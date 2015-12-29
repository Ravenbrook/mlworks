/* rts/src/arch/$ARCH/mach_state.h
 * 
 * Defines the ML and C states of a thread.
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * $Log: mach_state.h,v $
 * Revision 1.5  1995/11/13 13:47:15  nickb
 * Add native thread fields.
 *
 * Revision 1.4  1995/09/13  12:34:59  jont
 * Add a function to clear roots in ml_state
 *
 * Revision 1.3  1995/09/06  13:08:49  nickb
 * Add a new c_sp slot.
 *
 * Revision 1.2  1995/07/17  12:30:37  nickb
 * Add space profile slot.
 *
 * Revision 1.1  1995/03/30  14:00:11  nickb
 * new unit
 * Machine-specific ML and C state information.
 *
 */

#ifndef _mach_state_h
#define _mach_state_h

#ifdef NATIVE_THREADS
#include "native_threads.h"
#endif

/* C register values */

struct c_state {
  word sp;		/* top of C stack (when in ML) */
  word eip;
#ifdef NATIVE_THREADS
  struct native native;
#else
  struct c_stack *stack;
  word esp;		/* saved SP (when thread switched out) */
  word ebp;
  word esi;
  word edi;
  word ebx;
#endif
};

/* ML state values which are not in the implicit record or saved on
 * the stack by stub_c */

struct ml_state {
  mlval global;
  word sp;		/* top of ML stack (when in C) */
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

#define GC_RETURN		(*(mlval **)&CURRENT_THREAD->ml_state.global)
#define GC_SP(thread)		((struct stack_frame *)(thread)->ml_state.sp)

#define C_PC(c_state)		((c_state)->eip)

#endif
