(*
Inexhasutive match on constructed datatype

Result: WARNING
 
$Log: matchrules2.sml,v $
Revision 1.1  1993/07/26 12:37:41  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

datatype a = A | B | C | D
fun f A = 1
  | f C = 2

