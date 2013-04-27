(* _unify.sml the functor *)
(*
$Log: _unify.sml,v $
Revision 1.43  1998/02/19 16:48:31  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.42  1997/05/19  13:01:55  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.41  1997/05/01  13:20:16  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.40  1996/11/04  19:11:21  andreww
 * [Bug #1711]
 * Altering eq_and_imp to take account of real literals.
 *
 * Revision 1.39  1996/08/01  14:37:17  andreww
 * [Bug #1521]
 * Adding check for value polymorphism in unification of imperative variables
 * eq_and_imp.
 *
 * Revision 1.38  1996/04/30  15:47:59  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.37  1996/03/19  10:34:06  matthew
 * Removing string_inequalities option
 *
 * Revision 1.36  1996/02/22  12:50:38  jont
 * Replacing Map with NewMap
 *
 * Revision 1.35  1995/10/25  17:06:07  jont
 * Pretty up require statements
 *
Revision 1.34  1995/09/11  11:10:49  daveb
Added unification code for new overloaded tyvars.

Revision 1.33  1995/07/28  10:06:35  jont
Handle overloading of mod and div on ints and words

Revision 1.32  1995/05/11  14:45:38  matthew
Improving record domain error messages

Revision 1.31  1995/04/10  09:42:15  matthew
Moving various functions in here from Types

Revision 1.30  1995/02/02  14:59:16  matthew
Removing debug structure

Revision 1.29  1995/01/03  17:13:25  matthew
Change to substitution datatype

Revision 1.28  1994/05/13  15:35:25  daveb
Fixed erroneous boolean  expressions in do_overload.

Revision 1.27  1994/05/11  15:12:58  daveb
New overloading scheme.

Revision 1.26  1994/02/22  01:55:55  nosa
Changed Datatypes.instance to Datatypes.Instance.

Revision 1.25  1993/12/03  17:07:07  nickh
Remove TYNAME, fix substitution reference, remove old debugging code,
tidy up comments.

Revision 1.24  1993/11/26  09:14:39  nosa
Modified unified to be optionally side-effect free, returning substitutions;
Can apply resulting substitutions to types.

Revision 1.23  1993/09/22  09:45:16  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.22  1993/05/25  16:15:44  matthew
Change to output statements/

Revision 1.21  1993/05/18  18:22:11  jont
Removed integer parameter

Revision 1.20  1993/04/01  16:32:23  jont
Allowed overloadin on strings to be controlled by an option

Revision 1.19  1993/03/12  17:28:59  matthew
Reinstated record domain mismatch error.
./

Revision 1.18  1993/03/05  13:09:11  jont
Allowed overloading of relationals on strings

Revision 1.17  1993/02/08  12:01:54  matthew
Rationalised substructures

Revision 1.16  1992/12/22  15:38:38  jont
Anel's last changes

Revision 1.15  1992/12/10  18:48:32  matthew
RECORD_DOMAIN failure no longer generated.

Revision 1.14  1992/12/10  18:32:14  jont
Avoided stringifying types etc as debug unless really required

Revision 1.13  1992/12/03  12:35:04  matthew
Changed fail TYNAME ... to fail FAIL ...

Revision 1.12  1992/11/27  12:11:41  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.11  1992/11/25  15:41:36  jont
Modified unify to avoid so much recursion by stripping off various
METAs first

Revision 1.10  1992/10/27  15:01:47  jont
Fail bad unification on flexible records properly instead of crashing

Revision 1.9  1992/10/23  13:36:15  clive
Some bug fixes from Anel

Revision 1.8  1992/08/27  19:38:41  jont
Improved unify pattern matching

Revision 1.7  1992/06/16  08:21:31  jont
Modifications to sort out unification of flexible record types in order
to provide full information to the lambda translation

Revision 1.6  1992/05/06  21:33:04  jont
Fixed bug in unification of flexible record types.

Revision 1.5  1992/04/16  17:51:03  jont
Added lists parameter

Revision 1.4  1992/01/27  20:16:22  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.3  1992/01/24  16:19:00  jont
Updated to allow valenv in METATYNAME

Revision 1.2  1991/11/21  16:48:53  jont
Added copyright message

Revision 1.1  91/06/07  11:41:50  colin
Initial revision

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "../utils/lists";
require "../utils/print";
require "../utils/crash";
require "../main/options";
require "../typechecker/types";
require "unify";

functor Unify(
  structure Lists   : LISTS
  structure Print   : PRINT
  structure Crash   : CRASH
  structure Options : OPTIONS
  structure Types : TYPES

    ) : UNIFY =
  struct
    structure Datatypes = Types.Datatypes
    structure NewMap = Datatypes.NewMap
    structure Ident = Datatypes.Ident
    type options = Options.options

    open Datatypes

    (* Datatype for record domains in error results. *)

    datatype record =
      RIGID of (Ident.Lab * Type) list
    | FLEX  of (Ident.Lab * Type) list

    (* a substitution is returned for unification without side-effects *)

    type 'a refargs = 'a ref * 'a

    datatype substitution = 
      SUBST of ((int * Datatypes.Type * Datatypes.Instance) refargs list *
                (int * bool * Type * bool * bool) refargs list *
                Type refargs list)

    (* result of unification *)

    datatype unify_result =

      (* Unification succeeded. *)
      OK

      (* General failure. Returns the sub-types which could not be unified. *)

    | FAILED of Type * Type

      (* Different domains. Returns the two conflicting records. *)

    | RECORD_DOMAIN of record * record

      (* Explicit tyvars.
         Returns the explicit tyvar and the type it couldn't unify with. *)

    | EXPLICIT_TYVAR of Type * Type

      (* Wrong equality and imperative attributes.
         The first boolean is the equality attribute required, the
         second is the imperative attribute. *)

    | EQ_AND_IMP of bool * bool * Type

      (* Circularity.
         Returns the tyvar and the type which it couldn't unify to. *)

    | CIRCULARITY of Type * Type

      (* Overloading.
         Returns the type which could not be unified to the overloaded type. *)

    | OVERLOADED of Ident.TyVar * Type

      (* Substitution. side-effect free, returning a substitution *)

    | SUBSTITUTION of substitution

      (* the three assignment operations used in unification;
        we make them refs so we can record assignments in a substitution *)

    val assign1 : (((int * Type * Instance) ref
                    * (int * Type * Instance)) -> unit) ref = ref(fn _ => ())
    val assign2 : (((int * bool * Type * bool * bool) ref 
                    * (int * bool * Type * bool * bool)) -> unit) ref = ref(fn _ => ())
    val assign3 : ((Type ref * Type) -> unit) ref = ref(fn _ => ())

    fun apply_sub1(tyv,SUBST S) = ref(Lists.assoc(tyv,#1(S)))
    fun apply_sub2(recty,SUBST S) = ref(Lists.assoc(recty,#2(S)))
    fun apply_sub3(ty,SUBST S) = ref(Lists.assoc(ty,#3(S)))

    fun apply(SUBSTITUTION S,ty) = 
      let
        fun substitute_type(ty as TYVAR(tyv as ref(_,NULLTYPE,_),id)) =
            (TYVAR(apply_sub1(tyv,S),id)
             handle Lists.Assoc => ty)
          | substitute_type(ty as METATYVAR(tyv as ref(_,NULLTYPE,_),b1,b2)) = 
            (METATYVAR(apply_sub1(tyv,S),b1,b2)
             handle Lists.Assoc => ty)
          | substitute_type(METATYVAR (ref (_,ty,_),_,_)) = substitute_type ty
          | substitute_type(ty as META_OVERLOADED 
                            (tyv as ref NULLTYPE,v,valid,loc)) = 
            (META_OVERLOADED(apply_sub3(tyv,S),v,valid,loc)
             handle Lists.Assoc => ty)
          | substitute_type(META_OVERLOADED (ref ty,_,_,_)) = substitute_type ty
          | substitute_type(ty as METARECTYPE (tyv as ref (_,_,NULLTYPE,_,_))) = 
            (METARECTYPE(apply_sub2(tyv,S))
             handle Lists.Assoc => ty)
          | substitute_type(METARECTYPE (ref (_,_,ty,_,_))) = 
            substitute_type(ty)
          | substitute_type((RECTYPE amap)) =
            RECTYPE(NewMap.map substitute_type_map amap)
          | substitute_type(FUNTYPE(arg,res)) =
            FUNTYPE(substitute_type(arg),substitute_type(res))
          | substitute_type(CONSTYPE (tylist,tyname)) =
            CONSTYPE(map substitute_type tylist,tyname)
          | substitute_type ty = ty

	and substitute_type_map(_, ty) = substitute_type ty

      in
        substitute_type(ty)
      end
      | apply _ = Crash.impossible "NOT SUBSTITUTION:apply:unify"
    local

      (* Exception raised in the event of failure. *)

      exception Failed of unify_result

      (* Fail with a result. *)

      fun fail ex res = raise (Failed (ex res))

      fun remove_cons_meta (ty as META_OVERLOADED (ref ty',_,_,_)) =
	  (case ty' of
	     NULLTYPE => ty
	   | _ => remove_cons_meta ty')
	| remove_cons_meta (ty as METARECTYPE (ref {2 = b,3 = t,...})) =
	  if (not b) orelse (case t of METARECTYPE _ => true | _ => false) then
	    remove_cons_meta t
	  else
	    ty
	| remove_cons_meta (ty as CONSTYPE (l, tyname)) =
	  (case tyname of
	     METATYNAME {1 = ref tyfun,...} =>
	       (case tyfun of
		  ETA_TYFUN _ => remove_cons_meta (Types.apply (tyfun, l))
		| TYFUN _ => remove_cons_meta (Types.apply (tyfun, l))
		| _ => ty
		  )
	   | _ => ty)
	| remove_cons_meta ty = ty

      fun propagate_level level
        (recty as (METARECTYPE (r as ref (level',flex,ty,eq,imp)))) =
        (if level < level'
           then r := (level, flex, propagate_level level ty, eq, imp)
         else ();
           recty)
        | propagate_level level (RECTYPE amap) = 
          RECTYPE(NewMap.map (propagate_level_map level) amap)
        | propagate_level level (ty as (METATYVAR (r as ref (level',t,i),_,_))) =
          (if level < level' 
             then r := (level,propagate_level level t,i)
           else ();
             ty)
        | propagate_level _ ty = 
          ty

      and propagate_level_map level (_, ty) = propagate_level level ty

    (****
     eq_and_imp does the manipulation of the equality and imperative attributes
     during unification.
     Note: we must check that we can unify "imperative" and
     "applicative" type variables --- this is the case with value polymorphism
     ****)

        (* NOTE here: eq=true implies var doesn't admit equality
                      imp=true implies var is not imperative *)

      fun eq_and_imp (options,eq,imp,(TYVAR (_,Ident.TYVAR (_,eq',imp')))) = 
        let 
          val Options.OPTIONS{compat_options=
                              Options.COMPATOPTIONS{old_definition,...}
                              ,...} = options
            
          val imp = imp andalso old_definition
          val imp' = imp' andalso old_definition
        in
          if eq 
            then (eq' andalso (if imp
                                 then imp' 
                               else true))
          else (if imp
                  then imp'
                else true)
        end
        | eq_and_imp (options,eq,imp,FUNTYPE (a,r)) =
          if eq 
            then false 
          else (eq_and_imp (options,eq,imp,a)) andalso 
               (eq_and_imp (options,eq,imp,r))
        | eq_and_imp (options,eq,imp,DEBRUIJN (_,eq',imp',_)) =
        let 
          val Options.OPTIONS{compat_options=
                              Options.COMPATOPTIONS{old_definition,...}
                              ,...} = options
            
          val imp = imp andalso old_definition
          val imp' = imp' andalso old_definition
        in
          if eq 
            then (eq' andalso (if imp
                                 then imp' 
                               else true))
          else (if imp
                  then imp'
                else true)
        end
        | eq_and_imp (options,eq,imp,
                      CONSTYPE (tylist,METATYNAME{1 = ref tyfun,
                                                  4 = ref eq',...})) =
          (eq_and_imp (options,eq,imp,Types.apply (tyfun,tylist))
           handle NullTyfun =>
             let fun collect [] = true
                   | collect (h::t) = eq_and_imp (options,eq,imp,h) andalso 
                     (collect t)
             in
               ((not eq) 
                orelse
                (eq' andalso collect tylist))
             end)
        | eq_and_imp (options,eq,imp,CONSTYPE ([],name)) =
          if eq 
            then Types.eq_attrib name
          else true
        | eq_and_imp (options,eq,imp,CONSTYPE ([h],name)) =
          if eq then
            if Types.has_ref_equality name then
              eq_and_imp (options,false,imp,h)
            else Types.eq_attrib name andalso eq_and_imp (options,eq,imp,h)
          else eq_and_imp (options,eq,imp,h)
        | eq_and_imp (options,eq,imp,CONSTYPE (t,n)) = 
          let fun collect [] = true
                | collect (h::t) = eq_and_imp (options,eq,imp,h) 
                  andalso (collect t)
          in
            ((not eq) orelse (Types.eq_attrib n)) andalso (collect(t))
          end
        | eq_and_imp (options,eq,imp,RECTYPE amap) = 
          NewMap.forall (fn (_, x) => eq_and_imp(options,eq, imp, x)) amap
        | eq_and_imp (options,eq,imp,NULLTYPE) = true
        | eq_and_imp (options,eq,imp,
                      METATYVAR (x as ref (n,NULLTYPE,i),eq',imp')) =
          if (eq andalso not eq') orelse (imp andalso not imp')
            then (x := (n,
                        METATYVAR (ref (n,NULLTYPE,NO_INSTANCE),
                                   eq orelse eq',imp orelse imp'),i);
                  true)
          else true
        | eq_and_imp (options,eq,imp,METATYVAR (ref (_,t,_),eq',imp')) =
          if (eq andalso not eq') orelse (imp andalso not imp')
            then (eq_and_imp (options,eq,imp,t))
          else true
        | eq_and_imp (options,eq,imp,META_OVERLOADED(ref NULLTYPE,tv,_,_)) =
            (!Types.real_tyname_equality_attribute) orelse
            ( (* in this case, (i.e., in SML'96 mode), reals have no
                 equality attribute, and so can only be matched against
                 things which have no equality attribute. *)
            (not(tv=Ident.real_tyvar orelse tv=Ident.real_literal_tyvar))
            orelse (not eq))

        | eq_and_imp (options,eq,imp,m as META_OVERLOADED _) = true
        | eq_and_imp (options,eq,imp,
                      METARECTYPE (r as ref (n,true,t,eq',imp'))) =
          if (eq andalso not eq') orelse (imp andalso not imp')
            then (r := (n,true,t,eq orelse eq',imp orelse imp');
                  true)
          else true
        | eq_and_imp (options,eq,imp,
                      METARECTYPE (r as ref (n,false,t,eq',imp'))) =
          if (eq andalso not eq') orelse (imp andalso not imp')
            then (eq_and_imp (options,eq,imp,t))
          else true
            
      (****
       Occurs check in unification.
       ****)

      (* was - not_occurs (ameta,TYVAR _) = true  - changed 28/5/91 *)
          
      fun not_occurs_tyfun (ty,TYFUN (ty',_)) =
        not_occurs (ty,ty')
        | not_occurs_tyfun (ty,ETA_TYFUN tyname) =
          not_occurs_tyname (ty,tyname)
      | not_occurs_tyfun (ty,NULL_TYFUN _) =
        true
      and not_occurs_tyname (ty,TYNAME _) = true
        | not_occurs_tyname (ty,METATYNAME (ref tyfun,_,_,_,_,_)) =
          not_occurs_tyfun (ty,tyfun)
      and not_occurs (METATYVAR (ref (tyv as (n,_,_)),_,_),
                      TYVAR (r' as ref (n',_,_),_)) =
        (n > n')
        orelse
        (r' := tyv;
         true)
        | not_occurs (ameta,TYVAR _) = true
        | not_occurs (ameta,FUNTYPE(a,r)) = 
          not_occurs (ameta,a) andalso not_occurs (ameta,r)
        | not_occurs (ameta,t as DEBRUIJN _) = true
        | not_occurs (ameta,CONSTYPE (tylist,tyname)) =
          not_occurs_tyname (ameta, tyname)
          andalso
          Lists.forall (fn x => not_occurs(ameta,x)) tylist
        | not_occurs (ameta,RECTYPE amap)	= 
          NewMap.forall (fn (_, x) => not_occurs(ameta, x)) amap
        | not_occurs (ameta,NULLTYPE) = true
        | not_occurs (ameta as METATYVAR (ref (n,NULLTYPE,i),_,_),
                      ameta' as METATYVAR (x as ref (n',NULLTYPE,_),_,_)) = 
          if (Types.type_eq (ameta,ameta',true,true))
            then false
          else
            (n > n') 
            orelse
            (x := (n,NULLTYPE,i);
             true)
        | not_occurs (ameta as METATYVAR (ref (n,_,i),_,_),
                      ameta' as METATYVAR (x as ref (n',NULLTYPE,_),_,_)) = 
          if (Types.type_eq (ameta,ameta',true,true))
            then false
          else
            (n > n') 
            orelse
            (x := (n,NULLTYPE,i);
             true)
        | not_occurs (ameta,t as METATYVAR (ref (_,NULLTYPE,_),eq',imp')) =
          not (Types.type_eq (ameta,t,true,true))
        | not_occurs (ameta as METATYVAR (ref (n,_,i),_,_),
                      METATYVAR (x as ref (n',t,_),_,_)) = 
          (if (n > n') then () else x := (n,t,i);
             not_occurs (ameta,t))
        | not_occurs (ameta,METATYVAR (ref (_,t,_),_,_)) = not_occurs (ameta,t)
        | not_occurs (ameta,META_OVERLOADED _) = true
        | not_occurs (ameta,t as METARECTYPE (ref (_,true,arec,_,_))) = 
          not_occurs (ameta,arec)
        | not_occurs (ameta,METARECTYPE (ref (_,false,t,_,_))) = 
          not_occurs (ameta,t)

      exception NotRectype

      (* Unify a list of types. *)

      fun check set =
	let
	  fun check(Ident.VAR sy) =
	    let
	      val sy = Ident.Symbol.symbol_name sy
	    in
	      Lists.member(sy, set)
	    end
	    | check _ = false
	in
	  check
	end
	    
      val predicates = ["<", ">", "<=", ">="]
      val check_predicate = check predicates
      val mod_div = ["mod", "div"]
      val check_mod_or_div = check mod_div

      fun unify_lists (options,[], []) = ()
	| unify_lists (options,h :: t, h' :: t') = 
	  (unify' (options,h, h');
	   unify_lists (options,t, t'))
	| unify_lists _ =
	  Crash.impossible "Unify.unify_lists"

      and unify'(options,atype, atype') =
	let
	  val atype = remove_cons_meta atype
	  val atype' = remove_cons_meta atype'
	in
	  unify (options, atype, atype')
	end

      (* Unify two types. *)

      and unify(options,atype, atype') =
	case (atype, atype') of

	  (TYVAR (ref (n,_,_), id), TYVAR (ref (n',_,_), id')) =>
	    if (n = n' andalso id = id') then
	      ()
	    else
	      fail EXPLICIT_TYVAR (atype, atype')
		
	| (DEBRUIJN debruijn, DEBRUIJN debruijn') =>
	    if ((fn ty=>(#1(ty),#2(ty),#3(ty)))debruijn) = 
	      ((fn ty=>(#1(ty),#2(ty),#3(ty)))debruijn')
	      then ()
	    else
	      fail FAILED (atype, atype')

	| (FUNTYPE (a, r), FUNTYPE (a', r')) =>
	    (unify'(options,a, a');
	     unify'(options,r, r'))

	| (RECTYPE amap, RECTYPE amap') =>
	    let
	      (* Note that unify' fails using an exception *)
	      fun unify'' (ty, ty') = (unify'(options,ty, ty') ; true)
	      val res = NewMap.eq unify'' (amap, amap')
	    in
	      if res then ()
	      else
		let
		  val rec1 = NewMap.to_list_ordered amap
		  val rec2 = NewMap.to_list_ordered amap'
		in
		  fail RECORD_DOMAIN (RIGID rec1, RIGID rec2)
		end
(*
	      case res of
		Mapping.EQUAL =>
		  ()
	      | Mapping.NOT_EQUAL =>
		  (* Note that unify'' fails using an exception *)
		  Crash.impossible "Unify.unify RECTYPE and RECTYPE"
	      | Mapping.DIFFERENT_DOMAINS =>
		  let
		    val rec1 = Mapping.assoc amap
		    val rec2 = Mapping.assoc amap'
		  in
		    fail RECORD_DOMAIN (RIGID rec1, RIGID rec2)
		  end
*)
	    end

	| (METATYVAR (r as ref (n, NULLTYPE,_), eq, imp), _) =>
	    do_unify(options,r, eq, imp, atype')

	| (_, METATYVAR (r' as ref (n', NULLTYPE,_), eq', imp')) =>
	    do_unify(options,r', eq', imp', atype)
	     
	| (METATYVAR (ref (n, t,_), _, _), _) =>
	    unify'(options,t, atype')

	| (_, METATYVAR (ref (n', t',_), _, _)) =>
	    unify'(options,atype, t')

	| (META_OVERLOADED (ol as (r as ref NULLTYPE, tv, _, _)), _) =>
	     do_overload(ol, atype')

	| (_, META_OVERLOADED (ol as (r' as ref NULLTYPE, tv, _, _))) =>
	    do_overload(ol, atype)

	| (METARECTYPE (r as ref (_, true, RECTYPE _, _, _)), _) =>
	    (do_unify_rec(options,r, atype') 
	     handle NotRectype => fail FAILED (atype,atype'))

	| (_, METARECTYPE (r' as ref (_, true, RECTYPE _, _, _))) =>
	    (do_unify_rec(options,r', atype)
	     handle NotRectype => fail FAILED (atype,atype'))

	| (CONSTYPE (l, n), CONSTYPE (l', n')) =>
	    if Types.tyname_eq (n, n') then
	      unify_lists(options,l, l')
	    else
	      fail FAILED (atype, atype')

	| (_, _) => fail FAILED (atype, atype')

      (* Do the unification between a metatyvar and a type. *)

      and do_unify(options,r as ref (n, NULLTYPE,inst), eq, imp, t') =
	(case t' of
	   METATYVAR (r' as ref (n', NULLTYPE,inst'), eq', imp') =>

	     if r = r'
	       then ()
	     else
	       (let
		  val n'' = if n < n' then n else n'
		in
		  ((!assign1)(r',(n'', NULLTYPE,inst'));
		   (!assign1)(r,(n'', t',inst)))
		end;
		if eq_and_imp (options,eq, imp, t') 
		  then ()
		else Crash.impossible "Unify.do_unify METATYVAR and METATYVAR")
	   
	 | METATYVAR (r' as ref (n', t'',inst'), _, _) =>
	     if (n > n') andalso eq_and_imp (options,eq, imp, t') then
	       (!assign1)(r,(n', t',inst))
	     else do_unify(options,r, eq, imp, t'')
	       
	 | CONSTYPE (l, METATYNAME{1=ref(tyfun as ETA_TYFUN _), ...}) =>
	     do_unify(options,r, eq, imp, Types.apply (tyfun, l))
	     
	 | CONSTYPE (l, METATYNAME{1=ref(tyfun as TYFUN _), ...}) =>
	     do_unify(options,r, eq, imp, Types.apply (tyfun, l))
	     
	 | TYVAR (r' as ref (n',t,inst'),_) =>
	     if eq_and_imp (options,eq, imp, t')
	       then
		 let
		   val n'' = if n < n' then n else n'
		 in
		   ((!assign1)(r,(n'', t',inst));
		    (!assign1)(r',(n'',t,inst')))
		 end
	     else fail EQ_AND_IMP (eq, imp, t')
	       
	 | METARECTYPE (r' as ref (n', true, ty, eq', imp')) =>
	     if not_occurs (METATYVAR (r, eq, imp), t')
	       then
		 if eq_and_imp (options,eq, imp, t')
		   then
		     let 
		       val n'' = if n < n' then n else n'
		     in
		       ((!assign1)(r,(n'', t',inst));
			(!assign2)(r',(n'', true, propagate_level n'' ty, 
				       eq orelse eq',
				       imp orelse imp')))
		     end
		 else fail EQ_AND_IMP (eq, imp, t')
	     else fail CIRCULARITY (METATYVAR (r, eq, imp), t')
	       
	 | ty =>
	     if not_occurs (METATYVAR (r, eq, imp), t') 
	       then
		 if eq_and_imp (options,eq, imp, t') then
		   ((case t' of
		       NULLTYPE => Crash.impossible "nulltype"
		     | _ => ());
		       (!assign1)(r,(n, t',inst)))
		 else
		   fail EQ_AND_IMP (eq, imp, t')
	     else
	       fail CIRCULARITY (METATYVAR (r, eq, imp), t'))

	| do_unify _ = Crash.impossible "Unify.do_unify"

      (* Unify a meta-overloaded tyvar.
         The second argument will not be a metatyvar. *)

      and do_overload (ol as (r, tv, valid, loc), t') =
	case t' of
	  META_OVERLOADED(r' as ref NULLTYPE,tv',_,_) =>
	    (* We have two overloaded tyvars.  We have to check that they
	       are compatible, and make the most specific case the leaf. *)
	    if (r = r') then
	      ()
	    else if tv = Ident.numtext_tyvar then
	      (!assign3)(r, t')
	    else if tv' = Ident.numtext_tyvar then
	      (!assign3)(r', META_OVERLOADED ol)
	    else if tv = Ident.num_tyvar then
	      (!assign3)(r, t')
	    else if tv' = Ident.num_tyvar then
	      (!assign3)(r', META_OVERLOADED ol)
	    else if tv = Ident.wordint_tyvar then
	      if (tv' = Ident.real_tyvar orelse
		  tv' = Ident.real_literal_tyvar) then
	        fail OVERLOADED (tv, t')
	      else
	        (!assign3)(r, t')
	    else if tv' = Ident.wordint_tyvar then
	      if (tv = Ident.real_tyvar orelse
		  tv = Ident.real_literal_tyvar) then
	        fail OVERLOADED (tv', META_OVERLOADED ol)
	      else
	        (!assign3)(r', META_OVERLOADED ol)
	    else if tv = Ident.realint_tyvar then
	      if tv' = Ident.word_literal_tyvar then
	        fail OVERLOADED (tv, t')
	      else
	        (!assign3)(r, t')
	    else if tv' = Ident.realint_tyvar then
	      if tv = Ident.word_literal_tyvar then
	        fail OVERLOADED (tv', META_OVERLOADED ol)
	      else
	        (!assign3)(r', META_OVERLOADED ol)
	    else if tv = Ident.real_tyvar then
	      if (tv' = Ident.real_tyvar orelse
		  tv' = Ident.real_literal_tyvar) then
	        (!assign3)(r, t')
	      else
	        fail OVERLOADED (tv, t')
	    else if tv' = Ident.real_tyvar then
	      if tv = Ident.real_literal_tyvar then
	        (!assign3)(r', META_OVERLOADED ol)
	      else
	        fail OVERLOADED (tv, t')
	    else if tv' = tv then
	      (* E.g. two integer literals. *)
	      (!assign3)(r, t')
	    else
	      fail OVERLOADED (tv, t')

	| META_OVERLOADED(ref t'',_,_,_) =>
	    (* Traverse the list of existing instantiations. *)
	    do_overload(ol, t'')

	| _ =>
	    (* Unification of an overloaded type variable with an
	       ordinary type. *)
	    if tv = Ident.num_tyvar
	    andalso Types.num_typep t' then
	      (!assign3)(r,t')
	    else if tv = Ident.numtext_tyvar
	    andalso (Types.num_typep t'
	       	     orelse Types.num_or_string_typep t') then
	      (!assign3)(r,t')
	    else if tv = Ident.wordint_tyvar
	    andalso (Types.wordint_typep t') then
	      (!assign3)(r,t')
	    else if tv = Ident.realint_tyvar
	    andalso (Types.realint_typep t') then
	      (!assign3)(r,t')
	    else if tv = Ident.int_literal_tyvar
	    andalso Types.int_typep t' then
	      (!assign3)(r,t')
	    else if (tv = Ident.real_tyvar orelse tv = Ident.real_literal_tyvar)
	    andalso Types.real_typep t' then
	      (!assign3)(r,t')
	    else if tv = Ident.word_literal_tyvar
	    andalso Types.word_typep t' then
	      (!assign3)(r,t')
	    else fail OVERLOADED (tv, t')

      (* Unify a flexible record type.
         The second argument will not be a metatyvar. *)

      and do_unify_rec(options,
                       r as ref (level, _,ty as RECTYPE amap, eq, imp), t') =
	let
	  val t = METARECTYPE r
	in
	  case t' of
	    RECTYPE amap' =>
	      if not_occurs (t, t') then
		if eq_and_imp (options,eq,imp,t') then
		  let
		    fun unify'' (options,ty1, ty2) =
		      if (eq orelse imp) then
			if eq_and_imp (options,eq, imp, ty2) then
			  (unify'(options,ty1, ty2); true)
			else fail EQ_AND_IMP (eq, imp, ty2)
		      else (unify'(options,ty1, ty2); true)
		  in
		    NewMap.iterate
		    (fn (lab, ty) =>
		     let
		       val ty' = case NewMap.tryApply'(amap', lab) of
			 SOME ty' => ty'
		       | _ => 
			   let
			     val rec1 = NewMap.to_list_ordered amap
			     val rec2 = NewMap.to_list_ordered amap'
			   in
			     fail RECORD_DOMAIN (FLEX rec1, RIGID rec2)
			   end
		     in
		       if unify''(options,ty, ty') then
			 ()
		       else
			 Crash.impossible "Unify.do_unify_rec"
		     end)
		    amap;
		    (!assign2)(r,(level, false,
				  propagate_level level t', eq, imp))
(*
		    case Mapping.size (amap', amap, Ident.lab_order, 
				       unify'') of
		      Mapping.BIGGER =>
			(!assign2)(r,(level, false,
				      propagate_level level t', eq, imp))
		    | Mapping.NOT_BIGGER =>
			let
			  val rec1  = Mapping.assoc amap
			  val rec2 = Mapping.assoc amap'
			in
			  fail RECORD_DOMAIN (FLEX rec1, RIGID rec2)
			end
		    | Mapping.DIFFERENT_RANGE =>
			Crash.impossible "Unify.Mapping.size"
*)
		  end
		else fail EQ_AND_IMP (eq,imp,t')
	      else fail CIRCULARITY (t, t')
		 
	  | METARECTYPE (r' as ref (level', true, RECTYPE amap', eq', imp')) =>
	      if (r = r') 
                then ()
	      else
		if not_occurs (t, t') andalso not_occurs (t', t)
		  then
		    let 
		      infix andnot
		      fun (true, _) andnot (false, _) = true
			| (_, true) andnot (_, false) = true
			|     _     andnot     _      = false
			      
		      val leftfun =
			if (eq', imp') andnot (eq, imp) 
			  then
			    fn x =>
			    if eq_and_imp (options,eq', imp', x) 
			      then x
			    else
			      fail EQ_AND_IMP (eq', imp', x)
			else 
			  fn x => x
			  
		      val rightfun =
			if (eq, imp) andnot (eq', imp') 
			  then
			    fn x =>
			    if eq_and_imp (options,eq, imp, x)
			      then x
			    else
			      fail EQ_AND_IMP (eq, imp, x)
			else 
			  fn x => x
			  
		      fun unify''(options,x, y) =
			(unify'(options,leftfun x, rightfun y); true)

		      fun do_difference(in_map, out_map, res, in_fun) =
			NewMap.fold
			(fn (res, lab, ty) =>
			 case NewMap.tryApply'(out_map, lab) of
			   NONE =>
			     NewMap.define'(res, (lab, in_fun ty))
			 | _ => res)
			(res, in_map)

		      val new_map =
			do_difference(NewMap.empty' Ident.lab_lt, amap, amap', leftfun)
		      val new_map = do_difference(new_map, amap', amap, rightfun)
		      val new_map =
			NewMap.fold
			(fn (res, lab, ty) =>
			 case NewMap.tryApply'(amap', lab) of
			   SOME ty' =>
			     (ignore(unify''(options,ty, ty'));
			      NewMap.define'(res, (lab, ty)))
			 | _ => res)
			(new_map, amap)
(*
		      val new_map =
			Mapping.splice_maps
			(amap, amap', leftfun, rightfun, unify'', 
			 Ident.lab_order)
*)
			
		      val level'' = if level < level' then level else level'
			
		    in
		      (!assign2)(r,(level'', true, 
                                    propagate_level level'' t',eq, imp));
		      (!assign2)(r',(level'', true, 
                                     propagate_level level'' (RECTYPE new_map),
                                     eq', imp'))
		    end
		else
		  fail CIRCULARITY (t, t')

	 | _ => raise NotRectype
	 end

      | do_unify_rec _ = Crash.impossible "Unify.do_unify_rec(2)"

    in

      (* Top level unification function. *)

      fun unified(options, x, y, return_substitution) =
	let
	  val substitution = ref (nil,nil,nil)
	  fun add1 x = let val (s1,s2,s3) = !substitution
		       in substitution := (x::s1,s2,s3) end
	  fun add2 x = let val (s1,s2,s3) = !substitution
		       in substitution := (s1,x::s2,s3) end
	  fun add3 x = let val (s1,s2,s3) = !substitution
		       in substitution := (s1,s2,x::s3) end
	in
	  (assign1 := (if return_substitution then add1 else op :=);
	   assign2 := (if return_substitution then add2 else op :=);
	   assign3 := (if return_substitution then add3 else op :=);
	   unify'(options, x, y);
	   if return_substitution then
	     SUBSTITUTION (SUBST (!substitution))
	   else OK)
	  handle Failed res => 
	    if return_substitution then 
	      (print"\nWarning: Unification Failure; recipes may not be generated correctly\n";
	       SUBSTITUTION (SUBST (!substitution)))
           else res
	end
    end
  end;



