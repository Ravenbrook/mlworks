#ifndef explore_h
#define explore_h

/*  ==== HEAP EXPLORATION ====
 * 
 *  Copyright (C) 1995 Harlequin Ltd
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
