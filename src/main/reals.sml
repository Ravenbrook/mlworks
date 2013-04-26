(* reals.sml the signature *)
(*
$Log: reals.sml,v $
Revision 1.1  1991/11/11 14:54:06  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

signature REALS =
sig
  exception too_big
  exception too_small
  val evaluate_real : string -> real
  val find_real_components : real -> bool * string * int
end
