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
 $Log: mips_opcodes.sml,v $
 Revision 1.3  1994/03/08 13:58:03  jont
 Add OFFSET type for straight integers

Revision 1.2  1993/11/17  14:12:51  io
Deleted old SPARC comments and fixed type errors

 *)

require "machtypes";

signature MIPS_OPCODES = sig
  structure MachTypes : MACHTYPES
    
  exception not_done_yet

  datatype opcode =
    FORMATI of int (*op*) * MachTypes.Mips_Reg (*rs*) * MachTypes.Mips_Reg (*rt*) * 
    int (*imm16*)
  | FORMATI2 of int (*op*) * int (*rs*) * int (*rt*) * int (*imm16*)
  | FORMATJ of int (*op*) * int (*target26*)
  | FORMATR of int (*op*) * MachTypes.Mips_Reg (*rs*) * MachTypes.Mips_Reg (*rt*) * 
    MachTypes.Mips_Reg (*rd*) * int (*shamt*) * int (*funct*)
  | FORMATR2 of int * int * int * int * int * int
  | OFFSET of int

  val register_val : MachTypes.Mips_Reg -> int;
  val output_opcode : opcode -> string
end
