/* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Revision Log
 * ------------
 *
 * $Log: time_date.h,v $
 * Revision 1.2  1996/07/04 09:11:01  stephenb
 * Add a comment noting that mlw_time_make allocates.
 *
 * Revision 1.1  1996/05/07  14:13:25  stephenb
 * new unit
 *
 */

/* The following are obviously not going to change, they are just here
 * so that the code isn't littered with manifest constants which invite
 * the possibility of adding or dropping a zero.
 */
#define mlw_time_usecs_per_sec 1000000
#define mlw_time_msecs_per_sec 1000


extern long mlw_time_sec(mlval);
extern long mlw_time_usec(mlval);
extern mlval mlw_time_make(long secs, long usecs); /* ALLOCATES */
