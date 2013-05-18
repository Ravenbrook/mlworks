/*  ==== GARBAGE COLLECTOR ====
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
 *  Description
 *  -----------
 *  This file implements a generational garbage collector as part of the
 *  default storage manager for the MLWorks runtime system.  For details of
 *  the interface between the storage manager and the runtime system see the
 *  MLWorks documentation.
 *
 *  Revision Log
 *  ------------
 *  $Log: gc.c,v $
 *  Revision 1.51  1998/09/30 13:37:28  jont
 *  [Bug #70108]
 *  Remove requirement for time.h and resource.h
 *
 * Revision 1.50  1998/08/21  16:33:17  jont
 * [Bug #20133]
 * Set up GC_HEAP_REAL_LIMIT
 *
 * Revision 1.49  1998/06/29  11:07:15  jont
 * [Bug #20115]
 * Make sure we don't try to calculate the generation of values outside the
 * heap when fixing entry lists
 *
 * Revision 1.48  1998/05/29  12:49:01  jont
 * [Bug #70124]
 * Make gen->last.the.back point to gen->entry.the.back
 *
 * Revision 1.47  1998/05/26  15:31:22  mitchell
 * [Bug #30411]
 * Support for time-limited run-time
 *
 * Revision 1.46  1998/05/11  17:38:13  jont
 * [Bug #70031]
 * Fix compiler warnings
 *
 * Revision 1.45  1998/04/30  10:51:02  jont
 * [Bug #70031]
 * Make CREATION_SIZE be a variable
 *
 * Revision 1.44  1998/04/27  13:44:44  jont
 * [Bug #70032]
 * gen->values now measured in bytes
 *
 * Revision 1.43  1998/04/23  13:45:20  jont
 * [Bug #70034]
 * Rationalising names in mem.h
 *
 * Revision 1.42  1998/03/25  11:38:42  jont
 * [Bug #70018]
 * Fix problems associated with delivery
 *
 * Revision 1.41  1998/03/19  10:44:41  jont
 * [Bug #70018]
 * Fix compiler warnings
 *
 * Revision 1.40  1998/03/03  16:25:36  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.39  1997/09/12  13:00:25  nickb
 * Improve heap analysis to count pointers and integers.
 *
 * Revision 1.38  1996/05/22  15:11:47  nickb
 * Determining the generation of from-space static objects was
 * breaking entry list invariants. The fix is to move from-space
 * static objects to to-space at the beginning of the GC.
 * Also a problem with dereferencing gc_message_level when it has
 * a bogus value.
 * Also a few problems with checking the liveness or generation
 * of static shared closures or code items.
 *
 * Revision 1.37  1996/05/14  16:18:55  nickb
 * Windows compiler complains about signed/unsigned comparison.
 *
 * Revision 1.36  1996/02/19  14:16:38  nickb
 * Add call to global_tidy in gc_clean_image.
 *
 * Revision 1.35  1996/02/14  17:21:08  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.34  1996/02/14  12:08:55  nickb
 * Add heap-exploration hooks.
 *
 * Revision 1.33  1996/02/13  17:09:39  jont
 * Add some type casts to assist compilation without warnings under VC++
 *
 * Revision 1.32  1996/01/16  11:57:41  nickb
 * Remove "storage manager" interface; replace it with regular functions.
 *
 * Revision 1.31  1996/01/11  14:51:11  nickb
 * Remove gc-triggered window updates; these are now done by a timer.
 *
 * Revision 1.30  1996/01/09  15:24:34  nickb
 * Restore code to update windows.
 *
 * Revision 1.29  1995/10/24  11:43:32  nickb
 * Make C root table a closed hash table.
 *
 * Revision 1.28  1995/09/26  10:47:49  jont
 * Add SM_EXEC_IMAGE_SAVE
 *
 * Revision 1.27  1995/09/19  14:30:49  nickb
 * Add culprit analysis.
 *
 * Revision 1.26  1995/09/13  12:39:10  jont
 * Add parameter to sm_interface to control whether stack_crawl is done
 *
 * Revision 1.25  1995/09/13  12:21:06  nickb
 * Add SM_PROMOTE_ALL
 *
 * Revision 1.24  1995/07/21  16:05:12  matthew
 * Removing call to os_update_windows as this is unsafe if expose handlers call ML
 *
 * Revision 1.23  1995/07/14  10:56:21  nickb
 * Add space profiling hooks.
 *
 * Revision 1.22  1995/04/24  13:33:17  nickb
 * Add window updating and SM_WINDOW_UPDATES.
 *
 * Revision 1.21  1995/04/05  13:49:49  nickb
 * Add maximum memory use reporting.
 *
 * Revision 1.20  1995/03/15  17:04:00  nickb
 * Changes for threads.
 *
 * Revision 1.19  1995/03/07  16:12:56  nickb
 * Fix static object entry list bug.
 *
 * Revision 1.18  1995/02/28  13:13:21  nickb
 * union static_object has become struct static_object.
 *
 * Revision 1.17  1995/02/27  16:51:21  nickb
 * TYPE_LARGE becomes TYPE_STATIC
 *
 * Revision 1.16  1995/02/23  16:40:37  nickb
 * Remove inline declarations.
 *
 * Revision 1.15  1995/02/07  12:12:18  jont
 * Remove manifest floating point constants in favour of type casts
 *
 * Revision 1.14  1994/12/09  17:50:22  jont
 * Add ifndef control for NT
 *
 * Revision 1.13  1994/12/09  15:41:28  jont
 * Change time.h to mltime.h
 *
 * Revision 1.12  1994/11/23  15:24:59  nickb
 * Entry list bug with inplace collection.
 *
 * Revision 1.11  1994/11/09  16:24:57  nickb
 * Add instruction cache flushing.
 *
 * Revision 1.10  1994/10/14  15:43:12  nickb
 * Algorithmic improvements and modified list optimisation.
 *
 * Revision 1.9  1994/10/13  13:40:46  nickb
 * Make generation sizes change with the space size.
 *
 * Revision 1.8  1994/07/18  16:56:58  nickh
 * Add typical instruction analysis code, compiled out with #ifdef
 * COUNT_IMPLICITS, as an example.
 *
 * Revision 1.7  1994/07/15  09:42:03  nickh
 * Add simple garbage collection counter.
 *
 * Revision 1.6  1994/07/04  11:27:25  nickh
 * Make allocation analysis slightly more sophisticated.
 *
 * Revision 1.5  1994/07/01  16:25:20  nickh
 * Tidied up mesages and added analysis routines.
 *
 * Revision 1.4  1994/06/22  13:07:47  nickh
 * Add heap analysis code.
 *
 * Revision 1.3  1994/06/21  15:58:54  nickh
 * Improve 'complete' garbage collection (SM_COLLECT_ALL).
 *
 * Revision 1.2  1994/06/09  14:47:40  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:19:15  nickh
 * new file
 *
 *  Revision 1.89  1994/02/24  14:45:55  nickh
 *  Get the self-collecting messages right.
 *
 *  Revision 1.88  1994/02/24  13:16:13  nickh
 *  Added gc_message_end to self_collect.
 *
 *  Revision 1.87  1994/02/14  15:38:51  nickh
 *  Fixed the RCS log and the C handling of boxed floats.
 *
 *  Revision 1.86  1994/01/28  17:47:35  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.85  1994/01/26  12:43:53  nickh
 *  Fix treatment of bytearrays in C version of fixup, and
 *  change a size_t (which has changed to unsigned in Gcc 2.x.
 *
 *  Revision 1.84  1994/01/25  16:48:24  nickh
 *  Lifted integer test out of mach_fixup, for speed.
 *
 *  Revision 1.83  1994/01/11  14:51:01  nickh
 *  Fix various minor problems following a code review.
 *
 *  Revision 1.82  1994/01/11  12:55:27  nickh
 *  Fixed comments for stack_crawl().
 *
 *  Revision 1.81  1993/12/15  13:24:46  nickh
 *  Added SM_GET_STACK_LIMIT for symmetry.
 *
 *  Revision 1.80  1993/10/12  16:10:23  matthew
 *  Merging bug fixes
 *
 *  Revision 1.79.1.2  1993/10/12  14:54:55  matthew
 *  Added SM_EXTEND_STACK_LIMIT and SM_SET_STACK_LIMIT to sm_interface.
 *
 *  Revision 1.79.1.1  1993/06/22  11:16:30  jont
 *  Fork for bug fixing
 *
 *  Revision 1.79  1993/06/22  11:16:30  richard
 *  Moved the stack backtrace to a common place (utils).
 *
 *  Revision 1.78  1993/06/02  13:12:30  richard
 *  Added parentheses suggested by GCC 2.
 *  Changed some print formats from %08X to %p.
 *
 *  Revision 1.77  1993/05/13  16:32:02  jont
 *  Allowed function inlining to happen
 *
 *  Revision 1.76  1993/04/26  11:20:21  richard
 *  Increased diagnostic levels.
 *
 *  Revision 1.75  1993/04/06  11:36:38  richard
 *  New code vector organization and access macros.
 *
 *  Revision 1.74  1993/04/02  14:24:58  jont
 *  Extra case in sm_interface for image table
 *
 *  Revision 1.73  1993/02/11  16:37:53  jont
 *  Changes for code vector reform.
 *
 *  Revision 1.72  1993/02/09  18:22:03  matthew
 *  Added self_collect function.
 *  Changed sm_interface to use self_collect.
 *
 *  Revision 1.71  1993/02/01  16:04:28  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.70  1993/01/12  16:39:16  jont
 *  Added stack backtrace in case of bad header in register problem
 *
 *  Revision 1.69  1992/12/14  12:43:58  richard
 *  scan() was not appropriate for fixing the registers in a frame.  Headers
 *  in a register confused it.
 *
 *  Revision 1.68  1992/12/08  13:56:42  richard
 *  Generation 0 should not be resized even if its collection is
 *  forced.
 *
 *  Revision 1.67  1992/12/07  17:16:44  richard
 *  Corrected size of store mapped during SM_COLLECT action in
 *  sm_interface.
 *
 *  Revision 1.66  1992/12/07  17:13:41  richard
 *  Corrected method of creation the heap on the first call.
 *
 *  Revision 1.65  1992/11/20  15:08:12  jont
 *  Fixed gc_clock to be calculated from rusage to be consistent with
 *  other timings within the system. Removed the system element from
 *  gc time to allow consistent calculation of non-gc user time
 *
 *  Revision 1.64  1992/11/03  13:22:26  richard
 *  Added sm_interface() function.
 *
 *  Revision 1.63  1992/10/15  16:22:03  richard
 *  Added sm_interface function.  (Not yet well defined.)
 *  Corrected the large object code to set up space_gen[].
 *
 *  Revision 1.62  1992/10/02  14:18:05  richard
 *  Added casts to call to pow() so that it gets the right arguments.
 *  (Because the system headers are useless, basically.)
 *
 *  Revision 1.61  1992/10/02  08:39:40  richard
 *  Added ansi.h.
 *
 *  Revision 1.60  1992/09/09  13:21:29  richard
 *  Changed the criteria for extending the heap limit.  Should be more sane
 *  when near the limit.
 *
 *  Revision 1.59  1992/08/17  11:31:28  richard
 *  Added code to cope with the contingency of arena overflow.
 *
 *  Revision 1.58  1992/08/12  14:30:00  richard
 *  Changed the format of the gc statistics.
 *
 *  Revision 1.57  1992/08/05  17:37:41  richard
 *  Code vectors are now tagged differently to strings.
 *
 *  Revision 1.56  1992/08/04  16:28:31  richard
 *  Corrected a typo in retract_root().
 *
 *  Revision 1.55  1992/08/04  12:16:43  richard
 *  A new version using resizable generations without subdivisions.
 *  Makes use of a new version of the memory manager and an arena
 *  manager.
 *
 *  Revision 1.54  1992/07/28  13:28:51  richard
 *  Cached the gc message level so that it can't disappear or change
 *  while the collector is running.
 *  Tidied up the message and statisical output.
 *
 *  Revision 1.53  1992/07/23  14:08:48  richard
 *  Removed the code for weak C roots.
 *  Large objects are now scanned and collected properly.
 *  Additional information concerning large objects and the modified list
 *  is output if the GC message level is -1.
 *  Removed gcdebug.h.
 *
 *  Revision 1.52  1992/07/16  13:17:26  richard
 *  Rewrote the stack crawler to scan non-contiguous chunks of stack
 *  and so allow re-entry to ML.
 *  Changed the format of output to the gc_stat_stream.
 *
 *  Revision 1.51  1992/07/15  15:35:34  richard
 *  Changed the array header structure in order to tidy things up.
 *  The gc_message_level is now a ref cell on the heap.
 *
 *  Revision 1.50  1992/07/14  11:17:17  richard
 *  Implemented weak arrays.
 *
 *  Revision 1.49  1992/07/09  09:29:20  richard
 *  Corected pointer difference problem in fixup.
 *
 *  Revision 1.48  1992/07/03  07:19:23  richard
 *  Removed uses of P().  Stack extensions are marked with STACK_EXTENSION.
 *
 *  Revision 1.47  1992/07/01  11:38:33  richard
 *  Removed references to ml_state etc. in order to make garbage collector
 *  replaceable.  Corrected linked list code for large objects.
 *  Added temporary in_ML fix to stack_crawl().
 *
 *  Revision 1.46  1992/06/29  09:54:15  richard
 *  Altered some diagnostic levels.  Debugged fixup(), and abolished in_ML.
 *
 *  Revision 1.45  1992/06/25  08:24:39  richard
 *  Added calls to vadvise() around garbage collections.
 *
 *  Revision 1.44  1992/06/24  13:58:32  richard
 *  The C version of fixup() had gone rusty, so I've rewritten it, modelling
 *  it closely on the SPARC version.  It is now operational and faster than
 *  it used to be.
 *
 *  Revision 1.43  1992/06/23  14:06:29  richard
 *  Implemented a large object storage system using mark-and-sweep
 *  garbage collection.
 *
 *  Revision 1.42  1992/06/22  11:38:32  clive
 *  Stack_extension_marker now used
 *
 *  Revision 1.41  1992/06/18  12:07:06  richard
 *  Changed the way that stack extension frames are marked, and allowed
 *  the existence of other frames without closures.
 *
 *  Revision 1.40  1992/06/03  09:11:25  richard
 *  Corrected space naming problem that was confusing entry lists.
 *  Increased default gc_message_level to 2.
 *  Increased diagnostic level of messages about roots, which are very boring.
 *
 *  Revision 1.39  1992/05/27  08:33:58  richard
 *  The stack crawler no longer fixes link registers outside the from space.
 *
 *  Revision 1.38  1992/05/22  10:50:05  clive
 *  Some code in the stack reversal had not been updated
 *
 *  Revision 1.37  1992/05/20  15:21:15  richard
 *  Reworked stack_crawl() to eliminate non-determinism due to interrupts.
 *
 *  Revision 1.36  1992/05/15  14:34:34  clive
 *  Added timers and code for compiling the make system
 *
 *  Revision 1.35  1992/05/13  13:11:11  clive
 *  Added code to allow memory profiling
 *
 *  Revision 1.34  1992/04/10  13:31:38  clive
 *  ++i<=weak_table_size should have been ++i<weak_table_size
 *
 *  Revision 1.33  1992/04/10  11:16:30  clive
 *  Weak roots code had a reference to root_table instead of weak_table
 *
 *  Revision 1.32  1992/04/09  13:41:54  clive
 *  in the realloc of the weak_root_table there was a type - the new size was root_table_size
 *  and not weak
 *
 *  Revision 1.31  1992/04/07  07:44:28  richard
 *  Corrected the loop which changes the typemap in gc_space().
 *
 *  Revision 1.30  1992/04/06  09:40:39  richard
 *  Added weak root code.  Changed fixup to use a uniform evacuation
 *  marker.  GC stats now include GC time.
 *
 *  Revision 1.29  1992/04/03  10:40:47  richard
 *  Added hook to machine specific fixup() routine.
 *
 *  Revision 1.28  1992/04/01  08:56:09  richard
 *  Added an instruction to fix the new `argument' field of the ml_state.
 *
 *  Revision 1.27  1992/03/25  15:47:45  richard
 *  Added `inline' extension and a register windows flush iff compiling using
 *  GNU C.  (See Makefile and interface.s.)
 *
 *  Revision 1.26  1992/03/24  16:01:57  richard
 *  Improved pointer fixing routine and scan.  Added code to write statistics
 *  to a stream.
 *
 *  Revision 1.25  1992/03/19  16:44:16  richard
 *  Generation sizes are fetched from arrays defined in mem.h rather than
 *  calculated by macros.
 *
 *  Revision 1.24  1992/03/17  12:15:53  richard
 *  Changed gc() to accept zero parameter meaningfully.  See gc.h.
 *
 *  Revision 1.22  1992/03/12  11:50:46  richard
 *  Major revision: generations are now generalized to contain any number
 *  of spaces.  This improved entry list performance and allows a more
 *  flexible approach to squashing and promoting.  New and useful message
 *  output including debugging also added.
 *
 *  Revision 1.20  1992/03/05  10:14:51  richard
 *  When collecting into an occupied generation the to_space is no longer
 *  scanned right from the beginning of the semispace but from wherever
 *  the new data started.
 *
 *  Revision 1.19  1992/02/27  10:58:11  clive
 *  Needed a check for the gc_message_level before printing s and o
 *
 *  Revision 1.18  1992/02/26  17:25:20  clive
 *  I think we needed 4 to get past the header in SCAN
 *
 *  Revision 1.17  1992/02/26  11:30:58  richard
 *  Subtracted space required from heap start.
 *
 *  Revision 1.16  1992/02/25  16:35:51  clive
 *  Added val_print in the System structure in ML
 *
 *  Revision 1.15  1992/02/19  12:06:04  richard
 *  Changed the value placed in the forward link of `old' arrays to
 *  MLINT(1) so that it is not fixed during scans.
 *
 *  Revision 1.14  1992/02/18  11:06:44  clive
 *  Needed to double_align in gc - heap-start became unaligned
 *
 *  Revision 1.13  1992/01/27  14:30:17  richard
 *  Rewrote garbage collector controller.  The garbage collector now uses
 *  an algorithm that allows for an arbitrary number of generations.  Also,
 *  implemented entry tables for array update.
 *
 *  Revision 1.12  1992/01/20  15:54:19  richard
 *  Shifted diagnostic levels of the code that's pretty stable up to 4.
 *  Wrote entry list scanning and collecting code, as yet untested.
 *
 *  Revision 1.11  1992/01/16  14:39:05  richard
 *  Fixed a bug when skipping strings in the SCAN macro.
 *  Unified the representation of ARRAYs and REFs.
 *
 *  Revision 1.10  1992/01/15  12:13:29  richard
 *  Modified stack_crawl() so that it can find its way back across
 *  stack extensions.
 *
 *  Revision 1.9  1992/01/14  16:18:13  richard
 *  Reworked virtually everything.  It almost works!
 *
 *  Revision 1.8  1992/01/08  11:25:56  richard
 *  Added diagnostics and started to fix the stack crawling routine.  The
 *  new version doesn't yet cope with raw spill sizes.
 *
 *  Revision 1.7  1991/12/23  13:18:43  richard
 *  Changed the calls to runtime_error() to error() to preserve uniqueness of
 *  external symbols.
 *
 *  Revision 1.6  91/12/20  17:16:29  richard
 *  Added a missing `void'.  Changed crash and diagnostic output to
 *  fit in with the rest of the system.
 *
 *  Revision 1.5  91/12/17  17:23:55  nickh
 *  added header and comment.
 */


