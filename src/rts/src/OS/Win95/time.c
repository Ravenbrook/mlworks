/*  ==== PERVASIVE TIME ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 * Now that basis/time.sml and basis/timer.sml are fully implemented on all
 * platforms, all users of the interface (in the pervasive library) which
 * this file implements should move over to using the new basis interface.  
 * Until that time, this file (and the other five like it) has to be
 * maintained :-<
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
 *  Revision 1.15  1997/11/18 09:24:37  jont
 *  [Bug #30089]
 *  Remove stuff required by old MLWorks.Time
 *
 * Revision 1.14  1997/11/07  17:08:17  jont
 * [Bug #30089]
 * Remove time_file_modified and time_set_file_modified
 *
 * Revision 1.13  1997/03/14  10:34:06  johnh
 * [Bug #1850]
 * Replacing FindFirstFile with CreateFile - see comments.
 *
 * Revision 1.12  1996/12/19  10:17:26  stephenb
 * [Bug #1791]
 * MLTIME+CTIME: wrap the macro bodies in do { ... } while (0)
 * to avoid any binding problems
 *
 * Revision 1.11  1996/10/07  17:04:12  jont
 * Merging in beta updates
 *
 * Revision 1.10.1.2  1996/10/04  15:18:28  jont
 * Modify timestamp reading to take account of different file systems
 *  types
 *
 * Revision 1.10.1.1  1996/09/13  11:21:55  hope
 * branched from 1.10
 *
 * Revision 1.10  1996/09/09  17:55:06  jont
 * Remove use of ten_million in favour of mlw_ticks_per_sec
 * Move two_to_32 into time_date.h
 *
 * Revision 1.9  1996/08/22  13:28:49  jont
 * More problems with time stamp clamping
 *
 * Revision 1.8  1996/08/07  16:38:24  jont
 * Reduce accuracy of file time stamps to cope with portability to FAT
 *
 * Revision 1.7  1996/06/24  14:20:18  stephenb
 * Fix #1363 - Win95: Timings are bogus
 * Replaced the #ifdef'd out bodies of user_clock, get_current_time with
 * versions that get the real time and use that since Win95 doesn't
 * support process timing.
 *
 * Revision 1.6  1996/04/22  14:50:50  jont
 * Sort out removal of floor
 *
 * Revision 1.5  1996/03/01  11:27:07  jont
 * Add mktime, gmtime and localtime
 *
 * Revision 1.4  1996/02/14  17:37:14  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.3  1996/02/14  16:23:29  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.2  1996/02/14  13:15:16  jont
 * Add some type casts to remove warnings under VC++
 *
 * Revision 1.1  1995/10/17  13:43:52  jont
 * new unit
 *
 * Revision 1.8  1995/08/02  14:52:01  jont
 * Rearrange to get rid of compiler errors
 *
 * Revision 1.7  1995/07/17  15:47:47  nickb
 * Add ml_time_microseconds()
 *
 * Revision 1.6  1995/05/02  16:50:23  jont
 * Improve error message from set_time_modified
 *
 * Revision 1.5  1995/03/15  18:11:39  jont
 * Fix problem with the use of FindFirstFile and GetFileTime
 *
 * Revision 1.4  1995/02/07  12:05:25  jont
 * Remove manifest floating point constants in favour of type casts
 *
 * Revision 1.3  1995/01/19  12:51:16  jont
 * Fix decoding of timestamps to be same order as encoding
 *
 * Revision 1.2  1995/01/18  17:20:25  jont
 * Fix timings function bugs (negative and wrong order of magnitude answers)
 * Modified user_time to divide by 10 instead of multiply by 10
 *
 * Revision 1.1  1994/12/12  14:27:40  jont
 * new file
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

#include <windows.h> /* FILETIME */

#include "utils.h"
#include "mltypes.h"
#include "time_date.h"

extern void time_init(void)
{
}

/*  user_clock() is like clock(3) except that it returns only the user
 *  virtual time elapsed.
 *
 * Win95 doesn't support processes, so the real time (to the nearest
 * millisecond) is returned instead.
 */

double user_clock(void)
{
  SYSTEMTIME system_time;
  FILETIME user;
  double foo1, foo2;
  GetLocalTime(&system_time);
  (void)SystemTimeToFileTime(&system_time, &user);

  foo1 = (double)user.dwLowDateTime;
  foo2 = (double)user.dwHighDateTime;

  foo1 = foo1 / (double)10;
  foo2 = (foo2 * two_to_32) / (double)10;
  return ((double)user.dwLowDateTime / (double)10
	  + ((double) user.dwHighDateTime * two_to_32) / (double)10);
}
