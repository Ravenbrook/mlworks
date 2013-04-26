(* basis.sml the signature *)
(*
$Log: basis.sml,v $
Revision 1.27  1997/05/01 12:55:00  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.26  1996/10/04  16:16:38  andreww
 * [Bug #1592]
 * adding an extra function, tynamesIncludedIn
 *
 * Revision 1.25  1996/08/06  10:32:17  andreww
 * [Bug #1521]
 * propagating changes to _types.sml
 *
 * Revision 1.24  1996/03/29  12:26:24  matthew
 * Adding env_to_context function
 *
 * Revision 1.23  1996/03/19  15:55:57  matthew
 * Adding value polymorphism option
 *
 * Revision 1.22  1995/12/27  11:08:59  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.21  1995/12/18  12:16:13  matthew
Passing error info into close

Revision 1.20  1995/03/23  12:03:11  matthew
Use Stamp instead of Tyname_id etc.

Revision 1.19  1995/02/07  16:09:58  matthew
Improvement to unbound long id errors

Revision 1.18  1995/01/17  13:36:48  matthew
Rationalizing debugger

Revision 1.17  1994/09/22  15:47:50  matthew
Changed type of lookup_val

Revision 1.16  1994/05/11  14:17:28  daveb
testing new overloading scheme.

Revision 1.15  1994/02/21  23:12:34  nosa
generate_moduler compiler option required in type variable instantiation.

Revision 1.14  1993/12/16  13:01:58  matthew
Added level field to Basis.
Renamed Basis.level to Basis.context_level

Revision 1.13  1993/08/11  12:35:23  nosa
lookup_val now returns runtime_instance for polymorphic debugger.

Revision 1.12  1993/04/26  16:19:35  jont
Added remove_str for getting rid of FullPervasiveLibrary_ from initial env

Revision 1.11  1993/03/09  13:00:24  matthew
Str to Structure

Revision 1.10  1993/02/08  16:04:13  matthew
Removed open Datatypes
Changes for BasisTypes

Revision 1.9  1993/02/01  14:20:29  matthew
Added sharing

Revision 1.8  1992/12/01  16:00:16  matthew
Changed handling of overloaded variable errors.

Revision 1.7  1992/10/01  12:02:34  richard
Moved chain reducing code here from _toplevel.

Revision 1.6  1992/08/12  12:58:10  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.5  1992/02/11  10:03:03  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.4  1991/11/21  16:49:49  jont
*** empty log message ***

Revision 1.3  91/11/19  12:18:39  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.2.1.1  91/11/19  11:12:52  jont
Added comments for DRA on functions

Revision 1.2  91/06/28  15:00:49  nickh
Added empty_basis value.

Revision 1.1  91/06/07  11:42:18  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(* The types Basis and Context correspond to the semantic object
classes Basis and Context respectively, as defined in the definition
(p17,31). This module defines the types (which are both product types
of other types) and the commonly used functions over them which are
all described in the Definition *)

require "basistypes";

signature BASIS =
  sig
    structure BasisTypes : BASISTYPES

    exception LookupValId of BasisTypes.Datatypes.Ident.ValId
    exception LookupTyCon of BasisTypes.Datatypes.Ident.TyCon
    exception LookupStrId of BasisTypes.Datatypes.Ident.StrId
    exception LookupTyvar
    exception LookupSigId
    exception LookupFunId

    type error_info
    type print_options
    type options
    (* sigenvs *)

    val empty_sigenv : BasisTypes.Sigenv
    val add_to_sigenv : BasisTypes.Datatypes.Ident.SigId * BasisTypes.Sigma * 
                        BasisTypes.Sigenv -> BasisTypes.Sigenv
    val sigenv_plus_sigenv : BasisTypes.Sigenv * BasisTypes.Sigenv 
                          -> BasisTypes.Sigenv 

    (* funenvs *)
    val empty_funenv : BasisTypes.Funenv
    val add_to_funenv : BasisTypes.Datatypes.Ident.FunId * BasisTypes.Phi 
                      * BasisTypes.Funenv -> BasisTypes.Funenv
    val funenv_plus_funenv : BasisTypes.Funenv * BasisTypes.Funenv 
                          -> BasisTypes.Funenv 

    val lookup_tyvar : BasisTypes.Datatypes.Ident.TyVar * BasisTypes.Context
                    -> BasisTypes.Datatypes.Type

    (* Can raise LookupStrid or LookupValId *)
    val lookup_val :
      BasisTypes.Datatypes.Ident.LongValId * 
      BasisTypes.Context * 
      BasisTypes.Datatypes.Ident.Location.T * 
      bool ->
      BasisTypes.Datatypes.Type * 
      (BasisTypes.Datatypes.InstanceInfo * 
       BasisTypes.Datatypes.Instance ref option)

    (* Can raise LookupTyCon *)
    val lookup_tycon : 
      BasisTypes.Datatypes.Ident.TyCon * BasisTypes.Context 
      -> BasisTypes.Datatypes.Tystr

    (* Can raise LookupStrid or LookupTyCon *)
    val lookup_longtycon : 
      BasisTypes.Datatypes.Ident.LongTyCon * BasisTypes.Context 
      -> BasisTypes.Datatypes.Tystr

    val get_tyvarset : BasisTypes.Context -> 
                       BasisTypes.Datatypes.Ident.TyVar BasisTypes.Set.Set

    val context_plus_env : BasisTypes.Context * BasisTypes.Datatypes.Env
                       -> BasisTypes.Context
    val context_plus_ve : BasisTypes.Context * BasisTypes.Datatypes.Valenv
                       -> BasisTypes.Context
    val context_plus_te : BasisTypes.Context * BasisTypes.Datatypes.Tyenv 
                       -> BasisTypes.Context

    val context_plus_tyvarset :
      BasisTypes.Context * 
      BasisTypes.Datatypes.Ident.TyVar BasisTypes.Set.Set ->
      BasisTypes.Context

    val context_plus_tyvarlist :
      BasisTypes.Context * BasisTypes.Datatypes.Ident.TyVar list 
   -> BasisTypes.Context

    val context_for_datbind : 
      BasisTypes.Context * string *
      (BasisTypes.Datatypes.Ident.TyVar list * 
       BasisTypes.Datatypes.Ident.TyCon) list -> 
       BasisTypes.Context

    val context_level : BasisTypes.Context -> int

    val close :
      (error_info * options * BasisTypes.Datatypes.Ident.Location.T) ->
      int * BasisTypes.Datatypes.Valenv * 
      BasisTypes.Datatypes.Ident.ValId list * 
      BasisTypes.Datatypes.Ident.TyVar BasisTypes.Set.Set * bool -> 
      BasisTypes.Datatypes.Valenv

    val basis_to_context : BasisTypes.Basis -> BasisTypes.Context
    val env_of_context : BasisTypes.Context -> BasisTypes.Datatypes.Env
    val te_of_context : BasisTypes.Context -> BasisTypes.Datatypes.Tyenv
    val env_to_context : BasisTypes.Datatypes.Env -> BasisTypes.Context

    (* Can raise LookupStrid *)
    val lookup_longstrid : 
         BasisTypes.Datatypes.Ident.LongStrId * BasisTypes.Basis
      -> BasisTypes.Datatypes.Structure
    val basis_plus_env : BasisTypes.Basis * BasisTypes.Datatypes.Env 
                      -> BasisTypes.Basis
    val env_in_basis : BasisTypes.Datatypes.Env -> BasisTypes.Basis

    val basis_plus_names : BasisTypes.Basis * BasisTypes.Nameset 
                        -> BasisTypes.Basis

    val basis_plus_sigenv : BasisTypes.Basis * BasisTypes.Sigenv 
                         -> BasisTypes.Basis
    val sigenv_in_basis : BasisTypes.Sigenv -> BasisTypes.Basis

    (* Can raise LookupSigId *)
    val lookup_sigid : BasisTypes.Datatypes.Ident.SigId * BasisTypes.Basis
                    -> BasisTypes.Sigma

    val basis_plus_funenv : BasisTypes.Basis * BasisTypes.Funenv 
                         -> BasisTypes.Basis
    val funenv_in_basis : BasisTypes.Funenv -> BasisTypes.Basis      

    (* Can raise LookupFunId *)
    val lookup_funid : BasisTypes.Datatypes.Ident.FunId * BasisTypes.Basis 
                    -> BasisTypes.Phi

(*
    val basis_plus_basis : BasisTypes.Basis * BasisTypes.Basis 
                         -> BasisTypes.Basis
*)
    val basis_circle_plus_basis : BasisTypes.Basis * BasisTypes.Basis 
                               -> BasisTypes.Basis

    val basis_level : BasisTypes.Basis -> int

    val initial_basis : BasisTypes.Basis
    val initial_basis_for_builtin_library : BasisTypes.Basis

    val empty_basis : BasisTypes.Basis

    val reduce_chains : BasisTypes.Basis -> unit

    val remove_str :
      BasisTypes.Basis * BasisTypes.Datatypes.Ident.StrId -> BasisTypes.Basis

    val add_str :
      BasisTypes.Basis * BasisTypes.Datatypes.Ident.StrId * 
      BasisTypes.Datatypes.Structure -> BasisTypes.Basis

    val add_val :
      BasisTypes.Basis * BasisTypes.Datatypes.Ident.ValId * 
      BasisTypes.Datatypes.Typescheme -> BasisTypes.Basis

    val pervasive_stamp_count : int

    val tynamesNotIn: BasisTypes.Datatypes.Type
                    * BasisTypes.Context
                   -> BasisTypes.Datatypes.Tyname list

    val valEnvTynamesNotIn: BasisTypes.Datatypes.Valenv
                       * BasisTypes.Context
                      -> BasisTypes.Datatypes.Tyname list

end;
