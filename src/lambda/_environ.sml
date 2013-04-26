(* _environ.sml the functor *)
(*
$Log: _environ.sml,v $
Revision 1.55  1996/11/22 11:40:19  matthew
Tidying

 * Revision 1.54  1996/05/07  10:42:11  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.53  1996/04/15  15:40:10  jont
 * Improve abs_eval when getting switches
 *
 * Revision 1.52  1996/03/27  17:04:46  matthew
 * Changes for new language\.
 *
 * Revision 1.51  1996/03/20  12:24:24  matthew
 * Changes for value polymorphism
 *
 * Revision 1.50  1996/02/23  17:01:53  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.49  1995/12/27  11:34:40  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.48  1995/08/10  18:49:36  daveb
Added new types for different sizes of ints, words and reals.

Revision 1.47  1995/08/01  15:33:49  jont
Modification to the detection of overloaded valids

Revision 1.46  1995/08/01  11:38:38  matthew
Adding environment simplifier

Revision 1.45  1995/03/27  17:00:29  jont
Remove Builtin_p and modify FindBuiltin

Revision 1.44  1995/01/19  12:38:54  matthew
Tidying up

Revision 1.43  1994/12/06  17:19:42  matthew
Changing uses of cast

Revision 1.42  1994/10/13  11:08:58  matthew
Use pervasive Option.option for return values in NewMap

Revision 1.41  1994/02/28  05:35:40  nosa
Debugger environments for Modules Debugger.

Revision 1.40  1993/10/28  14:40:21  nickh
Merging in code change.

Revision 1.39.1.2  1993/10/27  16:37:25  nickh
Added and used a new function, number_envs, to replace all uses of
Lists.number_with_size, a function which was too inefficient (and ugly).
/

Revision 1.39.1.1  1993/07/08  15:49:43  jont
Fork for bug fixing

Revision 1.39  1993/07/08  15:49:43  nosa
structure Option.

Revision 1.38  1993/07/05  14:20:30  daveb
Removed exception environments and interfaces.

Revision 1.37  1993/05/18  18:48:08  jont
Removed integer parameter

Revision 1.36  1993/03/10  15:46:22  matthew
Signature revisions

Revision 1.35  1993/02/03  09:31:24  matthew
Rationalised functions for converting from structures to interfaces to environments.
Added a cached environment field to interfaces
Moved make_interface_from_str from typechecker/interface

Revision 1.34  1992/11/30  12:53:01  jont
Took out a number of unnecessary map operations

Revision 1.33  1992/10/28  11:46:26  jont
Changed maps to use strict less than functions

Revision 1.32  1992/10/02  16:21:05  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.31  1992/09/28  09:01:33  richard
Added make_str_env.

Revision 1.30  1992/09/25  11:50:19  jont
Removed counter parameter, unused

Revision 1.29  1992/08/26  11:49:58  jont
Removed some redundant structures and sharing

Revision 1.28  1992/08/18  19:49:52  davidt
Added sigid_order and symbol_order functions.

Revision 1.27  1992/08/12  11:43:59  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.26  1992/08/06  14:13:30  jont
Anel's changes to use NewMap instead of Map

Revision 1.26  1992/08/06  14:13:30  jont
Anel's changes to use NewMap instead of Map

Revision 1.25  1992/08/04  19:11:42  jont
Removed various uses of NewMap.to_list in favour of fold and union

Revision 1.24  1992/06/17  16:10:15  jont
Added make_external for benefit of interpreter

Revision 1.23  1992/06/10  17:47:09  jont
Changed to use newmap

Revision 1.22  1992/06/03  17:38:01  jont
Moved assign_fields function from _lambda

Revision 1.21  1992/02/27  17:38:08  jont
Changed to use eqaulity function maps

Revision 1.20  1992/01/09  17:36:10  jont
Changed paramter ordering in environment update to allow use with
Lists.foldl

Revision 1.19  1991/11/21  19:20:47  jont
Added type to overloads in order to keep njml 0.75 happy

Revision 1.18  91/10/22  15:05:59  davidt
Replaced impossible exception with Crash.impossible calls.

Revision 1.17  91/10/08  18:43:18  davidt
General tidy up, removed local copy of number_from (now in Lists
structure), Made changes due to record selection now requiring
the total size of the record to be present as well as the index.

Revision 1.16  91/07/23  11:57:11  jont
Fixed bug in make_env_from_interface to do with exception numbering

Revision 1.15  91/07/12  18:00:42  jont
Added exception environment to env

Revision 1.14  91/07/11  09:44:42  jont
Added empty_fun_env, add_funid_env, changed Fun_Env to use comp

Revision 1.13  91/07/10  12:58:16  jont
Reorganised

Revision 1.12  91/07/09  17:04:03  jont
Added empty_top_env and lookup_funid

Revision 1.11  91/07/08  17:56:09  jont
Added augment_top_env

Revision 1.10  91/07/08  15:41:41  jont
Added function to find imperative primitives

Revision 1.9  91/07/05  15:12:55  jont
Added overload environment to handle overloaded primitives such as +

Revision 1.8  91/06/27  12:55:17  jont
Removed Findconst as it's not used. Changed Builtin_p so it doesn't
need to catch exceptions

Revision 1.7  91/06/24  11:40:56  jont
Removed match support, as this is internal to _lambda

Revision 1.6  91/06/21  10:31:31  jont
Modified match environment functions for use with fold. Changed
names to be consistent with value environment

Revision 1.5  91/06/20  18:16:26  jont
Implemented match environment update and lookup functions

Revision 1.4  91/06/19  17:51:00  jont
Added match environment type, and changed the types of matchvar
lookup and generate

Revision 1.3  91/06/17  14:51:00  jont
Change add_valid_env and add_strid_env to have type 'a * Env -> Env
to allow use with foldleft or foldright

Revision 1.2  91/06/12  16:07:00  jont
Split off types from rest of environ

Copyright (c) 1991 Harlequin Ltd.
*)

