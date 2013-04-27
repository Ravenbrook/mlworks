/*  ==== EXECUTABLE FILE DELIVERY AND EXECUTION ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  This code deals with delivery executables rather than heap images.
 *  There are two halves to this. Firstly, writing such an object,
 *  and secondly, rerunning it
 *
 *  $Log: exec_delivery.c,v $
 *  Revision 1.10  1999/03/17 12:16:03  mitchell
 *  [Bug #190531]
 *  Include elf.h
 *
 * Revision 1.9  1998/09/30  14:00:31  jont
 * [Bug #70108]
 * Acquire libelf.h from libelf/libelf.h
 *
 * Revision 1.8  1998/04/14  12:46:19  mitchell
 * [Bug #50061]
 * Reverse treatment of command-line argument passing for executables with embedded image
 *
 * Revision 1.7  1997/11/26  10:40:31  johnh
 * [Bug #30134]
 * Extra arg needed in save_executable.
 *
 * Revision 1.6  1997/01/30  13:16:58  jont
 * [Bug #1034]
 * Implement executable delivery
 *
 * Revision 1.5  1996/08/27  16:29:27  nickb
 * Add unimplemented load_heap_from_executable.
 *
 * Revision 1.4  1996/05/01  08:52:27  nickb
 * Change to save_executable.
 *
 * Revision 1.3  1996/02/14  15:39:37  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.2  1996/01/16  13:55:59  nickb
 * Add include.
 *
 * Revision 1.1  1995/09/26  15:16:22  jont
 * new unit
 *
 */

#include <elf.h>
#include <libelf/libelf.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>

#include "exec_delivery.h"
#include "gc.h"
#include "diagnostic.h"
#include "image.h"
#include "main.h"
#include "utils.h"

/* A type for an ml heap elf section */

#define	SHT_ML_HEAP (SHT_LOUSER | 0x1)

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

static void copy_shdr(Elf32_Shdr *shdr_in, Elf32_Shdr *shdr_out)
{
  shdr_out->sh_name = shdr_in->sh_name; /* Index into string table */
  shdr_out->sh_type = shdr_in->sh_type; /* Same section type */
  shdr_out->sh_flags = shdr_in->sh_flags; /* Same section flags */
  shdr_out->sh_addr = shdr_in->sh_addr; /* Same section addr */
  /* offset and size done by elf_update */
  shdr_out->sh_link = shdr_in->sh_link; /* Same section link */
  shdr_out->sh_info = shdr_in->sh_info; /* Same section info */
  shdr_out->sh_addralign = shdr_in->sh_addralign; /* Same section addralign */
  shdr_out->sh_entsize = shdr_in->sh_entsize; /* Same section entsize */
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
{
  int fd_in, fd_out;
  Elf *elf_in, *elf_out;
  Elf32_Ehdr *ehdr_in, *ehdr_out;
  Elf32_Phdr *phdr_in, *phdr_out;
  size_t count;
  Elf_Scn *scn_in, *scn_out;
  Elf32_Shdr *shdr_in, *shdr_out;
  Elf_Data *data_in, *data_out;
  int sec_names = 0, new_sec_names = 0;
  void *string_table_buffer = NULL;
  int ml_heap_name = 0;

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
  /* First find out how many sections in the input */
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
  memcpy(phdr_out, phdr_in, count * sizeof(Elf32_Phdr));
  /* Copy all output sections */
  scn_in = (Elf_Scn *)NULL;
  while((scn_in = elf_nextscn(elf_in, scn_in)) != NULL) {
    /* Make sure we ignore existing ML heap sections, we don't want to copy them */
    sec_names++;
    shdr_in = elf32_getshdr(scn_in);
    data_in = elf_getdata(scn_in, (Elf_Data *)NULL);
    if (shdr_in->sh_type != SHT_ML_HEAP) {
      new_sec_names++;
      scn_out = elf_newscn(elf_out);
      shdr_out = elf32_getshdr(scn_out);
      data_out = elf_newdata(scn_out);
      copy_shdr(shdr_in, shdr_out);
      copy_data(data_in, data_out);
      if (sec_names == ehdr_in->e_shstrndx) {
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
	  ehdr_out->e_shstrndx = new_sec_names; /* Index in the new file */
	} else {
	  error("Section shstrndx (%d) is not a string table\n", sec_names);
	}
      }
    } else {
      DIAGNOSTIC(1, "Ignoring existing ML HEAP section", 0, 0);
    }
  }
  /* Now build the ML heap section */
  scn_out = elf_newscn(elf_out);
  shdr_out = elf32_getshdr(scn_out);
  data_out = elf_newdata(scn_out);
  /* Set up the final header entry */
  shdr_out->sh_name = ml_heap_name; /* Name in string table */
  shdr_out->sh_type = SHT_ML_HEAP; /* ML heap section */
  shdr_out->sh_flags = 0; /* No special,flags */
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
  elf_update(elf_out, ELF_C_WRITE);
  elf_end(elf_out);
  elf_end(elf_in);
  free(data_out->d_buf);
  close(fd_in);
  close(fd_out);
  free_string_buffer(string_table_buffer);
  return MLUNIT;
}

int load_heap_from_executable(mlval *heap, const char *runtime, int just_check)
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

  fd = open(runtime, O_RDONLY);
  if (fd < 0) {
    errno = EIMAGEOPEN;
    return 2;
  }
  /* Reset ELF error number */
  elf_errno();
  /* Check ELF version ... */
  if (elf_version(EV_CURRENT) == EV_NONE) {
    close(fd);
    return 1;
  };
  /*  Begin ELF processing of file - allocate ELF descriptor
   *  This also initially allocates internal memory used for ELF
   */
  elf = elf_begin(fd, ELF_C_READ, (Elf *)NULL);
  /* Get ELF header ... */
  ehdr = elf32_getehdr(elf);
  scn = (Elf_Scn *)NULL;
  /* Find ml heap section. It has type SHT_ML_HEAP */ 
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
  if (data == NULL) {
    DIAGNOSTIC(1, "No ML heap section found", 0, 0);
    /* Failed to find an ML heap section */
    close(fd);
    elf_end(elf);
    return 1;
  }
  heap_data = data->d_buf;
  heap_size = data->d_size;
  DIAGNOSTIC(1, "Found ML heap with pointer %p and size %d", heap, heap_size);

  if (just_check) {
    close(fd);
    elf_end(elf);
  } else {    
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