#include "ansi.h"
#include "diagnostic.h"
#include "types.h"
#include "mltypes.h"
#include "tags.h"
#include "values.h"
#include "mem.h"
#include "arena.h"
#include "state.h"
#include "loader.h"
#include "utils.h"
#include "implicit.h"
#include "gc.h"
#include "extensions.h"
#include "interface.h"
#include "profiler.h"
#include "fixup.h"
#include "stacks.h"
#include "pervasives.h"
#include "mltime.h"
#include "cache.h"
#include "exec_delivery.h"
#include "event.h"
#include "explore.h"
#include "global.h"

#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <errno.h>

/* Define this to be 1 if you want to allow crestion to be resized */
#define RESIZE_CREATION 0

/* if you want the GC to go a tiny bit faster, and don't care about
debuggability or code size, redefine this macro to be 'inline' */

#define gc_decl

FILE *gc_stat_stream = NULL;
double gc_clock = 0;
int in_GC = 0;

struct ml_heap *creation = NULL;
static unsigned int collections = 0;

static unsigned int do_stack_crawl = 0;
static unsigned int do_split_collection = 0;

#ifdef DEBUG
int analyse_creation_space = 0;
mlval *analyse_creation_start = NULL;
#endif

#ifdef COLLECT_STATS
size_t max_heap_size = 0;
#endif

