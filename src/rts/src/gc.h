/*  === GARBAGE COLLECTOR ===
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *
 *  Revision Log
 *  ------------
 *  $Log: gc.h,v $
 *  Revision 1.20  1998/04/27 13:43:44  jont
 *  [Bug #70032]
 *  gen->values now measured in bytes
 *
 * Revision 1.19  1998/04/23  13:29:11  jont
 * [Bug #70034]
 * Rationalising names in mem.h
 *
 * Revision 1.18  1998/03/19  10:45:21  jont
 * [Bug #70018]
 * Fix compiler warnings
 *
 * Revision 1.17  1998/03/02  13:22:04  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.16  1996/07/03  13:24:13  nickb
 * Correct comment for declare_/retract_ root.
 *
 * Revision 1.15  1996/02/19  14:13:28  nickb
 * Change prototype for gc_clean_image.
 *
 * Revision 1.14  1996/02/12  12:58:31  nickb
 * Add heap-exploration hooks.
 *
 * Revision 1.13  1996/01/16  11:57:13  nickb
 * Remove "storage manager" interface; replace it with regular functions.
 *
 * Revision 1.12  1996/01/11  14:51:34  nickb
 * Remove gc-triggered window updates; these are now done by a timer.
 *
 * Revision 1.11  1995/09/26  10:31:47  jont
 * Add SM_EXEC_IMAGE_SAVE
 *
 * Revision 1.10  1995/09/13  12:32:18  jont
 * Add parameter to sm_interface to control whether stack_crawl is done
 *
 * Revision 1.9  1995/09/13  11:18:05  nickb
 * Add SM_PROMOTE_ALL
 *
 * Revision 1.8  1995/06/16  15:42:13  nickb
 * Make CREATION_SIZE visible.
 *
 * Revision 1.7  1995/04/24  13:13:05  nickb
 * Add SM_WINDOW_UPDATES
 *
 * Revision 1.6  1995/04/05  13:33:58  nickb
 * Add maximum memory use reporting.
 *
 * Revision 1.5  1994/07/15  09:27:46  nickh
 * Add simple garbage collection counter.
 *
 * Revision 1.4  1994/07/01  15:22:23  nickh
 * Add more analysis code.
 *
 * Revision 1.3  1994/06/22  12:48:28  nickh
 * Add heap analysis code.
 *
 * Revision 1.2  1994/06/09  14:47:58  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:19:51  nickh
 * new file
 *
 *  Revision 1.17  1992/07/31  14:12:50  richard
 *  Added `creation'.  There are many underlying changes -- see gc.c.
 *
 *  Revision 1.16  1992/07/10  14:25:51  richard
 *  Removed redundent GC statistics.  See storeman.h.
 *
 *  Revision 1.15  1992/06/30  09:40:30  richard
 *  Removed most declarations to storeman.h in order to make storage
 *  manager replaceable.
 *
 *  Revision 1.14  1992/05/15  14:35:06  clive
 *  Added timers and code for compiling the make system
 *
 *  Revision 1.13  1992/05/13  13:08:23  clive
 *  Added code to allow memory profiling
 *
 *  Revision 1.12  1992/04/06  08:46:51  richard
 *  Added weak roots.
 *
 *  Revision 1.11  1992/03/23  13:16:03  richard
 *  Added `gc_stat_stream'.
 *
 *  Revision 1.10  1992/03/19  16:44:21  richard
 *  Documented and moved generation size macros to mem.h.
 *
 *  Revision 1.9  1992/03/12  16:58:03  richard
 *  Added in_ML here.  Needs documentation.
 *
 *  Revision 1.8  1992/03/12  11:44:16  richard
 *  Major revision: generations are now generalized to contain any number
 *  of spaces.  In particular this effects the GENBLKS and GENSPACES
 *  parameters specified here.
 *
 *  Revision 1.7  1992/03/10  12:42:33  richard
 *  Added missing parentheses to macros for generation sizes.
 *
 *  Revision 1.6  1992/02/24  16:19:56  clive
 *  Needed more roots
 *
 *  Revision 1.5  1992/01/27  14:54:54  richard
 *  Added gc_message_level to control collection messages.  Added
 *  macros which control generation sizes.  These should be tuned when we
 *  have some real programs running.
 *
 *  Revision 1.4  1992/01/14  15:30:30  richard
 *  Added MAX_NR_ROOTS.
 *
 *  Revision 1.3  1991/12/17  16:08:54  nickh
 *  Moved declare_root and retract_root to here.
 *
 *  Revision 1.2  91/11/28  15:44:07  richard
 *  Added a missing #include statement.
 *  
 *  Revision 1.1  91/10/29  17:00:56  davidt
 *  Initial revision
 */

#ifndef gc_h
#define gc_h

#include "types.h"
#include "values.h"
#include "mem.h"

#include <stddef.h>
#include <stdio.h>
#include <time.h>

/* The newest generation */

extern struct ml_heap *creation;

/*  == Garbage collection ==
 *
 *  This function is called when ML requires space for a new object and
 *  cannot allocate it directly using the heap start and heap limit
 *  pointers.
 */

extern void gc(size_t space_required, mlval closure);

/*  == C roots ==
 *
 *  C data (e.g. variables) which contain ML values which may refer
 *  onto the heap must be declared as `roots' so that the garbage
 *  collector can fix them. A root is declared by passing its address
 *  to declare_root(). If an object on the heap pointed to by a root
 *  is moved the root is updated as well.
 *
 *  NOTE: Be careful not to cache roots in other variables as they may
 *  change. Be careful to retract roots which drop out of scope. */

extern void declare_root(mlval *root, int live_for_image_save);
extern void retract_root(mlval *root);

/*  == Statistical output ==
 *
 *  If `gc_stat_stream' is not NULL it may be used as a stream to which
 *  garbage collection statistics are written.  It is initialised to
 *  be the file supplied to the `-gcstatistics' option.
 */

extern FILE *gc_stat_stream;

#ifdef COLLECT_STATS

/*  == Statistics collection ==
 *
 *  We measure the maximum size of the heap between GCs
 */

extern size_t max_heap_size;

#endif

/*  == GC running flag ==
 *  
 *  This integer is incremented when the GC is entered and decremeneted
 *  when it returns.
 */

extern int in_GC;

/*  == GC timing ==
 *  
 *  The user time (in microseconds) spent garbage collecting.
 */

extern double gc_clock;

#ifdef EXPLORER

/* explore_roots() applies explore_root to each GC root */

extern void explore_roots(void);

/* explore_heap() applies explore_heap_area to each area of the heap */

extern void explore_heap(void);

#endif

/* Miscellaneous GC functions */

extern void gc_collect_gen(unsigned int number);
extern void gc_collect_all(void);
extern void gc_promote_all(void);

extern mlval gc_collections(mlval unit);

extern void gc_clean_image(mlval package);

extern int live_in_gen(struct ml_heap *gen, mlval *value);

#ifdef DEBUG
extern void gc_analyse_heap(void);
extern void gc_analyse_creation_start(void);
extern void gc_analyse_creation_stop(void);
#endif

#endif
