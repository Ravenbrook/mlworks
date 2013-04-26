/* rts/src/arch/$ARCH/mach_state.c
 *
 * The ML and C states of a thread state are manipulated here. 
 *
 * Copyright (C) 1995 Harlequin Ltd.
 *
 * $Log: mach_state.c,v $
 * Revision 1.3  1995/09/13 11:57:43  jont
 * Add a function to clear roots in ml_state
 *
 * Revision 1.2  1995/09/06  15:02:24  nickb
 * Add a new c_sp slot.
 *
 * Revision 1.1  1995/03/30  14:00:53  nickb
 * new unit
 * Machine-specific ML and C state information.
 *
 */

#include "types.h"
#include "mltypes.h"
#include "values.h"
#include "mem.h"
#include "state.h"

#define STACK_ADJUST		(STACK_BUFFER+DEFAULT_STACK_SIZE)

mlval initialize_ml_state(struct ml_state *ml_state)
{
    struct ml_stack *ml_stack = make_ml_stack(NULL, 65536);
    ml_state->stack_top = ml_state->sp = (word) ml_stack->top;
    ml_state->global = MLUNIT;
    return (mlval)ml_stack+STACK_ADJUST;
}

void clear_ml_state_roots(struct ml_state *ml_state)
{
  return;
}

void free_ml_state(struct ml_state *ml_state,
		   char *stack_limit)
{
  free_ml_stacks((struct ml_stack *) (stack_limit - STACK_ADJUST));
}

void reset_c_state(struct c_state *c_state)
{
  c_state->thread_sp = (word) c_state->stack->top;
  c_state->sp = 0;
}

void free_c_state(struct c_state *c_state)
{
  free_c_stack(c_state->stack);
}

void initialize_c_state(struct c_state *c_state)
{
  struct c_stack *c_stack = make_c_stack();
  c_state->stack = c_stack;
  c_state->thread_sp = (word) c_stack->top;  
  c_state->sp = 0;
}

void initialize_top_thread_state(void)
{
  TOP_THREAD.c_state.stack		= NULL;
  TOP_THREAD.ml_state.global		= 0;
  TOP_THREAD.ml_state.sp		= 0;
  TOP_THREAD.ml_state.stack_top		= 0;
}
