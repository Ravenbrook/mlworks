(*
Explicit type variable must be generalised at their scoping declarations.

Result: OK
 
$Log: hetero1.sml,v $
Revision 1.2  1993/01/20 12:30:18  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

datatype ('a, 'b) HList = Nil | Cons of 'a * ('b, bool -> bool) HList

fun length(Nil) = 0
  | length(Cons(_, x)) = 1 + length(x)

val heterogeneous = Cons(1,Cons(true,Cons(fn x => x,Nil)))
