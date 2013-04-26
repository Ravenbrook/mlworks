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
 *  $Log: native_threads.c,v $
 *  Revision 1.1  1996/02/12 11:58:32  stephenb
 *  new unit
 *  This used to be src/rts/src/OS/common/native_threads.c
 *
 * Revision 1.5  1995/12/15  14:26:45  nickb
 * Profiling in the non-NATIVE_THREADS case (Windows NT) broken because we
 * never set main_thread.
 *
 * Revision 1.4  1995/12/13  15:57:40  nickb
 * Ooops.
 *
 * Revision 1.3  1995/12/13  15:43:36  nickb
 * Add thread sp reconstruction.
 *
 * Revision 1.2  1995/11/15  14:03:16  nickb
 * Add facilities for a timer thread.
 *
 * Revision 1.1  1995/11/13  13:25:41  nickb
 * new unit
 * Native threads functionality for Windows (95).
 *
 */

#include "state.h"
#include "diagnostic.h"
#include "utils.h"
#include "i386_code.h"

#include <windows.h>

/* abstracted the notions of setting and waiting for events, with
their associated errors &c */

static void wait_for_event(word *event)
{
  HANDLE event_handle = (HANDLE) event;
  DWORD result = WaitForSingleObject(event_handle, INFINITE);
  if (result != WAIT_OBJECT_0) {
    switch (result) {
    case WAIT_FAILED:
      error("WaitForSingleObject() failed, GetLastError() gives %u\n",
	    GetLastError());
    case WAIT_TIMEOUT:
    case WAIT_ABANDONED:
    default:
      error ("WaitForSingleObject() returned unexpected code %u, "
	     "GetLastError() gives %u\n", result, GetLastError());
    }
  }
}

static void set_event(word *event)
{
  HANDLE event_handle = (HANDLE) event;
  BOOL result = SetEvent(event_handle);
  if (result == FALSE)
    error ("SetEvent() returned FALSE, GetLastError() gives %u\n",
	   GetLastError());
}

/* thread suspend and resume operations */

static void suspend_thread(word *thread)
{
  DWORD result = SuspendThread((HANDLE)thread);
  if (result == 0xffffffff)
    error("SuspendThread() returned -1, GetLastError() gives %u\n",
	  GetLastError());
}

static void resume_thread(word *thread)
{
  DWORD result = ResumeThread((HANDLE)thread);
  if (result == 0xffffffff)
    error("ResumeThread() returned -1, GetLastError() gives %u\n",
	  GetLastError());
}

/* abstracted the notion of closing and duplicating handles, with the
associated error conditions */

static void close_handle(word *handle)
{
  HANDLE true_handle = (HANDLE) handle;
  BOOL result = CloseHandle(true_handle);
  if (result == FALSE)
    error ("CloseHandle() returned FALSE, GetLastError() gives %u\n",
	   GetLastError());
  DIAGNOSTIC(4,"native thread system closed handle 0x%x",handle,0);
}

/* this is necessary because of the pseudo-handle brain-damage */

static HANDLE duplicate_handle(HANDLE handle)
{
  HANDLE process = GetCurrentProcess();
  HANDLE new_handle;
  BOOL result = DuplicateHandle(process,
				handle,
				process,
				&new_handle,
				0,
				TRUE,
				DUPLICATE_SAME_ACCESS);
  if (result == FALSE)
    error("DuplicateHandle() returned FALSE, GetLastError gives %u\n",
	  GetLastError());
  DIAGNOSTIC(4,"native threads system duplicated handle 0x%08x to give 0x%08x",
	     handle,new_handle);
  return new_handle;
}

#ifdef NATIVE_THREADS

/* The thread switching itself takes place here */

static struct thread_state *previous_thread = NULL;

extern struct thread_state *
native_thread_yield(struct thread_state *this_thread,
		    struct thread_state *other_thread)
{
  DIAGNOSTIC(2,"Native thread %d yielding to native thread %d",
	     this_thread->number, other_thread->number);
  previous_thread = this_thread;
  set_event(other_thread->c_state.native.event);
  DIAGNOSTIC(3,"Native thread %d set event in thread %d, waiting for event",
	     this_thread->number, other_thread->number);
  wait_for_event(this_thread->c_state.native.event);
  DIAGNOSTIC(3,"Back in native thread %d",this_thread->number,0);
  return previous_thread;
}

