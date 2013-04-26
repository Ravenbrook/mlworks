/*  ==== EXECUTABLE FILE DELIVERY AND EXECUTION ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This code deals with delivery executables rather than heap images.
 *  There are two halves to this. Firstly, writing such an object,
 *  and secondly, rerunning it
 *
 *  $Log: exec_delivery.c,v $
 *  Revision 1.7  1998/04/14 12:45:14  mitchell
 *  [Bug #50061]
 *  Reverse treatment of command-line argument passing for executables with embedded image
 *
 * Revision 1.6  1997/11/26  10:39:19  johnh
 * [Bug #30134]
 * Extra arg needed in save_executable (not used here though).
 *
 * Revision 1.5  1997/03/03  18:02:01  jont
 * [Bug #1839]
 * Ensure all PROGBITS sections are output at the correct size
 * Also section 2, the .reginfo section
 *
 * Revision 1.4  1996/05/01  08:52:29  nickb
 * Change to save_executable.
 *
 * Revision 1.3  1996/02/14  15:40:57  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.2  1995/10/03  15:47:26  jont
 * Add executable file saving and loading via Elf
 *
 * Revision 1.1  1995/09/26  15:15:58  jont
 * new unit
 *
 */

#include <libelf.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <setjmp.h>

#include "exec_delivery.h"
#include "gc.h"
#include "diagnostic.h"
#include "image.h"
#include "main.h"
#include "utils.h"

/* A type for an ml heap elf section */

#define	SHT_ML_HEAP (SHT_LOUSER | 0x1)

static jmp_buf problem;

static FILE *file_in = NULL,  /* The elf file we're going to read */
            *file_out = NULL; /* The one we're going to write */

static void fail(void)
{
  if (file_in != NULL) fclose(file_in);
  if (file_out != NULL) fclose(file_out);
  longjmp(problem, errno);
}

static void *my_malloc(size_t request)
{
  if (request == 0) {
    fprintf(stderr, "malloc request of zero bytes\n");
    fail();
    return NULL; /* Not reached, keep compiler happy */
  } else {
    void *foo = malloc(request);
    if (foo == NULL) {
      fprintf(stderr, "malloc failed in request for %u bytes\n", request);
      fail();
    }
    return foo;
  }
}

