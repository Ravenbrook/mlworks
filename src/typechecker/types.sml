(* types.sml the signature *)
(*
$Log: types.sml,v $
Revision 1.64  1997/05/01 12:56:21  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.63  1997/04/25  16:27:40  jont
 * [Bug #20017]
 * Add has_int32_equality function
 *
 * Revision 1.62  1996/12/18  16:31:58  andreww
 * [Bug #1818]
 * Adding new floatarray type name.
 *
 * Revision 1.61  1996/11/05  17:43:46  andreww
 * [Bug #1711]
 * Punning real tyname equality attribute with old_definition option.
 *
 * Revision 1.60  1996/10/04  15:57:22  andreww
 * [Bug #1592]
 * adding extra argument to create_tyname_copy (to pass a level
 * identifier around).
 *
 * Revision 1.59  1996/08/05  14:16:13  andreww
 * [Bug #1521]
 * Prevent imperative type variables being distinguished from applicative ones
 * under value polymorphism when being printed.
 *
 * Revision 1.58  1996/03/08  12:07:30  daveb
 * Converted the types Dynamic and Type to the new identifier naming scheme.
 *
 * Revision 1.57  1995/12/27  11:25:54  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.56  1995/12/05  11:37:14  jont
Modify has_free_imptyvars to return the offending tyvar if it exists
Add type_occurs to find if such a type occurs within another more
complicated type

Revision 1.55  1995/09/08  17:49:44  daveb
Added types for different lengths of words, ints and reals.

Revision 1.54  1995/08/22  16:00:59  jont
Add has_int_equality, has_real_equality, has_string_equality

Revision 1.53  1995/07/27  16:39:43  jont
Add word_typep and wordint_typep

Revision 1.52  1995/07/20  14:08:03  jont
Add word_type and word_tyname

Revision 1.51  1995/07/19  13:32:23  jont
Add char_type

Revision 1.50  1995/07/13  12:38:20  jont
Add char type for new revised basis

Revision 1.49  1995/04/10  10:20:17  matthew
Adding simplify_type function
Moving some functions out of here

Revision 1.48  1995/03/28  16:20:52  matthew
Use Stamp structure for ids

Revision 1.47  1995/02/16  12:33:46  matthew
Adding combine_types for use by the debugger

Revision 1.46  1995/02/02  14:32:52  matthew
Rationalizations.

Revision 1.45  1994/06/17  11:08:29  jont
Export string_debruijn

Revision 1.44  1994/05/11  14:38:45  daveb
Added int_typep, real_typep, and resolve_overloading.

Revision 1.43  1994/04/27  15:17:49  jont
Added functions for checking for uninstantiated tyvars

Revision 1.42  1994/02/21  23:21:39  nosa
Global tyfun instantiations and extra TYNAME valenv recording for Modules Debugger.

Revision 1.41  1993/11/24  15:48:18  nickh
Added hooks to print types with a set of remembered type variables.

Revision 1.40  1993/09/27  11:03:33  jont
Merging in bug fixes

Revision 1.39  1993/08/16  10:22:01  nosa
Function all_tyvars that returns all METATYVAR- and TYVAR- refs
for polymorphic debugger.

Revision 1.38.1.2  1993/09/23  15:34:43  jont
Added make_true for doing equality_principal algorithm

Revision 1.38.1.1  1993/07/30  15:12:08  jont
Fork for bug fixing

Revision 1.38  1993/07/30  15:12:08  nosa
structure Option.

Revision 1.37  1993/07/29  17:12:09  jont
Extra extra information debug_print_type

Revision 1.36  1993/04/26  17:48:15  daveb
Added print_tyvars and make_tyvars.

Revision 1.35  1993/04/08  16:14:08  matthew
Added type_type and closed_type_equalityp

Revision 1.34  1993/03/30  14:48:37  jont
Put tyfun_strip into the signature

Revision 1.33  1993/03/09  17:24:12  jont
Added string_or_num_typep for spotting overloading of relationals to strings.

Revision 1.32  1993/03/04  10:08:21  matthew
Options & Info changes

Revision 1.31  1993/03/02  15:17:46  matthew
Added rectype functions so functions from Mapping not needed

Revision 1.30  1993/03/01  11:03:15  matthew
Added vector and bytearray tynames

Revision 1.29  1993/02/25  15:51:52  matthew
Added array_tyname

Revision 1.28  1993/02/22  16:19:07  matthew
Added dynamic_types

Revision 1.27  1993/02/17  15:31:53  jont
Put tyname_copy in the signature

Revision 1.26  1993/02/08  13:29:56  matthew
Removed open Datatypes

Revision 1.25  1993/02/01  14:20:35  matthew
Removed TypeLocation type from Datatypes

Revision 1.24  1992/12/20  15:11:42  jont
Anel's last changes

Revision 1.23  1992/11/26  17:42:32  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.22  1992/10/30  15:07:45  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.21  1992/10/12  11:09:25  clive
Tynames now have a slot recording their definition point

Revision 1.20  1992/09/16  08:38:26  daveb
show_eq_info controls printing of equality attribute of tycons.

Revision 1.19  1992/09/08  13:04:25  jont
Removed has_a_new_name, no longer needed

Revision 1.18  1992/09/04  10:54:30  jont
Stuff to understand type functions properly

Revision 1.17  1992/08/27  19:36:43  davidt
Made various changes so that structure copying can be
done more efficiently.

Revision 1.16  1992/08/27  14:50:28  jont
removed val meta_tyname_eq

Revision 1.15  1992/08/13  17:09:09  davidt
Changed tyvars function to take a tuple of arguments.

Revision 1.14  1992/08/11  12:57:20  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.13  1992/07/27  10:13:16  richard
Added ml_value_tyname.

Revision 1.12  1992/07/16  18:39:19  jont
Changed to use btrees for renaming of tynames and strnames

Revision 1.11  1992/07/04  17:16:07  jont
Anel's changes for improved structure copying

Revision 1.10  1992/03/27  10:42:54  jont
Added new function tyvar_equalityp for where the equality attribute is
significant. The previous function type_equalityp now ignores the
equality attribute of type variables

Revision 1.9  1992/02/11  10:13:33  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.8  1992/01/23  15:49:57  jont
Added value giving tyfun_id_counter at end of defining pervasives

Revision 1.7  1992/01/15  12:06:49  clive
Added the array type

Revision 1.6  1992/01/07  19:19:56  colin
Added pervasive_tyname_count giving tyname id of first tyname after
the pervasives have been defined.

Revision 1.5  1992/01/07  16:20:53  colin
Removed last argument to calls to make_tyname
Removed no_of_cons

Revision 1.4  1991/11/21  16:55:49  jont
Added copyright message

Revision 1.3  91/11/19  12:19:28  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.2.1.1  91/11/19  11:13:11  jont
Added comments for DRA on functions

Revision 1.2  91/06/18  15:39:00  colin
Added functions (isFunType) to check for a funtype and (argres) to extract
argument and result types.

Revision 1.1  91/06/07  11:46:30  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(* The type Type is defined in datatypes.sml. This module defines a
host of simple functions on types and type names. *)


require "../typechecker/datatypes";
require "../main/options";

signature TYPES =
  sig
    structure Datatypes : DATATYPES
    structure Options: OPTIONS

    (* Tyname Utilities *)
    val make_tyname : (int * bool * string * string option
                       * int) -> Datatypes.Tyname
    val eq_attrib : Datatypes.Tyname -> bool
    (* test for a ref or array *)
    val has_ref_equality : Datatypes.Tyname -> bool
    val has_int_equality : Datatypes.Tyname -> bool
    val has_real_equality : Datatypes.Tyname -> bool
    val has_string_equality : Datatypes.Tyname -> bool
    val has_int32_equality : Datatypes.Tyname -> bool
    val print_name : Options.options -> Datatypes.Tyname  -> string
    val debug_print_name : Datatypes.Tyname  -> string
    val tyname_arity : Datatypes.Tyname -> int
    (* set the equality attribute to false *)
    val tyname_make_false : Datatypes.Tyname -> bool
    val tyname_eq : Datatypes.Tyname * Datatypes.Tyname -> bool
    val tyname_conenv : Datatypes.Tyname -> Datatypes.Valenv
    val tyname_strip : Datatypes.Tyname -> Datatypes.Tyname

    (* Builtin tynames *)
    val bool_tyname : Datatypes.Tyname
    val int_tyname : Datatypes.Tyname
    val word_tyname : Datatypes.Tyname 
    val int8_tyname : Datatypes.Tyname
    val word8_tyname : Datatypes.Tyname 
    val int16_tyname : Datatypes.Tyname
    val word16_tyname : Datatypes.Tyname 
    val int32_tyname : Datatypes.Tyname
    val word32_tyname : Datatypes.Tyname 
    val int64_tyname : Datatypes.Tyname
    val word64_tyname : Datatypes.Tyname 
    val real_tyname : Datatypes.Tyname
    val float32_tyname : Datatypes.Tyname
    val string_tyname : Datatypes.Tyname 
    val char_tyname : Datatypes.Tyname 
    val list_tyname : Datatypes.Tyname
    val ref_tyname : Datatypes.Tyname
    val exn_tyname : Datatypes.Tyname
    val ml_value_tyname : Datatypes.Tyname
    val array_tyname : Datatypes.Tyname
    val vector_tyname : Datatypes.Tyname
    val bytearray_tyname : Datatypes.Tyname
    val floatarray_tyname : Datatypes.Tyname
    val dynamic_tyname : Datatypes.Tyname
    val typerep_tyname : Datatypes.Tyname

    (* the equality attribute of the real tyname is going to be
       set whenever the oldDefinition option is set.  See
       interpreter/_shell_structure.sml *)
       
    val real_tyname_equality_attribute: bool ref

    (* Types *)

    val cons_typep : Datatypes.Type -> bool 
    val imperativep : Datatypes.Type -> bool
    val tyvar_equalityp : Datatypes.Type -> bool
    val type_equalityp : Datatypes.Type -> bool
    val closed_type_equalityp : Datatypes.Type -> bool
    val type_eq : Datatypes.Type * Datatypes.Type * bool * bool -> bool
    val simplify_type : Datatypes.Type -> Datatypes.Type

    (* Tests used for handling overloading *)
    val int_typep : Datatypes.Type -> bool
    val real_typep : Datatypes.Type -> bool
    val word_typep : Datatypes.Type -> bool
    val num_typep : Datatypes.Type -> bool
    val num_or_string_typep : Datatypes.Type -> bool
    val wordint_typep : Datatypes.Type -> bool
    val realint_typep : Datatypes.Type -> bool

    (* Print functions *)
    val print_type : Options.options -> Datatypes.Type -> string
    val debug_print_type : Options.options ->
                                 Datatypes.Type -> string
    val extra_debug_print_type : Datatypes.Type -> string
    val print_tyvars: Options.options -> Datatypes.Type list -> string

    (* Misc *)
    val type_of : Datatypes.Ident.SCon -> Datatypes.Type
    val has_free_imptyvars : Datatypes.Type -> Datatypes.Type option
    val type_occurs : Datatypes.Type * Datatypes.Type -> bool
    val the_type : Datatypes.Type -> Datatypes.Type
    (* accumulate non-meta tyvars *)
    val tyvars : Datatypes.Ident.TyVar list * Datatypes.Type -> Datatypes.Ident.TyVar list
    val all_tyvars : Datatypes.Type -> (int * Datatypes.Type * Datatypes.Instance) ref list
    val make_tyvars: int -> Datatypes.Type list

    (* Builtin types *)
    val int_type : Datatypes.Type
    val word_type : Datatypes.Type
    val int8_type : Datatypes.Type
    val word8_type : Datatypes.Type
    val int16_type : Datatypes.Type
    val word16_type : Datatypes.Type
    val int32_type : Datatypes.Type
    val word32_type : Datatypes.Type
    val int64_type : Datatypes.Type
    val word64_type : Datatypes.Type
    val real_type : Datatypes.Type
    val float32_type : Datatypes.Type
    val string_type : Datatypes.Type
    val char_type : Datatypes.Type
    val bool_type : Datatypes.Type
    val exn_type : Datatypes.Type
    val ml_value_type : Datatypes.Type
    val dynamic_type : Datatypes.Type
    val typerep_type : Datatypes.Type

    (* Return the size in bits of built-in numeric types. *)
    val sizeof: Datatypes.Type -> int option

    (* resolve overloaded types to their defaults.  The flag controls 
       whether functions such as + are resolved in this way as well. *)

    val resolve_overloading:
      bool * Datatypes.Type * 
      (Datatypes.Ident.ValId * Datatypes.Ident.Location.T -> unit) ->
      unit

    (* record types *)
    val empty_rectype : Datatypes.Type 
    val rectype_domain : Datatypes.Type -> Datatypes.Ident.Lab list
    val rectype_range : Datatypes.Type -> Datatypes.Type list
    val add_to_rectype : (Datatypes.Ident.Lab * Datatypes.Type 
                          * Datatypes.Type) -> Datatypes.Type 
    val get_type_from_lab : (Datatypes.Ident.Lab * Datatypes.Type) 
                            -> Datatypes.Type 

    val isFunType : Datatypes.Type -> bool

    exception ArgRes 
    (* extract the argument and result types from a funtype *)
    val argres : Datatypes.Type -> Datatypes.Type * Datatypes.Type

    (* Tyfun utilities *)

    val tyfun_strip : Datatypes.Tyfun -> Datatypes.Tyfun
    val null_tyfunp : Datatypes.Tyfun -> bool
    val make_tyfun :  Datatypes.Ident.TyVar list * Datatypes.Type -> 
                      Datatypes.Tyfun
    val make_eta_tyfun : Datatypes.Tyname -> Datatypes.Tyfun
    val apply : Datatypes.Tyfun * Datatypes.Type list -> Datatypes.Type

    val has_a_name : Datatypes.Tyfun -> bool
    val meta_tyname : Datatypes.Tyfun -> Datatypes.Tyname
    val name : Datatypes.Tyfun -> Datatypes.Tyname
    val arity : Datatypes.Tyfun -> int
    val tyfun_eq : Datatypes.Tyfun * Datatypes.Tyfun -> bool   
    val equalityp : Datatypes.Tyfun -> bool    
    val make_false : Datatypes.Tyfun -> bool
    val make_true : Datatypes.Tyname -> unit
    val string_tyfun : Datatypes.Tyfun -> string
    val update_tyfun_instantiations : Datatypes.Tyfun -> int
    val fetch_tyfun_instantiation : int -> Datatypes.Tyfun

    (* Debruijns *)
    val string_debruijn : Options.options * int * bool * bool -> string
    val check_debruijns : Datatypes.Type list * int -> bool

    (* Copying *)
    (* the bool indicates if copying is done rigidly *)
    val create_tyname_copy :
      bool -> int ->
      Datatypes.Tyname Datatypes.StampMap * Datatypes.Tyname ->
      Datatypes.Tyname Datatypes.StampMap

    val tyname_copy : Datatypes.Tyname * Datatypes.Tyname Datatypes.StampMap 
                      -> Datatypes.Tyname
    val tyfun_copy : Datatypes.Tyfun * Datatypes.Tyname Datatypes.StampMap
                      -> Datatypes.Tyfun
    val type_copy : Datatypes.Type * Datatypes.Tyname Datatypes.StampMap
                     -> Datatypes.Type

    (* Tyvars *)
    type seen_tyvars (* used to record which tyvars have been printed *)
    val no_tyvars : seen_tyvars
    val print_type_with_seen_tyvars :
      Options.options * Datatypes.Type * seen_tyvars -> string * seen_tyvars
    val type_has_unbound_tyvars : Datatypes.Type -> bool
    val tyfun_has_unbound_tyvars : Datatypes.Tyfun -> bool

    (* Used in the debugger *)
    exception CombineTypes
    val combine_types : Datatypes.Type * Datatypes.Type -> Datatypes.Type

    (* Stamps *)

    val stamp_num : Datatypes.Stamp -> int
    val make_stamp : unit -> Datatypes.Stamp
    val pervasive_stamp_count : int
  end;
