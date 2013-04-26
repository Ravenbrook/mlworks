/* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 *
 * Revision Log
 * ------------
 *
 * $Log: time_date.h,v $
 * Revision 1.6  1997/11/17 10:05:28  jont
 * [Bug #30089]
 * Add mlw_time_make for converting doubles to basis times
 *
 * Revision 1.5  1996/09/09  17:55:07  jont
 * Move two_to_32 into time_date.h from time.c
 *
 * Revision 1.4  1996/06/13  15:54:52  stephenb
 * Add mlw_time_to_timeval as needed by select (which is used to
 * implement OS.IO.poll).
 *
 * Revision 1.2  1996/06/12  08:47:58  stephenb
 * Replace the previous interface with one that better hides the internal
 * details of the type.
 *
 * Revision 1.1  1996/05/01  10:16:05  stephenb
 * new unit
 *
 */

#ifndef time_date_h
#define time_date_h

#include "mltypes.h"
#include <windows.h> /* FILETIME */

#define mlw_time_ticks_per_sec 10000000
#define two_to_32 ((double)(1 << 16) * (double)(1 << 16))

extern mlval mlw_time_from_file_time(FILETIME *);
extern void  mlw_time_to_file_time(mlval, FILETIME *);
extern void  mlw_time_to_timeval(mlval, struct timeval *);
extern mlval mlw_time_from_double(double);
extern mlval mlw_time_make(long secs, long usecs); /* ALLOCATES */

#endif /* !time_date_h */
