(*
Imperative type variables may not be free at top level.

Result: FAIL
 
$Log: imptyvar.sml,v $
Revision 1.2  1993/01/20 12:31:20  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

fun g x =
  let
     val a = ref (fn t => t)
  in
    !a x
  end

val x = g g