/*#define CULPRIT_ANALYSIS*/
#ifdef CULPRIT_ANALYSIS
#define CULPRIT_LEVEL 0
#define CULPRIT_SIZE 0
#define CULPRIT_START(to,level,msg,arg)					\
				mlval *culprit_start = to;		\
				DIAGNOSTIC(CULPRIT_LEVEL+level,		\
					   (msg ", to = 0x%08x"),arg,to);
#define CULPRIT_SCAN(to,level,msg,arg)					\
				scan(culprit_start,to,to);		\
				if (to-culprit_start > CULPRIT_SIZE) {	\
				  DIAGNOSTIC(CULPRIT_LEVEL+level,	\
					     (msg ", to = 0x%08x"),arg,to); \
				}					\
				culprit_start = to;
#else
#define CULPRIT_START(to,level,msg,arg)
#define CULPRIT_SCAN(to,level,msg,arg)
#endif

/*  === GARBAGE COLLECTOR PARAMETERS ===
 *
 *  GEN_VALUES is the soft limit on the number of values in a generation.
 *
 *  MAX_NR_GENS is the number of generations which may exist before they
 * start getting merged together.
 * 
 *  CREATION_SIZE is the limit on the number of bytes in generation 0
 *  (the creation space) and determines the frequency of calls to the
 *  garbage collector.  It also determines the minimum size of `large'
 *  objects.
 */

#define GEN_VALUES	(SPACE_SIZE)
#define MAX_NR_GENS	100

#define CREATION_SIZE	0x100000

static size_t creation_size = CREATION_SIZE;
#if RESIZE_CREATION
static size_t min_creation_size = CREATION_SIZE;
static size_t max_creation_size = 16 * CREATION_SIZE;
#endif

/*  == Collection frequency ==
 *
 *  This frequency determines how vigorously the garbage collector tries to
 *  free memory.  It is calculated by think() and declared here so that it
 *  can be included in various messages.
 */

static float frequency;

/*  === Messages and statistical output ===
 *
 *  gc_message() and gc_message_end() write messages to the message
 *  stream.  The message, in the format of printf(), is output
 *  provided the level is greater than the gc_message_level.  When
 *  collecting generations the generation number is used as the message
 *  level, so messages only show up for collections involving generations
 *  greater or equal to the -c option parameter.
 *
 *  gc_statistics() writes information about the residence of generations to
 *  a stream.
 */

static int message_printed;
static int message_level;	/* cached version of gc_message_level */

static void gc_message(int level, const char *format, ...)
{
  va_list arg;

  if((message_level >= 0 && level >= message_level) ||
     (message_level < 0  && level >= -1-message_level))
  {
    va_start(arg, format);

    if(!message_printed)
    {
      message_start();
      message_content("Collection ");
      message_printed = 1;
    }

    vmessage_content(format, arg);
    va_end(arg);
  }
}

#ifdef COLLECT_STATS

static gc_decl void update_max_heap_size(void)
{
  if (arena_extent > max_heap_size)
    max_heap_size = arena_extent;
}

#endif

static gc_decl void gc_message_end(double time, unsigned int modified)
{
#ifdef COLLECT_STATS
  update_max_heap_size();
#endif

  if(message_printed)
  {
    message_content("%lums, %uMb", (long)(time/(double)1000), arena_extent>>20);

    if(message_level < 0)
    {
      struct ml_heap *gen;

      message_content(", %1.2f\n"
	      "   gen  coll    resident      extent  "
	      "     limit  entry static", frequency);

      for(gen = creation; gen != NULL; gen = gen->parent)
	message_content("\n  %4d  %1.2f  %10u  %10u  %10u  %5u  %5u",
		gen->number, gen->collect,
		gen->top - gen->start,
		gen->end - gen->start,
		gen->values,
		gen->nr_entries, gen->nr_static);

    }

    message_end();
  }
}

static gc_decl void gc_statistics(FILE *stream, double time, int collected)
{
  if(stream != NULL)
  {
    struct ml_heap *gen;

    fprintf(stream, "time %.0f collected %d\n", time, collected);

    for(gen=creation; gen!=NULL; gen=gen->parent)
      fprintf(stream, "  generation %d resident %u extent %u entry %u static %u\n",
	      gen->number, gen->top - gen->start, gen->end - gen->start,
	      gen->nr_entries, gen->nr_static);
  }    
}

#ifdef DEBUG

/* Code to analyse heap-allocated values. We scan through an area of
 * heap, counting headers and different kinds of data. */

/* First, a macro to tell the size in bytes of an object, taking
 * as arguments the length and secondary tag fields of the header word. */

#define objsize(l,s)  ((s == RECORD || s == CODE) ?		\
		       double_align((l+1)<<2) :			\
		       ((s == STRING || s == BYTEARRAY) ?	\
		        double_align(l+4) : 			\
		        ((s == ARRAY || s == WEAKARRAY) ?	\
		         double_align((l+3)<<2) :		\
		         (error ("bad header %x %x\n",l,s),0))))

/* Now some arrays and headers */

/* We subscript into these arrays with bits 5-3 of header words, and
 * have a fake slot at the end in which we record pairs (which don't
 * have headers).
 * 
 * ml_objects[n] is the number of objects seen.
 * ml_sizes[n] is their total size in bytes.
 */

#define OBJECTS_TO_COUNT 9
#define FAKE_HEADER_FOR_PAIRS 8

static size_t ml_objects[OBJECTS_TO_COUNT], ml_sizes[OBJECTS_TO_COUNT];

/* ml_total is the number of bytes scanned.
 * ml_pointers is the number of pointers found.
 * ml_integers is the number of integers found.
 * ml_headers is the number of headers found.
 * ml_ref_cells is the number of ref cells (i.e. arrays size 1)
 * ml_code_items is the number of code items (i.e. parts of code vectors)
 * ml_code_ancill is the size of the ancillary information (not counting names)
 * ml_code_names is the size of the code names
 */

static size_t ml_total, ml_headers, ml_pointers, ml_integers;
static size_t ml_ref_cells, ml_code_items, ml_code_ancill, ml_code_names;


#ifdef COUNT_IMPLICITS

/* As an example of how to extend the heap analysis to count code
   idioms, here we also count implicit vector lookups: */

#define IMPLICIT_ENTRIES 16
static size_t ml_implicit[IMPLICIT_ENTRIES];
static size_t ml_implicits;

#endif /* COUNT_IMPLICITS */

/* for printing the report, we might well not be interested in (say)
 * bytearrays, and we might want a certain order, so we have a macro
 * and an array to make these things easy to customize:
 *
 * OBJECTS_TO_PRINT is the total number of columns we print.
 * ml_to_print[n] is the order in which to print them.
 * ml_names[n] is the name of object type n (11 characters).
 * 
 * Each column is 11 characters wide. 
 */

#define OBJECTS_TO_PRINT 7

static int ml_to_print[OBJECTS_TO_PRINT] = {5,0,FAKE_HEADER_FOR_PAIRS,1,2,7,3};

/* order: code, records, pairs, strings, arrays, weakarrays, bytearrays */

static const char *ml_names[OBJECTS_TO_COUNT] = {
  "    records",
  "    strings",
  "     arrays",
  " bytearrays",
  "   backptrs",
  "       code",
  "   header50",
  " weakarrays",
  "      pairs"};

/* A function to zero all the counters */

static void heap_analysis_zero(void)
{
  int i;

  for (i=0; i<OBJECTS_TO_COUNT; i++)
    ml_objects[i] = ml_sizes[i] = 0;
  ml_total = ml_headers = ml_ref_cells = ml_code_items =
    ml_code_ancill = ml_code_names = 0;

  ml_pointers = ml_integers = 0;

#ifdef COUNT_IMPLICITS

  for(i=0; i < IMPLICIT_ENTRIES; i++)
    ml_implicit[i] = 0;
  ml_implicits = 0;

#endif /* COUNT_IMPLICITS */

}  

/* the function which counts integers and pointers in a record */
static void heap_analysis_count_pointers(mlval *start, mlval *end)
{
  while(start < end) {
    mlval value = *start;
    if (MLVALISPTR(value))
      ++ ml_pointers;
    else
      ++ ml_integers;
    ++ start;
  }
}

/* The function which scans heap areas (generations or static objects),
 * keeping all the different running totals */

