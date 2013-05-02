/*  ==== OPERATING SYSTEM INTERFACE ====
 *
 *  Copyright (C) 1994 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  Provides interfaces to OS-specific modules to the rest of the runtime.
 *
 *  Revision Log
 *  ------------
 *  $Log: os.h,v $
 *  Revision 1.7  1998/08/17 11:29:16  jont
 *  [Bug #70153]
 *  Add system_validate_ml_address
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

#endif
