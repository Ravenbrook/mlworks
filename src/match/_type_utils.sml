(* _type_utils.sml the functor *)
(*
$Log: _type_utils.sml,v $
Revision 1.24  1997/05/01 13:15:39  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.23  1996/08/05  17:55:49  andreww
 * [Bug #1521]
 * propagating changes to typechecker/_types.sml: passing
 * use_value_polymorphism argument everywhere.
 *
 * Revision 1.22  1996/02/22  13:20:20  jont
 * Replacing Map with NewMap
 *
 * Revision 1.21  1995/12/27  12:01:04  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.20  1995/08/10  14:48:46  daveb
Added words to the set of integral types.

Revision 1.19  1995/07/14  11:26:19  jont
Allow char to be an integral type

Revision 1.18  1995/05/01  10:16:22  matthew
Fixing problem with flexible record types

Revision 1.17  1995/03/17  19:28:06  daveb
Removed unused parameter Print.

Revision 1.16  1995/02/07  14:15:35  matthew
Log: Adding the_type for use by mir_cg

Revision 1.15  1993/09/16  14:48:54  nosa
Instances in schemes for polymorphic debugger.

Revision 1.14  1993/07/12  09:01:43  nosa
structure Option.

Revision 1.13  1992/11/24  16:57:39  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.12  1992/10/12  09:58:52  clive
Tynames now have a slot recording their definition point

Revision 1.11  1992/09/25  12:09:16  jont
Changed get_no_cons to use NewMap.size

Revision 1.10  1992/09/10  10:18:31  jont
Added predicates for has nullary constructors and has value carrying
constructors. Should be more efficient

Revision 1.9  1992/08/24  19:34:34  davidt
Took out message about following empty valenvs.

Revision 1.8  1992/08/12  17:44:26  jont
Fixed get_valenv to follow TYFUN(CONSTYPE) as well as ETA_TYFUN

Revision 1.7  1992/08/06  16:03:54  jont
Anel's changes to use NewMap instead of Map

Revision 1.5  1992/06/16  08:25:57  jont
Modifications to sort out unification of flexible record types in order
to provide full information to the lambda translation

Revision 1.4  1992/03/23  11:17:00  jont
Changed length for Lists.length

Revision 1.3  1992/01/24  23:27:12  jont
Added functionality to get valenvs from METATYNAMES and get domain
of record types

Revision 1.2  1992/01/24  17:29:19  jont
Modified the reference to METATYNAME to be flexible

Revision 1.1  1992/01/23  12:11:31  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/crash";
require "../utils/lists";
require "../typechecker/types";
require "type_utils";

functor TypeUtils(
  structure Crash : CRASH
  structure Lists : LISTS
  structure Types : TYPES
 ) : TYPE_UTILS =
  struct
    structure Datatypes = Types.Datatypes
    structure NewMap = Datatypes.NewMap
    structure Ident = Datatypes.Ident
    structure Symbol = Ident.Symbol

    fun get_cons_type(Datatypes.FUNTYPE(_, ty2)) = ty2
    | get_cons_type(ty as Datatypes.CONSTYPE _) = ty
    | get_cons_type _ = Crash.impossible "get_cons_type on non-constructed type"

    fun get_valenv (Datatypes.CONSTYPE
		    (_, Datatypes.TYNAME {5=ref (Datatypes.VE (_, valenv)),6=location,
					  ...})) =
      (case location of SOME x => x | NONE => "",valenv)
    | get_valenv(Datatypes.CONSTYPE
		   (_, tyname as Datatypes.METATYNAME{1 = ref tyfun,
					    5=ref(Datatypes.VE(_, valenv)),
					    ...})) =
      if NewMap.is_empty valenv then
	let
	  val (new_tyname, ok) = case tyfun of
	    Datatypes.TYFUN(Datatypes.CONSTYPE(_, tyname), _) =>
	      (tyname, true)
	  | Datatypes.ETA_TYFUN tyname => (tyname, true)
	  | _ => (tyname, false)
	in
	  if ok then
	    get_valenv(Datatypes.CONSTYPE([], new_tyname))
	  else
	    ("",valenv)
	end
      else
	("",valenv)
    | get_valenv ty =
      Crash.impossible("bad ty '" ^ Types.debug_print_type 
                                    Types.Options.default_options ty
                       ^ "' in get_valenv")

      (* any old options should do for the impossible case *)


    fun get_no_cons ty =
      NewMap.size (#2(get_valenv (get_cons_type ty)))

    fun type_from_scheme(Datatypes.SCHEME(_, (the_type,_))) = the_type
    | type_from_scheme(Datatypes.UNBOUND_SCHEME (the_type,_)) = the_type
    | type_from_scheme _ = Crash.impossible"OVERLOADED_SCHEME"

    fun is_vcc(Datatypes.FUNTYPE _) = true
    | is_vcc(Datatypes.CONSTYPE _) = false
    | is_vcc Datatypes.NULLTYPE = false
    | is_vcc _ = Crash.impossible"is_vcc on non-constructed type"

    val vcc_fun = is_vcc o type_from_scheme
    val null_fun = not o vcc_fun
    val null_exists = NewMap.exists (null_fun o #2) 
    val vcc_exists = NewMap.exists (vcc_fun o #2) 
    val vcc_len = Lists.filter_length vcc_fun
    val null_len = Lists.filter_length null_fun

    val get_no_vcc_cons = vcc_len o NewMap.range o #2 o get_valenv o get_cons_type

    val get_no_null_cons = null_len o NewMap.range o #2 o get_valenv o get_cons_type

    val has_null_cons = null_exists o #2 o get_valenv o get_cons_type

    val has_value_cons = vcc_exists o #2 o get_valenv o get_cons_type

    (*
     * A type is integral if it either has no value carrying constructors,
     * or it is int or char. Note that string and real are not integral.
     *)

    fun is_integral ty =
      case Types.the_type ty of
	(ty as Datatypes.CONSTYPE(_,tyname)) =>
	  Types.tyname_eq(tyname, Types.int_tyname) orelse
	  Types.tyname_eq(tyname, Types.word_tyname) orelse
	  Types.tyname_eq(tyname, Types.char_tyname) orelse
	  (case NewMap.to_list(#2(get_valenv ty)) of
	     [] =>
	       false
	   | assoc => 
	       Lists.forall (not o is_vcc o type_from_scheme o #2) assoc)
      | _ => false
          
  (* The two type utilities we need in _mir_cg *)

    fun is_integral2 primTy =
      case Types.the_type primTy of
        ty as Datatypes.RECTYPE _ =>
          is_integral(Types.get_type_from_lab (Ident.LAB(Symbol.find_symbol "2"), ty))
      | _ => false

    fun is_integral3 primTy =
      case Types.the_type primTy of
        ty as Datatypes.RECTYPE _ =>
          is_integral(Types.get_type_from_lab (Ident.LAB(Symbol.find_symbol "3"), ty))
      | _ => false


  end
