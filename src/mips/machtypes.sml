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
 
 based on Revision 1.28
 
 Revsion Log
 -----------
 $Log: machtypes.sml,v $
 Revision 1.10  1997/01/13 12:01:27  matthew
 Adding mult_result to registers

 * Revision 1.9  1995/08/14  12:05:06  jont
 * Add bits_per_word
 * Remove smallest_int, largest_int, largest_word
 *
Revision 1.8  1995/07/25  15:45:14  jont
Add largest_word

Revision 1.7  1994/06/14  13:09:50  io
simplifying callee_arg and caller_arg

Revision 1.6  1994/05/06  10:34:21  io
added dummy_reg to identify ignored bits of tree

Revision 1.5  1994/03/08  18:00:51  jont
Remove module type into separate file

Revision 1.4  1994/02/22  12:47:45  jont
Put back consistent version

Revision 1.2  1993/11/17  14:11:11  io
Deleted old SPARC comments and fixed type errors

 *)
 
signature MACHTYPES = sig
  datatype Mips_Reg =
    R0 |
    R1 |
    R2 |
    R3 |
    R4 |
    R5 |
    R6 |
    R7 |
    R8 |
    R9 |
    R10 |
    R11 |
    R12 |
    R13 |
    R14 |
    R15 |
    R16 |
    R17 |
    R18 |
    R19 |
    R20 |
    R21 |
    R22 |
    R23 |
    R24 |
    R25 |
    R26 |
    R27 |
    R28 |
    R29 |
    R30 |
    R31 |
    cond |
    heap |
    stack |
    mult_result |
    nil_v

  val F0 : Mips_Reg
  val F1 : Mips_Reg
  val F2 : Mips_Reg
  val F3 : Mips_Reg
  val F4 : Mips_Reg
  val F5 : Mips_Reg
  val F6 : Mips_Reg
  val F7 : Mips_Reg
  val F8 : Mips_Reg
  val F9 : Mips_Reg
  val F10 : Mips_Reg
  val F11 : Mips_Reg
  val F12 : Mips_Reg
  val F13 : Mips_Reg
  val F14 : Mips_Reg
  val F15 : Mips_Reg
  val F16 : Mips_Reg
  val F17 : Mips_Reg
  val F18 : Mips_Reg
  val F19 : Mips_Reg
  val F20 : Mips_Reg
  val F21 : Mips_Reg
  val F22 : Mips_Reg
  val F23 : Mips_Reg
  val F24 : Mips_Reg
  val F25 : Mips_Reg
  val F26 : Mips_Reg
  val F27 : Mips_Reg
  val F28 : Mips_Reg
  val F29 : Mips_Reg
  val F30 : Mips_Reg
  val F31 : Mips_Reg

  val next_reg : Mips_Reg -> Mips_Reg

  datatype fp_type = single | double | extended

  val fp_used : fp_type

  val reg_to_string : Mips_Reg -> string
  val fp_reg_to_string : Mips_Reg -> string

  val digits_in_real : int
  val bits_per_word : int

  val zero_reg : Mips_Reg
  val dummy_reg: Mips_Reg
(*
  used when unnecessary filler arguments are needed
  for instance:
     bgtz reg offset
  needs to be stored as:
     bgtz reg reg offset
  thus, to make it more readable:
     bgtz reg dummy offset
*)

  val arg : Mips_Reg
  val caller_closure : Mips_Reg
  val callee_closure : Mips_Reg
  val fp : Mips_Reg
  val sp : Mips_Reg
  val lr : Mips_Reg
  val handler : Mips_Reg
  val global : Mips_Reg
  val fp_global : Mips_Reg
  val gc1 : Mips_Reg
  val gc2 : Mips_Reg
  val implicit : Mips_Reg
  val stack_limit : Mips_Reg
  exception OutOfScope of Mips_Reg
  val after_preserve : Mips_Reg -> Mips_Reg
  val after_restore : Mips_Reg -> Mips_Reg


  exception Ord
  exception Chr

  val ord: string -> int
  val chr: int -> string

  exception NeedsPreserve

  val check_reg : Mips_Reg -> unit
end
