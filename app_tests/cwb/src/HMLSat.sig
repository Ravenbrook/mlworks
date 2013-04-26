(*
 *
 * $Log: HMLSat.sig,v $
 * Revision 1.2  1998/06/02 15:24:10  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: HMLSat.sig,v 1.2 1998/06/02 15:24:10 jont Exp $";
(********************************** HMLSat ***********************************)
(*                                                                           *)
(* This file contains the signature for local model checking.                *)
(*                                                                           *)
(*****************************************************************************)

signature HMLSAT =
sig
   type act
   type agent
   type prop

   val check : (agent -> (act * agent) list) -> agent -> prop -> bool
end

