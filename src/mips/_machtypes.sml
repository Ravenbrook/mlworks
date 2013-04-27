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

 based on Revision 1.30

 Revision Log
 ------------
 $Log: _machtypes.sml,v $
 Revision 1.16  1997/09/19 09:38:22  brucem
 [Bug #30153]
 Remove references to Old.

 * Revision 1.15  1997/01/13  16:18:49  matthew
 * Adding mult_result to registers
 *
 * Revision 1.14  1996/10/09  12:01:33  io
 * moving String from toplevel
 *
 * Revision 1.13  1996/05/01  11:58:38  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.12  1995/08/14  12:05:27  jont
 * Add bits_per_word
 * Remove smallest_int, largest_int, largest_word
 *
Revision 1.11  1995/07/25  15:45:36  jont
Add largest_word

Revision 1.10  1994/11/09  16:48:48  matthew
Changed fp_global to be R4

Revision 1.9  1994/10/24  17:14:31  matthew
Changed after_restore function to map callee closure to caller closure

Revision 1.8  1994/06/14  12:32:22  io
simplifying callee_arg and caller_arg

Revision 1.7  1994/05/06  10:34:43  io
added dummy_reg to identify ignored entries
in assembly format

Revision 1.6  1994/03/08  17:24:30  jont
Remove module type into separate file

Revision 1.5  1994/03/04  15:49:23  nickh
Improve code printing readability

Revision 1.4  1994/02/23  12:51:23  jont
Changes to machine register names

Revision 1.2  1993/11/16  16:58:56  io
Deleted old SPARC comments and fixed type errors

 *)

require "$.basis.__string";
require "../utils/crash";
require "machtypes";

functor MachTypes(
  structure Crash : CRASH
  ) : MACHTYPES =