require "../basis/__vector";
require "../utils/crash";
require "../utils/lists";
require "../basics/identprint";
require "../typechecker/datatypes";
require "environ";
require "environtypes";

(**
    The functor for handling the environment produced during the
    translation from abstract syntax to extended
    lambda calculus.  And for defining the datatypes used.
**)

functor Environ (
  structure Crash: CRASH
  structure Lists: LISTS
  structure Datatypes : DATATYPES
  structure IdentPrint : IDENTPRINT
  structure EnvironTypes : ENVIRONTYPES where type LambdaTypes.LVar = int

  sharing EnvironTypes.NewMap = Datatypes.NewMap
  sharing IdentPrint.Ident = EnvironTypes.LambdaTypes.Ident = Datatypes.Ident
  sharing type Datatypes.Type = EnvironTypes.LambdaTypes.Type
) : ENVIRON =
struct
  structure Ident = IdentPrint.Ident
  structure Symbol = Ident.Symbol
  structure EnvironTypes = EnvironTypes
  structure LambdaTypes = EnvironTypes.LambdaTypes
  structure NewMap = EnvironTypes.NewMap
  structure Set = LambdaTypes.Set
  structure Datatypes = Datatypes

  type Structure = Datatypes.Structure

  val cast = MLWorks.Internal.Value.cast

  val empty_env =
    EnvironTypes.ENV(NewMap.empty (Ident.valid_lt,Ident.valid_eq),
		     NewMap.empty (Ident.strid_lt,Ident.strid_eq))
  val empty_fun_env = EnvironTypes.FUN_ENV(NewMap.empty (Ident.funid_lt,Ident.funid_eq))
  val empty_top_env = EnvironTypes.TOP_ENV(empty_env, empty_fun_env)

  val empty_denv =
    EnvironTypes.DENV(NewMap.empty (Ident.valid_lt,Ident.valid_eq),
                      NewMap.empty (Ident.strid_lt,Ident.strid_eq))

  fun add_valid_env(EnvironTypes.ENV(mv, ms), (valid, lvar)) =
    EnvironTypes.ENV(NewMap.define(mv, valid, lvar), ms)
    (* Add one valid -> comp translation to an existing environment *)

  fun add_strid_env(EnvironTypes.ENV(mv, ms), (strid, e_c)) =
    EnvironTypes.ENV(mv, NewMap.define(ms, strid, e_c))
  (* Add one strid -> env, comp translation to an existing environment *)

  fun add_valid_denv(EnvironTypes.DENV(mv, ms), (valid, lvar)) =
    EnvironTypes.DENV(NewMap.define(mv, valid, lvar), ms)
    (* Add one valid -> exp translation to an existing environment *)

  fun add_strid_denv(EnvironTypes.DENV(mv, ms), (strid, se)) =
    EnvironTypes.DENV(mv, NewMap.define(ms, strid, se))
  (* Add one strid -> strexp, comp translation to an existing environment *)

  fun add_list(map, list) =
    Lists.reducel
    (fn (map, (d, r)) => NewMap.define(map, d, r))
    (map, list)

  fun augment_env(EnvironTypes.ENV(mv, ms), EnvironTypes.ENV(nv, ns)) =
    EnvironTypes.ENV
    (NewMap.union(mv, nv),
     NewMap.union(ms, ns))

  fun augment_denv(EnvironTypes.DENV(mv, ms), EnvironTypes.DENV(nv, ns)) =
    EnvironTypes.DENV
    (NewMap.union(mv, nv),
     NewMap.union(ms, ns))

  fun lookup_valid(valid, EnvironTypes.ENV(mv, _)) =
    NewMap.apply'(mv, valid)

  fun lookup_strid(strid, EnvironTypes.ENV(_, ms)) =
    NewMap.apply'(ms, strid)

  fun lookup_valid'(valid, EnvironTypes.DENV(mv, _)) =
    NewMap.apply'(mv, valid)

  fun lookup_strid'(strid, EnvironTypes.DENV(_, ms)) =
    NewMap.apply'(ms, strid)

  fun FindBuiltin(Ident.LONGVALID(Ident.NOPATH, valid),
		   env as EnvironTypes.ENV(mv, _)) =
    (case NewMap.tryApply'(mv, valid) of
       SOME(EnvironTypes.PRIM prim) => SOME prim
     | _ => NONE)
    | FindBuiltin _ = NONE

  local
    val overloads = ref(NewMap.empty' Ident.valid_lt:
			(Ident.ValId, LambdaTypes.Primitive)NewMap.map)
  in
    fun define_overloaded_ops ops =
      overloads :=
      let
	val env = !overloads
      in
	Lists.reducel
	(fn (map, (s, p)) => NewMap.define(map, Ident.VAR(Symbol.find_symbol s), p))
	(env, ops)
      end

    fun overloaded_op(arg as Ident.VAR _) =
      (case NewMap.tryApply'(!overloads, arg) of
	 x as SOME _ => x
       | _ => NONE)
      | overloaded_op _ = 
	Crash.impossible "Environ.is_overloaded_op"
  end

  fun add_funid_env(EnvironTypes.FUN_ENV m, (funid, c_i_e)) =
    EnvironTypes.FUN_ENV(NewMap.define(m, funid, c_i_e))
  (* Add one funid -> env, comp translation to an existing environment *)
  fun augment_top_env(EnvironTypes.TOP_ENV(e1, EnvironTypes.FUN_ENV fun_e1),
    EnvironTypes.TOP_ENV(e2, EnvironTypes.FUN_ENV fun_e2)) =
    EnvironTypes.TOP_ENV(augment_env(e1, e2),
      EnvironTypes.FUN_ENV(NewMap.union(fun_e1, fun_e2)))

  fun lookup_funid(funid, EnvironTypes.FUN_ENV fun_env) =
    NewMap.apply'(fun_env, funid)

  fun number_envs (vl,sl,fl) =
    let
      val length_v = Lists.length vl
      val length_s = Lists.length sl
      val total_length = length_v + length_s + (Lists.length fl)
      fun number n = EnvironTypes.FIELD {index=n, size=total_length}
      val (new_vl,_) = Lists.number_from_by_one (vl, 0, number)
      val (new_sl,_) = Lists.number_from_by_one (sl, length_v, number)
      val (new_fl,_) = Lists.number_from_by_one (fl, length_v+length_s, number)
    in
      (new_vl,new_sl,new_fl)
    end

  fun make_str_env (Datatypes.COPYSTR (_, str),generate_moduler) = make_str_env (str,generate_moduler)
  |   make_str_env (Datatypes.STR (_, ref (SOME env), _),generate_moduler) =
      cast env: EnvironTypes.Env
  |   make_str_env
	(Datatypes.STR
	   (_,
	    env_ref as ref NONE,
	    Datatypes.ENV
	      (Datatypes.SE strenv, Datatypes.TE tyenv, Datatypes.VE (_, valenv))),generate_moduler) =
    let
      val valenv =
        if generate_moduler then
          let
            val dummy_scheme = Datatypes.UNBOUND_SCHEME(Datatypes.NULLTYPE,NONE)
          in
            NewMap.fold (fn (map,Ident.TYCON(sym),_)=>NewMap.define(map,Ident.TYCON'(sym),dummy_scheme))
            (valenv,tyenv)
          end
        else valenv
      val (ve,se,_) = number_envs(NewMap.domain_ordered valenv,
				  NewMap.to_list_ordered strenv, [])
      
      val result =
	Lists.reducel
	  add_valid_env
	  (Lists.reducel
	     (fn (env, ((ident, str), field)) =>
	 	add_strid_env(env, (ident, (make_str_env (str,generate_moduler), field, generate_moduler))))
             (empty_env, se),
           ve)
    in
      env_ref := SOME (cast result);
      result
    end

  fun sort_fn f =
    fn ((x, _), (x', _)) => f (x, x')

  fun assign_fields(EnvironTypes.TOP_ENV(
    EnvironTypes.ENV(mv, ms), EnvironTypes.FUN_ENV m)) =
  let
    val (ve,se,fe) = number_envs (NewMap.to_list_ordered mv,
				  NewMap.to_list_ordered ms,
				  NewMap.to_list_ordered m)

    fun passing_on_prim (b as EnvironTypes.PRIM _) _ = b
      | passing_on_prim _ x = x
  in
    EnvironTypes.TOP_ENV
    (Lists.reducel
     (fn (env, ((sid, (e, var, generate_moduler)), f)) =>
      add_strid_env(env, (sid,(e, passing_on_prim var f, generate_moduler))))
     (Lists.reducel
      (fn (env, ((vid, var as EnvironTypes.LAMB lv), f as EnvironTypes.FIELD {index, ...})) =>
       (add_valid_env(env, (vid, passing_on_prim var f)))
        | (env, ((vid, var), f)) =>add_valid_env(env, (vid, passing_on_prim var f)))
      (empty_env, ve), se),
     Lists.reducel
     (fn (fun_env, ((fid, (_, e, generate_moduler)), f)) =>
      add_funid_env(fun_env, (fid,(f, e, generate_moduler))))
     (empty_fun_env, fe))
  end

  fun make_external(EnvironTypes.TOP_ENV
		    (EnvironTypes.ENV(mv, ms), EnvironTypes.FUN_ENV m)) =
    let
      fun do_valid(tree, v, comp as EnvironTypes.PRIM _) =
	NewMap.define(tree, v, comp)
	| do_valid(tree, v, _) =
	  NewMap.define(tree, v, EnvironTypes.EXTERNAL)
      fun do_strid(tree, v, comp as (_, EnvironTypes.PRIM _, _)) =
	NewMap.define(tree, v, comp)
	| do_strid(tree, v, (e, _, generate_moduler)) =
	  NewMap.define(tree, v, (e, EnvironTypes.EXTERNAL, generate_moduler))
      fun do_funid(tree, v, comp as (EnvironTypes.PRIM _, _, _)) =
	NewMap.define(tree, v, comp)
	| do_funid(tree, v, comp as (_, e, generate_moduler)) =
	  NewMap.define(tree, v, (EnvironTypes.EXTERNAL, e, generate_moduler))

      val valids =
	NewMap.fold
	do_valid
	(NewMap.empty (Ident.valid_lt,Ident.valid_eq), mv)
      val strids =
	NewMap.fold
	do_strid
	(NewMap.empty (Ident.strid_lt,Ident.strid_eq), ms)
      val funids =
	NewMap.fold
	do_funid
	(NewMap.empty (Ident.funid_lt,Ident.funid_eq), m)
    in
      EnvironTypes.TOP_ENV
      (EnvironTypes.ENV(valids, strids),
       EnvironTypes.FUN_ENV funids)
    end

  fun make_str_dexp(Datatypes.COPYSTR (_, str)) = make_str_dexp str
    | make_str_dexp(Datatypes.STR(_,_,Datatypes.ENV(Datatypes.SE(strmap),Datatypes.TE(tyconmap),
                                                    Datatypes.VE(_,valmap)))) =
      EnvironTypes.DENVEXP (EnvironTypes.DENV(NewMap.fold (fn (map,Ident.TYCON(tc),_) => 
                                                           NewMap.define (map,Ident.CON(tc),
                                                                          EnvironTypes.NULLEXP))
                                              (NewMap.map (fn _ => EnvironTypes.NULLEXP) valmap,tyconmap),
                                              NewMap.map (fn (_,str) => make_str_dexp str) strmap))
            

   (* Environment simplification function *)
      local
        open LambdaTypes
      in

        datatype result = 
          INTVAL of int |
          SCONVAL of Ident.SCon * int option |
          BUILTINVAL of LambdaTypes.Primitive |
          TUPLEVAL of result Vector.vector |
          DYNAMIC

        fun abs_eval (env,exp) =
          let
            fun lookup (x,[]) = DYNAMIC
              | lookup (x,(x',a)::rest) =
                if x = x' then a else lookup (x,rest)
          in
            case exp of
              VAR var => lookup (var,env)
            | FN _ => DYNAMIC
            | LET ((var,_, exp1),exp2) =>
                (case abs_eval (env,exp1) of
                   DYNAMIC => abs_eval (env,exp2)
                 | a => abs_eval ((var,a) :: env,exp2))
            | LETREC (_,_,e) => abs_eval (env,e)
            | APP _ => DYNAMIC
            | SCON scon => SCONVAL scon
            | INT i => INTVAL i
            | SWITCH(le, nums_opt, tag_le_list, le_op) =>
		let
		  fun filter_raises(acc, []) = acc
		    | filter_raises(acc, (tag, RAISE _) :: rest) =
		      filter_raises(acc, rest)
		    | filter_raises(acc, tag_le :: rest) =
		      filter_raises(tag_le :: acc, rest)
		  val tag_le_list = filter_raises([], tag_le_list)
		in
		  case tag_le_list of
		    [] =>
		      (case le_op of
			 SOME le => abs_eval(env, le)
		       | _ => Crash.impossible"abs_eval: empty switch")
		  | [(_, le)] =>
		      (case le_op of
			 NONE => abs_eval(env, le)
		       | _ => DYNAMIC)
		  | _ =>
		      DYNAMIC
		end
            | STRUCT (el,_) => 
                let
                  val values = map (fn e => abs_eval (env,e)) el
                in
                  if Lists.forall (fn DYNAMIC => true | _ => false) values
                    then DYNAMIC
                  else TUPLEVAL (Vector.fromList values)
                end
            | SELECT _ => DYNAMIC
            | RAISE _ => DYNAMIC
            | HANDLE _ => DYNAMIC
            | BUILTIN prim => BUILTINVAL prim
            | MLVALUE _ => DYNAMIC
          end

	exception BadList

        fun convert_list (INTVAL 1,acc) = TUPLEVAL (Vector.fromList (rev acc))
          | convert_list (TUPLEVAL elements,acc) =
            if Vector.length elements = 2
              then convert_list (Vector.sub (elements,1),Vector.sub (elements,0) :: acc)
            else
	      raise BadList
          | convert_list(DYNAMIC, _) = raise BadList
          | convert_list(SCONVAL _, _) = raise BadList
          | convert_list(BUILTINVAL _, _) = raise BadList
          | convert_list(INTVAL _, _) = raise BadList

        fun lookup (i,TUPLEVAL values) =
          if i >= Vector.length values
            then Crash.impossible "bad index for lookup"
          else Vector.sub (values,i)
          | lookup (i,_) = Crash.impossible "simplify_topenv:lookup"

        fun simplify_env (DYNAMIC,env) = env
          | simplify_env (values,EnvironTypes.ENV (valid_map,strid_map)) =
          let
            fun do_valid (valid,comp) =
              case comp of 
                EnvironTypes.FIELD {index,...} =>
                  (case lookup (index,values) of
                     BUILTINVAL b => EnvironTypes.PRIM b
                   | _ => comp)
              | _ => comp
            fun do_strid (strid,entry as (env,comp,b)) =
              case comp of
                EnvironTypes.FIELD {index,...} =>
                  (simplify_env (lookup (index,values), env),
                   comp,
                   b)
              | _ => entry
          in
            EnvironTypes.ENV (NewMap.map do_valid valid_map,NewMap.map do_strid strid_map)
          end
                      
        fun simplify_topenv(t_env as EnvironTypes.TOP_ENV (env,fun_env),exp) =
          let
            val values = convert_list (abs_eval ([],exp),[])
          in
            EnvironTypes.TOP_ENV (simplify_env (values,env),fun_env)
          end
	handle BadList => t_env
      end
end
