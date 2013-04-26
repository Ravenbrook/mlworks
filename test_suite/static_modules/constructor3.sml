(*
Value bindings can't match exception specifications.

Result: FAIL
 
$Log: constructor3.sml,v $
Revision 1.1  1993/01/20 15:06:51  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

structure bad2 :
sig 
  exception E
end = 
struct 
  exception F
  val E = F
end
