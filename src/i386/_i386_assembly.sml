(* _i386_assembly.sml the functor *)
(*
$Log: _i386_assembly.sml,v $
Revision 1.38  1998/08/07 13:03:50  jont
[Bug #70150]
Modify printing of shifts and rotates by 1 to omit the $1

 * Revision 1.37  1998/07/10  15:19:15  jont
 * [Bug #20127]
 * Make sure all shifts are word sized
 *
 * Revision 1.36  1998/07/10  08:53:25  jont
 * [Bug #20126]
 * Fix loop when index = base = ebp
 *
 * Revision 1.35  1998/07/03  12:27:44  jont
 * [Bug #20121]
 * Swap ebp base register when possible
 *
 * Revision 1.34  1998/06/29  14:34:56  jont
 * [Bug #20117]
 * Add align directive for benefit of jump tables
 *
 * Revision 1.33  1998/06/22  09:28:59  jont
 * [Bug #70137]
 * Make sure modified Int structure doesn't survive at top level
 * in bootstrap process.
 *
 * Revision 1.32  1998/06/18  16:56:58  jont
 * [Bug #70140]
 * Modify imm32 printing to ensure that all digits are printed
 * and that large negative numbers work
 *
 * Revision 1.31  1998/06/17  13:00:16  jont
 * [Bug #70137]
 * Modify print to produce gas format
 *
 * Revision 1.30  1997/09/19  09:18:01  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.29  1997/05/06  10:04:58  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.28  1996/11/06  11:12:05  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.27  1996/11/01  16:13:45  andreww
 * [Bug #1707]
 * Threading debug information through opcodes.
 *
 * Revision 1.26  1996/10/31  14:37:24  io
 * moving String from toplevel
 *
 * Revision 1.25  1996/05/01  12:42:33  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.24  1996/04/30  13:16:25  matthew
 * Replacing uses of MLWorks.Integer
 *
 * Revision 1.23  1996/04/04  13:08:48  jont
 * Allow offsets in mem_operands to be bigger than an int, to cope with words
 *
 * Revision 1.22  1995/12/20  14:15:59  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.21  1995/06/21  09:05:17  jont
Add defines_and_uses for imul
Fix bugs in code generation and size calculation for imul

Revision 1.20  1995/06/12  13:52:57  jont
Allow wait in defines_and_uses
Also sahf. Both are used by the floating point system

Revision 1.19  1995/02/15  17:32:32  jont
Produce a proper opcode_size function

Revision 1.18  1995/02/08  14:21:09  jont
Add defines and uses

Revision 1.17  1994/12/09  13:31:27  matthew
Added fnclex

Revision 1.16  1994/12/08  15:10:10  matthew
Lifting uses of B function.

Revision 1.15  1994/12/08  11:08:05  matthew
Added FP opcodes

Revision 1.14  1994/11/22  16:04:52  jont
moddify assemble_add_type to take advantage of special forms for AL, AX, EAX

Revision 1.13  1994/11/15  15:33:29  jont
Add fixed length rel32 type for use in switches

Revision 1.12  1994/11/08  14:25:00  jont
Sort out problems with EBP as base in SIB stuff

Revision 1.11  1994/10/26  18:22:51  jont
Remove debugging print statements

Revision 1.10  1994/10/19  09:45:15  jont
Fix label calculation

Revision 1.9  1994/10/14  10:01:44  jont
Change other_nop_code to be different from nop

Revision 1.8  1994/10/12  11:13:10  jont
Also fix encodings of sib

Revision 1.7  1994/10/04  14:33:22  jont
Fix reverse_branch
Fix minor problem in encodings

Revision 1.6  1994/09/26  11:02:41  jont
Get printing of loop opcodes correct

Revision 1.5  1994/09/21  14:25:39  jont
Move register value stuff into I386types
Modification for some erroneous encodings

Revision 1.4  1994/09/19  15:58:25  jont
Add print_mnemonic function
Implement printing of relative values as labels
Improve printing of immediate 32 bit values

Revision 1.3  1994/09/16  16:24:28  jont
Change 32 bit immediates to be pairs to get full range
Improve printed output
Ensure no negative immediates generated
Print actual binary generated
Full printing of r/m stuff

Revision 1.2  1994/09/09  14:44:31  jont
Add assembly language printing

Revision 1.1  1994/09/08  16:30:01  jont
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

require "../basis/__int";
require "../basis/__string";

require "../utils/crash";
require "../utils/lists";
require "../utils/intnewmap";
require "../mir/mirtypes";
require "i386_opcodes";
require "i386_assembly";
require "^.basis.__string_cvt";

functor I386_Assembly(
  structure Crash : CRASH
  structure Lists : LISTS
  structure Map : INTNEWMAP
  structure MirTypes : MIRTYPES
  structure I386_Opcodes : I386_OPCODES
  ) : I386_ASSEMBLY =
struct
  structure MirTypes = MirTypes
  structure Set = MirTypes.Set
  structure I386_Opcodes = I386_Opcodes
  structure I386Types = I386_Opcodes.I386Types
  structure Debugger_Types = MirTypes.Debugger_Types

  structure Int =
    struct
      fun toString x =
	let
	  val str = Int.toString x
	  val first = String.sub(str, 0)
	in
	  if first = #"~" then
	    "-" ^ String.substring(str, 1, size str - 1)
	  else
	    str
	end
    end

  type ''a Set = ''a Set.Set

  type tag = MirTypes.tag
  type Backend_Annotation = Debugger_Types.Backend_Annotation

  type LabMap = string Map.T

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
   | AugOPCODE of opcode * Debugger_Types.Backend_Annotation

  (* An opcode specification is a mnemonic *)
  (* Together with a list of operands *)
  (* For an opcode like CMC, this list is nil, as CMC has no operands *)
  (* For a call, the list has one element, since call takes one operand *)

  (* an Augmented Opcode is just an opcode with extra debug information
     attached. Note that the following functions universally ignore
     the extra debug information.  This constructor is included here
     simply to avoid defining another datatype "opcode or augmented
     opcode" in _i386_cg.sml.  Note that even though there is a
     theoretical possibility of nested AugOPCODEs, this will never occur
     in _i386_cg.sml. *)

  fun decode_cc above = "a"
    | decode_cc(above_or_equal) = "ae"
    | decode_cc(below) = "b"
    | decode_cc(below_or_equal) = "be"
    | decode_cc(cx_equal_zero) = "cxz"
    | decode_cc(ecx_equal_zero) = "ecxz"
    | decode_cc(equal) = "e"
    | decode_cc(greater) = "g"
    | decode_cc(greater_or_equal) = "ge"
    | decode_cc(less) = "l"
    | decode_cc(less_or_equal) = "le"
    | decode_cc(not_equal) = "ne"
    | decode_cc(not_overflow) = "no"
    | decode_cc(not_parity) = "np"
    | decode_cc(not_sign) = "ns"
    | decode_cc(overflow) = "o"
    | decode_cc(parity) = "p"
    | decode_cc(sign) = "s"

  fun decode_mnemonic aaa = "aaa"
    | decode_mnemonic aad = "aad"
    | decode_mnemonic aam = "aam"
    | decode_mnemonic aas = "aas"
    | decode_mnemonic adc = "adc"
    | decode_mnemonic add = "add"
    | decode_mnemonic align = ".align"
    | decode_mnemonic and_op = "and"
    | decode_mnemonic arpl = "arpl"
    | decode_mnemonic bound = "bound"
    | decode_mnemonic bsf = "bsf"
    | decode_mnemonic bsr = "bsr"
    | decode_mnemonic bt = "bt"
    | decode_mnemonic btc = "btc"
    | decode_mnemonic btr = "btr"
    | decode_mnemonic bts = "bts"
    | decode_mnemonic call = "call"
    | decode_mnemonic cbw = "cbw"
    | decode_mnemonic cwde = "cwde"
    | decode_mnemonic clc = "clc"
    | decode_mnemonic cld = "cld"
    | decode_mnemonic cli = "cli"
    | decode_mnemonic clts = "clts"
    | decode_mnemonic cmc = "cmc"
    | decode_mnemonic cmp = "cmp"
    | decode_mnemonic cmps = "cmps"
    | decode_mnemonic cmpsb = "cmpsb"
    | decode_mnemonic cmpsw = "cmpsw"
    | decode_mnemonic cmpsd = "cmpsd"
    | decode_mnemonic cwd = "cwd"
    | decode_mnemonic cdq = "cdq"
    | decode_mnemonic daa = "daa"
    | decode_mnemonic das = "das"
    | decode_mnemonic dec = "dec"
    | decode_mnemonic div_op = "div"
    | decode_mnemonic enter = "enter"

    | decode_mnemonic fld = "fldl"
    | decode_mnemonic fst = "fstl"
    | decode_mnemonic fstp = "fstpl"
    | decode_mnemonic fild = "fildl"
    | decode_mnemonic fist = "fistl"
    | decode_mnemonic fistp = "fistpl"

    | decode_mnemonic fadd = "faddl"
    | decode_mnemonic fsub = "fsubl"
    | decode_mnemonic fsubr = "fsubrl"
    | decode_mnemonic fmul = "fmull"
    | decode_mnemonic fdiv = "fdivl"
    | decode_mnemonic fdivr = "fdivrl"

    | decode_mnemonic fabs = "fabsl"
    | decode_mnemonic fpatan = "fpatanl"
    | decode_mnemonic fchs = "fchsl"
    | decode_mnemonic fcos = "fcosl"
    | decode_mnemonic fsin = "fsinl"
    | decode_mnemonic fsqrt = "fsqrtl"      
    | decode_mnemonic fptan = "fptanl"
    | decode_mnemonic fldz = "fldzl"
    | decode_mnemonic fld1 = "fld1l"
    | decode_mnemonic fyl2x = "fyl2xl"
    | decode_mnemonic fyl2xp = "fyl2xpl"
    | decode_mnemonic f2xm1 = "f2xm1l"
    (* Comparisons & tests *)
    (* No integer comparisons for the moment *)
    | decode_mnemonic fcom = "fcoml"
    | decode_mnemonic fcomp = "fcompl"
    | decode_mnemonic fcompp = "fcomppl"
    | decode_mnemonic fucom = "fucoml"
    | decode_mnemonic fucomp = "fucompl"
    | decode_mnemonic fucompp = "fucomppl"
    | decode_mnemonic ftst = "ftstl"
    | decode_mnemonic fxam = "fxam"
    (* Control *)
    | decode_mnemonic fldcw = "fldcw"
    | decode_mnemonic fstcw  = "fstcw "
    | decode_mnemonic fnstcw = "fnstcw"
    | decode_mnemonic fstsw = "fstsw"
    | decode_mnemonic fstsw_ax = "fstsw    %ax"
    | decode_mnemonic fnstsw = "fnstsw"
    | decode_mnemonic fnclex = "fnclex"

    | decode_mnemonic hlt = "hlt"
    | decode_mnemonic idiv = "idiv"
    | decode_mnemonic imul = "imul"
    | decode_mnemonic in_op = "in_op"
    | decode_mnemonic inc = "inc"
    | decode_mnemonic ins = "ins"
    | decode_mnemonic insb = "insb"
    | decode_mnemonic insw = "insw"
    | decode_mnemonic insd = "insd"
    | decode_mnemonic int = "int"
    | decode_mnemonic into = "into"
    | decode_mnemonic iret = "iret"
    | decode_mnemonic iretd = "iretd"
    | decode_mnemonic(jcc cc) = "j" ^ decode_cc cc
    | decode_mnemonic jmp = "jmp"
    | decode_mnemonic lahf = "lahf"
    | decode_mnemonic lar = "lar"
    | decode_mnemonic lea = "lea"
    | decode_mnemonic leave = "leave"
    | decode_mnemonic lgdt = "lgdt"
    | decode_mnemonic lidt = "lidt"
    | decode_mnemonic lgs = "lgs"
    | decode_mnemonic lss = "lss"
    | decode_mnemonic lds = "lds"
    | decode_mnemonic les = "les"
    | decode_mnemonic lfs = "lfs"
    | decode_mnemonic lldt = "lldt"
    | decode_mnemonic lmsw = "lmsw"
    | decode_mnemonic lock = "lock"
    | decode_mnemonic lods = "lods"
    | decode_mnemonic lodsb = "lodsb"
    | decode_mnemonic lodsw = "lodsw"
    | decode_mnemonic lodsd = "lodsd"
    | decode_mnemonic loop = "loop"
    | decode_mnemonic loopz = "loopz"
    | decode_mnemonic loopnz = "loopnz"
    | decode_mnemonic lsl = "lsl"
    | decode_mnemonic ltr = "ltr"
    | decode_mnemonic mov = "mov"
    | decode_mnemonic movs = "movs"
    | decode_mnemonic movsb = "movsb"
    | decode_mnemonic movsw = "movsw"
    | decode_mnemonic movsd = "movsd"
    | decode_mnemonic movsx = "movsbl"
    | decode_mnemonic movzx = "movzbl"
    | decode_mnemonic mul = "mul"
    | decode_mnemonic neg = "neg"
    | decode_mnemonic nop = "nop"
    | decode_mnemonic not = "not"
    | decode_mnemonic or = "or"
    | decode_mnemonic out = "out"
    | decode_mnemonic outs = "outs"
    | decode_mnemonic outsb = "outsb"
    | decode_mnemonic outsw = "outsw"
    | decode_mnemonic outsd = "outsd"
    | decode_mnemonic pop = "pop"
    | decode_mnemonic popa = "popa"
    | decode_mnemonic popad = "popad"
    | decode_mnemonic popf = "popf"
    | decode_mnemonic popfd = "popfd"
    | decode_mnemonic push = "push"
    | decode_mnemonic pusha = "pusha"
    | decode_mnemonic pushad = "pushad"
    | decode_mnemonic pushf = "pushf"
    | decode_mnemonic pushfd = "pushfd"
    | decode_mnemonic rcl = "rcl"
    | decode_mnemonic rcr = "rcr"
    | decode_mnemonic rol = "rol"
    | decode_mnemonic ror = "ror"
    | decode_mnemonic rep = "rep"
    | decode_mnemonic repz = "repz"
    | decode_mnemonic repnz = "repnz"
    | decode_mnemonic ret = "ret"
    | decode_mnemonic sahf = "sahf"
    | decode_mnemonic sal = "sal"
    | decode_mnemonic sar = "sar"
    | decode_mnemonic shl = "shl"
    | decode_mnemonic shr = "shr"
    | decode_mnemonic sbb = "sbb"
    | decode_mnemonic scas = "scas"
    | decode_mnemonic scasb = "scasb"
    | decode_mnemonic scasw = "scasw"
    | decode_mnemonic scasd = "scasd"
    | decode_mnemonic(setcc cc)= "set" ^ decode_cc cc
    | decode_mnemonic sgdt = "sgdt"
    | decode_mnemonic sidt = "sidt"
    | decode_mnemonic shld = "shld"
    | decode_mnemonic shrd = "shrd"
    | decode_mnemonic sldt = "sldt"
    | decode_mnemonic smsw = "smsw"
    | decode_mnemonic stc = "stc"
    | decode_mnemonic std = "std"
    | decode_mnemonic sti = "sti"
    | decode_mnemonic stos = "stos"
    | decode_mnemonic stosb = "stosb"
    | decode_mnemonic stosw = "stosw"
    | decode_mnemonic stosd = "stosd"
    | decode_mnemonic str = "str"
    | decode_mnemonic sub = "sub"
    | decode_mnemonic test = "test"
    | decode_mnemonic verr = "verr"
    | decode_mnemonic verw = "verw"
    | decode_mnemonic wait = "wait"
    | decode_mnemonic xchg = "xchg"
    | decode_mnemonic xlat = "xlat"
    | decode_mnemonic xlatb = "xlatb"
    | decode_mnemonic xor = "xor"

  val print_mnemonic = decode_mnemonic

  fun check _ = Crash.unimplemented"I386_Assembly.check"

  fun needs_sib(MEM{index = SOME (I386Types.ESP, _), ...}) =
    Crash.impossible"scaled index with ESP"
    | needs_sib(MEM{index = SOME _, ...}) = true
    | needs_sib(MEM{base = SOME I386Types.ESP, ...}) = true
    | needs_sib _ = false

    fun transform_mem(arg as (base, index, offset)) =
      let
	val needs_transform =
	  case base of
	    SOME I386Types.EBP =>
	      (case index of
		 SOME (reg, scale) =>
		   (case reg of
		      I386Types.ESP =>
			(case scale of
			   SOME i =>
			     Crash.impossible "scaled index on ESP"
			 | _ => false (* Can't swap this one *))
		    | I386Types.EBP => false (* Swaping this is pointless *)
		    | _ =>
			(case scale of
			   NONE =>
			     (case offset of
				NONE => true
			      | _ => false)
			 | _ => false))
	       | _ => false)
	  | _ => false
        (* This is to deal with the weird addressing modes involvinge EBP *)
	(* When EBP is the base, and the index is unscaled and not ESP *)
	(* We can swap them *)
	(* Otherwise, we must have a non-trivial offset *)
	(* and have mod non-zero *)
      in
	if needs_transform then
	  let
	    val base_reg = case base of
	      SOME reg => reg
	    | _ => Crash.impossible"mem base absent"
	    val index_reg = case index of
	      SOME (reg, _) => reg
	    | _ => Crash.impossible"mem index absent"
	  in
	    (SOME index_reg, SOME(base_reg, NONE), offset)
	  end
	else
	  arg
      end

  local
    val a = 10
    val b = 11
    val c = 12
    val d = 13
    val e = 14
    val f = 15

    fun B l =
      let
        fun aux ([],acc) = acc
          | aux (#"0"::rest,acc) =
            aux (rest,acc+acc)
          | aux (#"1"::rest,acc) =
            aux (rest,acc+acc+1)
          | aux (#" "::rest,acc) =
            aux (rest,acc)
          | aux (d::rest,acc) =
            Crash.impossible "bad binary number"
      in
        aux (explode l,0)
      end

    (* Exciting stuff huh? *)

    val B000 = B"000"
    val B001 = B"001"
    val B011 = B"011"
    val B101 = B"101"
    val B111 = B"111"

    val B00000 = B"00000"
    val B00001 = B"00001"
    val B00010 = B"00010"
    val B00100 = B"00100"
    val B00101 = B"00101"
    val B01000 = B"01000"
    val B01110 = B"01110"
    val B10000 = B"10000"
    val B10001 = B"10001"
    val B10010 = B"10010"
    val B10011 = B"10011"
    val B11001 = B"11001"
    val B11010 = B"11010"
    val B11011 = B"11011"
    val B11110 = B"11110"
    val B11111 = B"11111"

    val B11011000 = B"11011000"
    val B11010000 = B"11010000"

    val B1110_0000 = B"1110 0000"

    (* Constants for fp *)
    val esc = B11011 * 8 (* = 216 = 11011 << 3 *)

    val integer_mf = 1

    val float_mf =
      case I386Types.fp_used of
        I386Types.single => 0
      | I386Types.double => 2
      | _ => Crash.impossible "Can't handle float format yet"

    fun assemble_cc above = 7
      | assemble_cc above_or_equal = 3
      | assemble_cc below = 2
      | assemble_cc below_or_equal = 6
      | assemble_cc cx_equal_zero = Crash.impossible"assemble_cc:cx_equal_zero"
      | assemble_cc ecx_equal_zero = Crash.impossible"assemble_cc:ecx_equal_zero"
      | assemble_cc equal = 4
      | assemble_cc greater = f
      | assemble_cc greater_or_equal = d
      | assemble_cc less = c
      | assemble_cc less_or_equal = e
      | assemble_cc not_equal = 5
      | assemble_cc not_overflow = 1
      | assemble_cc not_parity = b
      | assemble_cc not_sign = 9
      | assemble_cc overflow = 0
      | assemble_cc parity = a
      | assemble_cc sign = 8

    fun mnemonic_assemble aaa = [16*3+7]
      | mnemonic_assemble aad = [16*d+5, 16*0+a]
      | mnemonic_assemble aam = [16*d+4, 16*0+a]
      | mnemonic_assemble aas = [16*3+f]
      | mnemonic_assemble adc = [16*1+4]
      | mnemonic_assemble add = [16*0+4]
      | mnemonic_assemble align = []
      | mnemonic_assemble and_op = [16*2+4]
      | mnemonic_assemble arpl = Crash.impossible"mnemonic_assemble:arpl"
      | mnemonic_assemble bound = [16*6+2]
      | mnemonic_assemble bsf = [16*0+f, 16*b+c]
      | mnemonic_assemble bsr = [16*0+f, 16*b+d]
      | mnemonic_assemble bt = [16*0+f, 16*a+3]
      | mnemonic_assemble btc = [16*0+f, 16*b+b]
      | mnemonic_assemble btr = [16*0+f, 16*b+3]
      | mnemonic_assemble bts = [16*0+f, 16*a+b]
      | mnemonic_assemble call = [16*e+8]
      | mnemonic_assemble cbw = [16*9+8]
      | mnemonic_assemble cwde = [16*9+8]
      | mnemonic_assemble clc = [16*f+8]
      | mnemonic_assemble cld = [16*f+c]
      | mnemonic_assemble cli = Crash.impossible"mnemonic_assemble:cli"
      | mnemonic_assemble clts = Crash.impossible"mnemonic_assemble:clts"
      | mnemonic_assemble cmc = [16*f+5]
      | mnemonic_assemble cmp = [16*3+c]
      | mnemonic_assemble cmps = Crash.impossible"mnemonic_assemble:cmps"
      | mnemonic_assemble cmpsb = [16*a+6]
      | mnemonic_assemble cmpsw = [16*a+7]
      | mnemonic_assemble cmpsd = [16*a+7]
      | mnemonic_assemble cwd = [16*9+9]
      | mnemonic_assemble cdq = [16*9+9]
      | mnemonic_assemble daa = [16*2+7]
      | mnemonic_assemble das = [16*2+f]
      | mnemonic_assemble dec = [16*f+e]
      | mnemonic_assemble div_op = [16*f+6]
      | mnemonic_assemble enter = [16*c+8]
      (* Floating point *)
      | mnemonic_assemble fld = []
      | mnemonic_assemble fst = []
      | mnemonic_assemble fstp = []
      | mnemonic_assemble fild = []
      | mnemonic_assemble fist = []
      | mnemonic_assemble fistp = []
      | mnemonic_assemble fadd = []
      | mnemonic_assemble fsub = []
      | mnemonic_assemble fsubr = []
      | mnemonic_assemble fmul = []
      | mnemonic_assemble fdiv = []
      | mnemonic_assemble fdivr = []
      | mnemonic_assemble fabs = []
      | mnemonic_assemble fpatan = []
      | mnemonic_assemble fchs = []
      | mnemonic_assemble fcos = []
      | mnemonic_assemble fsin = []
      | mnemonic_assemble fsqrt = []
      | mnemonic_assemble fptan = []
      | mnemonic_assemble fldz = []
      | mnemonic_assemble fld1 = []
      | mnemonic_assemble fyl2x = []
      | mnemonic_assemble fyl2xp = []
      | mnemonic_assemble f2xm1 = []

      (* Comparisons & tests *)
      (* No integer comparisons for the moment *)
      | mnemonic_assemble fcom = []
      | mnemonic_assemble fcomp = []
      | mnemonic_assemble fcompp = []
      | mnemonic_assemble fucom = []
      | mnemonic_assemble fucomp = []
      | mnemonic_assemble fucompp = []
      | mnemonic_assemble ftst = []
      | mnemonic_assemble fxam = []
      (* Control *)
      | mnemonic_assemble fldcw = []
      | mnemonic_assemble fstcw  = []
      | mnemonic_assemble fnstcw = []
      | mnemonic_assemble fstsw = []
      | mnemonic_assemble fstsw_ax = []
      | mnemonic_assemble fnstsw = []
      | mnemonic_assemble fnclex = []

      (* End floating point *)
      | mnemonic_assemble hlt = Crash.impossible"mnemonic_assemble:hlt"
      | mnemonic_assemble idiv = [16*f+6]
      | mnemonic_assemble imul = [16*f+6]
      | mnemonic_assemble in_op = Crash.impossible"mnemonic_assemble:in_op"
      | mnemonic_assemble inc = [16*f+e]
      | mnemonic_assemble ins = Crash.impossible"mnemonic_assemble:ins"
      | mnemonic_assemble insb = Crash.impossible"mnemonic_assemble:insb"
      | mnemonic_assemble insw = Crash.impossible"mnemonic_assemble:insw"
      | mnemonic_assemble insd = Crash.impossible"mnemonic_assemble:insd"
      | mnemonic_assemble int = Crash.impossible"mnemonic_assemble:int"
      | mnemonic_assemble into = Crash.impossible"mnemonic_assemble:into"
      | mnemonic_assemble iret = Crash.impossible"mnemonic_assemble:iret"
      | mnemonic_assemble iretd = Crash.impossible"mnemonic_assemble:iret"
      | mnemonic_assemble(jcc cc) =
	(case cc of
	   cx_equal_zero => [e*16+3]
	 | ecx_equal_zero => [e*16+3]
	 | _ => [assemble_cc cc + 7*16])
      | mnemonic_assemble jmp = [16*e+b]
      | mnemonic_assemble lahf = [16*9+f]
      | mnemonic_assemble lar = Crash.impossible"mnemonic_assemble:lar"
      | mnemonic_assemble lea = [16*8+d]
      | mnemonic_assemble leave = [16*c+9]
      | mnemonic_assemble lgdt = Crash.impossible"mnemonic_assemble:lgdt"
      | mnemonic_assemble lidt = Crash.impossible"mnemonic_assemble:lidt"
      | mnemonic_assemble lgs = Crash.impossible"mnemonic_assemble:lgs"
      | mnemonic_assemble lss = Crash.impossible"mnemonic_assemble:lss"
      | mnemonic_assemble lds = Crash.impossible"mnemonic_assemble:lds"
      | mnemonic_assemble les = Crash.impossible"mnemonic_assemble:les"
      | mnemonic_assemble lfs = Crash.impossible"mnemonic_assemble:lfs"
      | mnemonic_assemble lldt = Crash.impossible"mnemonic_assemble:lldt"
      | mnemonic_assemble lmsw = Crash.impossible"mnemonic_assemble:lmsw"
      | mnemonic_assemble lock = Crash.impossible"mnemonic_assemble:lock"
      | mnemonic_assemble lods = Crash.impossible"mnemonic_assemble:lods"
      | mnemonic_assemble lodsb = [16*a+c]
      | mnemonic_assemble lodsw = [16*a+d]
      | mnemonic_assemble lodsd = [16*a+d]
      | mnemonic_assemble loop = [16*e+2]
      | mnemonic_assemble loopz = [16*e+1]
      | mnemonic_assemble loopnz = [16*e+0]
      | mnemonic_assemble lsl = Crash.impossible"mnemonic_assemble:lsl"
      | mnemonic_assemble ltr = Crash.impossible"mnemonic_assemble:ltr"
      | mnemonic_assemble mov = [16*8+8]
      | mnemonic_assemble movs = Crash.impossible"mnemonic_assemble:movs"
      | mnemonic_assemble movsb = [16*a+4]
      | mnemonic_assemble movsw = [16*a+5]
      | mnemonic_assemble movsd = [16*a+5]
      | mnemonic_assemble movsx = [16*0+f, 16*b+e]
      | mnemonic_assemble movzx = [16*0+f, 16*b+6]
      | mnemonic_assemble mul = [16*f+6]
      | mnemonic_assemble neg = [16*f+6]
      | mnemonic_assemble nop = [16*9+0]
      | mnemonic_assemble not = [16*f+6]
      | mnemonic_assemble or = [16*0+c]
      | mnemonic_assemble out = Crash.impossible"mnemonic_assemble:out"
      | mnemonic_assemble outs = Crash.impossible"mnemonic_assemble:outs"
      | mnemonic_assemble outsb = Crash.impossible"mnemonic_assemble:outsb"
      | mnemonic_assemble outsw = Crash.impossible"mnemonic_assemble:outsw"
      | mnemonic_assemble outsd = Crash.impossible"mnemonic_assemble:outsd"
      | mnemonic_assemble pop = [16*8+f]
      | mnemonic_assemble popa = [16*6+1]
      | mnemonic_assemble popad = [16*6+1]
      | mnemonic_assemble popf = [16*9+d]
      | mnemonic_assemble popfd = [16*9+d]
      | mnemonic_assemble push = [16*f+f]
      | mnemonic_assemble pusha = [16*6+0]
      | mnemonic_assemble pushad = [16*6+0]
      | mnemonic_assemble pushf = [16*9+c]
      | mnemonic_assemble pushfd = [16*9+c]
      | mnemonic_assemble rcl = [16*d+0]
      | mnemonic_assemble rcr = [16*d+0]
      | mnemonic_assemble rol = [16*d+0]
      | mnemonic_assemble ror = [16*d+0]
      | mnemonic_assemble rep = [16*f+3, 16*6+c]
      | mnemonic_assemble repz = [16*f+3, 16*a+6]
      | mnemonic_assemble repnz = [16*f+2, 16*a+6]
      | mnemonic_assemble ret = [16*c+3]
      | mnemonic_assemble sahf = [16*9+e]
      | mnemonic_assemble sal = [16*d+0]
      | mnemonic_assemble sar = [16*d+0]
      | mnemonic_assemble shl = [16*d+0]
      | mnemonic_assemble shr = [16*d+0]
      | mnemonic_assemble sbb = [16*1+c]
      | mnemonic_assemble scas = Crash.impossible"mnemonic_assemble:scas"
      | mnemonic_assemble scasb = [16*a+e]
      | mnemonic_assemble scasw = [16*a+f]
      | mnemonic_assemble scasd = [16*a+f]
      | mnemonic_assemble(setcc cc) = [16*0+f, 9*16 + assemble_cc cc]
      | mnemonic_assemble sgdt = Crash.impossible"mnemonic_assemble:sgdt"
      | mnemonic_assemble sidt = Crash.impossible"mnemonic_assemble:sidt"
      | mnemonic_assemble shld = [16*0+f, 16*a+4]
      | mnemonic_assemble shrd = [16*0+f, 16*a+c]
      | mnemonic_assemble sldt = Crash.impossible"mnemonic_assemble:sldt"
      | mnemonic_assemble smsw = Crash.impossible"mnemonic_assemble:smsw"
      | mnemonic_assemble stc = [16*f+9]
      | mnemonic_assemble std = [16*f+d]
      | mnemonic_assemble sti = Crash.impossible"mnemonic_assemble:sti"
      | mnemonic_assemble stos = Crash.impossible"mnemonic_assemble:stos"
      | mnemonic_assemble stosb = [16*a+a]
      | mnemonic_assemble stosw = [16*a+b]
      | mnemonic_assemble stosd = [16*a+b]
      | mnemonic_assemble str = Crash.impossible"mnemonic_assemble:str"
      | mnemonic_assemble sub = [16*2+c]
      | mnemonic_assemble test = [16*a+8]
      | mnemonic_assemble verr = Crash.impossible"mnemonic_assemble:verr"
      | mnemonic_assemble verw = Crash.impossible"mnemonic_assemble:verw"
      | mnemonic_assemble wait = [16*9+b]
      | mnemonic_assemble xchg = [16*9+0]
      | mnemonic_assemble xlat = [16*d+7]
      | mnemonic_assemble xlatb = [16*d+7]
      | mnemonic_assemble xor = [16*3+4]

    fun get_modr_m_digit aaa = Crash.impossible"get_modr_m_digit:aaa"
      | get_modr_m_digit aad = Crash.impossible"get_modr_m_digit:aad"
      | get_modr_m_digit aam = Crash.impossible"get_modr_m_digit:aam"
      | get_modr_m_digit aas = Crash.impossible"get_modr_m_digit:aas"
      | get_modr_m_digit adc = (8*16-(16+4), 2)
      | get_modr_m_digit add = (8*16-4, 0)
      | get_modr_m_digit align = Crash.impossible"get_modr_m_digit:aas"
      | get_modr_m_digit and_op = (8*16-(2*16+4), 4)
      | get_modr_m_digit arpl = Crash.impossible"get_modr_m_digit:arpl"
      | get_modr_m_digit bound = Crash.impossible"get_modr_m_digit:bound"
      | get_modr_m_digit bsf = (0, 0)
      | get_modr_m_digit bsr = (0, 0)
      | get_modr_m_digit bt = (0, 4)
      | get_modr_m_digit btc = (0, 7)
      | get_modr_m_digit btr = (0, 6)
      | get_modr_m_digit bts = (0, 5)
      | get_modr_m_digit call = (0, 2)
      | get_modr_m_digit cbw = Crash.impossible"get_modr_m_digit:cbw"
      | get_modr_m_digit cwde = Crash.impossible"get_modr_m_digit:cwde"
      | get_modr_m_digit clc = Crash.impossible"get_modr_m_digit:clc"
      | get_modr_m_digit cld = Crash.impossible"get_modr_m_digit:cld"
      | get_modr_m_digit cli = Crash.impossible"get_modr_m_digit:cli"
      | get_modr_m_digit clts = Crash.impossible"get_modr_m_digit:clts"
      | get_modr_m_digit cmc = Crash.impossible"get_modr_m_digit:cmc"
      | get_modr_m_digit cmp = (8*16-(3*16+c), 7)
      | get_modr_m_digit cmps = Crash.impossible"get_modr_m_digit:cmps"
      | get_modr_m_digit cmpsb = Crash.impossible"get_modr_m_digit:cmpsb"
      | get_modr_m_digit cmpsw = Crash.impossible"get_modr_m_digit:cmpsw"
      | get_modr_m_digit cmpsd = Crash.impossible"get_modr_m_digit:cmpsd"
      | get_modr_m_digit cwd = Crash.impossible"get_modr_m_digit:cwd"
      | get_modr_m_digit cdq = Crash.impossible"get_modr_m_digit:cdq"
      | get_modr_m_digit daa = Crash.impossible"get_modr_m_digit:daa"
      | get_modr_m_digit das = Crash.impossible"get_modr_m_digit:das"
      | get_modr_m_digit dec = (16*4+8, 1)
      | get_modr_m_digit div_op = (0, 6)
      | get_modr_m_digit enter = Crash.impossible"get_modr_m_digit:enter"
      (* Floating point *)
      | get_modr_m_digit fld = Crash.impossible"get_modr_m_digit:fld"
      | get_modr_m_digit fst = Crash.impossible"get_modr_m_digit:fst"
      | get_modr_m_digit fstp = Crash.impossible"get_modr_m_digit:fstp"
      | get_modr_m_digit fild = Crash.impossible"get_modr_m_digit:fild"
      | get_modr_m_digit fist = Crash.impossible"get_modr_m_digit:fist"
      | get_modr_m_digit fistp = Crash.impossible"get_modr_m_digit:fistp"
      | get_modr_m_digit fadd = Crash.impossible"get_modr_m_digit:fadd"
      | get_modr_m_digit fsub = Crash.impossible"get_modr_m_digit:fsub"
      | get_modr_m_digit fsubr = Crash.impossible"get_modr_m_digit:fsubr"
      | get_modr_m_digit fmul = Crash.impossible"get_modr_m_digit:fmul"
      | get_modr_m_digit fdiv = Crash.impossible"get_modr_m_digit:fdiv"
      | get_modr_m_digit fdivr = Crash.impossible"get_modr_m_digit:fdivr"

      | get_modr_m_digit fabs = Crash.impossible"get_modr_m_digit:fabs"
      | get_modr_m_digit fpatan = Crash.impossible"get_modr_m_digit:fpatan"
      | get_modr_m_digit fchs = Crash.impossible"get_modr_m_digit:fchs"
      | get_modr_m_digit fcos = Crash.impossible"get_modr_m_digit:fcos"
      | get_modr_m_digit fsin = Crash.impossible"get_modr_m_digit:fsin"
      | get_modr_m_digit fsqrt = Crash.impossible"get_modr_m_digit:fsqrt"
      | get_modr_m_digit fptan = Crash.impossible"get_modr_m_digit:fptan"
      | get_modr_m_digit fldz = Crash.impossible"get_modr_m_digit:fldz"
      | get_modr_m_digit fld1 = Crash.impossible"get_modr_m_digit:fld1"
      | get_modr_m_digit fyl2x = Crash.impossible"get_modr_m_digit:fyl2x"
      | get_modr_m_digit fyl2xp = Crash.impossible"get_modr_m_digit:fyl2xp"
      | get_modr_m_digit f2xm1 = Crash.impossible"get_modr_m_digit:f2xm1"

      (* Comparisons & tests *)
      (* No integer comparisons for the moment *)
      | get_modr_m_digit fcom = Crash.impossible"get_modr_m_digit:fcom"
      | get_modr_m_digit fcomp = Crash.impossible"get_modr_m_digit:fcomp"
      | get_modr_m_digit fcompp = Crash.impossible"get_modr_m_digit:fcompp"
      | get_modr_m_digit fucom = Crash.impossible"get_modr_m_digit:fucom"
      | get_modr_m_digit fucomp = Crash.impossible"get_modr_m_digit:fucomp"
      | get_modr_m_digit fucompp = Crash.impossible"get_modr_m_digit:fucompp"
      | get_modr_m_digit ftst = Crash.impossible"get_modr_m_digit:ftst"
      | get_modr_m_digit fxam = Crash.impossible"get_modr_m_digit:fxam"
      (* Control *)
      | get_modr_m_digit fldcw = Crash.impossible"get_modr_m_digit:fldcw"
      | get_modr_m_digit fstcw  = Crash.impossible"get_modr_m_digit:fstcw "
      | get_modr_m_digit fnstcw = Crash.impossible"get_modr_m_digit:fnstcw"
      | get_modr_m_digit fstsw = Crash.impossible"get_modr_m_digit:fstsw"
      | get_modr_m_digit fstsw_ax = Crash.impossible"get_modr_m_digit:fstsw"
      | get_modr_m_digit fnstsw = Crash.impossible"get_modr_m_digit:fnstsw"
      | get_modr_m_digit fnclex = Crash.impossible"get_modr_m_digit:fnclex"

      (* End floating point *)
      | get_modr_m_digit hlt = Crash.impossible"get_modr_m_digit:hlt"
      | get_modr_m_digit idiv = (0, 7)
      | get_modr_m_digit imul = (0, 5)
      | get_modr_m_digit in_op = Crash.impossible"get_modr_m_digit:in_op"
      | get_modr_m_digit inc = (16*4, 0)
      | get_modr_m_digit ins = Crash.impossible"get_modr_m_digit:ins"
      | get_modr_m_digit insb = Crash.impossible"get_modr_m_digit:insb"
      | get_modr_m_digit insw = Crash.impossible"get_modr_m_digit:insw"
      | get_modr_m_digit insd = Crash.impossible"get_modr_m_digit:insd"
      | get_modr_m_digit int = Crash.impossible"get_modr_m_digit:int"
      | get_modr_m_digit into = Crash.impossible"get_modr_m_digit:into"
      | get_modr_m_digit iret = Crash.impossible"get_modr_m_digit:iret"
      | get_modr_m_digit iretd = Crash.impossible"get_modr_m_digit:iretd"
      | get_modr_m_digit(jcc cc) = Crash.impossible"get_modr_m_digit:jcc"
(*
	(case cc ofcc"
	   cx_equal_zero = Crash.impossible"get_modr_m_digit:cx_equal_zero"
	 | ecx_equal_zero = Crash.impossible"get_modr_m_digit:ecx_equal_zero"
	 | _ = Crash.impossible"get_modr_m_digit:_"
*)
      | get_modr_m_digit jmp = Crash.impossible"get_modr_m_digit:jmp"
      | get_modr_m_digit lahf = Crash.impossible"get_modr_m_digit:lahf"
      | get_modr_m_digit lar = Crash.impossible"get_modr_m_digit:lar"
      | get_modr_m_digit lea = (0, 0)
      | get_modr_m_digit leave = Crash.impossible"get_modr_m_digit:leave"
      | get_modr_m_digit lgdt = Crash.impossible"get_modr_m_digit:lgdt"
      | get_modr_m_digit lidt = Crash.impossible"get_modr_m_digit:lidt"
      | get_modr_m_digit lgs = Crash.impossible"get_modr_m_digit:lgs"
      | get_modr_m_digit lss = Crash.impossible"get_modr_m_digit:lss"
      | get_modr_m_digit lds = Crash.impossible"get_modr_m_digit:lds"
      | get_modr_m_digit les = Crash.impossible"get_modr_m_digit:les"
      | get_modr_m_digit lfs = Crash.impossible"get_modr_m_digit:lfs"
      | get_modr_m_digit lldt = Crash.impossible"get_modr_m_digit:lldt"
      | get_modr_m_digit lmsw = Crash.impossible"get_modr_m_digit:lmsw"
      | get_modr_m_digit lock = Crash.impossible"get_modr_m_digit:lock"
      | get_modr_m_digit lods = Crash.impossible"get_modr_m_digit:lods"
      | get_modr_m_digit lodsb = Crash.impossible"get_modr_m_digit:lodsb"
      | get_modr_m_digit lodsw = Crash.impossible"get_modr_m_digit:lodsw"
      | get_modr_m_digit lodsd = Crash.impossible"get_modr_m_digit:lodsd"
      | get_modr_m_digit loop = Crash.impossible"get_modr_m_digit:loop"
      | get_modr_m_digit loopz = Crash.impossible"get_modr_m_digit:loopz"
      | get_modr_m_digit loopnz = Crash.impossible"get_modr_m_digit:loopnz"
      | get_modr_m_digit lsl = Crash.impossible"get_modr_m_digit:lsl"
      | get_modr_m_digit ltr = Crash.impossible"get_modr_m_digit:ltr"
      | get_modr_m_digit mov = (0, 0)
      | get_modr_m_digit movs = (0, 0)
      | get_modr_m_digit movsb = Crash.impossible"get_modr_m_digit:movsb"
      | get_modr_m_digit movsw = Crash.impossible"get_modr_m_digit:movsw"
      | get_modr_m_digit movsd = Crash.impossible"get_modr_m_digit:movsd"
      | get_modr_m_digit movsx = (0, 0)
      | get_modr_m_digit movzx = (0, 0)
      | get_modr_m_digit mul = (0, 4)
      | get_modr_m_digit neg = (0, 3)
      | get_modr_m_digit nop = Crash.impossible"get_modr_m_digit:nop"
      | get_modr_m_digit not = (0, 2)
      | get_modr_m_digit or = (8*16-c, 1)
      | get_modr_m_digit out = Crash.impossible"get_modr_m_digit:out"
      | get_modr_m_digit outs = Crash.impossible"get_modr_m_digit:outs"
      | get_modr_m_digit outsb = Crash.impossible"get_modr_m_digit:outsb"
      | get_modr_m_digit outsw = Crash.impossible"get_modr_m_digit:outsw"
      | get_modr_m_digit outsd = Crash.impossible"get_modr_m_digit:outsd"
      | get_modr_m_digit pop = (0, 0)
      | get_modr_m_digit popa = Crash.impossible"get_modr_m_digit:popa"
      | get_modr_m_digit popad = Crash.impossible"get_modr_m_digit:popad"
      | get_modr_m_digit popf = Crash.impossible"get_modr_m_digit:popf"
      | get_modr_m_digit popfd = Crash.impossible"get_modr_m_digit:popfd"
      | get_modr_m_digit push = (0, 6)
      | get_modr_m_digit pusha = Crash.impossible"get_modr_m_digit:pusha"
      | get_modr_m_digit pushad = Crash.impossible"get_modr_m_digit:pushad"
      | get_modr_m_digit pushf = Crash.impossible"get_modr_m_digit:pushf"
      | get_modr_m_digit pushfd = Crash.impossible"get_modr_m_digit:pushfd"
      | get_modr_m_digit rcl = (0, 2)
      | get_modr_m_digit rcr = (0, 3)
      | get_modr_m_digit rol = (0, 0)
      | get_modr_m_digit ror = (0, 1)
      | get_modr_m_digit rep = Crash.impossible"get_modr_m_digit:rep"
      | get_modr_m_digit repz = Crash.impossible"get_modr_m_digit:repz"
      | get_modr_m_digit repnz = Crash.impossible"get_modr_m_digit:repnz"
      | get_modr_m_digit ret = Crash.impossible"get_modr_m_digit:ret"
      | get_modr_m_digit sahf = Crash.impossible"get_modr_m_digit:sahf"
      | get_modr_m_digit sal = (0, 4)
      | get_modr_m_digit sar = (0, 7)
      | get_modr_m_digit shl = (0, 4)
      | get_modr_m_digit shr = (0, 5)
      | get_modr_m_digit sbb = (16*8-(16+c), 3)
      | get_modr_m_digit scas = Crash.impossible"get_modr_m_digit:scas"
      | get_modr_m_digit scasb = Crash.impossible"get_modr_m_digit:scasb"
      | get_modr_m_digit scasw = Crash.impossible"get_modr_m_digit:scasw"
      | get_modr_m_digit scasd = Crash.impossible"get_modr_m_digit:scasd"
      | get_modr_m_digit(setcc cc) = Crash.impossible"get_modr_m_digit:setcc"
      | get_modr_m_digit sgdt = Crash.impossible"get_modr_m_digit:sgdt"
      | get_modr_m_digit sidt = Crash.impossible"get_modr_m_digit:sidt"
      | get_modr_m_digit shld = (0, 0)
      | get_modr_m_digit shrd = (0, 0)
      | get_modr_m_digit sldt = Crash.impossible"get_modr_m_digit:sldt"
      | get_modr_m_digit smsw = Crash.impossible"get_modr_m_digit:smsw"
      | get_modr_m_digit stc = Crash.impossible"get_modr_m_digit:stc"
      | get_modr_m_digit std = Crash.impossible"get_modr_m_digit:std"
      | get_modr_m_digit sti = Crash.impossible"get_modr_m_digit:sti"
      | get_modr_m_digit stos = Crash.impossible"get_modr_m_digit:stos"
      | get_modr_m_digit stosb = Crash.impossible"get_modr_m_digit:stosb"
      | get_modr_m_digit stosw = Crash.impossible"get_modr_m_digit:stosw"
      | get_modr_m_digit stosd = Crash.impossible"get_modr_m_digit:stosd"
      | get_modr_m_digit str = Crash.impossible"get_modr_m_digit:str"
      | get_modr_m_digit sub = (16*8-(16*2+c), 5)
      | get_modr_m_digit test = (16*f+6-(16*8+8), 0)
      | get_modr_m_digit verr = Crash.impossible"get_modr_m_digit:verr"
      | get_modr_m_digit verw = Crash.impossible"get_modr_m_digit:verw"
      | get_modr_m_digit wait = Crash.impossible"get_modr_m_digit:wait"
      | get_modr_m_digit xchg = (0, 0)
      | get_modr_m_digit xlat = Crash.impossible"get_modr_m_digit:xlat"
      | get_modr_m_digit xlatb = Crash.impossible"get_modr_m_digit:xlatb"
      | get_modr_m_digit xor = (16*8-(3*16+4), 6)

    val operand_prefix = 16*6+6

    fun assemble_char_signed i = [i mod 256]

    fun assemble_short_signed i = [i mod 256, (i div 256) mod 256]

    fun assemble_int_signed i =
      [i mod 256, (i div 256) mod 256, (i div (256*256)) mod 256,
       (i div (256*256*256)) mod 256]

    fun print_cons(rel8 _) = "rel8"
      | print_cons(rel16 _) = "rel16"
      | print_cons(rel32 _) = "rel32"
      | print_cons(fix_rel32 _) = "fix_rel32"
      | print_cons(ptr16_16 _) = "ptr16_16"
      | print_cons(ptr16_32 _) = "ptr16_32"
      | print_cons(r8 _) = "r8"
      | print_cons(r16 _) = "r16"
      | print_cons(r32 _) = "r32"
      | print_cons(imm8 _) = "imm8"
      | print_cons(imm16 _) = "imm16"
      | print_cons(imm32 _) = "imm32"
      | print_cons(r_m8 _) = "r_m8"
      | print_cons(r_m16 _) = "r_m16"
      | print_cons(r_m32 _) = "r_m32"
      | print_cons(m8 _) = "m8"
      | print_cons(m16 _) = "m16"
      | print_cons(m32 _) = "m32"
      | print_cons(fp_mem _) = "fp_mem"
      | print_cons(fp_reg _) = "fp_reg"

    fun assemble_imm(imm8 i) = assemble_char_signed i
      | assemble_imm(imm16 i) = assemble_short_signed i
      | assemble_imm(imm32(i, j)) =
	let
	  val hi = i div 64
	  val lo = i mod 64
	in
	  lo*4+j :: hi mod 256 :: assemble_short_signed(hi div 256)
	end
      | assemble_imm arg =
	Crash.impossible("assemble_imm: bad operand:" ^ print_cons arg)

    fun assemble_rel(rel32 i) = assemble_int_signed i
      | assemble_rel(fix_rel32 i) = assemble_int_signed i
      | assemble_rel(rel16 i) = assemble_short_signed i
      | assemble_rel(rel8 i) = assemble_char_signed i
      | assemble_rel _ = Crash.impossible"assemble_rel:bad operand"

    val assemble_reg = I386Types.register_value

    (* Returns MOD 000 R/M byte and (possibly) a list of SIB bytes and a list of DISP bytes *)
    fun assemble_mem(mem_operand as MEM{base, index, offset}) =
      let
	val needs_sib = needs_sib mem_operand
	val (base, index, offset) = transform_mem(base, index, offset)
      in
	let
	  val (disp, needs_disp) = case offset of
	    NONE =>
	      (case base of
		 SOME I386Types.EBP => (assemble_imm(imm8 0), true)
	       | _ => ([], false))
	  | SOME (SMALL i) =>
		 (assemble_imm(if i <= 127 andalso i > ~129 then imm8 i else imm32(i div 4, i mod 4)), false)
	  | SOME (LARGE(i, j)) =>
		 (assemble_imm(if i <= 31 andalso i >= ~32 then imm8(i*4+j) else imm32(i, j)), false)
	(* Perhaps we should pass the above information in *)
	in
	  if needs_sib then
	    let
	      val modr_m = case offset of
		NONE => if needs_disp then 4*16 + 4 else 0  + 4
	      | SOME (SMALL i) =>
		  (if i <= 127 andalso i >= ~128 then 4*16 else 8 *16) + 4
	      | SOME (LARGE(i, j)) =>
		     (if i <= 31 andalso i >= ~32  then 4*16 else 8 *16) + 4
	      val (index_reg, top_ss) = case index of
		SOME (reg, i_opt) =>
		  (assemble_reg reg * 8, case i_opt of
		   NONE => 0
		 | SOME i =>
		     case i of
		       2 => 4*16
		     | 4 => 8*16
		     | 8 => c*16
		     | _ => Crash.impossible"assemble_mem:scale not 2, 4 or 8")
	      | _ => (0, 4*8)
	      val sib = case base of
		SOME reg => assemble_reg reg + index_reg + top_ss
	      | _ => Crash.impossible"assemble_mem:base missing for sib"
	    in
	      (modr_m, [sib], disp)
	    end
	  else
	    let
	      val top_mod = case base of
		NONE => 0
	      | _ => case offset of
		  NONE => 0
		| SOME (SMALL i) =>
		    if i <= 127 andalso i >= ~128 then 4*16 else 8*16
		| SOME (LARGE(i, j)) =>
		      if i <= 31 andalso i >= ~32 then 4*16 else 8*16
	      val reg = case base of
		NONE => 5
	      | SOME reg => assemble_reg reg
	    in
	      (top_mod+reg, [], disp)
	    end
	end
      end

    fun assemble_r_m(r_m8(INL reg)) = (16*c + assemble_reg reg, [], [])
      | assemble_r_m(r_m8(INR mem)) = assemble_mem mem
      | assemble_r_m(r_m16(INL reg)) = (16*c + assemble_reg reg, [], [])
      | assemble_r_m(r_m16(INR mem)) = assemble_mem mem (* Guess? *)
      | assemble_r_m(r_m32(INL reg)) = (16*c + assemble_reg reg, [], [])
      | assemble_r_m(r_m32(INR mem)) = assemble_mem mem
      | assemble_r_m _ = Crash.impossible "assemble_r_m:bad arg" 

    fun hd (x :: _) = x
      | hd _ = Crash.impossible"I386_Assembly:hd:bad args"

    fun tl (_:: x) = x
      | tl _ = Crash.impossible"I386_Assembly:tl:bad args"

    (* This seems to expect one operand to be a register or immediate and *)
    (* the other to be a register or memory location *)

    fun assemble_operands(opcode, operand1, operand2) =
      let
	val imm = case operand2 of
	  imm8 _ => assemble_imm operand2
	| imm16 _ => assemble_imm operand2
	| imm32 _ => assemble_imm operand2
	| _ => []
	val needs_prefix = case operand1 of
	  r_m16 _ => true
	| r16 _ => true
	| _ => false
	val (extra_offset, modr_m_digit) = get_modr_m_digit opcode
	val reg =
	  case (operand1, operand2) of
	    (_, imm8 _) => modr_m_digit
	  | (_, imm16 _) => modr_m_digit
	  | (_, imm32 _) => modr_m_digit
	  | (r8 reg, _) => assemble_reg reg
	  | (r16 reg, _) => assemble_reg reg
	  | (r32 reg, _) => assemble_reg reg
	  | (_, r8 reg) => assemble_reg reg
	  | (_, r16 reg) => assemble_reg reg
	  | (_, r32 reg) => assemble_reg reg
	  | _ => Crash.impossible"assemble_operands:reg"
	val (modr_m, sib, disp) = case (operand1, operand2) of
	  (r_m8 _, _) => assemble_r_m operand1
	| (r_m16 _, _) => assemble_r_m operand1
	| (r_m32 _, _) => assemble_r_m operand1
	| (_, r_m8 _) => assemble_r_m operand2
	| (_, r_m16 _) => assemble_r_m operand2
	| (_, r_m32 _) => assemble_r_m operand2
	| _ => (0, [], [])
	val modr_m = modr_m + reg * 8
	val opcode_offset = case operand1 of
	  r_m8 _ =>
	    (case operand2 of
	       imm8 _ => extra_offset
	     | _ => ~4)
	| r_m16 _ =>
	    (case operand2 of
	       imm8 _ => extra_offset+3
	     | imm16 _ => extra_offset+1
	     | _ => ~3)
	| r_m32 _ =>
	    (case operand2 of
	       imm8 _ => extra_offset+3
	     | imm32 _ => extra_offset+1
	     | _ => ~3)
	| r8 _ => ~2
	| _ => ~1
      in
	(opcode_offset, modr_m, sib @ disp, imm, needs_prefix)
      end

    fun assemble_add_type(mnemonic_value, (opcode, adr_mode_list)) =
      let
	val (operand1, operand2) = case adr_mode_list of
	  [a, b] => (a, b)
	| _ => Crash.impossible("assemble:" ^ decode_mnemonic opcode ^
				":wrong number of arguments")
	val easy_imm = case (operand1, operand2) of
	  (r_m8(INL I386Types.AL), imm8 _) => true
	| (r_m16(INL I386Types.AX), imm16 _) => true
	| (r_m32(INL I386Types.EAX), imm32 _) => true
	| _ => false
      in
	if easy_imm then
	  let
(*
	    val _ = output(std_out, "Assembling short form for easy imm in add_type\n")
*)
	    val tail = assemble_imm operand2
	  in
	    case operand2 of
	      imm8 _ => I386_Opcodes.OPCODE(mnemonic_value @ tail)
	    | imm16 _ =>
		I386_Opcodes.OPCODE(operand_prefix :: (hd mnemonic_value)+1 :: tail)
	    | _ => I386_Opcodes.OPCODE((hd mnemonic_value)+1 :: tail)
	  end
	else
	  (* The two operand case *)
	  let
	    val (opcode_offset, modr_m, sib, imm, needs_prefix) =
	      assemble_operands(opcode, operand1, operand2)
	    val tail = (hd mnemonic_value)+opcode_offset :: modr_m :: (sib @ imm)
	  in
	    I386_Opcodes.OPCODE(if needs_prefix then operand_prefix :: tail else tail)
	  end
      end

    fun assemble_bit_scan_type(mnemonic_value, (opcode, adr_mode_list)) =
      let
	val (operand1, operand2) = case adr_mode_list of
	  [a, b] => (a, b)
	| _ => Crash.impossible("assemble" ^ decode_mnemonic opcode ^
				":wrong number of arguments")
	val (_, modr_m, sib, _, needs_prefix) =
	  assemble_operands(opcode, operand1, operand2)
	val main_opcode = mnemonic_value @ (modr_m :: sib)
      in
	I386_Opcodes.OPCODE(if needs_prefix then operand_prefix :: main_opcode else main_opcode)
      end

    fun assemble_bit_test_type(mnemonic_value, (opcode, adr_mode_list)) =
      let
	val (operand1, operand2) = case adr_mode_list of
	  [a, b] => (a, b)
	| _ => Crash.impossible("assemble" ^ decode_mnemonic opcode ^
				":wrong number of arguments")
	val (_, modr_m, sib, imm, needs_prefix) =
	  assemble_operands(opcode, operand1, operand2)
	val main_opcode = mnemonic_value @ (modr_m :: sib @ imm)
      in
	I386_Opcodes.OPCODE(if needs_prefix then operand_prefix :: main_opcode else main_opcode)
      end

    fun assemble_call(mnemonic_value, (opcode, adr_mode_list)) =
      let
	val operand =
	  case adr_mode_list of
	    [a] => a
	  | _ => Crash.impossible"assemble_call:wrong number of arguments"
      in
	case operand of
	  rel32 _ => I386_Opcodes.OPCODE(mnemonic_value @ assemble_rel operand)
	| fix_rel32 _ => I386_Opcodes.OPCODE(mnemonic_value @ assemble_rel operand)
	| _ =>
	    let
	      val (modr_m, sib, disp) = assemble_r_m operand
	    in
	      I386_Opcodes.OPCODE(f*16+f :: modr_m + 8*2 :: sib @ disp)
	    end
      end

    fun assemble_dec_type(mnemonic_value, (opcode, adr_mode_list)) =
      let
	val operand = case adr_mode_list of
	  [a] => a
	| _ => Crash.impossible"assemble_dec_type:wrong number of arguments"
	val (new_opcode, reg) = get_modr_m_digit opcode
      in
	case operand of
	  r16 reg =>
	    I386_Opcodes.OPCODE([operand_prefix, new_opcode + assemble_reg reg])
	| r32 reg =>
	    I386_Opcodes.OPCODE([new_opcode + assemble_reg reg])
	| _ =>
	    let
	      val (modr_m, sib, disp) = assemble_r_m operand
	      val main_opcode = modr_m + 8 * reg :: sib @ disp
	      val opc = hd mnemonic_value
	    in
	      I386_Opcodes.OPCODE
	      (case operand of
		 r_m8 _ => opc :: main_opcode
	       | r_m16 _ => operand_prefix :: opc+1 :: main_opcode
	       | r_m32 _ => opc+1 :: main_opcode
	       | _ => Crash.impossible"assemble_dec_type:bad operand")
	    end
      end

    fun assemble_div_type(mnemonic_value, (opcode, adr_mode_list)) =
      let
	val operand = case adr_mode_list of
	  [a] => a
	| _ => Crash.impossible"assemble_div_type:wrong number of arguments"
	val (_, reg) = get_modr_m_digit opcode
	val (modr_m, sib, disp) = assemble_r_m operand
	val main_opcode = modr_m + 8 * reg :: sib @ disp
	val opc = hd mnemonic_value
      in
	I386_Opcodes.OPCODE
	(case operand of
	   r_m8 _ => opc :: main_opcode
	 | r_m16 _ => operand_prefix :: opc+1 :: main_opcode
	 | r_m32 _ => opc+1 :: main_opcode
	 | _ => Crash.impossible"assemble_div_type:bad operand")
      end

    fun assemble_imul(full_arg as (mnemonic_value, (opcode, adr_mode_list))) =
      case adr_mode_list of
	[_] => assemble_div_type full_arg
      | [operand1, operand2] =>
	  (case operand2 of
	     r_m32 _ =>
	       let
		 val (_, modr_m, sib, imm, needs_prefix) =
		   assemble_operands(opcode, operand1, operand2)
		 val main_opcode = 15 :: 10*16+15 :: modr_m :: sib @ imm
	       in
		 I386_Opcodes.OPCODE(if needs_prefix then operand_prefix  :: main_opcode else main_opcode)
	       end
	   | _ =>
	       (* This should be register * immediate *)
	       let
		 val main_opcode = case operand2 of
		   imm8 _ => 6*16+11
		 | _ => 6*16+9
		 val imm = assemble_imm operand2
		 val reg = case operand1 of
		   r32 reg => reg
		 | r_m32(INL reg) => reg
		 | _ => Crash.impossible"assemble_imul:bad args"
		 val ass_reg = assemble_reg reg
		 val modr_m = ass_reg * 8 + 16*c + ass_reg
	       in
		 I386_Opcodes.OPCODE(main_opcode :: modr_m :: imm)
	       end)
      | [operand1, operand2, operand3] =>
	  let
	    val (_, modr_m, sib, _, needs_prefix) =
	      assemble_operands(opcode, operand1, operand2)
	    val imm = assemble_imm operand3
	    val new_opc = case operand3 of
	      imm8 _ => 6*16+11
	    | _ => 6*16+9
	    val main_opcode = new_opc :: modr_m :: sib @ imm
	  in
	    I386_Opcodes.OPCODE(if needs_prefix then operand_prefix  :: main_opcode else main_opcode)
	  end
      | _ => Crash.impossible"assemble_imul:wrong number of arguments"

    fun assemble_loop_opcode(mnemonic_value, (opcode, adr_mode_list)) =
      let
      val operand = case adr_mode_list of
	[operand] => operand
      | _ => Crash.impossible"assemble_loop_opcode:wrong number of arguments"
      in
	case operand of
	  rel8 _ => I386_Opcodes.OPCODE(mnemonic_value @ assemble_rel operand)
	| _ => Crash.impossible"assemble_loop_opcode:bad operand"
      end

    fun assemble_neg_not_type(arg as (_, (_, adr_mode_list))) =
      case adr_mode_list of
	[r_m8 _] => assemble_dec_type arg
      | [r_m16 _] => assemble_dec_type arg
      | [r_m32 _] => assemble_dec_type arg
      | _ => Crash.impossible"assemble_neg_not_type:bad operands"

    fun assemble_move(mnemonic_value, (opcode, adr_mode_list)) =
      let
	val (operand1, operand2) = case adr_mode_list of
	  [a, b] => (a, b)
	| _ => Crash.impossible"assemble_move:wrong number of operands"
	val (_, modr_m, sib, imm, needs_prefix) =
	  assemble_operands(opcode, operand1, operand2)
	val new_opcode = case (operand1, operand2) of
	  (r_m8 _, r8 _) => 8*16+8
	| (r_m16 _, r16 _) => 8*16+9
	| (r_m32 _, r32 _) => 8*16+9
	| (r8 _, r_m8 _) => 8*16+10
	| (r16 _, r_m16 _) => 8*16+11
	| (r32 _, r_m32 _) => 8*16+11
	| (r8 reg, _) => 11*16 + assemble_reg reg
	| (r16 reg, _) => 11*16 + 8 +assemble_reg reg
	| (r32 reg, _) => 11*16 + 8 +assemble_reg reg
	| (r_m8 _, _) => 12*16+6
	| (r_m16 _, _) => 12*16+7
	| (r_m32 _, _) => 12*16+7
	| _ => Crash.impossible"assemble_move:bad operands"
	val new_tail = sib @ imm
	val main_opcode = case (operand1, operand2) of
	  (r8 _, imm8 _) => new_opcode :: new_tail
	| (r16 _, imm16 _) => new_opcode :: new_tail
	| (r32 _, imm32 _) => new_opcode :: new_tail
	| _ => new_opcode :: modr_m :: new_tail
      in
	I386_Opcodes.OPCODE(if needs_prefix then operand_prefix :: main_opcode else main_opcode)
      end

    fun assemble_move_extend(mnemonic_value, (opcode, adr_mode_list)) =
      let
	val (operand1, operand2) = case adr_mode_list of
	  [a, b] =>
	    (case (a, b) of
	       arg as (r16 _, r_m8 _) => arg
	     | arg as (r32 _, r_m8 _) => arg
	     | arg as (r32 _, r_m16 _) => arg
	     | _ => Crash.impossible"assemble_move_extend:bad operands")
	| _ => Crash.impossible"assemble_move_extend:wrong number of operands"
	val (_, modr_m, sib, imm, needs_prefix) =
	  assemble_operands(opcode, operand1, operand2)
	val mnemonic_value = case (mnemonic_value, operand2) of
	  ([a, b], r_m16 _) => [a, b+1]
	| _ => mnemonic_value
	val main_opcode = mnemonic_value @ (modr_m :: sib @ imm)
      in
	I386_Opcodes.OPCODE(if needs_prefix then operand_prefix :: main_opcode else main_opcode)
      end

    fun assemble_shift_rotate_type(mnemonic_value, (opcode, adr_mode_list)) =
      let
	val (operand1, operand2) = case adr_mode_list of
	  [a, b] => (a, b)
	| _ => Crash.impossible"assemble_shift_rotate_type:wrong number of arguments"
	val (imm_type, imm1_type, cl_type, opc_inc) = case operand2 of
	  imm8 i =>
	    if i = 1 then
	      (false, true, false, 0)
	    else
	      (true, false, false, ~16)
	| r8 I386Types.CL => (false, false, true, 2)
	| _ => Crash.impossible"assemble_shift_rotate_type:bad operands"
	val imm =
	  if imm_type then
	    assemble_imm operand2
	  else
	    []
	val needs_prefix = case operand1 of
	  r_m16 _ => true
	| _ => false
	val opc_inc = opc_inc + (case operand1 of
				   r_m8 _ => 0
				 | _ => 1)
	val mnemonic_value = hd mnemonic_value + opc_inc
	val (_, reg) = get_modr_m_digit opcode
	val (modr_m, sib, disp) = assemble_r_m operand1
	val modr_m = modr_m + 8 * reg
	val main_opcode = mnemonic_value :: modr_m :: sib @ disp @ imm
      in

	I386_Opcodes.OPCODE(if needs_prefix then operand_prefix :: main_opcode else main_opcode)
      end

    fun assemble_double_shift(mnemonic_value, (opcode, adr_mode_list)) =
      let
	val ops as (operand1, operand2, operand3) = case adr_mode_list of
	  [a, b, c] => (a, b, c)
	| _ => Crash.impossible"assemble_double_shift:wrong number of arguments"
	val needs_prefix = case ops of
	  (r_m16 _, r16 _, _) => true
	| (r32 _, r_m32 _, _) => false
	| _ => Crash.impossible"assemble_double_shift:bad operands"
	val (opc_inc, imm) = case operand3 of
	  imm8 _ => (0, assemble_imm operand3)
	| r8 I386Types.CL => (1, [])
	| _ => Crash.impossible"assemble_double_shift:bad operands"
	val mnemonic_value = case mnemonic_value of
	  [a, b] => [a, b+opc_inc]
	| _ => mnemonic_value (* Shouldn't happen *)
	val (_, modr_m, sib, _, _) =
	  assemble_operands(opcode, operand1, operand2)
	val main_opcode = mnemonic_value @ (modr_m :: sib @ imm)
      in
	I386_Opcodes.OPCODE(if needs_prefix then operand_prefix :: main_opcode else main_opcode)
      end

    fun assemble_test_type(mnemonic_value, (opcode, adr_mode_list)) =
      let
	val (operand1, operand2) = case adr_mode_list of
	  [a, b] => (a, b)
	| _ => Crash.impossible("assemble:" ^ decode_mnemonic opcode ^
				":wrong number of arguments")
	val (opcode_offset, modr_m, sib, imm, needs_prefix) =
	  assemble_operands(opcode, operand1, operand2)
	val opcode = case (operand1, operand2) of
	  (r_m8 _, imm8 _) => f*16+6
	| (r_m16 _, imm16 _) => f*16+7
	| (r_m32 _, imm32 _) => f*16+7
	| (r_m8 _, r8 _) => 8*16+4
	| (r_m16 _, r16 _) => 8*16+5
	| (r_m32 _, r32 _) => 8*16+5
	| _ => Crash.impossible"assemble_test_type:bad operands"
	val tail = (hd mnemonic_value)+opcode_offset :: modr_m :: (sib @ imm)
      in
	I386_Opcodes.OPCODE(if needs_prefix then operand_prefix :: tail else tail)
      end

    fun assemble_fp_reg_op (mnemonic, adr_mode_list) =
      let
        val (first,second) =
          case mnemonic of
            fstp =>  (B101,B11011000)
          | fcom =>  (B000,B11010000)
          | fcomp => (B000,B11011000)
          | _=> Crash.impossible ("assemble_fp_reg_op: bad mnemonic: " ^ decode_mnemonic mnemonic)
        val reg =
          case adr_mode_list of
            [fp_reg r] =>
              if r >= 0 andalso r < 8 then r
              else Crash.impossible "assemble_fp_reg_op: bad register"
          | _ => Crash.impossible "assemble_fp_reg_op:bad adr_mode_list"
      in
        I386_Opcodes.OPCODE [esc + first, second + reg]
      end
    fun assemble_fp_mem_op (mnemonic, adr_mode_list) =
      let
        (* extn is single digit to go at end of first byte *)
        (* fun_code is for the middle of the second byte *)
        (* mf is memory format, if required *)
        val (mf,extn,fun_code) =
          case mnemonic of
            fld => (float_mf,1,0)
          | fild => (integer_mf,1,0)
          | fst => (float_mf,1,2)
          | fist => (integer_mf,1,2)
          | fstp => (float_mf,1,3)
          | fistp => (integer_mf,1,3)
          | fadd => (float_mf,0,0)
          | fsub => (float_mf,0,4)
          | fsubr => (float_mf,0,5)
          | fmul => (float_mf,0,1)
          | fdiv => (float_mf,0,6)
          | fdivr => (float_mf,0,7)
          | fcom => (float_mf,0,2)
          | fcomp => (float_mf,0,3)
          | fldcw => (0,1,B101)
          | fstcw => (0,1,B111)
          | fstsw => (2,1,B111)
          | _ => Crash.impossible ("assemble_fp_op: bad mnemonic: " ^ decode_mnemonic mnemonic)
      in
        case adr_mode_list of
          [operand] =>
            (* Single argument -- must be a memory reference *)
            let
              val (modr_m,sib,disp) =
                (* I guess we could have a m64f mode, or maybe not *)
                case operand of
                  fp_mem mem_operand => assemble_mem mem_operand
                | _ => Crash.impossible "assemble_fp_op: bad memory operand"
            in
              I386_Opcodes.OPCODE ((esc + (mf * 2) + extn) ::
                                   (modr_m + (8 * fun_code)) ::
                                   (sib @ disp))
            end
        | _ => Crash.impossible "assemble_fp_op: bad operands"
      end

    fun assemble_unary_fp_op mnemonic =
      let
        val (fun_code_1,fun_code_2) =
          (* These values should be lifted really *)
          case mnemonic of
            fabs => (B001,B00001)
          | fpatan => (B001,B10011)
          | fchs => (B001,B00000)
          | fcos => (B001,B11111)
          | fsin => (B001,B11110)
          | fsqrt => (B001,B11010)
          | fptan => (B001,B10010)
          | fldz => (B001,B01110)
          | fld1 => (B001,B01000)
          | fyl2x => (B001,B10001)
          | fyl2xp => (B001,B11001)
          | f2xm1 => (B001,B10000)
          | fxam => (B001,B00101)
          | ftst => (B001,B00100)
          | fstsw_ax => (B111,B00000)
          | fnclex => (B011,B00010)
          | _ => Crash.impossible "assemble_unary_fp_op: bad mnemonic"
      in
        I386_Opcodes.OPCODE [esc + fun_code_1,B1110_0000 + fun_code_2]
      end

    fun assemble_fp_op (mnemonic,adr_mode_list) =
      case adr_mode_list of
        [] => assemble_unary_fp_op mnemonic
      | [fp_mem _] => assemble_fp_mem_op (mnemonic,adr_mode_list)
      | [fp_reg _] => assemble_fp_reg_op (mnemonic,adr_mode_list)
      | _ => Crash.impossible "assemble_fp_op: adr_mode_list"
  in
    fun assemble(AugOPCODE(opcode,_)) = assemble opcode
      | assemble(OPCODE(opcode as (mnemonic, adr_mode_list))) =
      let
	val mnemonic_value = mnemonic_assemble mnemonic
	val arg = (mnemonic_value, opcode)
      in
	case mnemonic of
	  aaa => I386_Opcodes.OPCODE mnemonic_value
	| aad => I386_Opcodes.OPCODE mnemonic_value
	| aam => I386_Opcodes.OPCODE mnemonic_value
	| aas => I386_Opcodes.OPCODE mnemonic_value
	| adc => assemble_add_type arg
	| add => assemble_add_type arg
	| align => I386_Opcodes.OPCODE []
	| and_op => assemble_add_type arg
	| arpl => I386_Opcodes.OPCODE mnemonic_value
	| bound => I386_Opcodes.OPCODE mnemonic_value (* Wrong *)
	| bsf => assemble_bit_scan_type arg
	| bsr => assemble_bit_scan_type arg
	| bt => assemble_bit_test_type arg
	| btc => assemble_bit_test_type arg
	| btr => assemble_bit_test_type arg
	| bts => assemble_bit_test_type arg
	| call => assemble_call arg
	| cbw => I386_Opcodes.OPCODE(operand_prefix :: mnemonic_value)
	| cwde => I386_Opcodes.OPCODE mnemonic_value
	| clc => I386_Opcodes.OPCODE mnemonic_value
	| cld => I386_Opcodes.OPCODE mnemonic_value
	| cli => I386_Opcodes.OPCODE mnemonic_value
	| clts => I386_Opcodes.OPCODE mnemonic_value
	| cmc => I386_Opcodes.OPCODE mnemonic_value
	| cmp => assemble_add_type(mnemonic_value, opcode)
	| cmps => I386_Opcodes.OPCODE mnemonic_value
	| cmpsb => I386_Opcodes.OPCODE mnemonic_value
	| cmpsw => I386_Opcodes.OPCODE(operand_prefix :: mnemonic_value)
	| cmpsd => I386_Opcodes.OPCODE mnemonic_value
	| cwd => I386_Opcodes.OPCODE(operand_prefix :: mnemonic_value)
	| cdq => I386_Opcodes.OPCODE mnemonic_value
	| daa => I386_Opcodes.OPCODE mnemonic_value
	| das => I386_Opcodes.OPCODE mnemonic_value
	| dec => assemble_dec_type arg
	| div_op => assemble_div_type arg
	| enter =>
	    let
	      val (operand1, operand2) = case adr_mode_list of
		[a as imm16 _, b as imm8 _] => (a, b)
	      | _ => Crash.impossible"assemble:enter:wrong number of arguments"
	    in
	      I386_Opcodes.OPCODE(mnemonic_value @ assemble_imm operand1 @ assemble_imm operand2)
	    end
        (* Floating point *)
        | fld => assemble_fp_op opcode
        | fst => assemble_fp_op opcode
        | fstp => assemble_fp_op opcode
        | fild => assemble_fp_op opcode
        | fist => assemble_fp_op opcode
        | fistp => assemble_fp_op opcode
        | fadd => assemble_fp_op opcode
        | fsub => assemble_fp_op opcode
        | fsubr => assemble_fp_op opcode
        | fmul => assemble_fp_op opcode
        | fdiv => assemble_fp_op opcode
        | fdivr => assemble_fp_op opcode

        | fabs => assemble_fp_op opcode
        | fpatan => assemble_fp_op opcode
        | fchs => assemble_fp_op opcode
        | fcos => assemble_fp_op opcode
        | fsin => assemble_fp_op opcode
        | fsqrt => assemble_fp_op opcode
        | fptan => assemble_fp_op opcode
        | fldz => assemble_fp_op opcode
        | fld1 => assemble_fp_op opcode
        | fyl2x => assemble_fp_op opcode
        | fyl2xp => assemble_fp_op opcode
        | f2xm1 => assemble_fp_op opcode
        (* Comparisons & tests *)
        (* No integer comparisons for the moment *)
        | fcom => assemble_fp_op opcode
        | fcomp => assemble_fp_op opcode
        | fcompp => assemble_fp_op opcode
        (* These don't work yet as they don't have memory forms *)
        | fucom => Crash.impossible "assemble:fucom"
        | fucomp => Crash.impossible "assemble:fucomp"
        | fucompp => Crash.impossible "assemble:fucompp"
        | ftst => assemble_fp_op opcode
        | fxam => assemble_fp_op opcode
        (* Control *)
        | fldcw => assemble_fp_op opcode
        | fstcw => assemble_fp_op opcode
        | fnstcw => Crash.impossible "assemble:fnstcw"
        | fstsw => assemble_fp_op opcode
        | fstsw_ax => assemble_fp_op opcode
        | fnstsw => Crash.impossible "assemble:fnstsw"
        | fnclex => assemble_fp_op opcode

        (* End floating point *)

	| hlt => I386_Opcodes.OPCODE mnemonic_value
	| idiv => assemble_div_type arg
	| imul => assemble_imul arg
	| in_op => I386_Opcodes.OPCODE mnemonic_value
	| inc => assemble_dec_type arg
	| ins => I386_Opcodes.OPCODE mnemonic_value
	| insb => I386_Opcodes.OPCODE mnemonic_value
	| insw => I386_Opcodes.OPCODE mnemonic_value
	| insd => I386_Opcodes.OPCODE mnemonic_value
	| int => I386_Opcodes.OPCODE mnemonic_value
	| into => I386_Opcodes.OPCODE mnemonic_value
	| iret => I386_Opcodes.OPCODE mnemonic_value
	| iretd => I386_Opcodes.OPCODE mnemonic_value
	| jcc cc =>
	    (case adr_mode_list of
	       [operand] =>
		 let
		   val opc = hd mnemonic_value
		 in
		   case operand of
		     rel8 _ => I386_Opcodes.OPCODE(opc :: assemble_rel operand)
		   | rel16 _ => I386_Opcodes.OPCODE(operand_prefix :: 15 :: opc+16 :: assemble_rel operand)
		   | rel32 _ => I386_Opcodes.OPCODE(15 :: opc+16 :: assemble_rel operand)
		   | fix_rel32 _ => I386_Opcodes.OPCODE(15 :: opc+16 :: assemble_rel operand)
		   | _ => Crash.impossible"assemble:jcc:bad arguments"
		 end
	     | _ => Crash.impossible"assemble:jcc:wrong number of arguments")
	| jmp =>
	    (case adr_mode_list of
	       [operand] =>
		 let
		   val opc = hd mnemonic_value
		 in
		   case operand of
		     rel8 i => I386_Opcodes.OPCODE(opc :: assemble_rel operand)
		   | rel16 i => I386_Opcodes.OPCODE(operand_prefix :: opc-2 :: assemble_rel operand)
		   | rel32 i => I386_Opcodes.OPCODE(opc-2 :: assemble_rel operand)
		   | fix_rel32 i => I386_Opcodes.OPCODE(opc-2 :: assemble_rel operand)
		   | _ =>
		       let
			 val (modr_m, sib, disp) = assemble_r_m operand
			 val main_opcode = 255 :: modr_m+4*8 :: sib @ disp
		       in
			 case operand of
			   r_m16 _ => I386_Opcodes.OPCODE(operand_prefix :: main_opcode)
			 | r_m32 _ => I386_Opcodes.OPCODE main_opcode
			 | _ => Crash.impossible"assemble:jmp:bad operand"
		       end
		 end
	     | _ => Crash.impossible"assemble:jmp:wrong number of arguments")
	| lahf => I386_Opcodes.OPCODE mnemonic_value
	| lar => I386_Opcodes.OPCODE mnemonic_value
	| lea =>
	    let
	      val (operand1, operand2) = case adr_mode_list of
		[a, b] => (a, b)
	      | _ => Crash.impossible"assemble:lea:wrong number of arguments"
	      val (_, modr_m, sib, imm, needs_prefix) =
		assemble_operands(mnemonic, operand1, operand2)
	      val main_opcode = mnemonic_value @ (modr_m :: sib @ imm)
	    in
	      I386_Opcodes.OPCODE(if needs_prefix then operand_prefix :: main_opcode else main_opcode)
	    end
	| leave => I386_Opcodes.OPCODE mnemonic_value (* We don't want the 16 bit version *)
	| lgdt => I386_Opcodes.OPCODE mnemonic_value
	| lidt => I386_Opcodes.OPCODE mnemonic_value
	| lgs => I386_Opcodes.OPCODE mnemonic_value
	| lss => I386_Opcodes.OPCODE mnemonic_value
	| lds => I386_Opcodes.OPCODE mnemonic_value
	| les => I386_Opcodes.OPCODE mnemonic_value
	| lfs => I386_Opcodes.OPCODE mnemonic_value
	| lldt => I386_Opcodes.OPCODE mnemonic_value
	| lmsw => I386_Opcodes.OPCODE mnemonic_value
	| lock => I386_Opcodes.OPCODE mnemonic_value
	| lods => I386_Opcodes.OPCODE mnemonic_value
	| lodsb => I386_Opcodes.OPCODE mnemonic_value
	| lodsw => I386_Opcodes.OPCODE mnemonic_value
	| lodsd => I386_Opcodes.OPCODE mnemonic_value
	| loop => assemble_loop_opcode arg
	| loopz => assemble_loop_opcode arg
	| loopnz => assemble_loop_opcode arg
	| lsl => I386_Opcodes.OPCODE mnemonic_value
	| ltr => I386_Opcodes.OPCODE mnemonic_value
	| mov => assemble_move arg
	| movs => I386_Opcodes.OPCODE mnemonic_value
	| movsb => I386_Opcodes.OPCODE mnemonic_value
	| movsw => I386_Opcodes.OPCODE(operand_prefix :: mnemonic_value)
	| movsd => I386_Opcodes.OPCODE mnemonic_value
	| movsx => assemble_move_extend arg
	| movzx => assemble_move_extend arg
	| mul => assemble_div_type arg
	| neg => assemble_neg_not_type arg
	| nop => I386_Opcodes.OPCODE mnemonic_value
	| not => assemble_neg_not_type arg
	| or => assemble_add_type arg
	| out => I386_Opcodes.OPCODE mnemonic_value
	| outs => I386_Opcodes.OPCODE mnemonic_value
	| outsb => I386_Opcodes.OPCODE mnemonic_value
	| outsw => I386_Opcodes.OPCODE mnemonic_value
	| outsd => I386_Opcodes.OPCODE mnemonic_value
	| pop =>
	    let
	      val operand = case adr_mode_list of
		[a] => a
	      | _ => Crash.impossible"assemble:pop:wrong number of arguments"
	    in
	      case operand of
		r16 reg => I386_Opcodes.OPCODE([operand_prefix, 16*5+8+assemble_reg reg])
	      | r32 reg => I386_Opcodes.OPCODE([16*5+8+assemble_reg reg])
	      | r_m16 _ =>
		  let
		    val (modr_m, sib, disp) = assemble_r_m operand
		  in
		    I386_Opcodes.OPCODE(operand_prefix :: mnemonic_value @ (modr_m :: sib @ disp))
		  end
	      | r_m32 _ =>
		  let
		    val (modr_m, sib, disp) = assemble_r_m operand
		  in
		    I386_Opcodes.OPCODE(mnemonic_value @ (modr_m :: sib @ disp))
		  end
	      | _ => Crash.impossible"assemble:pop:bad operands"
	    end
	| popa => I386_Opcodes.OPCODE(operand_prefix :: mnemonic_value)
	| popad => I386_Opcodes.OPCODE mnemonic_value
	| popf => I386_Opcodes.OPCODE(operand_prefix :: mnemonic_value)
	| popfd => I386_Opcodes.OPCODE mnemonic_value
	| push =>
	    let
	      val operand = case adr_mode_list of
		[a] => a
	      | _ => Crash.impossible"assemble:push:wrong number of arguments"
	    in
	      case operand of
		r16 reg => I386_Opcodes.OPCODE([operand_prefix, 16*5+assemble_reg reg])
	      | r32 reg => I386_Opcodes.OPCODE([16*5+assemble_reg reg])
	      | imm8 _ => I386_Opcodes.OPCODE(16*6+10 :: assemble_imm operand)
	      | imm16 _ => I386_Opcodes.OPCODE(operand_prefix :: 16*6+8 :: assemble_imm operand)
	      | imm32 _ => I386_Opcodes.OPCODE(16*6+8 :: assemble_imm operand)
	      | r_m16 _ =>
		  let
		    val (modr_m, sib, disp) = assemble_r_m operand
		  in
		    I386_Opcodes.OPCODE(operand_prefix :: mnemonic_value @ (modr_m+6*8 :: sib @ disp))
		  end
	      | r_m32 _ =>
		  let
		    val (modr_m, sib, disp) = assemble_r_m operand
		  in
		    I386_Opcodes.OPCODE(mnemonic_value @ (modr_m+6*8 :: sib @ disp))
		  end
	      | _ => Crash.impossible"assemble:push:bad operands"
	    end
	| pusha => I386_Opcodes.OPCODE(operand_prefix :: mnemonic_value)
	| pushad => I386_Opcodes.OPCODE mnemonic_value
	| pushf => I386_Opcodes.OPCODE(operand_prefix ::  mnemonic_value)
	| pushfd => I386_Opcodes.OPCODE mnemonic_value
	| rcl => assemble_shift_rotate_type arg
	| rcr => assemble_shift_rotate_type arg
	| rol => assemble_shift_rotate_type arg
	| ror => assemble_shift_rotate_type arg
	| rep => I386_Opcodes.OPCODE mnemonic_value (* Wrong *)
	| repz => I386_Opcodes.OPCODE mnemonic_value (* Wrong *)
	| repnz => I386_Opcodes.OPCODE mnemonic_value (* Wrong *)
	| ret =>
	    (case adr_mode_list of
	       [] => I386_Opcodes.OPCODE mnemonic_value
	     | [operand as imm16 _] =>
		 I386_Opcodes.OPCODE(hd mnemonic_value - 1 :: assemble_imm operand)
	     | _ => Crash.impossible"assemble:ret:wrong number of or bad arguments")
	| sahf => I386_Opcodes.OPCODE mnemonic_value
	| sal => assemble_shift_rotate_type arg
	| sar => assemble_shift_rotate_type arg
	| shl => assemble_shift_rotate_type arg
	| shr => assemble_shift_rotate_type arg
	| sbb => assemble_add_type arg
	| scas => I386_Opcodes.OPCODE mnemonic_value
	| scasb => I386_Opcodes.OPCODE mnemonic_value
	| scasw => I386_Opcodes.OPCODE(operand_prefix :: mnemonic_value)
	| scasd => I386_Opcodes.OPCODE mnemonic_value
	| setcc cc => I386_Opcodes.OPCODE mnemonic_value
	| sgdt => I386_Opcodes.OPCODE mnemonic_value
	| sidt => I386_Opcodes.OPCODE mnemonic_value
	| shld => assemble_double_shift arg
	| shrd => assemble_double_shift arg
	| sldt => I386_Opcodes.OPCODE mnemonic_value
	| smsw => I386_Opcodes.OPCODE mnemonic_value
	| stc => I386_Opcodes.OPCODE mnemonic_value
	| std => I386_Opcodes.OPCODE mnemonic_value
	| sti => I386_Opcodes.OPCODE mnemonic_value
	| stos => I386_Opcodes.OPCODE mnemonic_value
	| stosb => I386_Opcodes.OPCODE mnemonic_value
	| stosw => I386_Opcodes.OPCODE(operand_prefix :: mnemonic_value)
	| stosd => I386_Opcodes.OPCODE mnemonic_value
	| str => I386_Opcodes.OPCODE mnemonic_value
	| sub => assemble_add_type arg
	| test =>
	    (case adr_mode_list of
	       [r_m8(INL I386Types.AL), imm8 _] => assemble_add_type arg
	     | [r_m16(INL I386Types.AX), imm16 _] => assemble_add_type arg
	     | [r_m32(INL I386Types.EAX), imm32 _] => assemble_add_type arg
	     | _ => assemble_test_type([8*16+8], opcode))
	(* Fake to make it look as though the test resembles other opcodes *)
	| verr => I386_Opcodes.OPCODE mnemonic_value
	| verw => I386_Opcodes.OPCODE mnemonic_value
	| wait => I386_Opcodes.OPCODE mnemonic_value
	| xchg =>
	    let
	      val (operand1, operand2) = case adr_mode_list of
		[a, b] => (a, b)
	      | _ => Crash.impossible"assemble:xchg:wrong number of operands"
	    in
	      case (operand1, operand2) of
		(r16 I386Types.AX, r16 reg) =>
		  I386_Opcodes.OPCODE([operand_prefix, 9*16 + assemble_reg reg])
	      | (r16 reg, r16 I386Types.AX) =>
		  I386_Opcodes.OPCODE([operand_prefix, 9*16 + assemble_reg reg])
	      | (r32 reg, r32 I386Types.EAX) =>
		  I386_Opcodes.OPCODE([9*16 + assemble_reg reg])
	      | (r32 I386Types.EAX, r32 reg) =>
		  I386_Opcodes.OPCODE([9*16 + assemble_reg reg])
	      | _ =>
		  let
		    val (_, modr_m, sib, imm, needs_prefix) =
		      assemble_operands(mnemonic, operand1, operand2)
		    val mnemonic_value = case (operand1, operand2) of
		      (_, r8 _) => 8*16+6
		    | _ => 8*16+7
		    val main_opcode = mnemonic_value :: modr_m :: sib @ imm
		  in
		    I386_Opcodes.OPCODE(if needs_prefix then operand_prefix :: main_opcode else main_opcode)
		  end
	    end
	| xlat => I386_Opcodes.OPCODE mnemonic_value
	| xlatb => I386_Opcodes.OPCODE mnemonic_value
	| xor => assemble_add_type arg
      end

  end

  fun mnemonic_size aaa = 1
    | mnemonic_size aad = 2
    | mnemonic_size aam = 2
    | mnemonic_size aas = 1
    | mnemonic_size adc = 1
    | mnemonic_size add = 1
    | mnemonic_size align = 0
    | mnemonic_size and_op = 1
    | mnemonic_size arpl = 1
    | mnemonic_size bound = 1
    | mnemonic_size bsf = 2
    | mnemonic_size bsr = 2
    | mnemonic_size bt = 2
    | mnemonic_size btc = 2
    | mnemonic_size btr = 2
    | mnemonic_size bts = 2
    | mnemonic_size call = 1
    | mnemonic_size cbw = 1
    | mnemonic_size cwde = 1
    | mnemonic_size clc = 1
    | mnemonic_size cld = 1
    | mnemonic_size cli = 1
    | mnemonic_size clts = 2
    | mnemonic_size cmc = 1
    | mnemonic_size cmp = 1
    | mnemonic_size cmps = 1
    | mnemonic_size cmpsb = 1
    | mnemonic_size cmpsw = 1
    | mnemonic_size cmpsd = 1
    | mnemonic_size cwd = 1
    | mnemonic_size cdq = 1
    | mnemonic_size daa = 1
    | mnemonic_size das = 1
    | mnemonic_size dec = 1
    | mnemonic_size div_op = 1
    | mnemonic_size enter = 1
    | mnemonic_size fld = 1
    | mnemonic_size fst = 1
    | mnemonic_size fstp = 1
    | mnemonic_size fild = 1
    | mnemonic_size fist = 1
    | mnemonic_size fistp = 1
    | mnemonic_size fadd = 1
    | mnemonic_size fsub = 1
    | mnemonic_size fsubr = 1
    | mnemonic_size fmul = 1
    | mnemonic_size fdiv = 1
    | mnemonic_size fdivr = 1
    | mnemonic_size fabs = 1
    | mnemonic_size fpatan = 1
    | mnemonic_size fchs = 1
    | mnemonic_size fcos = 1
    | mnemonic_size fsin = 1
    | mnemonic_size fsqrt = 1
    | mnemonic_size fptan = 1
    | mnemonic_size fldz = 1
    | mnemonic_size fld1 = 1
    | mnemonic_size fyl2x = 1
    | mnemonic_size fyl2xp = 1
    | mnemonic_size f2xm1 = 1
    | mnemonic_size fcom = 1
    | mnemonic_size fcomp = 1
    | mnemonic_size fcompp = 1
    | mnemonic_size fucom = Crash.impossible "assemble:fucom"
    | mnemonic_size fucomp = Crash.impossible "assemble:fucomp"
    | mnemonic_size fucompp = Crash.impossible "assemble:fucompp"
    | mnemonic_size ftst = 1
    | mnemonic_size fxam = 1
    | mnemonic_size fldcw = 1
    | mnemonic_size fstcw = 1
    | mnemonic_size fnstcw = Crash.impossible "assemble:fnstcw"
    | mnemonic_size fstsw = 1
    | mnemonic_size fstsw_ax = 1
    | mnemonic_size fnstsw = Crash.impossible "assemble:fnstsw"
    | mnemonic_size fnclex = 1
    | mnemonic_size hlt = 1
    | mnemonic_size idiv = 1
    | mnemonic_size imul = 1
    | mnemonic_size in_op = 1
    | mnemonic_size inc = 1
    | mnemonic_size ins = 1
    | mnemonic_size insb = 1
    | mnemonic_size insw = 1
    | mnemonic_size insd = 1
    | mnemonic_size int = 1
    | mnemonic_size into = 1
    | mnemonic_size iret = 1
    | mnemonic_size iretd = 1
    | mnemonic_size (jcc _) = 1
    | mnemonic_size jmp = 1
    | mnemonic_size lahf = 1
    | mnemonic_size lar = 2
    | mnemonic_size lea = 1
    | mnemonic_size leave = 1
    | mnemonic_size lgdt = 2
    | mnemonic_size lidt = 2
    | mnemonic_size lgs = 2
    | mnemonic_size lss = 2
    | mnemonic_size lds = 1
    | mnemonic_size les = 1
    | mnemonic_size lfs = 2
    | mnemonic_size lldt = 2
    | mnemonic_size lmsw = 2
    | mnemonic_size lock = 1
    | mnemonic_size lods = 1
    | mnemonic_size lodsb = 1
    | mnemonic_size lodsw = 1
    | mnemonic_size lodsd = 1
    | mnemonic_size loop = 1
    | mnemonic_size loopz = 1
    | mnemonic_size loopnz = 1
    | mnemonic_size lsl = 2
    | mnemonic_size ltr = 2
    | mnemonic_size mov = 1
    | mnemonic_size movs = 1
    | mnemonic_size movsb = 1
    | mnemonic_size movsw = 1
    | mnemonic_size movsd = 1
    | mnemonic_size movsx = 2
    | mnemonic_size movzx = 2
    | mnemonic_size mul = 1
    | mnemonic_size neg = 1
    | mnemonic_size nop = 1
    | mnemonic_size not = 1
    | mnemonic_size or = 1
    | mnemonic_size out = 1
    | mnemonic_size outs = 1
    | mnemonic_size outsb = 1
    | mnemonic_size outsw = 1
    | mnemonic_size outsd = 1
    | mnemonic_size pop = 1
    | mnemonic_size popa = 1
    | mnemonic_size popad = 1
    | mnemonic_size popf = 1
    | mnemonic_size popfd = 1
    | mnemonic_size push = 1
    | mnemonic_size pusha = 1
    | mnemonic_size pushad = 1
    | mnemonic_size pushf = 1
    | mnemonic_size pushfd = 1
    | mnemonic_size rcl = 1
    | mnemonic_size rcr = 1
    | mnemonic_size rol = 1
    | mnemonic_size ror = 1
    | mnemonic_size rep = 2
    | mnemonic_size repz = 2
    | mnemonic_size repnz = 2
    | mnemonic_size ret = 1
    | mnemonic_size sahf = 1
    | mnemonic_size sal = 1
    | mnemonic_size sar = 1
    | mnemonic_size shl = 1
    | mnemonic_size shr = 1
    | mnemonic_size sbb = 1
    | mnemonic_size scas = 1
    | mnemonic_size scasb = 1
    | mnemonic_size scasw = 1
    | mnemonic_size scasd = 1
    | mnemonic_size(setcc _) = 2
    | mnemonic_size sgdt = 2
    | mnemonic_size sidt = 2
    | mnemonic_size shld = 2
    | mnemonic_size shrd = 2
    | mnemonic_size sldt = 2
    | mnemonic_size smsw = 2
    | mnemonic_size stc = 1
    | mnemonic_size std = 1
    | mnemonic_size sti = 1
    | mnemonic_size stos = 1
    | mnemonic_size stosb = 1
    | mnemonic_size stosw = 1
    | mnemonic_size stosd = 1
    | mnemonic_size str = 2
    | mnemonic_size sub = 1
    | mnemonic_size test = 1
    | mnemonic_size verr = 2
    | mnemonic_size verw = 2
    | mnemonic_size wait = 1
    | mnemonic_size xchg = 1
    | mnemonic_size xlat = 1
    | mnemonic_size xlatb = 1
    | mnemonic_size xor = 1

  local
    fun size_char_signed _ = 1

    fun size_short_signed _ = 2

    fun size_int_signed _ = 4

    fun size_imm(imm8 i) = 1
      | size_imm(imm16 i) = 2
      | size_imm(imm32(i, j)) = 4
      | size_imm _ = Crash.impossible"size_imm: bad operand"

    fun size_rel(rel32 i) = size_int_signed i
      | size_rel(fix_rel32 i) = size_int_signed i
      | size_rel(rel16 i) = size_short_signed i
      | size_rel(rel8 i) = size_char_signed i
      | size_rel _ = Crash.impossible"size_rel:bad operand"

    fun size_mem(mem_operand as MEM{base, index, offset}) =
      let
	val needs_sib = needs_sib mem_operand
	val (base, index, offset) = transform_mem(base, index, offset)
	val disp = case offset of
	  NONE =>
	    (case base of
	       SOME I386Types.EBP => 1
	     | _ => 0)
	| SOME (SMALL i) =>
	       if i <= 127 andalso i >= ~128 then 1 else 4
	| SOME (LARGE(i, j)) =>
		 if i <= 31 andalso i >= ~32 then 1 else 4
      in
	(if needs_sib then 1 else 0, disp)
      end

    fun size_r_m(r_m8(INL reg)) = (0, 0)
      | size_r_m(r_m8(INR mem)) = size_mem mem
      | size_r_m(r_m16(INL reg)) = (0, 0)
      | size_r_m(r_m16(INR mem)) = size_mem mem (* Guess? *)
      | size_r_m(r_m32(INL reg)) = (0, 0)
      | size_r_m(r_m32(INR mem)) = size_mem mem
      | size_r_m _ = Crash.impossible "size_r_m:bad arg" 

    fun size_operands(opcode, operand1, operand2) =
      let
	val size_imm = case operand2 of
	  imm8 _ => 1
	| imm16 _ => 2
	| imm32 _ => 4
	| _ => 0
	val needs_prefix = case operand1 of
	  r_m16 _ => true
	| r16 _ => true
	| _ => false
	val (sib, disp) = case (operand1, operand2) of
	  (r_m8 _, _) => size_r_m operand1
	| (r_m16 _, _) => size_r_m operand1
	| (r_m32 _, _) => size_r_m operand1
	| (_, r_m8 _) => size_r_m operand2
	| (_, r_m16 _) => size_r_m operand2
	| (_, r_m32 _) => size_r_m operand2
	| _ => (0, 0)
      in
	(sib + disp, size_imm, needs_prefix)
      end

    fun size_add_type(mnemonic_size, (opcode, adr_mode_list)) =
      let
	val (operand1, operand2) = case adr_mode_list of
	  [a, b] => (a, b)
	| _ => Crash.impossible("size: wrong number of arguments")
	val easy_imm = case (operand1, operand2) of
	  (r_m8(INL I386Types.AL), imm8 _) => true
	| (r_m16(INL I386Types.AX), imm16 _) => true
	| (r_m32(INL I386Types.EAX), imm32 _) => true
	| _ => false
      in
	if easy_imm then
	  let
	    val tail = size_imm operand2
	  in
	    case operand2 of
	      imm8 _ => mnemonic_size + tail
	    | imm16 _ => 1 + 1 + tail
	    | _ => 1 + tail
	  end
	else
	  (* The two operand case *)
	  let
	    val (sib, imm, needs_prefix) =
	      size_operands(opcode, operand1, operand2)
	    val tail = 1 + 1 + sib + imm
	  in
	    if needs_prefix then 1 + tail else tail
	  end
      end

    fun size_bit_scan_type(mnemonic_size, (opcode, adr_mode_list)) =
      let
	val (operand1, operand2) = case adr_mode_list of
	  [a, b] => (a, b)
	| _ => Crash.impossible("size_bit_scan_type:wrong number of arguments")
	val (sib, _, needs_prefix) =
	  size_operands(opcode, operand1, operand2)
	val main_opcode = mnemonic_size + 1 + sib
      in
	if needs_prefix then 1 + main_opcode else main_opcode
      end

    fun size_bit_test_type(mnemonic_size, (opcode, adr_mode_list)) =
      let
	val (operand1, operand2) = case adr_mode_list of
	  [a, b] => (a, b)
	| _ => Crash.impossible("size_bit_test_type:wrong number of arguments")
	val (sib, imm, needs_prefix) =
	  size_operands(opcode, operand1, operand2)
	val main_opcode = mnemonic_size + 1 + sib + imm
      in
	if needs_prefix then 1 + main_opcode else main_opcode
      end

    fun size_call(mnemonic_size, (opcode, adr_mode_list)) =
      let
	val operand =
	  case adr_mode_list of
	    [a] => a
	  | _ => Crash.impossible"size_call:wrong number of arguments"
      in
	case operand of
	  rel32 _ => mnemonic_size + size_rel operand
	| fix_rel32 _ => mnemonic_size + size_rel operand
	| _ =>
	    let
	      val (sib, disp) = size_r_m operand
	    in
	      1 + 1 + sib + disp
	    end
      end

    fun size_dec_type(mnemonic_size, (opcode, adr_mode_list)) =
      let
	val operand = case adr_mode_list of
	  [a] => a
	| _ => Crash.impossible"size_dec_type:wrong number of arguments"
      in
	case operand of
	  r16 _ => 2
	| r32 _ => 1
	| _ =>
	    let
	      val (sib, disp) = size_r_m operand
	      val main_opcode = 1 + sib + disp
	    in
	      case operand of
		r_m8 _ => 1 + main_opcode
	      | r_m16 _ => 1 + 1 + main_opcode
	      | r_m32 _ => 1 + main_opcode
	      | _ => Crash.impossible"size_dec_type:bad operand"
	    end
      end

    fun size_div_type(mnemonic_size, (opcode, adr_mode_list)) =
      let
	val operand = case adr_mode_list of
	  [a] => a
	| _ => Crash.impossible"size_div_type:wrong number of arguments"
	val (sib, disp) = size_r_m operand
	val main_opcode = 1 + sib + disp
      in
	case operand of
	  r_m8 _ => 1 + main_opcode
	| r_m16 _ => 1 + 1 + main_opcode
	| r_m32 _ => 1 + main_opcode
	| _ => Crash.impossible"size_div_type:bad operand"
      end

    fun size_imul(full_arg as (mnemonic_size, (opcode, adr_mode_list))) =
      case adr_mode_list of
	[_] => size_div_type full_arg
      | [operand1, operand2] =>
	  (case operand2 of
	     r_m32 _ =>
	       let
		 val (sib, imm, needs_prefix) =
		   size_operands(opcode, operand1, operand2)
		 val main_opcode = 1 + 1 + 1 + sib + imm
	       in
		 if needs_prefix then 1 + main_opcode else main_opcode
	       end
	     | _ =>
		 (* This should be register * immediate *)
		 let
		   val imm = size_imm operand2
		   val main_opcode = 1 + 1 + imm
		 in
		   main_opcode
		 end)
      | [operand1, operand2, operand3] =>
	  let
	    val (sib, _, needs_prefix) =
	      size_operands(opcode, operand1, operand2)
	    val imm = size_imm operand3
	    val main_opcode = 1 + 1 + sib + imm
	  in
	    if needs_prefix then 1 + main_opcode else main_opcode
	  end
      | _ => Crash.impossible"size_imul:wrong number of arguments"

    fun size_loop_opcode(mnemonic_size, (opcode, adr_mode_list)) =
      let
	val operand = case adr_mode_list of
	  [operand] => operand
	| _ => Crash.impossible"size_loop_opcode:wrong number of arguments"
      in
	case operand of
	  rel8 _ => mnemonic_size + size_rel operand
	| _ => Crash.impossible"size_loop_opcode:bad operand"
      end

    fun size_neg_not_type(arg as (_, (_, adr_mode_list))) =
      case adr_mode_list of
	[r_m8 _] => size_dec_type arg
      | [r_m16 _] => size_dec_type arg
      | [r_m32 _] => size_dec_type arg
      | _ => Crash.impossible"size_neg_not_type:bad operands"

    fun size_move(mnemonic_size, (opcode, adr_mode_list)) =
      let
	val (operand1, operand2) = case adr_mode_list of
	  [a, b] => (a, b)
	| _ => Crash.impossible"size_move:wrong number of operands"
	val (sib, imm, needs_prefix) =
	  size_operands(opcode, operand1, operand2)
	val new_tail = sib + imm
	val main_opcode = case (operand1, operand2) of
	  (r8 _, imm8 _) => 1 + new_tail
	| (r16 _, imm16 _) => 1 + new_tail
	| (r32 _, imm32 _) => 1 + new_tail
	| _ => 1 + 1 + new_tail
      in
	if needs_prefix then 1 + main_opcode else main_opcode
      end

    fun size_move_extend(mnemonic_size, (opcode, adr_mode_list)) =
      let
	val (operand1, operand2) = case adr_mode_list of
	  [a, b] =>
	    (case (a, b) of
	       arg as (r16 _, r_m8 _) => arg
	     | arg as (r32 _, r_m8 _) => arg
	     | arg as (r32 _, r_m16 _) => arg
	     | _ => Crash.impossible"size_move_extend:bad operands")
	| _ => Crash.impossible"size_move_extend:wrong number of operands"
	val (sib, imm, needs_prefix) =
	  size_operands(opcode, operand1, operand2)
	val mnemonic_size = case (mnemonic_size, operand2) of
	  (2, r_m16 _) => 2
	| _ => mnemonic_size
	val main_opcode = mnemonic_size + 1 + sib + imm
      in
	if needs_prefix then 1 + main_opcode else main_opcode
      end

    fun size_shift_rotate_type(mnemonic_size, (opcode, adr_mode_list)) =
      let
	val (operand1, operand2) = case adr_mode_list of
	  [a, b] => (a, b)
	| _ => Crash.impossible"size_shift_rotate_type:wrong number of arguments"
	val imm_type = case operand2 of
	  imm8 i => if i = 1 then false else true
	| r8 I386Types.CL => false
	| _ => Crash.impossible"size_shift_rotate_type:bad operands"
	val imm = if imm_type then size_imm operand2 else 0
	val needs_prefix = case operand1 of
	  r_m16 _ => true
	| _ => false
	val mnemonic_size = 1
	val (sib, disp) = size_r_m operand1
	val main_opcode = 1 + 1 + sib + disp + imm
      in
	if needs_prefix then 1 + main_opcode else main_opcode
      end

    fun size_double_shift(mnemonic_size, (opcode, adr_mode_list)) =
      let
	val ops as (operand1, operand2, operand3) = case adr_mode_list of
	  [a, b, c] => (a, b, c)
	| _ => Crash.impossible"size_double_shift:wrong number of arguments"
	val needs_prefix = case ops of
	  (r_m16 _, r16 _, _) => true
	| (r32 _, r_m32 _, _) => false
	| _ => Crash.impossible"size_double_shift:bad operands"
	val imm = case operand3 of
	  imm8 _ => size_imm operand3
	| r8 I386Types.CL => 0
	| _ => Crash.impossible"size_double_shift:bad operands"
	val (sib, _, _) =
	  size_operands(opcode, operand1, operand2)
	val main_opcode = mnemonic_size + 1 + sib + imm
      in
	if needs_prefix then 1 + main_opcode else main_opcode
      end

    fun size_test_type(mnemonic_size, (opcode, adr_mode_list)) =
      let
	val (operand1, operand2) = case adr_mode_list of
	  [a, b] => (a, b)
	| _ => Crash.impossible("assemble:" ^ decode_mnemonic opcode ^
				":wrong number of arguments")
	val (sib, imm, needs_prefix) =
	  size_operands(opcode, operand1, operand2)
	val tail = 1 + 1 + sib + imm
      in
	if needs_prefix then 1 + tail else tail
      end

    fun size_fp_mem_op (mnemonic_size, adr_mode_list) =
      case adr_mode_list of
	[operand] =>
	  (* Single argument -- must be a memory reference *)
	  let
	    val (sib, disp) =
	      (* I guess we could have a m64f mode, or maybe not *)
	      case operand of
		fp_mem mem_operand => size_mem mem_operand
	      | _ => Crash.impossible "size_fp_op: bad memory operand"
	  in
	    1 + 1 + sib + disp
	  end
      | _ => Crash.impossible "size_fp_op: bad operands"

    fun size_fp_op (mnemonic,adr_mode_list) =
      case adr_mode_list of
        [] => 2
      | [fp_mem _] => size_fp_mem_op(mnemonic, adr_mode_list)
      | [fp_reg _] => 2
      | _ => Crash.impossible "size_fp_op: adr_mode_list"

  in
    fun assemble_size(AugOPCODE(opcode,_)) = assemble_size opcode
      | assemble_size(OPCODE(opcode as (mnemonic, adr_mode_list))) =
      let
	val mnemonic_size = mnemonic_size mnemonic
	val arg = (mnemonic_size, opcode)
      in
	case mnemonic of
	  aaa => mnemonic_size
	| aad => mnemonic_size
	| aam => mnemonic_size
	| aas => mnemonic_size
	| adc => size_add_type arg
	| add => size_add_type arg
	| align => 0
	| and_op => size_add_type arg
	| arpl => mnemonic_size
	| bound => mnemonic_size (* Wrong *)
	| bsf => size_bit_scan_type arg
	| bsr => size_bit_scan_type arg
	| bt => size_bit_test_type arg
	| btc => size_bit_test_type arg
	| btr => size_bit_test_type arg
	| bts => size_bit_test_type arg
	| call => size_call arg
	| cbw => 1 + mnemonic_size
	| cwde => mnemonic_size
	| clc => mnemonic_size
	| cld => mnemonic_size
	| cli => mnemonic_size
	| clts => mnemonic_size
	| cmc => mnemonic_size
	| cmp => size_add_type(mnemonic_size, opcode)
	| cmps => mnemonic_size
	| cmpsb => mnemonic_size
	| cmpsw => 1 + mnemonic_size
	| cmpsd => mnemonic_size
	| cwd => 1 + mnemonic_size
	| cdq => mnemonic_size
	| daa => mnemonic_size
	| das => mnemonic_size
	| dec => size_dec_type arg
	| div_op => size_div_type arg
	| enter =>
	    let
	      val (operand1, operand2) = case adr_mode_list of
		[a as imm16 _, b as imm8 _] => (a, b)
	      | _ => Crash.impossible"assemble:enter:wrong number of arguments"
	    in
	      mnemonic_size + size_imm operand1 + size_imm operand2
	    end
        (* Floating point *)
        | fld => size_fp_op opcode
        | fst => size_fp_op opcode
        | fstp => size_fp_op opcode
        | fild => size_fp_op opcode
        | fist => size_fp_op opcode
        | fistp => size_fp_op opcode
        | fadd => size_fp_op opcode
        | fsub => size_fp_op opcode
        | fsubr => size_fp_op opcode
        | fmul => size_fp_op opcode
        | fdiv => size_fp_op opcode
        | fdivr => size_fp_op opcode

        | fabs => size_fp_op opcode
        | fpatan => size_fp_op opcode
        | fchs => size_fp_op opcode
        | fcos => size_fp_op opcode
        | fsin => size_fp_op opcode
        | fsqrt => size_fp_op opcode
        | fptan => size_fp_op opcode
        | fldz => size_fp_op opcode
        | fld1 => size_fp_op opcode
        | fyl2x => size_fp_op opcode
        | fyl2xp => size_fp_op opcode
        | f2xm1 => size_fp_op opcode
        (* Comparisons & tests *)
        (* No integer comparisons for the moment *)
        | fcom => size_fp_op opcode
        | fcomp => size_fp_op opcode
        | fcompp => size_fp_op opcode
        (* These don't work yet as they don't have memory forms *)
        | fucom => Crash.impossible "assemble:fucom"
        | fucomp => Crash.impossible "assemble:fucomp"
        | fucompp => Crash.impossible "assemble:fucompp"
        | ftst => size_fp_op opcode
        | fxam => size_fp_op opcode
        (* Control *)
        | fldcw => size_fp_op opcode
        | fstcw => size_fp_op opcode
        | fnstcw => Crash.impossible "assemble:fnstcw"
        | fstsw => size_fp_op opcode
        | fstsw_ax => size_fp_op opcode
        | fnstsw => Crash.impossible "assemble:fnstsw"
        | fnclex => size_fp_op opcode

        (* End floating point *)

	| hlt => mnemonic_size
	| idiv => size_div_type arg
	| imul => size_imul arg
	| in_op => mnemonic_size
	| inc => size_dec_type arg
	| ins => mnemonic_size
	| insb => mnemonic_size
	| insw => mnemonic_size
	| insd => mnemonic_size
	| int => mnemonic_size
	| into => mnemonic_size
	| iret => mnemonic_size
	| iretd => mnemonic_size
	| jcc cc =>
	    (case adr_mode_list of
	       [operand] =>
		 (case operand of
		    rel8 _ => 1 + size_rel operand
		  | rel16 _ => 1 + 1 + 1 + size_rel operand
		  | rel32 _ => 1 + 1 + size_rel operand
		  | fix_rel32 _ => 1 + 1 + size_rel operand
		  | _ => Crash.impossible"assemble:jcc:bad arguments")
	     | _ => Crash.impossible"assemble:jcc:wrong number of arguments")
	| jmp =>
	    (case adr_mode_list of
	       [operand] =>
		 (case operand of
		    rel8 _ => 1 + size_rel operand
		  | rel16 _ => 1 + 1 + size_rel operand
		  | rel32 _ => 1 + size_rel operand
		  | fix_rel32 _ => 1 + size_rel operand
		  | _ =>
		      let
			val (sib, disp) = size_r_m operand
			val main_opcode = 1 + 1 + sib + disp
		      in
			case operand of
			  r_m16 _ => 1 + main_opcode
			| r_m32 _ => main_opcode
			| _ => Crash.impossible"assemble:jmp:bad operand"
		      end)
	     | _ => Crash.impossible"assemble:jmp:wrong number of arguments")
	| lahf => mnemonic_size
	| lar => mnemonic_size
	| lea =>
	    let
	      val (operand1, operand2) = case adr_mode_list of
		[a, b] => (a, b)
	      | _ => Crash.impossible"assemble:lea:wrong number of arguments"
	      val (sib, imm, needs_prefix) =
		size_operands(mnemonic, operand1, operand2)
	      val main_opcode = mnemonic_size + 1 + sib + imm
	    in
	      if needs_prefix then 1 + main_opcode else main_opcode
	    end
	| leave => mnemonic_size (* We don't want the 16 bit version *)
	| lgdt => mnemonic_size
	| lidt => mnemonic_size
	| lgs => mnemonic_size
	| lss => mnemonic_size
	| lds => mnemonic_size
	| les => mnemonic_size
	| lfs => mnemonic_size
	| lldt => mnemonic_size
	| lmsw => mnemonic_size
	| lock => mnemonic_size
	| lods => mnemonic_size
	| lodsb => mnemonic_size
	| lodsw => mnemonic_size
	| lodsd => mnemonic_size
	| loop => size_loop_opcode arg
	| loopz => size_loop_opcode arg
	| loopnz => size_loop_opcode arg
	| lsl => mnemonic_size
	| ltr => mnemonic_size
	| mov => size_move arg
	| movs => mnemonic_size
	| movsb => mnemonic_size
	| movsw => 1 + mnemonic_size
	| movsd => mnemonic_size
	| movsx => size_move_extend arg
	| movzx => size_move_extend arg
	| mul => size_div_type arg
	| neg => size_neg_not_type arg
	| nop => mnemonic_size
	| not => size_neg_not_type arg
	| or => size_add_type arg
	| out => mnemonic_size
	| outs => mnemonic_size
	| outsb => mnemonic_size
	| outsw => mnemonic_size
	| outsd => mnemonic_size
	| pop =>
	    let
	      val operand = case adr_mode_list of
		[a] => a
	      | _ => Crash.impossible"assemble:pop:wrong number of arguments"
	    in
	      case operand of
		r16 reg => 2
	      | r32 reg => 1
	      | r_m16 _ =>
		  let
		    val (sib, disp) = size_r_m operand
		  in
		    1 + mnemonic_size + 1 + sib + disp
		  end
	      | r_m32 _ =>
		  let
		    val (sib, disp) = size_r_m operand
		  in
		    1 + 1 + sib + disp
		  end
	      | _ => Crash.impossible"assemble:pop:bad operands"
	    end
	| popa => 1 + mnemonic_size
	| popad => mnemonic_size
	| popf => 1 + mnemonic_size
	| popfd => mnemonic_size
	| push =>
	    let
	      val operand = case adr_mode_list of
		[a] => a
	      | _ => Crash.impossible"assemble:push:wrong number of arguments"
	    in
	      case operand of
		r16 reg => 2
	      | r32 reg => 1
	      | imm8 _ => 2
	      | imm16 _ => 4
	      | imm32 _ => 5
	      | r_m16 _ =>
		  let
		    val (sib, disp) = size_r_m operand
		  in
		    1 + mnemonic_size + 1 + sib + disp
		  end
	      | r_m32 _ =>
		  let
		    val (sib, disp) = size_r_m operand
		  in
		    1 + 1 + sib + disp
		  end
	      | _ => Crash.impossible"assemble:push:bad operands"
	    end
	| pusha => 1 + mnemonic_size
	| pushad => mnemonic_size
	| pushf => 1 + mnemonic_size
	| pushfd => mnemonic_size
	| rcl => size_shift_rotate_type arg
	| rcr => size_shift_rotate_type arg
	| rol => size_shift_rotate_type arg
	| ror => size_shift_rotate_type arg
	| rep => mnemonic_size (* Wrong *)
	| repz => mnemonic_size (* Wrong *)
	| repnz => mnemonic_size (* Wrong *)
	| ret =>
	    (case adr_mode_list of
	       [] => mnemonic_size
	     | [operand as imm16 _] => 3
	     | _ => Crash.impossible"assemble:ret:wrong number of or bad arguments")
	| sahf => mnemonic_size
	| sal => size_shift_rotate_type arg
	| sar => size_shift_rotate_type arg
	| shl => size_shift_rotate_type arg
	| shr => size_shift_rotate_type arg
	| sbb => size_add_type arg
	| scas => mnemonic_size
	| scasb => mnemonic_size
	| scasw => 1 + mnemonic_size
	| scasd => mnemonic_size
	| setcc cc => mnemonic_size
	| sgdt => mnemonic_size
	| sidt => mnemonic_size
	| shld => size_double_shift arg
	| shrd => size_double_shift arg
	| sldt => mnemonic_size
	| smsw => mnemonic_size
	| stc => mnemonic_size
	| std => mnemonic_size
	| sti => mnemonic_size
	| stos => mnemonic_size
	| stosb => mnemonic_size
	| stosw => 1 + mnemonic_size
	| stosd => mnemonic_size
	| str => mnemonic_size
	| sub => size_add_type arg
	| test =>
	    (case adr_mode_list of
	       [r_m8(INL I386Types.AL), imm8 _] => size_add_type arg
	     | [r_m16(INL I386Types.AX), imm16 _] => size_add_type arg
	     | [r_m32(INL I386Types.EAX), imm32 _] => size_add_type arg
	     | _ => size_test_type([8*16+8], opcode))
	(* Fake to make it look as though the test resembles other opcodes *)
	| verr => mnemonic_size
	| verw => mnemonic_size
	| wait => mnemonic_size
	| xchg =>
	    let
	      val (operand1, operand2) = case adr_mode_list of
		[a, b] => (a, b)
	      | _ => Crash.impossible"assemble:xchg:wrong number of operands"
	    in
	      case (operand1, operand2) of
		(r16 I386Types.AX, r16 reg) => 2
	      | (r16 reg, r16 I386Types.AX) => 2
	      | (r32 reg, r32 I386Types.EAX) => 1
	      | (r32 I386Types.EAX, r32 reg) => 1
	      | _ =>
		  let
		    val (sib, imm, needs_prefix) =
		      size_operands(mnemonic, operand1, operand2)
		    val mnemonic_size = 1
		    val main_opcode = mnemonic_size + 1 + sib + imm
		  in
		    if needs_prefix then 1 + main_opcode else main_opcode
		  end
	    end
	| xlat => mnemonic_size
	| xlatb => mnemonic_size
	| xor => size_add_type arg
      end

  end

  fun opcode_size(AugOPCODE(opcode,_)) = assemble_size opcode
    | opcode_size(opcode as OPCODE(mnemonic, _)) = assemble_size opcode

  fun pad columns x = 
    if size x < columns then
      StringCvt.padRight #" " columns x
    else
      (* ensure at least one space *)
      x ^ " "
  local
    val opwidth = 9
  in
    val padit = pad opwidth
  end

  fun decode_mem_operand(MEM{base=base_opt, index=index_opt, offset=offset_opt}) =
    let
      val (base_opt, index_opt, offset_opt) = transform_mem(base_opt, index_opt, offset_opt)
      val base =
	case base_opt of
	  SOME reg => I386Types.reg_to_string reg
	| _ => ""
      val index = case index_opt of
	SOME(reg, i_opt) =>
	  I386Types.reg_to_string reg ^
	  (case i_opt of
	     SOME i => "*" ^ Int.toString i
	   | _ => "")
      | _ => ""
      val base_and_index = case (base_opt, index_opt) of
	(SOME _, SOME _) => "(" ^ base ^ "," ^ index ^ ")"
      | (NONE, NONE) => ""
      | _ => "(" ^ base ^ index ^ ")"
      val offset = case offset_opt of
	SOME(SMALL i) => Int.toString i
      | SOME (LARGE(i, j)) =>
	  let
	    val new_i = i div 25
	    val new_j = (i mod 25)*4 + j
	    val (new_i, new_j) =
	      if new_i < 0 andalso new_j <> 0 then
		(new_i+1, ~(100-new_j))
	      else
		(new_i, new_j)
	    val str1 = Int.toString new_i
	    val str2 = Int.toString new_j
	    val str1 = if str1 = "0" then "" else str1
	  in
	    str1 ^ str2
	  end
      | _ => ""
    in
      offset ^ base_and_index
    end

  fun decode_adr_mode(rel8 i) = "rel8 " ^ Int.toString i
    | decode_adr_mode(rel16 i) = "rel16 " ^ Int.toString i
    | decode_adr_mode(rel32 i) = "rel32 " ^ Int.toString i
    | decode_adr_mode(fix_rel32 i) = "rel32 " ^ Int.toString i
    | decode_adr_mode(ptr16_16(i, j)) =
      "ptr16:16(" ^ Int.toString i ^ ", " ^
      Int.toString j ^ ")"
    | decode_adr_mode(ptr16_32(i, j)) =
      "ptr16:32(" ^ Int.toString i ^ ", " ^
      Int.toString j ^ ")"
    | decode_adr_mode(r8 reg) =  I386Types.reg_to_string reg
    | decode_adr_mode(r16 reg) = I386Types.reg_to_string reg
    | decode_adr_mode(r32 reg) = I386Types.reg_to_string reg
    | decode_adr_mode(imm8 i) = "$" ^ Int.toString i
    | decode_adr_mode(imm16 i) = "$" ^ Int.toString i
    | decode_adr_mode(imm32(i, j)) =
      let
	val new_i = i div 25
	val new_j = (i mod 25)*4 + j
	(* Cope with cases of :- *)
	(* 1 -200 + 7 => -100 - 93 => (-100, 93) *)
	(* 2 -100 - 7 => 0 -93 => (0, -93) *)
	(* 3 (i >= 0, j >= 0) => (i, j) *)
	val (new_i, new_j) =
	  if new_i < 0 andalso new_j <> 0 then
	    let
	      val new_i = new_i+1
	      val new_j = ~(100-new_j)
	    in
	      if new_i < 0 then
		(new_i, abs new_j)
	      else
		(new_i, new_j)
	    end
	  else
	    (new_i, new_j)
	val str1 = Int.toString new_i
	val str2 = Int.toString new_j
	(* Cope with cases of *)
	(* 1 0, str => str *)
	(* 2 n, 0 <= str <= 9 => n0 str *)
	val str1 =
	  if str1 = "0" then
	    ""
	  else
	    if (size str2 <= 1) then str1 ^ "0" else str1
      in
	"$" ^ str1 ^ str2
      end
    | decode_adr_mode(r_m8 option) =
      (case option of
	 INL reg => I386Types.reg_to_string reg
       | INR mem => decode_mem_operand mem)
    | decode_adr_mode(r_m16 option) =
      (case option of
	 INL reg => I386Types.reg_to_string reg
       | INR mem => decode_mem_operand mem)
    | decode_adr_mode(r_m32 option) =
      (case option of
	 INL reg => I386Types.reg_to_string reg
       | INR mem => decode_mem_operand mem)
    | decode_adr_mode(m8 mem_operand) = "m8(" ^ decode_mem_operand mem_operand ^ ")"
    | decode_adr_mode(m16 mem_operand) = "m16(" ^ decode_mem_operand mem_operand ^ ")"
    | decode_adr_mode(m32 mem_operand) = "m32(" ^ decode_mem_operand mem_operand ^ ")"
    | decode_adr_mode(fp_mem mem_operand) = decode_mem_operand mem_operand
    | decode_adr_mode(fp_reg i) = "%ST(" ^ Int.toString i ^ ")"

  fun decode_adr_mode_list[] = []
    | decode_adr_mode_list[x] = [decode_adr_mode x]
    | decode_adr_mode_list(x :: y) = decode_adr_mode x :: ", " :: decode_adr_mode_list y

  val decode_adr_mode_list =
    fn list =>
    let
      val decoded = decode_adr_mode_list list
    in
      case decoded of
	(x :: ", " :: y) => y @ [", ", x]
      | x => x
    (* Modify to place the destination at the end as per gas *)
    end

  fun print_label (labmap,current,index) =
    Map.apply'(labmap,current+index)
    handle Map.Undefined => "<Undefined:" ^ Int.toString index ^ ">"

  fun is_imm(imm8 _) = true
    | is_imm(imm16 _) = true
    | is_imm(imm32 _) = true
    | is_imm _ = false

  fun has_imm [_] = false
    | has_imm adr_mode_list = Lists.exists is_imm adr_mode_list

  fun opcode_needs_size aaa = false
    | opcode_needs_size aad = false
    | opcode_needs_size aam = false
    | opcode_needs_size aas = false
    | opcode_needs_size adc = true
    | opcode_needs_size add = true
    | opcode_needs_size align = false
    | opcode_needs_size and_op = true
    | opcode_needs_size arpl = false
    | opcode_needs_size bound = true
    | opcode_needs_size bsf = true
    | opcode_needs_size bsr = true
    | opcode_needs_size bt = true
    | opcode_needs_size btc = true
    | opcode_needs_size btr = true
    | opcode_needs_size bts = false
    | opcode_needs_size call = false
    | opcode_needs_size cbw = false
    | opcode_needs_size cwde = false
    | opcode_needs_size clc = false
    | opcode_needs_size cld = false
    | opcode_needs_size cli = false
    | opcode_needs_size clts = false
    | opcode_needs_size cmc = false
    | opcode_needs_size cmp = true
    | opcode_needs_size cmps = false
    | opcode_needs_size cmpsb = false
    | opcode_needs_size cmpsw = false
    | opcode_needs_size cmpsd = false
    | opcode_needs_size cwd = false
    | opcode_needs_size cdq = false
    | opcode_needs_size daa = false
    | opcode_needs_size das = false
    | opcode_needs_size dec = true
    | opcode_needs_size div_op = true
    | opcode_needs_size enter = false
    | opcode_needs_size fld = false
    | opcode_needs_size fst = false
    | opcode_needs_size fstp = false
    | opcode_needs_size fild = false
    | opcode_needs_size fist = false
    | opcode_needs_size fistp = false
    | opcode_needs_size fadd = false
    | opcode_needs_size fsub = false
    | opcode_needs_size fsubr = false
    | opcode_needs_size fmul = false
    | opcode_needs_size fdiv = false
    | opcode_needs_size fdivr = false
    | opcode_needs_size fabs = false
    | opcode_needs_size fpatan = false
    | opcode_needs_size fchs = false
    | opcode_needs_size fcos = false
    | opcode_needs_size fsin = false
    | opcode_needs_size fsqrt = false
    | opcode_needs_size fptan = false
    | opcode_needs_size fldz = false
    | opcode_needs_size fld1 = false
    | opcode_needs_size fyl2x = false
    | opcode_needs_size fyl2xp = false
    | opcode_needs_size f2xm1 = false
    | opcode_needs_size fcom = false
    | opcode_needs_size fcomp = false
    | opcode_needs_size fcompp = false
    | opcode_needs_size fucom = false
    | opcode_needs_size fucomp = false
    | opcode_needs_size fucompp = false
    | opcode_needs_size ftst = false
    | opcode_needs_size fxam = false
    | opcode_needs_size fldcw = false
    | opcode_needs_size fstcw  = false
    | opcode_needs_size fnstcw = false
    | opcode_needs_size fstsw = false
    | opcode_needs_size fstsw_ax = false
    | opcode_needs_size fnstsw = false
    | opcode_needs_size fnclex = false
    | opcode_needs_size hlt = false
    | opcode_needs_size idiv = true
    | opcode_needs_size imul = true
    | opcode_needs_size in_op = false
    | opcode_needs_size inc = true
    | opcode_needs_size ins = false
    | opcode_needs_size insb = false
    | opcode_needs_size insw = false
    | opcode_needs_size insd = false
    | opcode_needs_size int = false
    | opcode_needs_size into = false
    | opcode_needs_size iret = false
    | opcode_needs_size iretd = false
    | opcode_needs_size(jcc _) = false
    | opcode_needs_size jmp = false
    | opcode_needs_size lahf = false
    | opcode_needs_size lar = true
    | opcode_needs_size lea = true
    | opcode_needs_size leave = false
    | opcode_needs_size lgdt = false
    | opcode_needs_size lidt = false
    | opcode_needs_size lgs = true
    | opcode_needs_size lss = true
    | opcode_needs_size lds = true
    | opcode_needs_size les = true
    | opcode_needs_size lfs = true
    | opcode_needs_size lldt = false
    | opcode_needs_size lmsw = false
    | opcode_needs_size lock = false
    | opcode_needs_size lods = false
    | opcode_needs_size lodsb = false
    | opcode_needs_size lodsw = false
    | opcode_needs_size lodsd = false
    | opcode_needs_size loop = false
    | opcode_needs_size loopz = false
    | opcode_needs_size loopnz = false
    | opcode_needs_size lsl = true
    | opcode_needs_size ltr = false
    | opcode_needs_size mov = true
    | opcode_needs_size movs = false
    | opcode_needs_size movsb = false
    | opcode_needs_size movsw = false
    | opcode_needs_size movsd = false
    | opcode_needs_size movsx = false
    | opcode_needs_size movzx = false
    | opcode_needs_size mul = true
    | opcode_needs_size neg = true
    | opcode_needs_size nop = false
    | opcode_needs_size not = true
    | opcode_needs_size or = true
    | opcode_needs_size out = false
    | opcode_needs_size outs = false
    | opcode_needs_size outsb = false
    | opcode_needs_size outsw = false
    | opcode_needs_size outsd = false
    | opcode_needs_size pop = true
    | opcode_needs_size popa = false
    | opcode_needs_size popad = false
    | opcode_needs_size popf = false
    | opcode_needs_size popfd = false
    | opcode_needs_size push = true
    | opcode_needs_size pusha = false
    | opcode_needs_size pushad = false
    | opcode_needs_size pushf = false
    | opcode_needs_size pushfd = false
    | opcode_needs_size rcl = true
    | opcode_needs_size rcr = true
    | opcode_needs_size rol = true
    | opcode_needs_size ror = true
    | opcode_needs_size rep = false
    | opcode_needs_size repz = false
    | opcode_needs_size repnz = false
    | opcode_needs_size ret = false
    | opcode_needs_size sahf = false
    | opcode_needs_size sal = true
    | opcode_needs_size sar = true
    | opcode_needs_size shl = true
    | opcode_needs_size shr = true
    | opcode_needs_size sbb = true
    | opcode_needs_size scas = false
    | opcode_needs_size scasb = false
    | opcode_needs_size scasw = false
    | opcode_needs_size scasd = false
    | opcode_needs_size(setcc _) = false
    | opcode_needs_size sgdt = false
    | opcode_needs_size sidt = false
    | opcode_needs_size shld = true
    | opcode_needs_size shrd = true
    | opcode_needs_size sldt = false
    | opcode_needs_size smsw = false
    | opcode_needs_size stc = false
    | opcode_needs_size std = false
    | opcode_needs_size sti = false
    | opcode_needs_size stos = false
    | opcode_needs_size stosb = false
    | opcode_needs_size stosw = false
    | opcode_needs_size stosd = false
    | opcode_needs_size str = false
    | opcode_needs_size sub = true
    | opcode_needs_size test = true
    | opcode_needs_size verr = false
    | opcode_needs_size verw = false
    | opcode_needs_size wait = false
    | opcode_needs_size xchg = false
    | opcode_needs_size xlat = false
    | opcode_needs_size xlatb = false
    | opcode_needs_size xor = true

  fun needs_size [r_m32(INR _)] = true
    | needs_size [r_m8(INR _)] = Crash.unimplemented"i386_assembly: needs_size: r_m8"
    | needs_size [r_m16(INR _)] = Crash.unimplemented"i386_assembly: needs_size: r_m16"
    | needs_size _ = false

  fun shift_needs_size(opc, [operand, _]) =
    (case opc of
       sal => true
     | sar => true
     | shl => true
     | shr => true
     | rcl => true
     | rcr => true
     | rol => true
     | ror => true
     | _ => false) andalso
       (case operand of r_m32(INR _) => true | _ => false)
    | shift_needs_size _ = false

  fun shift_by_1(opc, [_, operand as imm8 1]) =
    (case opc of
       sal => true
     | sar => true
     | shl => true
     | shr => true
     | rcl => true
     | rcr => true
     | rol => true
     | ror => true
     | _ => false)
    | shift_by_1 _ = false

  fun convert_shifts_by_1(arg as (opc, [op1, op2])) =
    if shift_by_1 arg then (opc, [op1]) else arg
    | convert_shifts_by_1 arg = arg

  fun reg_dest(r8 _) = true
    | reg_dest(r16 _) = true
    | reg_dest(r32 _) = true
    | reg_dest(r_m8(INL _)) = true
    | reg_dest(r_m16(INL _)) = true
    | reg_dest(r_m32(INL _)) = true
    | reg_dest _ = false

  fun reg_dest_list [] = false
    | reg_dest_list (x :: _) = reg_dest x

  fun lognot true = false
    | lognot false = true

  fun print'(AugOPCODE(opcode,_), n, labmap) = print'(opcode,n,labmap)
    | print'(opcode as OPCODE arg, n, labmap) =
    let
      val (mnemonic, adr_mode_list) = convert_shifts_by_1 arg
      val has_imm = has_imm adr_mode_list andalso lognot(reg_dest_list adr_mode_list)
      val needs_size = (has_imm orelse needs_size adr_mode_list orelse
			shift_needs_size(mnemonic, adr_mode_list)) andalso
	opcode_needs_size mnemonic
      val name = decode_mnemonic mnemonic
      val full_name = padit(if needs_size then name ^ "l" else name)
    in
      case adr_mode_list of
	[rel32 r] =>
	  full_name ^ print_label(labmap, n + opcode_size opcode, r)
      | [fix_rel32 r] =>
	  full_name ^ print_label(labmap, n + opcode_size opcode, r)
      | [rel8 r] =>
	  full_name ^ print_label(labmap, n + opcode_size opcode, r)
      | _ =>
	  concat(full_name :: decode_adr_mode_list adr_mode_list)
    end

  local
    open I386Types
  in
    fun reverse_branch(jcc above) = jcc below
      | reverse_branch(jcc above_or_equal) = jcc below_or_equal
      | reverse_branch(jcc below) = jcc above
      | reverse_branch(jcc below_or_equal) = jcc above_or_equal
      | reverse_branch(jcc equal) = jcc equal
      | reverse_branch(jcc greater) = jcc less
      | reverse_branch(jcc greater_or_equal) = jcc less_or_equal
      | reverse_branch(jcc less) = jcc greater
      | reverse_branch(jcc less_or_equal) = jcc greater_or_equal
      | reverse_branch(jcc not_equal) = jcc not_equal
      | reverse_branch(jcc cx_equal_zero) =
	Crash.impossible"reverse_branch jcc cx_equal_zero"
      | reverse_branch(jcc ecx_equal_zero) =
	Crash.impossible"reverse_branch jcc ecx_equal_zero"
      | reverse_branch(jcc not_overflow) =
	Crash.impossible"reverse_branch jcc not_overflow"
      | reverse_branch(jcc not_parity) =
	Crash.impossible"reverse_branch jcc not_parity"
      | reverse_branch(jcc not_sign) =
	Crash.impossible"reverse_branch jcc not_sign"
      | reverse_branch(jcc overflow) =
	Crash.impossible"reverse_branch jcc overflow"
      | reverse_branch(jcc parity) =
	Crash.impossible"reverse_branch jcc parity"
      | reverse_branch(jcc sign) =
	Crash.impossible"reverse_branch jcc sign"
      | reverse_branch _ = Crash.impossible"reverse_branch:not a branch"

  end

  fun reg_uses_of_mem{base, index, offset} =
    let
      val set = case base of
	SOME reg => Set.singleton(I386Types.full_reg_name reg)
      | _ => Set.empty_set
    in
      case index of
	SOME(reg, _) => Set.add_member(I386Types.full_reg_name reg, set)
      | _ => set
    end

  fun uses_of_mem x =
    let
      val set = reg_uses_of_mem x
    in
      Set.add_member
      (if Set.is_member(I386Types.ESP, set) then I386Types.stack else I386Types.heap, set)
    end

  fun uses(rel8 _) = Set.empty_set
    | uses(rel16 _) = Set.empty_set
    | uses(rel32 _) = Set.empty_set
    | uses(fix_rel32 _) = Set.empty_set
    | uses(ptr16_16 _) = Set.empty_set
    | uses(ptr16_32 _) = Set.empty_set
    | uses(r8 reg) = Set.singleton(I386Types.full_reg_name reg)
    | uses(r16 reg) = Set.singleton(I386Types.full_reg_name reg)
    | uses(r32 reg) = Set.singleton(I386Types.full_reg_name reg)
    | uses(imm8 _) = Set.empty_set
    | uses(imm16 _) = Set.empty_set
    | uses(imm32 _) = Set.empty_set
    | uses(r_m8 option) =
      (case option of
	 INL reg => Set.singleton(I386Types.full_reg_name reg)
       | INR(MEM mem) => uses_of_mem mem)
    | uses(r_m16 option) =
      (case option of
	 INL reg => Set.singleton(I386Types.full_reg_name reg)
       | INR(MEM mem) => uses_of_mem mem)
    | uses(r_m32 option) =
      (case option of
	 INL reg => Set.singleton(I386Types.full_reg_name reg)
       | INR(MEM mem) => uses_of_mem mem)
    | uses(m8(MEM mem)) = uses_of_mem mem
    | uses(m16(MEM mem)) = uses_of_mem mem
    | uses(m32(MEM mem)) = uses_of_mem mem
    | uses(fp_mem(MEM mem)) = uses_of_mem mem
    | uses(fp_reg _) = Set.empty_set

  fun reg_uses(rel8 _) = Set.empty_set
    | reg_uses(rel16 _) = Set.empty_set
    | reg_uses(rel32 _) = Set.empty_set
    | reg_uses(fix_rel32 _) = Set.empty_set
    | reg_uses(ptr16_16 _) = Set.empty_set
    | reg_uses(ptr16_32 _) = Set.empty_set
    | reg_uses(r8 reg) = Set.singleton(I386Types.full_reg_name reg)
    | reg_uses(r16 reg) = Set.singleton(I386Types.full_reg_name reg)
    | reg_uses(r32 reg) = Set.singleton(I386Types.full_reg_name reg)
    | reg_uses(imm8 _) = Set.empty_set
    | reg_uses(imm16 _) = Set.empty_set
    | reg_uses(imm32 _) = Set.empty_set
    | reg_uses(r_m8 option) =
      (case option of
	 INL reg => Set.singleton(I386Types.full_reg_name reg)
       | INR(MEM mem) => reg_uses_of_mem mem)
    | reg_uses(r_m16 option) =
      (case option of
	 INL reg => Set.singleton(I386Types.full_reg_name reg)
       | INR(MEM mem) => reg_uses_of_mem mem)
    | reg_uses(r_m32 option) =
      (case option of
	 INL reg => Set.singleton(I386Types.full_reg_name reg)
       | INR(MEM mem) => reg_uses_of_mem mem)
    | reg_uses(m8(MEM mem)) = reg_uses_of_mem mem
    | reg_uses(m16(MEM mem)) = reg_uses_of_mem mem
    | reg_uses(m32(MEM mem)) = reg_uses_of_mem mem
    | reg_uses(fp_mem(MEM mem)) = reg_uses_of_mem mem
    | reg_uses(fp_reg _) = Set.empty_set

  fun defines_of_mem mem =
    let
      val set = uses_of_mem mem
    in
      Set.singleton
      (if Set.is_member(I386Types.ESP, set) then I386Types.stack else I386Types.heap)
    end

  fun defines(rel8 _) = Set.empty_set
    | defines(rel16 _) = Set.empty_set
    | defines(rel32 _) = Set.empty_set
    | defines(fix_rel32 _) = Set.empty_set
    | defines(ptr16_16 _) = Set.singleton I386Types.heap
    | defines(ptr16_32 _) = Set.singleton I386Types.heap
    | defines(r8 reg) = Set.singleton(I386Types.full_reg_name reg)
    | defines(r16 reg) = Set.singleton(I386Types.full_reg_name reg)
    | defines(r32 reg) = Set.singleton(I386Types.full_reg_name reg)
    | defines(imm8 _) = Set.empty_set
    | defines(imm16 _) = Set.empty_set
    | defines(imm32 _) = Set.empty_set
    | defines(r_m8 option) =
      (case option of
	 INL reg => Set.singleton(I386Types.full_reg_name reg)
       | INR(MEM mem) => defines_of_mem mem)
    | defines(r_m16 option) =
      (case option of
	 INL reg => Set.singleton(I386Types.full_reg_name reg)
       | INR(MEM mem) => defines_of_mem mem)
    | defines(r_m32 option) =
      (case option of
	 INL reg => Set.singleton(I386Types.full_reg_name reg)
       | INR(MEM mem) => defines_of_mem mem)
    | defines(m8(MEM mem)) = defines_of_mem mem
    | defines(m16(MEM mem)) = defines_of_mem mem
    | defines(m32(MEM mem)) = defines_of_mem mem
    | defines(fp_mem(MEM mem)) = defines_of_mem mem
    | defines(fp_reg _) = Set.empty_set

  fun defines_and_uses(AugOPCODE(opcode,_)) = defines_and_uses opcode
    | defines_and_uses(OPCODE(aaa, args)) =
    (Set.list_to_set[I386Types.cond, I386Types.EAX],
     Set.singleton(I386Types.EAX))
    | defines_and_uses(OPCODE(aad, args)) =
      (Set.list_to_set[I386Types.cond, I386Types.EAX],
       Set.singleton(I386Types.EAX))
    | defines_and_uses(OPCODE(aam, args)) =
      (Set.list_to_set[I386Types.cond, I386Types.EAX],
       Set.singleton(I386Types.EAX))
    | defines_and_uses(OPCODE(aas, args)) =
      (Set.list_to_set[I386Types.cond, I386Types.EAX],
       Set.singleton(I386Types.EAX))
    | defines_and_uses(OPCODE(adc, [a, b])) =
      (Set.add_member(I386Types.cond, defines a), Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(add, [a, b])) =
      (Set.add_member(I386Types.cond, defines a), Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(align, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(and_op, [a, b])) =
      (Set.add_member(I386Types.cond, defines a), Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(arpl, args)) =
      Crash.impossible"defines_and_uses:arpl"
    | defines_and_uses(OPCODE(bound, args)) =
      Crash.impossible"defines_and_uses:bound"
    | defines_and_uses(OPCODE(bsf, [a, b])) =
      (Set.add_member(I386Types.cond, defines a), uses b)
    | defines_and_uses(OPCODE(bsr, [a, b])) =
      (Set.add_member(I386Types.cond, defines a), uses b)
    | defines_and_uses(OPCODE(bt, [a, b])) =
      (Set.singleton I386Types.cond, Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(btc, [a, b])) =
      (Set.add_member(I386Types.cond, defines a), Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(btr, [a, b])) =
      (Set.add_member(I386Types.cond, defines a), Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(bts, [a, b])) =
      (Set.add_member(I386Types.cond, defines a), Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(call, [a])) =
       (Set.list_to_set[I386Types.caller_closure, I386Types.caller_arg],
	Set.union(Set.list_to_set[I386Types.caller_closure,
				  I386Types.caller_arg,
				  I386Types.sp],
		  uses a))
    | defines_and_uses(OPCODE(cbw, args)) =
      (Set.singleton I386Types.EAX,Set.singleton I386Types.EAX)
    | defines_and_uses(OPCODE(cwde, args)) =
      (Set.singleton I386Types.EAX,Set.singleton I386Types.EAX)
    | defines_and_uses(OPCODE(clc, args)) =
      (Set.singleton I386Types.cond, Set.empty_set)
    | defines_and_uses(OPCODE(cld, args)) =
      (Set.singleton I386Types.cond, Set.empty_set)
    | defines_and_uses(OPCODE(cli, args)) =
      (Set.singleton I386Types.cond, Set.empty_set)
    | defines_and_uses(OPCODE(clts, args)) =
      Crash.impossible"defines_and_uses:clts"
    | defines_and_uses(OPCODE(cmc, args)) =
      (Set.singleton I386Types.cond, Set.singleton I386Types.cond)
    | defines_and_uses(OPCODE(cmp, [a, b])) =
      (Set.singleton(I386Types.cond), Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(cmps, args)) =
      (Set.singleton I386Types.cond, Set.list_to_set[I386Types.ESI, I386Types.EDI])
    | defines_and_uses(OPCODE(cmpsb, args)) =
      (Set.singleton I386Types.cond, Set.list_to_set[I386Types.ESI, I386Types.EDI])
    | defines_and_uses(OPCODE(cmpsw, args)) =
      (Set.singleton I386Types.cond, Set.list_to_set[I386Types.ESI, I386Types.EDI])
    | defines_and_uses(OPCODE(cmpsd, args)) =
      (Set.singleton I386Types.cond, Set.list_to_set[I386Types.ESI, I386Types.EDI])
    | defines_and_uses(OPCODE(cwd, args)) =
      (Set.list_to_set[I386Types.EAX, I386Types.EDX], Set.singleton I386Types.EAX)
    | defines_and_uses(OPCODE(cdq, args)) =
      (Set.list_to_set[I386Types.EAX, I386Types.EDX], Set.singleton I386Types.EAX)
    | defines_and_uses(OPCODE(daa, args)) =
      (Set.list_to_set[I386Types.cond, I386Types.EAX],
       Set.singleton(I386Types.EAX))
    | defines_and_uses(OPCODE(das, args)) =
      (Set.list_to_set[I386Types.cond, I386Types.EAX],
       Set.singleton(I386Types.EAX))
    | defines_and_uses(OPCODE(dec, [a])) =
      (Set.add_member(I386Types.cond, defines a), uses a)
    | defines_and_uses(OPCODE(div_op, args)) =
      Crash.unimplemented"defines_and_uses:dec"
    | defines_and_uses(OPCODE(enter, args)) =
      (Set.list_to_set[I386Types.ESP, I386Types.EBP, I386Types.stack],
       Set.list_to_set[I386Types.ESP, I386Types.EBP])
    | defines_and_uses(OPCODE(hlt, args)) =
      (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(idiv, args)) =
      Crash.unimplemented"defines_and_uses:idiv"
    | defines_and_uses(OPCODE(imul, args)) =
      (case args of
	 [arg1] => (Set.list_to_set[I386Types.cond, I386Types.EAX, I386Types.EDX],
		    Set.union(Set.list_to_set[I386Types.EAX, I386Types.EDX],
			      uses arg1))
       | [arg1, arg2] =>
	   (Set.add_member(I386Types.cond, defines arg1),
	    Set.union(uses arg1, uses arg2))
       | [arg1, arg2, _] =>
	   (* Third argument can only be constant *)
	   (Set.add_member(I386Types.cond, defines arg1), uses arg2)
       | _ => Crash.impossible
	   ("defines_and_uses:unknown operation or arguments: imul")
	   )
    | defines_and_uses(OPCODE(in_op, args)) =
      Crash.impossible"defines_and_uses:in_op"
    | defines_and_uses(OPCODE(inc, [a])) =
      (Set.add_member(I386Types.cond, defines a), uses a)
    | defines_and_uses(OPCODE(ins, args)) =
      Crash.impossible"defines_and_uses:ins"
    | defines_and_uses(OPCODE(insb, args)) =
      Crash.impossible"defines_and_uses:insb"
    | defines_and_uses(OPCODE(insw, args)) =
      Crash.impossible"defines_and_uses:insw"
    | defines_and_uses(OPCODE(insd, args)) =
      Crash.impossible"defines_and_uses:insd"
    | defines_and_uses(OPCODE(int, args)) =
      Crash.impossible"defines_and_uses:int"
    | defines_and_uses(OPCODE(into, args)) =
      Crash.impossible"defines_and_uses:into"
    | defines_and_uses(OPCODE(iret, args)) =
      Crash.impossible"defines_and_uses:iret"
    | defines_and_uses(OPCODE(iretd, args)) =
      Crash.impossible"defines_and_uses:iretd"
    | defines_and_uses(OPCODE(jcc cond, args)) =
      (Set.empty_set,
       case cond of
	 cx_equal_zero => Set.singleton I386Types.ECX
       | ecx_equal_zero => Set.singleton I386Types.ECX
       | _ => Set.singleton I386Types.cond)
    | defines_and_uses(OPCODE(jmp, [a])) =
      (Set.empty_set, uses a)
    | defines_and_uses(OPCODE(lahf, args)) =
      Crash.impossible"defines_and_uses:lahf"
    | defines_and_uses(OPCODE(lar, args)) =
      Crash.impossible"defines_and_uses:lar"
    | defines_and_uses(OPCODE(lea, [a, b])) =
      (defines a, reg_uses b)
    | defines_and_uses(OPCODE(leave, args)) =
      Crash.impossible"defines_and_uses:leave"
    | defines_and_uses(OPCODE(lgdt, args)) =
      Crash.impossible"defines_and_uses:lgdt"
    | defines_and_uses(OPCODE(lidt, args)) =
      Crash.impossible"defines_and_uses:lidt"
    | defines_and_uses(OPCODE(lgs, args)) =
      Crash.impossible"defines_and_uses:lgs"
    | defines_and_uses(OPCODE(lss, args)) =
      Crash.impossible"defines_and_uses:lss"
    | defines_and_uses(OPCODE(lds, args)) =
      Crash.impossible"defines_and_uses:lds"
    | defines_and_uses(OPCODE(les, args)) =
      Crash.impossible"defines_and_uses:les"
    | defines_and_uses(OPCODE(lfs, args)) =
      Crash.impossible"defines_and_uses:lfs"
    | defines_and_uses(OPCODE(lldt, args)) =
      Crash.impossible"defines_and_uses:lldt"
    | defines_and_uses(OPCODE(lmsw, args)) =
      Crash.impossible"defines_and_uses:lmsw"
    | defines_and_uses(OPCODE(lock, args)) =
      Crash.impossible"defines_and_uses:lock"
    | defines_and_uses(OPCODE(lods, args)) =
      (Set.list_to_set[I386Types.ESI, I386Types.EAX],
       Set.list_to_set[I386Types.ESI, I386Types.cond, I386Types.heap])
    | defines_and_uses(OPCODE(lodsb, args)) =
      (Set.list_to_set[I386Types.ESI, I386Types.EAX],
       Set.list_to_set[I386Types.ESI, I386Types.cond, I386Types.heap])
    | defines_and_uses(OPCODE(lodsw, args)) =
      (Set.list_to_set[I386Types.ESI, I386Types.EAX],
       Set.list_to_set[I386Types.ESI, I386Types.cond, I386Types.heap])
    | defines_and_uses(OPCODE(lodsd, args)) =
      (Set.list_to_set[I386Types.ESI, I386Types.EAX],
       Set.list_to_set[I386Types.ESI, I386Types.cond, I386Types.heap])
    | defines_and_uses(OPCODE(loop, args)) =
      (Set.singleton I386Types.ECX, Set.singleton I386Types.ECX)
    | defines_and_uses(OPCODE(loopz, args)) =
      (Set.list_to_set[I386Types.cond, I386Types.ECX], Set.singleton I386Types.ECX)
    | defines_and_uses(OPCODE(loopnz, args)) =
      (Set.list_to_set[I386Types.cond, I386Types.ECX], Set.singleton I386Types.ECX)
    | defines_and_uses(OPCODE(lsl, args)) =
      Crash.impossible"defines_and_uses:lsl"
    | defines_and_uses(OPCODE(ltr, args)) =
      Crash.impossible"defines_and_uses:ltr"
    | defines_and_uses(OPCODE(mov, [a, b])) =
      (defines a, Set.union(reg_uses a, uses b))
    | defines_and_uses(OPCODE(movs, args)) =
      (Set.list_to_set[I386Types.EDI, I386Types.ESI, I386Types.heap],
       Set.list_to_set[I386Types.EDI, I386Types.ESI, I386Types.heap])
    | defines_and_uses(OPCODE(movsb, args)) =
      (Set.list_to_set[I386Types.EDI, I386Types.ESI, I386Types.heap],
       Set.list_to_set[I386Types.EDI, I386Types.ESI, I386Types.heap])
    | defines_and_uses(OPCODE(movsw, args)) =
      (Set.list_to_set[I386Types.EDI, I386Types.ESI, I386Types.heap],
       Set.list_to_set[I386Types.EDI, I386Types.ESI, I386Types.heap])
    | defines_and_uses(OPCODE(movsd, args)) =
      (Set.list_to_set[I386Types.EDI, I386Types.ESI, I386Types.heap],
       Set.list_to_set[I386Types.EDI, I386Types.ESI, I386Types.heap])
    | defines_and_uses(OPCODE(movsx, [a, b])) =
      (defines a, uses b)
    | defines_and_uses(OPCODE(movzx, [a, b])) =
      (defines a, uses b)
    | defines_and_uses(OPCODE(mul, args)) =
      Crash.unimplemented"defines_and_uses:mul"
    | defines_and_uses(OPCODE(neg, [a])) =
      (defines a, uses a)
    | defines_and_uses(OPCODE(nop, args)) =
      (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(not, [a])) =
      (defines a, uses a)
    | defines_and_uses(OPCODE(or, [a, b])) =
      (Set.add_member(I386Types.cond, defines a), Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(out, args)) =
      Crash.impossible"defines_and_uses:out"
    | defines_and_uses(OPCODE(outs, args)) =
      Crash.impossible"defines_and_uses:outs"
    | defines_and_uses(OPCODE(outsb, args)) =
      Crash.impossible"defines_and_uses:outsb"
    | defines_and_uses(OPCODE(outsw, args)) =
      Crash.impossible"defines_and_uses:outsw"
    | defines_and_uses(OPCODE(outsd, args)) =
      Crash.impossible"defines_and_uses:outsd"
    | defines_and_uses(OPCODE(pop, [a])) =
      (Set.add_member(I386Types.ESP, defines a), Set.singleton I386Types.ESP)
    | defines_and_uses(OPCODE(popa, args)) =
      (Set.list_to_set[I386Types.ESP, I386Types.EBP, I386Types.ESI, I386Types.EDI,
		       I386Types.EAX, I386Types.EBX, I386Types.ECX, I386Types.EDX],
       Set.singleton I386Types.ESP)
    | defines_and_uses(OPCODE(popad, args)) =
      (Set.list_to_set[I386Types.ESP, I386Types.EBP, I386Types.ESI, I386Types.EDI,
		       I386Types.EAX, I386Types.EBX, I386Types.ECX, I386Types.EDX],
       Set.singleton I386Types.ESP)
    | defines_and_uses(OPCODE(popf, args)) =
      (Set.list_to_set[I386Types.ESP, I386Types.cond], Set.singleton I386Types.ESP)
    | defines_and_uses(OPCODE(popfd, args)) =
      (Set.list_to_set[I386Types.ESP, I386Types.cond], Set.singleton I386Types.ESP)
    | defines_and_uses(OPCODE(push, [a])) =
      (Set.singleton I386Types.ESP, Set.add_member(I386Types.ESP, uses a))
    | defines_and_uses(OPCODE(pusha, args)) =
      (Set.singleton I386Types.ESP,
       Set.list_to_set[I386Types.ESP, I386Types.EBP, I386Types.ESI, I386Types.EDI,
		       I386Types.EAX, I386Types.EBX, I386Types.ECX, I386Types.EDX])
    | defines_and_uses(OPCODE(pushad, args)) =
      (Set.singleton I386Types.ESP,
       Set.list_to_set[I386Types.ESP, I386Types.EBP, I386Types.ESI, I386Types.EDI,
		       I386Types.EAX, I386Types.EBX, I386Types.ECX, I386Types.EDX])
    | defines_and_uses(OPCODE(pushf, args)) =
      (Set.singleton I386Types.ESP, Set.list_to_set[I386Types.ESP, I386Types.cond])
    | defines_and_uses(OPCODE(pushfd, args)) =
      (Set.singleton I386Types.ESP, Set.list_to_set[I386Types.ESP, I386Types.cond])
    | defines_and_uses(OPCODE(rcl, [a, b])) =
      (defines a, Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(rcr, [a, b])) =
      (defines a, Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(rol, [a, b])) =
      (defines a, Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(ror, [a, b])) =
      (defines a, Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(rep, args)) =
      Crash.impossible"defines_and_uses:rep"
    | defines_and_uses(OPCODE(repz, args)) =
      Crash.impossible"defines_and_uses:rep"
    | defines_and_uses(OPCODE(repnz, args)) =
      Crash.impossible"defines_and_uses:rep"
    | defines_and_uses(OPCODE(ret, args)) =
      (Set.singleton I386Types.ESP, Set.list_to_set[I386Types.caller_arg, I386Types.ESP])
    | defines_and_uses(OPCODE(sahf, args)) =
      (Set.singleton I386Types.cond, Set.singleton I386Types.EAX)
    | defines_and_uses(OPCODE(sal, [a, b])) =
      (defines a, Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(sar, [a, b])) =
      (defines a, Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(shl, [a, b])) =
      (defines a, Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(shr, [a, b])) =
      (defines a, Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(sbb, [a, b])) =
      (Set.add_member(I386Types.cond, defines a), Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(scas, args)) =
      (Set.singleton I386Types.EDI, Set.list_to_set[I386Types.EAX, I386Types.EDI])
    | defines_and_uses(OPCODE(scasb, args)) =
      (Set.singleton I386Types.EDI,
       Set.list_to_set[I386Types.EAX, I386Types.EDI, I386Types.cond])
    | defines_and_uses(OPCODE(scasw, args)) =
      (Set.singleton I386Types.EDI,
       Set.list_to_set[I386Types.EAX, I386Types.EDI, I386Types.cond])
    | defines_and_uses(OPCODE(scasd, args)) =
      (Set.singleton I386Types.EDI,
       Set.list_to_set[I386Types.EAX, I386Types.EDI, I386Types.cond])
    | defines_and_uses(OPCODE(setcc _, [a])) =
      (Set.singleton I386Types.cond, uses a)
    | defines_and_uses(OPCODE(sgdt, args)) =
      Crash.impossible"defines_and_uses:sgdt"
    | defines_and_uses(OPCODE(sidt, args)) =
      Crash.impossible"defines_and_uses:sgdt"
    | defines_and_uses(OPCODE(shld, [a, b, c])) =
      (Set.add_member(I386Types.cond, defines a),
       Set.union(uses a, Set.union(uses b, uses c)))
    | defines_and_uses(OPCODE(shrd, [a, b, c])) =
      (Set.add_member(I386Types.cond, defines a),
       Set.union(uses a, Set.union(uses b, uses c)))
    | defines_and_uses(OPCODE(sldt, args)) =
      Crash.impossible"defines_and_uses:sldt"
    | defines_and_uses(OPCODE(smsw, args)) =
      Crash.impossible"defines_and_uses:smsw"
    | defines_and_uses(OPCODE(stc, args)) =
      (Set.singleton I386Types.cond, Set.empty_set)
    | defines_and_uses(OPCODE(std, args)) =
      (Set.singleton I386Types.cond, Set.empty_set)
    | defines_and_uses(OPCODE(sti, args)) =
      (Set.singleton I386Types.cond, Set.empty_set)
    | defines_and_uses(OPCODE(stos, args)) =
      (Set.list_to_set[I386Types.EDI, I386Types.heap],
       Set.list_to_set[I386Types.EDI, I386Types.EAX, I386Types.cond])
    | defines_and_uses(OPCODE(stosb, args)) =
      (Set.list_to_set[I386Types.EDI, I386Types.heap],
       Set.list_to_set[I386Types.EDI, I386Types.EAX, I386Types.cond])
    | defines_and_uses(OPCODE(stosw, args)) =
      (Set.list_to_set[I386Types.EDI, I386Types.heap],
       Set.list_to_set[I386Types.EDI, I386Types.EAX, I386Types.cond])
    | defines_and_uses(OPCODE(stosd, args)) =
      (Set.list_to_set[I386Types.EDI, I386Types.heap],
       Set.list_to_set[I386Types.EDI, I386Types.EAX, I386Types.cond])
    | defines_and_uses(OPCODE(str, args)) =
      Crash.impossible"defines_and_uses:str"
    | defines_and_uses(OPCODE(sub, [a, b])) =
      (Set.add_member(I386Types.cond, defines a), Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(test, [a, b])) =
      (Set.singleton I386Types.cond, Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(verr, args)) =
      Crash.impossible"defines_and_uses:verr"
    | defines_and_uses(OPCODE(verw, args)) =
      Crash.impossible"defines_and_uses:verw"
    | defines_and_uses(OPCODE(wait, args)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(xchg, [a, b])) =
      (Set.union(defines a, defines b), Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(xlat, args)) =
      Crash.impossible"defines_and_uses:xlat"
    | defines_and_uses(OPCODE(xlatb, args)) =
      Crash.impossible"defines_and_uses:xlat"
    | defines_and_uses(OPCODE(xor, [a, b])) =
      (Set.add_member(I386Types.cond, defines a), Set.union(uses a, uses b))
    | defines_and_uses(OPCODE(fld, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fst, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fstp, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fild, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fist, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fistp, _)) = (Set.empty_set, Set.empty_set)
    (* Binary ops *)
    | defines_and_uses(OPCODE(fadd, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fsub, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fsubr, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fmul, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fdiv, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fdivr, _)) = (Set.empty_set, Set.empty_set)
    (* Unary ops *)
    | defines_and_uses(OPCODE(fabs, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fpatan, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fchs, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fcos, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fsin, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fsqrt, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fptan, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fldz, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fld1, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fyl2x, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fyl2xp, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(f2xm1, _)) = (Set.empty_set, Set.empty_set)
    (* Comparisons & tests *)
    (* No integer comparisons for the moment *)
    | defines_and_uses(OPCODE(fcom, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fcomp, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fcompp, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fucom, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fucomp, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fucompp, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(ftst, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fxam, _)) = (Set.empty_set, Set.empty_set)
    (* Control *)
    | defines_and_uses(OPCODE(fldcw, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fstcw , _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fnstcw, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fstsw, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fstsw_ax, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fnstsw, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(fnclex, _)) = (Set.empty_set, Set.empty_set)
    | defines_and_uses(OPCODE(opcode, args)) =
      Crash.impossible
      ("defines_and_uses:unknown operation or arguments:" ^ print_mnemonic opcode)

  val defines_and_uses =
    fn x =>
    let
      val (defs, uses) = defines_and_uses x
    in
      (defs, uses, Set.empty_set, Set.empty_set) (* fp not handled here yet *)
    end

  fun inverse_branch _ = Crash.unimplemented "I386_Assembly.inverse_branch"

  local
    fun add_branch(offset:int, size, (n,labs)) =
      (n+size, (offset+n+size)::labs)
  in
    fun get_lab(w,AugOPCODE(opcode,_)) = get_lab (w,opcode)
      | get_lab(w as (n, labs), opcode as OPCODE(call, adr_mode_list)) =
      let
	val (i, make_label) = case adr_mode_list of
	  rel16 i :: _ => (i, true)
	| rel32 i :: _ => (i, true)
	| fix_rel32 i :: _ => (i, true)
	| _ => (0, false)
      in
	if make_label then
	  add_branch(i, opcode_size opcode, w)
	else
	  (n+opcode_size opcode, labs)
      end
      | get_lab(w as (n, labs), opcode as OPCODE(jmp, adr_mode_list)) =
	let
	  val (i, make_label) = case adr_mode_list of
	    rel8 i :: _ => (i, true)
	  | rel16 i :: _ => (i, true)
	  | rel32 i :: _ => (i, true)
	  | fix_rel32 i :: _ => (i, true)
	  | _ => (0, false)
	in
	  if make_label then
	    add_branch(i, opcode_size opcode, w)
	  else
	    (n+opcode_size opcode, labs)
	end
      | get_lab(w as (n, labs), opcode as OPCODE(jcc _, adr_mode_list)) =
	let
	  val (i, make_label) = case adr_mode_list of
	    rel8 i :: _ => (i, true)
	  | rel16 i :: _ => (i, true)
	  | rel32 i :: _ => (i, true)
	  | fix_rel32 i :: _ => (i, true)
	  | _ => (0, false)
	in
	  if make_label then
	    add_branch(i, opcode_size opcode, w)
	  else
	    (n+opcode_size opcode, labs)
	end
      | get_lab(w as (n, labs), opcode as OPCODE(loop, adr_mode_list)) =
	let
	  val (i, make_label) = case adr_mode_list of
	    rel8 i :: _ => (i, true)
	  | _ => (0, false)
	in
	  if make_label then
	    add_branch(i, opcode_size opcode, w)
	  else
	    (n+opcode_size opcode, labs)
	end
      | get_lab(w as (n, labs), opcode as OPCODE(loopz, adr_mode_list)) =
	let
	  val (i, make_label) = case adr_mode_list of
	    rel8 i :: _ => (i, true)
	  | _ => (0, false)
	in
	  if make_label then
	    add_branch(i, opcode_size opcode, w)
	  else
	    (n+opcode_size opcode, labs)
	end
      | get_lab(w as (n, labs), opcode as OPCODE(loopnz, adr_mode_list)) =
	let
	  val (i, make_label) = case adr_mode_list of
	    rel8 i :: _ => (i, true)
	  | _ => (0, false)
	in
	  if make_label then
	    add_branch(i, opcode_size opcode, w)
	  else
	    (n+opcode_size opcode, labs)
	end
      | get_lab((n, labs), opcode) = (n+opcode_size opcode, labs)
  end

  fun make_labmap_from_list l =
    let
      fun remove_duplicates ([],acc) = acc
        | remove_duplicates ([a],acc) = a::acc
        | remove_duplicates (a::(rest as (b :: c)),acc) =
          if a = b 
            then remove_duplicates (a::c,acc)
          else remove_duplicates (rest,a::acc)
      val sorted = rev (remove_duplicates (Lists.qsort (op <) l,[]))
      fun print_label i =
        "L" ^ Int.toString i
      val (labmap,_) =
        Lists.reducel
        (fn ((map,n),m) => (Map.define (map,m,print_label n),n+1))
        ((Map.empty,0),sorted)
    in
      labmap
    end

  fun double_align n = ((n+7) div 8) * 8

  (* The diddling with +- 2 is to cope with backptr slots *)
  (* Now +- 8, because we're working in bytes *)
  fun make_labmap codelistlist =
    let
      val (_,lablist) =
        Lists.reducel
        (fn ((n,label_list_so_far),codelist) => 
         (
	  Lists.reducel
	  (* This reduce goes over a set of mutually recursive procedures *)
          (fn ((n,label_list_so_far),code) =>
	   (* Inner reduce goes over one procedure *)
	   ((*output(std_out, "Calculating labels for proc, starting at offset " ^
		   Int.toString (double_align n + 8) ^ "\n");*)
	    
	   Lists.reducel get_lab ((double_align n + 8,label_list_so_far), code)))
          ((double_align n,label_list_so_far),codelist)
	  )
	 )
        ((0,[]),codelistlist)
    in
      make_labmap_from_list lablist
    end

  fun print_label (labmap,current,index) =
    Map.apply'(labmap,current+index)
    handle Map.Undefined => "<Undefined:" ^ Int.toString index ^ ">"

  fun labprint (args as (opc,n,labmap)) =
    let
      val line = print' args
      val size = opcode_size opc
    in
      case Map.tryApply' (labmap,n) of
        SOME s => if size <> 0 then (s ^ ":",line) else ("", line)
      | _ => ("",line)
    end

  fun print opcode =
    #2 (labprint (opcode,0,Map.empty))

  val nop_code = OPCODE(nop, [])

  val other_nop_code = OPCODE(cmc, [])

  val no_op = (OPCODE(nop, []), NONE, "no-op")
end
