(* sparc_opcodes.sml the signature *)
(*
$Log: sparc_opcodes.sml,v $
Revision 1.1  1991/09/25 08:35:36  jont
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

require "machtypes";

signature SPARC_OPCODES = sig
  structure MachTypes : MACHTYPES
    
  exception not_done_yet

  datatype opcode =
    FORMAT1 of int (*disp30*)
  | FORMAT2A of MachTypes.Sparc_Reg (*rd*) * int (*op2*) * int (*imm22*)
  | FORMAT2B of bool (*a*) * int (*cond*) * int (*op2*) * int (*disp22*)
  | FORMAT3A of int (*op*) * MachTypes.Sparc_Reg (*rd*) * int (*op3*) *
    MachTypes.Sparc_Reg (*rs1*) * bool (*i*) * int (*asi*) *
    MachTypes.Sparc_Reg (*rs2*)
  | FORMAT3B of int (*op*) * MachTypes.Sparc_Reg (*rd*) * int (*op3*) *
    MachTypes.Sparc_Reg (*rs1*) * bool (*i*) * int (*simm13*)
  | FORMAT3C of int (*op*) * MachTypes.Sparc_Reg (*rd*) * int (*op3*) *
    MachTypes.Sparc_Reg (*rs1*) * int (*opf*) * MachTypes.Sparc_Reg (*rs2*)
  val output_opcode : opcode -> string
end
