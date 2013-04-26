(*
Check we handle imperative tyvars in strdecs properly
Test for bug 505

Result: FAIL

$Log: imptyvars.sml,v $
Revision 1.1  1993/12/16 14:13:38  matthew
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

local
  val s = ref []
  structure S = struct end (* force to be a strdec *)
in
  fun pop () = case !s of (a::l) => (s := l;a) | _ => raise Div
end

  
