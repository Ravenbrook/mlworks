(* environment.sml the signature *)
(*
$Log: environment.sml,v $
Revision 1.24  1997/05/01 12:55:32  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.23  1996/07/03  15:22:02  jont
 * Change check for free imperative type variables to return
 * the full type as well as the type variable
 *
 * Revision 1.22  1995/12/04  10:55:22  jont
 * Modify no_imptyvars to return the offending tyvar if it exists
 *
Revision 1.21  1995/03/31  16:16:58  matthew
Use Stamp instead of Tyname_id etc.

Revision 1.20  1995/02/07  10:46:47  matthew
Improvement to unbound long id errors

Revision 1.19  1994/09/22  15:41:56  matthew
Added environment lookup functions for vals  and tycons
/

Revision 1.18  1993/06/14  18:36:27  daveb
Removed exception environments.

Revision 1.17  1993/03/09  13:02:09  matthew
Str to Structure

Revision 1.16  1993/02/19  12:45:21  matthew
Removed z from function names
Removed str_enriches

Revision 1.15  1993/02/17  15:36:01  jont
Put compose_maps in the signature

Revision 1.14  1993/02/08  16:04:31  matthew
Removed open Datatypes, Changes for BASISTYPES signature

Revision 1.13  1993/02/01  14:20:26  matthew
Added compression functions.
These aren't currently used as they don't seem to work.

Revision 1.12  1992/12/18  15:42:14  matthew
Propagating options to signature matching error messages.
,

Revision 1.11  1992/10/30  15:51:09  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.10  1992/08/27  18:45:09  davidt
Made various changes so that structure copying can be
done more efficiently.

Revision 1.9  1992/08/11  12:06:07  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.8  1992/08/03  10:00:36  jont
Anel's changes to use NewMap instead of Map

Revision 1.7  1992/07/17  13:22:05  jont
Changed to use btrees for renaming of tynames and strnames

Revision 1.6  1992/07/04  17:16:03  jont
Anel's changes for improved structure copying

Revision 1.5  1992/02/11  10:05:20  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.4  1991/11/21  16:51:21  jont
Added copyright message

Revision 1.3  91/11/20  10:30:16  richard
Removed the empty structure environment to the Strenv module.

Revision 1.2  91/11/19  12:18:51  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:12:55  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:43:33  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(*

The type Env corresponds to the class Env of semantic objects, as
defined in the Definition, p17. An Env is a tuple of other
environments. The type is defined in datatypes.sml. The functions
acting on Env mostly deal with extracting and adding information to
the sub-environments, and are all simple. 

*)

require "../typechecker/datatypes";

signature ENVIRONMENT =
  sig
    structure Datatypes : DATATYPES

    exception LookupStrId of Datatypes.Ident.StrId

    val empty_env : Datatypes.Env 
    val empty_envp : Datatypes.Env -> bool
    val env_plus_env : Datatypes.Env * Datatypes.Env -> Datatypes.Env
    val SE_in_env : Datatypes.Strenv -> Datatypes.Env
    val TE_in_env : Datatypes.Tyenv -> Datatypes.Env
    val VE_in_env : Datatypes.Valenv -> Datatypes.Env
    val VE_TE_in_env : Datatypes.Valenv * Datatypes.Tyenv -> Datatypes.Env
    val abs : Datatypes.Tyenv * Datatypes.Env -> Datatypes.Env
    val string_environment : Datatypes.Env -> string
    val string_str : Datatypes.Structure -> string
    val no_imptyvars : Datatypes.Env -> (Datatypes.Type * Datatypes.Type) option
    val lookup_strid : Datatypes.Ident.StrId * Datatypes.Env -> Datatypes.Structure option
    val lookup_longtycon : Datatypes.Ident.LongTyCon * Datatypes.Env -> Datatypes.Tystr
    val lookup_longvalid : Datatypes.Ident.LongValId * Datatypes.Env -> Datatypes.Typescheme
    val lookup_longstrid : Datatypes.Ident.LongStrId * Datatypes.Env -> Datatypes.Structure
    val compose_maps :
      ((Datatypes.Strname Datatypes.StampMap * Datatypes.Tyname Datatypes.StampMap) *
       (Datatypes.Strname Datatypes.StampMap * Datatypes.Tyname Datatypes.StampMap)) ->
      (Datatypes.Strname Datatypes.StampMap * Datatypes.Tyname Datatypes.StampMap)
    val str_copy : 
      Datatypes.Structure * (Datatypes.Strname) Datatypes.StampMap *
      Datatypes.Tyname Datatypes.StampMap -> Datatypes.Structure
    val resolve_top_level : Datatypes.Structure -> Datatypes.Structure
    val expand_str : Datatypes.Structure -> Datatypes.Structure
    val expand_env : Datatypes.Env -> Datatypes.Env
    val initial_env : Datatypes.Env
    val initial_env_for_builtin_library : Datatypes.Env
    val struct_eq : Datatypes.Structure * Datatypes.Structure -> bool
    val compress_str : Datatypes.Structure -> Datatypes.Structure
  end


