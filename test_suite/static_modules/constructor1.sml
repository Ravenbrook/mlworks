(*
Exception constructors can match value specifications.

Result: OK
 
$Log: constructor1.sml,v $
Revision 1.1  1993/01/20 15:06:01  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

structure bad2 :
sig 
  val E : exn
end = 
struct 
  exception E
end
