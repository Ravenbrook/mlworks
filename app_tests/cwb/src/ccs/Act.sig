(*
 *
 * $Log: Act.sig,v $
 * Revision 1.2  1998/06/02 15:37:07  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Act.sig,v 1.2 1998/06/02 15:37:07 jont Exp $";
(************************************ Act ************************************)
(*                                                                           *)
(*  This is the definition of "Actions".                                     *)
(*                                                                           *)
(*****************************************************************************)
signature ACT =
sig
   exception Parse of string

   eqtype act

   val tau      : act
   val eps      : act
   val step     : act

   val hashval  : act -> int
(* given 'a, returns a*)
   val name     : act -> act
(* 'a <--> a *)
   val inverse  : act -> act
(* answer "are these complementaary actions?" *)
   val inverses : act * act -> bool
(* make an action out of a string, using conventional 'a, tau, eps, 1*)
   val mkact    : string -> act
   val mktau    : act -> act

(* Several different string representations of actions: *)
(* any Tau represented by "tau" *)       
   val mkstr    : act -> string
(* Taus adorned with string like tau <a> (whence came this tau?)*)
   val mkstr1   : act -> string
(* With ! and ? *)       
   val mkstr2   : act -> string

   val eq       : act * act -> bool
(* Tau < Eps < Step < a < a' (then lexicographic) *)       
   val le       : act * act -> bool
end

