(* 
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
 
 based on ???
 
 Revision Log
 ------------
 $Log: mips_schedule.sml,v $
 Revision 1.5  1997/05/06 09:45:37  jont
 [Bug #30088]
 Get rid of MLWorks.Option

 * Revision 1.4  1997/01/24  14:46:17  matthew
 * Adding CompilerOptions parameter
 *
 * Revision 1.3  1995/12/22  13:20:51  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.2  1993/11/17  14:13:46  io
Deleted old SPARC comments and fixed type errors

 *)
 
require "mips_assembly";

signature MIPS_SCHEDULE = sig
  structure Mips_Assembly : MIPS_ASSEMBLY

  val reschedule_proc :
    bool ->
    (Mips_Assembly.MirTypes.tag *
     (Mips_Assembly.MirTypes.tag *
      (Mips_Assembly.opcode * Mips_Assembly.MirTypes.tag option * string) list) list)
    ->
    (Mips_Assembly.MirTypes.tag *
     (Mips_Assembly.MirTypes.tag *
      (Mips_Assembly.opcode * Mips_Assembly.MirTypes.tag option * string) list) list)
    (* Inter block rescheduling to move instructions back from destination *)
    (* blocks into delay slots for conditional branches where possible *)

end