static void fix(char *from_file, char *to_file)
{
  Elf32_Ehdr ehdr;
  Elf32_Phdr *phdr = NULL;
  Elf32_Shdr * shdr = NULL;
  size_t phdr_bytes = 0, shdr_bytes = 0, data_in_size, data_out_size;
  void *data_in, *data_out; /* The file data */
  int strndx;

  file_in = fopen(from_file, "rb"); /* Open it for binary reading */
  if (file_in == NULL) {
    fprintf(stderr, "Failed to open '%s'\n", from_file);
    exit(1);
  }
/*
  printf("%s opened for reading\n", from_file);
*/
  if (fread(&ehdr, sizeof(ehdr), 1, file_in) != 1) {
    fprintf(stderr, "Failed to read elf header from '%s'\n", from_file);
    fail();
  }
  strndx = ehdr.e_shstrndx;
/*
  printf("Elf header read from %s\n", from_file);
*/
  if (ehdr.e_version != elf_version(EV_CURRENT)) {
    fprintf(stderr, "Elf header from '%s' has wrong version number '%ld'\n",
	    from_file, ehdr.e_version);
    fail();
  }
/*
  printf("Elf version checked in %s\n", from_file);
*/
  phdr_bytes = ehdr.e_phnum * ehdr.e_phentsize;
  phdr = my_malloc(phdr_bytes);
  if (fread(phdr, ehdr.e_phentsize, ehdr.e_phnum, file_in) != ehdr.e_phnum) {
    fprintf(stderr, "Failed to read program header from '%s'\n", from_file);
    fail();
  }
/*
  printf("Program header read from %s\n", from_file);
*/
  data_in_size = ehdr.e_shoff - ftell(file_in);
  data_in = my_malloc(data_in_size); /* Allocate space for the real data */
  if (fread(data_in, 1, data_in_size, file_in) != data_in_size) {
    fprintf(stderr, "Failed to read data area from '%s'\n", from_file);
    fail();
  }
/*
  printf("Elf data read from %s\n", from_file);
*/
  shdr_bytes = ehdr.e_shnum * ehdr.e_shentsize;
  if (ftell(file_in) != ehdr.e_shoff) {
    fprintf(stderr, "Failed to seek to section header area in '%s'\n", from_file);
    fail();
  }
/*
  printf("Section headers read from %s\n", from_file);
*/
  shdr = my_malloc(shdr_bytes);
  if (fread(shdr, ehdr.e_shentsize, ehdr.e_shnum, file_in) != ehdr.e_shnum) {
    fprintf(stderr, "Failed to read section headers from '%s'\n", from_file);
    fail();
  }
  {
    /* Check section headers */
  }
  data_out = data_in;
  data_out_size = data_in_size;
  /*
   * Now fix up elf's errors
   */
  /* Now sort out the position of the section header name table */
  /* and all other sections beyond it */
  {
    Elf32_Shdr *strshdr = shdr + strndx; /* This is the section we need to move */
    size_t header_size = sizeof(ehdr) + phdr_bytes;
    size_t old_size = strshdr->sh_offset - header_size; /* Where its data is */
    /* Align to 64k */
    size_t new_offset = (strshdr->sh_offset + 0xffff) & 0xffff0000;
    size_t increment = new_offset - strshdr->sh_offset;
    size_t new_size = new_offset - header_size;
    int i;
    data_out_size = new_size + data_in_size - old_size;
    data_out = malloc(data_out_size);
    /* Copy existing stuff before string table */
    memcpy(data_out, data_in, old_size);
    /* Pad with 0 */
    memset(((char *)data_out) + old_size, 0, new_size - old_size);
    /* Now copy the remaining data */
    memcpy(((char *)data_out) + new_size, ((char *)data_in) + old_size, data_in_size - old_size);
    /* Now fix up the header and section header */
    ehdr.e_shoff = data_out_size + header_size;
    for (i = strndx; i < ehdr.e_shnum; i++) {
      /* Bump up all pointers beyond the section header names table */
      shdr[i].sh_offset += increment;
    }
  }
  /*
   * Write the output file
   */
  fclose(file_in);
  file_in = NULL;
  file_out = fopen(to_file, "wb");
  if (file_out == NULL) {
    fprintf(stderr, "Failed to open '%s'\n", to_file);
    fail();
  }
  if (fwrite(&ehdr, sizeof(ehdr), 1, file_out) != 1) {
    fprintf(stderr, "Failed to write elf header to '%s'\n", to_file);
    fail();
  }
  if (fwrite(phdr, ehdr.e_phentsize, ehdr.e_phnum, file_out) != ehdr.e_phnum) {
    fprintf(stderr, "Failed to write program header to '%s'\n", to_file);
    fail();
  }
  if (fwrite(data_out, 1, data_out_size, file_out) != data_out_size) {
    fprintf(stderr, "Failed to write data area to '%s'\n", to_file);
    fail();
  }
  if (fwrite(shdr, ehdr.e_shentsize, ehdr.e_shnum, file_out) != ehdr.e_shnum) {
    fprintf(stderr, "Failed to write section headers to '%s'\n", to_file);
    fail();
  }
  fclose(file_out);
  file_out = NULL;
}

#define PRINT_PHDR 0
#if PRINT_PHDR
static void print_phdr(Elf32_Phdr *phdr)
{
  printf("phdr->p_type = 0x%x\n", phdr->p_type);
  printf("phdr->p_offset = 0x%x\n", phdr->p_offset);
  printf("phdr->p_vaddr = 0x%x\n", phdr->p_vaddr);
  printf("phdr->p_paddr = 0x%x\n", phdr->p_paddr);
  printf("phdr->p_filesz = 0x%x\n", phdr->p_filesz);
  printf("phdr->p_memsz = 0x%x\n", phdr->p_memsz);
  printf("phdr->p_flags = 0x%x\n", phdr->p_flags);
  printf("phdr->p_align = 0x%x\n", phdr->p_align);
}
#endif

static size_t align(size_t offs, size_t mask)
{
  size_t mask2 = 0xffffffff - mask;
  return (offs + mask2) & mask;
}

static size_t align2(size_t offs, size_t mask)
{
  if (mask == 0 || mask == 1) {
    return offs; /* No alignment here */
  } else {
    size_t mask2 = (size_t)(-(int)mask); /* Negate to get the real mask */
    return align(offs, mask2);
  }
}

