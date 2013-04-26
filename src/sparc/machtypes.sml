(* machtypes.sml the signature *)
(*
$Log: machtypes.sml,v $
Revision 1.34  1997/01/17 13:07:48  matthew
Adding y register

 * Revision 1.33  1995/08/14  11:27:44  jont
 * Add bits_per_word, remove max and min integer s and words
 *
Revision 1.32  1995/07/25  10:29:18  jont
Add largest_word machine limit

Revision 1.31  1994/07/29  11:32:18  matthew
Added *_arg_regs
Removed *_arg2

Revision 1.30  1994/07/22  16:13:23  matthew
Added extra argument register
hdiff sparc/_machspec.sml

Revision 1.29  1994/03/08  18:13:42  jont
Remove module type to separate file

Revision 1.28  1993/03/18  10:08:25  jont
Added leaf and offsets lists into WORDSET

Revision 1.27  1993/03/11  11:07:01  matthew
Signature revisions

Revision 1.26  1993/03/01  14:27:32  matthew
Added MLVALUEs

Revision 1.25  1993/02/03  15:34:03  jont
Changes for code vector reform.

Revision 1.24  1993/01/15  11:33:57  jont
Split store into three areas of heap, stack and nil vector for scheduling improvement

Revision 1.23  1992/09/15  10:53:35  clive
Checked and corrected the specification for the floating point registers

Revision 1.22  1992/06/18  11:19:07  jont
Added furhter constructors to the module element type to express
interpretive stuff

Revision 1.21  1992/01/13  14:19:43  clive
Added code for non_gc spills number in front of code objects in a closure
by changing wordset definition

Revision 1.20  1992/01/07  09:08:17  clive
Added stack limit register definitions

Revision 1.19  1991/11/25  15:48:38  jont
Added fp_global as a temporary for conversions from fp to int

Revision 1.18  91/11/20  17:07:56  jont
Added check_reg function from mach_cg to see when save/restore is needed

Revision 1.17  91/11/13  12:35:12  jont
Added next_reg to signature

Revision 1.16  91/11/11  18:02:26  jont
Added a maximum number of real digits, and a type to determine the
type of floating point in use

Revision 1.15  91/11/08  11:28:10  jont
Added printing of floating point registers

Revision 1.14  91/10/28  11:54:25  jont
Added store register for detection of load/store interaction

Revision 1.13  91/10/24  15:56:55  davidt
Now knows about the `implicit' register.

Revision 1.12  91/10/24  13:17:52  jont
Added cond register to represent the condition for the benefit of the
instruction scheduler

Revision 1.11  91/10/16  12:55:55  jont
New improved simplified module structure

Revision 1.10  91/10/15  16:53:50  jont
Changed defn of FN_CALL

Revision 1.9  91/10/09  14:33:25  richard
Added some new register definitions

Revision 1.8  91/10/08  18:46:51  jont
New module structure with lists of functions

Revision 1.7  91/10/07  11:46:35  richard
Moved some system dependent stuff to MachSpec.

Revision 1.6  91/10/03  09:42:45  richard
Changed the name of spillable_regs to gc_registers for consistency,
and added fp_registers and fp_double_registers. These are currently set
to the empty set.

Revision 1.5  91/10/02  10:30:55  jont
More register names and fixed translations

Revision 1.4  91/09/06  13:15:47  jont
Added register definitions etc

Revision 1.3  91/08/27  12:24:19  davida
Added exceptions Ord and Chr

Revision 1.2  91/08/22  11:01:33  jont
Added string to int and int to string conversion functions in case we
want variations between host and target

Revision 1.1  91/08/09  17:21:47  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)


signature MACHTYPES = sig
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

  val F0 : Sparc_Reg
  val F1 : Sparc_Reg
  val F2 : Sparc_Reg
  val F3 : Sparc_Reg
  val F4 : Sparc_Reg
  val F5 : Sparc_Reg
  val F6 : Sparc_Reg
  val F7 : Sparc_Reg
  val F8 : Sparc_Reg
  val F9 : Sparc_Reg
  val F10 : Sparc_Reg
  val F11 : Sparc_Reg
  val F12 : Sparc_Reg
  val F13 : Sparc_Reg
  val F14 : Sparc_Reg
  val F15 : Sparc_Reg
  val F16 : Sparc_Reg
  val F17 : Sparc_Reg
  val F18 : Sparc_Reg
  val F19 : Sparc_Reg
  val F20 : Sparc_Reg
  val F21 : Sparc_Reg
  val F22 : Sparc_Reg
  val F23 : Sparc_Reg
  val F24 : Sparc_Reg
  val F25 : Sparc_Reg
  val F26 : Sparc_Reg
  val F27 : Sparc_Reg
  val F28 : Sparc_Reg
  val F29 : Sparc_Reg
  val F30 : Sparc_Reg
  val F31 : Sparc_Reg


  val next_reg : Sparc_Reg -> Sparc_Reg

  datatype fp_type = single | double | extended

  val fp_used : fp_type

  val reg_to_string : Sparc_Reg -> string
  val fp_reg_to_string : Sparc_Reg -> string

  val digits_in_real : int
  val bits_per_word : int

  val caller_arg : Sparc_Reg
  val callee_arg : Sparc_Reg
  val caller_arg_regs : Sparc_Reg list
  val callee_arg_regs : Sparc_Reg list
  val caller_closure : Sparc_Reg
  val callee_closure : Sparc_Reg
  val fp : Sparc_Reg
  val sp : Sparc_Reg
  val lr : Sparc_Reg
  val handler : Sparc_Reg
  val global : Sparc_Reg
  val fp_global : Sparc_Reg
  val gc1 : Sparc_Reg
  val gc2 : Sparc_Reg
  val implicit : Sparc_Reg
  val stack_limit : Sparc_Reg

  exception OutOfScope of Sparc_Reg
  val after_preserve : Sparc_Reg -> Sparc_Reg
  val after_restore : Sparc_Reg -> Sparc_Reg


  exception Ord
  exception Chr

  val ord: string -> int
  val chr: int -> string

  exception NeedsPreserve

  val check_reg : Sparc_Reg -> unit
end
