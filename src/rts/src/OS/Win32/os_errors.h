/* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * This is the interface to some of functions that are used to
 * implement OS.errorMsg, OS.errorName and OS.syserror.
 * The functions themselves are automatically generated,
 * see ./GNUmake and rts/awk/win32_{c,os}_errors_c.awk for more information.
 *
 * Revision Log
 * ------------
 *
 * $Log: os_errors.h,v $
 * Revision 1.3  1997/05/21 11:02:15  johnh
 * [Bug #01702]
 * mlw_win32_strerror moved to win32_error.h.
 *
 * Revision 1.2  1996/06/03  13:51:59  stephenb
 * Replace mlw_os_strerror with mlw_win32_strerror since the former is
 * no longer exported from os_errors.c.
 *
 * Revision 1.1  1996/05/28  10:50:22  stephenb
 * new unit
 *
 */

#ifndef os_errors_h
#define os_errors_h

extern mlval mlw_os_error_name(mlval);
extern mlval mlw_os_syserror(mlval);

#endif /* !os_errors_h */
