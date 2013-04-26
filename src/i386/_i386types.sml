(* _i386types.sml the functor *)
(*
$Log: _i386types.sml,v $
Revision 1.16  1998/06/16 13:09:02  jont
[Bug #70137]
Modify print to produce gas format

 * Revision 1.15  1997/09/19  09:25:23  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.14  1997/05/14  19:44:14  jont
 * [Bug #30076]
 * Adding argument passing pseudo registers for multiple argument passing work.
 *
 * Revision 1.13  1996/10/09  11:55:39  io
 * moving String from toplevel
 *
 * Revision 1.12  1996/05/01  12:35:48  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.11  1996/04/03  16:02:52  jont
 * Give type of register value (cond, heap, stack, nil_v) which fails register_value
 *
 * Revision 1.10  1995/08/14  12:14:25  jont
 * Add bits_per_word
 * Remove smallest_int, largest_int, largest_word
 *
Revision 1.8  1995/07/25  15:59:06  jont
Add largest_word

Revision 1.7  1994/11/24  11:56:05  jont
Add full_reg_name function

Revision 1.6  1994/11/18  15:11:06  jont
Modify to new register assignment

Revision 1.5  1994/09/21  13:14:52  jont
Add word_reg_name function

Revision 1.4  1994/09/20  11:11:23  jont
Add register value function

Revision 1.3  1994/09/16  14:11:29  jont
Add conversion to byte registers function

Revision 1.2  1994/09/15  11:07:22  jont
Remove fp, we're not having an fp

Revision 1.1  1994/09/09  15:57:02  jont
new file

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

require "$.basis.__string";
require "../utils/crash";
require "i386types";

functor I386Types(
  structure Crash : CRASH
  ) : I386TYPES =

struct
  datatype I386_Reg =
    EAX |
    EBX |
    ECX |
    EDX |
    ESP |
    EBP |
    EDI |
    ESI |
    AX |
    BX |
    CX |
    DX |
    SP |
    BP |
    DI |
    SI |
    AH |
    AL |
    BH |
    BL |
    CH |
    CL |
    DH |
    DL |
    cond |
    heap |
    stack |
    nil_v |
    i_arg1 |
    i_arg2 |
    i_arg3 |
    i_arg4 |
    i_arg5 |
    i_arg6 |
    i_arg7 |
    o_arg1 |
    o_arg2 |
    o_arg3 |
    o_arg4 |
    o_arg5 |
    o_arg6 |
    o_arg7

  fun register_value EAX = 0
    | register_value EBX = 3
    | register_value ECX = 1
    | register_value EDX = 2
    | register_value ESP = 4
    | register_value EBP = 5
    | register_value EDI = 7
    | register_value ESI = 6
    | register_value AX = 0
    | register_value BX = 3
    | register_value CX = 1
    | register_value DX = 2
    | register_value SP = 4
    | register_value BP = 5
    | register_value DI = 7
    | register_value SI = 6
    | register_value AH = 4
    | register_value AL = 0
    | register_value BH = 7
    | register_value BL = 3
    | register_value CH = 5
    | register_value CL = 1
    | register_value DH = 6
    | register_value DL = 2
    | register_value cond = Crash.impossible"register_value:not register (cond)"
    | register_value heap = Crash.impossible"register_value:not register (heap)"
    | register_value stack = Crash.impossible"register_value:not register (stack)"
    | register_value nil_v = Crash.impossible"register_value:not register (nil_v)"
    | register_value i_arg1 = Crash.impossible"register value:not register (i_arg1)"
    | register_value i_arg2 = Crash.impossible"register value:not register (i_arg2)"
    | register_value i_arg3 = Crash.impossible"register value:not register (i_arg3)"
    | register_value i_arg4 = Crash.impossible"register value:not register (i_arg4)"
    | register_value i_arg5 = Crash.impossible"register value:not register (i_arg5)"
    | register_value i_arg6 = Crash.impossible"register value:not register (i_arg6)"
    | register_value i_arg7 = Crash.impossible"register value:not register (i_arg7)"
    | register_value o_arg1 = Crash.impossible"register value:not register (o_arg1)"
    | register_value o_arg2 = Crash.impossible"register value:not register (o_arg2)"
    | register_value o_arg3 = Crash.impossible"register value:not register (o_arg3)"
    | register_value o_arg4 = Crash.impossible"register value:not register (o_arg4)"
    | register_value o_arg5 = Crash.impossible"register value:not register (o_arg5)"
    | register_value o_arg6 = Crash.impossible"register value:not register (o_arg6)"
    | register_value o_arg7 = Crash.impossible"register value:not register (o_arg7)"

  fun byte_reg_name EAX = AL
    | byte_reg_name EBX = BL
    | byte_reg_name ECX = CL
    | byte_reg_name EDX = DL
    | byte_reg_name _ = Crash.impossible"byte_reg_name: bad argument"

  fun has_byte_name EAX = true
    | has_byte_name EBX = true
    | has_byte_name ECX = true
    | has_byte_name EDX = true
    | has_byte_name _ = false

  fun half_reg_name EAX = AX
    | half_reg_name EBX = BX
    | half_reg_name ECX = CX
    | half_reg_name EDX = DX
    | half_reg_name ESP = SP
    | half_reg_name EBP = BP
    | half_reg_name EDI = DI
    | half_reg_name ESI = SI
    | half_reg_name _ = Crash.impossible"half_reg_name: bad argument"

  fun full_reg_name EAX = EAX
    | full_reg_name EBX = EBX
    | full_reg_name ECX = ECX
    | full_reg_name EDX = EDX
    | full_reg_name ESP = ESP
    | full_reg_name EBP = EBP
    | full_reg_name EDI = EDI
    | full_reg_name ESI = ESI
    | full_reg_name AX = EAX
    | full_reg_name BX = EBX
    | full_reg_name CX = ECX
    | full_reg_name DX = EDI
    | full_reg_name SP = ESP
    | full_reg_name BP = EBP
    | full_reg_name DI = EDI
    | full_reg_name SI = ESI
    | full_reg_name AH = EAX
    | full_reg_name AL = EAX
    | full_reg_name BH = EBX
    | full_reg_name BL = EBX
    | full_reg_name CH = ECX
    | full_reg_name CL = ECX
    | full_reg_name DH = EDX
    | full_reg_name DL = EDX
    | full_reg_name _ = Crash.impossible"full_reg_name:not register"

  datatype fp_type = single | double | extended

  val fp_used = double

  fun reg_to_string EAX = "%eax"
    | reg_to_string EBX = "%ebx"
    | reg_to_string ECX = "%ecx"
    | reg_to_string EDX = "%edx"
    | reg_to_string ESP = "%esp"
    | reg_to_string EBP = "%ebp"
    | reg_to_string EDI = "%edi"
    | reg_to_string ESI = "%esi"
    | reg_to_string AX = "%ax"
    | reg_to_string BX = "%bx"
    | reg_to_string CX = "%cx"
    | reg_to_string DX = "%dx"
    | reg_to_string SP = "%sp"
    | reg_to_string BP = "%bp"
    | reg_to_string DI = "%di"
    | reg_to_string SI = "%si"
    | reg_to_string AH = "%ah"
    | reg_to_string AL = "%al"
    | reg_to_string BH = "%bh"
    | reg_to_string BL = "%bl"
    | reg_to_string CH = "%ch"
    | reg_to_string CL = "%cl"
    | reg_to_string DH = "%dh"
    | reg_to_string DL = "%dl"
    | reg_to_string cond = "cond"
    | reg_to_string heap = "heap"
    | reg_to_string stack = "stack"
    | reg_to_string nil_v = "nil_v"
    | reg_to_string i_arg1 = "i_arg1"
    | reg_to_string i_arg2 = "i_arg2"
    | reg_to_string i_arg3 = "i_arg3"
    | reg_to_string i_arg4 = "i_arg4"
    | reg_to_string i_arg5 = "i_arg5"
    | reg_to_string i_arg6 = "i_arg6"
    | reg_to_string i_arg7 = "i_arg7"
    | reg_to_string o_arg1 = "o_arg1"
    | reg_to_string o_arg2 = "o_arg2"
    | reg_to_string o_arg3 = "o_arg3"
    | reg_to_string o_arg4 = "o_arg4"
    | reg_to_string o_arg5 = "o_arg5"
    | reg_to_string o_arg6 = "o_arg6"
    | reg_to_string o_arg7 = "o_arg7"

  fun fp_reg_to_string _ = Crash.unimplemented"fp_reg_to_string"
      
  val caller_arg = EBX
  val callee_arg = EBX
  val caller_closure = EBP
  val callee_closure = EDI
  val sp = ESP
  val global = ECX
  val implicit = ESI

  val digits_in_real = 64
  val bits_per_word = 30

  exception Ord and Chr

  val ord = fn x=>(ord (String.sub(x, 0))) handle ? => raise Ord
  val chr = fn x=>String.str(chr x) handle ? => raise Chr

end
