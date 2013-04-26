/*  ==== TIMER INTERFACE FOR WIN32 ====
 *
 *  Copyright (C) 1995 Harlequin Ltd
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
