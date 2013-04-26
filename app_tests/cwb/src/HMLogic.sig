(*
 *
 * $Log: HMLogic.sig,v $
 * Revision 1.2  1998/06/02 15:26:18  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: HMLogic.sig,v 1.2 1998/06/02 15:26:18 jont Exp $";
(*********************************** HMLog ***********************************)
(*                                                                           *)
(* This file contains the signatures and functors for a logic used by the    *)
(* system.                                                                   *)
(*                                                                           *)
(* HMLOG describes the logic used by the model checker.  As a grammar, the   *)
(* logic has the following description.                                      *)
(*      <P> ::=  T  |  V  |  ~P  |  P&P                                      *)
(*            |  [act list] P  |  [-act list] P  |  max(V.P)                 *)
(*                                                                           *)
(* Also all variables must be bound, and they must be distinct.              *)
(* (This is assured by the translator.)                                      *)
(*                                                                           *)
(*****************************************************************************)

signature HMLOGIC =
sig
   structure A : ACT
   structure V : VAR

   datatype modality = modlist of A.act list
                     | negmodlist of A.act list

   datatype prop = True
                 | Var of V.var
                 | Not of prop
                 | And of prop * prop
                 | Nec of modality * prop
                 | Max of V.var * prop
end

