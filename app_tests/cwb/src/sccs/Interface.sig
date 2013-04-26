(*
 *
 * $Log: Interface.sig,v $
 * Revision 1.2  1998/06/02 15:49:05  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Interface.sig,v 1.2 1998/06/02 15:49:05 jont Exp $";
(********************************* Interface *********************************)
(*                                                                           *)
(* Signature for global environments.                Rance Cleaveland Oct-87 *)
(*                                                                           *)
(*****************************************************************************)
(* pes: At the moment I am using this for UI stuff like print -- but *)
(* this needs some serious rethinking.*)
signature INTERFACE =
sig
   structure Ag : AGENT
   structure L : LOGIC
   structure E : ENV

   type part
   type act
   type var

   exception IO of string

   val agentenv      : (Ag.param list * Ag.agent) E.env ref
   val setenv        : act list E.env ref
   val psetenv       : part list E.env ref
   val relenv        : (act * part) list E.env ref

   val propenv       : (L.param list * L.prop) E.env ref

   val printagentenv : (Ag.param list * Ag.agent) E.env -> unit
   val printsetenv   : act list E.env -> unit 
   val printpsetenv  : part list E.env -> unit 
   val printrelenv   : (act * part) list E.env -> unit 

   val printpropenv  : (L.param list * L.prop) E.env -> unit

   val dumpallenvs   : string -> unit

   val print         : string -> unit                   (* Print string      *)
   val printagent    : Ag.agent -> unit
   val printagents   : Ag.agent list -> unit
   val printeqagents : Ag.agent list list -> unit
   val printders     : (act * Ag.agent) list -> unit
   val printdersseq  : (act list * Ag.agent) list -> unit
   val printexps     : (act list * Ag.agent) list -> unit
   val printseq      : act list list -> unit
   val printoneseq   : act list -> unit
   val printgraph    : (Ag.agent *
			(Ag.agent * ((act * Ag.agent) list)) list)
			-> unit

end