static void copy_shdr(Elf32_Shdr *shdr_in, Elf32_Shdr *shdr_out)
{
  shdr_out->sh_name = shdr_in->sh_name; /* Index into string table */
  shdr_out->sh_type = shdr_in->sh_type; /* Same section type */
  shdr_out->sh_flags = shdr_in->sh_flags; /* Same section flags */
  shdr_out->sh_addr = shdr_in->sh_addr; /* Same section addr */
  shdr_out->sh_offset = shdr_in->sh_offset; /* Experiment */
  /* offset and size done by elf_update */
  shdr_out->sh_link = shdr_in->sh_link; /* Same section link */
  shdr_out->sh_info = shdr_in->sh_info; /* Same section info */
  shdr_out->sh_addralign = shdr_in->sh_addralign; /* Same section addralign */
  shdr_out->sh_entsize = shdr_in->sh_entsize; /* Same section entsize */
/*
  printf("Setting sh_entsize to %x\n", shdr_in->sh_entsize);
*/
}

static void copy_data(Elf_Data *data_in, Elf_Data *data_out)
{
  data_out->d_buf = data_in->d_buf;
  data_out->d_type = data_in->d_type;
  data_out->d_size = data_in->d_size;
  data_out->d_off = data_in->d_off;
  data_out->d_align = data_in->d_align;
  data_out->d_version = elf_version(EV_CURRENT);
}

static void free_string_buffer(void *buffer)
{
  if (buffer != NULL) {
    free(buffer);
  } else {
    DIAGNOSTIC(1, "string table write not done", 0, 0);
  }
}

#define ML_HEAP_SECTION "ML HEAP"

