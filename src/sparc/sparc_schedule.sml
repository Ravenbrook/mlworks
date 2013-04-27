(* sparc_schedule.sml the signature *)
(*
$Log: sparc_schedule.sml,v $
Revision 1.9  1997/05/02 16:32:31  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.8  1997/01/31  10:48:50  matthew
 * Adding static flag to scheduler
 *
 * Revision 1.7  1995/12/22  13:03:02  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.6  1993/08/24  11:53:28  jont
Changed $Log to $Log: sparc_schedule.sml,v $
Changed $Log to Revision 1.9  1997/05/02 16:32:31  jont
Changed $Log to [Bug #30088]
Changed $Log to Get rid of MLWorks.Option
Changed $Log to
 * Revision 1.8  1997/01/31  10:48:50  matthew
 * Adding static flag to scheduler
 *
 * Revision 1.7  1995/12/22  13:03:02  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 * to get the change log

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

require "sparc_assembly";

signature SPARC_SCHEDULE = sig
  structure Sparc_Assembly : SPARC_ASSEMBLY

  val reschedule_block :
    bool *
    (Sparc_Assembly.opcode * Sparc_Assembly.MirTypes.tag option * string) list ->
    (Sparc_Assembly.opcode * Sparc_Assembly.MirTypes.tag option * string) list
    (* Internal block rescheduling to move instructions forward into *)
    (* delay slots where possible *)

  val reschedule_proc :
    (Sparc_Assembly.MirTypes.tag *
     (Sparc_Assembly.MirTypes.tag *
      (Sparc_Assembly.opcode * Sparc_Assembly.MirTypes.tag option * string) list) list)
    ->
    (Sparc_Assembly.MirTypes.tag *
     (Sparc_Assembly.MirTypes.tag *
      (Sparc_Assembly.opcode * Sparc_Assembly.MirTypes.tag option * string) list) list)
    (* Inter block rescheduling to move instructions back from destination *)
    (* blocks into delay slots for conditional branches where possible *)

end
