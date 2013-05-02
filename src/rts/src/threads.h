/* rts/src/threads.h
 *
 * We define structs describing the state of a thread and functions to
 * manipulate them.
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
 * $Log: threads.h,v $
 * Revision 1.10  1998/07/02 14:03:36  jont
 * [Bug #70131]
 * Add names to threads
 *
 * Revision 1.9  1997/01/29  11:40:40  andreww
 * [Bug #1891]
 * Adding flag for critical section
 *
 * Revision 1.8  1997/01/21  15:35:36  andreww
 * [Bug #1896]
 * Adding new state THREAD_KILLED_SLEEPING.
 * purely to maintain an accurate count of runnable threads
 * (i.e., so that it isn't decremented both when a thread goes to
 * sleep, and then when it is subsequently killed.)
 *
 * Revision 1.7  1997/01/20  15:22:23  andreww
 * [Bug #1894]
 * Adding new thread_root index for thread exceptions
 *
 * Revision 1.6  1996/01/15  11:31:08  nickb
 * Add facility to check for runnable threads.
 *
 * Revision 1.5  1996/01/11  16:18:34  stephenb
 * Add field to thread_state to indicate if currently inside a fatal
 * signal handler.
 *
 * Revision 1.4  1995/09/12  16:27:26  jont
 * Add a function to clean up c roots in ml_state etc
 *
 * Revision 1.3  1995/06/01  15:27:33  nickb
 * Fatal error handing.
 *
 * Revision 1.2  1995/04/24  13:45:04  nickb
 * Add thread_preemption_pending.
 *
 * Revision 1.1  1995/03/30  14:04:08  nickb
 * new unit
 * Portable threads code.
 *
 */

#ifndef _threads_h
#define _threads_h
#include "implicit.h"
#include "mem.h"
#include "mach_state.h"

/* a thread_state contains all the information necessary to continue
 * that thread. Continuing a thread consists of restoring C registers
 * (and the appropriate C stack) and jumping to the location indicated
 * by the C pc. All that information is in the C state, and is non
 * portable. There is also non-portable information in the ML
 * state. Those state structs are defined in mach_state.h.
 *
 * If you change any of the data layout here, you will also need to
 * change mach/$ARCH/asm_offsets.h.  */

/* how many roots in each thread_state */

#define THREAD_ROOTS 4

/* the meanings of a couple of those roots: */
/* roots[THREAD_CLOSURE] is the closure to run in this (new) thread */
/* roots[THREAD_HANDLER] is the fatal error handler for this thread. */
/* roots[THREAD_EXCEPTION_ROOT] is the exception root for this thread. */

#define THREAD_CLOSURE 0
#define THREAD_HANDLER 1
#define THREAD_EXCEPTION_ROOT 2


/* how many non-root thread locals in each thread_state */

#define THREAD_LOCALS 8

struct thread_state {
  struct implicit_vector implicit;	/* entry points &c */

  /* Values relating to the C and ML states */

  struct c_state c_state;
  struct ml_state ml_state;

  /* root maintenance; root[n] is declared iff declared[n] != 0 */

  mlval roots[THREAD_ROOTS];
  mlval declared[THREAD_ROOTS];

  /* a place to keep thread-local values which are not roots */

  word locals[THREAD_LOCALS];
  
  /* Now a pointer to the global state */

  struct global_state *global;

  /* now thread hierarchy structure information */

  word children;

  /* first and last children */

  struct thread_state *first_child;
  struct thread_state *last_child;

  /* siblings are a doubly-linked list, with the parent as sentinel */

  struct thread_state *next_sib; /* doubly-linked list of siblings */
  struct thread_state *last_sib;

  struct thread_state *parent;

  /* lastly thread management information */

  struct thread_state *next; 	/* allows this thread to be on one of */
  struct thread_state *last; 	/* several doubly-linked lists e.g. */
  				/* 'all runnable threads' */
  mlval ml_thread;		/* root to the ML thread value */
  word number;			/* unique to this thread */

  word in_fatal_signal_handler;
  char *name; /* A name for this thread */
};


/* There is a global state, which includes global state information
 * and also a thread state for the top level thread. The top level
 * thread runs only in C, on the OS-provided C stack, and is in charge
 * of scheduling; when a thread completes it returns to this
 * thread. This thread is also the ultimate ancestor of all threads
 * and the dummy member in the list of all threads. The global state
 * is declared in state.h and defined in state.c */

struct global_state {
  word in_ML;			/* used in signal handlers: are we in ML? */
  struct thread_state *current_thread;
  struct thread_state toplevel;
};

extern void run_scheduler(int (*start_mlworks)(int, const char *const *),
			  int argc, const char *const *argv);

extern unsigned long int next_thread_number;

extern void threads_init(void);
extern mlval thread_yield(mlval arg);
extern void thread_suicide(void);
extern void clear_thread_roots(void);

extern int thread_preemption_on;
extern int thread_preemption_pending;
extern int thread_in_critical_section;
extern int runnable_threads;

#define ML_THREAD(c_thread)	((c_thread)->ml_thread)
#define C_THREAD(ml_thread)	((struct thread_state *)(FIELD(ml_thread,1)))

#define THREAD_DIED		(MLINT(0))	/* received fatal signal */
#define THREAD_EXCEPTION	(MLINT(1))	/* raised uncaught exn */
#define THREAD_EXPIRED		(MLINT(2))	/* lost when image was saved */
#define THREAD_KILLED		(MLINT(3))	/* killed */
#define THREAD_RESULT		(MLINT(4))	/* completed */
#define THREAD_RUNNING		(MLINT(5))	/* still running */
#define THREAD_SLEEPING		(MLINT(6))	/* thread asleep */
#define THREAD_WAITING		(MLINT(7))	/* not implemented */
#define THREAD_KILLED_SLEEPING  (MLINT(8))      /* needed to keep
						   runnable_threads OK */

/* NB, if you change these numbers (which correspond to the
 * constructor numbers in the datatype MLWorks.Threads.result) then
 * you're going to have to change the said datatype plus functions.
 */

#define SET_RESULT(ml_thread,r) (MLUPDATE(FIELD(ml_thread,0),0,r))
#define GET_RESULT(ml_thread)   (MLSUB(FIELD(ml_thread,0),0))

#define SET_CONTINUATION(thread,fn) (C_PC(&thread->c_state) = (word)(fn))

#define THREAD_ERROR_HANDLER(thread) ((thread)->declared[THREAD_HANDLER] ? \
				      (thread)->roots[THREAD_HANDLER] :    \
				      MLUNIT)

#endif
