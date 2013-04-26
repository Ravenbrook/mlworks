(* typerep_utils.sml the signature *)
(*
$Log: typerep_utils.sml,v $
Revision 1.3  1996/03/19 16:04:51  matthew
Changed type of Scheme functions

 * Revision 1.2  1993/04/07  16:23:16  matthew
 * Removed print_typerep and make_typerep_expression
 * Added convert_dynamic_type
 *
Revision 1.1  1993/02/19  16:47:22  matthew
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

require "../typechecker/datatypes";
require "../basics/absyn";

signature TYPEREP_UTILS =
  sig
    structure Datatypes : DATATYPES
    structure Absyn : ABSYN

    val make_coerce_expression : Absyn.Exp * Datatypes.Type -> Absyn.Exp

    exception ConvertDynamicType
    val convert_dynamic_type : (bool * Datatypes.Type * int * Absyn.Ident.TyVar Absyn.Set.Set) -> Datatypes.Type
  end

