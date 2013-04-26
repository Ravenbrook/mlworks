/* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Implements various system specific parts of rts/OS/Unix/time_date.[ch]
 *
 * Revision Log
 * ------------
 *
 * $Log: time_date_local.h,v $
 * Revision 1.3  1997/10/15 16:37:48  io
 * add difftime for SunOS and fix strftime
 *
 * Revision 1.2  1996/05/10  08:37:42  stephenb
 * Add a prototype for strftime since the SunOS header files don't contain it.
 *
 * Revision 1.1  1996/05/07  09:52:00  stephenb
 * new unit
 *
 */

/* The following should be declared in <sys/time.h> but under SunOS it isn't. 
 */
extern int gettimeofday(struct timeval *, struct timezone *);

#define mlw_get_time_now(tv) gettimeofday(tv, NULL)

/* The following should be declared in <time.h> but isn't */

extern time_t mktime(struct tm *timeptr);
extern size_t strftime(char *s, size_t maxsize, const char *format, const struct tm *timeptr);

extern time_t time(time_t *tloc);
#define difftime(x,y)  ((double)(x-y))
