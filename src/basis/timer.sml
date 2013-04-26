(*  ==== INITIAL BASIS : TIMER ====
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
 *  This is part of the extended Initial Basis.
 *
 *  $Log: timer.sml,v $
 *  Revision 1.6  1999/05/12 11:00:34  daveb
 *  [Bug #190554]
 *  Separated out GC timers.
 *
 * Revision 1.5  1997/11/18  17:07:45  jont
 * [Bug #30085]
 * Add totalCPUTimer and totalRealTimer
 *
 * Revision 1.4  1996/05/29  15:13:43  stephenb
 * Make the signature match that defined in the March 1996 basis definition.
 *
 * Revision 1.3  1996/05/17  11:49:40  jont
 * Remove totalCPUTime and totalRealTime from interface
 *
 * Revision 1.2  1996/05/01  15:24:28  stephenb
 * Update wrt change in Time implementation.
 *
 * Revision 1.1  1996/04/18  11:46:20  jont
 * new unit
 *
 *  Revision 1.1  1995/04/13  14:15:50  jont
 *  new unit
 *  No reason given
 *
 *
 *)


require "^.system.__time";

signature TIMER =
  sig
    type cpu_timer
    type real_timer

    val startCPUTimer : unit -> cpu_timer
    val totalCPUTimer : unit -> cpu_timer
    val checkCPUTimer : cpu_timer -> {usr:Time.time, sys:Time.time}
    val checkGCTime : cpu_timer -> Time.time

    val startRealTimer : unit -> real_timer
    val totalRealTimer : unit -> real_timer
    val checkRealTimer : real_timer -> Time.time

  end
