(*
Value bindings can't match constructor specifications.

Result: FAIL
 
$Log: constructor2.sml,v $
Revision 1.1  1993/01/20 15:06:25  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

structure bad1 :
sig
  datatype t = X 
end =
struct 
  datatype t = Y
  val X = Y
end
