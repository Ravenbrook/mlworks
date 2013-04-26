/*  ==== EXECUTABLE FILE DELIVERY AND EXECUTION ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This code deals with delivery executables rather than heap images.
 *  There are two halves to this. Firstly, writing such an object,
 *  and secondly, rerunning it
 *  Win32 version.
 *
 *  $Log: exec_delivery.c,v $
 *  Revision 1.10  1998/08/28 16:10:40  mitchell
 *  [Bug #30484]
 *  Fix delivery for W95
 *
 * Revision 1.9  1998/05/19  08:45:50  mitchell
 * [Bug #30383]
 * Find new runtime relative to current one instead of using registry
 *
 * Revision 1.8  1998/04/14  12:48:50  mitchell
 * [Bug #50061]
 * Reverse treatment of command-line argument passing for executables with embedded image
 *
 * Revision 1.7  1998/04/03  14:26:02  johnh
 * [Bug #30383]
 * Initialised length of string passed to RegQueryValueEx.
 *
 * Revision 1.6  1997/11/26  11:44:40  johnh
 * [Bug #30134]
 * Change save_executable to save either console or window application.
 *
 * Revision 1.5  1997/04/08  14:18:44  jont
 * Minor diagnostic fix
 *
 * Revision 1.4  1997/02/26  18:23:08  jont
 * [Bug #1811]
 * Fix ERROR to be MLERROR
 *
 * Revision 1.3  1996/05/02  12:00:45  nickb
 * Cockup.
 *
 * Revision 1.2  1996/05/01  08:53:03  nickb
 * Change to save_executable.
 *
 * Revision 1.1  1996/02/12  11:58:40  stephenb
 * new unit
 * This used to be src/rts/src/OS/{NT,Win95}/win_exec_delivery.c
 *
 * Revision 1.2  1996/01/11  17:22:48  nickb
 * Runtime error message buffer problem.
 *
 * Revision 1.1  1995/11/28  13:28:38  jont
 * new unit
 *
 *
 */

#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <windows.h>

#include "gc.h"
#include "utils.h"
#include "exec_delivery.h"
#include "diagnostic.h"
#include "image.h"
#include "main.h"

#define SYMNMLEN 8

#define HEAP_NAME "ML_HEAP"

#define FILE_BUF_LENGTH 256 /* Buffer for expanded executable file names */

/* A COFF header */
typedef struct scnhdr
{
  char            s_name[SYMNMLEN];/* section name */
  long            s_paddr;    /* physical address */
  long            s_vaddr;    /* virtual address */
  long            s_size;     /* section size */
  long            s_scnptr;   /* file ptr to raw data */
  long            s_relptr;   /* file ptr to relocation */
  long            s_lnnoptr;  /* file ptr to line numbers */
  unsigned short  s_nreloc;   /* # reloc entries */
  unsigned short  s_nlnno;    /* # line number entries */
  long            s_flags;    /* flags */
} scnhdr;

long round_heap_size(long size)
{
  /* Round (towards +infinity) to the next 0x200 boundary */
  /* The linker etc seem to like 0x200 boundaries, dunno why */
  return (size + 0x1ff) & 0xfffffe00;
}

