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
 *  Revision 1.17  1997/11/18 15:38:16  jont
 *  [Bug #30089]
 *  Remove functions used by MLWorks.Time
 *
 * Revision 1.16  1997/11/07  17:07:00  jont
 * [Bug #30089]
 * Remove time_file_modified and time_set_file_modified
 *
 * Revision 1.15  1997/08/19  15:13:57  nickb
 * [Bug #30250]
 * Bugs in use of allocate_record and allocate_array: add debug-filling code.
 *
 * Revision 1.14  1996/12/19  09:46:06  stephenb
 * [Bug #1791]
 * MLTIME+CTIME: wrap the macro bodies in do { ... } while (0)
 * to avoid any binding problems
 *
 * Revision 1.13  1996/04/19  14:17:33  matthew
 * Changes to Exception raising
 *
 * Revision 1.12  1996/03/01  11:35:15  jont
 * Fix implementation of tm_to_time
 *
 * Revision 1.11  1996/02/14  17:36:25  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.10  1996/02/14  16:04:25  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.9  1995/07/17  09:53:37  nickb
 * Add ml_time_microseconds()
 *
 * Revision 1.8  1995/05/09  14:02:01  daveb
 * Added ml_time_t.
 *
 * Revision 1.7  1995/05/02  16:48:29  jont
 * Improve error message from set_time_modified
 *
 * Revision 1.6  1995/04/13  15:46:58  jont
 * Add interface to gmtime, localtime, mktime
 *
 * Revision 1.5  1994/12/09  16:27:54  jont
 * Change time.h to mltime.h
 * Fix bug 844 (set_file_time_modified problem)
 *
 * Revision 1.4  1994/11/09  12:38:42  jont
 * Fix overflowing integer computation in get_current_time
 *
 * Revision 1.3  1994/10/19  15:40:31  nickb
 * Some ints should be long ints here.
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
#include <sys/time.h>
#include <sys/resource.h>

#include "syscalls.h"
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
  
