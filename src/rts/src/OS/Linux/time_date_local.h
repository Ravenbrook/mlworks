/* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Implements various system specific parts of rts/OS/Unix/time_date.[ch]
 *
 * Revision Log
 * ------------
 *
 * $Log: time_date_local.h,v $
 * Revision 1.1  1996/05/07 10:03:13  stephenb
 * new unit
 *
 */


#define mlw_get_time_now(tv) gettimeofday(tv, NULL)
