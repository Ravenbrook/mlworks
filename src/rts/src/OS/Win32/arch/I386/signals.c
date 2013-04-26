/* ==== SIGNAL HANDLING ====
 * 
 * Copyright (C) 1994 Harlequin Ltd.
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
 * Revision 1.2  1998/07/02 16:03:01  jont
 * [Bug #70132]
 * Add signals_finalise
 *
 * Revision 1.1  1997/04/08  10:39:57  jont
 * new unit
 * Common for both NT and Win95
 *
 *
 * Moved from OS/NT/arch/I386/signals.c for commonality of code
 *
 * Revision 1.15  1997/03/25  17:34:05  jont
 * Stop trying to set intervals of zero when profiling
 *
 * Revision 1.14  1996/10/31  14:21:10  johnh
 * Added interrupt functionality to Windows.
 *
 * Revision 1.13  1996/10/17  13:58:30  jont
 * Merge in license stuff
 *
 * Revision 1.12.2.2  1996/10/09  11:16:32  nickb
 * Move to Harlequin license server.
 *
 * Revision 1.12.2.1  1996/10/07  16:16:13  hope
 * branched from 1.12
 *
 * Revision 1.12  1996/03/04  12:45:31  stephenb
 * Update wrt wintimer.h -> timer.h change.
 *
 * Revision 1.11  1996/02/08  16:41:48  jont
 * Removing do_exportFn, as this is no longer architecture dependent
 *
 * Revision 1.10  1996/01/18  12:41:27  stephenb
 * Remove include of winmain.h since it screws the compile up.
 *
 * Revision 1.9  1996/01/17  17:02:41  nickb
 * Disable interrupt handling except when a handler is defined.
 *
 * Revision 1.8  1996/01/11  15:23:06  nickb
 * Add stubs for timer-triggered window updates.
 *
 * Revision 1.7  1996/01/09  13:53:54  nickb
 * Extensions to event handling for non-signal events.
 *
 * Revision 1.6  1995/12/13  15:44:57  nickb
 * Extend time profiling.
 *
 * Revision 1.5  1995/11/15  14:47:55  nickb
 * Add timer capabilities.
 *
 * Revision 1.4  1995/09/15  17:37:31  jont
 * Add dummy implementation of do_exportFn
 *
 * Revision 1.3  1995/07/17  15:48:47  nickb
 * Change profiler interface.
 *
 * Revision 1.2  1995/03/15  16:53:15  nickb
 * Introduce the threads system.
 *
 * Revision 1.1  1994/12/12  15:05:07  jont
 * new file
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
#include "license.h"
#include "profiler.h"
#include "ansi.h"
#include "reals.h"
#include "alloc.h"
#include "main.h"
#include "pervasives.h"
#include "global.h"
#include "allocator.h"
#include "timer.h"
#include "native_threads.h"
#include "state.h"

#include <time.h>
#include <sys/types.h>
#include <string.h>
#include <memory.h>
#include <signal.h>
#include <errno.h>
#include <math.h>

/* ML signal handler support */

#define NR_SIGNALS	0
extern unsigned int signal_nr_signals = NR_SIGNALS;

/* Install or remove the signal handler for a given signal */

extern int signal_set_ml_handler(int sig)
{
  errno = ESIGNALNO;
  return 1;
}

extern int signal_clear_ml_handler(int sig)
{
  errno = ESIGNALNO;
  return 1;
}

/* == Event support ==
 */

/* signal_event() is called from record_event (in the events
   module). It can be called either synchronously in C or
   asynchronously in C or ML. It should set the 'interrupted' flag
   such that the event is taken synchronously by ML when we return to
   ML. */

extern void signal_event(void)
{
  /* set the thread state interrupt slot to -1 */
  CURRENT_THREAD->implicit.interrupt = (unsigned)-1;
  if (global_state.in_ML)
    CURRENT_THREAD->implicit.register_stack_limit = (unsigned)-1;
}

