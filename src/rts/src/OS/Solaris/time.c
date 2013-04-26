/*  ==== PERVASIVE TIME ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Implementation
 *  --------------
 * Clock time and intervals are timestruc pairs of integers (second,
 * nanosecond), obtained from PIOCUSAGE. File modification times
 * obtained from stat(2) get zero nanoseconds (this appears unsafe,
 * but actually is safe because stat(2) times could be on a different
 * machine in any case, so must only ever be compared with each other,
 * and not with now()).
 *
 * Times and intervals are represented to ML as quadruples of ints, a
 * pair for the seconds (each MLint taking 24 bits, allowing for
 * 48-bit values) and a pair for the nanoseconds.
 *
 *  Revision Log
 *  ------------
 *  $Log: time.c,v $
 *  Revision 1.20  1997/11/17 19:07:00  jont
 *  [Bug #30089]
 *  Remove functions only used by old MLWorks.Time structure (now removed)
 *
 * Revision 1.19  1997/11/07  17:07:22  jont
 * [Bug #30089]
 * Remove time_file_modified and time_set_file_modified
 *
 * Revision 1.18  1997/04/10  12:55:01  jont
 * [Bug #2036]
 * Cache value of tick to avoid system calls in time conversions
 *
 * Revision 1.17  1996/12/19  09:48:03  stephenb
 * [Bug #1791]
 * MLTIME+CTIME: wrap the macro bodies in do { ... } while (0)
 * to avoid any binding problems
 *
 * Revision 1.16  1996/09/20  11:29:28  io
 * [Bug #1607]
 * remove getrusage and modify gettimeofday prototype
 *
 * Revision 1.15  1996/04/19  14:55:40  matthew
 * Changes to Exception raising
 *
 * Revision 1.14  1996/03/01  11:51:49  jont
 * Fix implementation of tm_to_time
 *
 * Revision 1.13  1996/02/14  17:29:45  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.12  1996/02/14  15:11:44  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.11  1996/01/30  17:41:15  jont
 * Fix bug 907 (MLWorks.Time.now gives wrong answer)
 *
 * Revision 1.10  1995/07/17  11:27:12  nickb
 * Add ml_time_microseconds()
 *
 * Revision 1.9  1995/05/10  15:58:45  daveb
 * Added ml_time_t.
 *
 * Revision 1.8  1995/05/02  16:40:52  jont
 * Improve error message from set_time_modified
 *
 * Revision 1.7  1995/04/13  11:18:26  jont
 * Add interface to gmtime, localtime, mktime
 *
 * Revision 1.6  1995/02/23  13:56:12  nickb
 * Remove BSDisms.
 *
 * Revision 1.5  1994/12/12  11:03:56  jont
 * Change time.h to mltime.h
 *
 * Revision 1.4  1994/11/09  12:40:38  jont
 * Fix overflowing integer computation in get_current_time
 *
 * Revision 1.3  1994/10/20  10:43:32  nickb
 * Correct some types for gcc 2.5.8
 *
 * Revision 1.2  1994/07/22  14:15:36  nickh
 * user_clock is off by a factor of 1000. Should use times() instead.
 *
 * Revision 1.1  1994/07/08  10:45:13  nickh
 * new file
 * */

#include <sys/times.h>

#include <sys/param.h>

#include "mltime.h" 

typedef unsigned long long int nanoseconds;

static nanoseconds CACHE_TICK;

extern double user_clock(void)
{
  struct tms timebuf;

  (void) times(&timebuf);

  return ((((double)timebuf.tms_utime) * CACHE_TICK) / 1000.0);
}

extern void time_init(void)
{
  CACHE_TICK=TICK;
}
