(* mod_rules.sml the signature *)
(*
$Log: mod_rules.sml,v $
Revision 1.19  1995/04/05 14:16:21  matthew
Added flag to control whether structure expansion is done.

Revision 1.18  1993/06/02  17:37:02  jont
Changed type of check_topdec to take assemblies, thus making it functional

Revision 1.17  1993/05/28  10:42:26  jont
Cleaned up after assembly changes

Revision 1.16  1993/05/25  15:19:08  jont
Changes because Assemblies now has Basistypes instead of Datatypes

Revision 1.15  1993/03/10  14:27:20  matthew
Options changes

Revision 1.14  1993/03/09  13:05:10  matthew
Options & Info changes

Revision 1.13  1993/02/08  15:03:34  matthew
Changes for BASISTYPES signature

Revision 1.12  1993/02/04  12:31:00  matthew
Added sharing.

Revision 1.11  1992/12/02  13:49:30  jont
Modified to remove redundant info signatures

Revision 1.10  1992/11/26  19:06:18  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.9  1992/11/04  15:45:06  matthew
Changed Error structure to Info

Revision 1.8  1992/10/15  15:52:47  clive
Anel's changes for encapsulating assemblies

Revision 1.7  1992/09/02  18:00:23  richard
Installed central error reporting mechanism.

Revision 1.6  1992/06/22  09:27:48  davida
Changed print_times into ref.

Revision 1.5  1992/01/08  19:56:45  colin
added reset_assemblies

Revision 1.4  1991/11/21  16:52:35  jont
Added copyright message

Revision 1.3  91/11/19  12:18:59  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.2.1.1  91/11/19  11:12:58  jont
Added comments for DRA on functions

Revision 1.2  91/07/11  14:00:15  colin
Added exception Check_topdec - raised if any errors happened during
type checking in check_topdec

Revision 1.1  91/06/07  11:44:23  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(* This module is the top level of the typechecker. It provides the
key typechecking function, check_topdec, which is at the head of a
recursive-descent checker following the rules given in the Definition.
This function is the only one called from outside the typechecker. *)

require "../basics/absyn";
require "../main/info";
require "../main/options";
require "../typechecker/assemblies";

signature MODULE_RULES = 
  sig
    structure Absyn : ABSYN
    structure Assemblies : ASSEMBLIES
    structure Info : INFO
    structure Options : OPTIONS

    sharing Info.Location = Absyn.Ident.Location

    sharing type Absyn.Type = Assemblies.Basistypes.Datatypes.Type
    sharing type Absyn.Structure = Assemblies.Basistypes.Datatypes.Structure

    datatype assembly =
      ASSEMBLY of (Assemblies.StrAssembly * Assemblies.TypeAssembly)
    | BASIS of Assemblies.Basistypes.Basis

    (* The bool indicates if weare in the batch compiler *)
    val check_topdec :
      Info.options ->
      Options.options * bool * Absyn.TopDec * Assemblies.Basistypes.Basis * assembly ->
      Assemblies.Basistypes.Basis

  end
