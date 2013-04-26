/*  ==== OPERATING SYSTEM INTERFACE ====
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
 *  Provides interfaces to OS-specific modules to the rest of the runtime.
 *
 *  Revision Log
 *  ------------
 *  $Log: os.h,v $
 *  Revision 1.9  1998/09/16 15:05:52  jont
 *  [Bug #70174]
 *  Modify type of parse_command_line to fix compiler warnings
 *
 * Revision 1.8  1998/09/16  10:46:36  jont
 * [Bug #30108]
 * System specific stuff for command lines
 *
 * Revision 1.7  1998/08/17  11:29:16  jont
 * [Bug #70153]
 * Add system_validate_ml_address
 *
 * Revision 1.6  1997/03/24  15:03:25  nickb
 * Make malloc() and realloc() edge cases match the OS libraries.
 *
 * Revision 1.5  1996/08/27  14:59:52  nickb
 * Add os_on_exit().
 *
 * Revision 1.4  1996/05/10  08:46:16  matthew
 * Adding get/set rounding mode
 * /
 *
 * Revision 1.3  1995/04/24  12:55:59  nickb
 * Add update_windows();
 *
 * Revision 1.2  1994/06/09  14:40:37  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:08:17  nickh
 * new file
 *
 */

#ifndef os_h
#define os_h

#include <stdio.h>

/*  === INTIALISE ===
 *
 *  Initialises the OS modules and adds relevnt values to the environments.
 */

extern void os_init(void);

/* Synchronize a file. This is called between flushing and closing a
 * file to sync the timestamps. It may be an empty function on many
 * OS'es */

extern void os_filesync(FILE *f);

/* Update windows. This is called 'every so often' elsewhere in the OS
 * (e.g. in the GC). It allows OS-specific code to run which, for
 * instance, handles expose events (under X-Windows).
 */

extern void os_update_windows(void);

/* on exit: The argument function should be called on any normal exit.
 * Only one such function may be installed (i.e. os_on_exit() may only be
 * called once */

extern void os_on_exit(void (*)(void));

/* Modes are :
  0 : to nearest
  1 : to zero
  2 : to positive infinity
  3 : to negative infinity
*/

extern void os_set_rounding_mode (int mode);
extern int os_get_rounding_mode (void);


/* The behaviour of malloc(0), realloc(NULL,0) and realloc(p,0)
  depends on the OS, because we have to maintain compatibility with
  the OS libraries. See <URI:spring://MM_InfoSys/analysis/realloc> for
  more information. */

enum {
  OS_ALLOCATOR_MALLOC_ZERO,
  OS_ALLOCATOR_REALLOC_NULL_ZERO,
  OS_ALLOCATOR_REALLOC_P_ZERO
};

extern void *os_allocator(int code, void *arg);

/* A function for ml address validation outside of the heap */
/* This is important for when code may live in shared objects */

extern int system_validate_ml_address(void *addr);

/* A function to get and parse the command line the command line */

extern const char *const *parse_command_line(int *argc);

#endif