struct
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

  val F0 = R0
  val F1 = R1
  val F2 = R2
  val F3 = R3
  val F4 = R4
  val F5 = R5
  val F6 = R6
  val F7 = R7
  val F8 = R8
  val F9 = R9
  val F10 = R10
  val F11 = R11
  val F12 = R12
  val F13 = R13
  val F14 = R14
  val F15 = R15
  val F16 = R16
  val F17 = R17
  val F18 = R18
  val F19 = R19
  val F20 = R20
  val F21 = R21
  val F22 = R22
  val F23 = R23
  val F24 = R24
  val F25 = R25
  val F26 = R26
  val F27 = R27
  val F28 = R28
  val F29 = R29
  val F30 = R30
  val F31 = R31

  fun next_reg R0 = R1
  | next_reg R1 = R2
  | next_reg R2 = R3
  | next_reg R3 = R4
  | next_reg R4 = R5
  | next_reg R5 = R6
  | next_reg R6 = R7
  | next_reg R7 = R8
  | next_reg R8 = R9
  | next_reg R9 = R10
  | next_reg R10 = R11
  | next_reg R11 = R12
  | next_reg R12 = R13
  | next_reg R13 = R14
  | next_reg R14 = R15
  | next_reg R15 = R16
  | next_reg R16 = R17
  | next_reg R17 = R18
  | next_reg R18 = R19
  | next_reg R19 = R20
  | next_reg R20 = R21
  | next_reg R21 = R22
  | next_reg R22 = R23
  | next_reg R23 = R24
  | next_reg R24 = R25
  | next_reg R25 = R26
  | next_reg R26 = R27
  | next_reg R27 = R28
  | next_reg R28 = R29
  | next_reg R29 = R30
  | next_reg R30 = R31
  | next_reg R31 = Crash.impossible"Next reg of register 31"
  | next_reg _ = Crash.impossible"next_reg dummy register"

  datatype fp_type = single | double | extended

  val fp_used = double

  fun reg_to_string R0 = "zero"
    | reg_to_string R1 = "global"
    | reg_to_string R2 = "alloc"
    | reg_to_string R3 = "limit"
    | reg_to_string R4 = "arg"
    | reg_to_string R5 = "caller"
    | reg_to_string R6 = "callee"
    | reg_to_string R7 = "slimit"
    | reg_to_string R8 = "hndlr"
    | reg_to_string R9 = "implicit"
    | reg_to_string R10 = "r10"
    | reg_to_string R11 = "r11"
    | reg_to_string R12 = "r12"
    | reg_to_string R13 = "r13"
    | reg_to_string R14 = "r14"
    | reg_to_string R15 = "r15"
    | reg_to_string R16 = "r16"
    | reg_to_string R17 = "r17"
    | reg_to_string R18 = "r18"
    | reg_to_string R19 = "r19"
    | reg_to_string R20 = "r20"
    | reg_to_string R21 = "r21"
    | reg_to_string R22 = "r22"
    | reg_to_string R23 = "r23"
    | reg_to_string R24 = "r24"
    | reg_to_string R25 = "r25"
    | reg_to_string R26 = "kern1"
    | reg_to_string R27 = "kern2"
    | reg_to_string R28 = "gp"
    | reg_to_string R29 = "sp"
    | reg_to_string R30 = "fp"
    | reg_to_string R31 = "lr"
    | reg_to_string cond = "the condition codes"
    | reg_to_string heap = "the heap"
    | reg_to_string stack = "the stack"
    | reg_to_string mult_result = "multiplier result registers"
    | reg_to_string nil_v = "the nil vector"
      
  fun fp_reg_to_string R0 = "f0"
    | fp_reg_to_string R1 = "f1"
    | fp_reg_to_string R2 = "f2"
    | fp_reg_to_string R3 = "f3"
    | fp_reg_to_string R4 = "f4"
    | fp_reg_to_string R5 = "f5"
    | fp_reg_to_string R6 = "f6"
    | fp_reg_to_string R7 = "f7"
    | fp_reg_to_string R8 = "f8"
    | fp_reg_to_string R9 = "f9"
    | fp_reg_to_string R10 = "f10"
    | fp_reg_to_string R11 = "f11"
    | fp_reg_to_string R12 = "f12"
    | fp_reg_to_string R13 = "f13"
    | fp_reg_to_string R14 = "f14"
    | fp_reg_to_string R15 = "f15"
    | fp_reg_to_string R16 = "f16"
    | fp_reg_to_string R17 = "f17"
    | fp_reg_to_string R18 = "f18"
    | fp_reg_to_string R19 = "f19"
    | fp_reg_to_string R20 = "f20"
    | fp_reg_to_string R21 = "f21"
    | fp_reg_to_string R22 = "f22"
    | fp_reg_to_string R23 = "f23"
    | fp_reg_to_string R24 = "f24"
    | fp_reg_to_string R25 = "f25"
    | fp_reg_to_string R26 = "f26"
    | fp_reg_to_string R27 = "f27"
    | fp_reg_to_string R28 = "f28"
    | fp_reg_to_string R29 = "f29"
    | fp_reg_to_string R30 = "f30"
    | fp_reg_to_string R31 = "f31"

    | fp_reg_to_string cond = "the condition codes"
    | fp_reg_to_string heap = "the heap"
    | fp_reg_to_string stack = "the stack"
    | fp_reg_to_string mult_result = "multiplier result registers"
    | fp_reg_to_string nil_v = "the nil vector"
   
  val zero_reg = R0
  val dummy_reg = R0
  val arg = R4
  val caller_closure = R5
  val callee_closure = R6
  val fp = R30
  val sp = R29
  val lr = R31
  val handler = R8
  val gc1 = R2
  val gc2 = R3
  val global = R1
  val fp_global = R4 (* An arbitrary choice *)
  val implicit = R9
  val stack_limit = R7
    
  exception OutOfScope of Mips_Reg
  
  fun after_preserve X = X

  fun after_restore R6 = R5
    | after_restore X = X

  val digits_in_real = 64
  val bits_per_word = 30

  exception Ord and Chr

  val ord = fn x => (ord (String.sub(x, 0))) handle ? => raise Ord
  val chr = fn x => String.str(chr x) handle ? => raise Chr
  exception NeedsPreserve

  fun check_reg R0 = ()
    | check_reg R1 = ()
    | check_reg R2 = ()
    | check_reg R3 = ()
    | check_reg R4 = ()
    | check_reg R5 = () (* raise NeedsPreserve *)
    | check_reg R6 = ()
    | check_reg R7 = ()
    | check_reg R8 = ()
    | check_reg R9 = ()
    | check_reg R10 = raise NeedsPreserve
    | check_reg R11 = raise NeedsPreserve
    | check_reg R12 = raise NeedsPreserve
    | check_reg R13 = raise NeedsPreserve
    | check_reg R14 = raise NeedsPreserve
    | check_reg R15 = raise NeedsPreserve
    | check_reg R16 = ()
    | check_reg R17 = ()
    | check_reg R18 = ()
    | check_reg R19 = ()
    | check_reg R20 = ()
    | check_reg R21 = ()
    | check_reg R22 = ()
    | check_reg R23 = ()
    | check_reg R24 = raise NeedsPreserve
    | check_reg R25 = raise NeedsPreserve
    | check_reg R26 = ()
    | check_reg R27 = ()
    | check_reg R28 = ()
    | check_reg R29 = ()
    | check_reg R30 = ()
    | check_reg R31 = ()
    | check_reg cond = Crash.impossible"check_reg: the condition codes"
    | check_reg heap = Crash.impossible"check_reg: the heap"
    | check_reg stack = Crash.impossible"check_reg: the stack"
    | check_reg mult_result = Crash.impossible"check_reg: mult_result"
    | check_reg nil_v = Crash.impossible"check_reg: the nil vector"
      
end