static void heap_analysis_count(mlval *start, mlval *end)
{
  ml_total += ((end-start)<<2);

  while(start < end)
  {
    mlval value = *start;	/* get the header word */
    
    switch(PRIMARY(value)) {
    case HEADER:
      {
	int length = LENGTH(value);
	int secondary = SECONDARY(value);
	int size = objsize(length,secondary);
	int index = secondary >> 3; /* bits 5-3, index into our arrays */
	++ ml_headers;
	++ ml_objects[index];
	ml_sizes[index] += size;

	switch (secondary) {	/* add up any special totals */
	case CODE:
	  {
	    mlval ancillaries = *(start+1);
	    mlval name_record = FIELD(ancillaries,0);
	    int items = (PRIMARY(name_record) == PAIRPTR ? 2 :
			 LENGTH(GETHEADER((name_record))));
	    int i;
	    ++ ml_pointers; /* ancillary pointer */
	    ml_code_items += items;
	    
	    for(i=0; i<items; i++) { /* add up the code name lengths */
	      mlval name = FIELD(name_record,i);
	      mlval header = GETHEADER(name);
	      ml_code_names += double_align(LENGTH(header)+4);
	    }
	    ml_code_ancill += 8;	/* ancillary record */
	    if (items == 2)	/* then name and profile records are pairs */
	      ml_code_ancill += 16;
	    else			/* they are records */
	      ml_code_ancill += (double_align(4+(items<<2))) * 2;
	    
	    if (PRIMARY(ancillaries) != PAIRPTR) { /* then intercepting */
	      ml_code_ancill += 8; /* the ancillary record is a triple */
	      ml_code_ancill += double_align(12+(items<<2));
	      /* the interfn array size */
	    }

#ifdef COUNT_IMPLICITS

	    {
	      mlval *ptr = start, *end = (mlval *)(((int)start) + size);
      
	      for (; ptr < end; ptr++) {
		mlval instr = *ptr;
		if ((instr & 0xc1ffe000) == 0xc0016000) {
		  ml_implicits ++;
		  ml_implicit[(instr & (IMPLICIT_ENTRIES-1))>>2] ++;
		}
	      }
	    }

#endif /* COUNT_IMPLICITS */

	  }
	  break;
	  
	case ARRAY:
	  heap_analysis_count_pointers(start+3, start+3+length);
	  if (length == 1)
	    ++ml_ref_cells;
	  break;
	case RECORD:
	  heap_analysis_count_pointers(start+1, start+length+1);
	  break;
	case WEAKARRAY:
	  heap_analysis_count_pointers(start+3, start+length+3);
	  break;
	}
	start = (int*)(((int)start) + size);
	break;
      }

    case INTEGER0:
    case INTEGER1:
    case POINTER:
    case PAIRPTR:
    case REFPTR:
      heap_analysis_count_pointers(start, start+2);
      start += 2;
      ml_sizes[FAKE_HEADER_FOR_PAIRS] += 8;
      ml_objects[FAKE_HEADER_FOR_PAIRS] ++;
      break;
    default:
      error ("bad value %x\n",value);
    }
  }
}

/* print the results */

static void heap_analysis_results(void)
{
  int i;

#define heap_percentage(n) ((double)(n)*(double)100/(double)(ml_total))

  if (ml_total == 0) 
    message("End of heap analysis; no values analysed");
  else {
    size_t total_objects = ml_objects[FAKE_HEADER_FOR_PAIRS]+ml_headers;
    message_start();
    message_content("Heap analysis results:\n\n");
    message_content("total: %u headers: %u\n",ml_total,ml_headers);
    
    for (i=0;i<OBJECTS_TO_PRINT;i++)
      message_content("%s",ml_names[ml_to_print[i]]);
    message_content("\n");
    
    for (i=0;i<OBJECTS_TO_PRINT;i++)
      message_content("%11u",ml_objects[ml_to_print[i]]);
    message_content("\n");
    
    for (i=0;i<OBJECTS_TO_PRINT;i++)
      message_content("%11u",ml_sizes[ml_to_print[i]]);
    message_content("\n ");
    
    for (i=0;i<OBJECTS_TO_PRINT;i++)
      message_content("     %5.2f%%",
		      heap_percentage(ml_sizes[ml_to_print[i]]));
    message_content("\n\n");
    
    message_content("ref cells: %u code items: %u\n",
		    ml_ref_cells,ml_code_items);
    message_content("ancillary info: %u (%5.2f%%)",
		    ml_code_ancill,heap_percentage(ml_code_ancill));
    message_content(" code names: %u (%5.2f%%)\n",
		    ml_code_names,heap_percentage(ml_code_names));

    message_content("\n");
    message_content(" pointers %u, integers %u, objects %u\n",
		    ml_pointers, ml_integers, total_objects);
    message_content(" average object size %.2f, pointers/object %.2f\n",
		    ((double)ml_total)/total_objects,
		    ((double)ml_pointers)/total_objects);
		    

#ifdef COUNT_IMPLICITS

    message_content("implicit loads : %u\n[",ml_implicits);
    for(i=0;i<IMPLICIT_ENTRIES;i++)
      message_content("%4u ",ml_implicit[i]);
    message_content("]\n");

#endif /* COUNT_IMPLICITS */
    message_end();
  }
}

/* a function to analyse the whole heap and print the results. */
  
static void analyse_heap(void)
{
  struct ml_heap *gen;

  heap_analysis_zero();

/* count everything */

  for(gen = creation; gen != NULL; gen = gen->parent) {
    struct ml_static_object *stat = gen->statics.forward;

    while(stat != &gen->statics) {
      mlval header = stat->object[0];
      mlval secondary = SECONDARY(header);
      mlval length = LENGTH(header);
      mlval *base = &stat->object[0];
      mlval *top = (mlval*)(((byte*)base) + OBJECT_SIZE(secondary,length));
      heap_analysis_count(base, top);
      stat = stat->forward;
    }
    heap_analysis_count(gen->start, gen->top);
  }

  heap_analysis_results();
}

#endif

/*  === LOW LEVEL COLLECTION ===
 *
 *  This code deals with copying individual objects around, fixing pointers,
 *  scanning areas of memory, and crawling the stack.
 */

/* static_generation(value) gives the generation of the static object
 * pointed to by value. Note that during a collection, static objects
 * of the 'from' generation apparently belong to the 'to' generation
 * (this is to prevent them being moved onto the 'from' generation's
 * entry list). */

static gc_decl struct ml_heap *static_generation(mlval value)
{
  mlval *obj = OBJECT(value);
  if (PRIMARY(value) == POINTER) {
    /* then we might have a back-pointer or a shared closure */
    mlval header = *obj;
    /* this is valid because 'value' can't be a pair */
    while (header == 0) {
      obj -= 2;
      header = *obj;
    }
    if (SECONDARY(header) == BACKPTR)
      obj = (mlval*)((word)obj - LENGTH(header));
  }
  return STATIC_HEADER(obj)->gen;
}

/*  == Weak fix: Possibly collect one object ==
 *
 *  weak_fix() is a variant of fix which only fixes up a pointer if the
 *  object it references has already been fixed.  It is used to fix the
 *  contents of weak arrays after other fixes have occurred.  A pointer
 * which refers to an unfixed (dead) object is annulled to DEAD. */

static gc_decl void weak_fix(mlval *what)
{
  mlval *object;
  mlval value, header;
  int type;

  value = *what;

  /* If it's not a pointer it can't die. */

  if(!MLVALISPTR(value))
    return;

  object = OBJECT(value);
  type = SPACE_TYPE(value);

  /* If it cannot be in from-space, it can't have died */

  if (type != TYPE_FROM && type != TYPE_ML_STATIC)
    return;

  /* Find the actual header */

  header = object[0];

  if (PRIMARY(value) == POINTER) {
    /* then we might have a shared closure or a backptr */
    while (header == 0) { /* shared closure */
      object -= 2;
      header = object[0];
    }
  
    if (SECONDARY(header) == BACKPTR) {
      object = (mlval*)((word)object - LENGTH(header));
      header = object[0];
    }
  } 
  
  if (type == TYPE_ML_STATIC) { /* is it still marked? */
    if (STATIC_HEADER(object)->mark)
      *what = DEAD;
  } else {			/* has it been evacuated? */
    if (header == EVACUATED)
      *what = ((word)OBJECT(value) - (word)object)+object[1];
    else
      *what = DEAD;
  }
}

/*  === ARRAYS, ENTRY LISTS, AND STATIC OBJECTS ===
 *
 *  Certain objects need special treatment.  This code deals with arrays
 *  (which may point to objects younger than themselves), weak arrays (whose
 *  contents may die) and static objects (which are collected by
 *  mark-and-sweep).
 */


/*  == Garbage collect entry lists ==
 *
 *  This function is called after the objects in a generation are collected,
 *  but while the generation memory is still marked as TYPE_FROM.  It scans
 *  the entry lists of all generations and deletes any arrays which reside
 *  in TYPE_FROM.
 */

static gc_decl void sweep_entry_lists(void)
{
  struct ml_heap *gen;

  DIAGNOSTIC(4, "sweep_entry_lists()", 0, 0);

  for(gen=creation; gen!=NULL; gen=gen->parent)
  {
    union ml_array_header *array = gen->entry.the.forward;
    unsigned int count = 0;

    DIAGNOSTIC(4, "  generation 0x%X (%d)", gen, gen->number);

    while(array != &gen->entry)
    {
      int type = SPACE_TYPE(array);
      struct ml_static_object *stat = STATIC_HEADER(array);

      if(type == TYPE_FROM || (type == TYPE_ML_STATIC && stat->mark))
      {
	DIAGNOSTIC(4, "    deleting array 0x%X", array, 0);

	array->the.forward->the.back = array->the.back;
	array->the.back->the.forward = array->the.forward;
      }
      else
      {
	++count;
	DIAGNOSTIC(4, "    keeping array 0x%X", array, 0);
      }

      array = array->the.forward;
    }

    gen->nr_entries = count;
  }
}

/* See if the value is in the given generation */
extern int live_in_gen(struct ml_heap *gen, mlval *value)
{
  return (SPACE_TYPE(value) == TYPE_ML_STATIC ||
	  (value >= gen->start && value < gen->top));
}

#define collectable(value) ((SPACE_TYPE(value) == TYPE_ML_STATIC) || \
			    (SPACE_TYPE(value) == TYPE_ML_HEAP) || \
			    (SPACE_TYPE(value) == TYPE_FROM))

/*  == Fix normal arrays on entry lists ==
 *
 *  This function scans all the arrays on the entry list of a generation,
 *  fixing their contents.  It also makes sure that the arrays are in the
 *  right entry list by working out the youngest value pointed to.  The
 *  parameter is the generation for which the list should be fixed.
 */

