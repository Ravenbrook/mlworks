(*
New types in functor result shouldn't share 

Result: FAIL

$Log: functor_result.sml,v $
Revision 1.1  1995/03/31 09:45:48  matthew
new unit
Test for production of new rigid names in functor results


Copyright (c) 1994 Harlequin Ltd.
*)
functor F(type t val x : t val f : t * t -> t) =
  struct
    datatype foo = A of t
    val x = A x
    fun g (A x) = A (f (x,x))
  end;

structure S1 =  F(type t = int -> int val x = (fn x => x +1) val f = op o);

structure S2 = F(type t = int val x = 0 val f = (op +) : int * int -> int);

val S1.A f = S2.x;
