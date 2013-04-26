(*  ==== BASIS EXAMPLES : Clock structure ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module provides functions to clock the progress of the current
 *  process.  It demonstrates both the Timer and the Time structures in the
 *  basis library.
 *
 *  Revision Log
 *  ------------
 *  $Log: __clock.sml,v $
 *  Revision 1.3  1997/09/12 14:46:56  brucem
 *  [Bug #50002]
 *  Added exception handler to prevent failure when run as delivered application.
 *  Also added explanatory note.
 *
 *  Revision 1.2  1996/09/04  11:52:55  jont
 *  Make require statements absolute
 *
 *  Revision 1.1  1996/08/09  18:06:49  davids
 *  new unit
 *
 *
 *)


require "clock";
require "$.basis.__timer";
require "$.system.__time";
require "$.basis.__real";
require "$.basis.__string_cvt";

structure Clock : CLOCK =
  struct

    (* Create a CPU timer to keep track of how much user time has elapsed. *)

    val cpuClock = ref (Timer.startCPUTimer ())


    (* Create a wall clock timer to keep track of how much real time has
     elapsed. *)

    val wallClock = ref (Timer.startRealTimer ())


    (* Restart both the CPU timer and the wall clock timer. *)

    fun reset () =
      (cpuClock := Timer.startCPUTimer ();
       wallClock := Timer.startRealTimer ())

    (* Print the time elapsed on both the wall clock and the CPU timer.
     Calculate and print the percentage of time spent on the current
     process. *)

    (* Timer.checkCPUTimer may fail if you deliver the clock function.
       This is because starting a delivered application creates a new
       process, for which any old timers stored in wallClock and cpuClock
       are invalid.  This is why we wrap an exception handler around
       Timer.checkCPUTimer. *)

    fun clock () =
      let
	val wallTime = Timer.checkRealTimer (!wallClock)
	val userTimeOpt = SOME (#usr (Timer.checkCPUTimer (!cpuClock)))
                          handle Time.Time => NONE
	val percentage = case userTimeOpt of
                           SOME userTime =>
                             (Time.toReal userTime) / 
	                     (Time.toReal wallTime) * 100.0
                         | NONE => 100.0 (* arbitrary, won't be used. *)
      in
        case userTimeOpt of
          SOME userTime =>
            print ("Overall time passed: " ^
                    Time.fmt 1 wallTime ^ 
                    " seconds\n" ^ 
                    "Process has had CPU for: " ^ 
                    Time.fmt 1 userTime ^
                    " seconds\n" ^ 
                    "Time spent on this process is " ^
                    Real.fmt (StringCvt.FIX (SOME 1)) percentage ^
                    "%\n")
        | NONE =>
            print "Can't get user time, timers may have been invalidated.\n"
      end

  end

	
	
