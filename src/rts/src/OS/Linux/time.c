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
 *  Revision 1.16  1997/11/18 12:22:59  jont
 *  [Bug #30089]
 *  Remove stuff only required by old MLWorks.Time (now removed)
 *
 * Revision 1.15  1997/11/07  17:03:06  jont
 * [Bug #30089]
 * Remove time_file_modified and time_set_file_modified
 *
 * Revision 1.14  1997/08/19  15:13:54  nickb
 * [Bug #30250]
 * Bugs in use of allocate_record and allocate_array: add debug-filling code.
 *
 * Revision 1.13  1996/12/19  10:38:26  stephenb
 * [Bug #1791]
 * MLTIME+CTIME: wrap the macro bodies in do { ... } while (0)
 * to avoid any binding problems
 *
 * Revision 1.12  1996/04/19  11:06:01  matthew
 * Renaming exceptions
 *
 * Revision 1.11  1996/03/01  12:16:08  jont
 * Fix implementation of tm_to_time
 *
 * Revision 1.10  1996/02/14  17:36:47  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.9  1996/02/14  15:37:45  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.8  1995/08/04  10:50:30  nickb
 * gcc warning in time_to_string.
 *
 * Revision 1.7  1995/07/17  12:36:26  nickb
 * Add ml_time_microseconds.
 *
 * Revision 1.6  1995/05/18  16:09:04  jont
 * Add ml_time_t
 *
 * Revision 1.5  1995/05/02  16:49:04  jont
 * Improve error message from set_time_modified
 *
 * Revision 1.4  1995/04/13  16:12:45  jont
 * Add interface to gmtime, localtime, mktime
 *
 * Revision 1.3  1994/12/09  17:14:35  jont
 * Change time.h to mltime.h
 * Fix bug 844
 *
 * Revision 1.2  1994/11/09  11:13:19  jont
 * Fix overflowing integer computation in get_current_time
 *
 * Revision 1.1  1994/10/04  16:29:22  jont
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
