/* rts/src/arch/$ARCH/mach_state.h
 *
 * Defines the ML and C states of a thread state.
 *
 * Copyright (C) 1995 Harlequin Ltd.
 * 
 * $Log: mach_state.h,v $
 * Revision 1.5  1996/10/31 17:18:47  nickb
 * Exchange ml_state.base and ml_state.sp, to be consistent with other platforms.
 *
 * Revision 1.4  1995/09/12  16:25:22  jont
 * Add a function to clear roots in ml_state
 *
 * Revision 1.3  1995/09/06  13:12:37  nickb
 * Add a new c_sp slot.
 *
 * Revision 1.2  1995/07/17  10:06:11  nickb
 * Space profiler interface.
 *
 * Revision 1.1  1995/03/30  14:02:44  nickb
 * new unit
 * Machine-specific ML and C state information.
 *
 */

#ifndef _mach_state_h
#define _mach_state_h

/* C state */

struct c_state {
  word pc;			/* where to go to */
  word thread_sp;		/* thread saved sp */
  word sp;			/* previous top of C stack */
  struct c_stack *stack;
};

/* ML state values which are not in the implicit record or saved on
 * the stack by stub_c */

struct ml_state {
  mlval global;			/* saved global register g4 */
  word gc_sp;			/* most recent GCable stack frame */
  word sp;			/* most recent ML stack (when in C) */
  word stack_top;		/* fp of oldest GCable stack frame */
  word g7;			/* saved register g7 */
  mlval *space_profile;		/* current space profile pointer */
};

extern mlval initialize_ml_state(struct ml_state *ml_state);
extern void clear_ml_state_roots(struct ml_state *ml_state);
void free_ml_state(struct ml_state *ml_state, char *stack_limit);
void reset_c_state(struct c_state *c_state);
void free_c_state(struct c_state *c_state);
void initialize_c_state(struct c_state *c_state);

void initialize_top_thread_state(void);

#define GC_RETURN		((mlval *)CURRENT_THREAD->ml_state.global)
#define GC_SP(thread)		((struct stack_frame *)(thread)->ml_state.gc_sp)

#define C_PC(c_state)		((c_state)->pc)

#endif
