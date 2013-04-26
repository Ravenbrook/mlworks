/*  ==== OPERATING SYSTEM INTERFACE ====
 *
 *  Copyright (C) 1994 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: os.c,v $
 *  Revision 1.11  1998/09/17 14:24:29  jont
 *  [Bug #30108]
 *  Move dummy definitions os asm_trampoline from unix.c into os.c
 *
 * Revision 1.10  1997/03/25  12:38:22  nickb
 * Remove compilation warnings.
 *
 * Revision 1.9  1997/03/24  15:03:34  nickb
 * Make malloc() and realloc() edge cases match the OS libraries.
 *
 * Revision 1.8  1996/08/27  15:29:10  nickb
 * Storage manager no longer has its own options.
 *
 * Revision 1.7  1996/05/14  12:29:03  stephenb
 * Add a prototype for swapRM since <sys/fpu.h> doesn't have one.
 *
 * Revision 1.6  1996/05/10  08:45:24  matthew
 * Adding FPU rounding mode control.
 *
 * Revision 1.5  1996/01/29  12:47:49  stephenb
 * Add <unistd.h>
 *
 * Revision 1.4  1996/01/19  17:12:08  stephenb
 * OS reorganisation: Since the pervasive library no longer
 * contains OS specific stuff, there is no need to include
 * NT stuff under UNIX.
 *
 * Revision 1.3  1995/04/24  14:09:00  nickb
 * Add os_update_windows().
 *
 * Revision 1.2  1994/12/09  16:21:41  jont
 * Add nt
 *
 * Revision 1.1  1994/07/12  12:44:34  jont
 * new file
 *
 * Revision 1.2  1994/06/09  14:28:33  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:52:56  nickh
 * new file
 *
 *
 */

#include <unistd.h>		/* fsync */
#include <sys/fpu.h>		/* get_fpc_csr */
#include <stdio.h>		/* fileno */
#include <assert.h>		/* assert */
#include <stdlib.h>		/* atexit */
#include "utils.h"
#include "diagnostic.h"
#include "unix.h"
#include "x.h"
#include "os.h"

extern void os_init(void)
{
  unix_init();
  x_init();
}

extern void os_on_exit(void (*f)(void))
{
  atexit(f);
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



/* FPC(3C) mentions swapRM but <sys/fpu.h> doesn't declare it.
 * So declare it here ...
 */
extern int swapRM(int);



/* Modes are :
  0 : to nearest
  1 : to zero
  2 : to positive infinity
  3 : to negative infinity
*/

int os_get_rounding_mode (void)
{
  return (get_fpc_csr () & 3);
}


void os_set_rounding_mode(int mode)
{
  assert(mode >= 0 && mode <= 3);
  (void)swapRM(mode);
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

extern mlval asm_trampoline(mlval x);

extern mlval asm_trampoline(mlval x)
{
  error("Unix version of asm_trampoline not yet implemented and shouldn't be called");
}