static gc_decl mlval *fix_entry_list(struct ml_heap *gen, mlval *to)
{
  union ml_array_header *array = gen->entry.the.forward;
  CULPRIT_START(to,1,"fixing entry list for gen %d",gen->number);

  DIAGNOSTIC(4, "fix_entry_list(gen = 0x%X, to = 0x%X):", gen, to);

  while(array != &gen->entry)
  {
    if(SECONDARY(array->the.header) == ARRAY)
    {
      size_t i, length = LENGTH(array->the.header);
      struct ml_heap *youngest_gen = GENERATION(array);
      int array_nr = youngest_gen->number;
      int youngest_nr = array_nr;
      union ml_array_header *next;

      DIAGNOSTIC(4, "  array at 0x%lX (gen %d)", array, array_nr);
      DIAGNOSTIC(5, "    header 0x%lX", array->the.header, 0);
      DIAGNOSTIC(5, "    forward 0x%lX back 0x%lX", array->the.forward, array->the.back);
      DIAGNOSTIC(5, "    scanning 0x%lX to 0x%lX", &array->the.element[0], &array->the.element[length]);

      for(i=0; i<length; ++i)
      {
	mlval value = array->the.element[i];

	if(MLVALISPTR(value) && collectable(value)) {
	  struct ml_heap *this_gen;
	  int this_nr;
	  fix(to, &array->the.element[i]);
	  CULPRIT_SCAN(to,1, "after fixing array element at 0x%08x",
		       &array->the.element[i]);
	  value = array->the.element[i];		/* is still a ptr */
	  if (SPACE_TYPE(value) == TYPE_ML_STATIC)
	    this_gen = static_generation(value);
	  else
	    this_gen = space_gen[SPACE(value)];
	  this_nr = this_gen->number;
	  
	  if(this_nr < youngest_nr) {
	    youngest_nr = this_nr;
	    youngest_gen = this_gen;
	  }
	}
      }

      /* Fetch the (possibly fixed) pointer to the next array in the list */
      /* before it gets mangled by moving the array to another generation. */

      next = array->the.forward;

      /* If the youngest object referenced is in the same or an older */
      /* generation then the array can be taken off the list as it does */
      /* not refer to younger data. */

      if(youngest_nr == array_nr)
      {
	DIAGNOSTIC(4, "    disconnecting from entry list", 0, 0);

	array->the.back->the.forward = array->the.forward;
	array->the.forward->the.back = array->the.back;
	array->the.forward = (union ml_array_header *)MLINT(1);
	array->the.back    = NULL;
      }

/* We have to move the array to a different entry list if the
 * generations are distinct. n.b. youngest_gen != gen (the condition
 * we want) can be true even when youngest_nr == gen->number, when
 * collecting a generation in place (see inplace_collect()).  */

      else if(youngest_gen != gen)
      {
	DIAGNOSTIC(4, "    moving to list for generation %d", youngest_nr, 0);
	
	/* Disconnect the array from this list */
	array->the.back->the.forward = array->the.forward;
	array->the.forward->the.back = array->the.back;

	/* Insert into the entry list */
	/* for the youngest generation referred to */
	array->the.forward = youngest_gen->entry.the.forward;
	array->the.back    = &youngest_gen->entry;
	array->the.forward->the.back = array;
	array->the.back->the.forward = array;
      }

      array = next;
    }
    else
      array = array->the.forward;
  }

  return(to);
}

/*  == Fix weak arrays on entry lists ==
 *
 *  This function scans all the weak arrays on an entry list, fixing any
 *  fixed contents and killing any others.  It also makes sure that the
 *  arrays are in the right entry list by working out the youngest value
 *  pointed to.  The parameter is the generation for which the list should
 *  be fixed.
 *
 *  NOTE: Weak arrays are never taken off entry lists.
 */

static gc_decl void weak_fix_entry_list(struct ml_heap *gen)
{
  union ml_array_header *array = gen->entry.the.forward;

  DIAGNOSTIC(4, "weak_fix_entry_list(gen = %d):", gen, 0);

  while(array != &gen->entry)
  {
    if(SECONDARY(array->the.header) == WEAKARRAY)
    {
      size_t i, length = LENGTH(array->the.header);
      struct ml_heap *youngest_gen = GENERATION(array);
      int array_nr = youngest_gen->number;
      int youngest_nr = array_nr;
      union ml_array_header *next;

      DIAGNOSTIC(4, "  weak array at 0x%lX (gen %d)", array, array_nr);
      DIAGNOSTIC(5, "    header 0x%lX", array->the.header, 0);
      DIAGNOSTIC(5, "    forward 0x%lX back 0x%lX", array->the.forward, array->the.back);
      DIAGNOSTIC(5, "    scanning 0x%lX to 0x%lX", &array->the.element[0], &array->the.element[length]);

      for(i=0; i<length; ++i)
      {
	mlval value = array->the.element[i];

	if(MLVALISPTR(value) && collectable(value)) {
	  weak_fix(&array->the.element[i]);
	  value = array->the.element[i];
	  if(value != DEAD) {
	    struct ml_heap *this_gen;
	    int this_nr;
	    if (SPACE_TYPE(value) == TYPE_ML_STATIC)
	      this_gen = static_generation(value);
	    else
	      this_gen = space_gen[SPACE(value)];
	    this_nr = this_gen->number;
	    
	    if(this_nr < youngest_nr) {
	      youngest_nr = this_nr;
	      youngest_gen = this_gen;
	    }
	  }
	}
      }

      next = array->the.forward;

/* see comment in fix_entry_list, above */

      if(youngest_gen != gen)
      {
	DIAGNOSTIC(4, "    moving to list for generation %d", youngest_nr, 0);

	array->the.back->the.forward = array->the.forward;
	array->the.forward->the.back = array->the.back;

	array->the.forward = youngest_gen->entry.the.forward;
	array->the.back    = &youngest_gen->entry;
	array->the.forward->the.back = array;
	array->the.back->the.forward = array;
      }

      array = next;
    }
    else
      array = array->the.forward;
  }
}

/*  == Move modified array list ==
 *
 *  Newly created or modified arrays are placed on a singly-linked
 *  list by ML.  The first array on the list is at GC_MODIFIED_LIST.
 *  This function scans this list and moves arrays which are not in
 *  the creation space, and weak arrays, onto the entry list of the
 *  creation space (generation 0) where they are guaranteed to be
 *  fixed up properly by subsequent garbage collection, and will be
 *  moved to the correct entry list by fix_entry_list().
 *
 * The modified list is a singly-linked list using the backward
 * pointers as links. We scan this and thread the arrays we want to
 * keep onto the creation entry list, discarding the others */

static gc_decl size_t move_modified_list(void)
{
  union ml_array_header *array = GC_MODIFIED_LIST;
  union ml_array_header *kept = creation->entry.the.forward;
  size_t length = 0;
  unsigned int creation_space = creation->space;

    DIAGNOSTIC(4, "move_modified_list() starting at 0x%lX", array, 0);

  /* invariants:
     - 'array' points to the rest of the modified list.
     - 'kept' points to the finished creation space entry list
       (except 'kept->the.back' is undetermined). */

  while (array != NULL) {
    union ml_array_header *next = array->the.back;
    length++;
    if (SPACE(array) == creation_space &&
	SECONDARY(array->the.header) != WEAKARRAY) {
      array->the.forward = (union ml_array_header *)MLINT(1);
      array->the.back    = NULL;
    } else {
      kept->the.back = array;
      array->the.forward = kept;
      kept = array;
    }
    array = next;
  }

  kept->the.back = &creation->entry;
  creation->entry.the.forward = kept;
  GC_MODIFIED_LIST = NULL;

  DIAGNOSTIC(4, "  %u modified arrays", length, 0);

  return length;
}  

/*  == Mark static objects in a space ==
 *
 *  Sets the mark word of all static objects in the 'from' generation,
 * and moves them to the 'to' generation, so that when pointers to
 * them are fixed in arrays, the 'from' generation does not remain as
 * their apparent generation. */

static gc_decl void mark_static_objects(struct ml_heap *from, struct ml_heap *to)
{
  struct ml_static_object *stat;

  DIAGNOSTIC(4, "mark_static_objects(from = 0x%08x, to = 0x%08x)", from, to);

  for(stat = from->statics.forward;
      stat != &from->statics;
      stat = stat->forward)
  {
    DIAGNOSTIC(6, "  marking object at 0x%X", stat, 0);
    stat->mark = 1;
    stat->gen = to;
  }
}


/*  == Sweep static objects in a generation ==
 *
 *  Deallocates all static objects `in' a space whose mark words have not
 *  been changed since they were marked, and relinks the others onto the
 *  list of the to space.
 */

static gc_decl void sweep_static_objects(struct ml_heap *from, struct ml_heap *to)
{
  struct ml_static_object *stat = from->statics.forward;

  DIAGNOSTIC(4, "sweep_static_objects(from = 0x%X, to = 0x%X)", from, to);

  while(stat != &from->statics) {
    struct ml_static_object *next = stat->forward;

    if(stat->mark) {
      DIAGNOSTIC(5, "  deallocating static object at 0x%X (mark = %d)", stat, stat->mark);
      unmake_static_object(stat);

    } else {

      DIAGNOSTIC(5, "  collecting static object at 0x%X (mark = %d)", stat, stat->mark);
      stat->forward = to->statics.forward;
      stat->back = &to->statics;
      stat->forward->back = stat;
      stat->back->forward = stat;
      ++to->nr_static;
    }

    stat = next;
  }

  from->statics.forward = &from->statics;
  from->statics.back = &from->statics;
  from->nr_static = 0;
}

static gc_decl mlval *scan_static_objects(struct ml_heap *gen, mlval *to)
{
  struct ml_static_object *stat;
  CULPRIT_START(to,1,"scanning static objects in generation %d", gen->number);

  for(stat = gen->statics.forward;
      stat != &gen->statics;
      stat = stat->forward) {
    mlval header = stat->object[0];
    mlval secondary = SECONDARY(header);
    mlval length = LENGTH(header);
    mlval *base = &stat->object[0];
    mlval *top = (mlval*)(((byte*)base) + OBJECT_SIZE(secondary,length));
    
    DIAGNOSTIC(4, "  scanning static object 0x%X to 0x%X", base, top);
    scan(base, top, to);
    CULPRIT_SCAN(to,1,"after scanning static object from 0x%08x", base);
  }
  return to;
}

/*  === C ROOTS: VALUES NOT VISIBLE FROM ML ===
 *
 *  Each C root is a pointer to an ML value which needs to be fixed up
 *  when a GC occurs.  The roots are stored as a closed hash table of
 *  pointers to ML values.  */

typedef struct root {
  mlval *root;
  int live_for_image_save;
} root_struct;
  
static  root_struct *roots = NULL;
static size_t root_table_size = 0;
static size_t root_table_live = 0;

/* how to hash */

