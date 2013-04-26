(* core_rules.sml the signature *)
(*
$Log: core_rules.sml,v $
Revision 1.16  1993/05/28 13:32:13  jont
Cleaned up after assembly changes

Revision 1.15  1993/05/25  15:18:26  jont
Changes because Assemblies now has Basistypes instead of Datatypes

Revision 1.14  1993/03/10  14:39:05  matthew
Options changes

Revision 1.13  1993/03/09  13:05:11  matthew
Options & Info changes
Absyn changes

Revision 1.12  1993/02/08  15:01:46  matthew
Changes for BASISTYPES signature

Revision 1.11  1993/02/01  14:20:33  matthew
Added sharing

Revision 1.10  1992/12/08  15:39:23  jont
Removed a number of duplicated signatures and structures

Revision 1.9  1992/12/02  13:41:04  jont
Modified to remove redundant info signatures

Revision 1.8  1992/11/26  19:02:34  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.7  1992/11/04  16:52:12  matthew
Changed Error structure to Info

Revision 1.6  1992/09/02  15:45:39  richard
Installed central error reporting mechanism.

Revision 1.5  1992/08/11  15:42:22  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.4  1992/08/04  12:28:46  davidt
Added extra sharing equation.

Revision 1.3  1991/11/21  16:50:58  jont
Added copyright message

Revision 1.2  91/11/19  12:18:48  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:12:54  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:42:54  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../basics/absyn";
require "../main/info";
require "../main/options";
require "basistypes";

(* This module forms the heart of the checker for the static semantics
of the core (chapter 4 of the Definition). It performs recursive
descent over the abstract syntax, as one might expect,according to the
rules. The implementation is laid out strictly in rule order. The main
function provided, check_dec, checks a single Declaration in the
context provided, and returns the environment (See rules 17--25) *)


signature CORE_RULES =
  sig
    structure Absyn : ABSYN
    structure Basistypes : BASISTYPES
    structure Info : INFO
    structure Options : OPTIONS

    sharing Info.Location = Absyn.Ident.Location
    sharing Basistypes.Datatypes.Ident = Absyn.Ident
    sharing Absyn.Set = Basistypes.Set

    sharing type Absyn.Type = Basistypes.Datatypes.Type
    sharing type Absyn.Structure = Basistypes.Datatypes.Structure

    val check_dec :
      (Info.options * Options.options) ->
      Absyn.Dec * Basistypes.Context ->
      Basistypes.Datatypes.Env

    val check_type :
      Info.options ->
      Absyn.Ty * Basistypes.Context ->
      Basistypes.Datatypes.Type

  end

  
