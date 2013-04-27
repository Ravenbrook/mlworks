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
 *  serious programming environment which is Windows). The portable
 *  interface lives here (in fact, the Unix version of things could be
 *  made to fit this interface).
 *  
 *  Revision Log
 *  ------------
 *  $Log: timer.h,v $
 *  Revision 1.1  1996/03/04 12:24:45  stephenb
 *  new unit
 *  This used to be called src/rts/src/OS/common/wintimer.h
 *
 * Revision 1.2  1996/01/17  17:05:32  nickb
 * Add control-key handling here.
 *
 * Revision 1.1  1995/11/15  15:12:24  nickb
 * new unit
 * Timer facilities (for profiling and thread preemption).
 *
 */

#ifndef _timer_h
#define _timer_h

extern void init_timer(void);
extern void start_timer(unsigned int milliseconds);
extern void stop_timer(void);

extern int win32_set_ctrl_c_handler(void);
extern int win32_clear_ctrl_c_handler(void);

#endif
