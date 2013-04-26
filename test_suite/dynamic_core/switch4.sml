(*
Switches on datatypes with single constructors.

Result: OK

$Log: switch4.sml,v $
Revision 1.3  1998/02/18 11:56:00  mitchell
[Bug #30349]
Fix test to avoid non-unit sequence warning

 * Revision 1.2  1993/01/21  12:05:37  daveb
 * Updated header.
 *
Revision 1.1  1992/11/04  17:11:55  daveb
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)


(* Abstraction is needed to avoid optimisation of constants.
   Similarly for the second call; if there were only one call
     then eta-abstraction would allow constant folding again.
*) 

    datatype btree =
      LEAF

    fun insert LEAF = LEAF

    fun define' mapping =
        (ignore(insert mapping); insert mapping)
      ;

define' LEAF;


    datatype btree =
      Node of int

    fun insert (Node t1) = Node t1

    fun define' mapping =
        (ignore(insert mapping); insert mapping)
      ;

define' (Node 3);
