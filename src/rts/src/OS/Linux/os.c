/*  ==== OPERATING SYSTEM INTERFACE ====
 *
 *  Copyright (C) 1994 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: os.c,v $
 *  Revision 1.12  1997/04/11 13:52:08  jont
 *  [Bug #1412]
 *  Implement os_set_rounding_mode
 *
 * Revision 1.11  1997/04/04  17:47:03  jont
 * [Bug #1905]
 * Include utils.h for definition of error
 *
 * Revision 1.10  1997/03/24  15:03:29  nickb
 * Make malloc() and realloc() edge cases match the OS libraries.
 *
 * Revision 1.9  1997/01/30  13:16:03  jont
 * Add x interface
 *
 * Revision 1.8  1996/08/27  16:07:04  nickb
 * Add os_on_exit.
 *
 * Revision 1.7  1996/05/10  09:10:37  matthew
 * Adding get/set rounding mode functions
 *
 * Revision 1.6  1996/01/19  17:13:21  stephenb
 * OS reorganisation: Since the pervasive library no longer
 * contains OS specific stuff, there is no need to include
 * NT stuff under UNIX.
 *
 * Revision 1.5  1995/08/04  10:54:50  nickb
 * Fix gcc warnings.
 *
 * Revision 1.4  1995/04/24  14:09:51  nickb
 * Add os_update_windows().
 *
 * Revision 1.3  1994/12/09  17:17:07  jont
 * Add call to nt_init
 *
 * Revision 1.2  1994/12/08  13:49:41  matthew
 * Nasty little hack for setting the fpu to not trap
 *
 * Revision 1.1  1994/10/04  16:27:57  jont
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

#include <stdio.h>
#include <fpu_control.h>
#include <stdlib.h>		/* atexit */
#include <assert.h>

#include "os.h"
#include "unix.h"
#include "x.h"
#include "syscalls.h"
#include "diagnostic.h"
#include "utils.h"

extern void os_init(void)
{
  unix_init();
  /* This should be done properly sometime */
  __setfpucw (0x037f);
  x_init();
}

extern void os_on_exit(void (*f)(void))
{
  atexit(f);
}

/* On Solbournes, need a call to fsync between flushing and closing,
otherwise the wrong modification time may be obtained subsequently. As
far as we know there is no such requirement for Linux. */

extern void os_filesync(FILE *f)
{
}

/* this gets called 'every so often'. We use it to handle expose
 * events so windows which are brought to the top don't sit there
 * un-refreshed. */

extern void os_update_windows(void)
{
/* if we ever add Motif for Linux, this has to go in here:
  x_handle_expose_events();
  */
}

/* Modes are :
  0 : to nearest
  1 : to zero
  2 : to positive infinity
  3 : to negative infinity
*/

static unsigned short modes[] =
  {_FPU_RC_NEAREST, _FPU_RC_ZERO, _FPU_RC_UP, _FPU_RC_DOWN};

#define _FPU_MASK _FPU_RC_ZERO

extern unsigned short get_fpu_control_word(void);

extern int os_get_rounding_mode (void)
{
  unsigned short control = get_fpu_control_word() & _FPU_MASK;
  switch(control) {
  case _FPU_RC_NEAREST:
    return 0;
  case _FPU_RC_ZERO:
    return 1;
  case _FPU_RC_UP:
    return 2;
  case _FPU_RC_DOWN:
    return 3;
  default:
    return 0; /* Shouldn't happen */
  }
  return (0);
}

extern void os_set_rounding_mode (int arg)
{
  unsigned short control, old;
  assert(arg >= 0 && arg <= 3);
  control = modes[arg];
  old = get_fpu_control_word();
  control |= (old & (~_FPU_MASK));
  __setfpucw(control);
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
    return arg;
    break;
  default:
    error("Unknown code in os_allocator");
  }
  return NULL;
}

