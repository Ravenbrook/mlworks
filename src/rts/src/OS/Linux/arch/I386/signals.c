/* ==== SIGNAL HANDLING ====
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
 * Description
 * -----------
 * This module abstracts the OS-specific signal handling code from
 * the various parts of the runtime system.
 *
 * 
 * Revision Log
 * ------------
 * $Log: signals.c,v $
 * Revision 1.29  1997/01/30 18:11:49  jont
 * Merge in license stuff
 *
 * Revision 1.28.2.2  1996/10/09  11:13:32  nickb
 * Move to Harlequin license server.
 *
 * Revision 1.28.2.1  1996/10/07  16:14:04  hope
 * branched from 1.28
 *
 * Revision 1.28  1996/06/07  09:32:04  jont
 * Update best before to 01/01/97
 *
 * Revision 1.27  1996/02/08  16:06:14  jont
 * Removing do_exportFn, as this is no longer architecture dependent
 *
 * Revision 1.26  1996/02/08  14:52:40  jont
 * Modify exportFn mechanism not to use signals at all
 * Use busy waiting in parent instead, thus avoiding
 * potential race contions
 *
 * Revision 1.25  1996/02/07  12:15:46  nickb
 * Make interval window updates happen even if we stay in ML.
 *
 * Revision 1.24  1996/01/17  17:06:40  nickb
 * Disable interrupt handling except when a handler is defined.
 *
 * Revision 1.23  1996/01/17  11:39:57  nickb
 * Remove storage manager interface.
 *
 * Revision 1.22  1996/01/16  13:03:25  stephenb
 * Fix bug #995 - death of last thread due to a fatal signal should
 * result in a non-zero termination code.
 *
 * Revision 1.21  1996/01/12  16:45:38  stephenb
 * Fix handle_fatal_signal so that it is a little more robust
 * with respect to dealing with fatal signals that occur whilst
 * it is active i.e. generally stop it looping.
 *
 * Revision 1.20  1996/01/12  16:29:10  nickb
 * Stupid omission.
 *
 * Revision 1.19  1996/01/11  15:08:09  nickb
 * Add timer-triggered window updates.
 *
 * Revision 1.18  1996/01/09  13:27:35  nickb
 * Extensions to event handling for non-signal events.
 *
 * Revision 1.17  1996/01/02  16:45:03  nickb
 * Update best-before date.
 *
 * Revision 1.16  1995/11/24  11:36:15  nickb
 * Add code to fixup the sp before profiling.
 *
 * Revision 1.15  1995/09/19  14:42:39  nickb
 * Improve the full GC we do during function export.
 *
 * Revision 1.14  1995/09/15  17:17:52  jont
 * Add do_exportFn to do the system specific part of exportFn
 *
 * Revision 1.13  1995/09/01  10:10:46  nickb
 * Fix licensing code (the read call is being interrupted by the timing
 * interrupt).
 *
 * Revision 1.12  1995/08/04  16:00:07  nickb
 * record_event() using wrong slot in the implicit vector.
 *
 * Revision 1.11  1995/08/04  13:32:35  nickb
 * Linux signal handling; a first attempt.
 * ,
 *
 * Revision 1.10  1995/07/17  12:37:37  nickb
 * Change profiler interface.
 *
 * Revision 1.9  1995/07/03  10:18:33  nickb
 * Update best-before date.
 *
 * Revision 1.8  1995/05/05  12:07:49  nickb
 * Remove an X-Windows line.
 *
 * Revision 1.7  1995/04/27  13:04:10  daveb
 * If signal_ml_handler is called while we are waiting for an X event,
 * the runtime just prints a message.  This avoids problems with pointer
 * grabs in X callbacks.
 *
 * Revision 1.6  1995/04/24  15:17:49  nickb
 * Add thread_preemption_pending.
 *
 * Revision 1.5  1995/03/15  16:51:18  nickb
 * Introduce the threads system.
 *
 * Revision 1.4  1995/01/05  12:51:51  nickb
 * Amend best-before date to 1st July 1995.
 * Also fix Harlequin's telephone number.
 * Also make license signal handler run on the current stack.
 *
 * Revision 1.3  1994/11/23  16:50:21  nickb
 * Remove set_stack_underflow() call.
 *
 * Revision 1.2  1994/10/12  09:58:16  jont
 * Remove gc trap stuff
 *
 * Revision 1.1  1994/10/04  16:36:01  jont
 * new file
 *
 * Revision 1.8  1994/09/07  10:05:04  jont
 * Update license expiry date
 *
 * Revision 1.7  1994/07/25  13:16:54  nickh
 * Make sure all handlers execute on signal stack.
 *
 * Revision 1.6  1994/07/22  14:33:33  nickh
 * Add GC trap handling.
 *
 * Revision 1.5  1994/07/08  10:03:57  nickh
 * Add interrupt signal number and reserve two more signals.
 *
 * Revision 1.4  1994/06/14  14:51:09  jont
 * Add critical region support for FP signals
 *
 * Revision 1.3  1994/06/13  12:02:58  nickh
 * Update best-before date.
 *
 * Revision 1.2  1994/06/09  14:24:13  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:49:10  nickh
 * new file
 *
 */

