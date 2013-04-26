(*  ==== INITIAL BASIS : TIMER ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
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