#define HASH_PAGE_BITS1		10
#define HASH_PAGE_BITS2		20

/* when to resize the hash table: growth, shrinkage */
/* Note that these numbers, and the FACTORs below, must be chosen with
 * care to avoid rehashing too often */

#define HASH_GROW_FRACTION	2
#define HASH_SHRINK_FRACTION	8

/* what size to make the hash table: initial, growth, shrinkage */

#define INITIAL_HASH_SIZE	128
#define HASH_GROW_FACTOR	2
#define HASH_SHRINK_FACTOR	2

#define HASH_GROW		(root_table_size ?			\
				 root_table_size * HASH_GROW_FACTOR :	\
				 INITIAL_HASH_SIZE)

#define HASH_SHRINK		(root_table_size / HASH_SHRINK_FACTOR)

static inline int root_hash(mlval *root)
{
  word hash = (word) root;
  hash = hash ^ (hash >> HASH_PAGE_BITS1) ^ (hash >> HASH_PAGE_BITS2);
  hash &= (root_table_size-1);
  return (hash);
}

static gc_decl void store_root(mlval *root, int live_for_image_save)
{
  int hash = root_hash(root);
  while (roots[hash].root != NULL)
    hash = (hash+1) & (root_table_size-1);
  roots[hash].root = root;
  roots[hash].live_for_image_save = live_for_image_save;
}

static gc_decl void rehash(size_t size)
{
  root_struct *old_roots = roots;
  size_t old_table_size = root_table_size;
  size_t i;

  root_table_size = size;

  roots = (root_struct *)alloc(sizeof(root_struct) * root_table_size,
			       "Unable to allocate root table");

  DIAGNOSTIC(4,"rehashing root table to size %d with %d live",
	     root_table_size,root_table_live);

  for(i=0;i<root_table_size;i++)
    roots[i].root = NULL;

  for (i=0;i<old_table_size;i++) {
    mlval *root = old_roots[i].root;
    if (root) store_root(root, old_roots[i].live_for_image_save);
  }
  if (old_roots) free(old_roots);
}

void declare_root(mlval *root, int live_for_image_save)
{
  root_table_live++;
  if (root_table_live * HASH_GROW_FRACTION > root_table_size)
    rehash(HASH_GROW);
  store_root(root, live_for_image_save);
  DIAGNOSTIC(5,"declared root 0x%08x",root,0);
}

void retract_root(mlval *root)
{
  int hash = root_hash(root);
  int old_hash = hash;
  do {
    if (roots[hash].root == root) {
      DIAGNOSTIC(5,"root 0x%08x retracted at hash %d",root,hash);
      roots[hash].root = NULL;
      root_table_live--;
      if (root_table_live * HASH_SHRINK_FRACTION < root_table_size)
	rehash(HASH_SHRINK);
      return;
    }
    hash = (hash+1) & (root_table_size-1);
  } while(hash != old_hash);
  error("Unknown root at 0x%X retracted.", root);
}

static gc_decl mlval *fix_c_roots(mlval *to, int all_roots)
{
  size_t i;
  CULPRIT_START(to,1,"fixing %s","C roots"); 

  DIAGNOSTIC(4, "fix_c_roots(to = 0x%X):", to, 0);

  for(i=0; i<root_table_size; ++i)
    if(roots[i].root != NULL && (all_roots || roots[i].live_for_image_save)) {
      fix(to, roots[i].root);
      CULPRIT_SCAN(to,1,"after fixing root at 0x%08x",roots[i].root);
    }

  return(to);
}

/*  === GENERATIONAL GARBAGE COLLECTION ===
 *
 *  This code deals with the collection of generations and their
 *  organisation.
 */



/*  == Collect a generation ===
 *
 *  This function collects all objects in the `from' generation into the
 *  `to' generation.  It works by marking the source space blocks as
 *  TYPE_FROM and scanning all areas that could be roots: Any object
 *  referenced from any younger generation, the ML stack, the C roots, or
 *  the ML state vector which is also in a memory block marked as a
 *  TYPE_FROM is collected (see fix()).  Static objects in static object list
 *  for the generation are marked by fix().
 *
 *  Then, the arrays on the entry list of the generation and all its
 *  descendants are fixed.  (Remember that arrays are on the entry list of
 *  the _youngest_ generation to which they refer.)
 *
 *  The final stage of this function is scanning the to generation.  This
 *  ensures that all objects recursively referenced from those objects
 *  copied to the generation are fixed.
 *
 *  Generation numbers can get confused due to the temporary
 *  renumbering of generations during a multi-generation
 *  collection. So we pass around the 'actual' generation number of
 *  the 'from' generation.
 *
 *  Afterwards the source space blocks are marked as TYPE_ML_HEAP and the space
 *  is emptied.  */

static gc_decl void collect_gen(struct ml_heap *from, struct ml_heap *to, int number)
{
  struct ml_heap *gen;
  mlval *start = to->top, *next = start;
  mlval *new_start;
  CULPRIT_START(start,1,"before collecting generation number %d", number);

  DIAGNOSTIC(4, "collect_gen from 0x%X to 0x%X", from, to);
  DIAGNOSTIC(4, "  collecting from 0x%X to 0x%lX", from->start, next);

  space_type[from->space] = TYPE_FROM;
  pre_gc_space_profile(from, to, number);
  mark_static_objects(from, to);

  if (do_stack_crawl) {
    stack_crawl_phase_one();
  }
  CULPRIT_SCAN(next,1,"after%s scanning the stack",
	       (do_stack_crawl ? "" : " not"));

  next = fix_c_roots(next, 0); /* Scan only image save roots at this point */
  CULPRIT_SCAN(next,1,"after fixing %s","C roots");
  next = fix_entry_list(from, next);
  CULPRIT_SCAN(next,1,"after fixing %s","the entry list");

  /* This is very conservative: we scan the static objects belonging to
     from-space before we know whether they are live. Ideally this
     would be interleaved with the final scan of to-space. */

  next = scan_static_objects(from, next);
  CULPRIT_SCAN(next,1,"after scanning %s","static objects");

  /* Fix roots and entry lists in younger generations. */

  for(gen = from->child; gen != NULL; gen = gen->child) {
    mlval *top = (gen != creation && do_split_collection) ? gen->image_top : gen->top;

    DIAGNOSTIC(4, "  fixing roots in generation 0x%X (%d)", gen, gen->number);
    scan(gen->start, top, next);
    CULPRIT_SCAN(next,1,"after scanning generation %d", gen->number);
    next = scan_static_objects(gen,next);
    CULPRIT_SCAN(next,1,"after scanning %s","static objects");
    next = fix_entry_list(gen, next);
    CULPRIT_SCAN(next,1, "after fixing entry list for generation %d",
		 gen->number);
  }

  /* finally scan to-space */

  DIAGNOSTIC(4, "  fixing to-space at 0x%lX initially to 0x%lX", start, next);
  scan(start, next, next);
  CULPRIT_SCAN(next,1,"after scanning %s","to-space");

  /* We've now done all required for saving an image */
  /* But we still have to do the work to enable the */
  /* current session to continue */

  /* Start of the second phase */

  DIAGNOSTIC(3, "Starting phase 2 of collect gen", 0, 0);
  to->image_top = next;
  new_start = next; /* Earlier part of to-space already scanned */
  /* Now scan the remaining C roots */
  next = fix_c_roots(next, 1);
  /* Now do the rest of the stack scan */
  if (do_stack_crawl) {
    next = stack_crawl_phase_two(next);
  }

  /* Fix further roots and entry lists in younger generations. */

  if (do_split_collection) {
    for(gen = from->child; gen != NULL; gen = gen->child) {
      mlval *top = gen->top;
      mlval *start = (gen == creation) ? gen->top : gen->image_top;
      DIAGNOSTIC(4, "  fixing roots in generation 0x%X (%d)", gen, gen->number);
      scan(start, top, next);
      CULPRIT_SCAN(next,1,"after scanning generation %d", gen->number);
      next = scan_static_objects(gen,next);
      CULPRIT_SCAN(next,1,"after scanning %s","static objects");
      next = fix_entry_list(gen, next);
      CULPRIT_SCAN(next,1, "after fixing entry list for generation %d",
		   gen->number);
    }
  }

  /* Now scan any new stuff in to-space */
  scan(new_start, next, next);
  /* flush the instruction cache for to-space */
  cache_flush((void*) start, (size_t)((char*)next - (char*)start));

  to->top = next;

  for(gen = from; gen != NULL; gen = gen->child)
    weak_fix_entry_list(gen);

  sweep_entry_lists();
  sweep_static_objects(from, to);
  post_gc_space_profile(from,to, number);

  space_type[from->space] = TYPE_ML_HEAP;

  from->top = from->start;
  from ->image_top = from->start;
}

/* correct the 'nr_entries' slot in a generation to reflect the true
   state of the entry list; used in inplace_collect because the
   to_space there is not in the linked list of generations and so
   doesn't get its nr_entries slot fixed by sweep_entry_lists() during
   collect_gen().*/

static gc_decl void correct_entry_count(struct ml_heap *gen)
{
  union ml_array_header *array = gen->entry.the.forward;
  unsigned int count = 0;

  while(array != &gen->entry) {
    ++count;
    array = array->the.forward;
  }

  gen->nr_entries = count;
}

/* This function collects from a generation into a new generation, in
   the same place in the generation list.

   This should not be used to collect the creation space to a new
   creation space, as it makes a new resized generation with a
   different extent. It can be used to collect the creation space to a
   new generation 1, by changing the number of the created generation
   after calling this */

static gc_decl struct ml_heap *inplace_collect(struct ml_heap *it, int number)
{
  struct ml_heap *new_gen = NULL;
  size_t live = (it->top - it->start)*sizeof(mlval);

  new_gen = make_ml_heap(GEN_VALUES,0);

  new_gen->number = it->number;
  resize_ml_heap(new_gen,live);
  collect_gen(it,new_gen,number);
  resize_ml_heap(new_gen, (new_gen->top - new_gen->start)*sizeof(mlval));

  new_gen->collect = (float)0.0;
  new_gen->child = it->child;
  new_gen->parent = it->parent;

  if (new_gen->child == NULL)
    new_gen->child = creation;
  new_gen->child->parent = new_gen;

  if (new_gen->parent != NULL)
    new_gen->parent->child = new_gen;

/* At this point, new_gen has all the right entries on its entry list,
   but it has not been 'swept', so new_gen->entries is incorrect. */

  correct_entry_count(new_gen);

/* the entry list and static object list for 'it' have been emptied
   during collect_gen() */

  if (it != creation)
    unmake_ml_heap(it);

  return(new_gen);
}

