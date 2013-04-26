(* _basis.sml the functor  *)
(*
$Log: _basis.sml,v $
Revision 1.43  1997/05/01 13:19:07  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.42  1996/10/04  16:16:53  andreww
 * [Bug #1592]
 * adding an extra function, tynamesIncludedIn
 *
 * Revision 1.41  1996/08/06  10:32:51  andreww
 * [Bug #1521]
 * Propagating changes made to _types.sml
 *
 * Revision 1.40  1996/03/29  12:28:28  matthew
 * Adding env_to_context function
 *
 * Revision 1.39  1996/03/19  15:55:31  matthew
 * Adding value polymorphism option
 *
 * Revision 1.38  1995/12/27  11:39:11  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.37  1995/12/18  12:16:04  matthew
Changing interface to Scheme

Revision 1.36  1995/03/31  16:23:01  matthew
Use Stamp instead of Tyname_id etc.

Revision 1.35  1995/02/07  16:04:11  matthew
Improvement to unbound long id errors

Revision 1.34  1995/01/30  11:45:58  matthew
Rationalizing debugger

Revision 1.33  1994/09/22  15:55:56  matthew
Efficiency improvements for lookup functions

Revision 1.32  1994/08/30  12:19:31  matthew
Removing diagnostics

Revision 1.31  1994/05/11  14:17:43  daveb
Datatypes.META_OVERLOADED takes extra arguments.  Removed UnresolvedVar
exception, and tidied the close function.

Revision 1.30  1994/05/04  16:14:50  jont
Fix use of check_debruijns to be safe

Revision 1.29  1994/02/21  21:44:46  nosa
generate_moduler compiler option required in type variable instantiation.
n\n\n\n\n\nog: .

Revision 1.28  1993/12/16  14:20:47  matthew
Added level field to Basis.
Levels now allocated from a ref to ensure monotonicity.

Revision 1.27  1993/09/22  09:28:30  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.26  1993/06/30  15:39:53  daveb
Removed exception environments.

Revision 1.25  1993/04/26  16:22:17  jont
Added remove_str for getting rid of FullPervasiveLibrary_ from initial env

Revision 1.24  1993/03/17  18:48:13  matthew
Nameset structure changes

Revision 1.23  1993/03/02  16:00:33  matthew
Rationalised use of Mapping structure

Revision 1.22  1993/02/08  18:24:33  matthew
Changes for BASISTYPES signature

Revision 1.21  1993/01/27  12:23:38  matthew
Changes for COPYSTR representation

Revision 1.20  1992/12/22  15:19:03  jont
Anel's last changes

Revision 1.19  1992/12/03  13:27:32  jont
Modified tyenv for efficiency

Revision 1.18  1992/12/01  15:59:44  matthew
Changed handling of overloaded variable errors.

Revision 1.17  1992/11/25  15:38:37  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.16  1992/10/27  19:01:58  jont
Modified to use less than functions for maps

Revision 1.15  1992/10/02  16:11:58  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.14  1992/10/01  12:05:57  richard
Moved chain reducing code here from _toplevel.

Revision 1.13  1992/08/18  15:10:05  jont
Removed irrelevant handlers and new exceptions

Revision 1.12  1992/08/12  13:06:12  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.11  1992/08/06  17:31:13  jont
Anel's changes to use NewMap instead of Map

Revision 1.9  1992/06/24  17:19:46  jont
Changed to imperative implementation of namesets with hashing

Revision 1.8  1992/02/11  10:01:58  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.7  1992/01/27  20:13:42  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.6  1992/01/14  17:07:20  jont
Changed ref unit in valenv to ref int to assist encoder

Revision 1.5  1991/11/21  16:44:25  jont
Added copyright message

Revision 1.4  91/06/28  16:34:11  nickh
fixed trivial bug in empty_basis.

Revision 1.3  91/06/28  15:00:27  nickh
Added empty_basis value.

Revision 1.2  91/06/17  17:11:00  nickh
Modified to take new ValEnv definition with ref unit to allow
reading and writing of circular data structures.

Revision 1.1  91/06/07  11:34:42  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "stamp";
require "../utils/lists";
require "../utils/print";
require "../basics/identprint";
require "../typechecker/scheme";
require "../typechecker/valenv";
require "../typechecker/strenv";
require "../typechecker/tyenv";
require "../typechecker/environment";
require "../typechecker/nameset";
require "../typechecker/types";
require "../typechecker/sigma";

require "../typechecker/basis";

functor Basis (
  structure IdentPrint : IDENTPRINT
  structure Valenv : VALENV
  structure Strenv : STRENV
  structure Tyenv : TYENV
  structure Nameset : NAMESET
  structure Scheme : SCHEME
  structure Types : TYPES
  structure Env : ENVIRONMENT
  structure Sigma : SIGMA
  structure Lists : LISTS
  structure Print : PRINT
  structure Stamp : STAMP

  sharing Scheme.Datatypes = Env.Datatypes = Nameset.Datatypes =
    Valenv.Datatypes = Tyenv.Datatypes = Types.Datatypes =
    Strenv.Datatypes = Sigma.BasisTypes.Datatypes
  sharing Valenv.Datatypes.Ident = IdentPrint.Ident
  sharing Scheme.Set = Sigma.BasisTypes.Set

  sharing type Nameset.Nameset = Sigma.BasisTypes.Nameset
  sharing type Stamp.Map.T = Types.Datatypes.StampMap
) : BASIS =

  struct
    structure BasisTypes = Sigma.BasisTypes
    structure Datatypes = Types.Datatypes
    structure Set = Scheme.Set

    type print_options = Scheme.print_options
    type options = Scheme.Options.options
    type error_info = Scheme.error_info

    (****
     This structure contains the datatypes for the semantic objects Basis and 
     Context and the operations on them.
     ****)

    open Datatypes

    exception LookupValId = Valenv.LookupValId
    exception LookupTyCon = Tyenv.LookupTyCon
    exception LookupStrId = Env.LookupStrId

    exception LookupSigId = NewMap.Undefined
    exception LookupFunId = NewMap.Undefined
    exception LookupTyvar = NewMap.Undefined


    (* auxiliary functions that gather the type names from types,
       environments etc. *)

    (* following function strips away metatynames.  This removes
       spurious "unit" type names.  *)

    fun tynameLevelsOK(tyname as TYNAME(_,_,_,_,_,_,_,_,lev)) lev'= 
                        if lev<lev' then [] else [tyname]
      | tynameLevelsOK(METATYNAME(ref tyfun,_,_,_,_,_)) lev = 
                       tyfunLevelsOK tyfun lev

    and tyfunLevelsOK(TYFUN(t,_)) l= typeLevelsOK t l
      | tyfunLevelsOK(ETA_TYFUN tyname) l= tynameLevelsOK tyname l
      | tyfunLevelsOK(NULL_TYFUN (stamp,ref tyfun)) l =
        tyfunLevelsOK tyfun l
        
    and typeLevelsOK(METATYVAR(ref (_,t,_),_,_)) l=
        typeLevelsOK t l
      | typeLevelsOK(META_OVERLOADED(ref t,_,_,_)) l =
        typeLevelsOK t l
      | typeLevelsOK(TYVAR(ref(_,t,_),_)) l =
        typeLevelsOK t l
      | typeLevelsOK(METARECTYPE(ref(_,_,t,_,_))) l =
        typeLevelsOK t l
      | typeLevelsOK(RECTYPE(amap)) l =
        Datatypes.NewMap.fold (fn (acc,_,t)=> acc@(typeLevelsOK t l))
        ([],amap)
      | typeLevelsOK(FUNTYPE(t,t')) l =
        (typeLevelsOK t l) @ (typeLevelsOK t' l)
      | typeLevelsOK(CONSTYPE(tylist,tyname)) l =
        (Lists.reducel (fn (acc,t) => acc@(typeLevelsOK t l))
         (tynameLevelsOK tyname l,tylist))
      | typeLevelsOK(DEBRUIJN(_,_,_,t)) l =
        (case t of NONE => []
      | (SOME (ref (_,t',_))) => typeLevelsOK t' l)
      | typeLevelsOK NULLTYPE _ = []
        
    fun tyschemeLevelsOK (SCHEME(_,(t,_))) l = typeLevelsOK t l
      | tyschemeLevelsOK (UNBOUND_SCHEME(t,_)) l = typeLevelsOK t l
      | tyschemeLevelsOK (OVERLOADED_SCHEME _) _ = []
        
        
    fun valenvLevelsOK (VE (_,vmap)) lev =
      Lists.reducel
      (fn (acc,tscheme) => (tyschemeLevelsOK tscheme lev)@acc)
      ([],Datatypes.NewMap.range vmap)
      
    fun tyenvLevelsOK(TE amap) lev =
      Lists.reducel (fn (acc,TYSTR(tyFun,_)) => (tyfunLevelsOK tyFun lev)@acc)
      ([],Datatypes.NewMap.range amap)
      
    fun strEnvLevelsOK (SE smap) lev = 
      let
        fun structureLevelsOK(STR(_,_,env)) l = envLevelsOK env l
          | structureLevelsOK(COPYSTR((_,t),s)) l = 
            (Stamp.Map.range t) @ (structureLevelsOK s l)
      in
        Lists.reducel (fn (acc,s) => acc @ (structureLevelsOK s lev))
        ([],Datatypes.NewMap.range smap)
      end

    and envLevelsOK (ENV(strEnv ,tyEnv, valEnv)) l =
      (strEnvLevelsOK  strEnv l)@(valenvLevelsOK valEnv l)@
      (tyenvLevelsOK tyEnv l)


    (* tyvarenvs *)

    val empty_tyvarenv = BasisTypes.TYVARENV (NewMap.empty (Ident.tyvar_lt, 
                                                            Ident.tyvar_eq))

    fun tyvarenv_lookup (tyvar, BasisTypes.TYVARENV amap) = 
      NewMap.apply'(amap, tyvar)

    fun add_to_tyvarenv (alevel,tyvar,BasisTypes.TYVARENV amap) =
      BasisTypes.TYVARENV 
      (NewMap.define 
       (amap,tyvar,Datatypes.TYVAR(ref (alevel,
                   Datatypes.NULLTYPE,Datatypes.NO_INSTANCE),tyvar)))

    (* funenvs *)

    val empty_funenv = BasisTypes.FUNENV (NewMap.empty (Ident.funid_lt, Ident.funid_eq))
      
    fun add_to_funenv (funid,phi,BasisTypes.FUNENV amap) = 
      BasisTypes.FUNENV (NewMap.define (amap,funid,phi))
	      
    fun funenv_lookup (funid,BasisTypes.FUNENV amap) =
      NewMap.apply'(amap, funid)

    fun funenv_plus_funenv (BasisTypes.FUNENV amap,BasisTypes.FUNENV amap') = 
      BasisTypes.FUNENV (NewMap.union(amap, amap'))

    (* sigenvs *)

    val empty_sigenv = BasisTypes.SIGENV (NewMap.empty (Ident.sigid_lt, Ident.sigid_eq))

    fun add_to_sigenv (sigid,asig,BasisTypes.SIGENV amap) = 
      BasisTypes.SIGENV (NewMap.define (amap,sigid,asig))

    fun sigenv_lookup (sigid,BasisTypes.SIGENV amap) = 
      NewMap.apply'(amap, sigid)

    fun sigenv_plus_sigenv (BasisTypes.SIGENV amap,BasisTypes.SIGENV amap') =
      BasisTypes.SIGENV (NewMap.union(amap, amap'))

    (* Functions for looking up different values in the Context. *)

    fun lookup_tyvar (tyvar,BasisTypes.CONTEXT (_,_,_,tyvarenv)) =
      tyvarenv_lookup (tyvar,tyvarenv) 

    fun lookup_longtycon (longtycon,
                          BasisTypes.CONTEXT (_,_,env,_)) = 
      Env.lookup_longtycon (longtycon,env)

    fun lookup_val (longvalid,BasisTypes.CONTEXT (level,_,env,_),
                    location,generate_moduler) =
      let 
	val scheme = Env.lookup_longvalid (longvalid,env)
      in
	Scheme.instantiate (level, scheme, location, generate_moduler)
      end 


    fun lookup_tycon (tycon,BasisTypes.CONTEXT (_,_,ENV (_,te,_),_)) =
      Tyenv.lookup (te, tycon)

    (* This is used for setting levels in Basises and Contexts *)
    (* The requirement is for monotonically increasing allocation
       of level numbers *)
    (* When we have full concurrency this might still work *)
      
    val level_num_ref = ref 0

    fun new_level_num () = 
      let val new = 1 + (!level_num_ref) 
      in level_num_ref := new; new 
      end

    (****
     Modifications of the Context.
     ****)

    fun context_plus_ve (BasisTypes.CONTEXT (alevel,tyvars,
                                             ENV (se,te,ve),tyvarenv),ve') =
      BasisTypes.CONTEXT (new_level_num(),
                          tyvars,
                          ENV (se,te,Valenv.ve_plus_ve (ve,ve')),
                          tyvarenv)

    fun context_plus_te (BasisTypes.CONTEXT (level,tyvarset,
				  ENV (se,te,ve),tyvarenv),te') = 
      BasisTypes.CONTEXT (level,
                          tyvarset,
                          ENV (se,Tyenv.te_plus_te (te,te'),ve),
                          tyvarenv)

    fun context_plus_tyvarset (BasisTypes.CONTEXT(level,tyvars,
                                                  env,tyvarenv), tyvarset) =
      let 
	fun collect (tve, tv) = add_to_tyvarenv (level, tv, tve)
      in
	BasisTypes.CONTEXT (level,Set.union (tyvars,tyvarset), env,
                            Set.fold collect (tyvarenv,tyvarset))
      end


    fun context_plus_tyvarlist (BasisTypes.CONTEXT(level,
                                                   tyvars,env,tyvarenv), 
                                tyvarlist) =
      let
        fun collect ([],amap) = amap
          | collect (h::t,amap) =
            add_to_tyvarenv (level,h, collect(t,amap))
        fun make_tyvarenv (tyvars) =
          collect (tyvars, empty_tyvarenv)
      in
        BasisTypes.CONTEXT (level,tyvars,env,make_tyvarenv tyvarlist)
      end

    fun context_plus_env (BasisTypes.CONTEXT (alevel,tyvars,
                                              env,tyvarenv),env') =
      BasisTypes.CONTEXT (new_level_num(),
                          tyvars,
                          Env.env_plus_env (env,env'),tyvarenv)

    fun context_for_datbind (BasisTypes.CONTEXT (level,tyvarset,
                                                 ENV(se,te,ve),_),
                             location,
                             dummy_tycons) =
      let
        val loc_string = SOME location
        fun make_dummy_te ([],te) = te
          | make_dummy_te ((tyvars,tycon)::t,te) = 
            make_dummy_te(t,
                          Tyenv.add_to_te
                          (te, tycon,
                           TYSTR
                           (Types.make_eta_tyfun
                            (Types.make_tyname 
                             (Lists.length tyvars,
                              true,
                              IdentPrint.printTyCon tycon,
                              loc_string,level)),
                            empty_valenv)))
      in
        BasisTypes.CONTEXT (level,tyvarset,
                            ENV (se,make_dummy_te (dummy_tycons,te),ve),
                            empty_tyvarenv)
      end

    (****
     Closure as defined on p. 21 of The Definition.
     ****)

    fun close 
      (error_info,options,location)
      (alevel,VE (r,amap),exp_vars,tyvars_scoped_here,asig) =
      let 
  	fun close_ve (tree, valid, scheme) =
	  let
	    val scheme' =
	      Scheme.schemify 
              (error_info,options,location)
              (alevel,Lists.member (valid,exp_vars),
               scheme,tyvars_scoped_here,asig)
	  in
	    NewMap.define(tree, valid, scheme')
	  end
      in
	VE(ref 0,
	   NewMap.fold
	     close_ve
	     (NewMap.empty (Ident.valid_lt, Ident.valid_eq), amap))
      end
	
    (****
     Projection operations on the Context.
     ****)

    fun env_of_context (BasisTypes.CONTEXT (_,_,env,_)) = env

    fun te_of_context (BasisTypes.CONTEXT (_,_,ENV (_,te,_),_)) = te

    (****
     Various operations on the Context.
     ****)

    fun env_to_context env = BasisTypes.CONTEXT (0,Set.empty_set,env,
                                                 empty_tyvarenv)

    fun context_level (BasisTypes.CONTEXT (alevel,_,_,_)) = alevel

    fun get_tyvarset (BasisTypes.CONTEXT (_,tyvars,_,_)) = tyvars

    fun basis_to_context (BasisTypes.BASIS (level,_,_,_,env)) = 
      BasisTypes.CONTEXT (level,
                          Set.empty_set,env,empty_tyvarenv)
      
    (****
     Functions for looking up various values in the Basis.
     ****)

    fun lookup_sigid (sigid,BasisTypes.BASIS (_,_,_,sigenv,_)) = 
      sigenv_lookup (sigid,sigenv)

    fun lookup_longstrid (longstrid,BasisTypes.BASIS (_,_,_,_,env)) =
      Env.lookup_longstrid (longstrid,env)

    fun lookup_funid (funid,BasisTypes.BASIS (_,_,funenv,_,env)) = 
      funenv_lookup (funid,funenv)

    (****
     Injection operations into the basis.
     ****)

    (* These all seem to be only used for topdecs, so make level be 0 *)
    fun env_in_basis env = BasisTypes.BASIS (0,
                                             Nameset.empty_nameset(),
                                             empty_funenv,
                                             empty_sigenv,
                                             env)

    fun sigenv_in_basis sigenv = BasisTypes.BASIS (0,
                                                   Nameset.empty_nameset (),
                                                   empty_funenv,sigenv,
                                                   Env.empty_env)

    fun funenv_in_basis funenv = BasisTypes.BASIS (0,
                                                   Nameset.empty_nameset (),
                                                   funenv,
                                                   empty_sigenv,
                                                   Env.empty_env)

    (****
     Modifications of the Basis.
     ****)

    fun basis_plus_env (BasisTypes.BASIS (level,names,funenv,sigenv,env),
                        env') = 
      let
(*        val newNames = Nameset.nameset_of_name_lists(tynamesInEnv env',[])*)
      in
        BasisTypes.BASIS (new_level_num(),
                          (*Nameset.union(names,newNames),*) names,
                          funenv,sigenv,
                          Env.env_plus_env (env,env'))
      end


    fun basis_plus_sigenv (BasisTypes.BASIS (level,names,funenv,sigenv,env),
                           sigenv') = 
      BasisTypes.BASIS (level,names,funenv,
                        sigenv_plus_sigenv (sigenv,sigenv'),env)

    fun basis_plus_funenv (BasisTypes.BASIS (level,names,funenv,sigenv,env),
                           funenv') = 
      BasisTypes.BASIS (level,names,funenv_plus_funenv (funenv,funenv'),
                        sigenv,env)

    fun basis_plus_names (BasisTypes.BASIS (level,names,funenv,sigenv,env),
                          names') = 
      BasisTypes.BASIS (level,Nameset.union (names,names'),funenv,sigenv,env)


    fun basis_circle_plus_basis
             (BasisTypes.BASIS (level,names,funenv,sigenv,env),
	      BasisTypes.BASIS (level',names',funenv',sigenv',env')) = 
      BasisTypes.BASIS (new_level_num(),
                        Nameset.union (names,names'),
                        funenv_plus_funenv (funenv,funenv'),
                        sigenv_plus_sigenv (sigenv,sigenv'),
                        Env.env_plus_env (env,env'))

(* unused
    fun basis_plus_basis 
         (BasisTypes.BASIS (level,names,funenv,sigenv,env),
	  BasisTypes.BASIS (level',names',funenv',sigenv',env')) = 
      BasisTypes.BASIS (new_level_num(),
                        names,
                        funenv_plus_funenv (funenv,funenv'),
                        sigenv_plus_sigenv (sigenv,sigenv'),
                        Env.env_plus_env (env,env'))

*)
    fun basis_level (BasisTypes.BASIS{1=level,...}) = level

    val initial_basis =
      BasisTypes.BASIS (0,
                        Nameset.initial_nameset,
                        empty_funenv,
                        empty_sigenv,
                        Env.initial_env)

    val initial_basis_for_builtin_library =
      BasisTypes.BASIS (0,
                        Nameset.initial_nameset_for_builtin_library,
                        empty_funenv,
                        empty_sigenv,
                        Env.initial_env_for_builtin_library)

    val empty_basis = 
      BasisTypes.BASIS (0,
                        Nameset.empty_nameset (),
                        empty_funenv,
                        empty_sigenv,
                        Env.empty_env)

    fun remove_str(BasisTypes.BASIS(level,n, f, s, ENV(SE map, te, ve)),
                   strid) =
      BasisTypes.BASIS(level,n, f, s, ENV(SE(NewMap.undefine(map, strid)),
                                          te, ve))

    fun add_str (BasisTypes.BASIS (level,nameset, functor_env, signature_env,
                                   Datatypes.ENV (structure_env, type_env,
                                                  value_env)),
                 strid, str) =
      let
        val new_structure_env = Strenv.add_to_se (strid, str, structure_env)
      in
        BasisTypes.BASIS (level,nameset, functor_env, signature_env,
                          Datatypes.ENV (new_structure_env, type_env,
                                         value_env))
      end

    fun add_val (BasisTypes.BASIS (level, nameset, functor_env, signature_env,
                                   Datatypes.ENV (structure_env, type_env,
                                                  value_env)),
                 valid, scheme) =
      let
        val new_value_env = Valenv.add_to_ve (valid, scheme, value_env)
      in
        BasisTypes.BASIS (level, nameset, functor_env, signature_env,
                          Datatypes.ENV (structure_env, type_env,
                                         new_value_env))
      end

    local
      fun follow_tyname(arg as TYNAME _) = arg
        | follow_tyname(arg as METATYNAME{1=ref(NULL_TYFUN _), ...}) = arg
        | follow_tyname(METATYNAME{1=ref(ETA_TYFUN tyname), ...}) =
          follow_tyname tyname
        | follow_tyname(METATYNAME{1=ref(TYFUN(CONSTYPE([], tyname), 0)),
                                   ...}) = follow_tyname tyname
        | follow_tyname tyname = tyname

      fun follow_tyfun(arg as NULL_TYFUN _) = arg
        | follow_tyfun(arg as ETA_TYFUN(TYNAME _)) = arg
        | follow_tyfun(ETA_TYFUN(METATYNAME{1=ref tyfun, ...})) =
          follow_tyfun tyfun
        | follow_tyfun(tyfun as
                            TYFUN(CONSTYPE(l, tyname), 0)) =
          if Types.tyname_arity tyname = 0 andalso 
             Types.check_debruijns(l, 0) then
            follow_tyfun(ETA_TYFUN tyname)
          else
            tyfun
        | follow_tyfun tyfun = tyfun

      fun long_follow_tyfun(arg as NULL_TYFUN _) = arg
        | long_follow_tyfun(arg as ETA_TYFUN(TYNAME _)) = arg
        | long_follow_tyfun(arg as ETA_TYFUN(METATYNAME{1=ref(NULL_TYFUN _),
                                                        ...})) =
          arg
        | long_follow_tyfun(ETA_TYFUN(METATYNAME{1=ref tyfun, ...})) =
          long_follow_tyfun tyfun
        | long_follow_tyfun(tyfun as
                            TYFUN(CONSTYPE(l, tyname), 0)) =
          if Types.tyname_arity tyname = 0 andalso 
             Types.check_debruijns(l, 0) then
            long_follow_tyfun(ETA_TYFUN tyname)
          else
            tyfun
        | long_follow_tyfun tyfun = tyfun

      fun follow_strname(arg as STRNAME _) = arg
        | follow_strname(arg as NULLNAME _) = arg
        | follow_strname(arg as
                         METASTRNAME(ref(NULLNAME _))) =
          arg
        | follow_strname(arg as METASTRNAME(ref strname)) =
          follow_strname strname

      fun reduce_strname(arg as STRNAME _) = ()
        | reduce_strname(arg as NULLNAME _) = ()
        | reduce_strname(METASTRNAME(r as ref strname)) =
          r := follow_strname strname

      fun reduce_tyfun(arg as NULL_TYFUN _) = ()
        | reduce_tyfun(arg as ETA_TYFUN(METATYNAME{1=ref(NULL_TYFUN _), 
                                                   ...})) =
          ()
        | reduce_tyfun(ETA_TYFUN(METATYNAME{1=r as ref tyfun,
                                            5=ref_ve, ...})) =
          let
            val tyfun = long_follow_tyfun tyfun
          in
            (case tyfun of
               ETA_TYFUN _ => ref_ve := empty_valenv
             | _ => ());
               r := tyfun
          end
        | reduce_tyfun(ETA_TYFUN _) = ()
        | reduce_tyfun(TYFUN(ty, _)) = reduce_type ty

      and reduce_tyname(arg as TYNAME _) = ()
        | reduce_tyname(arg as METATYNAME{1=ref(NULL_TYFUN _), ...}) =
          ()
        | reduce_tyname(arg as METATYNAME{1=r as ref tyfun,
                                                    5=ref_ve, ...}) =
          let
            val tyfun = long_follow_tyfun tyfun
          in
            (case tyfun of
               ETA_TYFUN _ => ref_ve := empty_valenv
             | _ => ());
               r := tyfun
          end

      and reduce_scheme(SCHEME(_, (ty,_))) = reduce_type ty
        | reduce_scheme(UNBOUND_SCHEME (ty,_)) = reduce_type ty
        | reduce_scheme _ = ()

      and reduce_type(METATYVAR(ref(_, ty,_), _, _)) = reduce_type ty
        | reduce_type(META_OVERLOADED {1=ref ty,...}) =
	  reduce_type ty
        | reduce_type(TYVAR _) = ()
        | reduce_type(METARECTYPE(ref{3=ty, ...})) = reduce_type ty
        | reduce_type(ty as RECTYPE _) =
          Lists.iterate reduce_type (Types.rectype_range ty)
        | reduce_type(FUNTYPE(ty1, ty2)) =
          (reduce_type ty1;
           reduce_type ty2)
        | reduce_type(CONSTYPE(l, tyname)) =
          (Lists.iterate reduce_type l;
           reduce_tyname tyname)
        | reduce_type _ = ()

      and reduce_valenv(VE(_, ve_map)) =
        NewMap.iterate (fn (_, type_scheme) => reduce_scheme type_scheme)
                       ve_map

      fun reduce_str(STR(strname,_,env)) =
        (reduce_strname strname; reduce_env env)
        | reduce_str (COPYSTR((smap,tmap),str)) = 
          (* try this *) (* HACK *) (* This is  bad news *)
          reduce_str (Env.str_copy(str,smap,tmap))
(*
          let
            (* don't need to construct new maps here *)
            val smap' = Strname_id.Map.map (fn (_,strname) => (reduce_strname strname)) smap
            val tmap' = Tyfun_id.Map.map (fn (_,tyname) => (reduce_tyname tyname)) tmap
          in
            ()
          end
*)

      and reduce_env(ENV(SE strenv,
                                   TE tyenv,
                                   ve)) =
        (NewMap.iterate (fn (_, str) => reduce_str str) strenv;
         NewMap.iterate (fn (_, TYSTR(tyfun, ve)) =>
                         (reduce_valenv ve;
                          reduce_tyfun tyfun)) tyenv;
         reduce_valenv ve)

      fun reduce_nameset nameset =
        (Lists.iterate reduce_strname (Nameset.strnames_of_nameset nameset);
         Lists.iterate reduce_tyname (Nameset.tynames_of_nameset nameset))

      fun reduce_sigma(BasisTypes.SIGMA(nameset, str)) =
        (reduce_nameset nameset; reduce_str str)

    in

      fun reduce_chains (BasisTypes.BASIS(_,
                                          nameset, 
                                          BasisTypes.FUNENV funid_map,
                                          BasisTypes.SIGENV sigid_map, env)) =
        let
          val _ = reduce_nameset nameset
          val _ = NewMap.iterate
            (fn (_, BasisTypes.PHI(nameset, (str, sigma))) =>
             let
               val _ = reduce_nameset nameset
               val _ = reduce_str str
             in
               reduce_sigma sigma
             end)
            funid_map
          val _ = NewMap.iterate (fn (_, sigma) => reduce_sigma sigma)
                                 sigid_map
        in
          reduce_env env
        end
    end

    val pervasive_stamp_count = Types.pervasive_stamp_count


      (* The following function returns all the type names
         occurring within a type that were not also defined within a
         given context.  This is used to make sure that hidden value
         constructors do not escape. See rule 6 of _core_rules.sml *)

      fun tynamesNotIn (t,BasisTypes.CONTEXT(level,_,_,_)) =
        typeLevelsOK t level

      (* This function returns all the type names occurring within a 
         valenv that didn't also occur within a given context.
         This is used to check that no hidden type names escape
         through pattern matching (_core_rules.sml rules 15 and 16)
         and "val rec"s (_core_rules.sml rule 27) *)

      fun valEnvTynamesNotIn (valenv, BasisTypes.CONTEXT(level,_,_,_)) =
        valenvLevelsOK valenv level


end
