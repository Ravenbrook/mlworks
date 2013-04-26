(*
 *
 * $Log: Act.sig,v $
 * Revision 1.2  1998/06/02 15:44:57  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Act.sig,v 1.2 1998/06/02 15:44:57 jont Exp $";
(************************************ Act ************************************)
(*                                                                           *)
(*  This is the definition of "Actions".                                     *)
(*                                                                           *)
(*****************************************************************************)

signature ACT =
sig
   structure P : PART

   exception Parse of string

   eqtype act

   val tau      : act
   val eps      : act

(*an amatuerish hashing function.*)
   val hashval  : act -> int
(* 'a <--> a *)
   val inverse  : act -> act
(* answer "are these complementary actions?" *)
   val inverses : act * act -> bool
(* make an action out of a string, using conventional 'a, tau, eps, 1*)
   val mkact    : string -> act
   val mkstr    : act -> string
   val mkstr1   : act -> string

   val ispart   : act -> bool
   val parts    : act -> P.part list

   val product  : act * act -> act
   val relabel  : (act * P.part) list -> act -> act
   val permit   : P.part list -> act -> bool

   val eq       : act * act -> bool
   val le       : act * act -> bool
end

