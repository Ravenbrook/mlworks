/* Copyright (C) 1996 Harlequin Ltd.
 * 
 * Solaris/UltraSPARC compatibility check. Allows us to exit with
 * a clean message on broken platforms, rather than a messy SEGV.
 * 
 * $Log: check_windows.h,v $
 * Revision 1.2  1996/10/14 14:41:12  nickb
 * Add conditional compilation stuff.
 *
 * Revision 1.1  1996/10/14  13:44:41  nickb
 * new unit
 * Register window cleaning trap incompatible between SPARC and UltraSPARC
 * platforms.
 *
 */

#ifndef _check_windows_h
#define _check_windows_h

#include "types.h"

extern word check_windows(void);

#endif
