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
 *  $Log: profiler.c,v $
 *  Revision 1.29  1998/04/27 15:49:02  jont
 *  [Bug #70032]
 *  gen->values now measured in bytes
 *
 * Revision 1.28  1998/04/23  14:12:56  jont
 * [Bug #70034]
 * Rationalising names in mem.h
 *
 * Revision 1.27  1998/03/19  11:48:06  jont
 * [Bug #70026]
 * Allow profiling of stub_c functions, recording the time according
 * to the name of the runtime system functions
 *
 * Revision 1.26  1998/03/03  14:28:33  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.25  1997/11/17  09:05:19  jont
 * [Bug #30089]
 * Fix up a warning when compiling under cl
 *
 * Revision 1.24  1997/11/09  19:08:32  jont
 * [Bug #30089]
 * Convert profiler to use basis time instead of MLWorks.Time.Interval
 *
 * Revision 1.23  1997/03/25  13:33:16  nickb
 * Switch arguments of OBJECT_SIZE.
 *
 * Revision 1.22  1996/11/28  15:19:18  nickb
 * Fix ordering of code modification and selector function calls.
 * Also a few trivial bugs and clean-ups.
 *
 * Revision 1.21  1996/08/06  14:01:32  stephenb
 * time_prof_output_top_level: wrap some parens around | to keep
 * gcc-2.7.2 happy.
 *
 * Revision 1.20  1996/02/14  17:26:51  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.19  1996/02/13  17:33:20  jont
 * Add some type casts to allow compilation without warnings under VC++
 *
 * Revision 1.18  1996/01/16  10:53:22  nickb
 * Remove "storage manager" interface; replace it with regular functions.
 *
 * Revision 1.17  1995/12/12  15:26:13  nickb
 * Space profiler not getting correct size of pair objects.
 *
 * Revision 1.16  1995/10/23  16:21:08  nickb
 * Make profiler go faster.
 *
 * Revision 1.15  1995/10/19  12:50:04  nickb
 * Conditionalize root-counting.
 *
 * Revision 1.14  1995/09/19  10:29:57  jont
 * Fix problems with C ordering of evaluation of function parameters
 * interaction with gc and C roots
 *
 * Revision 1.13  1995/09/12  13:29:41  jont
 * Add parameter to sm_interface to control whether stack_crawl is done
 *
 * Revision 1.12  1995/07/19  15:10:59  nickb
 * Time profile header not being allocated large enough.
 *
 * Revision 1.11  1995/07/17  11:37:57  nickb
 * Move to new profiler framework, with results into ML.
 *
 * Revision 1.10  1995/05/02  15:06:02  nickb
 * Make portability changes for non-SPARC platforms.
 *
 * Revision 1.9  1995/03/15  13:30:13  nickb
 * Introduce the threads system.
 *
 * Revision 1.8  1995/02/02  14:49:57  nickb
 * Add another field to the profiling record.
 * New field shows 'total time evaluating this function'.
 *
 * Revision 1.7  1994/12/09  17:52:17  jont
 * Add ifndef control for NT
 *
 * Revision 1.6  1994/12/09  15:42:56  jont
 * Change time.h to mltime.h
 *
 * Revision 1.5  1994/10/19  14:22:59  nickb
 * Gcc 2.5.8 checks printf argument types, and there's one wrong in here.
 *
 * Revision 1.4  1994/06/24  10:53:15  nickh
 * Did the wrong thing to check for interception with new ancillaries.
 * Also failed to zero the gc_scans counter.
 *
 * Revision 1.3  1994/06/21  16:01:46  nickh
 * New ancillary structure.
 *
 * Revision 1.2  1994/06/09  14:45:51  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:15:40  nickh
 * new file
 *
 *  Revision 4.1  1994/03/29  15:57:28  johnk
 *   Bumped a revision.
 *
 *  Revision 3.7  1994/03/29  15:55:53  johnk
 *  Manually bumped.
 *
 *  Revision 3.6  1994/03/25  16:45:04  nickh
 *  General bug fixing.
 *
 *  Revision 3.5  1994/01/28  17:23:37  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 3.4  1993/06/02  13:11:21  richard
 *  Added extra parentheses around conditionals as suggested by GCC 2.
 *  Added overriding definition of inline.
 *
 *  Revision 3.3  1993/05/13  11:14:33  richard
 *  Added suspend and resume, and also stuff for call counting.
 *
 *  Revision 3.2  1993/04/29  14:23:38  richard
 *  Corrected the use of the large list of profile structures
 *  from profile_begin().
 *  Reinstated the profiler output header with general information.
 *
 *  Revision 3.1  1993/04/06  15:27:40  richard
 *  Another complete rewrite based on Nosa's multi-level profiler.
 *
 *  Revision 2.19  1993/03/01  17:12:52  nosa
 *  A Bug Fix
 *
 *  Revision 2.18  1993/02/24  14:05:42  nosa
 *  Implemented a multi-level profiler
 *
 *  Revision 2.17  1993/02/12  14:05:54  jont
 *  Changes for code vector reform
 *
 *  Revision 2.16  1992/12/18  15:20:25  clive
 *  Made the profiler take the generalised streams
 *
 *  Revision 2.15  1992/10/01  15:42:49  richard
 *  Added ansi.h.
 *
 *  Revision 2.14  1992/08/07  08:49:52  richard
 *  The profiler no longer maintains its own list of all code vectors
 *  but uses the weak list kept by the loader.  The weak list functions
 *  have been improved to allow the profiler to use them on that list.
 *
 *  Revision 2.13  1992/08/05  18:04:57  richard
 *  Added missing test in profile initialisation.
 *
 *  Revision 2.12  1992/08/05  12:48:17  richard
 *  Forgot to initialise the `miscellaneous' entry in the tables.
 *
 *  Revision 2.11  1992/08/04  16:19:15  richard
 *  Added some diagnostics.
 *
 *  Revision 2.10  1992/08/04  13:48:01  richard
 *  Added some missing roots.
 *
 *  Revision 2.9  1992/07/31  11:12:23  richard
 *  Added missing return of success code.
 *
 *  Revision 2.8  1992/07/31  11:00:40  richard
 *  Unregistered code vectors (stubs) may arise and are allowed.
 *
 *  Revision 2.7  1992/07/29  14:26:13  richard
 *  Added better error recovery.
 *
 *  Revision 2.6  1992/07/29  12:22:01  richard
 *  Each profiler table list may now contain multiple profiler entry
 *  structures.  This allows profile_begin() to allocate one large chunk
 *  of memory rather than thousands of small ones.
 *
 *  Revision 2.5  1992/07/21  13:42:22  richard
 *  The signal stack is now allocated by initialise.c.  Corrected the
 *  time interval calculation in start_timer().
 *
 *  Revision 2.4  1992/07/16  16:36:30  richard
 *  Removed is_ml_frame().  (Now implemented in the storage manager.)
 *
 *  Revision 2.3  1992/07/16  16:23:38  richard
 *  Removed is_ml_frame().  (Now implemented in the storage manager.)
 *
 *  Revision 2.2  1992/07/15  15:46:08  clive
 *  Temprary export of is_ml_frame until a better home is found for it
 *
 *  Revision 2.1  1992/07/14  15:56:06  richard
 *  Complete reimplementation without placing assumptions on the
 *  storage manager.  The profiler may now be `wrapped around'
 *  a computation in order to profile it, and sends it output to
 *  a specified stream.
 *
 *  Revision 1.8  1992/07/06  09:31:11  clive
 *  offsetof not defined in the headers - temporary fix
 *
 *  Revision 1.7  1992/07/03  07:23:28  richard
 *  Tried to eliminate some dependencies on the type checker and also some
 *  very poor C.
 *
 *  Revision 1.6  1992/06/30  08:50:43  richard
 *  Tidying, and moved in_ML here since it isn't (going to be) used
 *  from the storage manager.
 *
 *  Revision 1.5  1992/06/11  15:43:33  clive
 *  Fixed the bug where the stack interrupt stack was not being set up
 *  correctly
 *
 *  Revision 1.4  1992/05/14  10:19:57  clive
 *  Added some code for memory profiling and corrected some bugs
 *
 *  Revision 1.3  1992/05/06  13:47:52  clive
 *  Not clearing the global table pointer, when the table has been cleared
 *
 *  Revision 1.2  1992/05/05  11:07:01  clive
 *  Sort on name as well as number of calls
 *
 *  Revision 1.1  1992/04/14  16:14:18  clive
 *  Initial revision
 */

#include "ansi.h"
#include "syscalls.h"
#include "profiler.h"
#include "tags.h"
#include "values.h"
#include "diagnostic.h"
#include "interface.h"
#include "extensions.h"
#include "utils.h"
#include "allocator.h"
#include "global.h"
#include "loader.h"
#include "intercept.h"
#include "gc.h"
#include "signals.h"
#include "mltime.h"
#include "state.h"
#include "exceptions.h"
#include "environment.h"
#include "arch_code.h"
#include "time_date.h"

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <setjmp.h>
#include <stdarg.h>

#define mydecl

#ifdef DEBUG

static int debug_profiler_roots = 0;

#define declare_root(x, i)	do {declare_root(x, i);debug_profiler_roots++;}while(0)
#define retract_root(x)	do {retract_root(x);debug_profiler_roots--;}while(0)

#endif

/* Profiling overview.
 *
 * There are four kinds of profiling available: time, space, call-counting,
 * and cost-centred. This file is split into six sections accordingly:
 *
 * 1. general utilities &c
 * 2. time profiling
 * 3. space profiling
 * 4. call-count profiling
 * 5. cost-centred profiling
 * 6. general profiling control */

/* ------------------------------------------------------------------------- *
 * 				General utilities
 * ------------------------------------------------------------------------- */

/* We have several different kinds of C struct of which we want to
 * allocate large numbers dynamically and fairly cheaply and which we
 * want to free all-at-once. We do this using this macro, which
 * defines two functions of interest: make_foo() and free_foo_list()
 * (for some struct foo).  */

#define profile_allocator(struct_name, data_size_total)			\
									\
/* keep the structs in tables which are about page-size */		\
									\
static struct struct_name ## _table					\
{									\
  size_t nr_entries;							\
  struct struct_name ## _table *next;					\
  struct struct_name table[4060 / sizeof (struct struct_name)];		\
} *struct_name ## _list = NULL,						\
  *current_ ## struct_name;						\
									\
static struct struct_name ## _table *					\
   make_ ## struct_name ## _table(void)					\
{									\
  struct struct_name ## _table *result =				\
    (struct struct_name ## _table *)					\
      alloc_zero(sizeof(struct struct_name ## _table),			\
		 "Table of "						\
                 # struct_name						\
		 " profiler records");					\
  data_size_total += sizeof(struct struct_name ## _table);		\
  return result;							\
}									\
									\
static mydecl struct struct_name *make_ ## struct_name(void)		\
{									\
  if (current_ ## struct_name == NULL) {				\
    current_ ## struct_name = make_ ## struct_name ## _table();		\
    struct_name ## _list = current_ ## struct_name;			\
  }									\
  if (current_ ## struct_name->nr_entries ==				\
      4060 / sizeof(struct struct_name)) {				\
    current_ ## struct_name->next = make_ ## struct_name ## _table();	\
    current_ ## struct_name = current_## struct_name ->next;		\
  }									\
  return &(current_ ## struct_name->table				\
	   [current_ ## struct_name->nr_entries++]);			\
}									\
									\
static mydecl void free_ ## struct_name ## _list(void)			\
{									\
  struct struct_name ## _table *this = struct_name ## _list, *next;	\
									\
  while (this != NULL) {						\
    next = this->next;							\
    free(this);								\
    this = next;							\
  }									\
  struct_name ## _list = NULL;						\
  current_ ## struct_name = NULL;					\
}

struct profile {
  unsigned int calls;		/* call counting; must come first */
  struct time_profile *time;
  struct space_profile *space;
  unsigned int manner;		/* in what manner are we profiling this item */

  mlval code;			/* points back to the code item */
};

/*  == Globals ==
 *
 *  profile_options	the current profiler options
 *  profile_manners	OR of all the profile manners
 *  profile_data_size   how many bytes have we allocated
 *  in_profile		non-zero when actually executing profiling code
 */

static size_t profile_data_size;
unsigned int profile_manners;
struct profile_options profile_options;
int in_profile = 0;

profile_allocator(profile, profile_data_size)


#define SPARE_PROFILER_ROOTS	20

static mlval profiler_roots[SPARE_PROFILER_ROOTS];

#define TIME_ROOT1	profiler_roots[0]
#define TIME_ROOT2	profiler_roots[1]

#define SPACE_ROOT1	profiler_roots[2]
#define SPACE_ROOT2	profiler_roots[3]
#define SPACE_ROOT3	profiler_roots[4]
#define SPACE_ROOT4	profiler_roots[5]

#define GEN_ROOT1	profiler_roots[10]
#define GEN_ROOT2	profiler_roots[11]
#define GEN_ROOT3	profiler_roots[12]
#define GEN_ROOT4	profiler_roots[13]
#define GEN_ROOT5	profiler_roots[14]
#define GEN_ROOT6	profiler_roots[15]
#define GEN_ROOT7	profiler_roots[16]
#define GEN_ROOT8	profiler_roots[17]
#define GEN_ROOT9	profiler_roots[18]
#define GEN_ROOT10	profiler_roots[19]

#define ROOT(n)	profiler_roots[n]

static mydecl void declare_profiler_roots(void)
{
  int i;
  for (i=0; i<SPARE_PROFILER_ROOTS; i++) {
    declare_root(&profiler_roots[i], 0);
    profiler_roots[i] = MLUNIT;
  }
}

static mydecl void retract_profiler_roots(void)
{
  int i;
  for (i=0; i<SPARE_PROFILER_ROOTS; i++) {
    retract_root(&profiler_roots[i]);
    profiler_roots[i] = MLUNIT;
  }
}

/* ------------------------------------------------------------------------- *
 * 				Time profiling
 * ------------------------------------------------------------------------- */

/* Time profiling overview:
 *
 * 1. Single-level time profiling
 *
 * When a function is being time-profiled, the 'time' slot in its
 * struct profile points to a struct time_profile. The user specifies
 * a stack scanning interval (in milliseconds). With that frequency,
 * the runtime scans the stack. When the stack is scanned, the
 * time_profile structures of the code items corresponding to the
 * closures on the stack are updated. For details of the information
 * gathered, see the comment on struct time_profile.
 *
 * 2. Multi-level time profiling
 *
 * When scanning the stack, the time profiler can gather frequency
 * information on 'foo called bar called baz' patterns (to a depth
 * specified by the user). This is done by generating 'struct
 * time_profile_caller' structures, containing slots for statistical
 * profiling. Tables of these structures are managed in 'struct
 * time_profile_callers' structures. Each struct time_profile is at
 * the top of a tree of such structures. */

/*  == Globals ==
 *
 *  scans, gc_ticks	# of stack scans, # of scans skipped because in GC
 *  re_entered_ticks    # of scans re-entered (non-zero means a *bug*)
 *  profile_ticks	 # of scans skipped because in profile code
 *  time_profile_codes	number of code vectors time-profiled
 *  call_profile_codes	number of code vectors call-count profiled
 *  frames		number of frames scanned in total
 *  ml_frames		number of ML frames scanned in total
 *  maximum_ml_frames	     maximum depth of ML frames found in a single scan
 *  time_profile_data_size   how many bytes have we allocated
 *  time_profile_roots       how many roots have we declared
 *
 * frames and ml_frames are kept as doubles to provide extra bits
 * (when scanning a stack of depth 500, 100 times each second, a
 * profile of around a day will overflow a 32-bit int; IEEE doubles
 * have another 20 bits of precision).
 */

static unsigned int scans, gc_ticks, re_entered_ticks, profile_ticks;
static unsigned int time_profile_codes, maximum_ml_frames;
static double frames, ml_frames;
static unsigned int time_profile_data_size, time_profile_roots;
static int call_profile_codes;

/* struct time_profile records all time profiling information.
 *
 * 'callers' is a pointer to a record of the callers of this function.
 *
 * 'found' is the total number of times found
 * 'scans' is the number of scans on which found
 * 'top' is the number of times found on the top of the stack
 * 'updated' is the scan number of the last scan on which found
 * 'depth' is the number of times found in the current scan
 * 'max_depth' is the maximum number of times found in any scan
 * 'self' is the maximum contiguous stack depth found in any scan
 */

struct time_profile
{
  struct time_profile_callers *callers;

  unsigned int stack_depth;	/* stack depth of profile requested */

  unsigned int found;		/* nr times found on the stack */
  unsigned int scans;		/* nr of scans on which found */
  unsigned int top;		/* nr times found on the top of the stack */
  unsigned int updated;		/* scan # at which last found */
  unsigned int self;		/* maximum contiguous stack depth */
  unsigned int depth;		/* stack depth found in current scan */
  unsigned int max_depth;	/* maximum depth on any scan */
};

/* struct time_profile_caller is as for struct time_profile, but
 * without fields which are meaningless for callers. See the comment
 * on profiling above.
 *
 * 'callers' is obviously the recursive callers slot.
 *
 * The 'code' slot is a little different: we want to avoid having too
 * many GC roots, so if a caller is being profiled (i.e. has a 'struct
 * profile'), the 'code' slot in its struct time_profile_caller points
 * to the 'code' slot in its struct profile, and is not declared as a
 * root.  Callers which are not profiled in their own right have the
 * regular code pointer in their 'code' slots, and those slots are
 * declared as roots.  So to find the code object of a
 * time_profile_caller: if the 'code' slot has a tagged ML value, it
 * is the code pointer; otherwise it points to the code pointer. This
 * is done by 'find_code()' below (q.v.)
 *
 * 'found' is the number of times this caller-chain has been found.
 * 'scans' is the number of scans on which found.
 * 'updated' is the scan on which most recently found.
 * 'top' is the number of times it's been found at the top of the stack. */

struct time_profile_caller
{
  struct time_profile_callers *callers;
  mlval code;			/* code vector profiled (see comment) */

  unsigned int found;		/* nr times found on the stack */
  unsigned int scans;		/* nr of scans on which found */
  unsigned int top;		/* nr times found on the top of the stack */
  unsigned int updated;		/* scan # at which last found */
};

/* struct time_profile_callers is a linked list of caller tables
 * (this data structure chosen to combine space and time efficiency),
 * extended when a specific caller is not found during find_caller()
 * q.v. See struct time_profile_caller below, and the comment on
 * multi-level time profiling above. */

#define CALLERS_PER_BLOCK 4

struct time_profile_callers
{
  struct time_profile_callers *next; /* a linked list */
  struct time_profile_caller callers[CALLERS_PER_BLOCK];
};

profile_allocator(time_profile, time_profile_data_size)
profile_allocator(time_profile_callers, time_profile_data_size)

/* find_code(): see comment on struct time_profile_caller above */

static mydecl mlval find_code(mlval code)
{
  if (!MLVALISPTR(code))
    code = *(mlval *)code;

  return(code);
}

/*  == Find a caller ==
 *
 * Searches a caller table for a particular code vector.  If it isn't
 * found, a new struct time_profile_caller is created and added to the
 * table.
 */

static mydecl struct time_profile_caller *
find_caller (struct time_profile_callers **callee,
	     mlval code)
{
  size_t i;
  struct time_profile_caller *result = NULL;
  struct profile *caller;
  DIAGNOSTIC(2, "find_caller(callee = 0x%X, code = 0x%X)", callee, code);
  DIAGNOSTIC(2, "  caller name `%s'", CSTRING(CCODENAME(code)), 0);


  while(result == NULL) {
    struct time_profile_callers *callee_table = *callee;
    if (callee_table == NULL) {
      callee_table = make_time_profile_callers();
      *callee = callee_table;
    }
    for(i=0; i<CALLERS_PER_BLOCK; ++i) {
      mlval table_code = callee_table->callers[i].code;
      if (table_code == 0) {
	DIAGNOSTIC(2, "  not found",0,0);
	result = &callee_table->callers[i];
	break;
      } else {
	if(find_code(table_code) == code) {
	  DIAGNOSTIC(2, "  found at 0x%X", &callee_table[i], 0);
	  return(&callee_table->callers[i]);
	}
      }
    }
    callee = &(callee_table->next);
  }

  caller = (struct profile *)CCODEPROFILE(code);
  if (caller == NULL) {
    result->code = code;
    declare_root(&result->code, 0);
    time_profile_roots++;
  } else {
    DIAGNOSTIC(2, "  caller has profile at 0x%X", caller, 0);
    result->code = (mlval)&caller->code;
  }
  return result;
}

static mydecl void time_profile_retract_roots(void)
{
  struct time_profile_callers_table *table = time_profile_callers_list;
  unsigned int i,j;

  while(table != NULL) {
    for(i=0; i < table->nr_entries; i++) {
      for (j=0; j < CALLERS_PER_BLOCK; j++) {
	if (MLVALISPTR(table->table[i].callers[j].code)) {
	  retract_root(&(table->table[i].callers[j].code));
	}
      }
    }
    table = table->next;
  }
}

/* == Callers list for stack scanning ==
 * 
 * For multi-level time profiling (see the big comment on time
 * profiling above), we must record each ML stack frame in several
 * places: once in its own 'struct time_profile', and also as a caller
 * of each of several other functions.
 *
 * We keep a list 'callers_list', to record all the struct
 * time_profile_callers in which the code object of the current frame
 * should be looked up. We also keep a free list of callers.
 * 
 * At each stack scan, update_callers_list() is called, which scans
 * through the list acting on and updating each entry of it. 
 * 
 * The current closure is looken up for each list entry, and the
 * struct time_profile_caller returned is updated. The 'depth' slot of
 * the list entry is decremented, and when it reaches zero the entry
 * is freed. If the 'top' slot is non-zero, the top-level frame on
 * this chain was on top of the stack. 
 *
 * Then a new entry is added to the list for the current frame.
 */

static struct callers_link
{
  struct time_profile_callers **callers; /* NULL if this chain not profiled */
  int depth;				 /* How much more depth? */
  int top;	                         /* 1 if this chain on top of stack */
  struct callers_link *next;
} *callers_list = NULL, *callers_free_list = NULL;

static mydecl void free_callers_list(void)
{
  struct callers_link *item = callers_list, *next;
  while(item) {
    next = item->next;
    free(item);
    item = next;
  }
  item = callers_free_list;
  while(item) {
    next = item->next;
    free(item);
    item = next;
  }
  callers_free_list = callers_list = NULL;
}

static mydecl void clear_callers_list(void)
{
  if (callers_free_list) {
    struct callers_link *item = callers_free_list;
    while(item->next != NULL) 
      item = item->next;
    item->next = callers_list;
  } else
    callers_free_list = callers_list;
  callers_list = NULL;
}

static mydecl struct callers_link *make_callers_link(void)
{
  struct callers_link *result;
  if (callers_free_list) {
    result = callers_free_list;
    callers_free_list = result->next;
  } else {
    result = (struct callers_link *)
      alloc(sizeof(struct callers_link),
	    "Stack profiling caller list link");
  }
  result->next = callers_list;
  callers_list = result;
  return result;
}
 
static mydecl void free_callers_link(struct callers_link *item)
{
  item->next = callers_free_list;
  callers_free_list = item;
}
   
/* see the big comment above */

static mydecl void update_callers_list(mlval code,
				       struct time_profile *profile,
				       unsigned int top,
				       unsigned int scan)
{
  struct callers_link *item, *next, **last;
  struct time_profile_caller *caller;

  item = callers_list;
  last = &callers_list;
  while (item != NULL) {
    next = item->next;

    caller = find_caller(item->callers,code);
    if (caller->updated != scan) {
      caller->scans++;
      caller->updated = scan;
    }
    caller->found++;
    if (item->top)
      caller->top++;
      
    item->depth--;
    if (item->depth) {
      item->callers = &caller->callers;
      last = &(item->next);
    } else {
      *last = next;
      free_callers_link(item);
    }
    item = next;
  }
  if (profile && profile->stack_depth) {
    item = make_callers_link();
    item->depth = profile->stack_depth;
    item->callers = &profile->callers;
    item->top = top;
  }
}

/*  === Periodic Stack Scanning ===
 *
 * See the support in signals.[ch] for this. We start a regular
 * profiler alarm off when we start profiling, and stop it when we
 * finish. Each time it goes off, time_profile_scan() gets called. 
 *
*/

extern void time_profile_scan (struct stack_frame *sp)
{
  static int entered = 0;
  unsigned int ml_frames_found, frames_found, self, top;
  struct profile *prof;
  struct time_profile *profile;
  mlval code = MLUNIT, previous = MLUNIT;

  if(entered) {
    /* this is probably a bug, since we haven't reset the timer yet.
     * It can occur if the right signal is sent to MLWorks in some way
     * other than through the profiling alarm going off */
    re_entered_ticks++;
    return;

  } else if (in_profile)
    profile_ticks++;
  else if (!in_GC) {
    /* can only scan the stack if we're not garbage-collecting */
    entered = 1; 
    scans++;
    
    top = 1;
    ml_frames_found = 0;
    frames_found = 0;
    self = 0;
    clear_callers_list();

    for(;;) { /* scan the stack */
      
      /* skip any C frames */
      while (!is_stack_top(sp,CURRENT_THREAD) &&
	     (code = is_ml_frame(sp)) == MLUNIT) {
	previous = MLUNIT;  /* 'foo calls C calls foo' is not a self-call */
	sp = sp->fp;
	++frames_found;
      }
      
      /* have we reached the bottom of the stack? */
      if (is_stack_top(sp,CURRENT_THREAD))
	break;
      
      if (code == stub_c) {
	mlval closure = sp->closure;
	code = FIELD(closure, 4);
      }
      ++ml_frames_found;
      
      prof = (struct profile *)CCODEPROFILE(code);
      if (prof != NULL) {
	profile = prof->time;
      } else
	profile = NULL;

      if (profile != NULL) {
	/* do the profiling information */
	/* how many times found? */
	profile->found++;
	
	/* how many times found on top?*/
	if (top)
	  profile->top++;
	
	/* how many self-calls: 'maximum contiguous stack frames' */
	if(code == previous) {
	  ++self;
	  if (self > profile->self)
	    profile->self = self;
	} else
	  self = 0;
	
	/* how many recursions: 'maximum times found in a single scan' */
	if (profile->updated == scans) { /* previously found on this scan */
	  ++profile->depth;
	  if (profile->depth > profile->max_depth)
	    profile->max_depth = profile->depth;
	} else { /* not previously found on this scan */
	  profile->depth = 0;
	  profile->updated = scans;
	  profile->scans++;
	}
      }
      
      /* do the multi-level profiling information */
      update_callers_list(code, profile, top, scans);
      
      previous = code;
      top = 0;
      sp = sp->fp;
      ++frames_found;
    }
    /* finished the scan; update the globals */

    if (ml_frames_found > maximum_ml_frames)
      maximum_ml_frames = ml_frames_found;
    
    ml_frames += ml_frames_found;
    frames += frames_found;

  } else /* we're in the GC */
    gc_ticks++;

  entered = 0;
}

/* register and unregister code for time profiling: */

static void time_profile_code(struct profile *profile)
{
  if (profile->manner & PROFILE_TIME) {
    profile->time = make_time_profile();
    profile->time->stack_depth =
      (profile->manner & PROFILE_DEPTH_MASK) >> PROFILE_DEPTH_SHIFT;
    time_profile_codes ++;
  } else
    profile->time = NULL;
}

static void time_unprofile_code(struct profile *profile)
{
  profile->time = NULL;
}

/*  === Output ===

   MLWorks time profiler output format and sorting
   -----------------------------------------------

We output time profile reports in a big table, together with the
call-counting results. Here is an example:

----- report begins here -----
MLWorks time profile:
527064 bytes used for time profiling data
functions profiled : 7011
functions call-counted : 0
scans: 184150
(plus 28922 ticks in GC, 650964 ticks in profiler, 0 re-entered)
0 roots
frames scanned: 16577615
ML frames scanned: 15799496 (95.3%)
mean stack depth: 90.02
maximum ML stack depth: 2039
mean ML stack depth: 85.80
---
   calls       top     scans     found     depth      self   name
[...]
       -         2         2         2         0         0   decode_string[main._encapsulate:917]<Closure>
                 2         2         2                       decode_string[main._encapsulate:917]<Closure>; input_sixtuple argument 5[main._encapsulate:760]
       -        18        18        18         0         0   Builtin function _int=
                12        12        12                       Builtin function _int=; scan[utils._b23tree:153]
                 1         1         1                       Builtin function _int=; unwind1[utils._b23tree:65]
                 5         5         5                       Builtin function _int=; find[utils._b23tree:307]
       -         0         0         0         0         0   decode_strname[main._encapsulate:1121]<Closure>
       -         0         0         0         0         0   decode_tyname[main._encapsulate:1420]<Closure>
       -         8      1064      1064         0         0   augment_cb[main._toplevel:903]
                 0        44        44                       augment_cb[main._toplevel:903]; <case><Match0>[main._toplevel:1085]
                 8       409       409                       augment_cb[main._toplevel:903]; compile_topdecs'[main._toplevel:1244]
                 0       611       611                       augment_cb[main._toplevel:903]; compile_program[main._toplevel:958]
       -        37       403       403         0         0   find_object[main._toplevel:916]
                 5        42        42                       find_object[main._toplevel:916]; <anon>[main._toplevel:1095]
                32       361       361                       find_object[main._toplevel:916]; do_subrequires argument 1[main._toplevel:993]
       -        11        12        12         0         0   error_wrap[main._toplevel:988]
                 0         1         1                       error_wrap[main._toplevel:988]; <anon>[main._toplevel:1193]
                 1         1         1                       error_wrap[main._toplevel:988]; <anon>[main._toplevel:1222]
                 7         7         7                       error_wrap[main._toplevel:988]; <anon>[main._toplevel:1081]
                 3         3         3                       error_wrap[main._toplevel:988]; <anon>[main._toplevel:1095]
       -         0         0         0         0         0   <handle>[main._toplevel:1033]
[...]
----- report ends here -----

The report starts with several lines of general information about the
time profile: how much C space it required, how long it took, how many
times the stack was scanned, &c. Then follows the table of profile
records. Each line represents one profiling record. Top-level time
profile records (struct time_profile) have entries in each
column. 'Caller' records (struct time_profile_caller) only have
entries in columns which are meaningful for them. The 'name' of a
caller line is fun1; fun2; ...; funm, meaning "funm calling
... calling fun2 calling fun1".

Functions which have been compiled for call-counting get an entry in
the 'calls' column. Other functions just get "-".

To sort on the 'calls' column (number of function entries recorded):

% sort -r +0.0 -0.10

To sort on the 'top' column (number of times this function found at
the top of the stack, i.e. how much time spent in this function
alone):

% sort -r +0.10 -0.20

To sort on the 'scans' column (number of scans in which this function
was found anywhere in the stack, i.e. how much time spent in this
function, including time spent in sub-functions):

% sort -r +0.20 -0.30

To sort on the 'found' column (number of times a stack frame for this
function found anywhere on the stack):

% sort -r +0.30 -0.40

To sort on the 'depth' column (maximum number of times this function
found in one stack scan, i.e. how much does the algorithm recurse
through this function):

% sort -r +0.40 -0.50

To sort on the 'self' column (maximum number of times this function
found calling itself directly in one stack scan, i.e. how non-tail
recursive is this particluar function):

% sort -r +0.50 -0.60

Sorting on the 'top', 'scans', or 'found' columns will sort the caller
lines into the appropriate place. Sorting on any other column will
move the caller lines to the end.  */

/* function to print one line for a caller record. Arguments are:
 *
 * top: time_profile for the top-level function
 * stack: array of pointers to time_profile_caller structs for the caller chain
 * depth: how far down the chain are we?
 */

static mydecl void time_prof_print_nested(struct profile *top,
					  struct time_profile_caller *stack[],
					  size_t depth)
{
  struct time_profile_caller *p = stack[depth];
  unsigned int i;
  mlval code = top->code;
  char *name = CSTRING(CCODENAME(code));

  fprintf(profile_options.stream,
	  "          %8u  %8u  %8u                       %s",
	  p->top, p->scans, p->found, name);

  for(i=0; i<= depth; ++i) {
    code = find_code(stack[i]->code);
    name = CSTRING(CCODENAME(code));
    fprintf(profile_options.stream, "; %s", name);
  }

  fprintf(profile_options.stream,"\n");
}

/* Nested output for all lines below the top-level; calls itself
 * recursively. */

static void time_prof_output_nested (struct profile *top,
				     struct time_profile_caller *stack[],
				     size_t depth)
{
  size_t i;
  struct time_profile_callers *callers;

  time_prof_print_nested (top, stack, depth);

  callers = stack[depth]->callers;

  while (callers != NULL) {
    for(i=0; i<CALLERS_PER_BLOCK; ++i) {
	if (callers->callers[i].code) {
	  stack[depth+1] = &(callers->callers[i]);
	  time_prof_output_nested (top, stack, depth+1);
	}
      }
    callers = callers->next;
  }
}

/* Output all the lines for a top-level time profile struct */

static void time_prof_output_top_level (struct profile *top,
					struct time_profile_caller *stack[])
{
  mlval code = top->code;
  struct time_profile *tp = top->time;
  int i;

  if ((top->calls != -1) | (tp != NULL)) {
    char *name = CSTRING(CCODENAME(code));
    if (tp == NULL) {
      fprintf(profile_options.stream,
      "%8u         -           -           -           -           -   %s\n",
	      top->calls, name);
    } else {
      struct time_profile_callers *callers;
      if (top->calls != -1)
	fprintf(profile_options.stream,"%8u  %8u  %8u  %8u  %8u  %8u   %s\n",
		top->calls, tp->top, tp->scans, tp->found, tp->max_depth,
		tp->self, name);
      else
	fprintf(profile_options.stream,
		"       -  %8u  %8u  %8u  %8u  %8u   %s\n",
		tp->top, tp->scans, tp->found, tp->max_depth, tp->self, name);
      callers = tp->callers;
      while (callers != NULL) {
	for(i=0; i<CALLERS_PER_BLOCK; ++i) {
	    if (callers->callers[i].code) {
	      stack[0] = &(callers->callers[i]);
	      time_prof_output_nested (top, stack, 0);
	    }
	  }
	callers = callers->next;
      }
    }
  }
}

static void time_profile_report(void)
{
  struct time_profile_caller *stack[PROFILE_DEPTH_MAX];
  struct profile_table *list;

  fprintf(profile_options.stream,
	  "---------------------------------------------------------\n");
  fprintf(profile_options.stream,
	  "MLWorks time profile:\n"
	  "%u bytes used for time profiling data\n"
	  "functions profiled : %u\n"
	  "functions call-counted : %u\n"
	  "scans: %u\n"
	  "(plus %u ticks in GC, %u ticks in profiler, %u re-entered)\n",
	  time_profile_data_size,
	  time_profile_codes,
	  call_profile_codes,
	  scans, gc_ticks, profile_ticks, re_entered_ticks);

#ifdef DEBUG
  fprintf(profile_options.stream,
	  "%u roots\n", time_profile_roots);
#endif

  if (scans) {
    fprintf(profile_options.stream,
	    "frames scanned: %.0f\n"
	    "ML frames scanned: %.0f (%3.1f%%)\n"
	    "mean stack depth: %.2f\n"
	    "maximum ML stack depth: %u\n"
	    "mean ML stack depth: %.2f\n",
	    frames, ml_frames, (ml_frames/frames)*100.0,
	    frames/scans, maximum_ml_frames, ml_frames/scans);
  }

  if ((time_profile_codes && scans) || call_profile_codes) {

    fprintf(profile_options.stream,
	"---\n"
	"   calls       top     scans     found     depth      self   name\n");

    /* print all the profile report lines */

    list = profile_list;
    while(list != NULL) {
      size_t i;

      for(i=0; i<list->nr_entries; ++i)
	time_prof_output_top_level(&list->table[i], stack);

      list = list->next;
    }
  }
  fprintf(profile_options.stream,
	  "---------------------------------------------------------\n");
}

/* Now code to generate the ML profiler values. */

/*

datatype function_caller =
  Function_Caller of {id: function_id,			2
                      found: int,			1
		      top: int,			        4
		      scans: int,			3
		      callers: function_caller list}	0

*/

static mlval time_profile_item_callers(struct time_profile_callers *callers);

static mlval time_profile_item_caller(struct time_profile_caller *caller)
{
  mlval result, code;
  TIME_ROOT1 = time_profile_item_callers(caller->callers);
  result = allocate_record(5);

  code = find_code(caller->code);

  FIELD(result,0) = TIME_ROOT1;
  FIELD(result,1) = MLINT(caller->found);
  FIELD(result,2) = CCODENAME(code);
  FIELD(result,3) = MLINT(caller->scans);
  FIELD(result,4) = MLINT(caller->top);

  return result;
}

static mlval time_profile_item_callers(struct time_profile_callers *callers)
{
  int i;
  mlval caller_list = MLNIL;

/* do not have to declare and retract caller_list, as cons() does it for us */

  while(callers != NULL) {
    for (i=0; i<CALLERS_PER_BLOCK; ++i)
      if (callers->callers[i].code) {
	mlval temp = time_profile_item_caller(&(callers->callers[i]));
	 /* Do NOT inline this */
	caller_list = cons(temp, caller_list);
      }
    callers = callers->next;
  }
  return caller_list;
}

/*
   datatype function_time_profile =
   Function_Time_Profile of {found: int,			2
			     top: int,				5
			     scans: int,			3
			     depth: int,			1
			     self: int,				4
			     callers: function_caller list}	0
*/

static mlval time_profile_null_item = MLUNIT;

static mlval time_profile_item(struct time_profile *prof)
{
  if (prof) {
    mlval result;
    TIME_ROOT1 = time_profile_item_callers(prof->callers);

    result = allocate_record(6);
    FIELD(result,0) = TIME_ROOT1;
    FIELD(result,1) = MLINT(prof->max_depth);
    FIELD(result,2) = MLINT(prof->found);
    FIELD(result,3) = MLINT(prof->scans);
    FIELD(result,4) = MLINT(prof->self);
    FIELD(result,5) = MLINT(prof->top);
    return result;
  } else {
    /* not time-profiling this item; return the null record */
    if (time_profile_null_item == MLUNIT) {
      time_profile_null_item = allocate_record(6);
      FIELD(time_profile_null_item,0) = MLNIL;
      FIELD(time_profile_null_item,1) = MLINT(0);
      FIELD(time_profile_null_item,2) = MLINT(-1); /* this marks it as null */
      FIELD(time_profile_null_item,3) = MLINT(0);
      FIELD(time_profile_null_item,4) = MLINT(0);
      FIELD(time_profile_null_item,5) = MLINT(0);
    }
    return time_profile_null_item;
  }
}

static int time_profile_non_zero(struct time_profile *prof)
{
  if (prof)
    if (prof->found != 0)
      return 1;
  return 0;
}
 
/* datatype time_header =
   Time of {data_allocated: int,	0
            functions: int,		2
	    scans: int,			7
	    gc_ticks: int,		3
	    profile_ticks: int,		6
	    frames: bignum,		1
	    ml_frames: bignum,		5
	    max_ml_stack_depth: int} 4 */

static mlval time_profile_header(void)
{
  mlval result;

  TIME_ROOT1 = allocate_real();
  (void)SETREAL(TIME_ROOT1, frames);
  TIME_ROOT2 = allocate_real();
  (void)SETREAL(TIME_ROOT2, ml_frames);

  result = allocate_record(8);
  FIELD(result,0) = MLINT(time_profile_data_size);
  FIELD(result,1) = TIME_ROOT1;
  FIELD(result,2) = MLINT(time_profile_codes);
  FIELD(result,3) = MLINT(gc_ticks);
  FIELD(result,4) = MLINT(maximum_ml_frames);
  FIELD(result,5) = TIME_ROOT2;
  FIELD(result,6) = MLINT(profile_ticks);
  FIELD(result,7) = MLINT(scans);
  return result;
}

static mlval time_profile_null_header(void)
{
  mlval result;
  
  TIME_ROOT1 = allocate_real();
  (void)SETREAL(TIME_ROOT1, 0.0);

  result = allocate_record(8);
  FIELD(result,0) = 0;
  FIELD(result,1) = TIME_ROOT1;
  FIELD(result,2) = 0;
  FIELD(result,3) = 0;
  FIELD(result,4) = 0;
  FIELD(result,5) = TIME_ROOT1;
  FIELD(result,6) = 0;
  FIELD(result,7) = 0;
  return result;
}

/* Now the top-level functions */

static void time_profile_init(void)
{ /* Do nothing */
}

static void time_profile_start(void)
{
  time_profile_codes = 0;
  time_profile_data_size = 0;
}

static void time_profile_on(void)
{
  scans = gc_ticks = profile_ticks = re_entered_ticks = 0;
  frames = ml_frames = maximum_ml_frames = 0;
  time_profile_roots = 0;
  time_profile_null_item = MLUNIT;
  declare_root(&time_profile_null_item, 0);

  profiling_interval = profile_options.interval;
  signal_profiling_start();
}

static void time_profile_off(void)
{
  signal_profiling_stop();
}

static void time_profile_end(void)
{
  time_profile_null_item = MLUNIT;
  retract_root(&time_profile_null_item);

  time_profile_retract_roots();
  free_time_profile_list();
  free_time_profile_callers_list();
  free_callers_list();
}

static void time_profile_suspend(void)
{
  signal_profiling_stop();
}

static void time_profile_resume(void)
{
  profiling_interval = profile_options.interval;
  signal_profiling_start();
}

/* ------------------------------------------------------------------------- *
 *			     Space profiling
 * ------------------------------------------------------------------------- */

/*
 *  space_profile_codes		number of code vectors profiled
 *  space_profile_data_size	how many bytes have we allocated.
 *  space_profile_colls         number of collections during profiling
 *  space_profile_active	non-zero iff we are in space profiling
 *  space_profiling		space_profile_active and not suspended.
 */

static unsigned int space_profile_codes;
static size_t space_profile_data_size;
static unsigned int space_profile_colls;
static int space_profile_active;
int space_profiling;

/* Space profiling 
 *
 * When the user turns on space profiling, the code of any functions
 * selected for space profiling is edited to call a special routine
 * when doing an allocation, and a struct space_profile is allocated
 * for the space slot of the struct profile of that function. The
 * special allocation routine records the closure of the allocating
 * function in the creation space profiling area (Every generation has
 * a space profiling area). While space profiling is on, the GC code
 * propagates the profiling records of objects which survive
 * GC. Analysis of these records can thus be used to collect various
 * kinds of information. All this information is recorded in struct
 * space_profile records:
 *
 * - at GC of the creation space, we can scan the records to count all
 * allocation.
 * - at all GCs, we can scan the records to count all copying (and
 * therefore survival).
 * - when the user requests, we can scan the records to count all live
 * data [although we don't currently do this].
 *
 * At each of the above times, we can count either just the total
 * allocation size or we can analyse the data allocated into different
 * classes (according to runtime tags and layout).
 *
 * For more comments on how these structures are updated and when, see
 * the comments for the individual struct declarations below. */

/* struct large is substituted for size_t where we want more than 32
 * bits. It allows 52 bits (this number chosen to make conversion into
 * ML values, which use megabyte/byte pairs, easy). */

struct large {
  unsigned long high;	/* top 32 bits */
  unsigned long low;	/* bottom 20 bits */
};

#define HIGH12(x)	((x)>>20)
#define LOW20(x)	(((x)<<12)>>12)

#define inc_large(large,increment)					\
do {									\
  unsigned long l = (large).low+(increment);				\
  (large).high += HIGH12(l);						\
  (large).low = LOW20(l);						\
} while(0)

#define add_large(large1,large2,large3)					\
do {									\
  unsigned long l = (large1).low+(large2).low;				\
  (large3).high = (large1).high + (large2).high + HIGH12(l);		\
  (large3).low = LOW20(l);						\
} while(0)

#define zero_large(large)	do { (large).low = (large).high = 0 } while (0)
#define large_zero_p(large)	(((large).low == 0) && ((large).high == 0))
#define double_large(large) (((double)(large).high)*1048576.0+(large).low)

/* struct space_profile records all space profiling information.
 *
 * 'breakdown' is the bit-vector of breakdown fields requested by ML.
 * 'allocated' is the total amount of data allocated by this function.
 * 'copied' is the amount allocated which has been copied by the GC.
 * 'allocation' is a list of breakdowns of data allocated and
 * 	copied. Each entry on the list shows the data allocated in
 * 	a single generation.
 * 'copies' is a table of the amount copied into each generation.
 *
 * If either of 'allocation' or 'copies' is NULL, we are not gathering
 * that kind of information for this function.
 *
 * When we proceed to doing live data analysis, the following two
 * fields will be added:
 *
 * size_t live;			; total data live 'now'
 * struct space_profile_breakdown *live_info;  ; breakdown of live data
 *
 * 'live' is the amount allocated which is still on the heap.
 * 'live_info' is a list of breakdowns of the data still on the
 * 	heap. The first entry in the list is a total for the heap, the
 * other entries are one per generation.  */

struct space_profile
{
  unsigned int breakdown;		/* breakdown flags requested by ML */
  struct large allocated;		/* total data allocated */
  struct large copied;			/* total data copied by the GC */
  struct space_profile_breakdown *allocation; /* breakdown of allocated data */
  struct space_profile_copies *copies;        /* data copied into each gen */
} *space_profile_total = NULL;

/* struct space_profile_copies is a linked-list table of amounts copied
   into each generation (counting from 1). */

#define GENERATIONS_PER_BLOCK 3

struct space_profile_copies
{
  struct space_profile_copies *next; /* a linked list */
  struct large copied [GENERATIONS_PER_BLOCK];
};

/* struct space_profile_object_count is a set of running totals for a
 * given kind of object: total number of bytes, total number of
 * objects, and number of bytes in overhead (i.e. header word,
 * padding, &c). */

struct space_profile_object_count{
  struct large bytes;
  size_t objects;
  size_t overhead;
};

/* struct space_profile_breakdown is a linked list of per-kind object
 * analyses: a set of running totals for each of several kinds of
 * object. The kinds of object we count are the eight different header
 * tags (record, string, etc,), plus pairs, closures (which we do
 * _not_ count as regular records or pairs), and a total. */

#define OBJECTS_TO_COUNT	   11

#define INDEX_FOR_TOTALS	   10
#define INDEX_FOR_PAIRS		    9
#define INDEX_FOR_CLOSURES	    8

struct space_profile_breakdown
{
  struct space_profile_breakdown *next; /* a linked list */
  struct space_profile_object_count obj[OBJECTS_TO_COUNT];
};

profile_allocator(space_profile, space_profile_data_size)
profile_allocator(space_profile_breakdown, space_profile_data_size)
profile_allocator(space_profile_copies, space_profile_data_size)

/*  == Space profile area descriptor == 
 *
 * There is a linked list of space profile areas for each
 * generation. This list is usually empty.
 */

struct space_profile_area
{
  word *base, *limit;			/* base of area */
  word *top;				/* top of live data */
  struct space_profile_area *next;	/* next in list for this generation */
};

static struct space_profile_area_list
{
  struct ml_heap *gen;
  struct space_profile_area_list *next;
  struct space_profile_area *area;
} *space_profile_areas = NULL,
  *space_profile_free_areas = NULL,
  *space_profile_free_lists = NULL;

/* return a list of space profile areas to the memory manager */

static mydecl void
free_space_profile_area_list(struct space_profile_area_list *list)
{
  while (list != NULL) {
    struct space_profile_area_list *next_list = list->next;
    struct space_profile_area *area = list->area;
    while (area != NULL) {
      struct space_profile_area *next = area->next;
      free(area);
      area = next;
    }
    free(list);
    list = next_list;
  }
}

#ifdef PROFILE_DEBUG
extern mydecl void report_space_profile_areas(void);
mydecl void report_space_profile_areas(void)
{
  struct space_profile_area_list *list;
  struct space_profile_area *area;
  size_t total_size = 0;
  printf("live areas: \n");
  list = space_profile_areas;
  while(list != NULL) {
    total_size += sizeof(struct space_profile_area_list);
    printf(" 0x%x(gen %d)\n",(unsigned)list,list->gen->number);
    area = list->area;
    while( area != NULL) {
      total_size += ((char*)area->limit)-((char*)area);
      printf("  0x%x[0x%x, 0x%x, 0x%x]\n",
	     (unsigned)area, (unsigned)area->base, (unsigned)area->top,
	     (unsigned)area->limit);
      area = area->next;
    }
    list = list->next;
  }
  printf("\nfree areas: \n");
  list = space_profile_free_areas;
  while(list != NULL) {
    total_size += sizeof(struct space_profile_area_list);
    printf(" 0x%x\n",(unsigned)list);
    area = list->area;
    while( area != NULL) {
      total_size += ((char*)area->limit)-((char*)area);
      printf("  0x%x[0x%x, 0x%x]\n",
	     (unsigned)area, (unsigned)area->base, (unsigned)area->limit);
      area = area->next;
    }
    list = list->next;
  }
  printf("\nfree lists: \n");
  list = space_profile_free_lists;
  while(list != NULL) {
    total_size += sizeof(struct space_profile_area_list);
    printf(" 0x%x\n",(unsigned)list);
    area = list->area;
    while( area != NULL) {
      total_size += ((char*)area->limit)-((char*)area);
      printf("  0x%x[0x%x, 0x%x]\n",
	     (unsigned)area, (unsigned)area->base, (unsigned)area->limit);
      area = area->next;
    }
    list = list->next;
  }
  printf("\ntotal size = %d\n",total_size);
}

#endif

/* return all the space profile areas to the memory manager */

static mydecl void free_space_profile_areas(void)
{
  free_space_profile_area_list(space_profile_areas);
  free_space_profile_area_list(space_profile_free_areas);
  free_space_profile_area_list(space_profile_free_lists);
  space_profile_areas = space_profile_free_areas =
    space_profile_free_lists = NULL;
}

/* put the space profile areas (if any) for a given generation
   on the free list */

static mydecl void free_space_profile_area_gen(struct ml_heap *gen)
{
  struct space_profile_area_list **last = &space_profile_areas;
  struct space_profile_area_list *list = *last;
  while(list != NULL) {
    if (list->gen == gen) {
      *last = list->next;	/* remove from the active chain */
      if (list->area == NULL) {
	list->next = space_profile_free_lists;
	space_profile_free_lists = list;
      } else {
	list->next = space_profile_free_areas; /* add to the free list */
	space_profile_free_areas = list;
      }
      return;
    }			 
    last = &list->next;
    list = list->next;
  }
}

/* make a new space_profile_area_list */

static mydecl struct space_profile_area_list *
make_space_profile_area_list(void)
{
  struct space_profile_area_list *result;
  if (space_profile_free_lists == NULL) {
    size_t bytes = sizeof(struct space_profile_area_list);
    result = alloc(bytes, "Space profiling area list");
    space_profile_data_size += bytes;
  } else {
    result = space_profile_free_lists;
    space_profile_free_lists = result->next;
  }
  return result;
}

/* make a new space_profile_area,
   using the size if actual allocation is needed */

static mydecl struct space_profile_area *make_space_profile_area(size_t size)
{
  struct space_profile_area *result;
  if (space_profile_free_areas == NULL) {
    size_t bytes = sizeof(struct space_profile_area) + size * sizeof(word);
    result = alloc(bytes, "Space profiling area");
    space_profile_data_size += bytes;
    result->base = (word*)(result+1);
    result->limit = result->base + size;
  } else {
    struct space_profile_area_list *list = space_profile_free_areas;
    result = list->area;
    list->area = result->next;
    if (list->area == NULL) {
      space_profile_free_areas = list->next;
      list->next = space_profile_free_lists;
      space_profile_free_lists = list;
    }
  }
  result->top = result->base;
  result->next = NULL;
  return result;
}

/* space_profile_area_list(gen) returns NULL if the generation has no
   space profile areas, or a pointer to the space profile area
   list. */

static mydecl
struct space_profile_area_list *space_profile_area_list(struct ml_heap *gen)
{
  struct space_profile_area_list *list = space_profile_areas;
  while(list != NULL && list->gen != gen)
    list = list->next;
  return list;
}

/* first_space_profile_area(gen) returns NULL if the generation has no
   space profile areas, or a pointer to the first such area. */

static mydecl
struct space_profile_area *first_space_profile_area(struct ml_heap *gen)
{
  struct space_profile_area_list *list = space_profile_area_list(gen);
  if (list)
    return list->area;
  else return NULL;
}

/* find_space_profile_area_list(gen) finds the space profile area list
   for gen, if there is one, or creates a new one if there is not. */

static mydecl
struct space_profile_area_list *find_space_profile_area_list (struct ml_heap *gen)
{
  struct space_profile_area_list **where = &space_profile_areas,
                                 *list = *where;
  while(list != NULL && list->gen != gen) {
    where = &list->next;
    list = list->next;
  }
 if (list == NULL) {
   /* add the new entry to the end of the list */
    *where = list = make_space_profile_area_list();
    list->gen = gen;
    list->next = NULL;
    list->area = NULL;
  }
  return list;
}

/* get_space_profile_area(gen,size) finds a space profile area for
   gen with some free space. If there are none, it makes a new one 
   and returns it. If the new one is obtained from the memory manager, it
   is of size 'size'. */

static mydecl
struct space_profile_area *get_space_profile_area (struct ml_heap* gen,
						    size_t size)
{
  struct space_profile_area_list *list = find_space_profile_area_list(gen);
  struct space_profile_area **where = &list->area, *area = list->area;
  while(area != NULL && area->top == area->limit) {
    where = &(area->next);
    area = area->next;
  }
  if (area == NULL)
    *where = area = make_space_profile_area(size);

  return area;
}

/* another_space_profile_area(spa) makes a new space profile area, the
   same size as spa, and puts it on the 'next' chain for spa. */

static mydecl struct space_profile_area *
another_space_profile_area (struct space_profile_area *spa)
{
  struct space_profile_area *result =
    make_space_profile_area((size_t)(spa->limit-spa->base));
  spa->next = result;
  return result;
}

static mydecl void free_space_profile_lists(void)
{
  free_space_profile_list();
  free_space_profile_breakdown_list();
  free_space_profile_copies_list();
  free_space_profile_areas();
}
   
/* space_profile_update_count(br,i,s,o) updates one entry of a space profile
   object count table */

static mydecl
void space_profile_update_count(struct space_profile_breakdown *br,
				int index,
				size_t size,
				size_t overhead)
{
  br->obj[index].objects++;
  inc_large(br->obj[index].bytes, size);
  br->obj[index].overhead += overhead;
}

/* update a breakdown table list with some particular object */

static mydecl
void space_profile_update_breakdown (struct space_profile_breakdown *br,
				     int gen,
				     size_t size,
				     size_t overhead,
				     int index)
{
  while(gen != 0) {
    gen--;
    if (br->next == NULL)
      br->next = make_space_profile_breakdown();
    br = br->next;
  }
  space_profile_update_count(br, index, size, overhead);
  space_profile_update_count(br, INDEX_FOR_TOTALS, size, overhead);
}

/* compute_size(p) is the heap size of the object pointed to by p */

static mydecl size_t space_profile_obj_size(mlval *p)
{
  mlval header = *p;
  if (PRIMARY(header) == HEADER) {
    mlval length = LENGTH(header);
    mlval secondary = SECONDARY(header);
    return double_align(OBJECT_SIZE(secondary,length));
  } else
    return 8;
}

/* space_profile_obj_size_overhead_index(p) should be applied to an
 * mlval *, in a context in which size, overhead, and index are
 * declared. The idea is that this may be called in various contexts
 * when examining a space profile area record, depending on which
 * information we are recording for a given piece of code.
 *
 * We use the do ... while(0) construct so that, for instance, 
 *		if (...)
 *		   space_profile_obj_size_overhead_index(p);
 *		else { ... }
 * will have the expected behaviour */

#define space_profile_obj_size_overhead_index(p)                \
do 								\
{								\
  mlval hdr = *(p);						\
  size = 8, overhead = 0;					\
  index = INDEX_FOR_PAIRS;					\
  								\
  if (PRIMARY(hdr) == HEADER) {					\
    size_t length = LENGTH(hdr);				\
    int secondary = SECONDARY(hdr);				\
    size = double_align(OBJECT_SIZE(secondary,length));		\
    overhead = size - DATA_SIZE(secondary,length);		\
    index = secondary >> 3;					\
    if (secondary == RECORD) {					\
      mlval field0 = (p)[1];					\
      if (PRIMARY(field0) == POINTER &&				\
	  SECONDARY(FIELD(field0,-1)) == BACKPTR)		\
	index = INDEX_FOR_CLOSURES;				\
    }								\
  } else if (PRIMARY(hdr) == POINTER &&				\
	     SECONDARY(FIELD(hdr,-1)) == BACKPTR)		\
    index = INDEX_FOR_CLOSURES;					\
} while (0)							      

static mydecl
size_t space_profile_record_breakdown (struct space_profile_breakdown *br,
				       int gen,
				       mlval *p)
{
  size_t size;
  if (br) {
    size_t overhead;
    int index;
    space_profile_obj_size_overhead_index(p);
    space_profile_update_breakdown(br, gen, size, overhead, index);
    if (space_profile_total->allocation)
      space_profile_update_breakdown(space_profile_total->allocation,
				     gen, size,overhead,index);
  } else {
    size = space_profile_obj_size(p);
  }
  return size;
}

static mydecl
void space_profile_record_copies(struct space_profile_copies *copies,
				 int gen,
				 size_t size)
{
  if (copies) {
    while (gen > GENERATIONS_PER_BLOCK) {
      if (copies->next == NULL)
	copies->next = make_space_profile_copies();
      copies = copies->next;
      gen -= GENERATIONS_PER_BLOCK;
    }
    inc_large(copies->copied[gen-1],size);
  }
}

static mydecl void update_space_profile(struct space_profile *sp,
				       int gen,
				       mlval *p)
{
  if (space_profiling) {
    size_t size = space_profile_record_breakdown(sp->allocation, gen, p);
  
    if (gen == 0) {
      inc_large(sp->allocated, size);
      inc_large(space_profile_total->allocated, size);
    } else {
      inc_large(sp->copied, size);
      space_profile_record_copies(sp->copies, gen, size);
      inc_large(space_profile_total->copied, size);
      space_profile_record_copies(space_profile_total->copies, gen, size);
    }
  }
}

/* follow_forward follows a potentially forwarded pointer; since space
   profile records are processed after GC but before fromspace is
   reused, and since pointers in space profile areas are not treated
   as roots, we potentially need to follow forwarding of these
   pointers */

static mydecl mlval follow_forward(mlval arg)
{
  mlval *object = OBJECT(arg);
  mlval header = object[0];

  if (header == EVACUATED)
    return object[1];
  else
    return arg;
}

static mydecl word * process_creation_space_profile_record(word *spr,
							  word *to)
{
  struct space_profile *sp = (struct space_profile *)*spr;

  if (sp != NULL) {
    mlval object = (mlval)(spr[1]);
    int type = SPACE_TYPE(object);
    if (type == TYPE_ML_STATIC) {
      update_space_profile(sp, 0, (mlval *)object); /* record allocation */

      if ((((word*)object)[-1]) == 0) {	/* marked, so survives */
	/* note: we don't record a copy, as static objects are not copied */
	*to++ = (word)sp;
	*to++ = (word)object;
      }
    } else {
      mlval copied_object = (mlval) OBJECT(follow_forward(object));
      update_space_profile(sp, 0, (mlval *)copied_object);
    
      if (copied_object != object) { /* copied */
	update_space_profile(sp, 1, (mlval *) copied_object);
	*to++ = (word)sp;
	*to++ = (word)copied_object;
      }
    }
  }
  return to;
}
    
static mydecl word * process_space_profile_record (word *spr,
						  word *to,
						  int gen)
{
  struct space_profile *sp = (struct space_profile *)*spr;

  if (sp != NULL) {
    mlval object = (mlval) spr[1];
    int type = SPACE_TYPE(object);
    if (type == TYPE_ML_STATIC) {
      if ((((word*)object)[-1]) == 0) {	/* marked, so survives */
	/* note: we don't record a copy, as static objects are not copied */
	*to++ = (word)sp;
	*to++ = (word)object;
      }
    } else {
      mlval copied_object = (mlval) OBJECT(follow_forward(object));

      if (copied_object != object) { /* copied */
	update_space_profile(sp, gen, (mlval *) copied_object);
	*to++ = (word)sp;
	*to++ = (word)copied_object;
      }
    }
  }
  return to;
}

/* We want a space profile block to fit into one memory block (64k),
   including header and malloc header */

#define SPACE_PROFILE_BLOCK_SIZE 16372

static mydecl void process_creation_space_profile_area(void)
{
  struct space_profile_area *spa_from = first_space_profile_area(creation);
  if (spa_from != NULL) {
    word *record = spa_from->base;
    word *end = spa_from->top;
    struct space_profile_area *spa_to =
      get_space_profile_area(creation->parent, SPACE_PROFILE_BLOCK_SIZE);
    word *limit = spa_to->limit;
    word *top = spa_to->top;
    
    while (record < end) {
      top = process_creation_space_profile_record(record,top);
      record += 2;
      if (top >= limit) {
	spa_to->top = top;
	spa_to = another_space_profile_area(spa_to);
	top = spa_to->top;
	limit = spa_to->limit;
      }
    }
    spa_to->top = top;
  }
}

/* When processing space profile areas for spaces other than the
   creation space, we can reuse the 'from' generations areas for the
   'to' generation. */

static mydecl void process_space_profile_area(struct ml_heap *from,
					      struct ml_heap *to,
					      int number)
{
  struct space_profile_area_list *from_list = space_profile_area_list(from);
  if (from_list != NULL && from_list->area != NULL) {
    struct space_profile_area *from_area, *to_area, **to_where;
    struct space_profile_area_list *to_list;
    word *limit, *top;
    from_area = from_list->area;
    to_list = find_space_profile_area_list(to);
    to_area = to_list->area;

    /* find the end of the to_list, and append the from_list to it */
    to_where = &to_list->area;
    while (*to_where != NULL) {
      to_area = *to_where;
      to_where = &to_area->next;
    }
    *to_where = from_area;

    /* if the last member of the to_list is full, start with the first
     * member of the from_list */
    if (to_area == NULL || to_area->top == to_area->limit) {
      to_area = from_area;
      top = to_area->base;
    } else
      top = to_area->top;
    limit = to_area->limit;

    /* now process everything */
    while (from_area != NULL) {
      word *record = from_area->base;
      word *end = from_area->top;
      
      while (record < end) {
	top = process_space_profile_record(record,top,number);
	record += 2;
	if (top >= limit) {
	  to_area->top = top;
	  to_area = to_area->next;
	  top = to_area->base;
	  limit = to_area->limit;
	}
      }
      from_area = from_area->next;
    }
    /* we've finished; end the to_list and chop off the re-used part
     * of the from_list */
    to_area->top = top;
    from_list->area = to_area->next;
    to_area->next = NULL;
  }
}

  /* Whenever there's any garbage collection, we must correct the
   closure pointers in the creation space profile area. This is done by
   transform_creation_space_profile_closures (below), which converts each
   closure pointer into a pointer to the matching struct
   space_profile. This could possibly be combined with
   process_creation_space_profile_area, above, in the appropriate case.

   The closures may or may not have been copied, and likewise for the
   code items, so we potentially have to follow the evacuation
   pointers. This is done in get_code_vector_from_closure. The code
   items themselves, and their ancillary records, are guaranteed to be
   alive (since the profiling framework declares roots to them all),
   so once we have the code item we don't have to follow any other
   evacuation pointers (it will have been done by the GC). */

static mydecl mlval get_code_vector_from_closure(mlval closure)
{
  mlval code, codevector;
  word *object = OBJECT(closure);
  word header = object[0];
  
  if (header == EVACUATED)
    closure = (mlval)object[1];
  else if (header == 0) {
    mlval *p = object-2;
    while(*p == 0)
      p -= 2;
    if (*p == EVACUATED)
      closure = p[1] + ((byte*)object - (byte*)p);
  }
  code = FIELD(closure,0);
  codevector = FOLLOWBACK(code);
  object = OBJECT(codevector);
  header = object[0];
  if (header == EVACUATED)
    code = object[1] + (code-codevector);
  return code;
}

static mydecl void transform_creation_space_profile_closures(void)
{
  struct space_profile_area *spa_from = first_space_profile_area(creation);
  spa_from->top = CURRENT_THREAD->ml_state.space_profile;
  CURRENT_THREAD->ml_state.space_profile = spa_from->base;
  if (spa_from != NULL) {
    word *start = spa_from->base;
    word *end = spa_from->top;
    while (start < end) {
      mlval closure = (mlval)*start;
      if (MLVALISPTR(closure)) {
	mlval code = get_code_vector_from_closure(closure);
	struct profile *profile = (struct profile *) CCODEPROFILE(code);
	*start = (word)profile->space;
      }
      start += 2;
    }
  }
}
      
extern void pre_gc_space_profile(struct ml_heap *from,
				 struct ml_heap *to,
				 int number)
{
  in_profile = 1;
  /* transform_creation_space_profile_closures() would probably be a lot
     simpler if it were called here. */

  if (space_profile_active) {
    /* Do nothing */
    /* This is the place to do global allocation analysis, which should be
       moved here from gc.c */
  }
  in_profile = 0;
}

extern void post_gc_space_profile(struct ml_heap *from,
				  struct ml_heap *to,
				  int number)
{
  in_profile = 1;
  if (space_profile_active) {
    space_profile_colls++;

    transform_creation_space_profile_closures();

    if (from == creation) {
      process_creation_space_profile_area();
    } else {
      process_space_profile_area(from, to, number+1);
      free_space_profile_area_gen(from);
    }
  }
  in_profile = 0;
}

static mydecl
struct space_profile *construct_space_profile(unsigned int manner)
{
  struct space_profile *sp = make_space_profile();
  sp->breakdown = (manner & PROFILE_BREAKDOWN_MASK) >> PROFILE_BREAKDOWN_SHIFT;
  if (manner & PROFILE_SPACE_COPIES)
    sp->copies = make_space_profile_copies();
  if (sp->breakdown)
    sp->allocation = make_space_profile_breakdown();
  return sp;
}

/* registering and un-registering code to be profiled */

/* there are two circumstances under which this can be called:
 *
 * 1. as profiling is being set up (between space_profile_start and
 *    space_profile_on), when profile_new is being applied to all code
 *    items currently in the heap. In this circumstance, there is not
 *    yet a space_profile_area in which modified code can record
 *    allocations. So we should not (yet) modify any code. This
 *    important because the selector function is being called a lot at
 *    this point, and space_profile_code will be applied to this
 *    function along with every other.
 * 
 *    All the code modifications will be done by space_profile_on,
 *    after it creates a space_profile_area.
 * 
 * 2. after profiling is actually on (so space_profile_active is not
 *    zero), when profile_new is applied to a newly-loaded code item.
 *    In this case, we do want to modify the code right now.
 *
 * See also MLWorks bug report 1808.
 */

static mydecl void space_profile_code(struct profile *profile)
{
  if (profile->manner & PROFILE_SPACE) {
    profile->space = construct_space_profile(profile->manner);
    if (space_profile_active)
      arch_space_profile_code(profile->code);
    space_profile_codes ++;
  }
}

static mydecl void space_unprofile_code(struct profile *profile)
{
  if (profile->manner & PROFILE_SPACE)
    arch_space_unprofile_code(profile->code);
}

/*  === Output ===

    MLWorks space profiler output format

We output space profiler reports in a big table. Here is an example:

----- report begins here -----
MLWorks space profile
28436256 bytes used for profiling
6480 collections
functions profiled : 7011
---
       alloc      copied  name
  6651782992   896813760  total profiled
               784043096    94462784    16240576     1993576       73728
          gen            records       pairs    closures     strings      arrays  bytearrays        code  weakarrays       total
           0     no     87646718   454966160    47886300     1722171    12183592         417           0           0   604405358
               size   1864122920  3639729280   815755184    23821096   306643144     1711368           0           0  6651782992
           overhead    470860984           0   204373348    14255627   152179028        3336           0           0   841672323
           1     no     11175622    59752612       65881      671662     2341354         240           0           0    74007371
               size    229448560   478020896     1218744    10040696    64329240      984960           0           0   784043096
           overhead     61778480           0      298344     5171416    28887428        1920           0           0    96137588
           2     no      1401784     7524234         607       97233      214771           1           0           0     9238630
               size     29145480    60193872        9528     1452336     3657464        4104           0           0    94462784
           overhead      8326220           0        2668      719971     2585768           8           0           0    11634635
           3     no       223062     1325364          79       26642       54962           0           0           0     1630109
               size      4337936    10602912        1128      398864      899736           0           0           0    16240576
           overhead      1176900           0         316      196500      659708           0           0           0     2033424
           4     no        32984      148652          16        4577        7493           0           0           0      193722
               size       609472     1189216         240       70928      123720           0           0           0     1993576
           overhead       155920           0          64       33313       89960           0           0           0      279257
           5     no         1353        3879           5        1148           7           0           0           0        6392
               size        22968       31032          88       19144         496           0           0           0       73728
           overhead         5904           0          20        8763          96           0           0           0       14783
           0           0  decode_sigma[main._encapsulate:1681]<Closure>
       18296        4256  decode_sigenv[main._encapsulate:1689]<Closure>
                    4256
          gen            records       pairs    closures     strings      arrays  bytearrays        code  weakarrays       total
           0     no            0        2287           0           0           0           0           0           0        2287
               size            0       18296           0           0           0           0           0           0       18296
           overhead            0           0           0           0           0           0           0           0           0
           1     no            0         532           0           0           0           0           0           0         532
               size            0        4256           0           0           0           0           0           0        4256
           overhead            0           0           0           0           0           0           0           0           0
           0           0  input_sixtuple argument 5[main._encapsulate:760]<Closure>
      210320       35944  augment_cb[main._toplevel:903]
                   35432         512
          gen            records       pairs    closures     strings      arrays  bytearrays        code  weakarrays       total
           0     no         5258       15774           0           0           0           0           0           0       21032
               size        84128      126192           0           0           0           0           0           0      210320
           overhead        21032           0           0           0           0           0           0           0       21032
           1     no         2209          11           0           0           0           0           0           0        2220
               size        35344          88           0           0           0           0           0           0       35432
           overhead         8836           0           0           0           0           0           0           0        8836
           2     no           32           0           0           0           0           0           0           0          32
               size          512           0           0           0           0           0           0           0         512
           overhead          128           0           0           0           0           0           0           0         128
     1176936      235368  <case><Match0>[main._toplevel:1021]
                  211160       21440        2528         240
          gen            records       pairs    closures     strings      arrays  bytearrays        code  weakarrays       total
           0     no        40085       52892         416           0           0           0           0           0       93393
               size       747144      423136        6656           0           0           0           0           0     1176936
           overhead       213232           0        1664           0           0           0           0           0      214896
           1     no          194       25990           8           0           0           0           0           0       26192
               size         3112      207920         128           0           0           0           0           0      211160
           overhead          780           0          32           0           0           0           0           0         812
           2     no            0        2680           0           0           0           0           0           0        2680
               size            0       21440           0           0           0           0           0           0       21440
           overhead            0           0           0           0           0           0           0           0           0
           3     no            0         316           0           0           0           0           0           0         316
               size            0        2528           0           0           0           0           0           0        2528
           overhead            0           0           0           0           0           0           0           0           0
           4     no            0          30           0           0           0           0           0           0          30
               size            0         240           0           0           0           0           0           0         240
           overhead            0           0           0           0           0           0           0           0           0
    99362096           0  <anon>[harp._registercolourer:457]
          gen            records       pairs    closures     strings      arrays  bytearrays        code  weakarrays       total
           0     no            0    12420262           0           0           0           0           0           0    12420262
               size            0    99362096           0           0           0           0           0           0    99362096
           overhead            0           0           0           0           0           0           0           0           0
       58080           0  parse argument 0[main._toplevel:1274]
          gen            records       pairs    closures     strings      arrays  bytearrays        code  weakarrays       total
           0     no            0           0        2420           0           0           0           0           0        2420
               size            0           0       58080           0           0           0           0           0       58080
           overhead            0           0        9680           0           0           0           0           0        9680
           0           0  <handle>[main._toplevel:1293]
[...]
----- report ends here -----

First come a few lines about the space profiling: how much space it
required for its own data, how many collections it saw, &c. Then comes
the report proper, which is divided into records. Each record has:

- a line giving the total allocation and copying, and the name of the
	allocating function.
- if a struct space_profile_copies is being kept, a line giving the
	amount of copying into each generation.
- if allocation breakdown is being kept, a breakdown report.
  The breakdown report has a header line and then 3 lines per
     generation, which are self-explanatory. */

static void
output_space_profile_copies (struct space_profile_copies *copies)
{
  if (copies != NULL && !large_zero_p(copies->copied[0])) {
    fprintf(profile_options.stream,"            ");
    
    while(copies != NULL) {
      int i = 0;
      while(i < GENERATIONS_PER_BLOCK && !large_zero_p(copies->copied[i])) {
	fprintf(profile_options.stream,"%12.0f",
		double_large(copies->copied[i]));
	i++;
      }
      copies = copies->next;
    }
    fprintf(profile_options.stream,"\n");
  }
}

#define OBJECTS_TO_PRINT	    9

/* Do not print backptrs or header50. */
/* records pairs closures strings arrays bytearrays code weakarrays total */

static int objects_to_print[OBJECTS_TO_PRINT] =
{0,INDEX_FOR_PAIRS,INDEX_FOR_CLOSURES,1,2,3,5,7,INDEX_FOR_TOTALS};

static const char *object_names[OBJECTS_TO_COUNT] = {
  "     records",		/* 0 */
  "     strings",		/* 1 */
  "      arrays",		/* 2 */
  "  bytearrays",		/* 3 */
  "    backptrs",		/* 4 */
  "        code",		/* 5 */
  "    header50",		/* 6 */
  "  weakarrays",		/* 7 */
  "    closures",		/* INDEX_FOR_CLOSURES */
  "       pairs",		/* INDEX_FOR_PAIRS */
  "       total"		/* INDEX_FOR_TOTALS */
};

static char breakdown_heading[OBJECTS_TO_PRINT*12+11] = "gen        ";

static mydecl void space_profile_prepare_breakdown_header(void)
{
  char *to = breakdown_heading+10;
  int i;
  for(i=0; i<OBJECTS_TO_PRINT; i++) {
    (void) strncpy(to, object_names[objects_to_print[i]], 12);
    to += 12;
  }
  *to = '\0';
}

static mydecl void
output_space_profile_breakdown (struct space_profile_breakdown *breakdown)
{
  int i, gen=0;
  if (breakdown != NULL &&
      !large_zero_p(breakdown->obj[INDEX_FOR_TOTALS].bytes)) {
    fprintf(profile_options.stream,"          %s\n",breakdown_heading);
    while(breakdown != NULL) {
      fprintf(profile_options.stream,"          %2u     no ",gen);
      for(i=0; i<OBJECTS_TO_PRINT; i++)
	fprintf(profile_options.stream, "%12u",
		(unsigned)breakdown->obj[objects_to_print[i]].objects);
      fprintf(profile_options.stream,
	      "\n               size ");
      for(i=0; i<OBJECTS_TO_PRINT; i++)
	fprintf(profile_options.stream, "%12.0f",
		double_large(breakdown->obj[objects_to_print[i]].bytes));
      fprintf(profile_options.stream,
	      "\n           overhead ");
      for(i=0; i<OBJECTS_TO_PRINT; i++)
	fprintf(profile_options.stream, "%12u",
		(unsigned)breakdown->obj[objects_to_print[i]].overhead);
      fprintf(profile_options.stream,"\n");
      breakdown = breakdown->next;
      gen++;
    }
  }
}

static mydecl void output_space_profile(struct space_profile *sp,
					const char *name)
{
  if (sp != NULL) {
    fprintf(profile_options.stream,
	    "%12.0f%12.0f  %s\n",double_large(sp->allocated),
	    double_large(sp->copied), name);
    output_space_profile_copies(sp->copies);
    output_space_profile_breakdown(sp->allocation);
  }
}

static mydecl void space_profile_report (void)
{
  struct profile_table *list;

  fprintf(profile_options.stream,
	  "---------------------------------------------------------\n");
  fprintf(profile_options.stream,
	  "MLWorks space profile\n"
	  "%u bytes used for profiling\n"
	  "%u collections\n"
	  "functions profiled : %u\n",
	  (unsigned) space_profile_data_size,
	  space_profile_colls,
	  space_profile_codes);
  
  if (space_profile_codes) {

    /* Should report space profile area sizes here */
    
    space_profile_prepare_breakdown_header();

    fprintf(profile_options.stream,
	    "---\n"
	    "       alloc      copied  name\n");

    if (space_profile_total)
      output_space_profile(space_profile_total,"total profiled");

    list = profile_list;
    while(list != NULL) {
      size_t i;

      for(i=0; i<list->nr_entries; ++i) {
	struct profile *p = &list->table[i];
	const char *name = CSTRING(CCODENAME(p->code));
	output_space_profile(p->space,name);
      }
      list = list->next;
    }
  }
  fprintf(profile_options.stream,
	  "---------------------------------------------------------\n");
}

/* getting results into ML */

/*
(* a key type for amounts of stuff *)

datatype large_size =
  Large_Size of
  {megabytes : int,		1
   bytes : int}			0

*/

static mydecl mlval space_profile_item_large(struct large *l)
{
  mlval result = cons(MLINT(l->low), MLINT(l->high));
  return result;
}

/*

(* an object_breakdown is a breakdown of some allocation according to
 * object kind *)

datatype object_count =
	Object_Count of
	{number : int,		0
	 size : large_size,	2
	 overhead : int}	1

datatype object_kind =
    RECORD	5
  | PAIR	4
  | CLOSURE	2
  | STRING	6
  | ARRAY	0
  | BYTEARRAY	1
  | OTHER	3	(* includes weak arrays, code objects, ?? *)
  | TOTAL	7	(* only used when specifying a profiling manner *)

type object_breakdown = (object_kind * object_count) list

*/

/* in alphabetical order:
 * array, bytearray, closure, 'other', pair, record, string, total */

static int ml_object_index[PROFILE_BREAKDOWN_FIELDS] =
{2, 3, INDEX_FOR_CLOSURES, -1, INDEX_FOR_PAIRS, 0, 1, INDEX_FOR_TOTALS};

/* space_profile_item_object_count uses root 1 */
static mydecl mlval
space_profile_item_object_count(struct space_profile_object_count *ct)
{
  mlval result;
  SPACE_ROOT1 = space_profile_item_large(&ct->bytes);
  result = allocate_record(3);
  FIELD(result,0) = MLINT(ct->objects);
  FIELD(result,1) = MLINT(ct->overhead);
  FIELD(result,2) = SPACE_ROOT1;
  return result;
}

static mydecl mlval
space_profile_item_breakdown_other(struct space_profile_breakdown *breakdown)
{
  struct space_profile_object_count c;
  c.objects = breakdown->obj[5].objects + breakdown->obj[7].objects;
  c.overhead = breakdown->obj[5].overhead + breakdown->obj[7].overhead;
  add_large(breakdown->obj[5].bytes, breakdown->obj[7].bytes, c.bytes);
  return space_profile_item_object_count(&c);
}

static mydecl mlval
space_profile_item_breakdown(unsigned int flags,
			     struct space_profile_breakdown *breakdown)
{
  int i,j,f;
  if (breakdown) {
    mlval this = MLNIL;
    declare_root(&this, 0);
    i = 1;
    j = 0;
    f = flags;
    while(f) {
      if (f & i) {
	int index = ml_object_index[j];
	mlval count =
	  (index == -1 ? 
	   space_profile_item_breakdown_other(breakdown) :
	   space_profile_item_object_count(&breakdown->obj[index]));
	count = cons(MLINT(j),count);
	this = cons(count,this);
	f -= i;
      }
      i = i << 1;
      j++;
    }
    this = cons(this, space_profile_item_breakdown(flags, breakdown->next));
    retract_root(&this);
    return this;
  } else
    return MLNIL;
}

/* space_profile_item_copies uses root 2 */

static mydecl mlval
space_profile_item_copies(struct space_profile_copies *copies)
{
  SPACE_ROOT2 = MLNIL;
  if (copies != NULL) {
    int i = GENERATIONS_PER_BLOCK-1;
    if (copies->next != NULL)
      SPACE_ROOT2 = space_profile_item_copies(copies->next);
    while(i >= 0) {
      if (!large_zero_p(copies->copied[i])) {
	mlval temp = space_profile_item_large(&copies->copied[i]);
	/* Do NOT inline this */
	SPACE_ROOT2 = cons(temp, SPACE_ROOT2);
      }
      i--;
    }
  }
  return SPACE_ROOT2;
}
  
/*
(* the top-level type *)

datatype function_space_profile =
  Function_Space_Profile of
  {allocated : large_size,		0
   copied : large_size,			2
   copies : large_size list,		3
   allocation : object_breakdown list}	1
  
*/
static mlval space_profile_null_item = MLUNIT;

static mlval space_profile_item(struct space_profile *prof)
{
  if (prof) {
    mlval result;
    SPACE_ROOT1 = space_profile_item_breakdown(prof->breakdown,
					       prof->allocation);
    SPACE_ROOT2 = space_profile_item_copies(prof->copies);
    SPACE_ROOT3 = space_profile_item_large(&prof->allocated);
    SPACE_ROOT4 = space_profile_item_large(&prof->copied);
    
    result = allocate_record(4);
    FIELD(result,0) = SPACE_ROOT3;
    FIELD(result,1) = SPACE_ROOT1;
    FIELD(result,2) = SPACE_ROOT4;
    FIELD(result,3) = SPACE_ROOT2;
    return result;
  } else {
    /* not space-profiling this item; return the null record */
    if (space_profile_null_item == MLUNIT) {
      SPACE_ROOT1 = cons(MLINT(-1),MLINT(0));
      space_profile_null_item = allocate_record(4);
      FIELD(space_profile_null_item,0) = SPACE_ROOT1;
      FIELD(space_profile_null_item,1) = MLNIL;
      FIELD(space_profile_null_item,2) = SPACE_ROOT1;
      FIELD(space_profile_null_item,3) = MLNIL;
    }
    return space_profile_null_item;
  }
}

static int space_profile_non_zero(struct space_profile *prof)
{
  if (prof)
    if (!large_zero_p(prof->allocated))
      return 1;
  return 0;
}

/*
datatype space_header = 
  Space of {data_allocated: int,			1
	    functions: int,				2
	    collections: int,				0
	    total_profiled : function_space_profile}	3
*/

static mlval space_profile_header(void)
{
  mlval result;

  SPACE_ROOT1 = space_profile_item(space_profile_total);
  result = allocate_record(4);
  FIELD(result,0) = MLINT(space_profile_colls);
  FIELD(result,1) = MLINT(space_profile_data_size);
  FIELD(result,2) = MLINT(space_profile_codes);
  FIELD(result,3) = SPACE_ROOT1;
  return result;
}

static mlval space_profile_null_header(void)
{
  mlval result;

  SPACE_ROOT1 = space_profile_item(NULL);	/* the null item */
  result = allocate_record(4);
  FIELD(result,0) = MLINT(0);
  FIELD(result,1) = MLINT(0);
  FIELD(result,2) = MLINT(0);
  FIELD(result,3) = SPACE_ROOT1;
  return result;
}

/* The top-level space profiling control functions */

static mydecl void space_profile_init (void)
{
  space_profiling = 0;
  space_profile_active = 0;
}

static mydecl void space_profile_start (void)
{
  space_profile_data_size = 0;
  space_profile_codes = 0;
}

static mydecl void space_profile_on(void)
{
  struct space_profile_area *creation_area;
  struct profile_table *list;

  creation_area = get_space_profile_area(creation, creation->end - creation->start);
  CURRENT_THREAD->ml_state.space_profile = creation_area->base;

  if (profile_manners & PROFILE_SPACE)
    space_profile_total = construct_space_profile(profile_manners);
  else
    space_profile_total = NULL;

  space_profiling = 1;
  space_profile_active = 1;
  space_profile_colls = 0;
  space_profile_null_item = MLUNIT;
  declare_root(&space_profile_null_item, 0);

  /* now modify the code for all items being space profiled. We didn't
   * do this already because there wasn't a space profile area for
   * such modified items to use, and they may be run to determine a
   * profile manner. See MLWorks bug 1808. */

  list = profile_list;
  while(list != NULL) {
    unsigned int i;
    for (i=0; i < list->nr_entries; ++i) {
      struct profile *prof = &list->table[i];
      if (prof->manner & PROFILE_SPACE)
	arch_space_profile_code(prof->code);
    }
    list = list->next;
  }
}

static mydecl void space_profile_off(void)
{
  gc_collect_gen(0);
  space_profiling = 0;
  space_profile_active = 0;
}

static mydecl void space_profile_suspend (void)
{
  gc_collect_gen(0);
  space_profiling = 0;
}

static mydecl void space_profile_resume (void)
{
  space_profiling = 1;
}

static mydecl void space_profile_end (void)
{
  space_profile_null_item = MLUNIT;
  retract_root(&space_profile_null_item);
  space_profile_total = NULL;
  free_space_profile_lists();
  CURRENT_THREAD->ml_state.space_profile = NULL;
}

#ifdef PROFILE_LIVE_DATA

/* ------------------------------------------------------------------------- *
 *  (Prototype) 		Live Data Profiling		(Prototype)
 * ------------------------------------------------------------------------- */
/* This code relates to the recording of live data. It has never been
 * used and is somewhat out of date. */

/* Counting live data: this is called between garbage collections, so
   the creation space profile area still contains closures. */

static mydecl void count_live_data(struct space_profile *sp,
				   int gen,
				   mlval *p)
{
  sp->live += record_breakdown(sp->live_info, gen, p);
}

static mydecl void count_creation_live_data (void)
{
  struct space_profile_area *sp = creation->profile;
  if (sp != NULL) {
    mlval *spr = (mlval *) sp->base;
    mlval *limit = (mlval *) sp->limit;
    
    while(spr < limit) {
      mlval closure = *spr;
      mlval code = FIELD(closure,0);
      struct profile *prof = (struct profile *) CCODEPROFILE(code);
      if (prof != NULL) {
	struct space_profile *sp = (struct space_profile *)prof->space;
	if (sp != NULL) {
	  mlval *object = (mlval*)spr[1];
	  count_live_data(sp,0,object);
	}
      }
      spr += 2;
    }
  }
}

static mydecl void count_live_data_gen (struct ml_heap *gen)
{
  struct space_profile_area *spa = gen->profile;
  int number = gen->number;
  while (spa != NULL) {
    mlval *spr = (mlval *) spa->base;
    mlval *top = (mlval *) spa->top;
    
    while(spr < top) {
      struct space_profile *prof = (struct space_profile *) *spr;
      if (prof != NULL) {
	mlval *object = (mlval*)spr[1];
	count_live_data(prof,number,object);
      }
      spr += 2;
    }
    spa = spa->next;
  }
}

static mydecl void zero_count(struct space_profile_object_count *c)
{
  zero_large(c->bytes);
  c->objects = 0;
  c->overhead = 0;
}

static mydecl void zero_live_data(struct space_profile *sp)
{
  struct space_profile_breakdown *br = sp->live_info;
  sp->live = 0;
  while (br != 0) {
    size_t i;
    for (i=0; i < OBJECTS_TO_COUNT; i++)
      zero_count(&(br->obj[i]));
    br = br->next;
  }
}

static mydecl void zero_all_live_data(void)
{
  struct profiles_table *list = space_profiles_list;
  while(list != NULL) {
    size_t i;
    for (i=0; i < list->nr_entries; i++)
      zero_live_data(&(list->table[i]));
    list = list->next;
  }
}

static mydecl void count_all_live_data(void)
{
  struct ml_heap *gen = creation->parent;
  struct space_profile *old_space_profile_total = space_profile_total;
  space_profile_total = make_space_profile();
  count_creation_live_data();
  while(gen != NULL)
    count_live_data_gen(gen);

  /* output the live data here */

  space_profile_total = old_space_profile_total;
}

#endif

/* ------------------------------------------------------------------------- *
 *			     Call-count profiling
 * ------------------------------------------------------------------------- */

/* 
 * The profiler works by keeping a 'struct profile' (see below) for
 * each profiled code vector. This is pointed to by the 'profiles'
 * slot of the ancillaries for that code object. If the code vector
 * was compiled for tracing and call-counting, it is intercepted (by
 * calling intercept.c:code_intercept(), in profile_code() below), and
 * the intercept code increments the call count in the 'struct
 * profile'. (see intercept.c:count_call()). Call counting slows code
 * down substantially (each function entry point calls into C - many
 * tens of instructions - to increment the call count).
 * 
 */

/*  == Change code for call-count profiling ==
 *
 *  This code inserts the interception code to the profiled code vectors.
 *  profile_code() performs whatever changes are necessary.
 *  unprofile_code() removes those changes.
 *
 *  IMPORTANT: Call-count profiling must interact sensibly with
 * tracing, which uses code vector interception.  If the code is not
 * already intercepted then the profiler intercepts it.  If it is
 * already intercepted (or replaced) then nothing need be done because
 * the code in intercept.c increments the call count if the PROFILE
 * ancillary is set.  */

static void call_profile_code(struct profile *profile)
{
  if (profile->manner & PROFILE_CALLS) {
    mlval code = profile->code;
    if(CCODE_CAN_INTERCEPT(code) && CCODEINTERFN(code) == MLUNIT) {
      code_intercept(code);
      call_profile_codes++;
      return;
    }
  }
  profile->calls = (unsigned int) -1;
}

static void call_unprofile_code(struct profile *profile)
{
  if (profile->manner & PROFILE_CALLS) {
    mlval code = profile->code;
    if((profile->calls != (unsigned int) -1) &&
       CCODE_CAN_INTERCEPT(code) &&
       CCODEINTERFN(code) == MLUNIT) {
      code_nop(code);
    }
  }
}

/*
   datatype call_header = 
   Call of {functions : int}
*/

static mlval call_profile_header(void)
{
  mlval result = allocate_record(1);
  FIELD(result,0) = MLINT(call_profile_codes);
  return result;
}

static mlval call_profile_null_header(void)
{
  mlval result = allocate_record(1);
  FIELD(result,0) = 0;
  return result;
}

static void call_profile_init(void)
{ /* Do nothing */
}

static void call_profile_start(void)
{ 
  call_profile_codes = 0;
}

static void call_profile_on(void)
{ /* Do nothing */
}

static void call_profile_off(void)
{ /* Do nothing */
}

static void call_profile_end(void)
{ /* Do nothing */
}

static void call_profile_suspend(void)
{ /* when profiling is suspended, we must unprofile all code items */
  struct profile_table *list = profile_list;
  while(list != NULL) {
    size_t i;

    for(i=0; i<list->nr_entries; ++i)
      call_unprofile_code(&list->table[i]);

    list = list->next;
  }
}

static void call_profile_resume(void)
{ /* when profiling is resumed, we must reprofile all code items */
  struct profile_table *list = profile_list;
  while(list != NULL) {
    size_t i;

    for(i=0; i<list->nr_entries; ++i)
      call_profile_code(&list->table[i]);

    list = list->next;
  }
}

/* ------------------------------------------------------------------------- *
 *			     Cost-centred profiling
 * ------------------------------------------------------------------------- */

static void centre_profile_report(void)
{
  fprintf(profile_options.stream,
	  "---------------------------------------------------------\n");
  fprintf(profile_options.stream,
	  "MLWorks cost-centred profile\n"
	  "Not yet implemented.\n");
  fprintf(profile_options.stream,
	  "---------------------------------------------------------\n");
}

static mlval centre_profile_header(void)
{
  return MLUNIT;
}

static mlval centre_profile_null_header(void)
{
  return MLUNIT;
}

static mlval centre_profile_result(void)
{
  return MLNIL;
}

static void centre_profile_init(void)
{
}

static void centre_profile_start(void)
{
}

static void centre_profile_on(void)
{
}

static void centre_profile_off(void)
{
}

static void centre_profile_end(void)
{
}

static void centre_profile_suspend(void)
{
}

static void centre_profile_resume(void)
{
}

/* ------------------------------------------------------------------------- *
 *			     General profiling control
 * ------------------------------------------------------------------------- */

/*  == Globals ==
 *
 *  profile_suspended	see profiler.h
 *  profile_on          1 if profiling, 0 otherwise
 *  start, stop		profiler clock start and stop times,
 *  gaps		the time spent suspended
 *  profile_roots       how many roots have we declared
 *  profile_codes	how many code items are profiled in some way
 */

int profile_suspended;
int profile_on;
static double start, stop, gaps;
static unsigned int profile_roots, profile_codes;

/*  == Add code vector to profiler tables ==
 * 
 * profile_new is weak_apply()ed to all code already loaded when
 * profiling is started. It takes an unused "index" argument to give
 * it the right type for weak_apply.
 * 
 * profile_new_loader is a wrapper for profile_new which can be
 * installed in loader_code_observer when profiling is on, to get
 * applied to any new code items loaded during profiling.
 */


static mlval profile_new(unsigned int index, mlval code)
{
  int old_in_profile = in_profile;
  declare_root(&code, 0);
  in_profile = 1;
  if((struct profile *)CCODEPROFILE(code) != NULL)
    error("The code item 0x%X was introduced to the profiler twice.", code);
  else {
    /* this may call ml, so we need to be GC safe. Also see MLWorks bug 1808 */
    int manner = (profile_options.manner)(code);
    if (manner) {
      struct profile *profile = make_profile();
      profile_codes++;

      profile->code = code;
      declare_root(&profile->code, 0);
      profile_roots++;
      profile->manner = manner;
      profile->calls = 0;

      CCODE_SET_PROFILE(code, (mlval)profile);
      call_profile_code(profile);
      time_profile_code(profile);
      space_profile_code(profile);
      profile_manners |= manner;
    }
  }
  in_profile = old_in_profile;
  retract_root(&code);
  return code;
}

static void profile_new_loader(mlval code)
{
  (void)profile_new(0,code);
}


/*  === PROFILING CONTROL ===
 *
 *  A period of time is profiled by calling profile_begin() before it, and
 *  profile_end() after it.
 *
 *  The begin routine initialises the profiler tables, using the list of all
 *  current code vectors.  It then starts the time and space profiling.
 *
 *  The end code returns or reports the collected information in the
 *  profiler table and deallocates it.
 */

/* start profiling */

extern int profile_begin(struct profile_options *options)
{
  DIAGNOSTIC(1, "profile(options = 0x%X)", options, 0);

  if(profile_on)
  {
    DIAGNOSTIC(1, "  already running!", 0, 0);
    errno = EPROFILENEST;
    return(-1);
  }

  in_profile = 1;
  profile_on = 1;
  profile_manners = 0;
  profile_suspended = 0;
  profile_roots = 0;
  profile_data_size = 0;
  profile_codes = 0;

  time_profile_start();
  space_profile_start();
  call_profile_start();
  centre_profile_start();

  loader_code_observer = profile_new_loader;
  profile_options = *options;

  weak_apply(loader_code, profile_new);

  space_profile_on();
  call_profile_on();
  centre_profile_on();
  time_profile_on();

  start = user_clock();
  gaps = 0.0;
  in_profile = 0;
  return(0);
}

/* suspend and resume; not currently used but they're nice to have */

extern int profile_suspend(void)
{
  if(!profile_on) {
    errno = EPROFILENEST;
    return(-1);
  }
  in_profile = 1;
  if(profile_suspended++) {
    stop = user_clock();
    time_profile_suspend();
    space_profile_suspend();
    call_profile_suspend();
    centre_profile_suspend();
  }
  in_profile = 0;
  return(0);
}

extern int profile_resume(void)
{
  if(!profile_on)
  {
    errno = EPROFILENEST;
    return(-1);
  }
  in_profile = 1;
  if(!--profile_suspended)
  {
    double suspend = user_clock();
    gaps += suspend-stop;
    space_profile_resume();
    call_profile_resume();
    centre_profile_resume();
    time_profile_resume();
  }
  in_profile = 0;
  return(0);
}

static void profile_report(void)
{
  long profile_time = (long)((stop - gaps - start) / (double)1000);

  fprintf(profile_options.stream,
	  "MLWorks profiler report\n"
	  "%u bytes of data used for profiling control\n"
	  "profile period: %lu ms\n"
	  "functions profiled : %u\n",
	  (unsigned int)profile_data_size,
	  profile_time, profile_codes);

  centre_profile_report();
  time_profile_report();
  space_profile_report();
}

/*
   datatype general_header = 
   General of {data_allocated: int,			0
	       period: MLWorks.Time.Interval.T,		1
	       suspended: MLWorks.Time.Interval.T}	2
*/

static mlval mlw_time_microseconds(double t)
{
  long tv_sec =  (long)(t / 1000000);
  long tv_usec = (long)(t - ((double)tv_sec * 1000000.0));
  return (mlw_time_make(tv_sec, tv_usec));
}

static mlval profile_header(void) /* uses roots 2 and 3 */
{
  mlval result;
  
  GEN_ROOT2 = mlw_time_microseconds(stop-start);
  GEN_ROOT3 = mlw_time_microseconds(gaps);
  result = allocate_record(3);

  FIELD(result,0) = MLINT(profile_data_size);
  FIELD(result,1) = GEN_ROOT2;
  FIELD(result,2) = GEN_ROOT3;
  return result;
}

static mlval profile_null_header(void) /* uses root 2 */
{
  mlval result;
  GEN_ROOT2 = mlw_time_make(0, 0);
  result = allocate_record(3);
  FIELD(result,0) = 0;
  FIELD(result,1) = GEN_ROOT2;
  FIELD(result,2) = GEN_ROOT2;
  return result;
}

/*
   datatype function_profile =
   Function_Profile of {id: function_id,		1
		        call_count: int,		0
		        time: function_time_profile,	3
		        space: function_space_profile}	2
 */

static mlval profile_result_functions(void) /* uses roots 1-4 */
{
  struct profile *prof;
  struct profile_table *list;

  GEN_ROOT4 = MLNIL;

  list = profile_list;
  while(list != NULL) {
    unsigned int i;
    for (i=0; i < list->nr_entries; ++i) {
      prof = &list->table[i];
      if (space_profile_non_zero(prof->space) ||
	  time_profile_non_zero(prof->time)) {
	GEN_ROOT1 = space_profile_item(prof->space);
	GEN_ROOT2 = time_profile_item(prof->time);
	GEN_ROOT3 = allocate_record(4);
	FIELD(GEN_ROOT3,0) = MLINT(prof->calls);
	FIELD(GEN_ROOT3,1) = CCODENAME(prof->code);
	FIELD(GEN_ROOT3,2) = GEN_ROOT1;
	FIELD(GEN_ROOT3,3) = GEN_ROOT2;
	GEN_ROOT4 = cons(GEN_ROOT3,GEN_ROOT4);
      }
    }
    list = list->next;
  }
  return GEN_ROOT4;
}

/*
   datatype profile =
   Profile of  {general: general_header,		4
	        call: call_header,			0
	        time: stack_header,			6
	        space: space_header,			5
	        cost: cost_header,			2
	        functions: function_profile list,	3
	        centres: cost_centre_profile list}	1
*/

static mlval profile_result(void)
{
  mlval result;
  declare_profiler_roots();

  GEN_ROOT1 = profile_result_functions();
  GEN_ROOT2 = profile_header();
  GEN_ROOT3 = call_profile_header();
  GEN_ROOT4 = time_profile_header();
  GEN_ROOT5 = space_profile_header();
  GEN_ROOT6 = centre_profile_header();
  GEN_ROOT7 = centre_profile_result();

  result = allocate_record(7);
  FIELD(result,0) = GEN_ROOT3;
  FIELD(result,1) = GEN_ROOT7;
  FIELD(result,2) = GEN_ROOT6;
  FIELD(result,3) = GEN_ROOT1;
  FIELD(result,4) = GEN_ROOT2;
  FIELD(result,5) = GEN_ROOT5;
  FIELD(result,6) = GEN_ROOT4;

  retract_profiler_roots();
  return result;
}

static mlval profile_null_result(void)
{
  mlval result;

  declare_profiler_roots();

  GEN_ROOT1 = profile_null_header();
  GEN_ROOT2 = call_profile_null_header();
  GEN_ROOT3 = time_profile_null_header();
  GEN_ROOT4 = space_profile_null_header();
  GEN_ROOT5 = centre_profile_null_header();

  result = allocate_record(7);
  FIELD(result,0) = GEN_ROOT2;
  FIELD(result,1) = MLNIL;
  FIELD(result,2) = GEN_ROOT5;
  FIELD(result,3) = MLNIL;
  FIELD(result,4) = GEN_ROOT1;
  FIELD(result,5) = GEN_ROOT4;
  FIELD(result,6) = GEN_ROOT3;

  retract_profiler_roots();
  return result;
}  


/* finish profiling and print the profile report */

extern int profile_end(mlval *result)
{
  struct profile_table *list;

  if(!profile_on) {
    errno = EPROFILENEST;
    return(-1);
  }
  in_profile = 1;
  stop = user_clock();

  time_profile_off();
  space_profile_off();
  call_profile_off();
  centre_profile_off();

  if (profile_options.stream) {
    profile_report();
    *result = MLUNIT;
  } else {
    *result = profile_result();
  }

  /* unprofile everything, retract the roots, free the structures */

  list = profile_list;
  while(list != NULL) {
    unsigned int i;
    for (i=0; i < list->nr_entries; ++i) {
      struct profile *prof = &list->table[i];
      time_unprofile_code(prof);
      space_unprofile_code(prof);
      call_unprofile_code(prof);
      CCODE_SET_PROFILE(prof->code, MLUNIT);
      retract_root(&prof->code);
    }
    list = list->next;
  }

  time_profile_end();
  space_profile_end();
  call_profile_end();
  centre_profile_end();
  free_profile_list();
  loader_code_observer = NULL;
  profile_on = 0;
  profile_manners = 0;
  profile_options.interval = 0;
  profile_options.manner = NULL;
  profile_options.stream = NULL;
  in_profile = 0;
  return 0;
}


/* ------------------------------------------------------------------------- *
 *			     ML profiling interface
 * ------------------------------------------------------------------------- */

static mlval profile_selector;
static int profile_manner(mlval code)
{
  mlval ml_manner = callml(CCODENAME(code),profile_selector);

  return (CINT(ml_manner));
}

/*
(* mechanisms for the user to specify how a function should be
 * profiled *)

datatype space_profile_manner =
  Space_Profile_Manner of
  {record_copying : bool,
   record_breakdown : object_kind list}

datatype time_profile_manner =
  Time_Profile_Manner of
  {depth: int		(* this could be hard to implement *)
  }

datatype manner =
  {time:  time_profile_manner Option.option,
   space: space_profile_manner Option.option}
*/

/*
 * ML profiling.
 *
 * Called by MLWorks.Profile.profile, q.v.
 * It passes a tuple:
 *
 * - scan : int
 * - manner : fn_id -> ml_manner
 * - wrapper    : unit -> 'a
 *
 * Inside the profile, wrapper is applied to unit. (wrapper is so
 * constructed - in the definition of MLWorks.Profile.profile - as to
 * encapsulate exceptions in the result, not allowing them to escape).
 * After profiling, the result of this application is returned.
 *
 * If we are already profiling, a warning is output and no additional
 * profiling is done.
 */

static mlval ml_profile(mlval argument)
{
  struct profile_options options;
  mlval result, profiled_function, profile;

  profiled_function = FIELD(argument,2);
  declare_root (&profiled_function, 0);

  if (!profile_on) {
    /* we're not already profiling: */

    /* use the ML profile selector (defined above) */
    profile_selector = FIELD(argument,1);
    declare_root(&profile_selector, 0);

    /* set up the profile options */
    options.interval = CINT(FIELD(argument, 0));
    options.stream = NULL;
    options.manner = profile_manner;

    /* start the profiler */
    if(profile_begin(&options)) {       /* error starting the profiler */
      retract_root (&profile_selector);
      retract_root (&profiled_function);
      exn_raise_string(perv_exn_ref_profile,
		       "Unexpected error from profile_begin()");
    }
			    
    /* call the profiled function */
    result = callml(MLUNIT, profiled_function);
    declare_root (&result, 0);

    /* stop the profiler */
    if(profile_end(&profile)) {		/* error stopping the profiler */
      retract_root (&profile_selector);
      retract_root (&profiled_function);
      exn_raise_string(perv_exn_ref_profile,
		       "Unexpected error from profile_end()");
    }
    declare_root(&profile, 0);
    retract_root (&profile_selector);
  } else {
    /* we're already profiling */
    /* print a warning */
    message("Attempt to profile while already profiling.\n");
    /* call the function */
    result = callml(MLUNIT, profiled_function);
    declare_root(&result, 0);
    profile = profile_null_result();
    declare_root(&profile, 0);
  }

  retract_root (&profiled_function);
  result = cons(result,profile);
  retract_root(&result);
  retract_root(&profile);
  return(result);
}

/*  === Initialise ===
 *
 *  Initialise the profiler global state.
 */

void profile_init(void)
{
  profile_options.interval = 0;
  profile_options.manner = NULL;
  profile_options.stream = NULL;
  profile_on = 0;
  profile_suspended = 0;
  time_profile_init();
  space_profile_init();
  call_profile_init();
  centre_profile_init();

  env_function("profile",ml_profile);
}