mlval save_executable(char *to, mlval heap, int console_app)
/* Save a re-executable version of the current system */
/* returns MLUNIT if ok, MLERROR on error of some sort (with errno set) */
/* Experimental debugging version for MIPS */
{
  int fd_in, fd_out;
  Elf *elf_in, *elf_out;
  Elf32_Ehdr *ehdr_in, *ehdr_out;
  Elf32_Phdr *phdr_in, *phdr_out;
  size_t count;
  Elf_Scn *scn_in, *scn_out;
  Elf32_Shdr *shdr_in, *shdr_out;
  Elf_Data *data_in, *data_out;
  void *string_table_buffer = NULL;
  int ml_heap_name = 0;

  if (setjmp(problem) != 0) {
    free_string_buffer(string_table_buffer);
    return MLERROR;
  }

  fd_in = open(runtime, O_RDONLY);
  if (fd_in < 0) {
    errno = EIMAGEOPEN;
    return MLERROR;
  }
  fd_out = open(to, O_RDWR | O_TRUNC | O_CREAT, 0770);
  if (fd_out < 0) {
    errno = EIMAGEOPEN;
    close(fd_in);
    return MLERROR;
  }
  /* Reset ELF error number */
  elf_errno();
  /* Check ELF version ... */
  if (elf_version(EV_CURRENT) == EV_NONE) {
    close(fd_in);
    close(fd_out);
    return MLERROR;
  };
  /*  Begin ELF processing of file - allocate ELF descriptor
   *  This also initially allocates internal memory used for ELF
   *  Also start for the output file
   */
  elf_in = elf_begin(fd_in, ELF_C_READ, (Elf *)NULL);
  elf_out = elf_begin(fd_out, ELF_C_WRITE, (Elf *)NULL);
  /* Now copy the entirity of the input executable to the output */
  /* except for any sections already containing ml heaps */
  ehdr_in = elf32_newehdr(elf_in);
  count = ehdr_in->e_phnum; /* How many headers */
  ehdr_out = elf32_newehdr(elf_out);
  memcpy(ehdr_out->e_ident, ehdr_in->e_ident, EI_NIDENT); /* Identify */
  ehdr_out->e_type = ehdr_in->e_type; /* File type as before */
  ehdr_out->e_machine = ehdr_in->e_machine; /* Machine as before */
  ehdr_out->e_version = elf_version(EV_CURRENT);
  ehdr_out->e_entry = ehdr_in->e_entry; /* Entry as before */
  ehdr_out->e_ehsize = sizeof(Elf32_Ehdr); /* size of the Elf header */
  /* phoff and shoff are calculated by elf_update */
  ehdr_out->e_flags = ehdr_in->e_flags; /* Flags as before */
  ehdr_out->e_phentsize = sizeof(Elf32_Phdr); /* size of the program header */
  ehdr_out->e_phnum = ehdr_in->e_phnum; /* Phnum as before */
  ehdr_out->e_shentsize = sizeof(Elf32_Shdr); /* size of the section header */
  DIAGNOSTIC(3, "Section table names in section %d", ehdr_in->e_shstrndx, 0);
  ehdr_out->e_shstrndx = ehdr_in->e_shstrndx; /* Shstrndx as before */
  /* Ehdr all done bar shoff, which requires a file offset to be calculated */
  phdr_in = elf32_getphdr(elf_in); /* The previous program header */
  phdr_out = elf32_newphdr(elf_out, count); /* A new program header */
  /* Copy the entire set of program headers over */
/*
  printf("Copying %d bytes of program headers\n", count * sizeof(Elf32_Phdr));
*/
  memcpy(phdr_out, phdr_in, count * sizeof(Elf32_Phdr));
  /* Copy all output sections */
  scn_in = (Elf_Scn *)NULL;
  while((scn_in = elf_nextscn(elf_in, scn_in)) != NULL) {
    /* Make sure we ignore existing ML heap sections, we don't want to copy them */
    shdr_in = elf32_getshdr(scn_in);
    data_in = elf_getdata(scn_in, (Elf_Data *)NULL);
    if (shdr_in->sh_type != SHT_ML_HEAP) {
      int ndx;
      scn_out = elf_newscn(elf_out);
      shdr_out = elf32_getshdr(scn_out);
      data_out = elf_newdata(scn_out);
      copy_shdr(shdr_in, shdr_out);
      copy_data(data_in, data_out);
      if (shdr_in->sh_type != SHT_NOBITS) {
	/* Don't try this on a section with no data */
	Elf_Scn *scn = elf_nextscn(elf_in, scn_in); /* Look at next section */
	if (scn != NULL) {
	  /* Don't try this on the last section! */
	  Elf32_Shdr *shdr = elf32_getshdr(scn);
	  Elf32_Word sh_type = shdr->sh_type;
	  if (sh_type != SHT_NOBITS) {
	    /* Won't work if following section has no data */
	    Elf_Data *data = elf_getdata(scn, (Elf_Data *)NULL); /* And assoc data */
	    size_t total = (char *)data->d_buf - (char *)data_in->d_buf;
	    size_t actual = align2(data_in->d_size, data_in->d_align);
	    ndx = elf_ndxscn(scn_in);
	    if (total > actual) {
/*
	      printf("Section %d, total data size 0x%x but actual aligned size 0x%x\n",
		     ndx, total, actual);
*/
	      if (ndx == 2 || sh_type == SHT_PROGBITS) {
/*
		printf("Increasing total for section %d\n", ndx);
*/
		data_out->d_size = total; /* Bump up totals for these two */
		shdr_out->sh_size = total;
	      }
	    }
	  }
	}
      }
      if ((ndx = elf_ndxscn(scn_in)) == ehdr_in->e_shstrndx) {
#if DO_ML_HEAP
	if (shdr_in->sh_type == SHT_STRTAB) {
	  /* Found the string table of section names */
	  size_t data_size = data_in->d_size;
	  size_t extra_data_size = strlen(ML_HEAP_SECTION) + 1;
	  size_t new_data_size = data_size + extra_data_size;
	  string_table_buffer = malloc(new_data_size);
	  memcpy(string_table_buffer, data_in->d_buf, data_size);
	  memcpy(((char *)string_table_buffer) + data_size, ML_HEAP_SECTION, extra_data_size);
	  data_out->d_size = new_data_size;
	  data_out->d_buf = string_table_buffer;
	  ml_heap_name = data_size;
	  ehdr_out->e_shstrndx = elf_ndxscn(scn_out); /* Index in the new file */
	} else {
	  error("Section shstrndx (%d) is not a string table\n", elf_ndxscn(scn_in));
	}
#endif
      } else {
	Elf_Data *data = data_in;
	/* There may be more than one data buffer. Can there be? */
/*
	printf("Checking for multiple data buffers in section %d\n", elf_ndxscn(scn_in));
*/
	while ((data = elf_getdata(scn_in, data)) != NULL) {
	  DIAGNOSTIC(1, "Found extra data buffer in section %d\n", ndx, 0);
	  data_out = elf_newdata(scn_out);
	  copy_data(data, data_out);
	};
      }
    } else {
      DIAGNOSTIC(1, "Ignoring existing ML HEAP section", 0, 0);
    }
  }
#define DO_ML_HEAP 1
#if DO_ML_HEAP
  /* Now build the ML heap section */
  scn_out = elf_newscn(elf_out);
  shdr_out = elf32_getshdr(scn_out);
  data_out = elf_newdata(scn_out);
  /* Set up the final header entry */
  shdr_out->sh_name = ml_heap_name; /* Name in string table */
  shdr_out->sh_type = SHT_ML_HEAP; /* ML heap section */
  shdr_out->sh_flags = 0; /* No special flags */
  shdr_out->sh_addr = 0; /* Not memory mapped */
  /* offset and size done by elf_update */
  shdr_out->sh_link = SHN_UNDEF; /* Same section link */
  shdr_out->sh_info = 0; /* No extra info */
  shdr_out->sh_addralign = 0; /* No alignment constraints */
  shdr_out->sh_entsize = 0; /* No fixed size entries */
  /* Set up the final data section */
  if (memory_image_save_size(heap, &data_out->d_size) == MLERROR) {
    /* Calculate required size */
    elf_end(elf_out);
    elf_end(elf_in);
    close(fd_in);
    close(fd_out);
    free_string_buffer(string_table_buffer);
    return MLERROR;
  };
  data_out->d_buf = malloc(data_out->d_size);
  data_out->d_type = ELF_T_BYTE;
  /*I think Elf fills in d_off */
  data_out->d_align = 0; /* No special alignment */
  data_out->d_version = elf_version(EV_CURRENT);
  if (memory_image_save(heap, data_out->d_buf, data_out->d_size, &data_out->d_size)) {
    elf_end(elf_out);
    elf_end(elf_in);
    free(data_out->d_buf);
    close(fd_in);
    close(fd_out);
    free_string_buffer(string_table_buffer);
    return MLERROR;
  };
#endif
  elf_update(elf_out, ELF_C_WRITE);
  elf_end(elf_out);
  elf_end(elf_in);
#if DO_ML_HEAP
  free(data_out->d_buf);
#endif
  close(fd_in);
  close(fd_out);
  free_string_buffer(string_table_buffer);
  /* Now fix up the fact that elf on Irix doesn't write executables properly */
  fix(to, to);
  return MLUNIT;
}

