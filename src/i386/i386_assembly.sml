(* i386_assembly.sml the signature *)
(*
$Log: i386_assembly.sml,v $
Revision 1.14  1998/06/29 13:17:21  jont
[Bug #20117]
Add align directive for benefit of jump tables

 * Revision 1.13  1997/05/06  10:02:48  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.12  1996/11/06  10:53:26  andreww
 * [Bug #1734]
 * Changing type Backend_Annotation to eqtype Backend_Annotation.
 *
 * Revision 1.11  1996/10/28  15:21:51  andreww
 * [Bug #1707]
 * threading debugger information.
 *
 * Revision 1.10  1996/04/04  13:03:40  jont
 * Allow offsets in mem_operands to be bigger than an int, to cope with words
 *
 * Revision 1.9  1995/12/20  14:14:31  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.8  1994/12/09  13:27:56  matthew
Added fnclex

Revision 1.7  1994/12/08  11:06:07  matthew
Added FP opcodes

Revision 1.6  1994/11/15  15:28:08  jont
Add fixed length rel32 type for use in switches

Revision 1.5  1994/09/20  14:48:49  jont
Get type of reverse_branch right

Revision 1.4  1994/09/19  13:46:52  jont
Add print_mnemonic function

Revision 1.3  1994/09/16  12:34:09  jont
Change 32 bit immediates to be pairs to get full range

Revision 1.2  1994/09/15  15:52:49  jont
Make option an eqtype

Revision 1.1  1994/09/08  16:29:36  jont
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

require "i386_opcodes";

signature I386_ASSEMBLY = sig
  structure I386_Opcodes : I386_OPCODES

  type ''a Set

  type tag (* MirTypes.tag *)
  eqtype Backend_Annotation (* MirTypes.Debugger_Types.Backend_Annotation *)

  datatype ('a, 'b)union = INL of 'a | INR of 'b

  datatype cc =
    above
  | above_or_equal
  | below
  | below_or_equal
  | cx_equal_zero
  | ecx_equal_zero
  | equal
  | greater
  | greater_or_equal
  | less
  | less_or_equal
  | not_equal
  | not_overflow
  | not_parity
  | not_sign
  | overflow
  | parity
  | sign

  datatype mnemonic =
    aaa
  | aad
  | aam
  | aas
  | adc
  | add
  | align
  | and_op
  | arpl
  | bound
  | bsf
  | bsr
  | bt
  | btc
  | btr
  | bts
  | call
  | cbw
  | cwde
  | clc
  | cld
  | cli
  | clts
  | cmc
  | cmp
  | cmps
  | cmpsb
  | cmpsw
  | cmpsd
  | cwd
  | cdq
  | daa
  | das
  | dec
  | div_op
  | enter
  (* Floating point *)
  | fld
  | fst
  | fstp
  | fild
  | fist
  | fistp
  (* Binary ops *)
  | fadd
  | fsub
  | fsubr
  | fmul
  | fdiv
  | fdivr
  (* Unary ops *)
  | fabs
  | fpatan
  | fchs
  | fcos
  | fsin
  | fsqrt
  | fptan
  | fldz
  | fld1
  | fyl2x
  | fyl2xp
  | f2xm1
  (* Comparisons & tests *)
  (* No integer comparisons for the moment *)
  | fcom
  | fcomp
  | fcompp
  | fucom
  | fucomp
  | fucompp
  | ftst
  | fxam
  (* Control *)
  | fldcw
  | fstcw 
  | fnstcw
  | fstsw
  | fstsw_ax
  | fnstsw
  | fnclex
  (* End floating point *)
  | hlt
  | idiv
  | imul
  | in_op
  | inc
  | ins
  | insb
  | insw
  | insd
  | int
  | into
  | iret
  | iretd
  | jcc of cc
  | jmp
  | lahf
  | lar
  | lea
  | leave
  | lgdt
  | lidt
  | lgs
  | lss
  | lds
  | les
  | lfs
  | lldt
  | lmsw
  | lock
  | lods
  | lodsb
  | lodsw
  | lodsd
  | loop
  | loopz
  | loopnz
  | lsl
  | ltr
  | mov
  | movs
  | movsb
  | movsw
  | movsd
  | movsx
  | movzx
  | mul
  | neg
  | nop
  | not
  | or
  | out
  | outs
  | outsb
  | outsw
  | outsd
  | pop
  | popa
  | popad
  | popf
  | popfd
  | push
  | pusha
  | pushad
  | pushf
  | pushfd
  | rcl
  | rcr
  | rol
  | ror
  | rep
  | repz
  | repnz
  | ret
  | sahf
  | sal
  | sar
  | shl
  | shr
  | sbb
  | scas
  | scasb
  | scasw
  | scasd
  | setcc of cc
  | sgdt
  | sidt
  | shld
  | shrd
  | sldt
  | smsw
  | stc
  | std
  | sti
  | stos
  | stosb
  | stosw
  | stosd
  | str
  | sub
  | test
  | verr
  | verw
  | wait
  | xchg
  | xlat
  | xlatb
  | xor

  datatype offset_operand =
    SMALL of int
  | LARGE of int * int

  datatype mem_operand =
    MEM of {base: I386_Opcodes.I386Types.I386_Reg option,
	    index: (I386_Opcodes.I386Types.I386_Reg * int option) option,
	    offset: offset_operand option}
	    
  (* Note, the 32 bit quantities may need to be made larger (ie more than one int) *)

  datatype adr_mode =
    rel8 of int
  | rel16 of int
  | rel32 of int
  | fix_rel32 of int
  | ptr16_16 of int * int
  | ptr16_32 of int * int
  | r8 of I386_Opcodes.I386Types.I386_Reg
  | r16 of I386_Opcodes.I386Types.I386_Reg
  | r32 of I386_Opcodes.I386Types.I386_Reg
  | imm8 of int
  | imm16 of int
  | imm32 of (int * int)
  | r_m8 of (I386_Opcodes.I386Types.I386_Reg, mem_operand) union
  | r_m16 of (I386_Opcodes.I386Types.I386_Reg, mem_operand) union
  | r_m32 of (I386_Opcodes.I386Types.I386_Reg, mem_operand) union
  | m8 of mem_operand
  | m16 of mem_operand
  | m32 of mem_operand
  | fp_mem of mem_operand
  | fp_reg of int
(* I don't think we will want these, so I've left them out for the present
  | m16_16
  | m16_32
  | m16_m16
  | m16_m32
  | m32_m32
  | moffs8
  | moffs16
  | moffs32
  | sreg
*)

  datatype opcode =
    OPCODE of mnemonic * (adr_mode list)
   | AugOPCODE of opcode * Backend_Annotation


  val check: opcode -> unit (* Test a proposed opcode for validity *)

  val assemble : opcode -> I386_Opcodes.opcode

  val opcode_size : opcode -> int

  type LabMap

  val make_labmap : opcode list list list -> LabMap

  val print_mnemonic : mnemonic -> string
  val print : opcode -> string
  val labprint : opcode * int * LabMap -> string * string
  val reverse_branch : mnemonic -> mnemonic
  (* Produce rel' where a rel b == b rel' a *)

  val inverse_branch : mnemonic -> mnemonic
  (* Produce rel' where a rel b == not(a rel' b) *)

  val defines_and_uses :
    opcode ->
    I386_Opcodes.I386Types.I386_Reg Set * I386_Opcodes.I386Types.I386_Reg Set *
    I386_Opcodes.I386Types.I386_Reg Set * I386_Opcodes.I386Types.I386_Reg Set
  val nop_code : opcode
  val other_nop_code : opcode
  val no_op : opcode * tag option * string
end
