(* i386types.sml the signature *)
(*
$Log: i386types.sml,v $
Revision 1.9  1997/05/14 19:41:59  jont
[Bug #30076]
Adding argument passing pseudo registers for multiple argument passing work.

 * Revision 1.8  1995/08/14  12:13:25  jont
 * Add bits_per_word
 * Remove smallest_int, largest_int, largest_word
 *
Revision 1.7  1995/07/25  15:58:15  jont
Add largest_word

Revision 1.6  1994/11/23  18:15:01  jont
Add full_reg_name function

Revision 1.5  1994/09/21  13:02:28  jont
Add word_reg_name function

Revision 1.4  1994/09/20  11:09:01  jont
Add register value function

Revision 1.3  1994/09/16  14:06:50  jont
Add conversion to byte registers function

Revision 1.2  1994/09/15  10:40:01  jont
Remove fp, we're not having an fp

Revision 1.1  1994/09/08  12:19:15  jont
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


signature I386TYPES = sig
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

  val byte_reg_name : I386_Reg -> I386_Reg
  val has_byte_name : I386_Reg -> bool

  val half_reg_name : I386_Reg -> I386_Reg

  val full_reg_name : I386_Reg -> I386_Reg

  val register_value : I386_Reg -> int

  datatype fp_type = single | double | extended

  val fp_used : fp_type

  val reg_to_string : I386_Reg -> string
  val fp_reg_to_string : I386_Reg -> string

  val digits_in_real : int
  val bits_per_word : int

  val caller_arg : I386_Reg
  val callee_arg : I386_Reg
  val caller_closure : I386_Reg
  val callee_closure : I386_Reg
  val sp : I386_Reg
  val global : I386_Reg
  val implicit : I386_Reg

  exception Ord
  exception Chr

  val ord: string -> int
  val chr: int -> string

end
