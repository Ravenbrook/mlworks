(*
 *
 * $Log: Sim.sig,v $
 * Revision 1.2  1998/06/02 15:31:43  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Sim.sig,v 1.2 1998/06/02 15:31:43 jont Exp $";
(********************************* Simulate **********************************)
(*                                                                           *)
(* The module Simulate allows for the interactive simulation of an agent.    *)
(*                                                                           *)
(*****************************************************************************)

signature SIMULATE =
sig
   type agent
   type act
   val simulate: (agent -> ((act * agent) list) * string * string) -> 
       agent -> unit
end

