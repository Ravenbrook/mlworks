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
 *  Revision 1.12  1997/03/24 15:03:36  nickb
 *  Make malloc() and realloc() edge cases match the OS libraries.
 *
 * Revision 1.11  1997/03/19  16:56:26  daveb
 * [Bug #1941]
 * Made the error message understandable for when the OS doesn't have the
 * necessary patch to run MLWorks on the UltraSPARC.
 *
 * Revision 1.10  1996/10/14  14:13:08  nickb
 * Add check_windows().
 *
 * Revision 1.9  1996/08/27  15:35:19  nickb
 * Add os_on_exit.
 *
 * Revision 1.8  1996/05/13  10:18:03  stephenb
 * Flesh out the rounding mode routines.
 *
 * Revision 1.7  1996/05/10  09:09:09  matthew
 * Adding get/set rounding mode functions
 *
 * Revision 1.6  1996/01/17  15:20:37  stephenb
 * OS reorganisation: remove any reference to NT.
 *
 * Revision 1.5  1995/04/24  14:08:31  nickb
 * Add os_update_windows().
 *
 * Revision 1.4  1995/02/24  09:41:36  nickb
 * Add include for pioc.h
 *
 * Revision 1.3  1995/02/23  14:36:07  nickb
 * Add pioc_init().
 *
 * Revision 1.2  1994/12/12  11:05:00  jont
 * Add call to nt_init
 *
 * Revision 1.1  1994/07/08  10:44:13  nickh
 * new file
 *
 *
 */

#include <assert.h>
#include <ieeefp.h>		/* fp{get,set}round */
#include <stdlib.h>
#include "os.h"
#include "unix.h"
#include "x.h"
#include "pioc.h"
#include "check_windows.h"
#include "types.h"
#include "diagnostic.h"
#include "utils.h"

extern void os_init(void)
{
  word x = check_windows();
  if (x)
    error ("This computer requires a Sun kernel "
	   "patch before this application will run.\n"
           "Please contact the application's vendor "
	   "for details of the patch required.");
  pioc_init();
  unix_init();
  x_init();
}

extern void os_on_exit(void (*f)(void))
{
  atexit(f);
}


/* Don't know whether a call to fsync is necessary under Solaris; it
is on Solbourne machines. */

void os_filesync(FILE *f)
{
/* Do nothing; on SunOS we do fsync(fileno(f)) here. */
}



/* this gets called 'every so often'. We use it to handle expose
 * events so windows which are brought to the top don't sit there
 * un-refreshed. */

void os_update_windows(void)
{
  x_handle_expose_events();
}




/* Support for IEEEReal.{set,get}RoundingMode 
 *
 * os_{get,set}_rounding_mode are expected to return/take modes with the
 * following meanings :-
 *
 *  0 : to nearest
 *  1 : to zero
 *  2 : to positive infinity
 *  3 : to negative infinity
 *
 * The assertions in the following are there to make sure that the system
 * values are the same as the above.  If you ever get an assertion error
 * when running a test for these routines, then alter both of the following
 * to use some sort of mapping between the FP_R{N,Z,P,M} codes and the
 * required values.
 */


int os_get_rounding_mode(void)
{
  assert(FP_RN == 0);
  assert(FP_RZ == 1);
  assert(FP_RP == 2);
  assert(FP_RM == 3);
  return fpgetround();
}



void os_set_rounding_mode(int mode)
{
  assert(mode >= 0 && mode <= 3);
  assert(FP_RN == 0);
  assert(FP_RZ == 1);
  assert(FP_RP == 2);
  assert(FP_RM == 3);
  (void)fpsetround(mode);
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
    return malloc(1);
    break;
  case OS_ALLOCATOR_REALLOC_P_ZERO:
    DIAGNOSTIC(4,"realloc(0x%08x,0)",arg,0);
    free(arg);
    return malloc(1);
    break;
  default:
    error("Unknown code in os_allocator");
  }
  return NULL;
}

