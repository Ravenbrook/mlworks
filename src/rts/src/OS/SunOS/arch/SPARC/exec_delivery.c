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
 *  Revision 1.9  1998/04/14 12:48:00  mitchell
 *  [Bug #50061]
 *  Reverse treatment of command-line argument passing for executables with embedded image
 *
 * Revision 1.8  1997/11/26  10:40:58  johnh
 * [Bug #30134]
 * Extra arg needed in save_executable (not used here though).
 *
 * Revision 1.7  1996/08/05  13:24:11  jont
 * [Bug #1528]
 * Fixing problems when open fails delivering executables
 *
 * Revision 1.6  1996/07/30  15:58:03  jont
 * Change permission on new executable saves to be owner read-write
 *
 * Revision 1.5  1996/05/01  08:53:05  nickb
 * Change to save_executable.
 *
 * Revision 1.4  1996/02/14  16:06:36  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.3  1996/01/11  17:25:48  nickb
 * Runtime error message buffer problem.
 *
 * Revision 1.2  1995/11/29  16:02:41  jont
 * Provide a real implementation of loading and saving executables
 * by saving the heap on the end
 *
 * Revision 1.1  1995/09/26  15:17:59  jont
 * new unit
 *
 */

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <a.out.h>
#include <unistd.h>

#include "ansi.h"
#include "gc.h"
#include "utils.h"
#include "exec_delivery.h"
#include "diagnostic.h"
#include "image.h"
#include "main.h"
/* No contents yet */

static long round_up_to_8k(long size)
{
  return (size + 0x1fff) & 0xffffe000;
}

mlval save_executable(char *to, mlval heap, int console_app)
/* Save a re-executable version of the current system */
/* returns MLUNIT if ok, MLERROR on error of some sort (with errno set) */
{
  FILE *in_file, *out_file;
  struct exec exec;
  long stroff, size_of_file, heap_start, string_table_size;
  void *exec_part;

/* First find the right point in the executable, */
/* which may already have a heap in it */
  in_file = fopen(runtime, "rb");
  if (in_file == NULL) {
    DIAGNOSTIC(2, "Failed to open %s for reading", runtime, 0);
    errno = EIMAGEOPEN;
    return MLERROR;
  }
  if (fread(&exec, sizeof(struct exec), 1, in_file) != 1) {
    DIAGNOSTIC(2, "Failed to read exec header from %s", runtime, 0);
    fclose(in_file);
    errno = EIMAGEREAD;
    return MLERROR;
  }

  if (exec.a_magic != ZMAGIC) {
    DIAGNOSTIC(2, "Not an MLWorks executable: bad magic number 0x%04x",
	       exec.a_magic, 0);
    fclose(in_file);
    errno = EIMAGEREAD;
    return MLERROR;
  }
  else if (exec.a_machtype != M_SPARC) {
    DIAGNOSTIC(2, "Not an MLWorks executable: bad machine type 0x%02x",
	       exec.a_machtype, 0);
    fclose(in_file);
    errno = EIMAGEREAD;
    return MLERROR;
  }

  stroff = N_STROFF(exec);
  /* Now determine file size */
  if (fseek(in_file, 0, SEEK_END)) {
    DIAGNOSTIC(2, "Failed to seek to end of file %s", runtime, 0);
    fclose(in_file);
    errno = EIMAGEREAD;
    return MLERROR;
  }
  size_of_file = ftell(in_file);

  if (exec.a_syms == 0) { /* stripped executable */
    heap_start = stroff;
  } else {
    if (fseek(in_file, stroff, SEEK_SET)) {
      DIAGNOSTIC(2, "Failed to seek to start of string table (%d) in file %s",
		 stroff, runtime);
      fclose(in_file);
      errno = EIMAGEREAD;
      return MLERROR;
    }
    if (fread(&string_table_size, sizeof(string_table_size), 1, in_file) != 1) {
      DIAGNOSTIC(2, "Failed to read string table size from %s", runtime, 0);
      fclose(in_file);
      errno = EIMAGEREAD;
      return MLERROR;
    }
    heap_start = round_up_to_8k(stroff+string_table_size);
  }
  /* Now copy entire file up to heap_start */
  if (fseek(in_file, 0, SEEK_SET)) {
    DIAGNOSTIC(2, "Failed to seek to start of heap (%d) in file %s",
	       heap_start, runtime);
    fclose(in_file);
    errno = EIMAGEREAD;
    return MLERROR;
  }
  exec_part = malloc((unsigned long)heap_start);
  if (exec_part == NULL) {
    DIAGNOSTIC(2, "Failed to allocate memory (%d bytes) for executable part of file %s",
	       heap_start, runtime);
    fclose(in_file);
    errno = EIMAGEALLOC;
    return MLERROR;
  }
  if (fread(exec_part, 1, (unsigned long)heap_start, in_file) !=
      heap_start) {
    DIAGNOSTIC(2, "Failed to read executable part of file %s",
	       runtime, 0);
    fclose(in_file);
    free(exec_part);
    errno = EIMAGEREAD;
    return MLERROR;
  }
  out_file = fopen(to, "wb");
  if (out_file == NULL) {
    DIAGNOSTIC(2, "Failed to open %s for saving executable",
	       to, 0);
    fclose(in_file);
    free(exec_part);
    errno = EIMAGEOPEN;
    return MLERROR;
  }
  fclose(in_file); /* Don't need this any more */
  /* Now write the executable part */
  if (fwrite(exec_part, 1, (unsigned long)heap_start, out_file) !=
      heap_start) {
    DIAGNOSTIC(2, "Failed to write executable part to file %s",
	       to, 0);
    fclose(out_file);
    free(exec_part);
    errno = EIMAGEWRITE;
    return MLERROR;
  }
  free(exec_part);
  /* Now save the new heap */
  if (image_save_with_open_file(out_file, heap, to)) {
    fclose(out_file);
    message_start();
    message_string("image save to '");
    message_string(to);
    message_string("' failed, '");
    message_string(to);
    message_string("' removed");
    message_end();
    if (remove(to) != 0) {
      message_stderr("remove failed on '%s'", to);
    }
    return MLERROR;
  };
  /* Now pad up to an 8k boundary */
  {
    long size = ftell(out_file);
    long round_size = round_up_to_8k(size);
    while (size < round_size) {
      char a = '\000';
      if (fwrite(&a, 1, 1, out_file) != 1) {
	DIAGNOSTIC(2, "Failed to pad heap out to 8k boundary", 0, 0);
	fclose(out_file);
	errno = EIMAGEWRITE;
	return MLERROR;
      }
      size++;
    }
  }
  fclose(out_file);
  /* Now make sure it's executable */
  (void)chmod(to, 0750);
  /* Now return success */
  return MLUNIT;
}

int load_heap_from_executable(mlval *heap, const char *runtime, int just_check)
/* Reload the heap from within the executable, or just check if there is one */
/* This returns 0 if done (in which case we shouldn't try to load another heap) */
/* 1 if we failed to find a heap (in which case we continue as before) */
/* otherwise an error has occurred and errno is set */
{
  FILE *in_file;
  struct exec exec;
  long stroff, size_of_file, heap_start, string_table_size;
  
  in_file = fopen(runtime, "rb");
  if (in_file == NULL) {
    DIAGNOSTIC(2, "Failed to open %s for reading heap", runtime, 0);
    errno = EIMAGEOPEN;
    return 2;
  }
  if (fread(&exec, sizeof(struct exec), 1, in_file) != 1) {
    DIAGNOSTIC(2, "Failed to read exec header from %s", runtime, 0);
    fclose(in_file);
    errno = EIMAGEREAD;
    return 2;
  }

  if (exec.a_magic != ZMAGIC) {
    DIAGNOSTIC(2, "Not an MLWorks executable: bad magic number 0x%04x",
	       exec.a_magic, 0);
    fclose(in_file);
    errno = EIMAGEREAD;
    return 2;
  }
  else if (exec.a_machtype != M_SPARC) {
    DIAGNOSTIC(2, "Not an MLWorks executable: bad machine type 0x%02x",
	       exec.a_machtype, 0);
    fclose(in_file);
    errno = EIMAGEREAD;
    return 2;
  }

  stroff = N_STROFF(exec);
  /* Now determine file size */
  if (fseek(in_file, 0, SEEK_END)) {
    DIAGNOSTIC(2, "Failed to seek to end of file %s", runtime, 0);
    fclose(in_file);
    errno = EIMAGEREAD;
    return 2;
  }
  size_of_file = ftell(in_file);

  if (exec.a_syms == 0) { /* stripped executable */
    if (stroff == size_of_file)	/* no heap */
      return 1;
    else heap_start = stroff;
  } else {
    if (fseek(in_file, stroff, SEEK_SET)) {
      DIAGNOSTIC(2, "Failed to seek to start of string table (%d) in file %s",
		 stroff, runtime);
      fclose(in_file);
      errno = EIMAGEREAD;
      return 2;
    }
    if (fread(&string_table_size, sizeof(string_table_size), 1, in_file) != 1) {
      DIAGNOSTIC(2, "Failed to read string table size from %s", runtime, 0);
      fclose(in_file);
      errno = EIMAGEREAD;
      return 2;
    }
    heap_start = round_up_to_8k(stroff+string_table_size);
    DIAGNOSTIC(4, "string table offset = %d, string table size = %d",
	       stroff, string_table_size);
    DIAGNOSTIC(4, "rounded size = %d, size of file = %d",
	       heap_start, size_of_file);
    /* Now see if this is the end of the file */
    if (heap_start == size_of_file)
      return 1;
  }
  if (fseek(in_file, heap_start, SEEK_SET)) {
    DIAGNOSTIC(2, "Failed to seek to start of heap (%d) in file %s",
	       heap_start, runtime);
    fclose(in_file);
    errno = EIMAGEREAD;
    return 2;
  }

  if (just_check) {
    fclose(in_file);
  } else {    
    *heap = image_load_with_open_file(in_file, runtime);
    fclose(in_file);
    if (*heap == MLERROR) {
      /* Something went wrong */
      DIAGNOSTIC(1, "load_heap_from_executable gets bad heap %p", *heap, 0);
      return 2;
    }
  }
  return 0;
}