/* Collect  one generation without  affecting the others. Do not apply
   this to the creation space. */

static struct ml_heap *self_collect (struct ml_heap *it)
{
  struct ml_heap *new_gen;
  gc_message(it->number, "inplace %d ", it->number);
  new_gen = inplace_collect(it, it->number);
  return new_gen;
}

/* Renumber all the generations */

static gc_decl void renumber_generations(void)
{
  int number = 0;
  struct ml_heap *gen;
  for (gen = creation; gen != NULL; gen = gen->parent)
    gen->number = number++;
}

/* Insert a generation below a given generation; renumbers all the
   generations; do not apply this to the creation space */

static gc_decl struct ml_heap *insert_gen_below (struct ml_heap *gen)
{
  struct ml_heap *new = make_ml_heap (GEN_VALUES,0);
  new->child = gen->child;
  new->parent = gen;
  new->child->parent = new;
  gen->child = new;
  renumber_generations();
  return new;
}

/* Create a new generation at the top of the chain */

static gc_decl struct ml_heap *make_new_parent(struct ml_heap *gen)
{
  int number = gen->number+1;
  struct ml_heap *parent;
  gc_message(number, "new %d ", number);
  parent = make_ml_heap(GEN_VALUES, 0);
  parent->number = number;
  parent->child = gen;
  gen->parent = parent;
  return parent;
}

/* Remove a generation from the chain.
   Should not be applied to the creation space */

static gc_decl void remove_gen(struct ml_heap *gen)
{
  gen->parent->child = gen->child;
  gen->child->parent = gen->parent;
  unmake_ml_heap(gen);
  renumber_generations();
}

/*  == The generational algorithm ==
 *
 *  This function performs a scan of the generations and decides what to do
 *  with them.  Generations are marked for promotion by setting their
 *  `collect' member to a number not less than 1.0.  This is done if:
 *    1. a generation doesn't have enough room for stuff coming up from a
 *       younger generation, or
 *    2. it is time to promote the generation anyway.
 *  The frequency of timed promotions is calculated using a base frequency
 *  raised to the power of the generation number.  The base is calculated as
 *  the square of the proportion of arena used to that requested when the
 *  storage manager was initialised (using the -size option).
 * 
 *  This algorithm DOES NOT WORK very well. It triggers generation 1
 *  collections at reasonable times, but fails to ever trigger higher
 *  collections (which are always space-forced). This could do with
 *  further work.
 *
 *  If the number of generations exceeds the maximum then generations
 *  are merged together.  This should happen rarely, as there is
 *  little reason to avoid having many generations. */

static gc_decl void think(size_t required)
{
  static size_t arena_extra = 0;
  struct ml_heap *gen, *parent;
  int gen_nr = 0;
  int desire_merge;

  frequency = ((float)6/(float)10) * (float)arena_extent/(float)(arena_limit + arena_extra);
  frequency = frequency*frequency;

  DIAGNOSTIC(2, "Thinking with frequency %1.2f", frequency, 0);

  /* Work out which generations need to be collected, and mark them. */

  for(gen=creation; gen!=NULL; ++gen_nr, gen=gen->parent) {
    size_t live = (gen->top - gen->start)*sizeof(mlval);
    size_t free = gen->values - live;
    
    if(free < required) { /* then we force a collection */
      gen->collect = (float)1;
      required = live;
    } else { /* add to the 'collect' slot */
      gen->collect += (float)(pow((double)frequency, (double)gen->number));
      if (gen->collect >= (float)1) /* then a collection is due */
	required = live;
      else /* we're not collecting this generation */
	required = 0;
    }
    if (gen->parent == NULL && gen->collect >= (float)1) {
      /* create new top generation */
      (void) make_new_parent(gen);
      ++gen_nr;
    }
    
    DIAGNOSTIC(2, "  generation %d  collect %1.2f", gen->number, gen->collect);
    DIAGNOSTIC(2, "    required %u", required, 0);
  }

  /* if we have too many generations, set this flag */
  desire_merge = (gen_nr > MAX_NR_GENS);

  /* Perform the collections. */

  /* Scan up through the generations. If generations n,...,m all need
   * collecting, we collect n,...m-1 "in place". If generation n needs
   * collecting but generation n+1 does not, we collect generation n
   * by appending to generation n+1.
   *
   * "in place" collecting can disrupt generation numbers while in
   * this loop (some generations can get inserted, others deleted). So
   * for printing messages, we keep track of "the current generation
   * number" in gen_nr. */

  for(gen=creation, gen_nr = 0; gen!=NULL; gen_nr++, gen=parent) {
    parent = gen->parent;
    if(gen->collect >= (float)1) { /* Then we must collect it */
      int keep_from_space = 1; /* see long comment below */
      size_t live, required;
      if (parent->collect >= (float)1) {
	/* then collect this generation in place... */
	if (gen != creation) /* then insert a generation below gen */
	  (void) insert_gen_below(gen);
	/* loop through generations n ... m-1 */
	while (parent->collect >= (float)1) {
	  struct ml_heap *newgen;
	  gc_message(gen_nr,"collect %d ",gen_nr);
	  newgen = inplace_collect(gen, gen_nr);
	  renumber_generations();
	  gen = newgen->parent;
	  parent = gen->parent;
	  gen_nr++;
	}
	/* Suppose generations 1, 2, and 3 needed collecting. At this
	 * point, we will have a new, empty gen 1 (created by
	 * insert_gen_below), old gen 1 will have been in-place
	 * collected to new gen 2, and old gen 2 will have been
	 * in-place collected to new gen 3.  old gen 3 will still need
	 * collecting, and will have been renumbered as new gen 4.

	 * So we want to promote new gen 4 to new gen 5 and _delete_
	 * new gen 4. The promotion is like a regular promotion,
	 * except we don't keep from space, so we set this flag: */

	keep_from_space = 0;
      }
      /* Now we have a generation to be promoted to its parent */
      required = (gen->top - gen->start)*sizeof(mlval);
      live = (parent->top - parent->start)*sizeof(mlval);
      gc_message(gen_nr, "promote %d ", gen_nr);
      resize_ml_heap(parent, live + required);
      collect_gen(gen, parent, gen_nr);
      resize_ml_heap(parent, (parent->top - parent->start)*sizeof(mlval));
#if RESIZE_CREATION
/* Include this code to allow resizing of creation */
/* There's no evidence (from compilations anyway) that this is worht doing */
      {
	size_t discarded = live + required - (parent->top - parent->start)*sizeof(mlval);
	size_t promoted = required - discarded;
#define max(a, b) (((a) > (b)) ? (a) : (b))
#define min(a, b) (((a) < (b)) ? (a) : (b))
	if (gen == creation) {
	  size_t new_creation_size =
	    (promoted < creation_size / 4) ?
	    max(min_creation_size, (creation_size*3)/4) :
	    (promoted > (creation_size*3)/4) ?
	    min(max_creation_size, (creation_size*3)/2) :
	    creation_size;
	  DIAGNOSTIC(4, "Collecting creation space %d promoted, %d discarded\n",  promoted, discarded);
	  DIAGNOSTIC(4, "Promotion ratio %d%%\n", promoted * 100 / required, 0);
	  if (new_creation_size != creation_size) {
	    DIAGNOSTIC(4, "Resizing creation space from 0x%x to 0x%x\n", creation_size, new_creation_size);
	    resize_ml_heap(creation, new_creation_size);
	    creation_size = new_creation_size;
	  }
	}
      }
#endif
      gen->collect = (float)0;

      /* Now maybe we delete the "from" generation */
      if (gen != creation) {
	if (keep_from_space) {
	  resize_ml_heap(gen,0);
	  if (desire_merge) { /* then merge gen and parent */
	    gc_message(gen->number, "merge %d ", gen->number);
	    remove_gen(gen);
	    desire_merge = 0;
	  } else {
	    gen->image_top = gen->start;
	  }
	} else
	  remove_gen(gen);
      }
    }
  }

  /* If there is still more mapped memory than the advisory limit then there */
  /* is too much data!  Add extra space but try to remove it later. */
  
  if(arena_extent >= arena_limit + arena_extra) {
    arena_extra = (arena_extent * 2) - arena_limit;
    message("Warning: Live data exceeds advisory limit of %uMb.  Temporarily "
	    "increasing limit to %uMb.",
	    arena_limit >> 20, (arena_limit + arena_extra) >> 20);
  } else if(arena_extent < arena_limit && arena_extra > 0) {
    arena_extra = 0;
    message("Size limit restored to %uMb.", arena_limit >> 20);
  }
}


/*  == The garbage collector ==
 *
 *  The garbage collector is called when the creation space is full.  (See
 *  storage manager documentation.)  The parameter is the double-aligned
 *  number of bytes of space required on the heap.  On entry, GC_HEAP_START
 *  should be the top of the live heap plus this amount.  GC_HEAP_LIMIT and
 *  GC_RETURN may contain any value.  GC_SP points to the lowest stack frame
 *  that might contains fixable ML values.
 */

