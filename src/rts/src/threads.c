/* rts/src/threads.c
 *
 * Functions manipulating thread states, including the scheduler.
 *
 * Copyright (C) 1995 Harlequin Ltd.
 *
 * $Log: threads.c,v $
 * Revision 1.35  1998/08/21 14:15:52  jont
 * [Bug #30108]
 * Implement DLL based ML code
 *
 * Revision 1.34  1998/08/07  10:30:10  jont
 * [Bug #20129]
 * Fix compiler warning
 *
 * Revision 1.33  1998/07/02  16:36:26  jont
 * [Bug #70131]
 * Add name field to threads
 *
 * Revision 1.32  1998/07/02  14:56:30  jont
 * [Bug #70132]
 * Explicitly kill timer_thread if necessary by calling signals_finalise
 *
 * Revision 1.31  1998/04/23  14:14:47  jont
 * [Bug #70034]
 * Rationalising names in mem.h
 *
 * Revision 1.30  1998/03/19  10:50:42  jont
 * [Bug #70018]
 * Add cast to call to live_in_gen
 *
 * Revision 1.29  1998/03/02  19:07:30  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.28  1997/05/28  08:55:01  daveb
 * [Bug #01894]
 * Check for empty stack when raising exception.
 *
 * Revision 1.27  1997/05/06  10:29:49  stephenb
 * [Bug #30030]
 * run_scheduler: add a call to mlw_ci_init_globals.
 *
 * Revision 1.26  1997/01/29  11:50:30  andreww
 * [Bug #1891]
 * Adding functions to enter and exit critical sections
 *
 * Revision 1.25  1997/01/29  10:51:04  andreww
 * [Bug #1900]
 * patching scheduler queue to run only runnable threads.
 *
 * Revision 1.24  1997/01/21  15:34:02  andreww
 * [Bug #1896]
 * Adding new state THREAD_KILLED_SLEEPING.
 * purely to maintain an accurate count of runnable threads
 * (i.e., so that it isn't decremented both when a thread goes to
 * sleep, and then when it is subsequently killed.)
 *
 * Revision 1.23  1997/01/20  15:24:13  andreww
 * [Bug #1894]
 * Adding new thread_root index for thread exceptions
 *
 * Revision 1.22  1997/01/20  15:19:58  andreww
 * [Bug #1895]
 * kill thread should kill its argument thread, not the CURRENT thread.
 *
 * Revision 1.21  1997/01/20  15:15:23  andreww
 * [Bug #1896]
 * don't decrement runnable_threads counter when unmaking a sleeping
 * thread:  it's already been decremented.
 *
 * Revision 1.20  1996/11/18  13:25:21  stephenb
 * [Bug #1789]
 * thread_start_preemption: add a semi-colon after the
 * DIAGNOSTIC call.
 *
 * Revision 1.19  1996/10/10  11:50:10  stephenb
 * make_thread: correct indentation of an else branch which
 * implied that that the next statement belonged to the else when
 * it did not.
 *
 * Revision 1.18  1996/06/27  15:45:09  jont
 * Change GLOBAL_MISSING_NIL to GLOBAL_MISSING_UNIT since this is what it really means
 *
 * Revision 1.17  1996/05/16  14:49:43  nickb
 * Make backtrace of last thread come out on stderr.
 *
 * Revision 1.16  1996/02/16  16:56:16  nickb
 * Clear up costly root on export.
 *
 * Revision 1.15  1996/02/16  14:46:09  nickb
 * Change to declare_global().
 *
 * Revision 1.14  1996/02/14  10:50:08  jont
 * Modify some casts to get compilation under VC++ to work without warnings
 *
 * Revision 1.13  1996/01/15  12:06:10  nickb
 * Add facility to check for runnable threads.
 *
 * Revision 1.12  1996/01/12  17:21:53  stephenb
 * make_thread: initialise in_fatal_signal_handler to 0.
 *
 * Revision 1.11  1996/01/12  15:17:14  nickb
 * Change protocol of thread_preemption_pending.
 *
 * Revision 1.10  1996/01/11  16:52:34  nickb
 * Runtime error message buffer problem.
 *
 * Revision 1.9  1995/11/13  12:29:42  nickb
 * Move CURRENT_THREAD manipulation out of asm into portable C.
 *
 * Revision 1.8  1995/09/12  16:32:08  jont
 * Add a function to clean up c roots in ml_state etc
 *
 * Revision 1.7  1995/06/19  14:56:29  nickb
 * Copy space profiling word when switching threads.
 *
 * Revision 1.6  1995/06/02  16:08:48  nickb
 * Declare the fatal signal handler as global.
 *
 * Revision 1.5  1995/06/02  13:55:53  nickb
 * Fatal error handing.
 *
 * Revision 1.4  1995/05/03  09:55:24  matthew
 * Removing debugger implicit vector entries
 *
 * Revision 1.3  1995/04/24  12:11:07  nickb
 * Add thread_preemption_pending.
 *
 * Revision 1.2  1995/04/10  12:20:16  jont
 * Remove reference to system headers, no longer required
 *
 * Revision 1.1  1995/03/30  14:03:20  nickb
 * new unit
 * Portable threads code.
 *
 */


