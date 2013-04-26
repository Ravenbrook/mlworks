/*  ==== EVENT HANDLER ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Implementation
 *  --------------
 *  This is a mostly-portable interface to ML events. The harder,
 *  non-portable stuff is mostly in signals.[ch] now.
 *
 *  Revision Log
 *  ------------
 *  $Log: event.c,v $
 *  Revision 1.18  1997/01/27 16:41:12  andreww
 *  [Bug #1891]
 *  Making event EV_SWITCH yield its thread only if its not in
 *  a critical section.
 *
 * Revision 1.17  1996/06/27  15:29:38  jont
 * Change GLOBAL_MISSING_NIL to GLOBAL_MISSING_UNIT since this is what it really means
 *
 * Revision 1.16  1996/02/19  13:58:00  nickb
 * Get rid of clear_handlers().
 *
 * Revision 1.15  1996/02/16  18:39:06  nickb
 * Clear up roots on export.
 *
 * Revision 1.14  1996/02/16  14:38:30  nickb
 * Change to declare_global().
 *
 * Revision 1.13  1996/02/13  16:30:56  jont
 * Add some type casts to get compilation under VC++ to work without warnings
 *
 * Revision 1.12  1996/02/07  11:04:54  nickb
 * Reduce allocation at event time by pre-allocating a bunch of event structures.
 *
 * Revision 1.11  1996/01/19  11:36:45  nickb
 * Need global state fix for ml_interrupt_handler.
 *
 * Revision 1.10  1996/01/17  15:23:41  nickb
 * Disable interrupt handling except when a handler is defined.
 *
 * Revision 1.9  1996/01/12  15:16:50  nickb
 * Change protocol of thread_preemption_pending.
 *
 * Revision 1.8  1996/01/11  14:48:27  nickb
 * Remove "every n event" window updates; these are now done by a timer.
 *
 * Revision 1.7  1996/01/05  17:35:46  nickb
 * Add interrupt and stack-overflow events.
 *
 * Revision 1.6  1995/09/13  12:56:47  jont
 * Add a clear_handlers function for use by exportFn
 *
 * Revision 1.5  1995/04/24  13:45:33  nickb
 * Add thread_preemption_pending stuff, and X expose events.
 *
 * Revision 1.4  1995/03/29  15:06:54  nickb
 * Threads system.
 *
 * Revision 1.3  1994/07/08  10:04:48  nickh
 * Add explicit stack overflow and interrupt interfaces.
 *
 * Revision 1.2  1994/06/09  14:41:49  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:09:35  nickh
 * new file
 *
 *  Revision 1.4  1994/01/28  17:22:29  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.3  1993/04/26  11:46:58  richard
 *  Increased diagnostic level of various messages.
 *
 *  Revision 1.2  1992/11/10  11:35:06  clive
 *  Modified to allow nested event polling
 *
 *  Revision 1.1  1992/11/04  14:23:30  richard
 *  Initial revision
 *
 */

#include "syscalls.h"
#include "event.h"
#include "global.h"
#include "values.h"
#include "allocator.h"
#include "diagnostic.h"
#include "interface.h"
#include "implicit.h"
#include "utils.h"
#include "gc.h"
#include "alloc.h"
#include "signals.h"
#include "exceptions.h"
#include "environment.h"
#include "threads.h"
#include "os.h"

#include <errno.h>

/*  == ML event handlers ==
 * 
 * We have some ML event handlers for non-signal events, and an ML array of
 * handlers for signal events */

static mlval ml_interrupt_handler = MLUNIT;
static mlval ml_stack_overflow_handler = MLUNIT;
static mlval ml_signal_handlers = MLUNIT;

/*  This routine is called by the global state handler when an image is
 *  reloaded.  It runs through the ML signal handler table and sets up the
 *  C signal handler for any declared handlers.
 */

static void fix_ml_signal_handlers(const char *name, mlval *root, mlval value)
{
  int i;

  *root = value;

  for(i=1; i<(int)signal_nr_signals; ++i)
  {
    mlval handler = MLSUB(value, i);

    DIAGNOSTIC(4, "  handler for %d is 0x%X", i, handler);

    if(handler != MLUNIT)
      if (signal_set_ml_handler(i))
	error ("Couldn't fix signal handler for signal %d. "
	       "errno set to %d", i, errno);
  }
}

static mlval make_ml_signal_handler_array(void)
{
  mlval result = allocate_array(signal_nr_signals);
  unsigned int i;
  for(i=0; i<signal_nr_signals; ++i)
    MLUPDATE(result, i, MLUNIT);
  return result;
}

static void replace_ml_signal_handlers(const char *name, mlval *root)
{
  *root = make_ml_signal_handler_array();
}

static void fix_ml_interrupt_handler(const char *name,
				     mlval *root, mlval value)
{
  *root = value;
  if (value != MLUNIT)
    if (signal_set_interrupt_handler())
      error("Couldn't set interrupt handler");
}

/* the event queue */

struct event {
  int type;	/* from the enum defined in event.h */
  word value;	/* some ancillary value */
  struct event *forward, *back;
} event_queue, *free_events;

/* establish the free event list */

#define EVENT_BUFFER_SIZE		20