#include "signals.h"
#include "utils.h"
#include "diagnostic.h"
#include "interface.h"
#include "implicit.h"
#include "values.h"
#include "gc.h"
#include "stacks.h"
#include "syscalls.h"
#include "exceptions.h"
#include "event.h"
#include "profiler.h"
#include "ansi.h"
#include "reals.h"
#include "alloc.h"
#include "state.h"
#include "x.h"
#include "main.h"
#include "pervasives.h"
#include "global.h"
#include "allocator.h"
#include "i386_code.h"
#include "image.h"

#include <time.h>
#include <sys/types.h>
#include <sys/time.h>
#include <string.h>
#include <memory.h>
#include <sys/wait.h>
#include <signal.h>
#include <sys/signal.h>
#include <errno.h>
#include <sys/errno.h>
#include <math.h>
#include <unistd.h>

/* ML signal handler support */

#define NR_SIGNALS	32
#define SIGNAL_STACK_SIZE 	8192

unsigned int signal_nr_signals = NR_SIGNALS;

/* an array of flags showing how signals are handled */

#define SIGNAL_NOT_HANDLED 	((word)0)
#define SIGNAL_HANDLED_IN_ML	((word)1)
#define SIGNAL_HANDLED_IN_C	((word)2)
#define SIGNAL_HANDLED_FATALLY	((word)4)


static word *signal_handled = NULL;

static struct signal_name {int number;
			   const char *name;
			 } signal_names [] =
{{SIGHUP,	"SIGHUP"},
 {SIGINT,	"SIGINT"},
 {SIGQUIT,	"SIGQUIT"},
 {SIGILL,	"SIGILL"},
 {SIGTRAP,	"SIGTRAP"},
 {SIGABRT,	"SIGABRT"},
 {SIGBUS,	"SIGBUS"},
 {SIGFPE,	"SIGFPE"},
 {SIGKILL,	"SIGKILL"},
 {SIGUSR1,	"SIGUSR1"},
 {SIGSEGV,	"SIGSEGV"},
 {SIGUSR2,	"SIGUSR2"},
 {SIGPIPE,	"SIGPIPE"},
 {SIGALRM,	"SIGALRM"},
 {SIGTERM,	"SIGTERM"},
 {SIGSTKFLT,	"SIGSTKFLT"},
 {SIGCHLD,	"SIGCHLD"},
 {SIGCONT,	"SIGCONT"},
 {SIGSTOP,	"SIGSTOP"},
 {SIGTSTP,	"SIGTSTP"},
 {SIGTTIN,	"SIGTTIN"},
 {SIGTTOU,	"SIGTTOU"},
 {SIGURG,	"SIGURG"},
 {SIGXCPU,	"SIGXCPU"},
 {SIGXFSZ,	"SIGXFSZ"},
 {SIGVTALRM,	"SIGVTALRM"},
 {SIGPROF,	"SIGPROF"},
 {SIGWINCH,	"SIGWINCH"},
 {SIGIO,	"SIGIO"},
 {SIGPWR,	"SIGPWR"},
 {SIGUNUSED,	"SIGUNUSED"},
 {0,		NULL}};

