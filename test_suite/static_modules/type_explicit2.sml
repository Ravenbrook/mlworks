(*
This signature should be type-explicit.

Result: OK

$Log: type_explicit2.sml,v $
Revision 1.1  1993/05/06 11:29:43  matthew
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

signature FOO = sig type Foo end;

functor Bar (Foo : FOO) : sig val f : Foo.Foo -> Foo.Foo end =
  struct
    fun f x = x
  end;

