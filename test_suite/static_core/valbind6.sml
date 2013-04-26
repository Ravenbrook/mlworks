(*
  This tests that we can actually unify variables of type '_a with
  values of type 'a.

Result: OK

$Log: valbind6.sml,v $
Revision 1.1  1996/08/01 16:53:07  andreww
new unit
[1521]
Shows that under value polymorphism, '_a and 'a types unify.


Copyright (c) 1996 Harlequin Ltd.
*)

(* normally, this function ought to be given type unit-> '_a -> '_a,
   but with value polymorphism, there should be no difference *)

fun mk_id ():'a -> 'a = fn x => ! (ref x);


