/* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 * The Win95 implementation of runtime routines to support the 
 * Timer structure as defined in the basis.  Since Win95 does not support
 * processes, the real time is returned instead of the user and system time
 * as is allowed by Implementation Note in the Timer basis section.
 *
 * $Log: mlw_timer.c,v $
 * Revision 1.3  1998/02/24 11:25:23  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.2  1997/05/21  13:56:07  johnh
 * [Bug #01702]
 * Added a call to mlw_raise_win32_syserr and mlw_win32_strerror
 * now lives in win32_error.h
 *
 * Revision 1.1  1996/06/17  14:01:42  stephenb
 * new unit
 *
 * Revision 1.3  1996/06/17  10:28:35  stephenb
 * Flesh out the mlw_timer_now stub.
 *
 * Revision 1.2  1996/06/12  09:38:45  stephenb
 * Update wrt changes in the time_date interface.
 *
 * Revision 1.1  1996/05/30  10:26:26  stephenb
 * new unit
 *
 */

#include <windows.h>
#include "environment.h"	/* env_function ... etc. */
#include "allocator.h"		/* allocate_record */
#include "gc.h"			/* gc_clock, declare_root, ... etc. */
#include "win32_error.h"        /* mlw_win32_strerror */
#include "time_date.h"		/* mlw_time_from_double, ... */
#include "mlw_timer.h"
#include "mlw_timer_init.h"



/*
 * Timer.now : unit -> cpu_timer
 *
 * This is an auxiliary function that it used to support the implementation
 * of Timer.startCPUTimer and Timer.checkCPUTimer.  It just returns the
 * current user, system and gc time.  As noted above, Win95 doesn't support
 * process timing, so the real time (to the nearest microsecond) is returned.
 * This should be replaced with an interface to a higher resolution timer
 * (if such an interface exists, didn't have enough time to look when
 * implementing this).
 *
 * Note that this raises OS.SysErr if the time cannot be determined.
 * This does not match the spec., but seems a reasonable thing to do.
 */

static mlval mlw_timer_now(mlval unit)
{
  mlval gc_time, usr_time, sys_time, cpu_time;

  gc_time= mlw_time_from_double(gc_clock/1000.0);
  declare_root(&gc_time, 0);

  {
    SYSTEMTIME system_time;
    FILETIME file_time;
    GetLocalTime(&system_time);
    if (SystemTimeToFileTime(&system_time, &file_time) == FALSE) {
      mlw_raise_win32_syserr(GetLastError());
    }
    usr_time= mlw_time_from_file_time(&file_time);
    declare_root(&usr_time, 0);
    sys_time= mlw_time_from_double(0.0);
    declare_root(&sys_time, 0);
  }

  cpu_time= mlw_timer_cpu_make();
  mlw_timer_cpu_usr(cpu_time)= usr_time;
  mlw_timer_cpu_sys(cpu_time)= sys_time;
  mlw_timer_cpu_gc(cpu_time)= gc_time;
  retract_root(&sys_time);
  retract_root(&usr_time);
  retract_root(&gc_time);
  return cpu_time;
}



void mlw_timer_init(void)
{
  env_function("Timer.now", mlw_timer_now);
}