static void allocate_some_events(void)
{
  int i;
  struct event *event;

  event = (struct event *)alloc(sizeof(struct event) * EVENT_BUFFER_SIZE,
				"Couldn't allocate events");
  free_events = event;
  for (i = EVENT_BUFFER_SIZE-1; i; i--) {
    event->forward = event+1;
    event++;
  }
  event->forward = NULL;
}

static void free_event(struct event *event)
{
  event->forward = free_events;
  free_events = event;
}

static struct event *alloc_event(void)
{
  struct event *event;
  if (free_events == NULL)
    allocate_some_events();
  event = free_events;
  free_events = event->forward;
  return event;
}

/*  === POLL EVENTS ===  */

void ev_poll()
{
  DIAGNOSTIC(2, "ev_poll()  %d pending events", event_queue.value, 0);

  /* Always check the start of the queue in case there are nested calls to */
  /* ev_poll() or more events are introduced during a handler. */

  while(event_queue.forward->type != EV_SENTINEL)
  {
    struct event *current = event_queue.forward;
    struct event event = *current;

    event.back->forward = event.forward;
    event.forward->back = event.back;
    --event_queue.value;
    free_event(current);

    switch(event.type) {
    case EV_SIGNAL:
      callml(MLINT(event.value), MLSUB(ml_signal_handlers, event.value));
      break;
    case EV_STACK:
      if (ml_stack_overflow_handler != MLUNIT)
	callml(MLUNIT, ml_stack_overflow_handler);
      break;
    case EV_INTERRUPT:
      if (ml_interrupt_handler != MLUNIT) {
	thread_in_critical_section = 0;
	callml(MLUNIT, ml_interrupt_handler);}
      break;
    case EV_SWITCH:
      if (!thread_in_critical_section) {(void)thread_yield(MLUNIT);}
	else return;
      break;
    case EV_WINDOWS:
      os_update_windows();
      break;
    default:
      error("Unknown event type %d found on event queue", event.type);
    }
  }
}

/* add an event to the event queue */

extern void record_event(int type, word value)
{
  struct event *event;

  event = alloc_event();
  event->type = type;
  event->value = value;

  event->forward = &event_queue;
  event->back = event_queue.back;
  event->forward->back = event;
  event->back->forward = event;
  ++event_queue.value;
  signal_event();
}

/* install/remove a signal event handler */

static inline void event_set_signal_handler(int sig, mlval handler)
{
  if (handler == MLUNIT ?
      signal_clear_ml_handler(sig)
      : signal_set_ml_handler(sig))
    switch(errno) {
    case ESIGNALNO:
      exn_raise_string (perv_exn_ref_signal, "Illegal signal number");
    default:
      exn_raise_string (perv_exn_ref_signal, "Unexpected error");
    }
   
  MLUPDATE(ml_signal_handlers, (unsigned) sig, handler);
}

/*  === REGISTER A SIGNAL EVENT HANDLER ===
 *
 *  An ML function may be registered to be called when a signal occurs.  (In
 *  fact, it will be called at the next `safe' opportunity).
 *
 *  event_signal takes a pair: a signal number and an ML function,
 *  (type int -> unit) to call. It return MLUNIT.
 */

static mlval event_signal(mlval argument)
{
  int sig = CINT(FIELD(argument, 0));
  mlval handler = FIELD(argument,1);

  DIAGNOSTIC(2, "event_signal(sig = %d, handler = 0x%X)", sig, handler);

  if (sig <= 0 || sig >= (int)signal_nr_signals)
    exn_raise_string (perv_exn_ref_signal, "Illegal signal number");

  event_set_signal_handler(sig, handler);

  return (MLUNIT);
}

/* set/unset the stack overflow handler */

static mlval event_stack_overflow(mlval handler)
{
  ml_stack_overflow_handler = handler;
  return MLUNIT;
}

/* set/unset the interrupt handler */

static mlval event_interrupt(mlval handler)
{
  ml_interrupt_handler = handler;
  if (handler == MLUNIT ?
      signal_clear_interrupt_handler() :
      signal_set_interrupt_handler())
    exn_raise_string (perv_exn_ref_signal, "Unexpected error");
  return MLUNIT;
}

/*  === INITIALISE ===  */

void ev_init(void)
{
  /* Empty the event queue */
  event_queue.forward = event_queue.back = &event_queue;
  event_queue.value = 0;

  allocate_some_events();

  ml_signal_handlers = make_ml_signal_handler_array();
  ml_interrupt_handler = MLUNIT;
  ml_stack_overflow_handler = MLUNIT;

  declare_global("signal event handler table", &ml_signal_handlers,
		 GLOBAL_ENV, NULL, fix_ml_signal_handlers,
		 replace_ml_signal_handlers);
  declare_global("interrupt handler", &ml_interrupt_handler,
		 GLOBAL_ENV+GLOBAL_MISSING_UNIT,
		 NULL, fix_ml_interrupt_handler, NULL);
  declare_global("stack overflow handler", &ml_stack_overflow_handler,
		 GLOBAL_ENV+GLOBAL_MISSING_UNIT, NULL, NULL, NULL);

  env_function ("event signal", event_signal);
  env_function ("event signal stack overflow", event_stack_overflow);
  env_function ("event signal interrupt", event_interrupt);
}
