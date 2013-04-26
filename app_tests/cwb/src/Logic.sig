(*
 *
 * $Log: Logic.sig,v $
 * Revision 1.2  1998/06/02 15:28:42  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Logic.sig,v 1.2 1998/06/02 15:28:42 jont Exp $";
(********************************** HMLogIO **********************************)
(*                                                                           *)
(* This file contains the signatures and functors for a logic used by the    *)
(* system.                                                                   *)
(*                                                                           *)
(* HMLogIO describes the logic visible to the user of the system. As a       *)
(* grammar the logic has the following description. "V" is a variable, "a"   *)
(* is action (possibly epsilon, if used in a weak modality) and "K" is a     *)
(* list of actions (again possibly epsilon, in a weak modality).             *)
(*                                                                           *)
(*       P  ::=   T  |  F  |  ~P  |  P|P  |  P&P  |  P=>P                    *)
(*            |  [K]P      |  [-K]P     |  [[K]]P  |  [[-K]]P                *)
(*            |  <K>P      |  <-K>P     |  <<K>>P  |  <<-K>>P                *)
(*            |  max(V.P)  |  min(V.P)  |  V  |  V (paramlist)               *)
(*                                                                           *)
(*****************************************************************************)

signature LOGIC =
sig
   structure A : ACT
   structure V : VAR

   datatype modality = modlist of A.act list
                     | negmodlist of A.act list
                     | modvar of V.var
                     | negmodvar of V.var

   datatype param = Modparam of modality
                  | Propparam of prop

        and prop = True
                 | False
                 | Var of V.var * param list
                 | Not of prop
                 | And of prop * prop
                 | Or of prop * prop
                 | Imp of prop * prop
                 | Nec of modality * prop
                 | Pos of modality * prop
                 | WeakNec of modality * prop
                 | WeakPos of modality * prop
                 | Max of V.var * prop
                 | Min of V.var * prop


end

