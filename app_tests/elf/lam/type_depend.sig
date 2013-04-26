(*
 *
 * $Log: type_depend.sig,v $
 * Revision 1.2  1998/06/03 12:02:48  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Specifies legal type dependencies, used in type reconstruction *)

signature TYPE_DEPEND =
sig

  structure Term : TERM

  val known_may_depend : Term.term -> bool
  val unknown_may_depend : bool

end  (* signature TYPEDEPEND *)
