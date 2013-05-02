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
 * This file abstracts the OS-specific signal handling code from
 * the various parts of the runtime system.
 *
 * 
 * Revision Log
 * ------------
 * $Log: signals.h,v $
 * Revision 1.11  1998/07/02 14:54:08  jont
 * [Bug #70132]
 * Add signals_finalise
 *
 * Revision 1.10  1996/10/17  14:05:23  jont
 * Merging in license server stuff
 *
 * Revision 1.9.2.3  1996/10/09  13:52:46  nickb
 * Improve comments.
 *
 * Revision 1.9.2.2  1996/10/09  11:06:16  nickb
 * Move to Harlequin license server.
 *
 * Revision 1.9.2.1  1996/10/07  16:15:33  hope
 * branched from 1.9
 *
 * Revision 1.9  1996/02/08  17:53:01  jont
 * Remove do_exportFn, as this is no longer part of the signals interface
 *
 * Revision 1.8  1996/01/17  15:21:48  nickb
 * Disable interrupt handling except when a handler is defined.
 *
 * Revision 1.7  1996/01/11  12:51:34  nickb
 * Add timer-triggered window updates.
 *
 * Revision 1.6  1996/01/09  13:54:14  nickb
 * Extensions to event handling for non-signal events.
 *
 * Revision 1.5  1995/09/15  14:59:43  jont
 * Add support for signals handling of export child process
 *
 * Revision 1.4  1995/03/15  13:32:08  nickb
 * Introduce the threads system.
 *
 * Revision 1.3  1994/07/08  09:54:11  nickh
 * Add interrupt signal number.
 *
 * Revision 1.2  1994/06/09  14:51:15  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:25:59  nickh
 * new file
 *
 */

#ifndef signals_h
#define signals_h

#include "mltypes.h"

/* Initialize some signal handlers */

extern void signals_init (void);

/* Finalise signals. This may be responsible for killing some threads */

extern void signals_finalise (void);

/* These values and functions control the interval timer. The actions
 * when it goes off are determined by whether we are profiling and
 * whether we are pre-empting threads. If we are profiling, the
 * profiler is run. If we are pre-empting, an event is signalled to
 * the current thread.
 * 
 * The intervals at which the timer goes off are also determined by
 * whether we are profiling. If we are, the profiling interval
 * determines the interval. Otherwise, the pre-emption interval does.
 */

extern unsigned int thread_preemption_interval;
extern unsigned int profiling_interval;
extern unsigned int window_update_interval;

extern void signal_preemption_start(void);
extern void signal_preemption_stop(void);
extern void signal_preemption_change(void);

extern void signal_profiling_start(void);
extern void signal_profiling_stop(void);

extern void signal_window_updates_start(void);
extern void signal_window_updates_stop(void);


/* Non-event signal support. To record a non-signal event (e.g. stack
   overflow, or to request window updates), other parts of the runtime
   call a function in the events module. That records the event on the
   event queue and then must set some flag or flags to notify the
   running ML code of the event. This platform-specific notification
   is done here. */

extern void signal_event(void);

/* ML signal handler support; establish or remove the ML signal handler.  */

extern unsigned int signal_nr_signals;

extern int signal_set_ml_handler(int sig);
extern int signal_clear_ml_handler(int sig);

extern int signal_set_interrupt_handler(void);
extern int signal_clear_interrupt_handler(void);

enum /* values for errno */
{
  ESIGNALNO = 1,		/* illegal signal number */
};

#endif /* signals_h */
