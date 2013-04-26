/* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Implements various system specific parts of rts/OS/Unix/basis_time
 *
 * Revision Log
 * ------------
 *
 * $Log: time_date_local.h,v $
 * Revision 1.1  1996/05/01 12:31:37  stephenb
 * new unit
 *
 */

#include <sys/time.h>		/* gettimeofday */

#define mlw_get_time_now(tv) gettimeofday(tv)
