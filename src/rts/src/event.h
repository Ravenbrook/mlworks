/*  ==== EVENT HANDLER ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  The event handler deals with asynchronous events such as signals and
 *  turns them into synchronous events that ML can deal with.  (ML can't be
 *  interrupted in the middle of an allocation, for example.)
 *
 *  Revision Log
 *  ------------
 *  $Log: event.h,v $
 *  Revision 1.5  1996/02/19 13:59:26  nickb
 *  Get rid of clean_handlers();
 *
 * Revision 1.4  1996/01/05  16:38:00  nickb
 * Add interrupt and stack-overflow events.
 *
 * Revision 1.3  1995/09/12  14:32:17  jont
 * Add a clear_handlers function for use by exportFn
 *
 * Revision 1.2  1994/06/09  14:35:36  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:01:59  nickh
 * new file
 *
 *  Revision 1.1  1992/10/23  10:19:16  richard
 *  Initial revision
 *
 */

#ifndef event_h
#define event_h

#include "mltypes.h"
#include "tags.h"


/*  === INITIALISE ===
 *
 *  This must be called before any other function in this module.  It may
 *  declare global roots.
 */

extern void ev_init(void);


/*  === POLL EVENTS ===
 *
 *  This function may be called to clear pending events.  It is usually
 *  called by the ML interface code when it detects a pending event.
 */

extern void ev_poll(void);

/*  == Event queue ==
 *
 *  If an asynchronous event occurs while another is pending, it is queued.
 */

/* event types */

enum {
  EV_SENTINEL,	/* used as a sentinel on the event queue */
  EV_SIGNAL,	/* there has been a signal; the event value is the signal no */
  EV_STACK,	/* soft stack limit exceeded */
  EV_SWITCH,	/* thread pre-empt now */
  EV_INTERRUPT,	/* there has been an interrupt */
  EV_WINDOWS	/* now might be a good time to handle window updates */
};

extern void record_event(int type, word value);

#endif
