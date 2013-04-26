(*
The attempt to apply an equality tyvar as a function
should error.
A bug in eq_and_imp prevented this.

Result: FAIL
 
$Log: eqattr.sml,v $
Revision 1.1  1993/06/04 09:50:55  matthew
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

functor Foo (structure S : sig datatype 'a Foo = FOO of 'a end) =
  struct
    fun foo x =
      let
        val t = x = x
        val S.FOO f = x
      in
        f 3
      end
  end
