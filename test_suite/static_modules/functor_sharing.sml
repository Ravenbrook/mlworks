(*
Sharing problem

Result: OK

$Log: functor_sharing.sml,v $
Revision 1.1  1993/05/25 10:06:49  matthew
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

signature E = sig end;

functor Foo1 (structure E : E) : sig structure EE : E sharing EE = E end =
  struct structure EE = E end;

functor Foo (structure E : E) : sig structure EE : E sharing EE = E end =
  Foo1(structure E = E)
