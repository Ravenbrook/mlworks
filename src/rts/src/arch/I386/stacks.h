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
 *  Revision 1.7  1998/03/03 17:13:20  jont
 *  [Bug #70018]
 *  Split stack_crawl into two phases
 *
 * Revision 1.6  1996/10/04  15:23:52  stephenb
 * Add a cross reference to some mlworks mail about the lr field
 * in the stack_frame.
 *
 * Revision 1.5  1996/02/14  12:52:45  nickb
 * Add heap-exploration hooks.
 *
 * Revision 1.4  1995/05/05  08:33:13  nickb
 * Add is_stack_top
 *
 * Revision 1.3  1995/03/15  14:51:55  nickb
 * Introduce the threads system.
 *
 * Revision 1.2  1994/10/07  11:03:13  jont
 * Make it Intel architecture specific
 *
 *
 */

#ifndef stacks_h
#define stacks_h

#include "types.h"
#include "mltypes.h"
#include "threads.h"
#include <stdio.h>

/* An ML stack frame for the Intel 386.
 *
 * Note that the lr field does not really contain the return address.
 * The return address is really at the top of the frame i.e.
 * in ((word *)(sp->fp))-4, since that is where the CALL instruction
 * puts it.
 *
 * Why is the lr field here if it isn't used?  Well once it was used,
 * and since it was discovered it probably isn't, nobody has taken the time 
 * to ensure that nothing breaks if it is taken out.  See
 * mlworks.mail.823[234] for the source of this tidbit of information.
 * - stephenb
 */

struct stack_frame
{
  struct stack_frame *fp;
  word closure;
  word lr;			/* not the return address, see above */
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

extern void backtrace(struct stack_frame *sp,
		      struct thread_state *thread,
		      int depth_max);

/* This macro and function can be used for crawling around on a stack
 * (e.g. in the profiler) */

/* is_stack_top(sp,thread) is true if sp is the top of the stack for
   that thread; i.e. sp does not point to a genuine frame. */

#define is_stack_top(sp, thread)     ((!(sp)) ||			      \
				      ((word)(sp) ==			      \
				       (thread)->ml_state.stack_top))

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
