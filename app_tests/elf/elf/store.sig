(*
 *
 * $Log: store.sig,v $
 * Revision 1.2  1998/06/03 12:21:08  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1992 by Carnegie Mellon University *)
(* Modified: Ekkehard Rohwedder <er@cs.cmu.edu>     *)

signature STORE =
sig

  structure Term : TERM
  structure Sign : SIGN
  structure Progtab : PROGTAB

  structure Switch : SWITCH

  datatype topdecl
     = Static of Sign.sign
     | Dynamic of Sign.sign * Progtab.progentry list * Term.sign_entry list

  val topenv  : ((string * int * topdecl) list) ref

  val enter_top : string -> topdecl -> unit
  val find_top : string -> (string * int * topdecl) option

  val dload_one : string -> unit
  val sload_one : string -> unit

  val find_sig : string -> Sign.sign

  val help : unit -> unit
  val addhelp : (unit -> unit) -> unit

  val topsign  : unit -> Sign.sign

end  (* signature STORE *)
