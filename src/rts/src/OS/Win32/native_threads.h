/*  ==== NATIVE THREADS INTERFACE FOR WIN32 ====
 *
 *  Copyright (C) 1995 Harlequin Ltd
 *
 *  Notes:
 *  
 * Under Windows 95, certain system calls can only be made when
 * residing on a stack created by the OS. This prevents us from
 * using our own threads system unaltered, since our threads run on
 * stacks which we create and manipulate. Our solution is to run each
 * of our threads in its own Win32 thread. In order to keep our own
 * scheduling &c, we only allow one of these threads to run at a
 * time. We enforce that restriction by associating an event with each
 * thread. An thread which is inactive is waiting for the event
 * associated with it. To switch to a thread, we signal its event and
 * wait on our own.
 *
 *  Revision Log
 *  ------------
 *  $Log: native_threads.h,v $
 *  Revision 1.1  1996/02/12 11:58:33  stephenb
 *  new unit
 *  This used to be src/rts/src/OS/common/native_threads.h
 *
 * Revision 1.3  1995/12/13  15:42:34  nickb
 * Add thread sp reconstruction.
 *
 * Revision 1.2  1995/11/15  13:11:35  nickb
 * Add facilities for a timer thread.
 *
 * Revision 1.1  1995/11/13  13:26:04  nickb
 * new unit
 * Native threads functionality for Windows (95).
 *
 */

#ifndef _native_threads_h
#define _native_threads_h

#include "types.h"

#ifdef NATIVE_THREADS

/* an MLWorks thread C state contains one of these: */

struct native
{
  word* thread; /* the windows thread HANDLE */
  word* event;  /* the windows event HANDLE */
};

/* create a thread, which will wait on its event */
extern void native_make_thread(struct c_state *c_state);

/* fill in the top thread's native slots */
extern void native_make_top_thread(struct c_state *c_state);

/* destroy a thread. */
extern void native_unmake_thread(struct c_state *c_state);

/* yield from one thread to another. This function call will only
   return when the current thread is scheduled once more. It returns
   the 'previous thread' (i.e. the thread which yields to this one. */

extern struct thread_state *
native_thread_yield(struct thread_state *this_thread,
		    struct thread_state *other_thread);

#endif

/* support for a timer thread, which waits until notified and then runs */

extern void make_timer_thread(void (*thread_fun) (void));
extern void unmake_timer_thread(void);
extern void timer_thread_wait(void);
extern void notify_timer_thread(void);

/* one of the things the timer thread does is profiling, for which we have
 * to suspend the currently-running ML thread, and reconstruct its sp */

/* suspend_current_thread() suspends the current ML thread and returns
 * its handle */

extern word *suspend_current_thread(void);
extern void resume_current_thread(word *thread);

/* reconstruct_thread_sp(thread) uses architecture-specific hacks to
 * reconstruct the stack of the given (suspended) thread and returns a
 * faked sp */

extern word reconstruct_thread_sp(word *thread);

#endif
