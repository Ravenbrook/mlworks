/*  ==== OPERATING SYSTEM INTERFACE ====
 *
 *  Copyright (C) 1994 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: os.c,v $
 *  Revision 1.10  1997/03/25 12:41:37  nickb
 *  Fix compilation problem.
 *
 * Revision 1.9  1997/03/24  15:03:30  nickb
 * Make malloc() and realloc() edge cases match the OS libraries.
 *
 * Revision 1.8  1996/10/30  14:47:42  johnh
 * Add interrupt functionality on Windows.
 *
 * Revision 1.7  1996/08/27  16:22:02  nickb
 * Add os_on_exit.
 *
 * Revision 1.6  1996/06/18  14:35:28  stephenb
 * Fix #1390 - rounding mode controls not working.
 *
 * Revision 1.5  1996/05/30  10:14:36  stephenb
 * os_init: add call to mlw_timer_init.
 *
 * Revision 1.4  1996/05/13  12:01:44  stephenb
 * Flesh out the rounding mode routines.
 *
 * Revision 1.3  1996/05/10  09:10:52  matthew
 * Adding get/set rounding mode functions
 *
 * Revision 1.2  1996/05/07  12:42:05  stephenb
 * Add support for basis Time structure.
 *
 * Revision 1.1  1996/03/06  11:23:04  stephenb
 * new unit
 * This replaces src/rts/src/OS/{NT,Win95}/os.c
 *
 * Revision 1.6  1996/01/22  15:43:24  stephenb
 * change nt_init to win32_init.
 *
 * Revision 1.5  1996/01/18  14:26:22  stephenb
 * OS reorganisation: remove any reference to UNIX since this
 * is no longer in the pervasive library.
 *
 * Revision 1.4  1995/08/02  15:20:27  jont
 * Remove dependence on winmain.h
 *
 * Revision 1.3  1995/04/24  14:10:45  nickb
 * Add os_update_windows().
 *
 * Revision 1.2  1995/03/01  16:41:00  jont
 * Add winmain initialisation
 *
 * Revision 1.1  1994/12/12  14:27:06  jont
 * new file
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

#include <assert.h>		/* assert */
#include <float.h>		/* _controlfp */
#include <stdlib.h>		/* atexit */

#include "utils.h"
#include "diagnostic.h"
#include "win32.h"		/* win32_init */
#include "dde_lib.h"		/* dde_init */
#include "time_date_init.h"	/* mlw_time_date_init */
#include "mlw_timer_init.h"	/* mlw_timer_init */
#include "os_io_poll.h"		/* mlw_os_io_poll_init */
#include "alloc.h"

#include "os.h"

extern void winmain_init(void);	/* should be in window.h or an equivalent */
extern void mlw_expose_windows(void);

extern void os_init(void)
{
  dde_init();
  mlw_os_io_poll_init();
  mlw_time_date_init();
  mlw_timer_init();
  win32_init();
  winmain_init();
}

extern void os_on_exit(void (*f)(void))
{
  atexit(f);
}

/* On Solbournes, need a call to fsync between flushing and closing,
otherwise the wrong modification time may be obtained subsequently */

extern void os_filesync(FILE *f)
{
/*
  fsync(fileno(f));
*/
}

/* this gets called 'every so often'. 
 * It is used to handle expose events and check to see if the interrupt
 * button has been pressed. */

extern void os_update_windows(void)
{
  mlw_expose_windows();
/* the non-NT ports have this here:
   x_handle_expose_events();
*/
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
 * The Visual C++ manual isn't very explicit about what the rounding modes
 * it supports actually mean (espcially wrt IEEE modes).  Currently they
 * are mapped as follows :-
 *
 * _RC_NEAR : to nearest
 * _RC_DOWN : to negative infinity
 * _RC_UP   : to positive infinity
 * _RC_CHOP : to zero
 */


int os_get_rounding_mode (void)
{
  unsigned int c_mode= _controlfp(0, 0);
  switch(c_mode & _MCW_RC) {
  case _RC_NEAR:
    return 0;
  case _RC_DOWN:
    return 3;
  case _RC_UP:
    return 2;
  case _RC_CHOP:
    return 1;
  default:
    assert(0);
  }
}



static unsigned int
mlw_ieeefp_ml_to_c[]= { _RC_NEAR, _RC_CHOP, _RC_UP, _RC_DOWN };


void os_set_rounding_mode(int mode)
{
  assert(mode >= 0 && mode <= 3);
  (void)_controlfp(mlw_ieeefp_ml_to_c[mode], _MCW_RC);
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
    return NULL;
    break;
  default:
    error("Unknown code in os_allocator");
  }
  return NULL;
}

