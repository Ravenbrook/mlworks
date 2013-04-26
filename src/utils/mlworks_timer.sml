(* mlworks_timer.sml the signature *)
(*
$Log: mlworks_timer.sml,v $
Revision 1.3  1998/02/06 15:43:06  johnh
Automatic checkin:
changed attribute _comment to '*'

 *  Revision 1.1.1.2  1997/11/25  20:11:45  daveb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 * Revision 1.2.11.1  1997/09/11  21:12:08  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.3  1997/11/13  11:22:42  jont
 * [Bug #30089]
 * Modify TIMER (from utils) to be INTERNAL_TIMER to keep bootstrap happy
 *
 * Revision 1.2  1992/08/07  15:11:11  davidt
 * Put a semicolon at the end of the file.
 *
Revision 1.1  1992/01/31  12:10:13  clive
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(* 
  Utilities for timing functions 
    xtime takes a flag that governs whether anything is printed, and terminates
      with a newline
    time_it simply prints statistics anyway without a newline at the end 
*)

signature INTERNAL_TIMER =
  sig
    val xtime : string * bool * (unit -> 'a)  -> 'a
    val time_it : string * (unit -> 'a)  -> 'a
  end;
