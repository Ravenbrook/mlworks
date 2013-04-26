/*  ==== PERVASIVE TIME ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Implementation
 *  --------------
 * Clock time and intervals are timeval pairs of integers (second,
 * microsecond), obtained from getrusage(2) and gettimeofday(2). File
 * modification times obtained from stat(2) get zero microseconds
 * (this appears unsafe, but actually is safe because stat(2) times
 * could be on a different machine in any case, so must only ever be
 * compared with each other, and not with now()).
 *
 * Times and intervals are represented to ML as triples of ints, a
 * pair for the seconds (each MLint taking 24 bits, allowing for
 * 48-bit values) and one for the microseconds.
 *
 *  Revision Log
 *  ------------
 *  $Log: time.c,v $
 *  Revision 1.17  1997/11/18 15:21:41  jont
 *  [Bug #30089]
 *  Remove stuff only required by old (now removed) MLWorks.Time
 *
 * Revision 1.16  1997/11/07  17:06:40  jont
 * [Bug #30089]
 * Remove time_file_modified and time_set_file_modified
 *
 * Revision 1.15  1997/08/19  15:13:53  nickb
 * [Bug #30250]
 * Bugs in use of allocate_record and allocate_array: add debug-filling code.
 *
 * Revision 1.14  1996/12/19  09:49:34  stephenb
 * [Bug #1791]
 * MLTIME+CTIME: wrap the macro bodies in do { ... } while (0)
 * to avoid any binding problems
 *
 * Revision 1.13  1996/04/19  11:03:56  matthew
 * Changes to exceptions]
 *
 * Revision 1.12  1996/03/01  12:03:05  jont
 * Fix implementation of tm_to_time
 *
 * Revision 1.11  1996/02/14  17:36:35  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.10  1996/02/14  15:38:35  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.9  1996/01/29  13:15:19  stephenb
 * Add <sys/resource.h> since syscalls.h no longer pulls this in.
 *
 * Revision 1.8  1995/07/17  09:53:55  nickb
 * Add ml_time_microseconds.
 *
 * Revision 1.7  1995/05/10  16:54:19  daveb
 * Added ml_time_t.
 *
 * Revision 1.6  1995/05/02  16:48:45  jont
 * Improve error message from set_time_modified
 *
 * Revision 1.5  1995/04/13  15:55:36  jont
 * Add interface to gmtime, localtime, mktime
 *
 * Revision 1.4  1994/12/09  16:28:08  jont
 * Change time.h to mltime.h
 *
 * Revision 1.3  1994/11/09  12:39:02  jont
 * Fix overflowing integer computation in get_current_time
 *
 * Revision 1.2  1994/10/19  16:24:27  nickb
 * Change ints to long ints.
 *
 * Revision 1.1  1994/07/12  12:40:48  jont
 * new file
 *
 * Revision 1.2  1994/06/09  14:27:56  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:52:22  nickh
 * new file
 *
 *  Revision 1.11  1994/03/30  14:57:28  daveb
 *  Revised set_file_modified to take a datatype.
 *
 *  Revision 1.10  1994/03/30  13:49:43  daveb
 *  Added set_file_modified.
 *
 *  Revision 1.9  1994/01/28  17:40:03  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.8  1993/11/23  17:40:25  jont
 *  Exposed the encode and decode time functions for runtime consistency checking
 *  Increased the size of the marshalling buffer to the required size
 *
 *  Revision 1.7  1993/11/17  12:23:56  nickh
 *  Runtime support for new pervasive time structure.
 *  (radical change).
 *
 *  Revision 1.6  1993/06/02  13:10:08  richard
 *  Removed unused variable.
 *
 *  Revision 1.5  1993/04/26  11:50:51  richard
 *  Increased diagnostic levels.
 *
 *  Revision 1.4  1993/02/01  16:04:34  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.3  1992/12/23  13:57:43  richard
 *  Fixed the use of strftime in the case where the format string is empty.
 *
 *  Revision 1.2  1992/11/09  11:58:46  richard
 *  Corrected some missing initialisation.
 *
 *  Revision 1.1  1992/11/03  14:17:17  richard
 *  Initial revision
 *
 */

#include <errno.h>
#include <sys/resource.h>

#include "mltime.h"
#include "utils.h"

/*  user_clock() is like clock(3) except that it returns only the user
 *  virtual time elapsed.
 */

extern double user_clock(void)
{
  struct rusage rusage;

  if (getrusage(RUSAGE_SELF, &rusage))
    error ("Unable to read resource usage, "
	   "getrusage set errno to %d.",errno);

  return (rusage.ru_utime.tv_usec
	  + (double) rusage.ru_utime.tv_sec * 1000000.0);
}

void time_init()
{
}
