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
 *  Revision Log
 *  ------------
 *  $Log: os.c,v $
 *  Revision 1.11  1997/03/25 12:40:06  nickb
 *  Remove compilation warnings.
 *
 * Revision 1.10  1997/03/24  15:03:27  nickb
 * Make malloc() and realloc() edge cases match the OS libraries.
 *
 * Revision 1.9  1996/10/17  14:00:18  jont
 * Merging in license server stuff
 *
 * Revision 1.8.2.2  1996/10/15  14:42:12  jont
 * Fix problems with os_on_exit
 *
 * Revision 1.8.2.1  1996/10/07  16:11:49  hope
 * branched from 1.8
 *
 * Revision 1.8  1996/08/27  15:01:55  nickb
 * Add os_on_exit.
 *
 * Revision 1.7  1996/05/13  08:35:34  stephenb
 * Flesh out the IEEE rounding function stubs.
 *
 * Revision 1.6  1996/05/10  09:08:44  matthew
 * Adding get/set rounding mode functions
 *
 * Revision 1.5  1996/01/19  17:08:24  stephenb
 * OS reorganisation: The pervasive library no longer contains
 * OS specific stuff so there is no need to support NT on
 * UNIX platforms anymore.
 *
 * Revision 1.4  1995/04/24  12:55:52  nickb
 * Add update_windows().
 *
 * Revision 1.3  1994/12/09  15:47:51  jont
 * Add call to nt_init
 *
 * Revision 1.2  1994/06/09  14:28:33  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:52:56  nickh
 * new file
 *
 *
 */

#include <stdio.h>
#include <assert.h>
#include <sys/ieeefp.h>

#include "syscalls.h"

#include "utils.h"
#include "alloc.h"
#include "diagnostic.h"
#include "unix.h"
#include "x.h"

#include "os.h"

extern void os_init(void)
{
  unix_init();
  x_init();
}

static void (*os_exit_fn)(void) = NULL;


static void os_exit(int status, caddr_t arg)
{
  if (os_exit_fn != NULL)
    os_exit_fn();
}

extern void os_on_exit(void (*f)(void))
{
  os_exit_fn = f;
  on_exit(os_exit,0);
}



/* On Solbournes, need a call to fsync between flushing and closing,
otherwise the wrong modification time may be obtained subsequently */

extern void os_filesync(FILE *f)
{
  fsync(fileno(f));
}



/* this gets called 'every so often'. We use it to handle expose
 * events so windows which are brought to the top don't sit there
 * un-refreshed. */

extern void os_update_windows(void)
{
  x_handle_expose_events();
}



/* The following should be declared in sys/ieeefp.h but as with most SunOS
 * header files it is not.  This could go into ansi.h but since this is
 * the only place it should ever be used it might as well go here
 */
extern int ieee_flags(char const *, char const *, char const *, char **);



/* Modes are :
  0 : to nearest
  1 : to zero
  2 : to positive infinity
  3 : to negative infinity
*/


/* A mapping from the above modes to the strings that SunOS uses to
 * represent them.  The obviously must be in the same order as the 
 * above codes.
 */
static char const *
mlw_ieeefp_int_to_str[]={ "nearest", "tozero", "positive", "negative"};




int os_get_rounding_mode (void)
{
  char * out;
  int mode= ieee_flags("get", "direction", "",  &out);
  return mode;
}



/* Note that the result if the ieee_flags is ignored because the SML
 * routine that this implements (IEEEReal.setRoundingMode) doesn't expect
 * any failure.
 */
void os_set_rounding_mode(int mode)
{
  char * out;
  assert(mode >= 0 && mode <= 3);
  (void)ieee_flags("set", "direction", mlw_ieeefp_int_to_str[mode], &out);
}

/* The behaviour of malloc(0), realloc(NULL,0) and realloc(p,0)
 * depends on the OS, because we have to maintain compatibility with
 * the OS libraries See <URI:spring://MM_InfoSys/analysis/realloc> for
 * more information. */

extern void *os_allocator(int code, void *arg)
{
  switch (code) {
  case OS_ALLOCATOR_MALLOC_ZERO:
    DIAGNOSTIC(4,"malloc(0)",0,0);
    return malloc(1);
    break;
  case OS_ALLOCATOR_REALLOC_NULL_ZERO:
    DIAGNOSTIC(4,"realloc(NULL,0)",0,0);
    return NULL;
    break;
  case OS_ALLOCATOR_REALLOC_P_ZERO:
    DIAGNOSTIC(4,"realloc(0x%08x,0)",arg,0);
    free(arg);
    return arg;
    break;
  default:
    error("Unknown code in os_allocator");
  }
  return NULL;
}