/* This is the function which runs when a native thread is first created */

static void native_thread_run(struct c_state *c_state)
{
  void (*continuation)(void);
  DIAGNOSTIC(2,"starting new native thread, waiting for event",0,0);
  wait_for_event(c_state->native.event);
  continuation = (void (*)(void))c_state->eip;
  DIAGNOSTIC(3,"in new thread, calling continuation 0x%x",continuation,0);
  continuation();
}

/* making a native thread. We create a thread running, immediately to
 * wait on its event. */

extern void native_make_thread(struct c_state *c_state)
{
  DWORD thread_id;
  c_state->native.event = (word*)
    CreateEvent (NULL, 		/* no security */
		 FALSE,		/* auto-reset */
		 FALSE,		/* initially unsignalled */
		 NULL);		/* un-named */
  if (c_state->native.event == NULL)
    error("CreateEvent() has failed; GetLastError() returns %u",
	  GetLastError());
  DIAGNOSTIC(4,"Native threads system created new event handle 0x%x",
	     c_state->native.event,0);
  c_state->native.thread = (word*)
    CreateThread (NULL,		/* no security */
		  0,		/* same stack size as main() */
		  (LPTHREAD_START_ROUTINE) native_thread_run,
		  (LPVOID) c_state,	/* the argument to native_thread_run */
		  0,		/* no special creation flags */
		  &thread_id);
  if (c_state->native.thread == NULL)
    error ("CreateThread has failed; GetLastError() returns %u",
	   GetLastError());
  DIAGNOSTIC(4,"new native thread id %u made, handle 0x%x",thread_id,
	     c_state->native.thread);
}

/* The top thread has to have meaningful thread and event fields */

extern void native_make_top_thread(struct c_state *c_state)
{
  HANDLE pseudo_top_thread_handle;
  c_state->native.event = (word*)
    CreateEvent (NULL, 		/* no security */
		 FALSE,		/* auto-reset */
		 FALSE,		/* initially unsignalled */
		 NULL);		/* un-named */
  if (c_state->native.event == NULL)
    error("CreateEvent() has failed; GetLastError() returns %u",
	  GetLastError());
  DIAGNOSTIC(4,"Native threads created event handle 0x%x for top thread",
	     c_state->native.event,0);
  pseudo_top_thread_handle = GetCurrentThread();
  c_state->native.thread = (word*) duplicate_handle(pseudo_top_thread_handle);
  DIAGNOSTIC(4,"top thread handle 0x%x obtained",c_state->native.thread,0);
}

/* when killing a thread, we force this code, since calling ExitThread
 * does OS-related cleanup */

static void native_thread_exit(struct c_state *c_state)
{
  DIAGNOSTIC(2,"leaving native thread",0,0);
  ExitThread(0);
}

/* unmaking a thread. We are careful to close all handles &c */

extern void native_unmake_thread(struct c_state *c_state)
{
  DIAGNOSTIC(2,"unmaking native thread",0,0);
  c_state->eip = (word)native_thread_exit;
  set_event(c_state->native.event);
  DIAGNOSTIC(3,"set event on thread to unmake, waiting on thread",0,0);
  wait_for_event(c_state->native.thread);
  DIAGNOSTIC(3,"unmade thread signalled, closing handles",0,0);
  close_handle(c_state->native.thread);
  close_handle(c_state->native.event);
  DIAGNOSTIC(3,"closed handles; native thread is history",0,0);
}

#endif /* NATIVE_THREADS */

/* support for a timer thread, which waits until notified and then runs */

#ifndef NATIVE_THREADS
/* We have to support suspending the current ML thread. With native
   threads, this is simple. With non-native threads, it is equivalent
   to suspending the 'main' native thread. This function obtains that
   thread. */

static word* main_thread = NULL;
static void set_main_thread(void)
{
  HANDLE pseudo_main_thread_handle = GetCurrentThread();
  main_thread = (word*) duplicate_handle(pseudo_main_thread_handle);
  DIAGNOSTIC(4,"main thread handle 0x%x obtained", main_thread,0);
}
#endif

static word* timer_thread = NULL;
static word* timer_event = NULL;

