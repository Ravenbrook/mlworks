/*  === Win32 Error & String functions ===
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * Revision Log
 * ------------
 * $Log: win32_error.h,v $
 * Revision 1.1  1997/05/22 09:17:09  johnh
 * new unit
 * [Bug #01702]
 * Moved mlw_win32_strerror from being auto generated to this file plus
 * other functions that were duplicated across a number of files.
 *
 *
 */

#ifndef win32_error_h
#define win32_error_h

extern void mlw_raise_win32_syserr(int);
extern void mlw_raise_c_syserr(int);
extern mlval mlw_win32_strerror(unsigned int);

#endif
