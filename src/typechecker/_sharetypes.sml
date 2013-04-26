(* _sharetypes.sml the functor *)
(*
$Log: _sharetypes.sml,v $
Revision 1.26  1996/03/27 17:01:06  matthew
Updating for new language revisions

 * Revision 1.25  1995/02/02  13:54:12  matthew
 * Removing debug stuff
 *
Revision 1.24  1993/11/30  11:50:35  matthew
Added is_abs field to TYNAME and METATYNAME

Revision 1.23  1993/05/26  09:34:14  matthew
Added sharing constraint

Revision 1.22  1993/05/25  15:26:33  jont
Changes because Assemblies now has Basistypes instead of Datatypes

Revision 1.21  1993/05/24  14:46:30  matthew
Removed debug statements.
Fixed bug with equality attributes.

Revision 1.20  1993/05/21  13:00:39  jont
Fixed up to check for illegal sharing in functor result signatures
ie trying to force extra sharing on the functor parameter

Revision 1.19  1993/05/20  16:48:22  jont
Avoid updating flexible names in the basis (when doing sharng in functor results)

Revision 1.18  1992/12/22  15:49:54  jont
Anel's last changes

Revision 1.17  1992/12/04  19:26:21  matthew
Error message revisions.

Revision 1.16  1992/11/26  18:04:29  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.15  1992/10/23  13:35:05  clive
Some bug fixes from Anel

Revision 1.14  1992/10/12  11:33:44  clive
Tynames now have a slot recording their definition point

Revision 1.13  1992/09/08  13:44:54  jont
Removed has_a_new_name, no longer needed

Revision 1.12  1992/09/04  11:00:13  jont
Stuff to understand type functions properly

Revision 1.11  1992/08/20  18:34:31  jont
Various improvements to remove garbage, handlers etc.

Revision 1.10  1992/08/17  11:56:46  jont
Modified to propagate valenvs from rigid types to flexible types

Revision 1.9  1992/08/13  15:53:08  jont
Added more checking for valenv consistency when sharing tyfuns

Revision 1.8  1992/08/12  17:18:08  jont
Fixed type sharing to propagate valenvs down whenever they're not empty

Revision 1.7  1992/08/11  13:54:44  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.6  1992/08/04  13:12:50  jont
Anel's changes to use NewMap instead of Map

Revision 1.5  1992/03/18  17:41:14  jont
Modified do_share_tyfun to ensure that when a type is shared with a
datatype the conenv is propagated into the type

Revision 1.4  1992/01/27  20:15:15  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.3  1992/01/24  16:54:14  jont
Updated to allow valenv in METATYNAME

Revision 1.2  1991/11/21  16:47:08  jont
Added copyright message

Revision 1.1  91/06/07  11:37:49  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/print";
require "../typechecker/sharetypes";
require "../typechecker/types";
require "../typechecker/valenv";
require "../typechecker/assemblies";
require "../typechecker/nameset";
require "../typechecker/namesettypes";

functor Sharetypes(
  structure Print : PRINT
  structure Types : TYPES
  structure Conenv : VALENV
  structure Assemblies : ASSEMBLIES
  structure Nameset : NAMESET
  structure NamesetTypes : NAMESETTYPES

  sharing Assemblies.Basistypes.Datatypes = 
    Types.Datatypes = Conenv.Datatypes = Nameset.Datatypes

  sharing type Nameset.Nameset = NamesetTypes.Nameset =
    Assemblies.Basistypes.Nameset
    ) : SHARETYPES =
  struct
    structure Assemblies = Assemblies
    structure Datatypes = Assemblies.Basistypes.Datatypes
    structure NamesetTypes = NamesetTypes

    (****
     Sharing of types are handled in this functor.
     ****)

    open Datatypes

    exception ShareError of string

    (****
     Determine the type function the flexible type name of the argument
     type function has been instantiated to.
     ****)

    fun strip (tyfun as ETA_TYFUN (METATYNAME{1=ref(NULL_TYFUN _), ...})) =
      tyfun
      | strip (ETA_TYFUN (METATYNAME{1=ref tyfun, ...})) = strip tyfun
      | strip tyfun = tyfun
	
    fun valenv_of_tyfun(ETA_TYFUN(TYNAME{5=ref valenv, ...})) = valenv
      | valenv_of_tyfun(TYFUN(CONSTYPE(_, TYNAME{5=ref valenv, ...}), _)) =
	valenv
      | valenv_of_tyfun _ = empty_valenv

    fun same_tyfun (ETA_TYFUN (METATYNAME{1=r as ref(NULL_TYFUN _), ...}),
		     ETA_TYFUN (METATYNAME{1=r' as ref(NULL_TYFUN _), ...})) = 
      r = r'
      | same_tyfun (TYFUN (CONSTYPE (_,METATYNAME{1=r as ref (NULL_TYFUN _),
						    ...}),_),
		     TYFUN (CONSTYPE (_,METATYNAME{1=r' as ref (NULL_TYFUN _),
						   ...}),_)) = r = r'
      | same_tyfun (ETA_TYFUN (METATYNAME{1=r as ref(NULL_TYFUN _), ...}),
		     TYFUN (CONSTYPE (_,METATYNAME{1=r' as ref (NULL_TYFUN _),
						   ...}),_)) = r = r'
      | same_tyfun (TYFUN (CONSTYPE (_,METATYNAME{1=r as ref(NULL_TYFUN _),
						   ...}),_),
		     ETA_TYFUN (METATYNAME{1=r' as ref(NULL_TYFUN _), ...})) =
	r = r'

      (****
       Otherwise one of them is instantiated to a tyfun of a rigid type
       and we can test for ordinary equality of tyfuns.
       ****)

      | same_tyfun (tyfun,tyfun') = Types.tyfun_eq (tyfun,tyfun')

    fun tystr_consistent (conenv,conenv') = 
      Conenv.empty_valenvp conenv
      orelse
      Conenv.empty_valenvp conenv'
      orelse
      Conenv.dom_valenv_eq (conenv,conenv')

    fun update_and_share
      (tyfun,tyfun',ce,ce',tyfun_ref,ty_ass,valenv_ref,valenv) = 
      let 
	val (ty_ass',count) = Assemblies.remfromTypeAssembly (tyfun, ty_ass)
	val (ty_ass'',count') = Assemblies.remfromTypeAssembly (tyfun',ty_ass')
	val _ = tyfun_ref := tyfun'
	val _ = valenv_ref := valenv
      in
	(true,Assemblies.add_to_TypeAssembly 
	 ((strip tyfun),ce,count,
	  Assemblies.add_to_TypeAssembly ((strip tyfun'),ce',count',ty_ass'')))
      end 

    fun update_eqrefs (eqref,eqref',neweq) =
      (eqref := neweq;
       eqref' := neweq)

    (****
     To ensure that the type assembly is updated correctly the entries
     corresponding to the tyfuns being shared are first removed from the 
     type assembly (once it has been determined that the sharing is 
     possible), then the references are updated (sharing done), and 
     then they are both added to the type assembly again. 
     There is also an attempt to ensure that flexible names in the basis
     are not updated by sharing constraints in functor result signatures.
     ****)

    fun do_share_tyfun(old_definition,
                       tyfun as ETA_TYFUN (meta as METATYNAME 
					   {1=r as ref (NULL_TYFUN _),
					    4=b,
					    5=ref_valenv,...}),
		       tyfun' as ETA_TYFUN (meta' as METATYNAME
					    {1=r' as ref (NULL_TYFUN _),
					     4=b',
					     5=ref_valenv',...}),ty_ass, nameset) =
      let
        val (ce as VE (_,vemap),_) = Assemblies.lookupTyfun (tyfun,ty_ass)
        val (ce' as VE(_,vemap'),_) = Assemblies.lookupTyfun (tyfun',ty_ass)
        val (ref_valenv, valenv) =
          if NewMap.is_empty vemap then
            (ref_valenv,ce')
          else (ref_valenv',ce)
      in
        if tystr_consistent (ce,ce') then
          if Types.arity (tyfun) = Types.arity (tyfun') then
            let
              val neweq =
                (* This extra check is necessary for the pathological ex 11.5 
                    in the Commentary *)
                if (not (NewMap.is_empty vemap)
                    andalso 
                    not (NewMap.is_empty vemap'))
                  then
                    (!b) andalso (!b')
                else
                  (!b) orelse (!b')
            in
              if Nameset.member_of_tynames(meta, nameset) then
                (if not(neweq = (!b))
                   then raise ShareError "incompatible equality attributes"
                 else ();
                 update_eqrefs(b,b',neweq);
                 update_and_share (tyfun',tyfun,ce',ce,r',ty_ass,
                                   ref_valenv,valenv))
              (* Point the non-basis one at the basis one *)
              else
                (if Nameset.member_of_tynames(meta',nameset) andalso
                   not(neweq = (!b'))
                   then raise ShareError "incompatible equality attributes"
                 else ();
                 update_eqrefs(b,b',neweq);
                 update_and_share (tyfun,tyfun',ce,ce',r,ty_ass,ref_valenv,valenv))
            end
          else
            raise ShareError "different arities"
        else
          raise ShareError "inconsistent value constructors"
      end

      | do_share_tyfun(old_definition,
                       tyfun as ETA_TYFUN (METATYNAME{1=r as ref(NULL_TYFUN _),
						     4=b as ref eq,
						     5=ref_valenv, ...}),
			tyfun',ty_ass, nameset) =
        if old_definition then
        let
          val (ce,_) = Assemblies.lookupTyfun (tyfun,ty_ass)
          val (ce',_) = Assemblies.lookupTyfun (tyfun',ty_ass)
        in
          if tystr_consistent (ce,ce') then
            if Types.arity (tyfun) = Types.arity (tyfun') then
              let
                val eq' = Types.equalityp tyfun'
              in
                if (eq andalso eq') orelse not eq then
                  (b := eq';
                   update_and_share (tyfun,tyfun',ce,ce',r,ty_ass,
                                     ref_valenv, ce'))
                else
                  raise ShareError "incompatible equality attributes"
              end
            else 
              raise ShareError "different arities"
          else
            raise ShareError "inconsistent value constructors"
        end
        else
      raise ShareError "sharing with rigid names"

	   
      | do_share_tyfun(old_definition,
                       tyfun,tyfun' as ETA_TYFUN(METATYNAME
						 {1=r as ref(NULL_TYFUN _),
						  4=b as ref eq,
						  5=ref_valenv,...}),
		       ty_ass, nameset) =
        if old_definition then
        let
          val (ce,_) = Assemblies.lookupTyfun (tyfun,ty_ass)
          val (ce',_) = Assemblies.lookupTyfun (tyfun',ty_ass)
        in
          if tystr_consistent (ce,ce') then
            if Types.arity (tyfun) = Types.arity (tyfun') then
              let
                val eq' = Types.equalityp tyfun
              in
                if (eq andalso eq') orelse not eq then
                  (b := eq';
                   update_and_share (tyfun',tyfun,ce',ce,r,ty_ass,
                                     ref_valenv,ce))
                else
                  raise ShareError "incompatible equality attributes"
              end
            else
              raise ShareError "different arities"
          else
            raise ShareError "inconsistent value constructors"
        end
      else
        raise ShareError "sharing with rigid names"
	     
      | do_share_tyfun(old_definition,tyfun, tyfun', ty_ass, nameset) =
        (false,ty_ass)

    fun get_meta(ETA_TYFUN meta) = meta
      | get_meta tyfun =
	METATYNAME(ref tyfun, "Bad tyname", 0, ref false, ref empty_valenv,ref false)

    fun share_tyfun (old_definition,tyfun, tyfun', ty_ass, nameset) = 
      let
        val tyfun = strip tyfun
        val tyfun' = strip tyfun'
      in
        if same_tyfun(tyfun, tyfun')
          then (true, ty_ass)
        else
          let
            val null = Types.null_tyfunp tyfun
            val null' = Types.null_tyfunp tyfun'
          in
            if null orelse null' then
              (* At least one is flexible *)
              let
                val bad =
                  (not null) orelse Nameset.member_of_tynames(get_meta tyfun, nameset)
                val bad' =
                  (not null') orelse Nameset.member_of_tynames(get_meta tyfun', nameset)
              (* Bad indicates rigid or flexible but in the nameset *)
              (* Can't share two such unless they are equal *)
              in
                if bad andalso bad' then
                  raise ShareError "different rigid types"
                else
                  do_share_tyfun(old_definition,tyfun, tyfun', ty_ass, nameset)
              end
            else
              raise ShareError "different rigid types"
          end
      end
  end