#include "values.h"
#include "threads.h"
#include "state.h"
#include "gc.h"
#include "alloc.h"
#include "utils.h"
#include "print.h"
#include "stacks.h"
#include "interface.h"
#include "environment.h"
#include "stubs.h"
#include "signals.h"
#include "global.h"
#include "diagnostic.h"
#include "exceptions.h"
#include "mlw_ci_globals.h"	/* mlw_ci_init_globals */
#include "mem.h"		/* GENERATION */

#include <string.h>

int thread_preemption_on = 0;
int thread_preemption_pending = 0;
int thread_in_critical_section = 0;
int runnable_threads = 0;

/* change_thread() does the portable part of changing the thread
 * state, and punts the non-portable part to switch_to_thread(), which
 * is written in asm. */

static inline struct thread_state *change_thread
  (struct thread_state *new_thread)
{
  struct thread_state *old_thread = CURRENT_THREAD;
  /* copy the dynamic shared part of the thread state to the new thread */
  new_thread->implicit.gc_base = old_thread->implicit.gc_base;
  new_thread->implicit.gc_limit = old_thread->implicit.gc_limit;
  new_thread->implicit.gc_modified_list =
    old_thread->implicit.gc_modified_list;
  new_thread->ml_state.space_profile =
    old_thread->ml_state.space_profile;
  CURRENT_THREAD = new_thread;
  if (old_thread->implicit.interrupt)
    new_thread->implicit.interrupt = (unsigned)-1;

  /* actually do the switch */
  return switch_to_thread(old_thread, new_thread);
}
  
/* we end a thread simply by switching to the topmost thread */

#define END_THREAD		(void)change_thread(&TOP_THREAD)

/* Undo everything connecting this thread to the world and free it */

static void unmake_thread (struct thread_state *thread)
{
  int i;

  DIAGNOSTIC(5, "unmaking thread %d (%s)", thread->number, thread->name);
  if (CURRENT_THREAD == thread)
    error("attempting to unmake the current thread %d\n",thread->number);

  /* if the thread being unmade is asleep, then the counter
     has already been decremented */

  if ((GET_RESULT(ML_THREAD(thread))!=THREAD_SLEEPING) && 
      (GET_RESULT(ML_THREAD(thread))!=THREAD_KILLED_SLEEPING))
    runnable_threads--;

  /* deal with children */
  if (thread->children) {
    struct thread_state *child = thread->first_child;
    while (child != thread) { /* pass children up to parent */
      child->parent = thread->parent;
      child = child->next_sib;
    }
    /* thread children into siblings list */
    thread->first_child->last_sib = thread->last_sib;
    thread->last_child->next_sib = thread->next_sib;

    if (thread->last_sib == thread->parent)
      thread->parent->first_child = thread->first_child;
    else
      thread->last_sib->next_sib = thread->first_child;

    if (thread->next_sib == thread->parent)
      thread->parent->last_child = thread->last_child;
    else
      thread->next_sib->last_sib = thread->last_child;
  } else {
    /* unhook from siblings */
    if (thread->next_sib == thread->parent)
      thread->parent->last_child = thread->last_sib;
    else
      thread->next_sib->last_sib = thread->last_sib;

    if (thread->last_sib == thread->parent)
      thread->parent->first_child = thread->next_sib;
    else
      thread->last_sib->next_sib = thread->next_sib;
  }

  thread->parent->children += (thread->children -1);

  /* unhook from overall list of threads */
  thread->next->last = thread->last;
  thread->last->next = thread->next;

  /* disentangle from ML */
  C_THREAD(ML_THREAD(thread)) = (mlval) NULL;
  ML_THREAD(thread) = MLUNIT;
  retract_root(&thread->ml_thread);
  retract_root(&thread->implicit.handler);
  for(i=0; i < THREAD_ROOTS; i++)
    if (thread->declared[i])
      retract_root(&thread->roots[i]);

  /* free other objects and quit */
  free_ml_state(&thread->ml_state, (char *)thread->implicit.stack_limit);
  free_c_state(&thread->c_state);
  free(thread->name);
  free(thread);
}

