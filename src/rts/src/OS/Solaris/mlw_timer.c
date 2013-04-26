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
 * The default Unix timer implementation (../Unix/mlw_timer.c) uses
 * getrusage which is only supported under Solaris as part of the BSD
 * compatability package which we (generally) don't want to rely on.
 * Although the SunOS (4.1.X) manual page lists times as being obsolete
 * this is the mechanism that is used under Solaris to get user and system
 * times!
 *
 * Note that Solaris does support a higher resolution timer than 
 * gettimeofday, called gethrtime, which could be used to provide more
 * accurate results for Timer.real_timer.  Hopefully this will be integrated
 * when there is time to overhaul the time implementation again.
 * 
 * Revision Log
 * ------------
 *
 * $Log: mlw_timer.c,v $
 * Revision 1.2  1998/02/23 18:44:36  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.1  1996/05/30  11:27:53  stephenb
 * new unit
 *
 */

#include <assert.h>		/* assert */
#include <sys/times.h>		/* times */
#include <unistd.h>		/* sysconf */
#include <errno.h>		/* errno */
#include <string.h>		/* strerror */
#include "environment.h"	/* env_function ... etc. */
#include "allocator.h"		/* allocate_record */
#include "gc.h"			/* gc_clock, declare_root, ... etc. */
#include "utils.h"		/* error */
#include "time_date.h"		/* mlw_time_make */
#include "mlw_timer.h"
#include "mlw_timer_init.h"


/*
 * Normally I'd just use CLK_TCK, but this is wrapped up in #ifdefs
 * in <limits.h> under Solaris to avoid it being seen because the value is 
 * is not fixed at compile time.  The correct way to determine the tick value 
 * is to use sysconf ...
 */
static int mlw_timer_tick; /* = sysconf(_SC_CLK_TCK) */




/*
 * Timer.now : unit -> cpu_timer
 *
 * This is an auxiliary function that it used to support the implementation
 * of Timer.startCPUTimer and Timer.checkCPUTimer.  It just returns the
 * current user, system and gc time.
 */

static mlval mlw_timer_now(mlval unit)
{
  mlval gc_time, usr_time, sys_time, cpu_time;

  assert(mlw_timer_tick > 0);

  {
    long gc_time_sec, gc_time_usec;
    gc_time_sec= gc_clock / 1000000.0;
    gc_time_usec= gc_clock - ((double)gc_time_sec * 1000000.0);
    gc_time= mlw_time_make(gc_time_sec, gc_time_usec);
    declare_root(&gc_time, 0);
  }

  {
    long secs, usecs;
    struct tms tms;
    (void)times(&tms);
    secs= tms.tms_utime/mlw_timer_tick;
    usecs= (tms.tms_utime%mlw_timer_tick)*mlw_time_usecs_per_sec/mlw_timer_tick;
    usr_time= mlw_time_make(secs, usecs);
    declare_root(&usr_time, 0);
    secs= tms.tms_stime/mlw_timer_tick;
    usecs= (tms.tms_stime%mlw_timer_tick)*mlw_time_usecs_per_sec/mlw_timer_tick;
    sys_time= mlw_time_make(secs, usecs);
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
  if ((mlw_timer_tick= sysconf(_SC_CLK_TCK)) < 0)
    error(" cannot determine CLK_TCK: %s\n", strerror(errno));
  env_function("Timer.now", mlw_timer_now);
}
