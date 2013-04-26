(*
Matches on exception constructors

Result: OK
 
$Log: matchrules3.sml,v $
Revision 1.1  1995/05/11 17:00:21  jont
new unit
No reason given

Copyright (c) 1995 Harlequin Ltd.
*)

exception A of int * real
exception B of int * real
exception C of real * int
fun errormessage_str(A(e,t)) = ()
  | errormessage_str(C(e,t)) = ()
  | errormessage_str _ = ();
fun errormessage_str(A(e,t)) = ()
  | errormessage_str(B(e,t)) = ()
  | errormessage_str _ = ();
