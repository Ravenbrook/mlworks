(*
Result: OK
 
$Log: hetero.sml,v $
Revision 1.2  1993/01/20 12:29:56  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)


datatype ('a,'b,'c) HList = Nil | Cons of 'a * ('b,'c,'a) HList

fun length(Nil) = 0
  | length(Cons(_, x)) = 1 + length(x)

val heterogeneous = Cons(1,Cons(true,Cons(fn x => x,Nil)))