void gc(size_t space_required, mlval closure)
{
  double start, stop, time;
  size_t values_required = space_required/sizeof(mlval);
  size_t modified = 0;

  ++in_GC;
  start = user_clock();

  /* Is this the initial call to the GC?  If so, set up the heap */
  /* pointers and continue. Note that if the first object ever
     allocated is too large, this will fail. Since the first object
     allocated is something in the runtime environment, this problem
     never manifests itself. */

  if(creation == NULL)
  {
    creation = make_ml_heap(creation_size, creation_size);
    GC_RETURN     = creation->start;
    GC_HEAP_START = creation->start + values_required;
    GC_HEAP_REAL_LIMIT = creation->end;
    GC_HEAP_LIMIT = creation->end;
  }
  else
  {
    /* if we have a very small creation space, we can end up here
     * while unpacking the global roots from a loaded image, before
     * the gc_message_level has been restored from the loaded image.
     * In that case, gc_message_level is equal to DEAD, and we can use
     * a default value. Note that none of the other GC entry points
     * (e.g. gc_collect_all) suffer from this problem. */

    message_level = (gc_message_level == DEAD ? 2 : 
		     CINT(DEREF(gc_message_level)));
    message_printed = 0;

    if((int)values_required > creation->end - creation->start)
    {
      struct ml_static_object *stat =
	make_static_object(values_required * sizeof(mlval));

      stat->forward = creation->statics.forward;
      stat->back    = &creation->statics;
      stat->forward->back = stat;
      stat->back->forward = stat;
      stat->gen = creation;
      ++creation->nr_static;

      DIAGNOSTIC(1, "new static object at 0x%X size %u words", stat, values_required);

      GC_HEAP_START -= values_required;
      GC_HEAP_REAL_LIMIT = creation->end;
      GC_HEAP_LIMIT = creation->end;
      GC_RETURN = &stat->object[0];
    }
    else
    {
      /* Copy the ML registers pointing to the heap back into the space */
      /* descriptor for the creation space. */
      creation->top = GC_HEAP_START - values_required;
      
#ifdef DEBUG
      if (analyse_creation_space) {
	if (analyse_creation_start) {
	  heap_analysis_count(analyse_creation_start,creation->top);
	  analyse_creation_start = NULL;
	} else
	  heap_analysis_count(creation->start,creation->top);
      }
#endif /* DEBUG */

      gc_statistics(gc_stat_stream, user_clock(), 0);

      /* Attach the modified refs to the creation generation entry list. */
      modified = move_modified_list();
      
      /* Make room for the request in the creation space. */
      if(values_required != 0) {
	do_stack_crawl = 1;
	think(values_required);
	collections++;
      }

      gc_statistics(gc_stat_stream, user_clock(), 1);

      GC_HEAP_LIMIT = creation->end;
      GC_HEAP_REAL_LIMIT = creation->end;
      GC_HEAP_START = creation->top + values_required;
      GC_RETURN = creation->top;
    }
  }

  stop = user_clock();
  time = stop - start;
  gc_clock += time;
  gc_message_end(time, modified);

  --in_GC;
}

/*  == Miscellaneous exported GC functions ==  */

extern void gc_collect_gen(unsigned int number)
{
  struct ml_heap *gen;
  int collected = 0;
  double start, stop, time;
  
  ++in_GC;
  start = user_clock();
  
  message_printed = 0;
  message_level = CINT(DEREF(gc_message_level));
  
  creation->top = GC_HEAP_START;
  (void)move_modified_list();
  
  do_stack_crawl = 1;

  if (number == 0) {
    collected = 1;
    gc_message(0,"inplace 0 ");
    think (creation_size);
  } else {
    for(gen=creation; gen!=NULL; gen=gen->parent)
      if((unsigned)gen->number == number) {
	collected = 1;
	self_collect(gen);
      }
  }
  
  GC_HEAP_LIMIT = creation->end;
  GC_HEAP_REAL_LIMIT = creation->end;
  GC_HEAP_START = creation->top;
  
  if (collected) {
    stop = user_clock();
    time = stop - start;
    gc_clock += time;
    gc_message_end(time,0);
  }
  
  --in_GC;
}

static void collect_all(void)
{
  struct ml_heap *gen;
  double start, stop, time;
  
  ++in_GC;
  start = user_clock();

  message_printed = 0;
  message_level = CINT(DEREF(gc_message_level));
  
  creation->top = GC_HEAP_START;
  (void)move_modified_list();
  
  think (creation_size);
  for(gen=creation->parent; gen!=NULL; gen=gen->parent)
    self_collect(gen);
  for(gen=creation->parent; gen!=NULL; gen=gen->parent)
    self_collect(gen);
  
  GC_HEAP_LIMIT = creation->end;
  GC_HEAP_REAL_LIMIT = creation->end;
  GC_HEAP_START = creation->top;
  
  stop = user_clock();
  time = stop - start;
  gc_clock += time;
  gc_message_end(time,0);
  --in_GC;
}

static void promote_all(void)
{ /* this should be called after collect_all */
  struct ml_heap *parent, *child;
  double start, stop, time;
  
  ++ in_GC;
  start = user_clock();
  
  message_printed = 0;
  message_level = CINT(DEREF(gc_message_level));
  
  creation->top = GC_HEAP_START;
  (void)move_modified_list();
  think (creation_size);
  
  /* find the oldest generation */
  parent = creation;
  while(parent->parent != NULL)
    parent = parent->parent;
  
  child = parent->child;
  
  while (child != NULL) {
    size_t live = (parent->top - parent->start)*sizeof(mlval);
    size_t free = parent->values - live;
    size_t required = (child->top - child->start)*sizeof(mlval);
    if (required < free) {
      /* promote child to parent */
      gc_message(child->number, "promote %d ", child->number);
      resize_ml_heap(parent, live+required);
      collect_gen(child, parent, child->number);
      resize_ml_heap(parent, (parent->top - parent->start)*sizeof(mlval));
      child->collect = (float) 0;
      if (child != creation)
	resize_ml_heap(child,0);
    } else
      parent = child;
    child = child->child;
  }
  
  GC_HEAP_LIMIT = creation->end;
  GC_HEAP_REAL_LIMIT = creation->end;
  GC_HEAP_START = creation->top;
  
  stop = user_clock();
  time = stop - start;
  gc_clock += time;
  gc_message_end(time,0);
  --in_GC;
}

/* A function to sort one entry list as required by sort_entry_lists below */
static void sort_entry_list(struct ml_heap *gen)
{
  union ml_array_header *array = gen->entry.the.forward;
  unsigned int i = 0;
  while (i < gen->nr_entries) {
    struct ml_heap *array_gen = GENERATION((mlval *)array);
    union ml_array_header *array_next = array->the.forward;
    i++;
    if (array_gen != NULL) {
      if ((mlval *)array >= array_gen->image_top &&
	  (mlval *)array < array_gen->top) {
	/* Move this array to the end of the list */
	/* First disconnect from the list */
	array->the.back->the.forward = array->the.forward;
	array->the.forward->the.back = array->the.back;
	/* Now reinsert at end */
	array->the.forward = &gen->entry; /* Forward returns to gen */
	array->the.back = gen->entry.the.back; /* Back to last existing element */
	gen->entry.the.back = array;
	array->the.back->the.forward = array; /* And connect back into list */
      } else {
	if (!live_in_gen(array_gen, (mlval *)array)) {
	  error("entry list array 0x%x outside generation %d", array, array_gen->number);
	} else {
	  gen->last.the.back = array; /* Update last on list pointer */ 
	  DIAGNOSTIC(4, "gen->last.the.back updated to 0x%x\n", array, 0);
	}
      }
    } else {
      error("Unable to determine generation for 0x%x", array, 0);
    }
    array = array_next;
  }
}

/* A function to move all entry list items which wouldn't */
/* appear in a saved image to the end of the lists. */
/* This allows the image loader to sort out the lists easily */
static void sort_entry_lists(void)
{
  struct ml_heap *gen;
  for (gen = creation; gen != NULL; gen=gen->parent) {
    gen->last.the.back = gen->entry.the.back; /* initial end of save entry list */
    if (gen->image_top >= gen->start && gen->image_top < gen->top) {
      sort_entry_list(gen);
    } else {
      if (gen->image_top != gen->top) {
	DIAGNOSTIC(1, "image_top 0x%x not within generation %d", gen->image_top, gen->number);
	DIAGNOSTIC(1, "start 0x%x top 0x%x", gen->start, gen->top);
      }
    }
  }
}

extern void gc_collect_all(void)
{
  do_stack_crawl = 1;
  do_split_collection = 1;
  collect_all();
  do_split_collection = 0;
  sort_entry_lists();
}

extern void gc_promote_all(void)
{
  do_stack_crawl = 1;
  promote_all();
}

extern mlval gc_collections(mlval unit)
{
  return mlw_cons(MLINT(collections),
	      MLINT((GC_HEAP_START- creation->start))<<2);
}

extern void gc_clean_image(mlval global_package)
{
  mlval old_message_level = DEREF(gc_message_level);
  declare_root(&global_package, 1);
  clear_thread_roots();
  do_stack_crawl = 0;
  collect_all();
  promote_all();
  collect_all();
  global_tidy(global_package);
  retract_root(&global_package);
  MLUPDATE(gc_message_level,0,MLINT(-1));		/* turn on messages */
  do_split_collection = 1;
  collect_all();
  do_split_collection = 0;
  sort_entry_lists();
  MLUPDATE(gc_message_level,0,old_message_level);
}

#ifdef DEBUG
extern void gc_analyse_heap(void)
{
  creation->top = GC_HEAP_START;
  analyse_heap();
}

extern void gc_analyse_creation_start(void)
{
  analyse_creation_space = 1;
  analyse_creation_start = GC_HEAP_START;
  heap_analysis_zero();
  message("Analysing creation space");
}

extern void gc_analyse_creation_stop(void)
{
  analyse_creation_space = 0;
  heap_analysis_count(analyse_creation_start ?
		      analyse_creation_start : 
		      creation->start,
		      GC_HEAP_START);
  heap_analysis_results();
  heap_analysis_zero();
}

#endif

#ifdef EXPLORER

extern void explore_roots(void)
{
  size_t i;

  for(i=0; i<root_table_size; ++i)
    if(roots[i].root != NULL)
      explore_root(roots[i].root);
}

extern void explore_heap(void)
{
  if (creation) {
    struct ml_heap *gen = creation;
    creation->top = GC_HEAP_START;
    while(gen) {
      struct ml_static_object *stat = gen->statics.forward;
      while(stat != &gen->statics) {
	mlval header = stat->object[0];
	mlval secondary = SECONDARY(header);
	mlval length = LENGTH(header);
	mlval *base = &stat->object[0];
	mlval *top = (mlval*)(((byte*)base) + OBJECT_SIZE(secondary,length));
	explore_heap_area(gen, base, top);
	stat = stat->forward;
      }
      explore_heap_area(gen, gen->start, gen->top);
      gen = gen->parent;
    }
  }
}

#endif
