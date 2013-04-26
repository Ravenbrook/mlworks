(*
Sharing constraints in result signature of functor.

Result: FAIL

$Log: share17.sml,v $
Revision 1.1  1994/01/05 11:38:54  daveb
Initial revision


Copyright (c) 1994 Harlequin Ltd.
*)

signature S =
sig
  type t
end;

signature T =
sig
  structure S1: S
  structure S2: S
  sharing type S1.t = S2.t
end;

functor F (
  structure S1: S
  structure S2: S
  (* no sharing constraint *)
): T =
struct
  structure S1 = S1
  structure S2 = S2
  (* sharing constraint imposed by result signature *)
end;
