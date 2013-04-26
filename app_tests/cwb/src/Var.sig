(*
 *
 * $Log: Var.sig,v $
 * Revision 1.2  1998/06/02 15:36:18  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Var.sig,v 1.2 1998/06/02 15:36:18 jont Exp $";
(************************************ Var ************************************)
(*                                                                           *)
(*  This is the definitions of "Variables".           Joachim Parrow Sept-86 *)
(*                                                                           *)
(*****************************************************************************)

signature VAR =
sig
   eqtype var

   val mkvar : string -> var
   val mkstr : var -> string

   val eq    : var * var -> bool
   val le    : var * var -> bool

   val hashval : var -> int
end

