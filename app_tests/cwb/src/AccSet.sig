(*
 *
 * $Log: AccSet.sig,v $
 * Revision 1.2  1998/06/02 15:14:47  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: AccSet.sig,v 1.2 1998/06/02 15:14:47 jont Exp $";
(********************************** AccSet ***********************************)
(*                                                                           *)
(* This file contains a signature and functor for the manipulation of        *)
(* acceptance sets needed in the testing equivalences and preorders.         *)
(* An acceptance set is a set of finite sets of actions such that no proper  *)
(* subset of an element of an acceptance set is itself an element.           *)
(* We shall assume that sets of actions are sorted lists of actions contain- *)
(* ing no duplicates; then acceptance sets will be represented as tries with *)
(* actions as arc labels. We shall label the redundant EOS by unit.          *)
(*                                                                           *)
(* mkaccset    - given a list of (sorted) lists of actions, constructs the   *)
(*               corresponding acceptance set.                               *)
(* subaccset   - determines whether accset A << accset B, where A << B means *)
(*    the following: For all S in A there is T in B contained in S.          *)
(*                                                                           *)
(*****************************************************************************)

signature ACCSET =
sig
   type act
   type accset
   val empty     : accset
   val eq        : accset * accset -> bool
   val mkaccset  : act list list -> accset
   val subaccset : accset * accset -> bool
end

