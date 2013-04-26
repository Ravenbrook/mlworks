/* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * An interface to exporting functions (win32 version).
 *
 * $Log: export.c,v $
 * Revision 1.9  1998/06/09 15:11:00  mitchell
 * [Bug #30419]
 * Move free edition check to rts!src:system.c
 *
 * Revision 1.8  1998/05/11  15:40:06  johnh
 * [Bug #30303]
 * Disabling image saving for student edition.
 *
 * Revision 1.7  1998/02/24  11:21:21  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.6  1997/11/26  15:43:36  johnh
 * [Bug #30134]
 * Change deliverFn to only save executeables and also differentiate between console and window apps.
 *
 * Revision 1.5  1997/10/10  16:14:20  johnh
 * [Bug #20084]
 * Add .exe extension if none is given (save_executable).
 *
 * Revision 1.4  1997/06/13  13:36:47  jkbrook
 * [Bug #50004]
 * Merging changes from 1.0r2c2 into 2.0m0
 *
 * Revision 1.3  1997/04/08  14:16:33  jont
 * Make sure save_executable doesn't fail silently
 *
 * Revision 1.2  1997/02/27  11:29:58  jont
 * [Bug #1811]
 * In deliverFn, use the third argument to determine
 * whether to deliver an executable or an image.
 * False => image, True => executable
 *
 * Revision 1.1  1996/02/20  10:19:28  stephenb
 * new unit
 * This used to be src/rts/src/OS/{NT,Win95}/win_export.c
 *
 * Revision 1.7  1996/02/19  15:14:02  nickb
 * Get rid of ad-hoc root clearing.
 *
 * Revision 1.6  1996/02/16  12:33:24  nickb
 * Change to global_pack().
 *
 * Revision 1.5  1996/02/14  16:07:59  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.4  1996/02/14  11:48:13  jont
 * Fixing some compiler warnings under VC++
 *
 * Revision 1.3  1996/02/09  13:57:50  jont
 * Improve error handling wheh exportFn fails
 *
 * Revision 1.2  1996/02/09  12:26:09  jont
 * Implement terminating exportFn
 *
 * Revision 1.1  1996/02/08  17:34:48  jont
 * new unit
 *
 *
 */

#include "diagnostic.h"
#include "gc.h"
#include "exceptions.h"
#include "main.h"
#include "global.h"
#include "allocator.h"
#include "image.h"
#include "export.h"
#include "ansi.h"
#include "exec_delivery.h"
#include "utils.h"
#include "license.h"
#include "mlw_mklic.h"

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

mlval deliverFn(mlval argument)
{
/*
 * We'd like to use fork here, but Win32 doesn't provide anything remotely like it.
 * So this is a single shot implementation.
 * Caveat emptor
 */
  mlval global;
  mlval filename = FIELD(argument, 0);
  /* This ml arg must match datatype definition in pervasive library */
  mlval console_app = CINT(FIELD(argument, 2));
  char* c_filename = CSTRING(filename);
  FILE* test_file;
  int i, ext_exists=0, consoleApp;
  char* c_filename_exe = (char*) malloc(strlen(c_filename) + 4);

  if (c_filename_exe == NULL)
    error("Unable to malloc.  Out of memory.");

  for(i=0; i < (int) strlen(c_filename); i++)
    if (c_filename[i] == '.') 
      ext_exists = 1;

  strcpy(c_filename_exe, c_filename);

  if (ext_exists == 0)
    strcat(c_filename_exe, ".exe");

  /* Check that we can write the file before going any further, because
   * once we're past this stage on Windows, the process is doomed to die.
   */
  test_file = fopen(c_filename_exe, "wb");
  if (test_file == NULL) {
    exn_raise_string(perv_exn_ref_save, "Unable to open file for delivery");
  } else {
    fclose(test_file);
  }

  image_continuation = FIELD(argument, 1); /* This is a global, and hence a root */
  declare_root(&filename, 1);
    
  global = global_pack(1);	/* 1 = delivery rather than image save */
  declare_root(&global, 1);
    
  gc_clean_image(global);

  consoleApp = (console_app == 0) ? APP_CONSOLE : APP_WINDOWS;

  if (save_executable(c_filename_exe, global, consoleApp) == MLERROR) {
    DIAGNOSTIC(1,"save_executable failed, exiting with errno %d",errno,0);
    switch (errno) {
    case EIMPL:
      error("Function save not implemented");
    case EIMAGEWRITE:
      error("Error writing opened image file");
    case EIMAGEOPEN:
      error("Unable to open image file");
    default:
      break;
    }
    if (errno) error(strerror(errno));
    error("deliver failed with unknown error");
    exit(-1); /* NOT REACHED */
  } else {
    DIAGNOSTIC(1,"save_executable succeeded, exiting with errno %d",errno,0);
  }

  exit(0);
  /*** NOT REACHED ***/
  return MLUNIT;
}

