(* _valenv.sml the functor *)
(*
$Log: _valenv.sml,v $
Revision 1.41  1996/10/28 17:20:01  io
moving String from toplevel

 * Revision 1.40  1996/09/23  12:19:28  andreww
 * [Bug #1605]
 * removing default_overloads flag.  Now subsumed by old_definition.
 *
 * Revision 1.39  1996/04/30  15:26:02  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.38  1995/12/27  11:36:02  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.37  1995/09/08  17:47:43  daveb
Added realint_tyvar for abs and ~; removed real_tyvar and int_tyvar.

Revision 1.36  1995/07/27  16:27:54  jont
Add div and mod to list of overloaded operators

Revision 1.35  1995/05/26  10:33:17  matthew
Get list of builtin library values from Primitives

Revision 1.34  1995/02/06  10:54:38  matthew
Removing debug structure

Revision 1.33  1994/05/11  15:02:11  daveb
Added resolve_overloads.  Simplified code for creating initial ve.

Revision 1.32  1993/12/03  13:26:47  nosa
TYCON' for type function functions in lambda code for Modules Debugger.

Revision 1.31  1993/09/16  13:49:18  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.30  1993/03/04  10:23:31  matthew
Options & Info changes

Revision 1.29  1993/03/02  15:32:10  matthew
empty_rec_type to empty_rectype

Revision 1.28  1993/02/19  10:48:32  matthew
Moved enrichment code to _realise

Revision 1.27  1992/12/22  15:39:42  jont
Anel's last changes

Revision 1.26  1992/12/18  15:45:11  matthew
Propagating options to signature matching error messages.

Revision 1.25  1992/12/04  19:47:44  matthew
Error message revisions.

Revision 1.24  1992/11/25  15:43:48  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.23  1992/10/30  15:36:52  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.22  1992/09/09  11:49:47  matthew
Changed valenv printing

Revision 1.21  1992/08/27  20:01:16  davidt
Yet more changes to get structure copying working better.

Revision 1.20  1992/08/27  16:13:51  davidt
Added Anel's changes, and changed some stuff to do better
equality checking of valenvs etc.

Revision 1.19  1992/08/18  16:10:31  jont
Removed irrelevant handlers and new exceptions

Revision 1.18  1992/08/13  17:18:13  davidt
Changed to use Lists.reducel instead of Lists.foldr.

Revision 1.17  1992/08/11  17:52:46  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.16  1992/08/06  18:05:35  jont
Anel's changes to use NewMap instead of Map

Revision 1.14  1992/07/27  14:00:50  jont
Improved enrichment efficiency

Revision 1.13  1992/07/16  18:55:28  jont
Changed to use btrees for renaming of tynames and strnames

Revision 1.12  1992/06/16  14:12:58  clive
Added the printing of the name of the relevant identifier in a couple of error messages

Revision 1.11  1992/05/05  10:56:08  jont
Anel's fixes

Revision 1.10  1992/02/11  11:25:33  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.9  1992/01/30  17:38:29  jont
Removed some loop invariants from ve_ran_enriches and ee_ran_enriches
This is done for efficiency only, since NJ is too dumb to do it for you.
Our compiler, will, when we get there!

Revision 1.8  1992/01/27  20:16:32  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.7  1992/01/14  16:55:18  jont
Changed ref unit in valenv to ref int to assist encoder

Revision 1.6  1992/01/10  12:05:23  richard
Added a SUBSTRING pervasive as a temporary measure so that the same code
can be compiled under under both New Jersey and MLWorks.

Revision 1.5  1991/11/21  16:49:06  jont
Added copyright message

Revision 1.4  91/08/06  14:25:37  colin
fixed bug in ve_copy which was changing identifier status of all valids
to vars (now uses Mapping.domain rather than ve_domain)

Revision 1.3  91/07/16  16:01:28  colin
Made valenv map an eqfun_map with Ident.eq_valid as equality function. This
reflects the fact that in the semantics the domain of VE is a union rather
than a _disjoint_ union of VAR, CON and EXCON. Also made ve_domain coerce
everything to a VAR - this avoids problems with erroneous distinction of 
valid identifier classes.

Revision 1.2  91/06/17  18:13:00  nickh
Modified to take new ValEnv definition with ref unit to allow
reading and writing circular data structures.

Revision 1.1  91/06/07  11:42:03  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/crash";
require "../utils/lists";
require "../main/info";
require "../main/primitives";
require "../basics/identprint";
require "../typechecker/types";
require "../typechecker/scheme";

require "../typechecker/valenv";

functor Valenv(
  structure Crash     : CRASH
  structure Lists     : LISTS
  structure Info : INFO
  structure Primitives : PRIMITIVES
  structure IdentPrint : IDENTPRINT
  structure Types     : TYPES
  structure Scheme    : TYPESCHEME

  sharing Types.Options = IdentPrint.Options = Scheme.Options
  sharing Types.Datatypes = Scheme.Datatypes
  sharing Types.Datatypes.Ident = IdentPrint.Ident
  sharing IdentPrint.Ident.Location = Info.Location
    ) : VALENV =
  
  struct 
    structure Datatypes = Types.Datatypes
    type Options = Types.Options.options
    type ErrorInfo = Info.options

    open Datatypes
      
    exception LookupValId of Ident.ValId

    fun ve_plus_ve (VE (_,amap),VE (_,amap')) = 
      VE (ref 0, NewMap.union(amap, amap'))

    fun lookup (valid,VE (_,valenv)) = 
      case NewMap.tryApply'(valenv, valid) of
        SOME t => t
      | _ => raise LookupValId valid

    fun ve_domain (VE (_,amap)) = 
      NewMap.fold_in_rev_order
      (fn (res, Ident.CON sym, _) => Ident.VAR sym :: res
        | (res, Ident.EXCON sym, _) => Ident.VAR sym :: res
	| (res, v as (Ident.VAR _), _) => v :: res
        |  _ => Crash.impossible "TYCON':ve_domain:valenv")
      ([], amap)

    fun add_to_ve (valid,scheme,VE (_,amap)) =
      VE ((ref 0, NewMap.define (amap,valid,scheme)))
	 
    local
      val bool_scheme = Scheme.make_scheme ([],(CONSTYPE ([],Types.bool_tyname),NONE))
      fun atyvar (id,eq,imp) =
	TYVAR (ref (0,NULLTYPE,NO_INSTANCE),
               Ident.TYVAR (Ident.Symbol.find_symbol (id),eq,imp))
    in
      val initial_ee = empty_valenv
        
      val basic_constructor_set =
        Lists.reducel
        (fn (ve,(name,scheme)) =>
         (add_to_ve (Ident.CON (Ident.Symbol.find_symbol name),
                     scheme,
                     ve)))
        (empty_valenv,
         [("true",bool_scheme),
          ("false",bool_scheme),
          ("ref",
           let val aty = atyvar ("'_a",false,true)
           in
             Scheme.make_scheme([aty],(FUNTYPE (aty,CONSTYPE
                                                ([aty],Types.ref_tyname)),
                                       NONE))
           end),
          ("nil",
           let 
             val aty = atyvar ("'a",false,false)
           in
             Scheme.make_scheme([aty],(CONSTYPE ([aty],Types.list_tyname),
                                       NONE))
           end),
          ("::",
           let val aty = atyvar ("'a",false,false)
           in
             Scheme.make_scheme ([aty],
                                 (FUNTYPE
                                  (Types.add_to_rectype
                                   (Ident.LAB
                                    (Ident.Symbol.find_symbol ("1")),
                                    aty,Types.add_to_rectype
                                    (Ident.LAB
                                     (Ident.Symbol.find_symbol ("2")),
                                     CONSTYPE
                                     ([aty],Types.list_tyname),
                                     Types.empty_rectype)),
                                   CONSTYPE
                                   ([aty],Types.list_tyname)),NONE))
           end)])

      val initial_ve = 
        add_to_ve
	  (Ident.VAR (Ident.Symbol.find_symbol ("=")),
	   let val aty = atyvar ("''a",true,false)
	   in
	     Scheme.make_scheme ([aty],
                                 (FUNTYPE
                                  (Types.add_to_rectype
                                   (Ident.LAB
                                    (Ident.Symbol.find_symbol ("1")),aty,
                                    Types.add_to_rectype
                                    (Ident.LAB
                                     (Ident.Symbol.find_symbol ("2")),aty,
                                     Types.empty_rectype)),
                                   CONSTYPE ([],Types.bool_tyname)),
                                  NONE))
	   end,
           Lists.reducel
	     (fn (ve,(s, f, t)) =>
	        let val v = Ident.VAR (Ident.Symbol.find_symbol s)
	        in add_to_ve (v, f (v, t), ve)
	        end)
             (basic_constructor_set,
              [("~", Scheme.unary_overloaded_scheme, Ident.realint_tyvar),
               ("abs", Scheme.unary_overloaded_scheme, Ident.realint_tyvar),
               ("*", Scheme.binary_overloaded_scheme, Ident.num_tyvar),
               ("+", Scheme.binary_overloaded_scheme, Ident.num_tyvar),
               ("-", Scheme.binary_overloaded_scheme, Ident.num_tyvar),
               ("mod", Scheme.binary_overloaded_scheme, Ident.wordint_tyvar),
               ("div", Scheme.binary_overloaded_scheme, Ident.wordint_tyvar),
               ("/", Scheme.binary_overloaded_scheme, Ident.real_tyvar),
               ("<", Scheme.predicate_overloaded_scheme, Ident.numtext_tyvar),
               (">", Scheme.predicate_overloaded_scheme, Ident.numtext_tyvar),
               ("<=", Scheme.predicate_overloaded_scheme, Ident.numtext_tyvar),
               (">=", Scheme.predicate_overloaded_scheme, Ident.numtext_tyvar)]))

        val initial_ve_for_builtin_library =
          Lists.reducel
          (fn (env,s) =>
           let
             val aty = atyvar ("'a", false, false)
           in
             add_to_ve (Ident.VAR (Ident.Symbol.find_symbol s),
                        Scheme.make_scheme ([aty],(aty,NONE)),
                        env)
           end)
          (basic_constructor_set,
           (map #1 Primitives.values_for_builtin_library))
    end

    fun string_valenv (start, VE (_,amap)) =
      let 
        fun print_spaces (res, n) =
	  if n = 0 then concat(" " :: res)
	  else print_spaces (" " :: res, n-1)
      in
	NewMap.string IdentPrint.debug_printValId Scheme.string_scheme
	{start = "{", domSep = " |--> ", itemSep = "\n" ^ print_spaces([], start), finish = "}"}
	(NewMap.map (fn (id,sch)=>sch) amap)
      end

    fun empty_valenvp (VE (_,amap)) = NewMap.is_empty amap

    (*
     * Note that the constructor status of the identifiers in the domains
     * of valenvs is ignored during equality.
     *)

    fun valenv_eq (ve as VE (_,amap),ve' as VE (_,amap')) =
      NewMap.eq (fn (sch,sch')=> Scheme.typescheme_eq (sch,sch')) (amap, amap')

    fun dom_valenv_eq (ve as VE(_, m), ve' as VE(_, m')) =
      NewMap.eq (fn _ => true) (m, m')

    fun resolve_overloads
          error_info
          (ENV (_, _, VE (_, amap)),
	   options as Types.Options.OPTIONS
	     {print_options,
	      compat_options = Types.Options.COMPATOPTIONS
		{old_definition, ...},
	      ...}) =
      let
        fun error_fn (valid, loc) =
          Info.error' error_info
            (Info.FATAL, loc,
             "Unresolved overloading for "
             ^ IdentPrint.printValId print_options valid)

	fun resolve_scheme (_, SCHEME (i, (ty, inst))) =
	  Types.resolve_overloading (not old_definition, ty, error_fn)
	|   resolve_scheme (_, UNBOUND_SCHEME (ty, inst)) =
	  Types.resolve_overloading (not old_definition, ty, error_fn)
	|   resolve_scheme (_, s as OVERLOADED_SCHEME _) =
	  ()
      in
	NewMap.iterate resolve_scheme amap
      end
      
    fun ve_copy (VE (_,amap),tyname_copies) = 
      let
	fun copy (_, s) = Scheme.scheme_copy (s,tyname_copies)
      in
	VE(ref 0, NewMap.map copy amap)
      end

    fun tyvars (VE (_,amap)) = 
      Lists.filter
      (NewMap.fold (fn (acc, _,  ran) => Scheme.tyvars(acc, ran)) ([], amap))
  end
