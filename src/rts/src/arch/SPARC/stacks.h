/*  === SPARC STACK ROUTINES ===
 *
 *  Copyright (C) 1994 Harlequin Ltd
 *
 *  Description
 *  -----------
 * All architecture-dependent routines that deal with the stack.
 *
 *  Revision Log
 *  ------------
 *  $Log: stacks.h,v $
 *  Revision 1.6  1998/02/24 17:24:24  jont
 *  [Bug #70018]
 *  Split stack_crawl into two phases
 *  First phase turns return addresses into offsets
 *  Second phase fixes the stack, including the return offsets
 *
 * Revision 1.5  1996/02/12  13:11:55  nickb
 * Add heap-exploration hooks.
 *
 * Revision 1.4  1995/05/05  08:31:22  nickb
 * Add is_stack_top
 *
 * Revision 1.3  1995/03/15  14:49:51  nickb
 * Introduce the threads system.
 *
 * Revision 1.2  1994/06/09  14:29:24  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:53:50  nickh
 * new file
 *
 *
 */

#ifndef stacks_h
#define stacks_h

#include "types.h"
#include "mltypes.h"
#include "threads.h"

/*  == Sparc stack frame == */

struct stack_frame
{
  word l0, l1, l2, l3, l4, l5, l6, l7;
  word i0, closure, i2, i3, i4, i5;
  struct stack_frame *fp;
  word lr;
};

/* stack_crawl is part of the GC. It crawls over the stack, fixing up
 * ML values, using the macros in fixup.h
 * The first phase converts return addresses into code offsets,
 * in case the code moves.
 * The second phase does all the fixup work, including
 * converting the return offsets back into addresses.
 */

extern void stack_crawl_phase_one(void);
extern mlval *stack_crawl_phase_two(mlval *to);

/*  == Stack backtrace ==  */

extern int max_backtrace_depth;

extern void backtrace(struct stack_frame *sp, struct thread_state *thread,
		      int depth_max);

/* This macro and function can be used for crawling around on a stack
 * (e.g. in the profiler) */

/* is_stack_top(sp,thread) is true if sp is the top of the stack for
   that thread; i.e. sp does not point to a genuine frame. */

#define is_stack_top(sp, thread)     ((sp) == NULL)

/* is_ml_frame(sp) returns the code item of the closure contained
 * within the indicated frame, or MLUNIT if there is no such
 * closure. It should only be called if is_stack_top(sp,thread) is
 * false */

extern mlval is_ml_frame(struct stack_frame *sp);

#ifdef EXPLORER

/* explore_stacks() scans the stacks, locating GC roots for the
 * explorer.  It calls explore_stack_registers() on each area of
 * GCable registers, and explore_stack_allocated(begin,end) on each
 * stack allocated area */

extern void explore_stacks(void);

#endif

extern void stacks_init(void);

#endif
