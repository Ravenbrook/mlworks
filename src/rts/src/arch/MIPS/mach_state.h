/* rts/src/arch/$ARCH/mach_state.h
 * 
 * Defines the ML and C states of a thread state.
 *
 * Copyright (C) 1995 Harlequin Ltd.
 * 
 * $Log: mach_state.h,v $
 * Revision 1.4  1995/09/13 11:56:59  jont
 * Add a function to clear roots in ml_state
 *
 * Revision 1.3  1995/09/06  15:01:21  nickb
 * Add a new c_sp slot.
 *
 * Revision 1.2  1995/07/17  10:08:43  nickb
 * Space profiler interface.
 *
 * Revision 1.1  1995/03/30  14:01:30  nickb
 * new unit
 * Machine-specific ML and C state information.
 *
 */

#ifndef _mach_state_h
#define _mach_state_h

#define C_CALLEE_SAVES 9

#define C_DOUBLE_SAVES 6

/* C register values */

struct c_state {
  word callee_saves[C_CALLEE_SAVES];
  double float_saves[C_DOUBLE_SAVES];
  word pc;			/* where to go to */
  struct c_stack *stack;
  word sp;
  word thread_sp;
};

/* ML state values which are not in the implicit record or saved on
 * the stack by stub_c */

struct ml_state {
  mlval global;
  word sp;
  word stack_top;
  mlval *space_profile;
};

extern mlval initialize_ml_state(struct ml_state *ml_state);
extern void clear_ml_state_roots(struct ml_state *ml_state);
void free_ml_state(struct ml_state *ml_state, char *stack_limit);
void reset_c_state(struct c_state *c_state);
void free_c_state(struct c_state *c_state);
void initialize_c_state(struct c_state *c_state);

void initialize_top_thread_state(void);

#define GC_RETURN		((mlval *)CURRENT_THREAD->ml_state.global)
#define GC_SP(thread)		((struct stack_frame *)(thread)->ml_state.sp)

#define C_PC(c_state)		((c_state)->pc)

#endif
