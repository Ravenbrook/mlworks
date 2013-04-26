(* type_utils.sml the signature *)
(*
$Log: type_utils.sml,v $
Revision 1.9  1996/02/23 17:15:47  jont
newmap becomes map, NEWMAP becomes MAP

 * Revision 1.8  1995/05/01  10:04:41  matthew
 * Removing record_domain
 *
Revision 1.7  1995/02/07  13:46:04  matthew
Adding the_type for use by mir_cg

Revision 1.6  1992/10/12  09:50:06  clive
Tynames now have a slot recording their definition point

Revision 1.5  1992/09/09  15:51:32  jont
Added predicates for has nullary constructors and has value carrying
constructors. Should be more efficient

Revision 1.4  1992/08/06  15:38:59  jont
Anel's changes to use NewMap instead of Map

Revision 1.2  1992/01/24  23:25:26  jont
Added functionality to get valenvs from METATYNAMES and get domain
of record types

Revision 1.1  1992/01/23  12:06:25  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../typechecker/datatypes";

signature TYPE_UTILS =
  sig
    structure Datatypes : DATATYPES

    val get_valenv :
      Datatypes.Type -> string * (Datatypes.Ident.ValId,Datatypes.Typescheme) Datatypes.NewMap.map
    val type_from_scheme : Datatypes.Typescheme -> Datatypes.Type
    val is_vcc : Datatypes.Type -> bool
    val get_no_cons : Datatypes.Type -> int
    val get_no_vcc_cons : Datatypes.Type -> int
    val get_no_null_cons : Datatypes.Type -> int
    val has_null_cons : Datatypes.Type -> bool
    val has_value_cons : Datatypes.Type -> bool
    val get_cons_type : Datatypes.Type -> Datatypes.Type
    val is_integral2 : Datatypes.Type -> bool
    val is_integral3 : Datatypes.Type -> bool
  end
