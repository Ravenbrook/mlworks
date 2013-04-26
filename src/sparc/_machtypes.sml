(* _machtypes.sml the functor *)
(*
$Log: _machtypes.sml,v $
Revision 1.41  1997/09/19 08:29:22  brucem
[Bug #30153]
Remove references to Old.

 * Revision 1.40  1997/01/17  13:07:40  matthew
 * Adding y register
 *
 * Revision 1.39  1996/10/29  18:09:38  io
 * moving String from toplevel
 *
 * Revision 1.38  1996/04/30  16:18:36  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.37  1995/08/14  11:28:16  jont
 * Add bits_per_word, remove max and min integer s and words
 *
Revision 1.36  1995/07/25  10:31:12  jont
Add largest_word machine limit

Revision 1.35  1994/08/08  11:00:31  matthew
Added *_arg_regs, removed *_arg2

Revision 1.34  1994/07/25  10:44:58  matthew
Added extra argument register

Revision 1.33  1994/03/23  15:17:30  matthew
Proper names for registers

Revision 1.31  1994/03/08  18:14:01  jont
Remove module type to separate file

Revision 1.30  1993/07/14  11:12:37  jont
Fixed maximum and minimum integer sizes for lambda optimiser

Revision 1.29  1993/03/18  10:08:35  jont
Added leaf and offsets lists into WORDSET

Revision 1.28  1993/03/11  11:07:13  matthew
Added type Module

Revision 1.27  1993/03/01  14:27:46  matthew
Added MLVALUEs

Revision 1.26  1993/02/03  15:34:53  jont
Changes for code vector reform.

Revision 1.25  1993/01/15  12:29:42  jont
Split store into three areas of heap, stack and nil vector for scheduling improvement

Revision 1.24  1992/09/15  10:56:24  clive
Checked and corrected the specification for the floating point registers

Revision 1.23  1992/06/18  11:01:06  jont
Added furhter constructors to the module element type to express
interpretive stuff

Revision 1.22  1992/01/13  14:19:26  clive
Added code for non_gc spills number in front of code objects in a closure

Revision 1.21  1992/01/07  09:07:08  clive
Added stack limit register definitions

Revision 1.20  1991/11/25  15:48:57  jont
Added fp_global as a temporary for conversions from fp to int

Revision 1.19  91/11/20  17:34:43  jont
Added check_reg function from mach_cg to see when save/restore is needed

Revision 1.18  91/11/13  12:41:08  jont
Added next_reg to give the next register up. Needed for doubel and extended
moves, abs, neg, and extended store operations

Revision 1.17  91/11/11  18:03:25  jont
Added a maximum number of real digits, and a type to determine the
type of floating point in use

Revision 1.16  91/11/08  11:31:49  jont
Added printing of floating point registers

Revision 1.15  91/10/28  11:55:25  jont
Added store register for detection of load/store interaction

Revision 1.14  91/10/24  15:26:26  davidt
Now knows about the `implicit' register.

Revision 1.13  91/10/24  13:26:44  jont
Added cond register to represent the condition for the benefit of the
instruction scheduler

Revision 1.12  91/10/16  12:47:12  jont
New improved simplified module structure

Revision 1.11  91/10/15  16:54:01  jont
Changed defn of FN_CALL

Revision 1.10  91/10/09  14:33:15  richard
Added some new register definitions

Revision 1.9  91/10/09  10:55:13  jont
Changed some register allocations

Revision 1.8  91/10/08  18:47:05  jont
New module structure with lists of functions

Revision 1.7  91/10/07  11:46:17  richard
Moved some machine specific information to MachSpec.
Changed Bad_Reg exception to include a value. It is now called
OutOfScope.

Revision 1.6  91/10/03  09:42:44  richard
Changed the name of spillable_regs to gc_registers for consistency,
and added fp_registers and fp_double_registers.

Revision 1.5  91/10/02  10:32:43  jont
More register names and fixed translations

Revision 1.4  91/09/06  13:27:36  jont
Added register definitions etc

Revision 1.3  91/08/27  12:51:31  davida
Added exceptions Ord and Chr

Revision 1.2  91/08/22  11:02:02  jont
Added string to int and int to string conversion functions in case we
want variations between host and target

Revision 1.1  91/08/09  17:22:25  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "$.basis.__string";
require "../utils/crash";
require "machtypes";


functor MachTypes(
  structure Crash : CRASH
  ) : MACHTYPES =

struct
  datatype Sparc_Reg =
    I0 |
    I1 |
    I2 |
    I3 |
    I4 |
    I5 |
    I6 |
    I7 |
    L0 |
    L1 |
    L2 |
    L3 |
    L4 |
    L5 |
    L6 |
    L7 |
    O0 |
    O1 |
    O2 |
    O3 |
    O4 |
    O5 |
    O6 |
    O7 |
    G0 |
    G1 |
    G2 |
    G3 |
    G4 |
    G5 |
    G6 |
    G7 |
    cond |
    heap |
    stack |
    y_reg |
    nil_v

  val F0 = G0
  val F1 = G1
  val F2 = G2
  val F3 = G3
  val F4 = G4
  val F5 = G5
  val F6 = G6
  val F7 = G7
  val F8 = O0
  val F9 = O1
  val F10 = O2
  val F11 = O3
  val F12 = O4
  val F13 = O5
  val F14 = O6
  val F15 = O7
  val F16 = L0
  val F17 = L1
  val F18 = L2
  val F19 = L3
  val F20 = L4
  val F21 = L5
  val F22 = L6
  val F23 = L7
  val F24 = I0
  val F25 = I1
  val F26 = I2
  val F27 = I3
  val F28 = I4
  val F29 = I5
  val F30 = I6
  val F31 = I7

  fun next_reg I0 = I1
  | next_reg I1 = I2
  | next_reg I2 = I3
  | next_reg I3 = I4
  | next_reg I4 = I5
  | next_reg I5 = I6
  | next_reg I6 = I7
  | next_reg I7 = Crash.impossible"Next reg of register 31"
  | next_reg L0 = L1
  | next_reg L1 = L2
  | next_reg L2 = L3
  | next_reg L3 = L4
  | next_reg L4 = L5
  | next_reg L5 = L6
  | next_reg L6 = L7
  | next_reg L7 = I0
  | next_reg O0 = O1
  | next_reg O1 = O2
  | next_reg O2 = O3
  | next_reg O3 = O4
  | next_reg O4 = O5
  | next_reg O5 = O6
  | next_reg O6 = O7
  | next_reg O7 = L0
  | next_reg G0 = G1
  | next_reg G1 = G2
  | next_reg G2 = G3
  | next_reg G3 = G4
  | next_reg G4 = G5
  | next_reg G5 = G6
  | next_reg G6 = G7
  | next_reg G7 = O0
  | next_reg cond = Crash.impossible"next_reg cond"
  | next_reg heap = Crash.impossible"next_reg heap"
  | next_reg stack = Crash.impossible"next_reg stack"
  | next_reg y_reg = Crash.impossible"next_reg y_reg"
  | next_reg nil_v = Crash.impossible"next_reg nil_v"

  datatype fp_type = single | double | extended

  val fp_used = double

  fun reg_to_string I0 = "carg"
    | reg_to_string I1 = "cclos"
    | reg_to_string I2 = "i2"
    | reg_to_string I3 = "i3"
    | reg_to_string I4 = "i4"
    | reg_to_string I5 = "i5"
    | reg_to_string I6 = "fp"
    | reg_to_string I7 = "i7"
    | reg_to_string L0 = "l0"
    | reg_to_string L1 = "l1"
    | reg_to_string L2 = "l2"
    | reg_to_string L3 = "l3"
    | reg_to_string L4 = "l4"
    | reg_to_string L5 = "l5"
    | reg_to_string L6 = "l6"
    | reg_to_string L7 = "l7"
    | reg_to_string O0 = "arg"
    | reg_to_string O1 = "clos"
    | reg_to_string O2 = "o2"
    | reg_to_string O3 = "o3"
    | reg_to_string O4 = "o4"
    | reg_to_string O5 = "o5"
    | reg_to_string O6 = "sp"
    | reg_to_string O7 = "lr"
    | reg_to_string G0 = "zero"
    | reg_to_string G1 = "alloc"
    | reg_to_string G2 = "limit"
    | reg_to_string G3 = "handler"
    | reg_to_string G4 = "temp"
    | reg_to_string G5 = "implicit"
    | reg_to_string G6 = "stacklimit"
    | reg_to_string G7 = "g7"
    | reg_to_string cond = "the condition codes"
    | reg_to_string heap = "the heap"
    | reg_to_string stack = "the stack"
    | reg_to_string y_reg = "the y register"
    | reg_to_string nil_v = "the nil vector"
      
  fun fp_reg_to_string I0 = "f24"
    | fp_reg_to_string I1 = "f25"
    | fp_reg_to_string I2 = "f26"
    | fp_reg_to_string I3 = "f27"
    | fp_reg_to_string I4 = "f28"
    | fp_reg_to_string I5 = "f29"
    | fp_reg_to_string I6 = "f30"
    | fp_reg_to_string I7 = "f31"
    | fp_reg_to_string L0 = "f16"
    | fp_reg_to_string L1 = "f17"
    | fp_reg_to_string L2 = "f18"
    | fp_reg_to_string L3 = "f19"
    | fp_reg_to_string L4 = "f20"
    | fp_reg_to_string L5 = "f21"
    | fp_reg_to_string L6 = "f22"
    | fp_reg_to_string L7 = "f23"
    | fp_reg_to_string O0 = "f8"
    | fp_reg_to_string O1 = "f9"
    | fp_reg_to_string O2 = "f10"
    | fp_reg_to_string O3 = "f11"
    | fp_reg_to_string O4 = "f12"
    | fp_reg_to_string O5 = "f13"
    | fp_reg_to_string O6 = "f14"
    | fp_reg_to_string O7 = "f15"
    | fp_reg_to_string G0 = "f0"
    | fp_reg_to_string G1 = "f1"
    | fp_reg_to_string G2 = "f2"
    | fp_reg_to_string G3 = "f3"
    | fp_reg_to_string G4 = "f4"
    | fp_reg_to_string G5 = "f5"
    | fp_reg_to_string G6 = "f6"
    | fp_reg_to_string G7 = "f7"
    | fp_reg_to_string cond = "the condition codes"
    | fp_reg_to_string heap = "the heap"
    | fp_reg_to_string stack = "the stack"
    | fp_reg_to_string y_reg = "the y register"
    | fp_reg_to_string nil_v = "the nil vector"
      
  val caller_arg = O0
  val callee_arg = I0
  val caller_arg_regs = [O0,O2,O3,O4,O5]
  val callee_arg_regs = [I0,I2,I3,I4,I5]
  val caller_closure = O1
  val callee_closure = I1
  val fp = I6
  val sp = O6
  val lr = O7
  val handler = G3
  val gc1 = G1
  val gc2 = G2
  val global = G4
  val fp_global = G4
  val implicit = G5
  val stack_limit = G6
    
  exception OutOfScope of Sparc_Reg
  
  fun after_preserve I0 = raise OutOfScope I0
    | after_preserve I1 = raise OutOfScope I1
    | after_preserve I2 = raise OutOfScope I2
    | after_preserve I3 = raise OutOfScope I3
    | after_preserve I4 = raise OutOfScope I4
    | after_preserve I5 = raise OutOfScope I5
    | after_preserve I6 = raise OutOfScope I6
    | after_preserve I7 = raise OutOfScope I7
    | after_preserve L0 = raise OutOfScope L0
    | after_preserve L1 = raise OutOfScope L1
    | after_preserve L2 = raise OutOfScope L2
    | after_preserve L3 = raise OutOfScope L3
    | after_preserve L4 = raise OutOfScope L4
    | after_preserve L5 = raise OutOfScope L5
    | after_preserve L6 = raise OutOfScope L6
    | after_preserve L7 = raise OutOfScope L7
    | after_preserve O0 = I0
    | after_preserve O1 = I1
    | after_preserve O2 = I2
    | after_preserve O3 = I3
    | after_preserve O4 = I4
    | after_preserve O5 = I5
    | after_preserve O6 = I6
    | after_preserve O7 = I7
    | after_preserve G0 = G0
    | after_preserve G1 = G1
    | after_preserve G2 = G2
    | after_preserve G3 = G3
    | after_preserve G4 = G4
    | after_preserve G5 = G5
    | after_preserve G6 = G6
    | after_preserve G7 = G7
    | after_preserve cond = Crash.impossible"after_preserve cond"
    | after_preserve heap = Crash.impossible"after_preserve heap"
    | after_preserve stack = Crash.impossible"after_preserve stack"
    | after_preserve y_reg = Crash.impossible"after_preserve y_reg"
    | after_preserve nil_v = Crash.impossible"after_preserve nil_v"

  fun after_restore I0 = O0
    | after_restore I1 = O1
    | after_restore I2 = O2
    | after_restore I3 = O3
    | after_restore I4 = O4
    | after_restore I5 = O5
    | after_restore I6 = O6
    | after_restore I7 = O7
    | after_restore L0 = raise OutOfScope L0
    | after_restore L1 = raise OutOfScope L1
    | after_restore L2 = raise OutOfScope L2
    | after_restore L3 = raise OutOfScope L3
    | after_restore L4 = raise OutOfScope L4
    | after_restore L5 = raise OutOfScope L5
    | after_restore L6 = raise OutOfScope L6
    | after_restore L7 = raise OutOfScope L7
    | after_restore O0 = raise OutOfScope O0
    | after_restore O1 = raise OutOfScope O1
    | after_restore O2 = raise OutOfScope O2
    | after_restore O3 = raise OutOfScope O3
    | after_restore O4 = raise OutOfScope O4
    | after_restore O5 = raise OutOfScope O5
    | after_restore O6 = raise OutOfScope O6
    | after_restore O7 = raise OutOfScope O7
    | after_restore G0 = G0
    | after_restore G1 = G1
    | after_restore G2 = G2
    | after_restore G3 = G3
    | after_restore G4 = G4
    | after_restore G5 = G5
    | after_restore G6 = G6
    | after_restore G7 = G7
    | after_restore cond = Crash.impossible"after_restore cond"    
    | after_restore heap = Crash.impossible"after_restore heap"
    | after_restore stack = Crash.impossible"after_restore stack"
    | after_restore y_reg = Crash.impossible"after_restore y_reg"
    | after_restore nil_v = Crash.impossible"after_restore nil_v"

  val bits_per_word = 30
  val digits_in_real = 64

  exception Ord and Chr

  val ord = fn x=>(ord (String.sub(x, 0))) handle ? => raise Ord
  val chr = fn x=>(String.str(chr x)) handle ? => raise Chr
  exception NeedsPreserve

  fun check_reg L0 = raise NeedsPreserve
  | check_reg L1 = raise NeedsPreserve
  | check_reg L2 = raise NeedsPreserve
  | check_reg L3 = raise NeedsPreserve
  | check_reg L4 = raise NeedsPreserve
  | check_reg L5 = raise NeedsPreserve
  | check_reg L6 = raise NeedsPreserve
  | check_reg L7 = raise NeedsPreserve
  | check_reg O0 = raise NeedsPreserve
  | check_reg O1 = raise NeedsPreserve
  | check_reg O2 = raise NeedsPreserve
  | check_reg O3 = raise NeedsPreserve
  | check_reg O4 = raise NeedsPreserve
  | check_reg O5 = raise NeedsPreserve
    (* We don't count this as an output
     *| check_reg O6 = raise NeedsPreserve
     *)
  | check_reg O7 = raise NeedsPreserve
  | check_reg _ = ()

end
