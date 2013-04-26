(* sharetypes.sml the signature *)
(*
$Log: sharetypes.sml,v $
Revision 1.7  1996/03/27 16:59:58  matthew
Updating for new language revisions

 * Revision 1.6  1993/05/25  15:33:39  jont
 * Changes because Assemblies now has Basistypes instead of Datatypes
 *
Revision 1.5  1993/05/20  16:29:02  jont
Avoid updating flexible names in the basis (when doing sharng in functor results)

Revision 1.4  1992/08/11  14:22:20  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.3  1991/11/21  16:53:57  jont
Added copyright message

Revision 1.2  91/11/19  12:19:14  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:04  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:45:33  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(* This module performs the updating of metatynames and metatyfuns to
obey the typename sharing rule (89 in the Definition). It is only
called when following this rule (from mod_rules.sml). *)

require "namesettypes";
require "assemblies";

signature SHARETYPES = 
  sig
    structure Assemblies : ASSEMBLIES
    structure NamesetTypes : NAMESETTYPES
    sharing type Assemblies.Basistypes.Nameset = NamesetTypes.Nameset
    exception ShareError of string

    val share_tyfun : bool * Assemblies.Basistypes.Datatypes.Tyfun * Assemblies.Basistypes.Datatypes.Tyfun *
      Assemblies.TypeAssembly * NamesetTypes.Nameset -> bool * Assemblies.TypeAssembly
  end
