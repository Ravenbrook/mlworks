(* _sparc_opcodes.sml the functor *)
(*
$Log: _sparc_opcodes.sml,v $
Revision 1.12  1997/01/17 13:18:26  matthew
Multiply instructions

 * Revision 1.11  1996/05/17  09:43:59  matthew
 * Moved Bits to MLWorks.Internal
 *
 * Revision 1.10  1995/03/17  13:25:18  matthew
 * Replacing implode with implode_char
 *
Revision 1.9  1994/09/12  13:37:39  matthew
Replaced ^ by implodes.  This is because the new optimizer can't do hat optimizations yet.

Revision 1.8  1993/01/15  12:37:51  jont
Split store into three areas of heap, stack and nil vector for scheduling improvement

Revision 1.7  1992/08/26  14:53:53  richard
Changed MLWorks.Bits to Bits to improve performance under
New Jersey.

Revision 1.6  1992/08/19  19:06:09  jont
Changed most of the multiplies, divides and mods into bit operations

Revision 1.5  1992/08/18  19:09:27  jont
Improved implementation of output_opcode

Revision 1.4  1991/10/28  11:59:04  jont
Added store register for detection of load/store interaction

Revision 1.3  91/10/24  13:29:45  jont
Fixed inexhaustive match

Revision 1.2  91/10/21  10:43:57  jont
Fixed coding of larger integers

Revision 1.1  91/09/26  09:58:29  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/crash";
require "machtypes";
require "sparc_opcodes";

functor Sparc_Opcodes(
  structure Crash : CRASH
  structure MachTypes : MACHTYPES
) : SPARC_OPCODES =
struct
  structure MachTypes = MachTypes

  structure Bits = MLWorks.Internal.Bits

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

  fun register_val MachTypes.I0 = 24
  | register_val MachTypes.I1 = 25
  | register_val MachTypes.I2 = 26
  | register_val MachTypes.I3 = 27
  | register_val MachTypes.I4 = 28
  | register_val MachTypes.I5 = 29
  | register_val MachTypes.I6 = 30
  | register_val MachTypes.I7 = 31
  | register_val MachTypes.L0 = 16
  | register_val MachTypes.L1 = 17
  | register_val MachTypes.L2 = 18
  | register_val MachTypes.L3 = 19
  | register_val MachTypes.L4 = 20
  | register_val MachTypes.L5 = 21
  | register_val MachTypes.L6 = 22
  | register_val MachTypes.L7 = 23
  | register_val MachTypes.O0 = 8
  | register_val MachTypes.O1 = 9
  | register_val MachTypes.O2 = 10
  | register_val MachTypes.O3 = 11
  | register_val MachTypes.O4 = 12
  | register_val MachTypes.O5 = 13
  | register_val MachTypes.O6 = 14
  | register_val MachTypes.O7 = 15
  | register_val MachTypes.G0 = 0
  | register_val MachTypes.G1 = 1
  | register_val MachTypes.G2 = 2
  | register_val MachTypes.G3 = 3
  | register_val MachTypes.G4 = 4
  | register_val MachTypes.G5 = 5
  | register_val MachTypes.G6 = 6
  | register_val MachTypes.G7 = 7
  | register_val MachTypes.cond = Crash.impossible"register_val cond"
  | register_val MachTypes.heap = Crash.impossible"register_val heap"
  | register_val MachTypes.stack = Crash.impossible"register_val stack"
  | register_val MachTypes.y_reg = Crash.impossible"register_val y_reg"
  | register_val MachTypes.nil_v = Crash.impossible"register_val nil_v"

  fun bool_val false = 0
  | bool_val true = 1

  fun make_list(bytes, value, acc) =
    if bytes <= 0 then acc
    else
      make_list(bytes-1, value div 256, (value mod 256) :: acc)

  fun output_int(bytes, value) =
    make_list(bytes, value, [])

  val implode_char = MLWorks.String.implode_char

  fun output_opcode(FORMAT1 disp30) =
    let
      val top = Bits.andb(Bits.rshift(disp30, 24), 63)
      val bottom3 = Bits.andb(disp30, (256*256*256)-1)
    in
      implode_char((64 + top) :: output_int(3, bottom3))
    end
  | output_opcode(FORMAT2A(rd, op2, imm22)) =
    let
      val top = Bits.andb(Bits.rshift(imm22, 16), 63)
      val bottom2 = Bits.andb(imm22, (256*256)-1)
    in
      implode_char
      ((Bits.lshift(register_val rd, 1) + op2 div 4) ::
       (Bits.lshift((op2 mod 4), 6) + top) ::
       output_int(2, bottom2))
    end
  | output_opcode(FORMAT2B(a, cond, op2, disp22)) =
    let
      val top = Bits.andb(Bits.rshift(disp22, 16), 63)
      val bottom2 = Bits.andb(disp22, (256*256)-1)
    in
      implode_char
      ((Bits.lshift(bool_val a, 5) + Bits.lshift(cond, 1) +
	   op2 div 4) ::
       (Bits.lshift((op2 mod 4), 6) + top) ::
       output_int(2, bottom2))
    end
  | output_opcode(FORMAT3A(op1, rd, op3, rs1, i, asi, rs2)) =
    implode_char [(Bits.lshift(op1, 6) +
                 Bits.lshift(register_val rd, 1) + op3 div 32),
             (Bits.lshift((op3 mod 32), 3) + register_val rs1 div 4),
             (Bits.lshift(register_val rs1 mod 4, 6) +
                 Bits.lshift(bool_val i, 5) + asi div 8),
             (Bits.lshift(asi mod 8, 5) + register_val rs2)]
  | output_opcode(FORMAT3B(op1, rd, op3, rs1, i, simm13)) =
    let
      val top = Bits.andb(Bits.rshift(simm13, 8), 31)
      val bottom = Bits.andb(simm13, 256-1)
    in
      implode_char [(Bits.lshift(op1, 6) +
                   Bits.lshift(register_val rd, 1) + op3 div 32),
               (Bits.lshift(op3 mod 32, 3) + register_val rs1 div 4),
               (Bits.lshift(register_val rs1 mod 4, 6) +
                   Bits.lshift(bool_val i, 5) + top),
                bottom]
    end
  | output_opcode(FORMAT3C(op1, rd, op3, rs1, opf, rs2)) =
    implode_char [(Bits.lshift(op1, 6) +
                 Bits.lshift(register_val rd, 1) + op3 div 32),
                  (Bits.lshift(op3 mod 32, 3) + register_val rs1 div 4),
                  (Bits.lshift(register_val rs1 mod 4, 6) + opf div 8),
                  (Bits.lshift(opf mod 8, 5) + register_val rs2)]

end
