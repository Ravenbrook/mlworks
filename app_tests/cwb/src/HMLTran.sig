(*
 *
 * $Log: HMLTran.sig,v $
 * Revision 1.2  1998/06/02 15:25:29  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: HMLTran.sig,v 1.2 1998/06/02 15:25:29 jont Exp $";
(********************************** HMLTran **********************************)
(*                                                                           *)
(* This file contains the signatures and functors for translating logics     *)
(* used by the system.                                                       *)
(*                                                                           *)
(* As the logic used by the model checker is different from the logic        *)
(* visible to the user, a means of translating from the latter to the former *)
(* must be supplied.  This signature describes such a translator.            *)
(*                                                                           *)
(*****************************************************************************)

signature HMLTRAN =
sig
   structure L   : LOGIC
   structure HML : HMLOGIC
     sharing L.A = HML.A
         and L.V = HML.V

   type 'a env

   exception Error of string
   exception Debug of string
   
   val translate : L.prop -> (L.param list * L.prop) env
                          -> L.A.act list env -> HML.prop
end

