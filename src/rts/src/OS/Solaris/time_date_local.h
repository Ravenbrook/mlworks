/* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Implements various system specific parts of rts/OS/Unix/time_date
 *
 * Revision Log
 * ------------
 *
 * $Log: time_date_local.h,v $
 * Revision 1.3  1996/10/22 11:18:11  jont
 * [Bug #1678]
 * Include syscalls.h to remove compiler warning
 *
 * Revision 1.2  1996/09/20  11:29:21  io
 * [Bug #1607]
 * remove getrusage and modify gettimeofday prototype
 *
 * Revision 1.1  1996/05/07  10:45:59  stephenb
 * new unit
 *
 */

#include "syscalls.h"

#define mlw_get_time_now(tv) gettimeofday(tv, NULL)