extern void make_timer_thread(void (*thread_fun) (void))
{
  UINT thread_id;
#ifndef NATIVE_THREADS
  /* set main_thread here, then the timer thread can suspend it */
  set_main_thread();
#endif
  timer_event = (word*)
    CreateEvent(NULL,		/* no security */
		FALSE,		/* auto-reset */
		FALSE,		/* initially unsignalled */
		NULL);		/* un-named */
  if (timer_event == NULL)
    error("CreateEvent() has failed; GetLastError() returns %u",
	  GetLastError());
  DIAGNOSTIC(4,"made timer event",0,0);
  timer_thread = (word*)
    CreateThread(NULL,		/* no security */
		 0,		/* same stack size as main() */
		 (LPTHREAD_START_ROUTINE) thread_fun,
		 (LPVOID) 0,	/* thread_fun takes no arguments */
		 0,		/* no special creation flags */
		 &thread_id);
  if (timer_thread == NULL)
    error("CreateThread() has failed; GetLastError() returns %u",
	  GetLastError());
  DIAGNOSTIC(2,"made timer thread with id %d",thread_id,0);
}

/* have to support unmaking the timer thread (although this is quite
 * difficult, and not currently used) */

static void timer_thread_end(void)
{
  DIAGNOSTIC(2,"leaving timer thread",0,0);
  ExitThread(0);
}

extern void unmake_timer_thread(void)
{
  CONTEXT timer_thread_context;
  BOOL result;
  DIAGNOSTIC(2,"unmaking timer thread",0,0);
  suspend_thread(timer_thread);
  DIAGNOSTIC(3,"timer thread suspended",0,0);
  timer_thread_context.ContextFlags = CONTEXT_CONTROL;
  result = GetThreadContext((HANDLE)timer_thread,
			    &timer_thread_context);
  if (result == FALSE)
    error("GetThreadContext(timer) failed; GetLastError() returns %d",
	  GetLastError());
  DIAGNOSTIC(3,"timer thread context obtained",0,0);
  timer_thread_context.Eip = (DWORD)timer_thread_end;
  result = SetThreadContext((HANDLE)timer_thread,
			    &timer_thread_context);
  if (result == FALSE)
    error("SetThreadContext(timer) failed; GetLastError() returns %d",
	  GetLastError());
  DIAGNOSTIC(3,"timer thread context set",0,0);
  set_event(timer_event);
  DIAGNOSTIC(3,"timer event set",0,0);
  resume_thread(timer_thread);
  DIAGNOSTIC(3,"timer thread resumed",0,0);
  wait_for_event(timer_thread);
  DIAGNOSTIC(3,"timer thread signalled",0,0);
  close_handle(timer_thread);
  close_handle(timer_event);
  DIAGNOSTIC(2,"timer thread unmade and forgotten",0,0);
}

extern void timer_thread_wait(void)
{
  DIAGNOSTIC(4,"timer thread waiting for timer event",0,0);
  wait_for_event(timer_event);
  DIAGNOSTIC(4,"timer thread received timer event",0,0);
}

extern void notify_timer_thread(void)
{
  DIAGNOSTIC(4,"notifying timer thread",0,0);
  set_event(timer_event);
}

/* one of the things the timer thread does is profiling, for which we have
 * to suspend the currently-running ML thread */

extern word* suspend_current_thread(void)
{
  word *thread =
#ifdef NATIVE_THREADS
    CURRENT_THREAD->c_state.native.thread;
#else
    main_thread;
#endif
  suspend_thread(thread);
  DIAGNOSTIC(2,"suspended ML threads",0,0);
  return thread;
}

extern void resume_current_thread(word *thread)
{
  DIAGNOSTIC(2,"resuming ML threads",0,0);
  resume_thread(thread);
}

/* reconstruct_thread_sp(thread) uses architecture-specific hacks to
 * reconstruct the stack of the given (suspended) thread and returns a
 * faked sp */

extern word reconstruct_thread_sp(word *thread)
{
  CONTEXT context;
  BOOL result;
  context.ContextFlags = CONTEXT_CONTROL | CONTEXT_INTEGER;
  result = GetThreadContext((HANDLE)thread,
			    &context);
  if (result == FALSE)
    error("GetThreadContext(thread) failed; GetLastError() returns %d",
	  GetLastError());
  return i386_fixup_sp((word)context.Esp, (word)context.Eip, (word)context.Edi,
		       (word)context.Ebp, (word)context.Ecx);
}