/* thread_toplevel_handler_record is the handler record installed in
   every thread as it is created. The handler function is
   thread_toplevel_handler, below. */

static mlval thread_toplevel_handler_record;

/* thread_toplevel_handler is installed as the handler of any thread
 * before running that thread. When it gets called, an exception has
 * been raised in the thread and not handled by any handler there. It
 * prints a message on the message stream and terminates the
 * thread. */

static mlval thread_toplevel_handler(mlval packet)
{
  struct thread_state *thread = CURRENT_THREAD;
  mlval result;
  mlval content;

  DIAGNOSTIC(1,"toplevel handler for thread %d", thread->number, 0);
  declare_root(&packet, 0);
  result = mlw_cons(THREAD_EXCEPTION,packet); /* Died (r) */
  SET_RESULT(ML_THREAD(thread),result);
  retract_root(&packet);

  if (runnable_threads == 2)
    messager_function = NULL;	/* force the backtrace to come out on stderr */

  message_start();
  message_content("Thread %d dying due to uncaught exception \"",
		  thread->number);
  message_string(PACKET_NAME(packet));
  message_string("\"");
  content = PACKET_CONTENT(packet);
  if (content != MLUNIT) {
    message_content(" of ");
    message_print(NULL, content);
  }
  message_content ("\n");
  backtrace(GC_SP(thread), thread, max_backtrace_depth);
  message_end();
  END_THREAD;
  return MLUNIT;
}

/* initialize_toplevel_handler creates a closure for the top-level
 * handler, and a fake handler frame containing that closure, and a
 * pointer to that handler frame with which to initialize the handler
 * chain in any newly created thread. */

static mlval thread_toplevel_handler_frame[6];