/* == Licensing support ==
 * 
 * We don't support licensing on Windows. */

/* == Interrupt support == */

extern int signal_set_interrupt_handler(void)
{
  return win32_set_ctrl_c_handler();
}

extern int signal_clear_interrupt_handler(void)
{
  return win32_clear_ctrl_c_handler();
}

/* == Timer support ==
 * 
 * We have a timer for two purposes: for stack-based profiling and for
 * thread pre-emption. The timer is mainly implemented in wintimer.c
 * and native_threads.c
 */

static unsigned int timer_interval;

/* the number of milliseconds for the profiling, pre-emption and
 * window update intervals. */

unsigned int profiling_interval = 0;
unsigned int thread_preemption_interval = 0;
unsigned int window_update_interval = 0;
static unsigned int window_update_remaining = 0;
static unsigned int window_updates_on = 0;


/* signal_update_windows: return value needed to comply with the shared
 * header file in <URI: src/rts/src/os.h>.  If window updates are started
 * (which is typically during compilation or computation within a 
 * listener), then an event is recorded to handle Window messages sent to
 * the MLWorks environment, and to check for the interrupt button being 
 * pressed. See <URI: src/rts/src/OS/Win32/os.c> and also 
 * <URI: src/rts/src/OS/Win32/window.c:mlw_expose_windows>. 
 */
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

static inline void signal_set_timer(unsigned int interval)
{
  if (interval != 0) {
    timer_interval = interval;
    start_timer(timer_interval);
  }
}

/* The timer function. If we're profiling we run the profiler. If
 * we're pre-empting we record the event. */

static void signal_interval_alarm(void)
{
  if (profile_on) {
    word *current_thread = suspend_current_thread();
    time_profile_scan((struct stack_frame *)
		      reconstruct_thread_sp(current_thread));
    resume_current_thread(current_thread);
  }

  if (thread_preemption_on) {
    thread_preemption_pending = 1;
    record_event(EV_SWITCH, (word)0);
  }

  signal_update_windows (timer_interval);

  start_timer(timer_interval);
}

static void timer_thread(void)
{
  for(;;) {
    timer_thread_wait();
    signal_interval_alarm();
  }
}

/* == Licensing support == */

extern void signal_license_timer(int interval)
{
  error("Licensing not operative on Win32");
}

/* == Profiling support == */

extern void signal_profiling_start(void)
{
  signal_set_timer(profiling_interval);
}

extern void signal_profiling_stop(void)
{
  unsigned int interval;
  stop_timer();
  if (thread_preemption_on)
    interval = thread_preemption_interval;
  else if (window_updates_on)
    interval = window_update_interval;
  else
    interval = 0;
  signal_set_timer(interval);
}

/* == Preemption support == */

extern void signal_preemption_start(void)
{
  if (!profile_on)
    signal_set_timer(thread_preemption_interval);
}

extern void signal_preemption_stop(void)
{
  if (!profile_on) {
    unsigned int interval;
    stop_timer();
    if (window_updates_on)
      interval = window_update_interval;
    else 
      interval = 0;
    signal_set_timer(interval);
  }
}

extern void signal_preemption_change(void)
{
  signal_preemption_start();
}

/* == Window updates == */

/* signal_window_updates_{start,stop} used in <URI: src/rts/src/OS/Win32/window.c>
 * Started typically before compilation and before any computation in a 
 * listener.  Note: starting window updates also allows the checking of an 
 * interrupt button being pressed.
 */ 
extern void signal_window_updates_start()
{
  window_updates_on = 1;
  if (timer_interval == 0)
    signal_set_timer(window_update_interval);
}

extern void signal_window_updates_stop()
{
  window_updates_on = 0;
}

extern void signals_init (void)
{
  make_timer_thread(timer_thread);
  init_timer();
}

extern void signals_finalise(void)
{
  unmake_timer_thread(); /* Don't need this any more */
}
