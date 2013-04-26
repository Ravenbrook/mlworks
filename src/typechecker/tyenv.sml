(* tyenv.sml the signature *)
(*
$Log: tyenv.sml,v $
Revision 1.14  1995/03/24 15:01:17  matthew
Use Stamp instead of Tyname_id etc.

Revision 1.13  1995/02/07  10:58:30  matthew
Improving lookup failure messages

Revision 1.12  1993/02/19  10:37:47  matthew
Moved te_ran_enriches to _realise

Revision 1.11  1993/02/08  13:20:12  matthew
Removed open Datatypes

Revision 1.10  1992/12/03  13:20:32  jont
Modified tyenv for efficiency

Revision 1.9  1992/10/30  15:43:12  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.8  1992/08/27  20:06:27  davidt
Yet more changes to get structure copying working better.

Revision 1.7  1992/08/11  13:35:48  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.6  1992/07/16  19:03:03  jont
Changed to use btrees for renaming of tynames and strnames

Revision 1.5  1992/07/04  17:16:07  jont
Anel's changes for improved structure copying

Revision 1.4  1992/02/11  10:12:21  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.3  1991/11/21  16:55:23  jont
Added copyright message

Revision 1.2  91/11/19  12:19:24  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:08  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:46:15  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(*

A TyEnv is a type environment, a mapping from type constructors to
type structures, as defined in the Definiton (page 17). The type TyEnv
is defined in datatypes.sml: this module provides functions that act
on TyEnvs, which are essentially those actions described in the
Definition, including enrichment. 

*)

require "../typechecker/datatypes";

signature TYENV =
  sig
    structure Datatypes : DATATYPES

    exception LookupTyCon of Datatypes.Ident.TyCon

    val empty_tyenv : Datatypes.Tyenv
    val initial_te : Datatypes.Tyenv
    val initial_te_for_builtin_library : Datatypes.Tyenv
    val lookup : Datatypes.Tyenv * Datatypes.Ident.TyCon -> Datatypes.Tystr
    val te_plus_te : Datatypes.Tyenv * Datatypes.Tyenv -> Datatypes.Tyenv 
    val add_to_te : (Datatypes.Tyenv * Datatypes.Ident.TyCon * Datatypes.Tystr) -> Datatypes.Tyenv 
    val string_tyenv : Datatypes.Tyenv -> string
    val empty_tyenvp : Datatypes.Tyenv -> bool
    val te_copy : Datatypes.Tyenv * Datatypes.Tyname Datatypes.StampMap -> Datatypes.Tyenv
    val tystr_copy : Datatypes.Tystr * Datatypes.Tyname Datatypes.StampMap -> Datatypes.Tystr
  end

