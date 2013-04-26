(* sigma.sml the signature *)
(*
$Log: sigma.sml,v $
Revision 1.14  1996/10/04 16:07:10  andreww
[Bug #1592]
propagating type name level information.

 * Revision 1.13  1995/04/05  09:47:01  matthew
 * Use Stamp instead of Tyname_id etc.
 * \nImprovements to copying structures
 * for functors and signatures
 *
Revision 1.12  1995/02/07  14:40:29  matthew
Adding phi functions

Revision 1.11  1993/04/08  10:40:35  matthew
Simplified interface.  Added abstract_sigma function

Revision 1.10  1993/03/09  13:03:54  matthew
Options & Info changes
Str to Structure

Revision 1.9  1993/02/08  16:48:33  matthew
Removed open Datatypes, Changes for BASISTYPES signature

Revision 1.8  1992/11/26  17:16:45  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.7  1992/10/30  16:09:39  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.6  1992/08/11  18:05:11  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.5  1992/07/17  10:29:37  jont
Changed to use btrees for renaming of tynames and strnames

Revision 1.4  1992/07/04  17:16:06  jont
Anel's changes for improved structure copying

Revision 1.3  1991/11/21  16:54:34  jont
Added copyright message

Revision 1.2  91/11/19  12:19:18  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:06  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:45:49  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(* A Sigma is a value in the class Sig defined in the Definition
(p31), a pair of a NameSet and a Str. This module defines the type
Sigma and functions over that type, all of which are simple. *)

require "basistypes";
require "../main/options";

signature SIGMA =
  sig
    structure BasisTypes : BASISTYPES
    structure Options : OPTIONS
    val string_sigma : Options.print_options -> BasisTypes.Sigma -> string
    val string_phi : Options.print_options -> BasisTypes.Phi -> string

      (* NB, the extra int arg to the next three functions
         carry the level for new type names. *)

    val sig_copy : BasisTypes.Sigma * bool -> int -> BasisTypes.Sigma
    val phi_copy : BasisTypes.Phi * bool -> int -> BasisTypes.Phi
    val abstract_sigma : BasisTypes.Sigma -> int -> BasisTypes.Sigma

    val new_names_of : BasisTypes.Datatypes.Structure -> BasisTypes.Nameset
    val names_of : BasisTypes.Datatypes.Structure -> BasisTypes.Nameset
    val names_of_env : BasisTypes.Datatypes.Env -> BasisTypes.Nameset

  end