static void initialize_toplevel_handler(void)
{
  mlval thread_toplevel_handler_closure;
  
  DIAGNOSTIC(5, "Initializing top level hander", 0, 0);
  thread_toplevel_handler_closure = 
    env_function("top level exception handler", thread_toplevel_handler);
  thread_toplevel_handler_frame[2] = thread_toplevel_handler_closure;
  thread_toplevel_handler_record = MLPTR(PAIRPTR,
					 thread_toplevel_handler_frame);
  declare_root(&thread_toplevel_handler_record, 0);
  declare_global("toplevel exception handler stub",
		 thread_toplevel_handler_frame+2,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
}

/* each thread may carry around several roots into the ML heap */

static void thread_declare_root(struct thread_state *thread, int root)
{
  DIAGNOSTIC(5, "declaring thread %d root %d", thread->number, root);

  if (root >= THREAD_ROOTS)
    error("thread %d root %d declared: out of range.\n",thread->number, root);
  if (thread->declared[root])
    error("thread %d root %d already declared.\n", thread->number, root);
  thread->declared[root] = 1;
  declare_root(&thread->roots[root], 0);
}

static void thread_retract_root(struct thread_state *thread, int root)
{
  DIAGNOSTIC(5, "retracting thread %d root %d", thread->number, root);
  
  if (root >= THREAD_ROOTS)
    error("thread %d root %d retracted: out of range.\n",thread->number, root);
  if (!thread->declared[root])
    error("thread %d root %d not declared.\n", thread->number, root);
  thread->declared[root] = 0;
  retract_root(&thread->roots[root]);
}

extern void clear_thread_roots(void)
{
  int i;
  struct thread_state *thread = &TOP_THREAD;
  do {
    for(i=0; i < THREAD_ROOTS; i++)
      if (thread->declared[i]) {
        retract_root(&thread->roots[i]);
        thread->declared[i] = 0;
      }
  clear_ml_state_roots(&thread->ml_state);
  thread = thread->next;
  } while (thread != &TOP_THREAD);
}

/* run_ml_thread is a start-up function for a forked thread. It is the
 * first code which will actually execute in a thread created to run
 * an ML closure. It takes the closure (one of the roots in the thread
 * state) and applies it to unit. See thread_fork(). */

static void run_ml_thread(void)
{
  mlval result;
  struct thread_state *thread = CURRENT_THREAD;
  mlval closure = thread->roots[THREAD_CLOSURE];

  DIAGNOSTIC(1, "running closure %s in thread %d",
	     CSTRING(CCODENAME(FIELD(closure,0))),
	     thread->number);

  thread_retract_root(thread,THREAD_CLOSURE);
  result = callml(MLUNIT, closure);
  declare_root(&result, 0);
  result = mlw_cons(THREAD_RESULT,result); /* Result (r) */
  SET_RESULT(ML_THREAD(thread),result);
  retract_root(&result);
  DIAGNOSTIC(1, "thread %d returned", thread->number, 0);
  END_THREAD;
}

/* run_c_thread is similarly a start-up function for a thread forked
 * to run a C function. It is installed by thread_c_fork, q.v. */

static void run_c_thread(void)
{
  struct thread_state *thread = CURRENT_THREAD;
  void (*f)(word,word,word,word) =
    (void (*)(word,word,word,word)) thread->locals[0];
  word arg0 = thread->locals[1];
  word arg1 = thread->locals[2];
  word arg2 = thread->locals[3];
  word arg3 = thread->locals[4];

  DIAGNOSTIC(1, "starting thread %d in C", thread->number, 0);
  f(arg0,arg1,arg2,arg3);
  SET_RESULT(ML_THREAD(thread),mlw_cons(THREAD_RESULT,MLUNIT)); /* Result () */
  DIAGNOSTIC(1, "thread %d returned", thread->number, 0);
  END_THREAD;
}

/* We keep a weak array of the extant threads, so we can manipulate
 * them when an image is loaded. */

static mlval threads;

/* thread_fix fixes a single thread. We retain threads 0 and 1, and
 * 'expire' other threads (since we no longer have the C structure
 * representing their state). */
/* Jont: Any value to be fixed which is outside the image is marked DEAD */

static mlval thread_fix(unsigned int index, mlval ml_thread)
{
  struct ml_heap *gen = VALUE_GEN(ml_thread);
  if (live_in_gen(gen, (mlval *)ml_thread)) {
    switch (index) {
    case 0:
      DIAGNOSTIC(5, "relinking thread 0", 0, 0);
      C_THREAD(ml_thread) = &TOP_THREAD;
      ML_THREAD(&TOP_THREAD) = ml_thread;
      SET_RESULT(ml_thread,THREAD_RUNNING);
      break;
    case 1:
      DIAGNOSTIC(5, "relinking thread 1", 0, 0);
      C_THREAD(ml_thread) = TOP_THREAD.next;
      ML_THREAD(TOP_THREAD.next) = ml_thread;
      SET_RESULT(ml_thread,THREAD_RUNNING);
      break;
    default:
      message("expired thread %d", index);
      C_THREAD(ml_thread) = (mlval) NULL;
      SET_RESULT(ml_thread,THREAD_EXPIRED);
    }
    return ml_thread;
  } else {
    return DEAD;
  }
}

/* threads_fix fixes the weak list of threads */

static void threads_fix(const char *name, mlval *root, mlval value)
{
  size_t threads = weak_length(value);
  DIAGNOSTIC(3, "fixing %d threads", threads, 0);
  if (next_thread_number != 2)
    error("Cannot load an image with more than 1 thread running.");
  /* we do not warn if it is just threads 0 and 1 */
  if (threads > 2)
    message("Warning: %d threads (live when image was saved) not restarted",
	    threads-2);
  else if (threads < 2)
    error("Cannot load an image saved with no running threads");

  weak_apply(value, thread_fix);
  *root = value;
  runnable_threads = 2;
}

/* next_thread_number is the number of the next thread to be created */

unsigned long int next_thread_number = 0;

/* make_thread() creates a new thread_state structure. */

static struct thread_state *make_thread (struct thread_state *parent, const char *name)
{
  struct thread_state *thread =
    (struct thread_state *)alloc(sizeof(struct thread_state),
				 "Failed to allocate thread state.");
  int i;

  thread->implicit = TOP_THREAD.implicit;
  thread->implicit.interrupt = 0;
  thread->implicit.handler = thread_toplevel_handler_record;
  declare_root(&thread->implicit.handler, 0);

  initialize_c_state(&thread->c_state);
  thread->implicit.stack_limit = initialize_ml_state (&thread->ml_state);

  for(i=0; i < THREAD_ROOTS; i++)
    thread->declared[i] = 0;

  thread->global = &global_state;

  /* no children */
  thread->children = 0;
  thread->first_child = thread->last_child = thread;

  /* sort out parent and siblings */
  thread->parent = parent;
  thread->next_sib = parent->first_child;
  parent->first_child = thread;
  thread->last_sib = parent;
  if (parent->children)
    thread->next_sib->last_sib = thread;
  else
    parent->last_child = thread;
  parent->children++;

  /* insert into list of threads just before the current thread */
  thread->next = CURRENT_THREAD;
  thread->last = CURRENT_THREAD->last;
  thread->last->next = thread;
  CURRENT_THREAD->last = thread;

  thread->number = next_thread_number++;

  { /* the ML thread value */
    mlval result = ref(THREAD_RUNNING);
    declare_root(&result, 0);
    thread->ml_thread = mlw_cons(result,(mlval)thread);
    retract_root(&result);
    declare_root(&thread->ml_thread, 1);
    threads = weak_add(threads,thread->ml_thread);
  }

  thread->in_fatal_signal_handler= 0;

  runnable_threads++;

  DIAGNOSTIC(5, "made thread %d (%s)",thread->number, thread->name);
  DIAGNOSTIC(5, "(%d total threads)", weak_length(threads), 0);

  thread->name = malloc(strlen(name)+1);
  strcpy(thread->name, name);
  return thread;
}
  
/* thread_reset_signal_status is for use by ML fatal signal handlers.
 * Just before said handler terminates it should call this to clear
 * the signal status */

static mlval thread_reset_fatal_status(mlval unit)
{
  CURRENT_THREAD->in_fatal_signal_handler= 0;
  return MLUNIT;
}

/* thread_c_fork(f,a,b,c,d) forks a thread to call the C function
 * f(a,b,c,d). See also run_c_thread. */

static struct thread_state *thread_c_fork(void (*fun)(),
					  word arg0, word arg1,
					  word arg2, word arg3,
					  const char *name)
{
  struct thread_state *thread = make_thread(CURRENT_THREAD, name);

  DIAGNOSTIC(1, "forking thread %d (to run C) from thread %d",
	     thread->number, CURRENT_THREAD->number);

  thread->locals[0] = (word)fun;
  thread->locals[1] = arg0;
  thread->locals[2] = arg1;
  thread->locals[3] = arg2;
  thread->locals[4] = arg3;
  SET_CONTINUATION(thread,run_c_thread);
  return thread;
}

static mlval thread_1_fatal_handler = MLUNIT;

static void thread_1_fatal_handler_fix(const char *name,
				       mlval *root, mlval value)
{
  struct thread_state *thread = TOP_THREAD.next;
  if (!thread->declared[THREAD_HANDLER])
    thread_declare_root(thread,THREAD_HANDLER);
  thread->roots[THREAD_HANDLER] = value;
  DIAGNOSTIC(5, "fixing handler in thread 1", 0, 0);
}




/* This determines the next thread to be run by the scheduler.  Typically
   in pre-emption mode, when the first thread dies, the next thread may
   be asleep.  So we simply scan the list to get the first non-sleeping
   thread.  Note that Dead and Killed threads are assumed to be runnable,
   because they are removed from the queue by running them.
*/

static inline struct thread_state *next_runnable_thread
  (struct thread_state *thread)
{
  while (thread != &TOP_THREAD) {
    mlval result = GET_RESULT(ML_THREAD(thread));
    if ((result != THREAD_SLEEPING) &&
	(result != THREAD_WAITING))
      return thread;
    else thread=thread->next;
  }
  /* we've gone round the loop and haven't found anything runnable */
  error_without_alloc("No Runnable threads.");
  return thread; /* control never returns from here */
}




/* The scheduler. This is the threaded equivalent of 'main' in the
 * unthreaded context (and is indeed called directly by the new 'main'
 * function). It creates a new thread to run the function
 * 'start_mlworks' (which used to be 'main'). Then it has a very basic
 * scheduler loop.
 *
 *.order: Don't alter the order of these two calls -- see 
 * <URI:spring://ML_Notebook/Design/FI/Core#stub.c.c.reload-order>
 * for more info.
 */

extern void run_scheduler(int (*start_mlworks)(int, const char *const *, mlval, void (*)(void)),
			  int argc, const char *const *argv, mlval setup, void (*declare)(void))
{
  sm_init();
  stubs_init();
  mlw_ci_init_globals();  /* .order */
  env_init();		  /* .order */

  initialize_global_state();
  initialize_toplevel_handler();
  threads = weak_new(16);
  threads = weak_add(threads,TOP_THREAD.ml_thread);
  declare_global("ML threads", &threads, GLOBAL_DEFAULT,
		 NULL, threads_fix, NULL);
  declare_global("Thread 1 fatal signal handler",
		 &thread_1_fatal_handler, GLOBAL_ENV + GLOBAL_MISSING_UNIT,
		 NULL, thread_1_fatal_handler_fix, NULL);

  thread_c_fork((void (*)()) start_mlworks, (word) argc, (word) argv, (word)setup, (word) declare, "start_mlworks");

  /* The scheduler loop */
  while (TOP_THREAD.next != &TOP_THREAD) {
    struct thread_state *thread;
    thread =
      change_thread(next_runnable_thread(TOP_THREAD.next));
    DIAGNOSTIC(5,"thread %d returned to the scheduler", thread->number, 0);
    unmake_thread(thread);
  }
  signals_finalise();
}

/* some useful functions for manipulating threads */

/* thread_suicide; if called in a thread this causes the thread to die */

extern void thread_suicide(void)
{
  DIAGNOSTIC(1, "thread %d ending", CURRENT_THREAD->number, 0);
  END_THREAD;
}

/* kill_thread kills its argument thread */

static void kill_thread(struct thread_state *thread)
{
  if (GET_RESULT(ML_THREAD(thread))==THREAD_SLEEPING)
    SET_RESULT(ML_THREAD(thread),THREAD_KILLED_SLEEPING);
  else
    SET_RESULT(ML_THREAD(thread),THREAD_KILLED);
  SET_CONTINUATION(thread,thread_suicide);
  DIAGNOSTIC(1, "thread %d killed by thread %d",
	     thread->number, CURRENT_THREAD->number);
}

/* thread_raise_continuation is installed as a continuation by
 * thread_raise_exn */

static void thread_raise_continuation(void)
{
  mlval exn = CURRENT_THREAD->roots[THREAD_EXCEPTION_ROOT];

  DIAGNOSTIC(5,"raising %s in thread %d",PACKET_NAME(exn),
	     CURRENT_THREAD->number);
  thread_retract_root(CURRENT_THREAD,THREAD_EXCEPTION_ROOT);
  c_raise(exn);
}

/* thread_raise_exn(t,e) raises e in thread t */

static void thread_raise_exn(struct thread_state *thread, mlval exn)
{
  DIAGNOSTIC(1,"injecting exception into thread %d from thread %d",
	     thread->number, CURRENT_THREAD->number);
  if (thread == CURRENT_THREAD)
    c_raise(exn);
  else {
    /* We need a special case for when we're trying to raise an
     * exception in a thread that hasn't ever been run.  In that
     * case the stack hasn't been set up, and in particular,
     * there will be no "raise frame" on top of the stack.  Since 
     * <URI:hope://MLWrts/src/OS/arch/.../interface.S#c_raise> assumes
     * (on all platforms) that there is a raise frame, attempting
     * to unwind the (empty) stack to find it will cause a seg fault.  So
     * in this special case, we just kill the thread in question:
     * it can have no exception handler.
     */
    if (thread->ml_state.sp == thread->ml_state.stack_top)
      SET_CONTINUATION(thread,thread_suicide);
    else {
      thread->roots[THREAD_EXCEPTION_ROOT] = exn;
      thread_declare_root(thread,THREAD_EXCEPTION_ROOT);
      SET_CONTINUATION(thread,thread_raise_continuation);
    }
  }
}

/* Now the functions which we provide to ML .... */


/* thread_fork forks a new thread to run an ML function */

static mlval thread_fork(mlval closure)
{
  struct thread_state *thread =
    make_thread(CURRENT_THREAD, CSTRING(CCODENAME(FIELD(closure, 0))));
  /* Set the thread name to be the ML function name */

  DIAGNOSTIC(1, "forking thread %d from thread %d",
	     thread->number, CURRENT_THREAD->number);

  SET_CONTINUATION(thread,run_ml_thread);
  thread->roots[THREAD_CLOSURE] = closure;
  thread_declare_root(thread,THREAD_CLOSURE);
  return(thread->ml_thread);
}

/* thread_yield picks the next thread in the scheduler loop and runs it */

extern mlval thread_yield(mlval unit)
{
  struct thread_state *thread;

  if (thread_in_critical_section)
    {
      thread_in_critical_section=0;
      exn_raise_string(perv_exn_ref_threads,
		       "Thread can't yield in a critical section");
    }


  thread_preemption_pending = 0;
  thread = CURRENT_THREAD;
  for (;;) {
    thread = thread->next;
    if (thread == CURRENT_THREAD)	/* no other runnable threads */
      return MLUNIT;
    if (thread != &TOP_THREAD) {	/* do not yield to the top thread */
      mlval result = GET_RESULT(ML_THREAD(thread));
      if ((result != THREAD_SLEEPING) &&
	  (result != THREAD_WAITING)) {	/* only yield to runnable threads */

	/* we do yield to THREAD_KILLED and THREAD_DIED threads as threads
	 * pass through those states before being taken out of the loop */

	change_thread(thread);
	return MLUNIT;
      }
    }
  }
}

/* thread_yield_to runs a specified thread */

static mlval thread_yield_to(mlval ml_thread)
{
  struct thread_state *thread = C_THREAD(ml_thread);
  mlval result;

  if (thread_in_critical_section)
    {
      thread_in_critical_section=0;
      exn_raise_string(perv_exn_ref_threads,
		       "Thread can't yield in a critical section");
    }

  if (thread == &TOP_THREAD)
    exn_raise_string (perv_exn_ref_threads,
		      "Attempt to yield to the root thread");
  else if (thread == NULL)
    exn_raise_string (perv_exn_ref_threads,
		      "Attempt to yield to a dead thread");

  result = GET_RESULT(ML_THREAD(thread));
  if (result == THREAD_SLEEPING) {
    message ("Waking thread %d",thread->number);
    SET_RESULT(ML_THREAD(thread), THREAD_RUNNING);
  }
  if (result != THREAD_RUNNING)
    exn_raise_string(perv_exn_ref_threads,
		     "Attempt to yield to a non-runnable thread");

  DIAGNOSTIC(1,"yielding directly to thread %d from thread %d",
	     thread->number, CURRENT_THREAD->number);
  change_thread(thread);
  return MLUNIT;
}

/* a bunch of functions for controlling preemption */

static mlval thread_start_preemption(mlval unit)
{
  DIAGNOSTIC(1,"starting thread preemption, interval %d",
	     thread_preemption_interval, 0);
  signal_preemption_start();
  thread_preemption_on = 1;
  return MLUNIT;
}

static mlval thread_stop_preemption(mlval unit)
{
  DIAGNOSTIC(1,"stopping thread preemption", 0, 0);
  signal_preemption_stop();
  thread_preemption_on = 0;
  return MLUNIT;
}

static mlval thread_get_interval(mlval unit)
{
  return MLINT(thread_preemption_interval);
}

static mlval thread_set_interval(mlval interval)
{
  thread_preemption_interval = CINT(interval);
  if (thread_preemption_on)
    signal_preemption_change();
  return MLUNIT;
}

static mlval thread_preempting(mlval interval)
{
  return (thread_preemption_on ? MLTRUE : MLFALSE);
}


static mlval thread_start_critical_section(mlval unit)
{
  thread_in_critical_section = 1;
  return MLUNIT;
}


static mlval thread_stop_critical_section(mlval unit)
{
  thread_in_critical_section = 0;
  if (thread_preemption_pending) thread_yield(MLUNIT);
  return MLUNIT;
}

static mlval thread_critical(mlval unit)
{
  return (thread_in_critical_section ? MLTRUE : MLFALSE);
}




/* some functions for examining the thread hierarchy */

static mlval thread_current(mlval ml_thread)
{
  return CURRENT_THREAD->ml_thread;
}

static mlval thread_number(mlval ml_thread)
{
  struct thread_state *thread = C_THREAD(ml_thread);
  if (thread == NULL)
    exn_raise_string(perv_exn_ref_threads,"Attempt to examine a dead thread");
  return MLINT(thread->number);
}

static mlval thread_children(mlval ml_thread)
{
  struct thread_state *thread = C_THREAD(ml_thread);
  struct thread_state *child;
  mlval children;
  if (thread == NULL)
    exn_raise_string(perv_exn_ref_threads,"Attempt to examine a dead thread");

  DIAGNOSTIC(3,"constructing list of children of thread %d",
	     thread->number, 0);
  child = thread->first_child;
  children = MLNIL;
  declare_root(&children, 0);

  while (child != thread) {
    children = mlw_cons(child->ml_thread, children);
    child = child->next_sib;
  }
  retract_root(&children);
  return children;
}

static mlval thread_all(mlval unit)
{
  struct thread_state *thread = &TOP_THREAD;
  mlval threads = MLNIL;
  
  DIAGNOSTIC(3,"constructing list of all threads", 0, 0);
  declare_root(&threads, 0);
  do {
    threads = mlw_cons(thread->ml_thread, threads);
    thread = thread->next;
  } while (thread != &TOP_THREAD);

  retract_root(&threads);
  return threads;
}

static mlval thread_parent(mlval ml_thread)
{
  struct thread_state *thread = C_THREAD(ml_thread);

  if (thread == NULL)
    exn_raise_string(perv_exn_ref_threads,"Attempt to examine a dead thread");
  return thread->parent->ml_thread;
}

/* thread_kill kills the specified thread */

static mlval thread_kill(mlval ml_thread)
{
  struct thread_state *thread = C_THREAD(ml_thread);
  if (thread == CURRENT_THREAD) {
    SET_RESULT(ML_THREAD(thread),THREAD_KILLED);  /* can't be sleeping. */
    thread_suicide();
  } else if (thread == &TOP_THREAD) {
    exn_raise_string(perv_exn_ref_threads,"Attempt to kill root thread");
  } else if (thread == NULL) {
    exn_raise_string(perv_exn_ref_threads,"Attempt to kill dead thread");
  }
  kill_thread(C_THREAD(ml_thread));
  return MLUNIT;
}

/* thread_raise raises an exception in the specified thread */

static mlval thread_raise(mlval arg)
{
  mlval ml_thread = FIELD(arg,0);
  mlval exn = FIELD(arg,1);
  struct thread_state *thread = C_THREAD(ml_thread);
  if (thread == &TOP_THREAD)
    exn_raise_string(perv_exn_ref_threads,
		     "Attempt to raise exception in root thread");
  if (thread == NULL)
    exn_raise_string(perv_exn_ref_threads,
		     "Attempt to raise exception in a dead thread");
  thread_raise_exn(thread,exn);
  return MLUNIT;
}

static mlval thread_sleep(mlval ml_thread)
{
  struct thread_state *thread = C_THREAD(ml_thread);
  if (thread == &TOP_THREAD)
    exn_raise_string(perv_exn_ref_threads,
		     "Attempt to put root thread to sleep");
  else if (thread == NULL)
    exn_raise_string(perv_exn_ref_threads,
		     "Attempt to put dead thread to sleep");
  else if (GET_RESULT(ml_thread) != THREAD_RUNNING)
    exn_raise_string(perv_exn_ref_threads,
		     "Attempt to put non-running thread to sleep");
  else if (runnable_threads == 2)
    exn_raise_string(perv_exn_ref_threads,
		     "Attempt to put only running thread to sleep");

  SET_RESULT(ml_thread, THREAD_SLEEPING);
  runnable_threads--;

  if (thread == CURRENT_THREAD) 
    /* then we have to continue in another thread */
    {
      thread_in_critical_section=0;
      thread_yield(MLUNIT);
    }
  return MLUNIT;
}

static mlval thread_wake(mlval ml_thread)
{
  struct thread_state *thread = C_THREAD(ml_thread);
  if (thread == NULL)
    exn_raise_string(perv_exn_ref_threads,
		     "Attempt to wake dead thread");
  else if (GET_RESULT(ml_thread) != THREAD_SLEEPING)
    exn_raise_string(perv_exn_ref_threads,
		     "Attempt to wake non-sleeping thread");

  SET_RESULT(ml_thread, THREAD_RUNNING);
  runnable_threads++;
  
  return MLUNIT;
}

static mlval thread_set_fatal_handler(mlval closure)
{
  if (!CURRENT_THREAD->declared[THREAD_HANDLER])
    thread_declare_root(CURRENT_THREAD,THREAD_HANDLER);
  CURRENT_THREAD->roots[THREAD_HANDLER] = closure;
  DIAGNOSTIC(5,"setting handler in thread %d", CURRENT_THREAD->number, 0);
  if (CURRENT_THREAD->number == 1)
    thread_1_fatal_handler = closure;
  return MLUNIT;
}

extern void threads_init(void)
{

  DIAGNOSTIC(3, "initializing thread pervasives", 0, 0);
/* some basic concurrency primitives */

  env_function("thread fork", thread_fork);
  env_function("thread yield", thread_yield);
  env_function("thread yield to", thread_yield_to);
  env_function("thread kill", thread_kill);
  env_function("thread raise", thread_raise);
  env_function("thread sleep", thread_sleep);
  env_function("thread wake", thread_wake);

/* preemption control */

  env_function("thread start preemption", thread_start_preemption);
  env_function("thread stop preemption", thread_stop_preemption);
  env_function("thread get preemption interval", thread_get_interval);
  env_function("thread set preemption interval", thread_set_interval);
  env_function("thread preempting",thread_preempting);
  env_function("thread start critical section",thread_start_critical_section);
  env_function("thread stop critical section",thread_stop_critical_section);
  env_function("thread critical",thread_critical);
  
/* navigating the thread hierarchy */

  env_function("thread current thread",thread_current);
  env_function("thread children", thread_children);
  env_function("thread all threads", thread_all);
  env_function("thread parent", thread_parent);

/* utilities */

  env_function("thread number",thread_number);
  env_function("thread set fatal handler",thread_set_fatal_handler);
  env_function("thread reset fatal status", thread_reset_fatal_status);
}
