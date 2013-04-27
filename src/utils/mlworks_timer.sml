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

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