int load_heap_from_executable(mlval *heap, const char *runtime,
                              int just_check)
/* Reload the heap from within the executable, or just check if there is one */
/* This returns 0 if done (in which case we shouldn't try to load another heap) */
/* 1 if we failed to find such a section (in which case we continue as before) */
/* otherwise an error has occurred and errno is set */
{
  int fd;
  Elf *elf;
  Elf32_Ehdr *ehdr;
  Elf_Scn *scn;
  Elf32_Shdr *shdr;
  Elf_Data *data = NULL;
  void *heap_data = NULL;
  size_t heap_size = 0;

/*
  printf("Opening '%s'\n", runtime);
*/
  fd = open(runtime, O_RDONLY);
  if (fd < 0) {
    errno = EIMAGEOPEN;
    return 2;
  }
/*
  printf("Resetting elf error\n");
*/
  /* Reset ELF error number */
  elf_errno();
  /* Check ELF version ... */
/*
  printf("Checking elf version\n");
*/
  if (elf_version(EV_CURRENT) == EV_NONE) {
    close(fd);
    return 1;
  };
  /*  Begin ELF processing of file - allocate ELF descriptor
   *  This also initially allocates internal memory used for ELF
   */
/*
  printf("Calling elf_begin\n");
*/
  elf = elf_begin(fd, ELF_C_READ, (Elf *)NULL);
  /* Get ELF header */
  ehdr = elf32_getehdr(elf);
  scn = (Elf_Scn *)NULL;
  /* Find ml heap section. It has type SHT_ML_HEAP */ 
/*
  printf("Reading sections\n");
*/
  while((scn = elf_nextscn(elf,scn)) != NULL) {
    shdr = elf32_getshdr(scn);
    if (shdr->sh_type == SHT_ML_HEAP ) {
      data = elf_getdata(scn, (Elf_Data *)NULL);
      if (data->d_type != ELF_T_BYTE) {
	close(fd);
	elf_end(elf);
	DIAGNOSTIC(1, "Error, bad data type %d in ML heap section\n", data-> d_type, 0);
	errno = EIMAGEFORMAT;
	return 2;
      }
      break;
    }
  };
/*
  printf("Checking if a heap found\n");
*/
  if (data == NULL) {
    DIAGNOSTIC(1, "No ML heap section found", 0, 0);
    /* Failed to find an ML heap section */
    close(fd);
    elf_end(elf);
    return 1;
  }
/*
  printf("Returning ok\n");
*/

  DIAGNOSTIC(1, "Found ML heap with pointer %p and size %d", heap, heap_size);

  if (just_check) {
    close(fd);
    elf_end(elf);
  } else {    
    heap_data = data->d_buf;
    heap_size = data->d_size;
    *heap = memory_image_load(heap_data, heap_size);
    close(fd);
    elf_end(elf);
    if (*heap == MLERROR) {
      /* Something went wrong */
      DIAGNOSTIC(1, "load_heap_from_executable gets bad heap %p", *heap, 0);
      return 2;
    }
  }
  return 0;
}
