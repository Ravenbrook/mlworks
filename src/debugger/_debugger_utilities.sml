
(* _debugger_utilities the functor *)
(*
$Log: _debugger_utilities.sml,v $
Revision 1.15  1998/08/18 12:00:28  jont
[Bug #70068]
Avoid generating debug string when not needed

 * Revision 1.14  1997/05/21  16:35:59  jont
 * [Bug #30090]
 * Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.13  1997/05/02  14:14:55  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.12  1996/10/02  15:19:37  andreww
 * [Bug #1592]
 * threading level argument to TYNAMEs
 *
 * Revision 1.11  1996/08/05  17:22:27  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_types.sml
 *
 * Revision 1.10  1996/07/10  08:11:45  stephenb
 * Remove root_name since it is no longer used anywhere.
 * Also removed is_suppressed_frame_names for the same reason.
 *
 * Revision 1.9  1996/04/30  16:44:51  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.8  1996/03/28  10:38:33  matthew
 * Adding where type clause
 *
 * Revision 1.7  1996/02/22  13:50:54  jont
 * Replacing Map with NewMap
 *
 * Revision 1.6  1995/12/27  12:56:59  jont
 * Removing Option in favour of MLWorks.Option
 *
 * Revision 1.5  1995/11/15  17:09:09  jont
 * General improvements to debug inference of types in stack backtraces,
 * particularly for local variable debugging
 *
Revision 1.4  1995/04/13  13:23:04  matthew
Adding type generalization function

Revision 1.3  1995/03/08  17:22:00  matthew
Making debugger platform independent

Revision 1.1  1995/01/30  13:13:36  matthew
new unit
Renamed to debugger_utilities

Revision 1.31  1994/05/05  15:27:24  daveb
Datatypes.META_OVERLOADED takes extra arguments.

Revision 1.30  1994/02/22  03:14:13  nosa
Extra TYNAME valenv for Modules Debugger.

Revision 1.29  1993/12/09  19:27:08  jont
Added copyright message

Revision 1.28  1993/11/30  12:21:23  matthew
Added is_abs field to TYNAME and METATYNAME

Revision 1.27  1993/09/03  10:41:40  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.26  1993/09/02  17:07:53  matthew
Merging in bug fixes

Revision 1.25.1.2  1993/09/02  13:31:50  matthew
Added some debugging information

Revision 1.25  1993/05/18  18:41:18  jont
Removed integer parameter

Revision 1.24  1993/04/29  10:19:59  matthew
Renamed Debugger_Type_Utilities to DebuggerTypeUtilities

Revision 1.23  1993/03/10  16:59:36  matthew
Signature revisions

Revision 1.22  1993/03/04  13:11:12  matthew
Options & Info changes
Removed options param from generate_recipe

Revision 1.21  1993/03/02  17:45:31  matthew
Rationalised use of Mapping structure

Revision 1.20  1993/02/04  16:15:20  matthew
Changed functor parameter

Revision 1.19  1992/12/22  15:00:54  jont
Anel's last changes

Revision 1.18  1992/12/09  15:55:22  clive
Changed to error message to a better one

Revision 1.17  1992/12/07  17:09:59  clive
Added some debugging messages

Revision 1.16  1992/12/01  16:46:32  matthew
Removed "Can't generate debugging information" warning

Revision 1.15  1992/11/26  15:29:14  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.14  1992/11/17  13:08:52  matthew
Changed Error structure to Info

Revision 1.13  1992/11/16  15:34:01  clive
Changed the format of the error message

Revision 1.12  1992/10/12  11:47:54  clive
Tynames now have a slot recording their definition point

Revision 1.11  1992/09/30  08:26:59  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.10  1992/09/04  08:36:08  richard
Installed central error reporting mechanism.

Revision 1.9  1992/09/02  08:42:11  clive
Tidied up the wrong-type-found message

Revision 1.8  1992/08/24  09:54:38  clive
Added details about leafness to the debug information

Revision 1.7  1992/08/18  14:16:49  clive
Various improvements

Revision 1.6  1992/08/07  13:32:39  clive
New sharing constraints after lower level changes

Revision 1.5  1992/08/07  13:32:39  clive
Handles the propogation of types better

Revision 1.4  1992/07/22  09:23:26  clive
Periodical checking in - many improvements

Revision 1.3  1992/07/21  14:46:46  clive
More work on the debugger

Revision 1.2  1992/07/16  16:58:21  clive
Added utilites for the polymorphic deduction code

Revision 1.1  1992/07/09  09:43:35  clive
Initial revision

 * Copyright (c) 1993 Harlequin Ltd.
*)

require "../basis/__text_io";

require "../utils/lists";
require "../utils/crash";
require "../typechecker/types";
require "../typechecker/scheme";
require "debugger_types";
require "debugger_utilities";

functor DebuggerUtilities(
  structure Lists : LISTS
  structure Crash : CRASH
  structure Types : TYPES
  structure Scheme : SCHEME
  structure Debugger_Types : DEBUGGER_TYPES

  sharing Types.Datatypes = Scheme.Datatypes
  sharing type Types.Datatypes.Type = Debugger_Types.Type
  sharing type Types.Datatypes.Tyname = Debugger_Types.Tyname
  sharing type Debugger_Types.Options.options = Types.Options.options
                                ) : DEBUGGER_UTILITIES =
  
  struct
    
    structure Debugger_Types = Debugger_Types
    structure Datatypes = Types.Datatypes
    structure NewMap = Datatypes.NewMap
    structure Ident = Datatypes.Ident
    structure Options = Types.Options

    val do_debug = false

    fun debug f =
      if do_debug
        then TextIO.output(TextIO.stdErr,"  # " ^ f () ^ "\n")
      else ()

    fun slim_down_a_type(x as Datatypes.METATYVAR(ref(_,Datatypes.NULLTYPE,_),_,_)) = x
      | slim_down_a_type(Datatypes.METATYVAR(ref(_,ty,_),_,_)) = slim_down_a_type ty
      | slim_down_a_type(Datatypes.META_OVERLOADED {1=ref ty,...}) =
        slim_down_a_type ty
      | slim_down_a_type(x as Datatypes.TYVAR _) = x
      | slim_down_a_type(Datatypes.METARECTYPE(ref(_,_,ty,_,_))) = slim_down_a_type ty
      | slim_down_a_type(Datatypes.RECTYPE mapping) =
          Datatypes.RECTYPE(NewMap.map slim_down_a_type_map mapping)
      | slim_down_a_type(Datatypes.FUNTYPE(arg,res)) =
        Datatypes.FUNTYPE(slim_down_a_type arg,slim_down_a_type res)
      | slim_down_a_type(Datatypes.CONSTYPE(ty_list,tyname)) =
        Datatypes.CONSTYPE(map slim_down_a_type ty_list,tyname)
      | slim_down_a_type(x as Datatypes.DEBRUIJN _) = x
      | slim_down_a_type x = x
 
    and slim_down_a_type_map(_, ty) = slim_down_a_type ty

    fun cut_away_unnecessary_stuff(x as Datatypes.METATYVAR(ref(_,
                                                Datatypes.NULLTYPE,_),_,_)) = x
      | cut_away_unnecessary_stuff(Datatypes.METATYVAR(ref(_,x,_),_,_)) = 
        cut_away_unnecessary_stuff x
      | cut_away_unnecessary_stuff x = x

    exception GenerateRecipe of string
    exception NullType

    fun get_arg_and_res_types(Datatypes.FUNTYPE (arg,res)) = (arg,res)
      | get_arg_and_res_types arg =
        Crash.impossible ("get_arg_and_res_types: Not a function type: " ^ Types.debug_print_type Options.default_options arg)

    (* for an impossible case, we don't care what options will be passed*)

    (* We walk the first argument, working out a position for each metatyvar that occurs;
       we then use the map to walk the second argument *)

    (* Add the parameter type onto the assoc list *)
    fun walk(assoc,ty,f) =
      walk'((ty,f Debugger_Types.NOP)::assoc,ty,f)

    and walk'(assoc,Datatypes.NULLTYPE,_) = assoc
      | walk'(assoc,Datatypes.META_OVERLOADED {1=ref ty,...}, f) =
	walk'(assoc,ty,f)
      (* Can we do something better with this? *)
(*
      | walk'(assoc,Datatypes.TYVAR _,_) = raise GenerateRecipe "Tyvar found"
*)
        
      | walk'(assoc,var as Datatypes.TYVAR _,f) = 
        (var,f Debugger_Types.NOP)::assoc
      (* Add metatyvars onto assoc list *)
      (* METATYVARs represent polymorphic types *)
      | walk'(assoc,var as Datatypes.METATYVAR(ref (_,Datatypes.NULLTYPE,_),_,_),f) = 
        (var,f Debugger_Types.NOP)::assoc
      | walk'(assoc,Datatypes.METATYVAR(ref(_,ty,_),_,_),f) = walk'(assoc,ty,f)
      | walk'(assoc,Datatypes.METARECTYPE(ref(_,_,ty,_,_)),f) = walk'(assoc,ty,f)
      | walk'(assoc,ty as (Datatypes.RECTYPE _),f) =
        let
          val range = Types.rectype_range ty
          val (assoc',_) = 
            Lists.reducel (fn ((assoc,count),ty) =>
                           (walk'(assoc,ty,fn x => f(Debugger_Types.SELECT(count,x))),count+1))
                           ((assoc,0),range)
        in
          assoc'
        end
      | walk'(assoc,Datatypes.FUNTYPE(arg,res),f) =
        (* Add the argument and result type to the assoc list *)
        walk (walk (assoc,
                    arg,
                    fn x => f (Debugger_Types.FUNARG x)),
              res,
              fn x => f(Debugger_Types.FUNRES x))
      (* Added constructed types onto assoc list *)
      (* Note that the ty_name is ignored *)
      (* This where functor parameter types will appear *)
      | walk'(assoc,ty as Datatypes.CONSTYPE(ty_list,ty_name),f) =
        let
          val assoc' = (ty,f Debugger_Types.NOP)::assoc
          val (assoc'',_) = 
            (* Add the parameter types to the assoc list *)
            Lists.reducel (fn ((assoc,count),ty) =>
                           (walk (assoc,
                                  ty,
                                  fn x => f (Debugger_Types.DECONS(count,x))),
                            count+1))
            ((assoc',0),ty_list)
        in
          assoc''
        end
      | walk'(assoc,Datatypes.DEBRUIJN _,_) = Crash.impossible "walk':DeBruijn found"

    fun generate_recipe options (ty,recipe_for,name) =
      (case ty of
        Datatypes.NULLTYPE => raise NullType
      | _ =>
          let
            val (arg,res) = get_arg_and_res_types(cut_away_unnecessary_stuff ty)
            val assoc = walk([],arg,fn x => x)
              
            exception Assoc
            
            fun do_assoc(x,y) =
              let
                fun eq(Datatypes.METATYVAR(n as ref(n',Datatypes.NULLTYPE,_),_,_),
                       Datatypes.METATYVAR(m as ref(m',Datatypes.NULLTYPE,_),_,_)) =
		  m=n
                  | eq(arg as Datatypes.METATYVAR(ref(n,
                                  Datatypes.NULLTYPE,_),_,_),arg') = eq(arg',arg)
                  | eq(Datatypes.METATYVAR(ref(_,t,_),_,_),
                       arg' as Datatypes.METATYVAR(ref(n,Datatypes.NULLTYPE,_),_,_)) = 
                    eq(t,arg')
                  | eq(Datatypes.METATYVAR(ref(_,t,_),_,_),arg) = eq(t,arg)
                  | eq(arg,Datatypes.METATYVAR(ref(_,t,_),_,_)) = eq(arg,t)
                  | eq(Datatypes.META_OVERLOADED {1=ref ty,...}, arg') = eq(ty,arg')
                  | eq(arg',Datatypes.META_OVERLOADED {1=ref ty,...}) = eq(arg',ty)
                  (* Is this the correct test or should we look for equality of the refs *)
                  | eq(Datatypes.TYVAR (_,Datatypes.Ident.TYVAR (sym,_,_)),
                       Datatypes.TYVAR (_,Datatypes.Ident.TYVAR (sym',_,_))) = 
                    sym=sym'
                  | eq(Datatypes.FUNTYPE(t,t'),Datatypes.FUNTYPE(s,s')) = eq(t,s) andalso eq(s,s')
                  | eq(Datatypes.METARECTYPE(ref(_,_,t,_,_)),arg) = eq(t,arg)
                  | eq(arg,Datatypes.METARECTYPE(ref(_,_,t,_,_))) = eq(arg,t)
                  | eq(Datatypes.CONSTYPE(args,
                                          Datatypes.TYNAME(n,_,_,_,_,_,_,_,_)),
                       Datatypes.CONSTYPE(args',
                                          Datatypes.TYNAME(m,_,_,_,_,_,_,_,_)))
                    =
                    let
                      fun check ([],[]) = true
                        | check (_,[]) = false
                        | check([],_) = false
                        | check (h::t,a::b) = eq(h,a) andalso check(t,b)
                    in
                      (m=n) andalso check(args,args')
                    end
                  | eq(Datatypes.RECTYPE amap,Datatypes.RECTYPE amap') =
                    NewMap.eq eq (amap, amap')
                  | eq (x,y) = false
                    
                fun assoc'(x,[]) = raise Assoc
                  | assoc'(x,(h,a)::t) = 
                    if eq(x,h)
                      then a
                    else assoc'(x,t)
              in
                assoc'(x,y)
              end
            
            fun make_recipe arg =
              let
                val (found,recipe) = 
                  (true,do_assoc(arg,assoc)) 
                  handle Assoc => (false,Debugger_Types.ERROR "Recipe not found")
              in
                if found
                  then recipe
                else make_recipe' arg
              end
            
            and make_recipe'(arg as Datatypes.METATYVAR(ref(_,Datatypes.NULLTYPE,_),_,_)) =
              (do_assoc(arg,assoc)
               handle Assoc =>
		 (debug (fn () =>
			 let
			   val str =
			     "generating recipe inside " ^ name ^ " with types\nrecipe_for = " ^
			     Types.debug_print_type options recipe_for ^ " as " ^ 
			     Types.extra_debug_print_type recipe_for ^ " and ty =\n" ^
			     Types.debug_print_type options ty ^ " as " ^ 
			     Types.extra_debug_print_type ty ^ "\n"
			 in
			   "Hidden nulltype found in " ^
			   Types.extra_debug_print_type arg ^ " when " ^ str
			 end);
		  raise GenerateRecipe "Hidden nulltype"))
              | make_recipe'(arg as Datatypes.METATYVAR(ref(_,ty,_),_,_)) = 
                make_recipe ty
              | make_recipe'(Datatypes.META_OVERLOADED {1=ref ty,...}) =
                make_recipe ty
              | make_recipe'(arg as Datatypes.TYVAR _) =
                (do_assoc(arg,assoc)
                 handle Assoc => raise GenerateRecipe "tyvar not found")
              | make_recipe'(Datatypes.METARECTYPE(ref(_,_,ty,_,_))) = 
                make_recipe ty
              | make_recipe'(ty as Datatypes.RECTYPE amap) =
                let
                  val domain = Types.rectype_domain ty
                  val range = Types.rectype_range ty
                in
                  Debugger_Types.MAKERECORD
                  (map
                   (fn (Datatypes.Ident.LAB x,y) => (Datatypes.Ident.Symbol.symbol_name x,make_recipe y))
                   (NewMap.to_list amap))
                end
              | make_recipe'(Datatypes.FUNTYPE(from,to)) = 
                Debugger_Types.MAKEFUNTYPE(make_recipe from,make_recipe to)
              | make_recipe'(Datatypes.CONSTYPE(args,tyname)) = 
                Debugger_Types.MAKECONSTYPE(map make_recipe args,tyname)
              | make_recipe' _ = raise GenerateRecipe "No type case"
                
            val result = 
              case recipe_for of 
                Datatypes.NULLTYPE => 
                  ((* debug (fn _ => "output type is null: " ^ name);*) raise NullType)
              | _ => make_recipe recipe_for
                                
          in
	    case result of
	      Debugger_Types.NOP =>
		let
		  val options = Options.default_options
		  val seen_tyvars = Types.no_tyvars
		  val (str1, seen_tyvars) =
		    Types.print_type_with_seen_tyvars
		    (options, ty, seen_tyvars)
		  val (str2, seen_tyvars) =
		    Types.print_type_with_seen_tyvars
		    (options, recipe_for, seen_tyvars)
		in
(*
		  output(std_out, "Recipe for " ^ name ^ " with ty =\n" ^
			 str1 ^ " and recipe_for =\n" ^
			 str2 ^ " is nop\n");
*)
		  (*raise NullType*)result
		end
	    | _ => result
          end)
         handle NullType => (*Debugger_Types.NOP (* Huh? *)*)
	   Debugger_Types.ERROR"input type null (probably a match default function)"
              | GenerateRecipe s => 
                  ((* debug (fn _ => "Problem for " ^ name ^ ": " ^ s); *)
                   Debugger_Types.ERROR s)

    exception ApplyRecipe of string

    fun apply_recipe(recipe,start_type) =
      let
        fun apply_recipe' (Debugger_Types.NOP,x) = x
          | apply_recipe' (Debugger_Types.ERROR s,_) = raise ApplyRecipe ("Error: " ^ s)
          | apply_recipe' (_,ty as Datatypes.NULLTYPE) = raise ApplyRecipe "Nulltype found"
          | apply_recipe' (x,Datatypes.METATYVAR(ref(_,ty,_),_,_)) = apply_recipe' (x,ty)
          | apply_recipe' (x,Datatypes.METARECTYPE(ref(_,_,ty,_,_))) = apply_recipe' (x,ty)
          | apply_recipe'(x,Datatypes.META_OVERLOADED {1=ref ty,...}) =
	    apply_recipe' (x,ty)
          | apply_recipe' (Debugger_Types.SELECT(arg,recipe'),ty as Datatypes.RECTYPE _) =
            let
              val range = Types.rectype_range ty
              fun select (0,h::t) = h
                | select (n,[]) = 
                  raise ApplyRecipe "Nil found before count is zero"
                | select (n,h::t) = select(n-1,t)
            in
              apply_recipe'(recipe',select(arg,range))
            end
          | apply_recipe'(Debugger_Types.MAKERECORD args,ty) =
            let
(*
              fun make_mapping ([],mapping) = mapping
                | make_mapping ((label,recipe)::rest,mapping) = 
                  make_mapping(rest,
                               Datatypes.Mapping.add((Datatypes.Ident.LAB
                                                      (Datatypes.Ident.Symbol.find_symbol label),
                                                      apply_recipe'(recipe,start_type)),
                               mapping,
                               Datatypes.Ident.lab_order))
*)
            in
(*
              Datatypes.RECTYPE(make_mapping (args,Datatypes.Mapping.empty_map))
*)
              Datatypes.RECTYPE(Lists.reducel
				(fn(map, (label,recipe)) =>
				 NewMap.define'(map, (Datatypes.Ident.LAB
                                                      (Datatypes.Ident.Symbol.find_symbol label),
                                                      apply_recipe'(recipe,start_type))))
				(NewMap.empty' Ident.lab_lt, args))
            end
          | apply_recipe'(Debugger_Types.MAKECONSTYPE(args,ty_name),ty) =
            Datatypes.CONSTYPE(map (fn x => apply_recipe'(x,start_type)) args,ty_name)
          | apply_recipe'(Debugger_Types.DECONS(value,recipe),Datatypes.CONSTYPE(args,_)) =
            let
              fun select(_,[]) = raise ApplyRecipe "Value too big in constype"
                | select(0,h::t) = h
                | select(n,h::t) = select(n-1,t)
            in
              apply_recipe'(recipe,select(value,args))
            end
          | apply_recipe'(Debugger_Types.FUNARG(recipe),Datatypes.FUNTYPE(x,_)) =
            apply_recipe'(recipe,x)
          | apply_recipe'(Debugger_Types.FUNRES(recipe),Datatypes.FUNTYPE(_,x)) =
            apply_recipe'(recipe,x)
          | apply_recipe'(Debugger_Types.MAKEFUNTYPE(recipe,recipe'),ty) =
            Datatypes.FUNTYPE(apply_recipe'(recipe,start_type),apply_recipe'(recipe',start_type))
          | apply_recipe' (recipe,_) = 
            raise ApplyRecipe ("Did not match any of the cases" ^ 
                                     Debugger_Types.print_backend_annotation
                                     Options.default_options recipe)
      in
        apply_recipe'(recipe,start_type)
      end

    fun is_type_polymorphic (Datatypes.METATYVAR(ref(_,Datatypes.NULLTYPE,_),_,_)) = true
      | is_type_polymorphic (Datatypes.METATYVAR(ref(_,ty,_),_,_)) = is_type_polymorphic ty
      | is_type_polymorphic (Datatypes.NULLTYPE) = false
      | is_type_polymorphic (Datatypes.META_OVERLOADED {1=ref ty,...}) =
	is_type_polymorphic ty
      | is_type_polymorphic (Datatypes.TYVAR _) = true
      | is_type_polymorphic (Datatypes.METARECTYPE(ref(_,_,ty,_,_))) = is_type_polymorphic ty
      | is_type_polymorphic (ty as Datatypes.RECTYPE _) = 
        let
          val range = Types.rectype_range ty
        in
          Lists.exists is_type_polymorphic range
        end
      | is_type_polymorphic (Datatypes.FUNTYPE (a,b)) =
        is_type_polymorphic a orelse is_type_polymorphic b
      | is_type_polymorphic (Datatypes.CONSTYPE(args,_)) =
        Lists.exists is_type_polymorphic args
      | is_type_polymorphic (Datatypes.DEBRUIJN _) = true

    val handler_type = Datatypes.FUNTYPE(Datatypes.CONSTYPE([],Types.exn_tyname),Datatypes.NULLTYPE)
    val setup_function_type = Datatypes.FUNTYPE (Types.empty_rectype,Types.empty_rectype)

    fun is_nulltype Datatypes.NULLTYPE = true
      | is_nulltype _ = false



    fun add_tyvar (tyvar,[],acc) = tyvar :: acc
      | add_tyvar (tyvar,l as (tyvar'::rest),acc) =
        if Types.type_eq (tyvar,tyvar',false,false) then acc @ l
        else add_tyvar (tyvar,rest,tyvar'::acc)

    (* Maybe this should be in Types *)
    local
      open Datatypes
      fun get_scheme_type (SCHEME (_,(ty,_))) = ty
        | get_scheme_type (UNBOUND_SCHEME (ty,_)) = ty
        | get_scheme_type (OVERLOADED_SCHEME _) =
          Crash.impossible "get_scheme_type"

      (* Maybe this should be in types *)
      (* Accumulate the non-imperative tyvars in a type *)
      fun get_tyvars (tyvarlist, tyvar as METATYVAR (ref (_,NULLTYPE,_),_,imp)) = 
        if imp then tyvarlist
        else add_tyvar (tyvar,tyvarlist,[])
        | get_tyvars (tyvarlist, METATYVAR (ref (_,atype,_),_,_)) = 
          get_tyvars (tyvarlist, atype)
        | get_tyvars (tyvarlist, tyvar as TYVAR (_,Ident.TYVAR (_,_,imp))) = 
          if imp then tyvarlist
          else add_tyvar (tyvar,tyvarlist,[])
        | get_tyvars (tyvarlist, METARECTYPE (ref (_,_,atype,_,_))) =
          get_tyvars (tyvarlist, atype)
        | get_tyvars (tyvarlist, RECTYPE amap) = 
          NewMap.fold
          get_tyvars_fold
          (tyvarlist, amap)
        | get_tyvars (tyvarlist, FUNTYPE (atype,atype')) = 
          get_tyvars (get_tyvars (tyvarlist, atype), atype')
        | get_tyvars (tyvarlist, CONSTYPE (tylist,_)) =
          Lists.reducel get_tyvars (tyvarlist, tylist)
        | get_tyvars (tyvarlist, _) = tyvarlist

      and get_tyvars_fold(tyvarlist, _, ty) = get_tyvars(tyvarlist, ty)
    in
      fun close_type ty =
        get_scheme_type (Scheme.make_scheme (get_tyvars ([],ty),(ty,NONE)))
    end
       
  end
 
