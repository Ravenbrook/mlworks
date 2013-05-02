/*  === MIPS STACK ROUTINES ===
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
 * All architecture-dependent routines that deal with the stack.
 *
 *  Revision Log
 *  ------------
 *  $Log: stacks.h,v $
 *  Revision 1.6  1998/03/03 17:13:01  jont
 *  [Bug #70018]
 *  Split stack_crawl into two phases
 *
 * Revision 1.5  1996/02/14  12:09:52  nickb
 * Add heap-exploration hooks.
 *
 * Revision 1.4  1995/05/02  15:06:04  nickb
 * Add macros for determining ML-ness of frames and top of stack.
 *
 * Revision 1.3  1995/03/15  14:50:57  nickb
 * Introduce the threads system.
 *
 * Revision 1.2  1994/07/13  15:59:33  jont
 * Modify for MIPS version
 *
 * Revision 1.1  1994/07/12  12:04:35  jont
 * new file
 *
 */

#ifndef stacks_h
#define stacks_h

#include "types.h"
#include "mltypes.h"
#include "threads.h"

/*  == Mips stack frame == */

struct stack_frame
{
  struct stack_frame *fp;
  word closure;
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
