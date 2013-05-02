/*  ==== TIMER INTERFACE FOR WIN32 ====
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
 *  Notes:
 * 
 *  Under Windows, we cannot use a Unix-style signal handler to run
 *  our profiling and thread preemption timer code. Instead we use
 *  "multi-media timers" (intimately connected with joysticks, in that
 *  serious programming environment which is Windows). Sadly these are
 *  real-time rather than virtual-time, so they run constantly. 
 *  
 *  Revision Log
 *  ------------
 *  $Log: timer.c,v $
 *  Revision 1.4  1998/08/11 12:07:37  jont
 *  [Bug #01957]
 *  Retry setTimeEvent if it returns NULL
 *
 * Revision 1.3  1998/04/20  12:43:24  jont
 * [Bug #70100]
 * Remove compiler warning
 *
 * Revision 1.2  1998/03/20  13:49:00  jont
 * [Bug #70083]
 * Ensure that all timer events that are created are killed
 * Avoid trying to kill timer events that haven't ticked
 * as this seems to cause NT to hang
 *
 * Revision 1.1  1996/02/19  15:36:26  stephenb
 * new unit
 * This used to be called src/rts/src/OS/common/wintimer.c
 *
 * Revision 1.4  1996/02/14  10:53:41  jont
 * Add some type casts to achieve compilation under VC++ without warnings
 *
 * Revision 1.3  1996/01/18  12:56:34  stephenb
 * Add missing include file needed in order to get it to compile!
 *
 * Revision 1.2  1996/01/17  17:05:20  nickb
 * Add control-key handling here.
 *
 * Revision 1.1  1995/11/15  15:11:57  nickb
 * new unit
 * Timer facilities (for profiling and thread preemption).
 * */

#include "utils.h"
#include "types.h"
#include "diagnostic.h"
#include "native_threads.h"
#include "event.h"

#include <assert.h>

#include <windows.h>
#include <mmsystem.h>

static unsigned long int time_resolution;

static void get_min_period(void)
{
  TIMECAPS tc;
  MMRESULT result = timeGetDevCaps(&tc, sizeof(TIMECAPS));
  switch(result) {
  case TIMERR_NOERROR:
    DIAGNOSTIC(4,"time caps: %d min, %d max",tc.wPeriodMin,tc.wPeriodMax);
    break;
  case TIMERR_STRUCT:
    error("timeGetDevCaps() failed");
  default:
    error ("timeGetDevCaps() returned %d",result);
  }
  time_resolution = tc.wPeriodMin;
}

static void time_begin(void)
{
  MMRESULT result = timeBeginPeriod(time_resolution);
  switch(result) {
  case TIMERR_NOERROR:
    DIAGNOSTIC(4,"timeBeginPeriod(%d) succeeded",time_resolution,0);
    break;
  case TIMERR_NOCANDO:
    error("timeBeginPeriod() reports that %d resolution is not possible",
	  time_resolution);
  default:
    error("timeBeginPeriod() returned %d",result);
  }
}

extern void init_timer(void)
{
  get_min_period();
  time_begin();
}

MMRESULT timer_event;

static void CALLBACK time_callback(UINT id,
				   UINT msg,
				   DWORD arg,
				   DWORD dw1,
				   DWORD dw2)
{
  DIAGNOSTIC(4,"in timer callback, notifying timer thread",0,0);
  timer_event = (MMRESULT)NULL;
  notify_timer_thread();
}

extern void start_timer(unsigned int milliseconds)
{
/* would like to use TIME_CALLBACK_EVENT_SET here, but it doesn't work
 * on Win95 */
  int tries = 0;
  while (tries < 10) {
    timer_event = timeSetEvent(milliseconds,	/* how soon */
			       time_resolution,	/* with what resolution */
			       (LPTIMECALLBACK) time_callback,
			       0,			/* argument to time_callback */
			       TIME_ONESHOT);	/* not periodic */
    if (timer_event == (MMRESULT)NULL) {
      tries++;
      DIAGNOSTIC(1, "timeSetEvent() returned NULL at try %d", tries, 0);
    } else {
      DIAGNOSTIC(4,"set timer event id %d with delay of %dms",
		 timer_event,milliseconds);
      break;
    }
  }
  if (tries >= 10)
    error("timeSetEvent() returned NULL");
}

extern void stop_timer(void)
{
  if (timer_event) {
    timer_event = (MMRESULT)NULL;
  }
}

/* ctrl-c handling */

BOOL control_key_handler(DWORD ctrl_type)
{
  switch (ctrl_type) {

  case CTRL_C_EVENT:
    record_event(EV_INTERRUPT, (word) 0);
    return TRUE;

  case CTRL_BREAK_EVENT:
  case CTRL_CLOSE_EVENT:
  case CTRL_LOGOFF_EVENT:
  case CTRL_SHUTDOWN_EVENT:
    return FALSE;
  }

  assert(0);
  return FALSE;
}

extern int win32_set_ctrl_c_handler(void)
{
  BOOL result = SetConsoleCtrlHandler((PHANDLER_ROUTINE)control_key_handler,
				      TRUE);
  if (result == FALSE)
    return -1;
  else
    return 0;
}

extern int win32_clear_ctrl_c_handler(void)
{
  BOOL result = SetConsoleCtrlHandler((PHANDLER_ROUTINE)control_key_handler,
				      FALSE);
  if (result == FALSE)
    return -1;
  else
    return 0;
}
