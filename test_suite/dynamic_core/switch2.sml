(*
Some cases that have broken the switch translation: 2

Result: OK

$Log: switch2.sml,v $
Revision 1.3  1998/02/18 11:56:00  mitchell
[Bug #30349]
Fix test to avoid non-unit sequence warning

 * Revision 1.2  1993/01/21  12:04:30  daveb
 * Updated header.
 *
Revision 1.1  1992/11/04  17:11:54  daveb
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)


(* Switch on an IMM and a default.  The type must contain a VCC that
   isn't in the switch.  We can't have another IMM in the type.
   We must be swiching on an IMM.
   Abstraction is needed to avoid optimisation of constants.
   Similarly for the second call; if there were only one call
     then eta-abstraction would allow constant folding again.
*)

    datatype btree =
      LEAF
    | N1 of int
    | N2 of btree

    fun insert (N1 t1) = N1 23
      | insert LEAF = LEAF
      | insert other_shape = other_shape

    fun define' mapping =
        (ignore(insert mapping); insert mapping)
      ;

define' LEAF
