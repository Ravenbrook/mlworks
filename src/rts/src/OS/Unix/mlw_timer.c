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
 * The default Unix implementation of runtime routines to support the 
 * Timer structure as defined in the basis.
 *
 * The default uses getrusage to get the user and system times.  If this
 * is not available on a given Unix platform (it isn't on Solaris except
 * when using BSD compatability library), then create an OS specific version
 * in rts/OS/$(OS)/mlw_timer.c.  This will then override this version due
 * to the way .c files are found during the build.
 *
 * Revision Log
 * ------------
 *
 * $Log: mlw_timer.c,v $
 * Revision 1.2  1998/02/23 18:47:10  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.1  1996/05/30  09:25:17  stephenb
 * new unit
 *
 */

#include <sys/time.h>		/* struct timeval */
#include <sys/resource.h>	/* struct rusage */
#include "environment.h"	/* env_function ... etc. */
#include "allocator.h"		/* allocate_record */
#include "gc.h"			/* gc_clock, declare_root, ... etc. */
#include "time_date.h"		/* mlw_time_make */
#include "mlw_timer.h"
#include "mlw_timer_init.h"


/*
 * The following should be define in sys/resource.h or sys/time.h but
 * under SunOS it isn't in either.  So rather than set up a separate
 * header file just for this one declaration, it is included inline
 * here.
 */
extern int getrusage(int, struct rusage *);



/*
 * Timer.now : unit -> cpu_timer
 *
 * This is an auxiliary function that it used to support the implementation
 * of Timer.startCPUTimer and Timer.checkCPUTimer.  It just returns the
 * current user, system and gc time.
 */
/* Note that the return value of rusage is cast away since the ML
 * interface doesn't provide a way to singal an error back to the
 * user :-<
 * Could call error and abort MLWorks but that seems a bit drastic.
 */

static mlval mlw_timer_now(mlval unit)
{
  mlval gc_time, usr_time, sys_time, cpu_time;

  {
    long gc_time_sec, gc_time_usec;
    gc_time_sec= gc_clock / 1000000.0;
    gc_time_usec= gc_clock - ((double)gc_time_sec * 1000000.0);
    gc_time= mlw_time_make(gc_time_sec, gc_time_usec);
    declare_root(&gc_time, 0);
  }

  {
    struct rusage rusage;
    (void)getrusage(RUSAGE_SELF, &rusage);
    usr_time= mlw_time_make(rusage.ru_utime.tv_sec, rusage.ru_utime.tv_usec);
    declare_root(&usr_time, 0);
    sys_time= mlw_time_make(rusage.ru_stime.tv_sec, rusage.ru_stime.tv_usec);
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
