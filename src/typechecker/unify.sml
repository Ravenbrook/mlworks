(* unify.sml the signature *)
(*
$Log: unify.sml,v $
Revision 1.10  1995/05/11 14:44:07  matthew
Improving record domain error messages

Revision 1.9  1995/02/02  14:59:04  matthew
Rationalizations

Revision 1.8  1995/01/03  17:12:00  matthew
Change to substitution datatype

Revision 1.7  1994/04/27  12:44:54  daveb
Added type variable to OVERLOADED case of unify_result.

Revision 1.6  1993/12/03  15:56:17  nickh
Remove TYNAME.

Revision 1.5  1993/11/24  16:35:17  nosa
Modified unified to be optionally side-effect free, returning substitutions;
Can apply resulting substitutions to types.

Revision 1.4  1993/04/01  16:33:16  jont
Allowed overloadin on strings to be controlled by an option

Revision 1.3  1991/11/21  16:56:22  jont
Added copyright message

Revision 1.2  91/11/19  12:19:36  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:15  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:46:54  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../typechecker/datatypes";

(* This module forms the core of the type unifier (it is mostly called
via the module Control_Unify, which provides a more powerful
front-end. It attempts to unify two types by setting type variables
(and unresolved types, i.e. meta-types) within the types to new
values. The algorithm is very simple and is well-commented (in
_unify.sml). *)


signature UNIFY = 
  sig
    structure Datatypes : DATATYPES

    type options

    type 'a refargs

    datatype substitution = 
      SUBST of ((int * Datatypes.Type * Datatypes.Instance) refargs list *
                (int * bool * Datatypes.Type * bool * bool) refargs list *
                Datatypes.Type refargs list)

    datatype record =
      RIGID of (Datatypes.Ident.Lab * Datatypes.Type) list
    | FLEX  of (Datatypes.Ident.Lab * Datatypes.Type) list

    datatype unify_result =
      OK
    | FAILED of Datatypes.Type * Datatypes.Type
    | RECORD_DOMAIN of record * record
    | EXPLICIT_TYVAR of Datatypes.Type * Datatypes.Type
    | EQ_AND_IMP of bool * bool * Datatypes.Type
    | CIRCULARITY of Datatypes.Type * Datatypes.Type
    | OVERLOADED of Datatypes.Ident.TyVar * Datatypes.Type
    | SUBSTITUTION of substitution

    val apply : unify_result * Datatypes.Type -> Datatypes.Type
    val unified : options * Datatypes.Type * Datatypes.Type * bool -> unify_result
  end;
