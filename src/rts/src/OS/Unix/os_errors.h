/* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * This is the interface to a couple of functions that are used to
 * implement OS.errorName and OS.syserror.  The functions themselves
 * are automatically generated, see ./GNUmake  and 
 * rts/awk/posix_os_errors_c.awk for more information.
 *
 * Revision Log
 * ------------
 *
 * $Log: os_errors.h,v $
 * Revision 1.1  1996/05/28 10:44:44  stephenb
 * new unit
 *
 */

#ifndef os_errors_h
#define os_errors_h

extern mlval mlw_os_error_name(mlval);
extern mlval mlw_os_syserror(mlval);

#endif /* !os_errors_h */
