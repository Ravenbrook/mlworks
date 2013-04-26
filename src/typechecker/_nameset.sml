(* _nameset.sml the functor *)
(*
$Log: _nameset.sml,v $
Revision 1.36  1999/02/02 16:01:47  mitchell
[Bug #190500]
Remove redundant require statements

 * Revision 1.35  1997/05/01  13:20:01  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.34  1996/10/02  13:48:48  andreww
 * [Bug #1592]
 * Adding "char" type name to initial_nameset.
 *
 * Revision 1.33  1996/02/22  11:59:48  jont
 * Replacing Map with NewMap
 *
 * Revision 1.32  1995/08/10  14:46:47  daveb
 * Added types for different lengths of words, ints and reals.
 *
Revision 1.31  1995/03/28  16:20:19  matthew
Fix for rigid tynames in functor result problem

Revision 1.30  1995/02/02  13:46:00  matthew
Removing debug stuff

Revision 1.29  1994/02/28  06:08:05  nosa
Extra TYNAME valenv for Modules Debugger.

Revision 1.28  1994/01/05  12:09:13  matthew
Added --
remove_strname -- delete a strname from a nameset
simple_copy -- make a duplicate nameset

Revision 1.27  1993/11/30  11:27:54  matthew
Added is_abs field to TYNAME and METATYNAME

Revision 1.26  1993/09/23  12:55:14  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.25  1993/07/30  11:29:49  nosa
Changed type of constructor NULL_TYFUN for value printing in
local and closure variable inspection in the debugger.

Revision 1.24  1993/05/21  15:59:41  matthew
Handle Tyfun_id.Map.Undefined

Revision 1.23  1993/05/20  12:55:39  jont
Added nameset_rehash to deal with the effects of sharing and realisation

Revision 1.22  1993/04/08  11:43:39  matthew
Removed duplication between copying functions
Added nameset_rigid_copy for use in abstraction semantics

Revision 1.21  1993/03/17  18:31:49  matthew
Added NamesetTypes structure
/

Revision 1.20  1993/03/04  10:32:59  matthew
Options & Info changes

Revision 1.19  1993/02/26  11:48:46  jont
Modified to use the new hashset with variable size tables

Revision 1.18  1993/02/08  17:38:20  matthew
Changes for BASISTYPES signature

Revision 1.17  1992/12/01  18:51:54  jont
Modified to use new improved hashset signature

Revision 1.16  1992/11/25  20:27:38  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.15  1992/10/30  16:03:57  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.14  1992/10/23  13:19:51  clive
Some bug fixes from Anel

Revision 1.13  1992/09/16  12:27:47  jont
Removed yet another silly handler

Revision 1.12  1992/09/08  17:05:13  jont
Added updating of valenvs within metatynames when copying, to assist
the interpreter with printing out types

Revision 1.11  1992/09/01  16:31:39  jont
Stuff to understand type functions properly

Revision 1.10  1992/08/27  18:38:22  davidt
Made various changes so that structure copying can be
done more efficiently.

Revision 1.9  1992/08/11  17:42:42  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.8  1992/08/04  19:51:39  davidt
Took out some long bits of commented out code, and replaced
most to_list calls with folds.

Revision 1.7  1992/07/17  10:17:37  jont
Changed to use btrees for renaming of tynames and strnames

Revision 1.6  1992/07/04  17:15:54  jont
Anel's changes for improved structure copying

Revision 1.5  1992/06/30  10:28:33  jont
Changed to imperative implementation of namesets with hashing

Revision 1.1  1992/04/21  17:03:09  jont
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)

require "../utils/print";
require "../utils/crash";
require "../typechecker/types";
require "../typechecker/strnames";
require "stamp";
require "namesettypes";

require "../typechecker/nameset";

functor Nameset(
  structure Crash : CRASH
  structure Print : PRINT
  structure Types : TYPES
  structure NamesetTypes : NAMESETTYPES
  structure Stamp : STAMP

  structure Strnames : STRNAMES
  sharing Types.Datatypes = Strnames.Datatypes

  sharing type NamesetTypes.TynameSet.element = Types.Datatypes.Tyname
  sharing type NamesetTypes.StrnameSet.element = Types.Datatypes.Strname
  sharing type Types.Datatypes.Stamp = Stamp.Stamp
  sharing type Types.Datatypes.StampMap = Stamp.Map.T
) : NAMESET =
  struct
    structure Datatypes = Types.Datatypes
    structure Options = Types.Options
    structure TynameSet = NamesetTypes.TynameSet
    structure StrnameSet = NamesetTypes.StrnameSet

    type Nameset = NamesetTypes.Nameset

    open Datatypes

    val initial_tynameset_size = 32
    val initial_strnameset_size = 16

    fun empty_nameset () =
      NamesetTypes.NAMESET(NamesetTypes.TynameSet.empty_set initial_tynameset_size,
			 NamesetTypes.StrnameSet.empty_set initial_strnameset_size)

    fun member_of_tynames (tyname,NamesetTypes.NAMESET(tynames,_)) = 
      NamesetTypes.TynameSet.is_member(tynames, tyname)

    fun member_of_strnames (strname,NamesetTypes.NAMESET(_,strnames)) = 
      NamesetTypes.StrnameSet.is_member(strnames, strname)

    fun union (NamesetTypes.NAMESET(tynames,strnames),NamesetTypes.NAMESET(tynames',strnames')) =
      NamesetTypes.NAMESET(NamesetTypes.TynameSet.union(tynames,tynames'),
                           NamesetTypes.StrnameSet.union (strnames,strnames'))


    fun intersection (NamesetTypes.NAMESET(tynames,strnames),NamesetTypes.NAMESET(tynames',strnames')) = 
      NamesetTypes.NAMESET(NamesetTypes.TynameSet.intersection(tynames,tynames'),
                           NamesetTypes.StrnameSet.intersection (strnames,strnames'))

    fun nameset_eq (NamesetTypes.NAMESET(tynames,strnames),NamesetTypes.NAMESET(tynames',strnames')) = 
      NamesetTypes.TynameSet.seteq(tynames,tynames')
      andalso
      NamesetTypes.StrnameSet.seteq(strnames,strnames')

    fun emptyp nameset =
      nameset_eq (nameset, empty_nameset())

    fun no_tynames (NamesetTypes.NAMESET(tynames,_)) = NamesetTypes.TynameSet.empty_setp tynames

    fun add_tyname (name,NamesetTypes.NAMESET(tynames,strnames)) =
      NamesetTypes.NAMESET(NamesetTypes.TynameSet.add_member(tynames, name),strnames)

    fun add_strname (name,NamesetTypes.NAMESET(tynames,strnames)) = 
      NamesetTypes.NAMESET(tynames, NamesetTypes.StrnameSet.add_member(strnames, name))

    fun tynames_in_nameset (tynames,NamesetTypes.NAMESET(tynames',strnames)) = 
      NamesetTypes.NAMESET(NamesetTypes.TynameSet.add_list(tynames', tynames),strnames)

    (****
     local_setdiff removes all the elements of the second argument that are
     members of the first argument from the first argument.
     ****)

    fun remove_tyname (name,NamesetTypes.NAMESET(tynames,strnames)) = 
      NamesetTypes.NAMESET(NamesetTypes.TynameSet.remove_member(tynames, name),strnames)

    fun remove_strname (name,NamesetTypes.NAMESET(tynames,strnames)) = 
      NamesetTypes.NAMESET(tynames,NamesetTypes.StrnameSet.remove_member(strnames, name))

    fun diff (NamesetTypes.NAMESET(tynames,strnames),NamesetTypes.NAMESET(tynames',strnames')) =
      NamesetTypes.NAMESET(NamesetTypes.TynameSet.setdiff(tynames,tynames'),
                           NamesetTypes.StrnameSet.setdiff (strnames,strnames'))

    val initial_nameset =
      NamesetTypes.NAMESET(NamesetTypes.TynameSet.list_to_set
                         [Types.bool_tyname,
                          Types.int_tyname,
                          Types.word_tyname,
                          Types.int8_tyname,
                          Types.word8_tyname,
                          Types.int16_tyname,
                          Types.word16_tyname,
                          Types.int32_tyname,
                          Types.word32_tyname,
                          Types.int64_tyname,
                          Types.word64_tyname,
                          Types.real_tyname,
                          Types.float32_tyname,
                          Types.string_tyname,
                          Types.char_tyname,
                          Types.list_tyname,
                          Types.ref_tyname,
                          Types.exn_tyname],
                         NamesetTypes.StrnameSet.empty_set initial_strnameset_size)

    val initial_nameset_for_builtin_library =
      initial_nameset

    fun string_nameset options (NamesetTypes.NAMESET(tynames,strnames)) =
      "NAMESET ({" ^ (NamesetTypes.TynameSet.set_print(tynames, Types.debug_print_name)) ^ "}{" ^
      (NamesetTypes.StrnameSet.set_print(strnames, Strnames.string_strname)) ^ "})"

    local
      val doCopyRigidTyname = Types.create_tyname_copy true

      val doCopyRigidStrname = Strnames.create_strname_copy true

      val doNewTyname = Types.create_tyname_copy false

      val doNewStrname = Strnames.create_strname_copy false

      fun copy
        (tynamecopyfun,strnamecopyfun)
        (NamesetTypes.NAMESET(tynames,strnames),
         strname_copies,tyname_copies) newTynameLevel = 
	let
          (* Make copies of the nameset *)
	  val tyname_copies' =
	    NamesetTypes.TynameSet.fold (tynamecopyfun newTynameLevel)
                                        (tyname_copies, tynames)
	  val strname_copies' =
	    NamesetTypes.StrnameSet.fold strnamecopyfun 
                                         (strname_copies, strnames)

          (* Remove instantiations of METATYNAMES *)
	  fun strip_tyname(meta as METATYNAME{1 = ref(NULL_TYFUN _), ...}) =
	    meta
	    | strip_tyname(METATYNAME{1=ref(ETA_TYFUN tyname), ...}) =
	      strip_tyname tyname
	    | strip_tyname _ = Crash.impossible"strip_tyname"

          (* Is the difference with the one in _types significant? *)
	  fun copy_type(METATYVAR(ref(i, ty,instances), eq, imp)) =
	    METATYVAR(ref(i, copy_type ty,instances), eq, imp)
	    | copy_type(METARECTYPE(ref(i, flex, ty, eq, imp))) =
	      METARECTYPE(ref(i, flex, copy_type ty, eq, imp))
	    | copy_type(RECTYPE map) =
	      RECTYPE(NewMap.map copy_type_map map)
	    | copy_type(FUNTYPE(ty1, ty2)) =
	      FUNTYPE(copy_type ty1, copy_type ty2)
	    | copy_type(CONSTYPE(type_list, tyname)) =
	      let
		val type_list = map copy_type type_list
		val tyname = case tyname of
		  TYNAME {1=id,...} => 
                    (case Stamp.Map.tryApply'(tyname_copies', id) of
                       SOME tyname' => tyname'
                     | _ => tyname)
		| METATYNAME(r as ref tyfun, s, ar, ref eq, ref ve, ref is_abs) =>
		    if Types.null_tyfunp tyfun then
		      let
                        val stripped_tyname = strip_tyname tyname
			val (r, id) = case stripped_tyname of
			  METATYNAME{1=r as ref(NULL_TYFUN (id,_)), ...} =>
			    (r, id)
			| _ => Crash.impossible"strip_tyname2"
		      in
			case Stamp.Map.tryApply'(tyname_copies', id) of
                          SOME x => x
                        | _ => stripped_tyname
		      end
		    else
		      tyname
	      in
		CONSTYPE(type_list, tyname)
	      end
	    | copy_type ty = ty

	  and copy_type_map(_, ty) = copy_type ty

	  fun copy_type_for_scheme(FUNTYPE(ty, _)) =
	    FUNTYPE(copy_type ty, NULLTYPE)
	    | copy_type_for_scheme _ = NULLTYPE

	  and copy_scheme(scheme as OVERLOADED_SCHEME _) = scheme
	    | copy_scheme(UNBOUND_SCHEME (ty,instance)) =
	      UNBOUND_SCHEME(copy_type_for_scheme ty,instance)
	    | copy_scheme(SCHEME(i, (ty,instance))) =
	      SCHEME(i, (copy_type_for_scheme ty,instance))

	  fun new_valenvs(meta as METATYNAME(ref(NULL_TYFUN id), s, arity,
					     ref eq, r as
					     ref(VE(_,mapping)),
                                             ref is_abs)) =
	    let
	      val mapping = NewMap.map (copy_scheme o #2) mapping
	    in
	      r := VE(ref 0, mapping)
	    end
            | new_valenvs(TYNAME{5= r as ref(VE(_, mapping)) ,...}) =
              let
                val mapping = 
                  NewMap.map (copy_scheme o #2) mapping
              in
                r := VE(ref 0, mapping)
              end
	    | new_valenvs _ = ()

          fun findstrname (strname as METASTRNAME (ref (NULLNAME id)),
                           strname_map) =
            Stamp.Map.apply_default'(strname_map, strname, id)
            | findstrname (strname as METASTRNAME (ref name),copies) = 
              findstrname (name,copies)
            | findstrname (strname,_) = strname

          fun findtyname (tyname as METATYNAME {1=ref (NULL_TYFUN (id,_)), ...},
                          tyname_map) =
            Stamp.Map.apply_default'(tyname_map, tyname, id)
            | findtyname (METATYNAME {1 = ref (ETA_TYFUN 
                                               (tyname as METATYNAME 
                                                {1 = ref tyfun,...})),...},
              copies) = findtyname (tyname,copies)
            | findtyname (METATYNAME {1 = ref (TYFUN 
                                               (CONSTYPE ([],tyname as METATYNAME 
                                                          {1 = ref tyfun,...}),
                                                _)),...},
              copies) = findtyname (tyname,copies)
            | findtyname (tyname as METATYNAME {1=ref tyfun, ...},_) = tyname
            | findtyname (tyname as TYNAME {1= id,...},tyname_map) =
              Stamp.Map.apply_default'(tyname_map, tyname, id)

          fun substTynameCopies tyname_copies (res, tyname) =
            NamesetTypes.TynameSet.add_member (res, findtyname(tyname, tyname_copies))

          fun substStrnameCopies strname_copies (res, strname) =
            NamesetTypes.StrnameSet.add_member (res, findstrname(strname, strname_copies))

	  val tynames' =
	    NamesetTypes.TynameSet.fold (substTynameCopies tyname_copies')
	    (NamesetTypes.TynameSet.empty_set (NamesetTypes.TynameSet.set_size tynames div 2),
	     tynames)
	  val strnames' =
	    NamesetTypes.StrnameSet.fold (substStrnameCopies strname_copies')
	    (NamesetTypes.StrnameSet.empty_set(NamesetTypes.StrnameSet.set_size strnames div 2),
	     strnames)
	  val _ = NamesetTypes.TynameSet.iterate new_valenvs tynames'
	in
	  (NamesetTypes.NAMESET(tynames',strnames'), strname_copies',tyname_copies')
	end
    in
      val nameset_rigid_copy = copy (doCopyRigidTyname,doCopyRigidStrname)
      (****
       new_names instantiate every flexible name to a new distinct 
       name - used in rule 64.  Necessary for correct sharing.
       See test t4.sml.
       ****)

      val new_names =  copy (doNewTyname,doNewStrname)

      val nameset_copy = new_names

      fun new_names_from_scratch nameset = 
                new_names (nameset, Stamp.Map.empty, Stamp.Map.empty)
    end

    (* these next three functions added 6.6.91 by nickh to enable the
     spec-encoding and decoding *)

    fun tynames_of_nameset (NamesetTypes.NAMESET(tl,sl)) = NamesetTypes.TynameSet.set_to_list tl
    fun strnames_of_nameset (NamesetTypes.NAMESET(tl,sl)) = NamesetTypes.StrnameSet.set_to_list sl
    fun nameset_of_name_lists (tl,sl) =
      NamesetTypes.NAMESET (NamesetTypes.TynameSet.list_to_set tl,NamesetTypes.StrnameSet.list_to_set sl)

    fun simple_copy nameset =
      nameset_of_name_lists (tynames_of_nameset nameset,
                             strnames_of_nameset nameset)

    fun nameset_rehash(NamesetTypes.NAMESET(tl,sl)) =
      (TynameSet.rehash tl; StrnameSet.rehash sl)
  end
