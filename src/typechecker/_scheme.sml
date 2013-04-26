(* _scheme.sml the functor *)
(*
$Log: _scheme.sml,v $
Revision 1.66  1998/02/19 16:42:17  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.65  1998/02/02  16:26:42  mitchell
 * [Bug #50006]
 * Fix is_polymorphic for Debruijn variables
 *
 * Revision 1.64  1996/11/06  11:33:21  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.63  1996/10/29  13:49:19  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.62  1996/09/24  10:02:29  matthew
 * Adding monotype instantiations of metatyvars in signature matching
 *
 * Revision 1.61  1996/08/20  12:32:44  andreww
 * [Bug #1522]
 * Modified the signature matching error message to report if a free
 * (explicit) type variable was trying to match a bound type var.
 *
 * Revision 1.60  1996/08/06  13:24:30  andreww
 * [Bug #1521]
 * Propagating changes to _types.sml and _completion.sml
 * and dividing the dynamic_generalises function into two:
 * one for sml'90 and one for sml'96 (to take into account the
 * differences in treatment of "imperative" variables.
 *
 * Revision 1.59  1996/07/03  15:29:52  jont
 * Change check for free imperative type variables to return
 * the full type as well as the type variable
 *
 * Revision 1.58  1996/05/07  10:40:58  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.57  1996/04/30  17:42:39  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.56  1996/04/29  13:40:11  matthew
 * Integer changes
 *
 * Revision 1.55  1996/03/19  15:52:30  matthew
 * Adding option for value polymorphism
 *
 * Revision 1.54  1996/03/08  12:18:02  daveb
 * Converted the types Dynamic and Type to the new identifier naming scheme.
 *
 * Revision 1.53  1996/02/26  16:23:24  matthew
 * Improve message about imperative type variables
 *
 * Revision 1.52  1996/02/22  15:20:31  jont
 * Replacing Map with NewMap
 *
 * Revision 1.51  1996/02/21  13:16:14  daveb
 * Moved MLWorks.Dynamic to MLWorks.Internal.Dynamic.  Hid some members; moved
 * some functionality to the Shell structure.
 *
 * Revision 1.50  1995/12/27  11:32:55  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.49  1995/12/18  12:43:22  matthew
Changing error behaviour for unresolved records.

Revision 1.48  1995/11/02  11:57:32  matthew
Adding (optional) support for value polymorphism

Revision 1.47  1995/05/11  11:45:36  matthew
Improving error messages

Revision 1.46  1995/03/24  12:02:26  matthew
Use Stamp instead of Tyname_id etc.

Revision 1.45  1995/02/13  17:09:08  matthew
Debugger stuff

Revision 1.44  1995/01/30  11:54:15  matthew
Rationalizing debugger

Revision 1.43  1994/07/01  14:40:42  jont
Fix error messages for attempted unification during signature matching

Revision 1.42  1994/06/17  16:52:36  jont
Allow alternative printing of types to include quantifiers

Revision 1.41  1994/05/11  14:26:33  daveb
New overloading scheme.

Revision 1.40  1994/02/21  22:42:19  nosa
Only return real instance of type variables in Modules Debugger.

Revision 1.39  1993/12/03  15:49:37  nickh
Removed dead code, removed colons in an error message.

Revision 1.38  1993/11/30  14:50:16  nickh
Marked certain error messages as "impossible".

Revision 1.37  1993/11/24  17:29:52  nickh
Added code to encode type errors as a list of strings and types.

Revision 1.36  1993/09/23  12:22:01  nosa
Typechecker now records instances in closed-over type variables
for polymorphic debugger.

Revision 1.35  1993/05/21  15:34:35  matthew
Removed output statement

Revision 1.34  1993/05/18  18:11:59  jont
Removed integer parameter

Revision 1.33  1993/04/20  09:26:14  matthew
 Added generalises_map and apply_instantiation functions

Revision 1.32  1993/04/08  16:22:01  matthew
Changed type generalisation test from using unification to using the
a type variable mapping.
This needs better treatment of error messages.

Revision 1.31  1993/04/01  16:43:37  jont
Allowed overloading on strings to be controlled by an option

Revision 1.30  1993/03/15  13:45:58  matthew
Changed error message for record mismatch
Stopped raising error for unresolved overloading
This should be controlled by an option really

Revision 1.29  1993/03/05  14:12:02  matthew
Options & Info changes

Revision 1.28  1993/03/02  16:12:42  matthew
Rationalised use of Mapping structure

Revision 1.27  1993/02/22  15:45:48  matthew
Added Completion parameter

Revision 1.26  1992/12/22  15:32:01  jont
Anel's last changes

Revision 1.25  1992/12/18  15:49:53  matthew
Propagating options to signature matching error messages.

Revision 1.24  1992/12/10  11:28:17  matthew
Expanded structure does not match signature errors.

Revision 1.23  1992/12/04  19:24:46  matthew
Error message revisions.

Revision 1.22  1992/12/04  14:16:31  matthew
Error message revision

Revision 1.21  1992/12/03  20:24:39  matthew
Changes to error messages.
Fixed problem of silent error in scheme_generalises

Revision 1.20  1992/12/01  15:47:44  matthew
Changed handling of overloaded variable errors.

Revision 1.19  1992/11/30  10:32:24  jont
Further improvements to gather_names

Revision 1.18  1992/11/26  19:54:43  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.17  1992/11/25  15:12:16  jont
Redid instance to make sub_vec constant and remove a parameter

Revision 1.16  1992/10/30  15:26:31  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.15  1992/10/02  14:37:08  matthew
Fixed problem with printing record domains.

Revision 1.14  1992/09/08  13:36:16  jont
Modified gather_names to be simpler

Revision 1.13  1992/08/27  19:56:58  davidt
Yet more changes to get structure copying working better.

Revision 1.12  1992/08/13  17:19:18  davidt
Changed tyvars function to take a tuple of arguments.

Revision 1.11  1992/08/11  17:50:43  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.10  1992/07/28  14:49:47  jont
Removed use of Array parameter to allow pervasive Array to be used

Revision 1.9  1992/07/16  18:57:45  jont
Changed to use btrees for renaming of tynames and strnames

Revision 1.8  1992/06/16  15:48:19  clive
Added the printing of the name of the relevant identifier in a couple of error messages

Revision 1.7  1992/06/16  08:21:17  jont
Modifications to sort out unification of flexible record types in order
to provide full information to the lambda translation

Revision 1.6  1992/03/27  10:42:07  jont
Changed call of type_equalityp to call of tyvar_erqualityp in order to
preserve significance of the equality attribute of type variables.

Revision 1.5  1992/01/27  20:14:45  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.4  1992/01/24  16:14:32  jont
Updated to allow valenv in METATYNAME

Revision 1.3  1991/11/21  16:46:53  jont
Added copyright message

Revision 1.2  91/10/08  17:37:52  davidt
Put in a catch-all and Crash.impossible to avoid a match
not exhaustive warning.

Revision 1.1  91/06/07  11:37:32  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../basis/__int";
require "^.basis.__list";
require "../utils/set";
require "../utils/lists";
require "../utils/print";
require "../utils/crash";
require "../main/info";
require "../basics/identprint";
require "../typechecker/scheme";
require "../typechecker/types";
require "../typechecker/completion";

functor Scheme(
  structure Set : SET
  structure Lists : LISTS
  structure Info : INFO
  structure IdentPrint : IDENTPRINT
  structure Types : TYPES
  structure Print : PRINT
  structure Crash : CRASH
  structure Completion : COMPLETION

  sharing Info.Location = IdentPrint.Ident.Location
  sharing Types.Options = IdentPrint.Options = Completion.Options
  sharing Types.Datatypes = Completion.Datatypes
  sharing IdentPrint.Ident = Types.Datatypes.Ident
    ) : TYPESCHEME =
  struct
    structure Datatypes = Types.Datatypes
    structure Options = Types.Options
    structure Set = Set
    structure Location = Info.Location

    type print_options = Options.print_options
    type error_info = Info.options
    open Datatypes

    exception EnrichError of string

    fun err_valid (Options.OPTIONS{print_options,...}, vname) = 
      Err_String (IdentPrint.printValId print_options vname)

    (****
     Non closed over metavariable remains as a metavariable, while closed over
     metavariable becomes a debruijn.
     ****)    

    local 

      fun stack_depth [] = 0
	| stack_depth ((_,DEBRUIJN(n,_,_,_))::_) = n+1
	| stack_depth _ = Crash.impossible "Scheme.stack_depth"

      fun generalise (error_info,options, location) (subfun,ty) = 
        let
          fun generalise (t as (TYVAR(_))) = subfun t
            | generalise (t as (METATYVAR (ref (_,NULLTYPE,_),_,_))) = subfun t
            | generalise (METATYVAR (ref (_,ty,_),_,_)) =
              generalise ty
            | generalise (ty as META_OVERLOADED {1=ref NULLTYPE,...}) = ty
            | generalise (META_OVERLOADED {1=ref ty,...}) = generalise ty
            | generalise (METARECTYPE (ref (_,true,ty as METARECTYPE _,_,_))) = 
              generalise ty
            | generalise (ty as METARECTYPE (ref (_,true,subty,_,_))) = 
              (Info.error error_info
               (Info.RECOVERABLE,
                location,
                "Unresolved flexible record of type " ^
                Types.print_type options ty);
               generalise subty)
            | generalise (METARECTYPE (ref (_,_,ty,_,_))) = 
              generalise ty
            | generalise ((RECTYPE amap)) =
              RECTYPE (NewMap.map generalise_map amap)
            | generalise (FUNTYPE(arg,res)) =
              FUNTYPE (generalise arg,generalise res)
            | generalise (CONSTYPE (tylist,tyname)) =
              CONSTYPE (map generalise tylist,tyname)
            | generalise (ty as DEBRUIJN _) = Crash.impossible ("impossible type error 15: debruijn ")
            | generalise (ty as NULLTYPE) = ty

	  and generalise_map(_, ty) = generalise ty

        in
          generalise ty
        end

      (* accumulate instances for polymorphic debugger *)
      fun make_new_instance instance tyvar = 
        case instance of
          NONE => ()
        (* instance is a ref *)
        | SOME (instance,_) => 
            let 
              val tyvar_info =
                case tyvar of
                  (METATYVAR (info,_,_)) => info
                | (TYVAR (info,_)) => info
                | _ => Crash.impossible "tyvar_info:make_new_instance:scheme"
            in
              (* Add the extracted tyvar info, if not present *)
              case !instance of
                NO_INSTANCE => instance := INSTANCE([tyvar_info])
              | INSTANCE tyvars =>
                  if Lists.member(tyvar_info,tyvars) then ()
                  else 
                    instance := INSTANCE(tyvar_info::tyvars)
              | _ => Crash.impossible "make_new_instance:scheme"
            end

      (* Substitute for a tyvar * debruijn assoc list *)
      (* newinstance is either the function above or the unit function *)
      fun subst new_instance (subst_list,tyvar) = 
        let
          fun subst ([],ty) = ty
            | subst (((atyvar'' as TYVAR (atyvar as _), adebruijn)::t),
                     ty as TYVAR atyvar') =
              if atyvar = atyvar' 
                then (ignore(new_instance atyvar'');
                      adebruijn)
              else 
                subst (t,ty)
            | subst (((tyvar as METATYVAR (x',_,_), adebruijn)::t),
                     ty as METATYVAR (x,_,_)) = 
              if x = x'
                then (ignore(new_instance tyvar);
                      adebruijn)
              else 
                subst (t,ty)
            | subst (((TYVAR _, _)::t),ty as METATYVAR _) = 
              subst (t,ty)
            | subst (((METATYVAR _, _)::t),ty as TYVAR _) = 
              subst (t,ty)
            | subst ((x,y)::t,ty) = Crash.impossible "Scheme.subst"
        in
          subst (subst_list,tyvar)
        end
	  
      fun make_subst_list options ([],n,substacc) = (n,substacc)
	| make_subst_list options (h::t,n,substacc) = 
	  let val new_debruijn = 
            DEBRUIJN (n,Types.tyvar_equalityp h,
                      Types.imperativep h,
                      case h of
                        METATYVAR(tyv,_,_) => SOME (tyv)
                      | TYVAR(tyv,_) => SOME (tyv)
                      | _ => Crash.impossible 
                          "new_debruijn:make_subst_list:scheme")
	  in
	    make_subst_list options (t,n+1,(h,new_debruijn) :: substacc)
	  end
    in 
      fun make_scheme' (error_info,options,location) ([],tyexp) = 
        UNBOUND_SCHEME (tyexp)
	(****
	 So in effect make_scheme already schemifies the type scheme when
	 the number of type variables are not zero.
	 ****)
	| make_scheme' (error_info,options,location)
                       (tylist,tyexp as (ty,instance)) = 
	  let 
            val (no_of_bound_vars,substlist) = 
                       make_subst_list options (tylist,0,[])
            val new_instance = make_new_instance instance
	  in
	    SCHEME (no_of_bound_vars,
		    (generalise (error_info,options,location)
                                (fn tyvar => subst new_instance 
                                                   (substlist,tyvar),
                                 ty),
                     instance))
	  end

      val default_values = (Info.make_default_options (),
                            Options.default_options,
                            Location.UNKNOWN)


      (* Generally this won't produce errors (I think) *)
      val make_scheme = make_scheme' default_values



      (****
       schemify is used when closing variable environments - type variables
       which can be closed over are substituted by debruijns.
       ****)
      fun schemify (error_info,options,location)
                   (alevel,exp_varp,
                    UNBOUND_SCHEME (atype as (atype',instance'')),
                    tyvars_scoped,asig) =
	let

          val Options.OPTIONS{compat_options=
                              Options.COMPATOPTIONS{old_definition,...},...}
            = options

	  (****
	   Scoping is done by levels - only explicit type variables scoped 
	   at the current level, alevel, can be closed over. 
	   ****)
	  fun levels_ok (avar as TYVAR (ref (var_level,_,_),id)) =
            var_level >= alevel
	    | levels_ok (avar as METATYVAR (ref (var_level,_,_),_,_)) =
              var_level >= alevel
	    | levels_ok _ = Crash.impossible "Scheme.levels_ok"

	  fun tyvarp (TYVAR _) = true
	    | tyvarp _ = false

	  fun extract_tyvar (TYVAR (_,atyvar)) = atyvar
	    | extract_tyvar _ = Crash.impossible "Scheme.extract_tyvar"

	  (****
	   valbind indicates that we are closing a VE that stems from the
	   elaboration of a valbind.
	   ****)
	  fun substp (avar,valbind) =
	    if valbind 
	      then
		(not (exp_varp andalso 
                      ((not old_definition) orelse Types.imperativep avar)))
		andalso
		(levels_ok avar)
		andalso
		(if tyvarp avar then
		   (Set.is_member (extract_tyvar (avar),tyvars_scoped))
		 else
		   true)
	    else 
	      true

          (****
	   Substitution function for schemify - debruijns are substituted
	   for type variables.
	   ****)

          val new_instance = make_new_instance instance''

	  val sub_stack = ref []

	  fun subfun (avar) =
	    if substp (avar,asig)
	      then
		let 
		  val stack = !sub_stack
		  val asub = subst (fn _ => ()) (!sub_stack,avar) 
		  fun debruijnp (DEBRUIJN _) = true
		    | debruijnp _ = false
		in
		  if debruijnp asub 
		    then asub
		  else
		    let 
		      val new_debruijn = 
			DEBRUIJN (stack_depth  stack,
				  Types.tyvar_equalityp avar,
                                  Types.imperativep avar,
                                  case avar of
                                    METATYVAR(tyv,_,_) => SOME (tyv)
                                  | TYVAR(tyv,_) => SOME (tyv)
                                  | _ => Crash.impossible "new_debruijn:subfun:scheme")
		    in
                      (new_instance avar;
                       sub_stack := (avar,new_debruijn)::stack;
                       new_debruijn)
		    end
		end
	    else avar

	  val scheme_type = (generalise (error_info,options,location) 
                                        (subfun,atype'),instance'')

	in
          SCHEME (stack_depth (!sub_stack),scheme_type)
	end
	| schemify _ _ = Crash.impossible "Scheme.schemify"

      (* Call this when we are reasonably confident no errors can arise *)
      val schemify' = schemify default_values
    end

    fun check_closure (use_value_polymorphism,atype,alevel,tyvars_scoped) =
      let
        fun levels_ok (avar as TYVAR (ref (var_level,_,_),id)) =
          var_level >= alevel
          | levels_ok (avar as METATYVAR (ref (var_level,_,_),_,_)) =
            var_level >= alevel
          | levels_ok _ = Crash.impossible "Scheme.levels_ok"

        fun tyvarp (TYVAR _) = true
          | tyvarp _ = false

        fun extract_tyvar (TYVAR (_,atyvar)) = atyvar
          | extract_tyvar _ = Crash.impossible "Scheme.extract_tyvar"

        fun check_var avar =
          not (use_value_polymorphism orelse Types.imperativep avar)
          andalso
          (levels_ok avar)
          andalso
          (if tyvarp avar then
             (Set.is_member (extract_tyvar (avar),tyvars_scoped))
           else
             true)

        exception CheckClosure of string

        fun check (t as (TYVAR _)) = check_var t
          | check (t as (METATYVAR (ref (_,NULLTYPE,_),_,_))) = check_var t
          | check (METATYVAR (ref (_,ty,_),_,_)) = check ty
          | check (META_OVERLOADED {1=ref NULLTYPE,...}) =
            raise CheckClosure ("Unresolved overloaded function")
          | check (META_OVERLOADED {1=ref ty,...}) = check ty
          | check (METARECTYPE (ref (_,true,ty as METARECTYPE _,_,_))) = check ty
          | check (ty as METARECTYPE (ref (_,true,_,_,_))) = 
            raise CheckClosure ("Unresolved flexible record of type ")
          | check (METARECTYPE (ref (_,_,ty,_,_))) = check ty
          | check (RECTYPE amap) = NewMap.forall check_forall amap
          | check (FUNTYPE(arg,res)) = check arg andalso check res
          | check (CONSTYPE (tylist,tyname)) = List.all check tylist
          | check (ty as DEBRUIJN _) = raise CheckClosure ("debruijn")
          | check (ty as NULLTYPE) = true

	and check_forall(_, ty) = check ty

      in
        check atype
      end

    fun unary_overloaded_scheme x =
      OVERLOADED_SCHEME (UNARY x)
    fun binary_overloaded_scheme x =
      OVERLOADED_SCHEME (BINARY x)
    fun predicate_overloaded_scheme x =
      OVERLOADED_SCHEME (PREDICATE x)

    (****
     instantiate returns the appropriate generic type given a scheme.
     ****)
    fun instantiate (_,UNBOUND_SCHEME (tyexp,instance),_,_) = 
      (tyexp,
       case instance of
         NONE => (ZERO,NONE)
       | SOME (instance,instance') =>
           case instance' of
             ref(instance' as SOME (ref (SIGNATURE_INSTANCE instance_info))) => 
               (instance_info,instance')
           | _ => (ZERO,SOME(instance)))
      | instantiate (_,OVERLOADED_SCHEME (UNARY (valid, tyvar)),loc,_) = 
	let
	  val olvar = META_OVERLOADED (ref NULLTYPE, tyvar, valid, loc)
	in
	  (FUNTYPE (olvar,olvar),(ZERO,NONE))
	end
      | instantiate (_,OVERLOADED_SCHEME (BINARY (valid, tyvar)),loc,_) = 
	let 
          val olvar = META_OVERLOADED (ref NULLTYPE, tyvar, valid, loc)
	in
	  (FUNTYPE (Types.add_to_rectype 
		   (Ident.LAB (Ident.Symbol.find_symbol ("1")),olvar,
		    Types.add_to_rectype 
		    (Ident.LAB (Ident.Symbol.find_symbol ("2")),olvar,
		     Types.empty_rectype)),olvar),
          (ZERO,NONE))
        end
      | instantiate (_,OVERLOADED_SCHEME (PREDICATE (valid, tyvar)),loc,_) = 
	let
	  val olvar = META_OVERLOADED (ref NULLTYPE, tyvar, valid, loc)
	in
	  (FUNTYPE (Types.add_to_rectype 
		   (Ident.LAB (Ident.Symbol.find_symbol("1")),olvar,
		    Types.add_to_rectype 
		    (Ident.LAB (Ident.Symbol.find_symbol("2")),olvar,
		     Types.empty_rectype)),Types.bool_type),
          (ZERO,NONE))
	end
      | instantiate (alevel,SCHEME (n,(tyexp,instance')),_,generate_moduler) =
	let
          val (instance',instance'') =
            case instance' of
              SOME (instance',ref instance'') => 
                (SOME instance',instance'')
            | _ => (NONE,NONE)

	  val sub_vec = MLWorks.Internal.Array.array(n, NULLTYPE)

	  fun instance_map(_, ty) = instance ty

	  and instance (t as (TYVAR _)) = t
	    | instance ((RECTYPE amap)) =
	      RECTYPE (NewMap.map instance_map amap)
	    | instance (FUNTYPE(arg,res)) =
	      FUNTYPE (instance (arg),instance (res))
	    | instance (CONSTYPE (tylist,tyname)) =
	      CONSTYPE (map instance tylist,tyname)
	    | instance (DEBRUIJN (n,eq,imp,tyvar)) = 
	      let 
		val asub = MLWorks.Internal.Array.sub (sub_vec,n)
	      in
		case asub of
		  NULLTYPE =>
		    let
		      val new_meta' = ref (alevel,NULLTYPE,NO_INSTANCE)
		      val new_meta = METATYVAR(new_meta',eq,imp)
                      (* accumulate instances for polymorphic debugger;
                         record every instance of the type variable *)
                      val _ =
                        case instance' of
                          NONE => ()
                        | SOME instance => 
                           (case !instance of
                              NO_INSTANCE => ()
                            | INSTANCE(_) =>
                                 (case tyvar of
                                    SOME (tyvar as ref(n,ty,instances)) => 
                                      tyvar := 
                                      (n,ty,INSTANCE(new_meta'::
                                       (case instances of
                                          NO_INSTANCE => nil
                                        | INSTANCE(instances) => instances
                                        | _ => Crash.impossible 
                                            "1:instance:instantiate:scheme")))
                                  | _ => Crash.impossible "2:instance:instantiate:scheme")
                            | _ => Crash.impossible "3:instance:instantiate:scheme")
		    in
		      (MLWorks.Internal.Array.update (sub_vec,n,new_meta);
		       new_meta)
		    end
		| _ => asub
	      end
	    | instance (NULLTYPE) =
	      Crash.impossible "impossible type error 16: nulltype in scheme"
	    | instance(t as  (METATYVAR (ref (_,ty,_),_,_))) =
	      (case ty of
		 NULLTYPE => t
	       | _ => instance ty)
	    | instance (t as (META_OVERLOADED {1=ref ty,...})) =
	      (case ty of
		 NULLTYPE => t
	       | _ => instance ty)
	    | instance (t as METARECTYPE (ref (_,b,ty,_,_))) =
	      if b then
		(case ty of
		   METARECTYPE _ => instance ty
		 | _ => t)
	      else
		ty
          val ty = instance (tyexp)

          (* Don't understand this stuff at all *)
          (* compute integer-instance to be eventually passed round at runtime 
             for the polymorphic debugger *)

          fun instance_length (NO_INSTANCE) = ZERO
            | instance_length (INSTANCE instances) = ONE (length(instances))
            | instance_length _ = Crash.impossible "length:instantiate:scheme"

          (* Yurk *)
          fun combine_instances (ZERO,inst) = inst
            | combine_instances (inst,ZERO) = inst
            | combine_instances (ONE n,ONE m) = TWO (n,m)
            | combine_instances _ = Crash.impossible "combine_instances"

          val length = 
            case instance' of
              NONE => ZERO
            | SOME instance => 
                (case !instance of
                   NO_INSTANCE => 
                     (case instance'' of
                        SOME (ref (SIGNATURE_INSTANCE instance_info)) => 
                          if generate_moduler 
                            then ZERO (* Why? *)
                          else instance_info
                      | _ => ZERO)
                 | INSTANCE((tyvar as ref(_,_,instances))::_) => 
                     (case instance'' of
                        SOME (ref (SIGNATURE_INSTANCE instance_info)) => 
                          if generate_moduler 
                            then instance_length instances (* Why? *)
                          else combine_instances (instance_info,instance_length instances)
                      | _ => instance_length instances)
                 | _ => Crash.impossible "instance:instantiate:scheme")
	in
           (ty,(length,case instance'' of
                         SOME (ref (SIGNATURE_INSTANCE _)) => instance''
                       | _ => instance'))
	end
      
      (****
       skolemize removes the quantifier from a type scheme - used in 
       enrichment.
       ****)
    fun skolemize (UNBOUND_SCHEME (atype,_)) = atype
      | skolemize (SCHEME (n,(atype,_))) = atype
      (****
       This should never occur because the only OVERLOADED_SCHEMEs are
       to be found in the initial basis.
       ****)
      | skolemize (OVERLOADED_SCHEME _) = Crash.impossible "Scheme.skolemize"

    (* This tells us if the scheme respects equality when considered as a type function *)
    (* hence the call to type_equalityp and not closed_type_equalityp *)
    fun equalityp (SCHEME (_,(FUNTYPE (atype,atype'),_))) = 
      Types.type_equalityp (atype)
      | equalityp (UNBOUND_SCHEME ((FUNTYPE (atype,atype'),_))) =
	Types.type_equalityp (atype)
      | equalityp (_) = true
	
    fun string_scheme (OVERLOADED_SCHEME (UNARY (_, tyvar))) = 
	  let val olvar = IdentPrint.printTyVar tyvar
	  in
	    concat ["ALL ", olvar, ".", olvar, " -> ", olvar]
	  end
      | string_scheme (OVERLOADED_SCHEME (BINARY (_, tyvar))) = 
	  let val olvar = IdentPrint.printTyVar tyvar
	  in
	    concat ["ALL ", olvar, ".", olvar, " * ", olvar, " -> ", olvar]
	  end
      | string_scheme (OVERLOADED_SCHEME (PREDICATE (_, tyvar))) = 
	  let val olvar = IdentPrint.printTyVar tyvar
	  in
	    concat ["ALL ", olvar, ".", olvar, " * ", olvar, " -> bool"]
	  end
      | string_scheme (UNBOUND_SCHEME (aty,_)) = 
	  "ALL{}." ^ (Types.extra_debug_print_type aty)
      | string_scheme (SCHEME (n,(aty,_))) =
	 "ALL{"^ (Int.toString n)^"}." ^ (Types.extra_debug_print_type aty)

    (* used to return an error from generalisation - should be better than this *)
    exception Error of Type * Type * string
    exception Mismatch

    fun internal_generalises_map isSML90 (ty1,ty2) =
      (* This function attempts to construct a mapping from the deBruijns
         of ty1 to the subtypes of ty2 such that the ty1 = ty2 under the
         mapping *)
      let
        (* put the debruijn bindings here *)
        val binding_list = ref []

        fun check_debruijn (stuff as (n,eq,imp,tyvar),ty) =
         (let val ty' = Lists.assoc (n,!binding_list)
          in
            if Types.type_eq (ty,ty',true,true)
              then ()
            (* Debruijns instantiated differently *)
            else raise Error (ty,ty',"types clash")
          end
          handle
          Lists.Assoc =>
            ((* need to check the equality and imperative attributes *)
             if eq andalso not(Types.closed_type_equalityp ty)
               then raise Error (DEBRUIJN stuff,ty,
                                 "equality attribute missing") 
             else ();
             if imp andalso isSML90
                    andalso not (Types.imperativep ty)
               then raise Error (DEBRUIJN stuff,ty,
                                 "imperative attribute missing") 
             else ();
             case tyvar of
               SOME (tyvar) =>
                 (* record the signature type corresponding to the structure *)
                 (* type variable as instance - crucial for application of the *)
                 (* polymorphic debugger to the modules language *)
                 (case tyvar of 
                    ref(n,t,instance) => 
                      tyvar := (n,t,
                                (case ty of
                                   DEBRUIJN(_,_,_,SOME(tyv)) => 
                                     (* prevent unneccessary duplication of tyvars *)
                                     if tyv = tyvar then 
                                       instance
                                     else
                                       INSTANCE (tyv::
                                                 (case instance of
                                                    NO_INSTANCE => nil
                                                  | INSTANCE(instances) => instances
                                                  | _ => Crash.impossible "2:check_debruijn:scheme"))
                                 | DEBRUIJN _ => instance
                                 | _ => INSTANCE(ref(0,ty,NO_INSTANCE)::
                                                 (case instance of
                                                    NO_INSTANCE => nil
                                                  | INSTANCE(instances) => instances
                                                  | _ => Crash.impossible "2:check_debruijn:scheme")))))
             | _ => ();
             binding_list := (n,ty)::(!binding_list)))

        fun type_strip(ty as METATYVAR(ref(_, ty',_), _, _)) =
          (case ty' of
             NULLTYPE => ty
           | _ => type_strip ty')
          | type_strip(ty as META_OVERLOADED {1=ref ty',...}) =
            (case ty' of
               NULLTYPE => ty
             | _ => type_strip ty')
          | type_strip(METARECTYPE(ref{3 = ty, ...})) = type_strip ty
          | type_strip(ty as CONSTYPE(l, METATYNAME{1 = ref tyfun, ...})) =
            (case tyfun of
               NULL_TYFUN _ => ty
             | _ => type_strip(Types.apply(tyfun, l)))
          | type_strip ty = ty

        fun is_polymorphic (DEBRUIJN _) = true
          | is_polymorphic ty =
            not (Types.all_tyvars ty = [])

        (* check_type always raises an exception if a type match failure occurs *)
        fun check_type (ty,ty') = check_type' (type_strip ty,type_strip ty')

        and check_type' (DEBRUIJN stuff,ty) =
          check_debruijn (stuff,ty)
          | check_type' (ty1 as RECTYPE map,ty2 as RECTYPE map') =
            if NewMap.eq (fn (ty1,ty2) => (check_type (ty1,ty2); true)) (map, map') then
	      ()
	    else
	      raise Error (ty1,ty2,"record types have different domains")
(*
               Mapping.EQUAL => ()
             | Mapping.NOT_EQUAL => Crash.impossible "scheme:check_type'"
             | Mapping.DIFFERENT_DOMAINS => raise Error (ty1,ty2,"record types have different domains")
*)
          | check_type' (FUNTYPE (ran,dom),FUNTYPE(ran',dom')) =
            (check_type (ran,ran');
             check_type (dom,dom'))
          | check_type' (ty1 as CONSTYPE (tys,tyname), ty2 as CONSTYPE (tys',tyname')) =
            if not (Types.tyname_eq (tyname,tyname'))
              then raise Error (ty1,ty2,"types clash")
            else
              Lists.iterate check_type (Lists.zip (tys,tys'))
          | check_type' (ty1 as METATYVAR(r as ref (_,NULLTYPE,_), eq, imp), ty2) =
              if isSML90 then raise Error(ty1,ty2,"")
              else if is_polymorphic ty2 then raise Error(ty1,ty2,"trying to instantiate to a polytype")
              else if eq andalso not(Types.closed_type_equalityp ty2)
                then raise Error(ty1,ty2,"missing equality attribute")
              else (* can instantiate the type *)
                r := (0,ty2,NO_INSTANCE)
          | check_type' (ty,ty') =
            if Types.type_eq (ty,ty',true,true)
              then 
                ()
            else raise Error(ty,ty',"")
      in
        (* Error is raised by check_type *)
        (check_type (ty1,ty2);
         !binding_list)
      end

    fun generalises isSML90 (ty1,ty2) =
      (ignore(internal_generalises_map isSML90 (ty1,ty2)); true)
      handle Error _ => raise Mismatch

    fun generalises_map isSML90 (ty1,ty2) =
      internal_generalises_map isSML90 (ty1,ty2)
      handle Error _ => raise Mismatch


        (* note that the two functions, SML9?_dynamic_generalises
           are set here and in the functions 
           select_sml'90, select_sml'96 in interpreter/_shell_structure.sml
         *)


    fun SML90_dynamic_generalises
	  (ty1 : MLWorks.Internal.Dynamic.type_rep,
	   ty2 : MLWorks.Internal.Dynamic.type_rep) =
      let
        val cast : 'a -> 'b = MLWorks.Internal.Value.cast
      in
        generalises true (cast ty1,cast ty2)
        handle Mismatch => 
          raise MLWorks.Internal.Dynamic.Coerce(ty1, ty2)
      end


    fun SML96_dynamic_generalises
	  (ty1 : MLWorks.Internal.Dynamic.type_rep,
	   ty2 : MLWorks.Internal.Dynamic.type_rep) =
      let
        val cast : 'a -> 'b = MLWorks.Internal.Value.cast
      in
        generalises false (cast ty1,cast ty2)
        handle Mismatch => 
          raise MLWorks.Internal.Dynamic.Coerce(ty1, ty2)
      end

    (* And set the pervasive generalizes function *)

    val _ = MLWorks.Internal.Dynamic.generalises_ref := 
      let val Options.OPTIONS{compat_options=
                              Options.COMPATOPTIONS{old_definition,...},...}
        = Options.default_options
       in
         if old_definition then SML90_dynamic_generalises
         else SML96_dynamic_generalises
      end

    (* Note similarity of code with instantiate above *)
    fun apply_instantiation (ty,binding_list) =
      let
	fun instance_map(_, ty) = instance ty

        and instance (t as (TYVAR _)) = t
          | instance ((RECTYPE amap)) =
            RECTYPE (NewMap.map instance_map amap)
          | instance (FUNTYPE(arg,res)) =
            FUNTYPE (instance arg,instance res)
          | instance (CONSTYPE (tylist,tyname)) =
            CONSTYPE (map instance tylist,tyname)
          | instance (t as DEBRUIJN (n,_,_,_)) = 
            ((Lists.assoc (n,binding_list))
             handle Lists.Assoc => t)
          | instance (t as NULLTYPE) = t
          | instance(t as (METATYVAR (ref (_,ty,_),_,_))) =
            (case ty of
               NULLTYPE => t
             | _ => instance ty)
          | instance (t as (META_OVERLOADED {1=ref ty,...})) =
	    (case ty of
               NULLTYPE => t
             | _ => instance ty)
          | instance (t as METARECTYPE (ref (_,b,ty,_,_))) =
            if b then
              (case ty of
                 METARECTYPE _ => instance ty
               | _ => t)
            else
              ty
      in
        instance ty
      end

    fun is_meta(Datatypes.METATYVAR _) = true
      | is_meta _ = false

    fun is_deb(Datatypes.DEBRUIJN _) = true
      | is_deb _ = false

    fun is_tyvar (Datatypes.TYVAR _) = true
      | is_tyvar _ = false

    (* This alas takes params in opposite order to generalises *)
    fun scheme_generalises options (name,completion_env,_,scheme,scheme') =
      let
        val atype = skolemize scheme
        val atype' = skolemize scheme'
        val Options.OPTIONS{compat_options=
                            Options.COMPATOPTIONS{old_definition,...},...}
          = options
      in
        (* note reversal of parameter order *)
        (ignore(internal_generalises_map old_definition (atype',atype)); true)
        handle Error(ty',ty,reason) =>
	  let
	    val same_types = Types.type_eq(atype, ty, true, true)
            fun dbx ty = [Err_Type ty, Err_String ": ",
                          if is_meta ty then Err_String "Meta " else
                            Err_String "",
                          if is_deb ty then Err_String "Deb " else
                            Err_String "",
                          if is_tyvar ty then Err_String "Tyvar " else
                            Err_String ""]
            fun expand_reason "" = "type clash"
              | expand_reason r = r
	  in
	    raise EnrichError
	      (Completion.report_type_error
	       (options, completion_env,
		[Err_String "Type mismatch in signature and structure:",
                 Err_String "\n    id : ", err_valid (options, name),
                 Err_String "\n    spec :   ", Err_Scheme atype,
                 Err_String "\n    actual : ", Err_Scheme atype']@
		(if same_types then
		   [Err_String ("\n      (" ^ expand_reason reason ^ ")")]
		 else
		   Err_String "\n      because" ::
		   Err_String "\n         " ::
		   (if (is_meta ty') orelse (is_tyvar ty')(*special*) then
		      (Err_Scheme ty' ::
                       Err_String "\n      is a" ::
                       (if is_tyvar ty' then Err_String "n explicit "
                        else Err_String " ") ::
                          (if Types.imperativep ty'
                             then Err_String "free imperative type variable"
                           else Err_String "free type variable") ::
                             (if is_deb ty then
                                [Err_String "\n      which cannot be instantiated to the bound variable",
                                 Err_String "\n         ", Err_Type ty]
                              else
                                [Err_String "\n      which cannot be instantiated to",
                                 Err_String "\n         ", Err_Type ty])) @
                      (if reason = "" then [] else [Err_String ("\n     (" ^ reason ^ ")")])
                    else [Err_Type ty',
		       Err_String "\n      is not an instance of",
		       Err_String "\n         ", Err_Type ty,
                       Err_String ("\n      (" ^ expand_reason reason ^ ")")]))))
	  end
      end

    fun typescheme_eq (OVERLOADED_SCHEME (UNARY (_,tv)),
                       OVERLOADED_SCHEME (UNARY (_,tv'))) = tv = tv'
      | typescheme_eq (OVERLOADED_SCHEME (UNARY _),_) = false
      | typescheme_eq (OVERLOADED_SCHEME (BINARY (_,tv)),
                       OVERLOADED_SCHEME (BINARY (_,tv'))) = tv = tv'
      | typescheme_eq (OVERLOADED_SCHEME (BINARY _),_) = false
      | typescheme_eq (OVERLOADED_SCHEME (PREDICATE (_,tv)),
		       OVERLOADED_SCHEME (PREDICATE (_,tv'))) = tv = tv'
      | typescheme_eq (OVERLOADED_SCHEME (PREDICATE _),_) = false
      | typescheme_eq (UNBOUND_SCHEME (atype,_),UNBOUND_SCHEME (atype',_)) = 
	Types.type_eq (atype,atype',true,false)
      | typescheme_eq (SCHEME(n,(atype,_)),SCHEME(n',(atype',_))) = 
	n = n andalso Types.type_eq (atype,atype',true,false)
      | typescheme_eq _ = Crash.impossible "Scheme.typescheme_eq"

    local

      fun follow (name as METATYNAME{1=ref(NULL_TYFUN _), ...}) =
	name
	| follow (METATYNAME{1=ref(ETA_TYFUN (name)), ...}) =
	  follow (name)
	| follow _ = Crash.impossible "Scheme.follow"

      fun uninstantiated (METATYNAME{1=ref(NULL_TYFUN _), ...}) = true
	| uninstantiated (METATYNAME{1=ref(ETA_TYFUN (name)), ...}) =
	  uninstantiated (name)
	| uninstantiated (_) = false

      fun gather_names (namelist, CONSTYPE (tylist,tyname)) = 
	let
	  val names = Lists.reducel gather_names (namelist, tylist)
	in
	  if (uninstantiated tyname) then
	    follow tyname :: names
	  else
	    names
	end
	| gather_names(namelist, FUNTYPE (atype,atype')) = 
	  gather_names(gather_names(namelist, atype), atype')
	| gather_names(namelist, ty as RECTYPE _) =
	  Lists.reducel
	  (fn (list, ty') => gather_names(list, ty'))
	  (namelist, Types.rectype_range ty)
	| gather_names(namelist, METATYVAR (ref (_,atype,_),_,_)) =
	  gather_names(namelist, atype)
	| gather_names(namelist, META_OVERLOADED {1=ref atype,...}) =
	  gather_names(namelist, atype)
	| gather_names(namelist, METARECTYPE (ref (_,_,atype,_,_))) =
	  gather_names(namelist, atype)
	| gather_names(namelist, _) = namelist
    in
      fun gather_tynames (UNBOUND_SCHEME (atype,_)) = gather_names ([], atype)
	| gather_tynames (SCHEME (_,(atype,_))) = gather_names ([], atype)
	| gather_tynames (OVERLOADED_SCHEME _) = []
    end

    fun return_both atype =
      case Types.has_free_imptyvars atype of
	SOME ty => SOME (ty, atype)
      | _ => NONE

    fun has_free_imptyvars (SCHEME (_,(atype,_))) = 
      return_both atype
      | has_free_imptyvars (UNBOUND_SCHEME ((atype,_))) = 
	return_both atype
      (* only in final ve for exceptions *)
      | has_free_imptyvars _ = Crash.impossible "Scheme.has_free_imptyvar"
	
    (****
     scheme_copy is used in copying of signatures.
     ****)  

    fun scheme_copy (s as SCHEME (n,(atype,instance)),tyname_copies) = 
        SCHEME(n, (Types.type_copy(atype, tyname_copies),instance))
      | scheme_copy (UNBOUND_SCHEME (atype,instance),tyname_copies) =
	UNBOUND_SCHEME(Types.type_copy(atype,tyname_copies),instance)
      | scheme_copy (scheme as OVERLOADED_SCHEME _, _) = 
	scheme

    fun tyvars (tyvarlist, SCHEME (_,(atype,_))) = Types.tyvars(tyvarlist, atype)
      | tyvars (tyvarlist, UNBOUND_SCHEME (atype,_)) = 
        Types.tyvars(tyvarlist, atype)
      | tyvars _ = Crash.impossible "Scheme.tyvars"
  end;