mlval save_executable(char *out_file, mlval heap, int console_app)
/* Save a re-executable version of the current system */
/* returns MLUNIT if ok, MLERROR on error of some sort (with errno set) */
{
  FILE *file_in, *file_out;
  int sec_names = 0, new_sec_names = 0;
  void *string_table_buffer = NULL;
  char *rest;
  int ml_heap_name = 0;
  IMAGE_DOS_HEADER dos_header;
  DWORD Signature;
  IMAGE_FILE_HEADER file_header;
  IMAGE_OPTIONAL_HEADER opt_header;
  WORD opt_header_size;
  size_t heap_size, rounded_heap_size;
  long nt_headers_offset, pos1, pos2, ml_heap_increment;
  unsigned long sections, heap_section, ml_heap_ptr, old_heap_size, s, rest_size;
  scnhdr *section = NULL;
  char new_runtime[FILE_BUF_LENGTH];
  DWORD new_length = FILE_BUF_LENGTH;

  if (console_app == APP_CURRENT) {
    new_length = GetModuleFileName(NULL, new_runtime, FILE_BUF_LENGTH-1);
  } else {
    char *tl; DWORD l;
    HANDLE handle;
    WIN32_FIND_DATA found;
    char full_path[FILE_BUF_LENGTH];

    GetModuleFileName(NULL, new_runtime, FILE_BUF_LENGTH-1);

    /* The filename is potentially in short form, so convert to long form */
    strcpy(full_path, new_runtime);
    handle = FindFirstFile(full_path, &found);
    FindClose(handle);
    *(strrchr(full_path, '\\') + 1) = '\0';
    sprintf(new_runtime, "%s%s", full_path, found.cFileName);

    /* Strip off .exe, -g and -windows suffixes */
    l = strlen(new_runtime);
    if (l > 4) { 
      tl = new_runtime + (l-4); 
      if (strcmp(tl, ".exe")     ==0) { *tl = 0; l -= 4; } }
    if (l > 2) {
      tl = new_runtime + (l-2); 
      if (strcmp(tl, "-g")       ==0) { *tl = 0; l -= 2; } }
    if (l > 8) {
      tl = new_runtime + (l-8); 
      if (strcmp(tl, "-windows") ==0) { *tl = 0; l -= 8; } }

    /* Add appropriate suffix */
    if (console_app == APP_CONSOLE) 
      strcat(new_runtime, ".exe");
    else
      strcat(new_runtime, "-windows.exe");
    new_length = strlen(new_runtime);
  }

  if (new_length == 0 || new_length == (FILE_BUF_LENGTH-1)) {
    DIAGNOSTIC(2, "Failed to get module file name %s", runtime, 0);
    errno = EIMAGEOPEN;
    return MLERROR;
  }
  DIAGNOSTIC(1, "saving heap to %s from runtime = %s", out_file, new_runtime);
  file_in = fopen(new_runtime, "rb");
  if (file_in == NULL) {
    errno = EIMAGEOPEN;
    return MLERROR;
  }
  file_out = fopen(out_file, "wb");
  if (file_out == NULL) {
    errno = EIMAGEOPEN;
    fclose(file_in);
    return MLERROR;
  }
  /* Now copy the entirity of the input executable to the output */
  /* Replace an ml heap with the new one */
  /* Expanding or contracting appropriately */
  /* First sort out the early part of the input */
  /* Up to the section table */

  if (fread(&dos_header, sizeof(dos_header), 1, file_in) != 1) {
    DIAGNOSTIC(2, "Failed to read dos file header from '%s'", new_runtime, 0);
    errno = EIMAGEREAD;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  nt_headers_offset = dos_header.e_lfanew;
  if (fseek(file_in, nt_headers_offset, SEEK_SET)) {
    DIAGNOSTIC(2, "Failed to seek to nt image headers in '%s'", new_runtime, 0);
    errno = EIMAGEREAD;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  if (fread(&Signature, sizeof(Signature), 1, file_in) != 1) {
    DIAGNOSTIC(2, "Failed to read nt image header Signature from '%s'", new_runtime, 0);
    errno = EIMAGEREAD;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  if (fread(&file_header, sizeof(file_header), 1, file_in) != 1) {
    DIAGNOSTIC(2, "Failed to read nt image header file_header from '%s'", new_runtime, 0);
    errno = EIMAGEREAD;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  opt_header_size = file_header.SizeOfOptionalHeader;
  if (fread(&opt_header, opt_header_size, 1, file_in) != 1) {
    DIAGNOSTIC(2, "Failed to read nt image header opt_header from '%s'", new_runtime, 0);
    errno = EIMAGEREAD;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  sections = file_header.NumberOfSections;
  DIAGNOSTIC(4, "%d sections found", sections, 0);
  DIAGNOSTIC(4, "allocating %d bytes for sections", sections*sizeof(*section), 0);
  section = malloc(sections * sizeof(*section));  
  if (section == NULL) {
    DIAGNOSTIC(2, "Malloc failed to allocate section header table", 0, 0);
    errno = EIMAGEALLOC;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  DIAGNOSTIC(4, "Sections begin at offset 0x%x", ftell(file_in), 0);
  if (fread(section, sizeof(*section), sections, file_in) != sections) {
    DIAGNOSTIC(2, "Failed to read section header from '%s'", new_runtime, 0);
    errno = EIMAGEREAD;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  /* Now copy everything from input to output, expanding ML HEAP section */
  if (fwrite(&dos_header, sizeof(dos_header), 1, file_out) != 1) {
    DIAGNOSTIC(2, "Failed to write dos file header to '%s'", out_file, 0);
    errno = EIMAGEWRITE;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  /* Now we need to pad */
  if (ftell(file_out) != nt_headers_offset) {
    while (ftell(file_out) != nt_headers_offset) {
      char a = '\000';
      if (fwrite(&a, 1, 1, file_out) != 1) {
	DIAGNOSTIC(2, "Failed to write dos file header padding to '%s'", out_file, 0);
	errno = EIMAGEWRITE;
	fclose(file_in);
	fclose(file_out);
	return MLERROR;
      }
    }
  }
  /* Now we're ready for the next bit, */
  /* the Signature, header and optional header */
  if (fwrite(&Signature, sizeof(Signature), 1, file_out) != 1) {
    DIAGNOSTIC(2, "Failed to write nt image header Signature to '%s'", out_file, 0);
    errno = EIMAGEWRITE;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  if (fwrite(&file_header, sizeof(file_header), 1, file_out) != 1) {
    DIAGNOSTIC(2, "Failed to write nt image header file_header to '%s'", out_file, 0);
    errno = EIMAGEWRITE;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  /* Now the optional bit */
  if (fwrite(&opt_header, opt_header_size, 1, file_out) != 1) {
    DIAGNOSTIC(2, "Failed to write nt image header opt_header to '%s'", out_file, 0);
    errno = EIMAGEWRITE;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  /* Now find the ML heap section */
  {
    for (heap_section = 0; heap_section < sections; heap_section++) {
      if (strcmp(section[heap_section].s_name, HEAP_NAME) == 0) {
	break;
      }
    }
    if (heap_section >= sections) {
      DIAGNOSTIC(2, "ML heap section missing from '%s'", new_runtime, 0);
      errno = EIMAGEREAD;
      fclose(file_in);
      fclose(file_out);
      return MLERROR;
    }
    ml_heap_ptr = section[heap_section].s_scnptr;
    old_heap_size = section[heap_section].s_size;
    DIAGNOSTIC(4, "ML heap found in section %d", heap_section, 0);
    DIAGNOSTIC(4, "starting at file offset 0x%x, of size 0x%x",
	       ml_heap_ptr, old_heap_size);
  }
  /* Now calculate new heap size */
  if (memory_image_save_size(heap, &heap_size) == MLERROR) {
    /* Calculate required size */
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  };
  rounded_heap_size = round_heap_size(heap_size);
  /* This might be negative. It is how much the following sections have to move */
  ml_heap_increment = rounded_heap_size - section[heap_section].s_size;
  DIAGNOSTIC(3, "New heap requires %d, which rounds to %d",
	  heap_size, rounded_heap_size);
  /* Now increment the section size for ML heap */
  /* Set new heap size */
  section[heap_section].s_size = rounded_heap_size;
  /* Now the section headers */
  for (s = heap_section+1; s < sections; s++) {
    section[s].s_scnptr += ml_heap_increment;
  }
  if (fwrite(section, sizeof(*section), sections, file_out) != sections) {
    DIAGNOSTIC(2, "Failed to write section header to '%s'", out_file, 0);
    errno = EIMAGEWRITE;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  /* Now the main data */
  /* First see how much there is */
  pos1 = ftell(file_in);
  if (fseek(file_in, 0, SEEK_END)) {
    DIAGNOSTIC(2, "Failed to seek to end of '%s'", new_runtime, 0);
    errno = EIMAGEREAD;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  pos2 = ftell(file_in);
  rest_size = pos2 - pos1;
  DIAGNOSTIC(4, "remaining file size = %d, from position %d beyond section headers",
	 rest_size, pos1);
  rest = malloc(rest_size);
  if (rest == NULL) {
    DIAGNOSTIC(2, "Malloc failed to allocate space (%d) for rest of file",
	       rest_size, 0);
    errno = EIMAGEALLOC;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  fseek(file_in, pos1, SEEK_SET);
  DIAGNOSTIC(4, "%s reset to %d", new_runtime, ftell(file_in));
  /* read sections */
  if (fread(rest, 1, rest_size, file_in) != rest_size) {
    DIAGNOSTIC(2, "Failed to read rest of file from '%s'", new_runtime, 0);
    errno = EIMAGEREAD;
    fclose(file_in);
    fclose(file_out);
    return MLERROR;
  }
  /* print all up to but not including ML_HEAP */
  {
    /* First write out sections before ML_HEAP */
    unsigned long pre_ml_size = ml_heap_ptr - pos1;
    if (fwrite(rest, 1, pre_ml_size, file_out) != pre_ml_size) {
      DIAGNOSTIC(2, "Failed to write early sections of rest of file to '%s'",
		 out_file, 0);
      errno = EIMAGEWRITE;
      fclose(file_in);
      fclose(file_out);
      return MLERROR;
    }
    /* Now write the new ML heap */
    if (image_save_with_open_file(file_out, heap, out_file)) {
      free(rest);
      fclose(file_in);
      fclose(file_out);
      message_start();
      message_string("image save to '");
      message_string(out_file);
      message_string("'failed, '");
      message_string(out_file);
      message_string("' removed");
      message_end();
      if (remove(out_file) != 0) {
	message_stderr("remove failed on '%s'", out_file);
      }
      return MLERROR;
    };
    /* Now pad with rounded_heap_size - heap_size bytes */
    if (rounded_heap_size - heap_size != 0) {
      long i = rounded_heap_size - heap_size;
      while (i-- > 0) {
	char a = '\000';
	if (fwrite(&a, 1, 1, file_out) != 1) {
	  DIAGNOSTIC(2, "Failed to ML heap padding to '%s'", out_file, 0);
	  errno = EIMAGEWRITE;
	  fclose(file_in);
	  fclose(file_out);
	  return MLERROR;
	}
      }
    }
    /* Now write out remaining sections */
    if (fwrite(rest + pre_ml_size + old_heap_size, 1,
	       rest_size - pre_ml_size - old_heap_size, file_out) !=
	rest_size - pre_ml_size - old_heap_size) {
      DIAGNOSTIC(2, "Failed to write remaining sections of rest of file to '%s'",
		 out_file, 0);
      errno = EIMAGEWRITE;
      fclose(file_in);
      fclose(file_out);
      return MLERROR;
    }
  }

  return MLUNIT;
}

int load_heap_from_executable(mlval *heap, const char *runtime, int just_check)
/* Reload the heap from within the executable, or just check if there is one */
/* This returns 0 if done (in which case we shouldn't try to load another heap) */
/* 1 if we failed to find such a section (in which case we continue as before) */
/* otherwise an error has occurred and errno is set */
{
  FILE *file;
  IMAGE_DOS_HEADER dos_header;
  DWORD Signature;
  IMAGE_FILE_HEADER file_header;
  IMAGE_OPTIONAL_HEADER opt_header;
  WORD opt_header_size;
  scnhdr *section = NULL;
  void *heap_data = NULL;
  long ml_heap_ptr;
  long nt_headers_offset;
  unsigned long sections, heap_section;
  size_t heap_size = 0;

  /* First sort out the proper name of the executable, */
  /* since NT isn't clever enough to give it to you */
  char new_runtime[FILE_BUF_LENGTH];
  DWORD new_length = GetModuleFileName(NULL, new_runtime, FILE_BUF_LENGTH-1);
  if (new_length == 0 || new_length == (FILE_BUF_LENGTH-1)) {
    DIAGNOSTIC(2, "Failed to get module file name %s", runtime, 0);
    errno = EIMAGEOPEN;
    return 2;
  }
  DIAGNOSTIC(2, "Entering load_heap_from_executable with runtime = %s", new_runtime, 0);
  file = fopen(new_runtime, "rb");
  if (file == NULL) {
    errno = EIMAGEOPEN;
    return 2;
  }
  DIAGNOSTIC(4, "Opened %s", new_runtime, 0);
  if (fread(&dos_header, sizeof(dos_header), 1, file) != 1) {
    DIAGNOSTIC(2, "Failed to read dos file header from '%s'", new_runtime, 0);
    errno = EIMAGEREAD;
    return 2;
  }
  DIAGNOSTIC(4, "Read DOS header from %s", new_runtime, 0);
  nt_headers_offset = dos_header.e_lfanew;
  if (fseek(file, nt_headers_offset, SEEK_SET)) {
    DIAGNOSTIC(2, "Failed to seek to nt image headers in '%s'", new_runtime, 0);
    errno = EIMAGEREAD;
    return 2;
  }
  DIAGNOSTIC(4, "Seeked to nt header in %s", new_runtime, 0);
  if (fread(&Signature, sizeof(Signature), 1, file) != 1) {
    DIAGNOSTIC(2, "Failed to read nt image header Signature from '%s'", new_runtime, 0);
    errno = EIMAGEREAD;
    return 2;
  }
  DIAGNOSTIC(4, "Read signature from %s", new_runtime, 0);
  if (fread(&file_header, sizeof(file_header), 1, file) != 1) {
    DIAGNOSTIC(2, "Failed to read nt image header file_header from '%s'", new_runtime, 0);
    errno = EIMAGEREAD;
    return 2;
  }
  opt_header_size = file_header.SizeOfOptionalHeader;
  if (fread(&opt_header, opt_header_size, 1, file) != 1) {
    DIAGNOSTIC(2, "Failed to read nt image header opt_header from '%s'", new_runtime, 0);
    errno = EIMAGEREAD;
    return 2;
  }
  sections = file_header.NumberOfSections;
  DIAGNOSTIC(4, "%d sections found", sections, 0);
  DIAGNOSTIC(4, "allocating %d bytes for sections", sections*sizeof(*section), 0);
  section = malloc(sections * sizeof(*section));  
  if (section == NULL) {
    DIAGNOSTIC(2, "Malloc failed to allocate section header table", 0, 0);
    errno = EIMAGEALLOC;
    return 2;
  }
  DIAGNOSTIC(4, "Sections begin at offset 0x%x", ftell(file), 0);
  if (fread(section, sizeof(*section), sections, file) != sections) {
    DIAGNOSTIC(2, "Failed to read section header from '%s'", new_runtime, 0);
    free(section);
    errno = EIMAGEREAD;
    return 2;
  }
  /* Now find the ML_HEAP section header */
  {
    for (heap_section = 0; heap_section < sections; heap_section++) {
      if (strcmp(section[heap_section].s_name, HEAP_NAME) == 0) {
	break;
      }
    }
    if (heap_section >= sections) {
      DIAGNOSTIC(2, "ML heap section missing from '%s'", new_runtime, 0);
      free(section);
      return 1; /* All ok, but no section found */
    }
    ml_heap_ptr = section[heap_section].s_scnptr;
    heap_size = section[heap_section].s_size;
  }
  free(section); /* Table not needed any more */
  /* Now check that this is a real heap, */
  /* not just the dummy one in all executables */
  if (fseek(file, ml_heap_ptr, SEEK_SET)) {
    DIAGNOSTIC(2, "Failed to seek to ML heap data in '%s'", new_runtime, 0);
    errno = EIMAGEREAD;
    return 2;
  }
  if (heap_size <= 0x200) {
    /* Not a real heap */
    DIAGNOSTIC(3, "Not a real heap, returning 1", 0, 0);
    return 1;
  }
  DIAGNOSTIC(1, "Found ML heap with pointer 0x%x and size 0x%x",
	     ml_heap_ptr, heap_size);
  
  if (just_check) {
    fclose(file);
  } else {    
    *heap = image_load_with_open_file(file, new_runtime);
    fclose(file);
    if (*heap == MLERROR) {
      /* Something went wrong */
      DIAGNOSTIC(1, "load_heap_from_executable gets bad heap %p", *heap, 0);
      return 2;
    }
  }
  return 0;
}