static const char *name_that_signal (int sig)
{
  static const char *no_such_signal = "Unknown";
  struct signal_name *this = signal_names;

  while (this->number != sig &&
	 this->name != NULL)
    this++;

  if (this->name == NULL)
    return no_such_signal;
  else
    return this->name;
}

/* Linux-specific stuff for setting and clearing a signal handler */

typedef void (*signal_handler)(int sig, struct sigcontext sc);

static int check_sigaction (int sig, struct sigaction *act)
{
  int result = sigaction (sig,act,NULL);

  if (result)
    switch(errno) {
    case EINVAL:
      errno = ESIGNALNO;
      break;
    default:
      error("sigaction returned an unexpected error code %d", errno);
    }
  return result;
}

static int set_signal_handler(int sig, signal_handler handler)
{
  struct sigaction sa;
  sa.sa_handler = (__sighandler_t) handler;
  sigemptyset(&sa.sa_mask);
  sa.sa_flags = 0;
      
  return (check_sigaction (sig,&sa));
}

static int restore_default_signal_handler(int sig)
{
  struct sigaction sa;
  sa.sa_handler= SIG_DFL;
  sigemptyset(&sa.sa_mask);
  sa.sa_flags= 0;
  return check_sigaction(sig, &sa);
}

/* signal_event() is called from record_event (in the events
   module). It can be called either synchronously in C or
   asynchronously in C or ML. It should set the 'interrupted' flag
   such that the event is taken synchronously by ML when we return to
   ML. */

extern void signal_event(void)
{
  /* set the thread state interrupt slot to -1 */
  CURRENT_THREAD->implicit.interrupt = (unsigned)-1;
}

static void signal_ml_event (void)
{
  if (global_state.in_ML)
    CURRENT_THREAD->implicit.register_stack_limit = (unsigned)-1;
}

/*  == The C signal handler ==
 *
 *  This function converts a C signal into an ML signal event.
 */

static void ml_signal_handler(int sig)
{
  record_event(EV_SIGNAL, (word) sig);
  signal_ml_event();
}

static void signal_ml_handler(int sig, struct sigcontext sc)
{
  ml_signal_handler(sig);
}

/* Install or remove the signal handler for a given signal */

extern int signal_set_ml_handler(int sig)
{
  word handled = signal_handled[sig];
  if ((handled & SIGNAL_HANDLED_IN_ML) == 0) {
    signal_handled[sig] = handled + SIGNAL_HANDLED_IN_ML;
    if ((handled & SIGNAL_HANDLED_IN_C) == 0) {
      return set_signal_handler(sig,signal_ml_handler);
    }
  }
  return 0;
}

extern int signal_clear_ml_handler(int sig)
{
  word handled = signal_handled[sig];
  if (handled & SIGNAL_HANDLED_IN_ML) {
    signal_handled[sig] = handled = handled - SIGNAL_HANDLED_IN_ML;
    if (handled == 0) {
      return restore_default_signal_handler(sig);
    }
  }
  return 0;
}

/* Do something tolerable in the face of a fatal signal */

static mlval signal_thread_suicide_stub[] = {0, 0, (mlval)thread_suicide};

static void restore_default_fatal_signal_handlers(void)
{
  int i;
  for (i=0; i < NR_SIGNALS; i++) {
    if (signal_handled[i] & SIGNAL_HANDLED_FATALLY) {
      signal_handled[i] -= (SIGNAL_HANDLED_FATALLY + SIGNAL_HANDLED_IN_C);
      if (restore_default_signal_handler(i) != 0)
	error_without_alloc("Could not restore default fatal signal handlers");
    }
  }
}

static void die_in_fatal_signal_handler(char const *message)
{
  /* race condition here if the following call fails with a fatal signal */
  restore_default_fatal_signal_handlers();
  message_stderr("Fatal signal handler dying: %s", message);
}

