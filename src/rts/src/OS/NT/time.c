/*  ==== PERVASIVE TIME ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
 *  Revision 1.21  1997/11/18 09:24:59  jont
 *  [Bug #30089]
 *  Remove stuff required by old MLWorks.Time
 *
 * Revision 1.20  1997/11/07  17:08:01  jont
 * [Bug #30089]
 * Remove time_file_modified and time_set_file_modified
 *
 * Revision 1.19  1997/03/14  10:34:49  johnh
 * [Bug #1850]
 * Replacing FindFirstFile with CreateFile - see comments.
 *
 * Revision 1.18  1996/12/19  09:52:02  stephenb
 * [Bug #1791]
 * MLTIME+CTIME: wrap the macro bodies in do { ... } while (0)
 * to avoid any binding problems
 *
 * Revision 1.17  1996/10/07  17:03:38  jont
 * Merging in beta updates
 *
 * Revision 1.16.1.2  1996/10/07  10:51:09  jont
 * Add ml_stat_sub for doing stuff common to ml_stat for Win95 and NT.
 * Includes stuff to deal with timezone variation problems on FAT
 *
 * Revision 1.16  1996/09/09  17:55:04  jont
 * Remove use of ten_million in favour of mlw_ticks_per_sec
 * Move two_to_32 into time_date.h
 *
 * Revision 1.15  1996/08/22  13:29:10  jont
 * More problems with time stamp clamping
 *
 * Revision 1.14  1996/08/07  17:06:09  jont
 * Add time stamp clamping as per the Win95 so installation works properly
 *
 * Revision 1.13  1996/04/19  11:05:49  matthew
 * Renaming exceptions
 *
 * Revision 1.12  1996/03/01  11:02:59  jont
 * Add localtime, gmtime and mktime
 *
 * Revision 1.11  1996/02/14  17:37:01  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.10  1996/02/14  16:09:17  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.9  1996/02/13  18:10:16  jont
 * Add some type casts to allow compilation without warnings under VC++
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

#define DEBUG_TIMES 0

/*  user_clock() is like clock(3) except that it returns only the user
 *  virtual time elapsed.
 */

extern void time_init(void)
{
}

extern double user_clock(void)
{
  FILETIME creation, death, kernel, user;

  double foo1, foo2;
  if((GetProcessTimes(GetCurrentProcess(), &creation, &death, &kernel, &user)) != TRUE)
    error("Unable to read resource consumption.  "
	  "GetProcessTimes() set errno to %d.", GetLastError());

  foo1 = (double)user.dwLowDateTime;
  foo2 = (double)user.dwHighDateTime;

  foo1 = foo1 / (double)10;
  foo2 = (foo2 * two_to_32) / (double)10;
  return ((double)user.dwLowDateTime / (double)10
	  + ((double) user.dwHighDateTime * two_to_32) / (double)10);
}
