#ifndef explore_h
#define explore_h

/*  ==== HEAP EXPLORATION ====
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
 *  This file implements the 'explorer': a debugging tool which allows one
 *  to navigate an MLWorks heap. It's intended for internal use by MLWorkers.
 *
 * $Log: explore.h,v $
 * Revision 1.4  1998/04/23 14:18:52  jont
 * [Bug #70034]
 * Rationalising names in mem.h
 *
 * Revision 1.3  1996/07/11  16:25:07  nickb
 * Allow the explorer to exit the runtime and to explore executable images.
 *
 * Revision 1.2  1996/06/03  16:25:52  nickb
 * Add argument to explore() dictating whether the stacks should be examined.
 *
 * Revision 1.1  1996/02/14  14:06:59  nickb
 * new unit
 * The explorer.
 *
 */

#ifdef EXPLORER

#include "values.h"
#include "threads.h"
#include "stacks.h"

/* if explore() returns non-zero, the runtime should terminate. */

extern int explore (mlval what, int use_stacks);

extern void explore_root(mlval *root);

extern void explore_stack_registers(struct thread_state *thread,
				    struct stack_frame *frame,
				    mlval *base, mlval *top);

extern void explore_stack_allocated(struct thread_state *thread,
				    struct stack_frame *frame,
				    mlval *base, mlval *top);

extern void explore_heap_area(struct ml_heap *gen, mlval *base, mlval *top);

#endif /* EXPLORER */

#endif /* explore_h */
