(*
$Log: _tyenv.sml,v $
Revision 1.42  1997/05/01 12:54:47  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.41  1996/12/18  16:37:57  andreww
 * [Bug #1818]
 * Adding new floatarray type name.
 *
 * Revision 1.40  1996/03/08  12:09:13  daveb
 * Converted the types Dynamic and Type to the new identifier naming scheme.
 *
 * Revision 1.38  1995/12/27  11:37:13  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.37  1995/08/18  09:19:35  daveb
Added types for different lengths of words, ints and reals.

Revision 1.36  1995/07/20  14:10:15  jont
Add word type

Revision 1.35  1995/07/13  12:36:58  jont
Add char type for new revised basis

Revision 1.34  1995/02/07  11:54:59  matthew
Removing debug structure

Revision 1.33  1994/10/13  10:39:08  matthew
Use pervasive Option.option for return values in NewMap

Revision 1.32  1993/09/16  13:51:10  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.31  1993/04/21  10:36:22  matthew
The normal initial type environment now just contains
standard ML types.

Revision 1.30  1993/04/20  17:04:36  matthew
Rationalised the way the initial tyenv is constructed/

Revision 1.29  1993/04/05  11:53:53  matthew
Added Type type to initial tyenv

Revision 1.28  1993/03/02  15:36:59  matthew
empty_rec_type to empty_rectype

Revision 1.27  1993/03/01  11:02:11  matthew
Added vector and bytearray as built in types
/
 .

Revision 1.26  1993/02/25  16:02:19  matthew
Added array type to initial type environment

Revision 1.25  1993/02/19  11:30:36  matthew
Changed Conenv to Valenv
Moved enrichment code to _realise

Revision 1.24  1992/12/22  15:57:54  jont
Anel's last changes

Revision 1.23  1992/12/07  11:28:35  matthew
Changed error messages.

Revision 1.22  1992/12/04  19:46:19  matthew
Error message revisions.

Revision 1.21  1992/12/03  13:20:21  jont
Modified tyenv for efficiency

Revision 1.20  1992/10/30  15:46:28  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.19  1992/10/27  19:16:51  jont
Modified to use less than functions for maps

Revision 1.18  1992/10/02  16:04:06  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.17  1992/09/09  11:48:01  matthew
Changed error message

Revision 1.16  1992/09/09  11:34:38  matthew
Trivial change to typescheme printing.

Revision 1.15  1992/08/27  20:07:55  davidt
Yet more changes to get structure copying working better.

Revision 1.14  1992/08/27  14:35:30  jont
Anel's changes - an attempt to get slightly better error messages.

Revision 1.13  1992/08/18  16:07:41  jont
Removed irrelevant handlers and new exceptions

Revision 1.12  1992/08/11  16:23:22  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.11  1992/08/06  17:40:35  jont
Anel's changes to use NewMap instead of Map

Revision 1.9  1992/07/27  14:00:47  jont
Improved enrichment efficiency

Revision 1.8  1992/07/16  19:05:08  jont
Changed to use btrees for renaming of tynames and strnames

Revision 1.7  1992/05/05  10:58:25  jont
Anel's fixes

Revision 1.6  1992/04/15  15:13:04  jont
Some improvements from Anel

Revision 1.5  1992/03/09  11:06:41  jont
Added require "tystr";

Revision 1.4  1992/02/11  11:32:41  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.3  1992/01/27  20:15:53  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.2  1991/11/19  17:29:24  jont
Fixed inexhaustive bindings

Revision 1.1  91/06/07  11:38:51  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/lists";
require "../utils/print";
require "../utils/crash";
require "../basics/identprint";
require "../typechecker/tyenv";
require "../typechecker/types";
require "../typechecker/valenv";
require "../typechecker/scheme";

functor Tyenv(
  structure Lists : LISTS
  structure IdentPrint : IDENTPRINT
  structure Types : TYPES
  structure Valenv : VALENV
  structure Scheme : TYPESCHEME
  structure Print : PRINT
  structure Crash : CRASH

  sharing Types.Datatypes = Valenv.Datatypes = Scheme.Datatypes
  sharing IdentPrint.Ident = Types.Datatypes.Ident
    ) : TYENV =
 
  struct
    structure Datatypes = Types.Datatypes

    open Datatypes

    (****
     Operations on the type environment.
     ****)

    exception LookupTyCon of Ident.TyCon

    val empty_tyenv = TE (NewMap.empty (Ident.tycon_lt, Ident.tycon_eq))

    fun lookup (TE amap, tycon) =
      case NewMap.tryApply' (amap, tycon) of
        SOME tystr => tystr
      | _ => raise LookupTyCon tycon

    fun te_plus_te (TE amap,TE amap') =
      TE (NewMap.union(amap, amap'))

    fun add_to_te (TE amap, tycon, tystr) = 
      TE (NewMap.define (amap,tycon,tystr))

    fun string_tyenv (TE amap) =
      let
	val tycon_length = ref 0

        val tycon_tystr_list = NewMap.to_list_ordered amap

	fun print_tycon tycon =
	  let 
	    val string_tycon = IdentPrint.printTyCon tycon
	    val tycon_size = size string_tycon
	  in
	    (tycon_length := tycon_size;
	     string_tycon)
	  end

        fun string_tystr (start,TYSTR (tyfun,conenv)) =
          let 
            val tyfun_string = Types.string_tyfun tyfun
            val conenv_string = Valenv.string_valenv (start + 
                                                      (size tyfun_string) + 8,
                                                      conenv)
          in
            "(" ^ tyfun_string ^ "," ^ conenv_string ^ ")\n"
          end
  
	fun str_tystr tystr = string_tystr (!tycon_length,tystr)

        fun print_pair ((object,image),print_object,print_image,connector) = 
          print_object object ^ connector ^ print_image image

      in
        Lists.to_string
        (fn (x,y) => print_pair ((x,y),IdentPrint.printTyCon,
                                 fn tystr => (string_tystr (!tycon_length,tystr)),
                                 " |==> "))
        tycon_tystr_list
      end

    fun empty_tyenvp (TE amap) = NewMap.is_empty amap

    (****
     Used during copying of a signature before the signature is matched to 
     a structure.
     ****)

    fun tystr_copy (TYSTR (tyfun,conenv), tyname_copies) = 
      TYSTR(Types.tyfun_copy (tyfun,tyname_copies), Valenv.ve_copy(conenv,tyname_copies))

    fun te_copy (TE amap,tyname_copies) = 
      let
	fun copy (_, tystr) = tystr_copy (tystr, tyname_copies)
      in
	TE(NewMap.map copy amap)
      end

    local
      fun atyvar (id,eq,imp) =
	TYVAR (ref (0,NULLTYPE,NO_INSTANCE),
               Ident.TYVAR (Ident.Symbol.find_symbol (id),eq,imp))
      fun do_one (te,(id,tystr)) = add_to_te (te,id,tystr)
    in
      val basic_te =
        Lists.reducel
        do_one
        (empty_tyenv,
         [(Ident.TYCON (Ident.Symbol.find_symbol ("int")),
           TYSTR (Types.make_eta_tyfun (Types.int_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("word")),
           TYSTR (Types.make_eta_tyfun (Types.word_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("real")),
           TYSTR (Types.make_eta_tyfun (Types.real_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("string")),
           TYSTR (Types.make_eta_tyfun (Types.string_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("char")),
           TYSTR (Types.make_eta_tyfun (Types.char_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("ref")),
           let
             val aty = atyvar ("'_a",false,true)
           in
             TYSTR (Types.make_eta_tyfun (Types.ref_tyname),
                    let 
                      val valenv =
                        Valenv.add_to_ve
                        (Ident.CON (Ident.Symbol.find_symbol ("ref")),
                         Scheme.make_scheme
                         ([aty],
                          (FUNTYPE (aty,CONSTYPE([aty],
                                                Types.ref_tyname)),NONE)),
                         empty_valenv)
                      val valenvref = case Types.ref_tyname of
                        TYNAME {5=valenvref,...} => valenvref
                      | _ => Crash.impossible"Types.ref_tyname bad"
                    in
                      (valenvref := valenv ; valenv)
                    end)
           end), 
          (Ident.TYCON (Ident.Symbol.find_symbol ("exn")),
           TYSTR (Types.make_eta_tyfun (Types.exn_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("list")),
           let
             val aty = atyvar ("'a",false,false)
           in
             TYSTR (Types.make_eta_tyfun (Types.list_tyname),
                    let 
                      val valenv =
                        Valenv.add_to_ve
                        (Ident.CON (Ident.Symbol.find_symbol ("nil")),
                         Scheme.make_scheme
                         ([aty],(CONSTYPE ([aty],Types.list_tyname),
                                 NONE)),
                         Valenv.add_to_ve
                         (Ident.CON (Ident.Symbol.find_symbol ("::")),
                          Scheme.make_scheme
                          ([aty],(FUNTYPE
                           (Types.add_to_rectype
                            (Ident.LAB 
                             (Ident.Symbol.find_symbol ("1")),aty,
                             Types.add_to_rectype
                             (Ident.LAB (Ident.Symbol.find_symbol ("2")),
                              CONSTYPE ([aty],Types.list_tyname),
                              Types.empty_rectype)),
                            CONSTYPE ([aty],Types.list_tyname)),NONE)),
                          empty_valenv))
                      val valenvref = case Types.list_tyname of
                        TYNAME {5=valenvref,...} => valenvref
                      | _ => Crash.impossible"Types.list_tyname bad"
                    in
                      (valenvref := valenv ; valenv)
                    end)
           end),
          (Ident.TYCON (Ident.Symbol.find_symbol ("bool")),
           TYSTR (Types.make_eta_tyfun (Types.bool_tyname),
                  let 
                    val valenv = 
                      Valenv.add_to_ve
                      (Ident.CON (Ident.Symbol.find_symbol ("true")),
                       Scheme.make_scheme
                       ([],(CONSTYPE ([],Types.bool_tyname),NONE)),
                       Valenv.add_to_ve
                       (Ident.CON (Ident.Symbol.find_symbol ("false")),
                        Scheme.make_scheme
                        ([],(CONSTYPE ([],Types.bool_tyname),NONE)),  
                        empty_valenv))
                    val valenvref = case Types.bool_tyname of
                      TYNAME {5=valenvref,...} => valenvref
                    | _ => Crash.impossible"Types.bool_tyname bad"
                  in
                    (valenvref := valenv ; valenv)
                  end)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("unit")),
           TYSTR (Types.make_tyfun ([],Types.empty_rectype),
                  empty_valenv))])

      val initial_te_for_builtin_library =
        Lists.reducel
        do_one
        (basic_te,
         [(Ident.TYCON (Ident.Symbol.find_symbol "type_rep"),
           TYSTR (Types.make_eta_tyfun (Types.typerep_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol "vector"),
           TYSTR (Types.make_eta_tyfun (Types.vector_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol "bytearray"),
           TYSTR (Types.make_eta_tyfun (Types.bytearray_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol "floatarray"),
           TYSTR (Types.make_eta_tyfun (Types.floatarray_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol "array"),
           TYSTR (Types.make_eta_tyfun (Types.array_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("dynamic")),
           TYSTR (Types.make_eta_tyfun (Types.dynamic_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("int8")),
           TYSTR (Types.make_eta_tyfun (Types.int8_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("word8")),
           TYSTR (Types.make_eta_tyfun (Types.word8_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("int16")),
           TYSTR (Types.make_eta_tyfun (Types.int16_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("word16")),
           TYSTR (Types.make_eta_tyfun (Types.word16_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("int32")),
           TYSTR (Types.make_eta_tyfun (Types.int32_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("word32")),
           TYSTR (Types.make_eta_tyfun (Types.word32_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("int64")),
           TYSTR (Types.make_eta_tyfun (Types.int64_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("word64")),
           TYSTR (Types.make_eta_tyfun (Types.word64_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("float32")),
           TYSTR (Types.make_eta_tyfun (Types.float32_tyname),
                  empty_valenv)),
          (Ident.TYCON (Ident.Symbol.find_symbol ("ml_value")),
           TYSTR (Types.make_eta_tyfun (Types.ml_value_tyname),
                  empty_valenv))])

      val initial_te = basic_te 
    end
end
