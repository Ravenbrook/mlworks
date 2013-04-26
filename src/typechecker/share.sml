(* share.sml the signature *)
(*
$Log: share.sml,v $
Revision 1.7  1995/02/07 15:29:25  matthew
Adding share_tyfun function

Revision 1.6  1993/05/25  15:23:14  jont
Changes because Assemblies now has Basistypes instead of Datatypes

Revision 1.5  1993/02/08  16:09:29  matthew
Changes for BASISTYPES signature

Revision 1.4  1992/08/11  14:23:05  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.3  1991/11/21  16:53:44  jont
Added copyright message

Revision 1.2  91/11/19  12:19:12  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:03  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:45:21  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(* Structure sharing. In rules 88,89,90 of the Definition cover the
behaviour of sharing equations. This module performs the necessary
consistency checking and updating of metastrnames. The module
sharetypes does similar work *)

require "assemblies";

signature SHARE = 
  sig
    structure Assemblies : ASSEMBLIES

    exception ShareError of string

    val share_str : Assemblies.Basistypes.Datatypes.Strname *
      Assemblies.Basistypes.Datatypes.Strname * 
      Assemblies.StrAssembly * Assemblies.TypeAssembly * Assemblies.Basistypes.Nameset -> 
      bool * Assemblies.StrAssembly * Assemblies.TypeAssembly

  end