static void handle_fatal_signal(int sig, struct sigcontext sc)
{
  if (CURRENT_THREAD == 0) {
    die_in_fatal_signal_handler("corrupt threads system");

  } else if (CURRENT_THREAD->in_fatal_signal_handler) {
    die_in_fatal_signal_handler("fatal signal raised by handler");

  } else if (in_GC) {
    die_in_fatal_signal_handler("fatal signal raised during GC.");

  } else {
    const char *signal_name;
    mlval handler;

    CURRENT_THREAD->in_fatal_signal_handler= 1;
    signal_name= name_that_signal (sig);
    handler= THREAD_ERROR_HANDLER(CURRENT_THREAD);

    DIAGNOSTIC(2, "signal_handler(sig = %d)", sig, 0);

    if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
      ml_signal_handler(sig);

    if (handler == MLUNIT) {
      /* there is no handler; print a message and kill this thread. */
      if (runnable_threads == 2) {
	die_in_fatal_signal_handler("Last thread dying.");
      } else {
	word sp = i386_fixup_sp(sc.esp,sc.eip,sc.edi,sc.ebp,sc.ecx);
	message ("Thread #%d received an intolerable signal %s (%d) %sin ML and died.",
		 CURRENT_THREAD->number, signal_name, sig, 
		 global_state.in_ML? "" : "not ");

	backtrace ((struct stack_frame *)sp, CURRENT_THREAD, max_backtrace_depth);
	SET_RESULT(ML_THREAD(CURRENT_THREAD), THREAD_DIED);
	if (global_state.in_ML) { 
	  sc.eip = (int)stub_c+CODE_OFFSET;                 /* code pointer */
	  sc.ebx = MLUNIT;	                            /* argument */
	  sc.ebp = (int)signal_thread_suicide_stub+POINTER; /* closure */
	} else {
	  /* this will be very lucky to work */
	  sc.eip = (int) thread_suicide;                    /* code pointer */
	}
	/* to reduce the race window the following should be near the
	 * end of thread_suicide.  However, that entails putting it in
	 * the end of the asm routine change_thread, so for simplicity it
	 * is left here. */
	CURRENT_THREAD->in_fatal_signal_handler= 0;
      }
    } else {
      /* there is a handler; skip to it */
      sc.ebx = MLINT(sig);				/* argument */
      sc.ebp = handler;					/* closure */
      if (global_state.in_ML)
	sc.eip = FIELD(handler,0)+CODE_OFFSET;		/* code pointer */
      else
	/* this won't work at all */
	sc.eip = (int)callml;				/* code pointer */

      /* Note that CURRENT_THREAD->in_fatal_signal_handler is not reset here.
       * The onus is on the SML fatal signal handler to call the SML
       * version of thread_reset_fatal_status before returning. */
    }
  }
}

/* Install the above function for a given signal */

static int die_on_signal(int sig)
{
  signal_handled[sig] |= SIGNAL_HANDLED_IN_C | SIGNAL_HANDLED_FATALLY;
  return set_signal_handler(sig,handle_fatal_signal);
}

/* == Interrupt Support ==
 * 
 * SIGINT is handled and interpreted as an interrupt. */

static void signal_interrupt_handler (int sig, struct sigcontext sc)
{
  if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
    ml_signal_handler(sig);
  else 
    signal_ml_event();
  
  record_event(EV_INTERRUPT, (word) 0);
}

extern int signal_set_interrupt_handler(void)
{
  signal_handled[SIGINT] |= SIGNAL_HANDLED_IN_C;	/* interrupt */
  return set_signal_handler(SIGINT,signal_interrupt_handler);
}

extern int signal_clear_interrupt_handler(void)
{
  signal_handled[SIGINT] &= !SIGNAL_HANDLED_IN_C;

  if (signal_handled[SIGINT] & SIGNAL_HANDLED_IN_ML)
    return signal_set_ml_handler(SIGINT);
  else
    return restore_default_signal_handler(SIGINT);
}

/* == Timer support ==
 *
 * We need a virtual-time alarm for several purposes: stack-based
 * profiling, thread pre-emption, and window updates.
 */

static struct itimerval interval_timer, residual_timer;
unsigned int current_interval = 0;

/* the number of milliseconds for the profiling and pre-emption intervals. */

