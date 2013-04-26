(*
 *
 * $Log: Parse.sig,v $
 * Revision 1.2  1998/06/02 15:29:35  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Parse.sig,v 1.2 1998/06/02 15:29:35 jont Exp $";
(*********************************** Parse ***********************************)
(*                                                                           *)
(* Signature for parsing commands.                                           *)
(*                                                                           *)
(*****************************************************************************)

signature PARSE =
sig
   structure Commands : COMMANDS

   exception Parse of string

   val parse : string ->
               (string -> Commands.Ag.A.act) ->
               (string -> Commands.Ag.V.var) ->
               (string -> Commands.Ag.agent) ->
               (string -> Commands.L.prop) ->
                string -> Commands.Command
end

