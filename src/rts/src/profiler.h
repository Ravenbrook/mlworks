/*  ==== PROFILER ====
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
 *  Revision Log
 *  ------------
 *  $Log: profiler.h,v $
 *  Revision 1.5  1998/07/29 12:54:57  jont
 *  [Bug #20133]
 *  Make space_profile_active visible to external code (interface.S)
 *
 * Revision 1.4  1998/04/23  13:43:57  jont
 * [Bug #70034]
 * Rationalising names in mem.h
 *
 * Revision 1.3  1995/07/17  08:58:34  nickb
 * Move to new profiler framework, with results into ML.
 *
 * Revision 1.2  1994/06/09  14:46:07  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:16:07  nickh
 * new file
 *
 *  Revision 4.1  1994/03/29  15:57:03  johnk
 *  Bumped a revision.
 *
 *  Revision 3.4  1994/03/29  15:56:12  johnk
 *  Manually Bumped.
 *
 *  Revision 3.3  1994/03/23  12:44:07  nickh
 *  New profiler, with a slightly different interface.
 *
 *  Revision 3.2  1993/05/13  10:47:55  richard
 *  Added suspend and resume.
 *
 *  Revision 3.1  1993/04/06  15:28:01  richard
 *  Another complete rewrite based on Nosa's multi-level profiler.
 *
 *  Revision 2.5  1993/02/04  23:21:16  nosa
 *  Implemented a multi-level profiler
 *
 *  Revision 2.4  1992/12/18  15:20:56  clive
 *  Made the profiler take the generalised streams
 *
 *  Revision 2.3  1992/08/07  08:40:40  richard
 *  Profile_new() is no longer needed due to changes in the loader.
 *
 *  Revision 2.2  1992/07/29  14:23:00  richard
 *  Added better error return.
 *
 *  Revision 2.1  1992/07/14  15:56:06  richard
 *  Complete reimplementation without placing assumptions on the
 *  storage manager.  The profiler may now be `wrapped around'
 *  a computation in order to profile it, and sends it output to
 *  a specified stream.
 *
 *  Revision 1.4  1992/06/30  09:44:02  richard
 *  Tidying, and moved in_ML here since it isn't (going to be) used
 *  from the storage manager.
 *
 *  Revision 1.3  1992/06/11  17:07:21  clive
 *  Fixes to the profiler
 *  
 *  Revision 1.2  1992/05/08  17:09:03  clive
 *  Added some code for memory profiling and corrected some bugs
 *  
 *  Revision 1.1  1992/04/14  16:14:32  clive
 *  Initial revision
 */

#ifndef profiler_h
#define profiler_h

#include <stdio.h>
#include <stddef.h>

#include "options.h"
#include "values.h"
#include "stacks.h"

/*  === INIIALISE THE PROFILER ===
 *
 *  Performs internal initialisation.
 */

extern void profile_init(void);

/*  === PROFILING MANNER === */

#define PROFILE_CALLS		1
#define PROFILE_TIME		2
#define PROFILE_SPACE		4
#define PROFILE_SPACE_COPIES	8

#define PROFILE_DEPTH_SHIFT	16
#define PROFILE_DEPTH_MAX	15
#define PROFILE_DEPTH_MASK	(PROFILE_DEPTH_MAX << PROFILE_DEPTH_SHIFT)

#define PROFILE_BREAKDOWN_FIELDS 8
#define PROFILE_BREAKDOWN_SHIFT 8
#define PROFILE_BREAKDOWN_MASK  (((1<<PROFILE_BREAKDOWN_FIELDS) -1)	\
				 << PROFILE_BREAKDOWN_SHIFT)

#define PROFILE_SPACE_BREAKDOWN	PROFILE_BREAKDOWN_MASK

#define PROFILE_ALL	(PROFILE_CALLS + PROFILE_TIME + PROFILE_SPACE)

/*  === PROFILING OPTIONS ===
 *
 *  interval
 *    The interval, in virtual milliseconds, between scans of the stack.
 *    If zero, no scans will occur.
 *  manner
 *    A function which returns the manner in which a code item is
 *    to be profiled.
 *  stream
 *    The stream to which the profiler results are to be printed. If
 *    this is NULL, the profiler was called from ML and the profiler
 *    result should be constructed as an ML value and returned from
 *    profile_end.
 */

struct profile_options
{
  unsigned int interval;
  int (*manner)(mlval code);
  FILE *stream;
};

extern int profile_select_all_manner;
extern int profile_select_all(mlval code);

/* profile_on is non-zero when profiling and zero otherwise */

extern int profile_on;
extern int space_profile_active;

/*  profile_begin() and profile_end() are used to `bracket' a section of
 *  code to be profiled.
 */

extern int profile_begin(struct profile_options *options);
extern int profile_end(mlval *result);

enum /* errno */
{
  EPROFILENEST = 1,			/* profiler cannot nest */
  EPROFILEDEPTH				/* stack profiling too deep */
};

/* time_profile_scan is called by the signal-handling code (in
 * signals.[ch]), each time the profiler alarm goes off. */

extern void time_profile_scan(struct stack_frame *sp);

/* pre_gc_space_profile and post_gc_space_profile are called either
   side of a collection from 'from' to 'to'. 'number' is the true
   generation number of the 'from' generation.  */

extern void pre_gc_space_profile(struct ml_heap *from,
				 struct ml_heap *to,
				 int number);
extern void post_gc_space_profile(struct ml_heap *from,
				  struct ml_heap *to,
				  int number);

/*  === PROFILE SUSPENDING ===
 *
 *  Between a profile_begin() and a profile_end() it may be desirable to
 *  suspend profiling temporarily, for example, to enter a debugger.
 *  profile_suspend() and profile_resume() do the obvious thing, and return
 *  zero on success.  They nest, and return -1 and set errno to EPROFILENEST
 *  if wrongly nested or used outside profiling.
 *
 *  The integer profile_suspended is non-zero if profiling is suspended.  It
 * is not meaningful outside profiling.  */

extern int profile_suspended;
extern int profile_suspend(void);
extern int profile_resume(void);

#endif
