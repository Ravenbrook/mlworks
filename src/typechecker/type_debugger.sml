(* type_debugger.sml. Utilities for type checking information *)
(*
* $Log: type_debugger.sml,v $
* Revision 1.2  1996/08/05 16:36:01  andreww
* [Bug #1521]
* Propagating changes made to _types.sml:
* need to pass use_value_polymorphism flag to the print typevars
* functions.
*
 * Revision 1.1  1993/05/11  12:50:07  matthew
 * Initial revision
 *
*
* Copyright (c) 1993 Harlequin Ltd.
*)

require "../basics/absyn";
require "../main/options";
signature TYPE_DEBUGGER =
  sig
    structure Options : OPTIONS
    structure Absyn: ABSYN
    val gather_vartypes :
      Absyn.TopDec ->
      (Absyn.Ident.ValId * Absyn.Type * Absyn.Ident.Location.T) list
    val print_vartypes :
      Options.options ->
      (Absyn.Ident.ValId * Absyn.Type * Absyn.Ident.Location.T) list -> unit
  end

