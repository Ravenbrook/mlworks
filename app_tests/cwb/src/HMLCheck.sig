(*
 *
 * $Log: HMLCheck.sig,v $
 * Revision 1.2  1998/06/02 15:23:08  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: HMLCheck.sig,v 1.2 1998/06/02 15:23:08 jont Exp $";
(********************************** HMLSat ***********************************)
(*                                                                           *)
(* This file contains the signature for model checking on predefined graphs. *)
(*                                                                           *)
(*****************************************************************************)

signature HMLCHECK =
sig
   structure PG : POLYGRAPH

   eqtype mcinfo
   type prop

   val setmcinfo : PG.agent -> mcinfo
   val check : (mcinfo PG.state ref * mcinfo PG.state ref list) -> prop -> bool
end