unsigned int profiling_interval = 0;
unsigned int thread_preemption_interval = 0;
unsigned int window_update_interval = 0;
static unsigned int window_update_remaining = 0;
static unsigned int window_updates_on = 0;

static void signal_start_timer(void)
{
  if(setitimer(ITIMER_VIRTUAL, &interval_timer, &residual_timer) == -1)
    message("Warning: Unable to set interval timer. \n"
	    " Profiling, preemption, and window updates may not occur");
}

static unsigned int signal_set_timer(unsigned int interval)
{
  unsigned int last_interval = current_interval;
  current_interval = interval;
  interval_timer.it_value.tv_sec = interval/1000;
  interval_timer.it_value.tv_usec = (interval%1000)*1000;
  interval_timer.it_interval.tv_sec = 0;
  interval_timer.it_interval.tv_usec = 0; /* one shot timer */

  signal_start_timer();
  interval = ((residual_timer.it_value.tv_sec * 1000) +
	      (residual_timer.it_value.tv_usec / 1000));
  interval = last_interval - interval;
  return interval;
}

static int signal_update_windows(unsigned int interval)
{
  if (window_update_remaining < interval) {
    window_update_remaining = window_update_interval;
    if (window_updates_on) {
      record_event(EV_WINDOWS, (word) 0);
      return 1;
    }
  } else
    window_update_remaining -= interval;
  return 0;
}
  
static void signal_do_timer(unsigned int interval)
{
  unsigned int residue = signal_set_timer(interval);
  (void) signal_update_windows(residue);
}

/* The signal handler function. If we're profiling we run the
 * profiler. If we're pre-empting we record the event. */

static void signal_interval_alarm (int sig, struct sigcontext sc)
{
  if (signal_handled[sig] & SIGNAL_HANDLED_IN_ML)
    ml_signal_handler(sig);

  if (profile_on) {
    time_profile_scan((struct stack_frame *)
		      i386_fixup_sp(sc.esp,sc.eip,sc.edi,sc.ebp,sc.ecx));
  }
  if (thread_preemption_on) {
    thread_preemption_pending = 1;
    record_event(EV_SWITCH, (word)0);
    if ((signal_handled[sig] & SIGNAL_HANDLED_IN_ML) == 0)
      signal_ml_event();
  }

  if (signal_update_windows (current_interval))
    signal_ml_event();
  signal_start_timer();
}

/* == Profiling support == */

extern void signal_profiling_start(void)
{
  signal_do_timer(profiling_interval);
}

extern void signal_profiling_stop(void)
{
  unsigned int interval;
  if (thread_preemption_on)
    interval = thread_preemption_interval;
  else if (window_updates_on)
    interval = window_update_interval;
  else
    interval = 0;
  signal_do_timer(interval);
}

/* == Preemption support == */

extern void signal_preemption_start(void)
{
  if (!profile_on)
    signal_do_timer(thread_preemption_interval);
}

extern void signal_preemption_stop(void)
{
  if (!profile_on) {
    unsigned int interval;
    if (window_updates_on)
      interval = window_update_interval;
    else
      interval = 0;
    signal_do_timer(interval);
  }
}

extern void signal_preemption_change(void)
{
  signal_preemption_start();
}

/* Window update support */

extern void signal_window_updates_start(void)
{
  window_updates_on = 1;
  if (current_interval == 0)
    signal_do_timer(window_update_interval);
}

extern void signal_window_updates_stop(void)
{
  window_updates_on = 0;
}

static void establish_signal_table(void)
{
  int i;
  signal_handled = (word*) alloc(NR_SIGNALS * sizeof(word),
				 "Unable to allocate signal table");
  for (i=0; i < NR_SIGNALS; i++)
    signal_handled[i] = SIGNAL_NOT_HANDLED;
  signal_handled[SIGVTALRM] = SIGNAL_HANDLED_IN_C;	/* intervals */
}

extern void signals_init (void)
{
  establish_signal_table();
  
  /* virtual interval alarm handler */
  if (set_signal_handler(SIGVTALRM, signal_interval_alarm))
    error("Unable to set up virtual interval timer signal handler.");

  /* these signals are fatal */

  die_on_signal (SIGILL);
  die_on_signal (SIGSEGV);
}
