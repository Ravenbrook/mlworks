/* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Any SunOS specific declarations which override the default code
 * in  ../OS/Unix/os_io_poll.c should go here.
 *
 * Revision Log
 * ------------
 *
 * $Log: os_io_poll_local.h,v $
 * Revision 1.1  1996/05/07 10:46:56  stephenb
 * new unit
 *
 */


/* 
 * Prototypes for various functions missing from the SunOS headers
 */
extern int poll(struct pollfd *, unsigned long, int);
extern char const *strerror(int);
