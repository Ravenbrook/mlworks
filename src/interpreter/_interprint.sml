(*  ==== INTERPRETER PRINTER ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Revision Log
 *  ------------
 *  $Log: _interprint.sml,v $
 *  Revision 1.66  1999/02/02 16:00:05  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 * Revision 1.65  1998/03/02  15:07:22  mitchell
 * [Bug #70074]
 * Add depth limit support for signature printing
 *
 * Revision 1.64  1997/05/22  14:03:29  jont
 * [Bug #30090]
 * Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.63  1996/11/06  11:13:57  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.62  1996/10/30  15:12:26  io
 * [Bug #1614]
 * removing toplevel String
 *
 * Revision 1.61  1996/10/23  11:31:19  andreww
 * [Bug #1686]
 * extending parser environment
 *
 * Revision 1.60  1996/09/05  17:02:28  andreww
 * [Bug #1577]
 * Catching the "Unbound" exception in the print_identifier function
 *
 * Revision 1.59  1996/08/05  18:18:50  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_scheme.sml and _types.sml
 *
 * Revision 1.58  1996/05/01  09:49:24  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.57  1996/04/30  09:39:40  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.56  1995/12/22  17:56:11  jont
 * Remove Option in favour of MLWorks.Option
 *
 *  Revision 1.55  1995/09/21  09:23:41  daveb
 *  Changed printing of datatypes back, but kept separate printing of constructors
 *  as well.
 *
 *  Revision 1.54  1995/08/15  16:11:42  daveb
 *  I implemented the last change by changing the way datatypes are printed.
 *  I've now corrected this so that constructors are printed *separately*.
 *
 *  Revision 1.53  1995/08/15  11:12:57  daveb
 *  Changed printing of datatypes to emphasise the fact that
 *  the value constructors are bound as well as the type constructor.
 *
 *  Revision 1.52  1995/07/13  12:05:51  matthew
 *  Moving identifier type to Ident
 *
 *  Revision 1.51  1995/05/02  12:23:10  matthew
 *  Removing debug_polyvariables
 *
 *  Revision 1.50  1995/04/11  10:07:57  matthew
 *  Adding cached completion functions
 *
 *  Revision 1.49  1995/04/06  12:23:38  matthew
 *  Adding (debugging) output of internal structures.
 *
 *  Revision 1.48  1995/03/31  10:19:15  daveb
 *  Removed constructors from the list of results.
 *
 *  Revision 1.47  1995/03/02  12:47:57  daveb
 *  Removed the indentation argument to the strings function.
 *
 *  Revision 1.46  1995/02/07  13:59:28  matthew
 *  Changes to type lookup functions
 *
 *  Revision 1.45  1994/08/09  12:14:48  daveb
 *  Removed SourceResult type, and changed strings function to take a
 *  ParserBasis argument instead.
 *
 *  Revision 1.44  1994/07/28  15:42:30  daveb
 *  Removed definitions function.
 *
 *  Revision 1.43  1994/06/24  10:56:16  daveb
 *  Restored printing of fixity directives.
 *
 *  Revision 1.42  1994/06/21  12:11:51  daveb
 *  Added strings function, for tools that want to use the result strings.
 *
 *  Revision 1.41  1994/06/09  16:01:56  nickh
 *  New runtime directory structure.
 *
 *  Revision 1.40  1994/05/06  16:41:51  jont
 *  Add printing of fixity directives
 *
 *  Revision 1.39  1994/05/04  15:04:03  jont
 *  Fix printing of types in general to get the arity information right
 *  and to give the full information
 *
 *  Revision 1.38  1994/02/21  23:45:59  nosa
 *  Boolean indicators for Modules Debugger and Monomorphic debugger decapsulation.
 *
 *  Revision 1.37  1994/01/28  16:22:41  matthew
 *  Better locations in error messages
 *
 *  Revision 1.36  1994/01/07  15:59:47  matthew
 *  Print signature name when signature absyn is unknown.
 *
 *  Revision 1.35  1993/12/17  18:36:04  matthew
 *  Added option for depth of structure printing
 *
 *  Revision 1.34  1993/12/15  13:42:41  matthew
 *  Added level field to Basis.
 *
 *  Revision 1.33  1993/11/30  13:33:51  matthew
 *  Added is_abs field to TYNAME and METATYNAME
 *
 *  Revision 1.32  1993/09/17  10:04:26  nosa
 *  Print overloaded polymorphic values as functions for polymorphic debugger.
 *
 *  Revision 1.31  1993/07/29  11:18:11  matthew
 *  Removed error_info parameter from definitions
 *
 *  Revision 1.30  1993/07/06  11:20:51  daveb
 *  Removed exception environments.
 *
 *  Revision 1.29  1993/06/04  16:28:42  matthew
 *  Added space after tyvars in datatype printing
 *
 *  Revision 1.28  1993/06/03  10:40:45  matthew
 *  Added space before list of tyvars in type printing
 *
 *  Revision 1.27  1993/05/10  10:59:27  matthew
 *  Use ordered fold for printing datatypes etc.
 *
 *  Revision 1.26  1993/05/06  12:12:49  matthew
 *  Removed printer descriptors.
 *
 *  Revision 1.25  1993/04/26  17:31:56  daveb
 *  Moved print_tyvars and make_tyvars to _types.
 *
 *  Revision 1.24  1993/04/02  14:03:56  matthew
 *  Signature changes
 *
 *  Revision 1.23  1993/03/12  11:11:26  matthew
 *  Changed definitions to take an output function rather than a stream
 *
 *  Revision 1.22  1993/03/09  15:31:52  matthew
 *  Options & Info changes
 *  Removed InterMake from signature
 *
 *  Revision 1.21  1993/03/04  10:56:21  daveb
 *  Changed a call to output to a call to Info.error'.
 *  Changed references to std_out to the appropriate outstream.
 *
 *  Revision 1.20  1993/02/22  17:02:06  matthew
 *   Removed currying from completion interface
 *  Reinstated printing of COPYSTR's
 *
 *  Revision 1.19  1993/02/09  10:45:27  matthew
 *  Typechecker structure changes
 *
 *  Revision 1.18  1993/02/04  18:33:33  matthew
 *  Structure changes.
 *
 *  Revision 1.17  1993/01/07  11:29:15  matthew
 *  In print_typescheme_closed, removed the application of the type scheme which
 *  didn't handle imperative and equality attributes properly.
 *
 *  Revision 1.16  1992/12/18  16:46:13  jont
 *  Modified to produce longtycons when printing types out of structures
 *
 *  Revision 1.15  1992/12/09  15:41:12  clive
 *  Lower level changes going up
 *
 *  Revision 1.14  1992/12/03  13:36:45  jont
 *  Modified tyenv for efficiency
 *
 *  Revision 1.13  1992/12/01  17:46:16  daveb
 *  Changes to propagate compiler options as parameters instead of references.
 *
 *  Revision 1.12  1992/11/30  16:36:29  matthew
 *  Used pervasive streams
 *
 *  Revision 1.11  1992/11/27  19:47:29  daveb
 *  Changes to make show_id_class and show_eq_info part of Info structure
 *  instead of references.
 *
 *  Revision 1.10  1992/11/26  14:25:28  matthew
 *  Changed to use Stream structure
 *
 *  Revision 1.9  1992/11/20  16:38:10  jont
 *  Modified sharing constraints to remove superfluous structures
 *
 *  Revision 1.8  1992/11/09  14:37:10  daveb
 *  Added option type to control printing.
 *
 *  Revision 1.7  1992/11/03  16:26:41  richard
 *  Time is now represented by a pervasive structure.
 *
 *  Revision 1.6  1992/10/14  17:53:11  richard
 *  Added diagnostics.
 *
 *  Revision 1.5  1992/10/12  08:46:21  clive
 *  Tynames now have a slot recording their definition point
 *
 *  Revision 1.4  1992/10/09  09:36:23  clive
 *  Added printing of the values contained in structures
 *
 *  Revision 1.3  1992/10/08  11:17:29  clive
 *  Modified to use new value_printer
 *
 *  Revision 1.2  1992/10/07  15:24:14  richard
 *  Changes related to restructuring of Incremental.
 *
 *  Revision 1.1  1992/10/01  16:47:20  richard
 *  Initial revision
 *
 *)

require "^.basis.__text_io";
require "^.basis.__int";

require "../utils/diagnostic";
require "../lambda/topdecprint";
require "../basics/identprint";
require "../debugger/value_printer";
require "../lambda/environ";
require "../typechecker/basis";
require "../typechecker/environment";
require "../typechecker/valenv";
require "../typechecker/strenv";
require "../typechecker/tyenv";
require "../typechecker/types";
require "../typechecker/completion";
require "../typechecker/sigma";
require "../parser/parserenv";
require "../rts/gen/tags";
require "incremental";
require "interprint";

functor InterPrint (
  structure Incremental	: INCREMENTAL
  structure TopdecPrint	: TOPDECPRINT
  structure IdentPrint	: IDENTPRINT
  structure ValuePrinter: VALUE_PRINTER
  structure Environ     : ENVIRON
  structure Basis       : BASIS
  structure Env         : ENVIRONMENT
  structure Valenv	: VALENV
  structure Strenv	: STRENV 
  structure Tyenv	: TYENV
  structure Types	: TYPES
  structure Completion	: COMPLETION
  structure Sigma	: SIGMA
  structure ParserEnv	: PARSERENV
  structure Diagnostic	: DIAGNOSTIC
  structure Tags	: TAGS

  sharing Types.Datatypes.Ident = IdentPrint.Ident = ParserEnv.Ident
  sharing Incremental.InterMake.Compiler.Absyn = TopdecPrint.Absyn
  sharing Basis.BasisTypes.Datatypes = Completion.Datatypes =
    Types.Datatypes = Valenv.Datatypes = Tyenv.Datatypes = Strenv.Datatypes = Env.Datatypes
  sharing TopdecPrint.Options = Types.Options = IdentPrint.Options =
    Incremental.InterMake.Inter_EnvTypes.Options = Completion.Options =
    ValuePrinter.Options = Sigma.Options
  sharing Incremental.InterMake.Inter_EnvTypes.EnvironTypes = Environ.EnvironTypes
  sharing Incremental.InterMake.Compiler.NewMap =
    Basis.BasisTypes.Datatypes.NewMap
  sharing TopdecPrint.Absyn.Ident = Basis.BasisTypes.Datatypes.Ident =
    Environ.EnvironTypes.LambdaTypes.Ident
  sharing Basis.BasisTypes = Sigma.BasisTypes

  sharing type Incremental.InterMake.Compiler.DebugInformation =
    ValuePrinter.DebugInformation
  sharing type Environ.Structure = Basis.BasisTypes.Datatypes.Structure
  sharing type TopdecPrint.Absyn.Type = Basis.BasisTypes.Datatypes.Type = 
    ValuePrinter.Type = Environ.EnvironTypes.LambdaTypes.Type
  sharing type Incremental.InterMake.Compiler.TypeBasis = ValuePrinter.TypeBasis = Basis.BasisTypes.Basis
  sharing type Incremental.InterMake.Compiler.ParserBasis = ParserEnv.pB
) : INTERPRINT =
  struct
    structure Incremental = Incremental
    structure Datatypes = Types.Datatypes
    structure Map = Datatypes.NewMap
    structure Ident = Datatypes.Ident
    structure Inter_EnvTypes = Incremental.InterMake.Inter_EnvTypes
    structure Compiler = Incremental.InterMake.Compiler
    structure BasisTypes = Basis.BasisTypes
    structure Diagnostic = Diagnostic
    structure ValuePrinter = ValuePrinter
    structure Info = Compiler.Info
    structure Options = ValuePrinter.Options
    type Context = Incremental.Context

    fun diagnostic_fn (level, output_function) =
      Diagnostic.output_fn level
      (fn (verbosity, stream) => (TextIO.output (stream, "Incremental: ");
				  output_function (verbosity, stream)))

    val show_structures = false

    exception Undefined of Ident.Identifier

    val make_tyvars = Types.make_tyvars

    fun strings 
	  (context,
           options as
           Options.OPTIONS
	     {print_options,
	      compiler_options =
		Options.COMPILEROPTIONS
		  {generate_moduler, ...},
              compat_options =
                Options.COMPATOPTIONS
                  {old_definition, ...},
              ...},
           identifiers,
	   parser_basis) =
      let
        val cache_ref = ref (Completion.empty_cache ())
        fun print (so_far, string) = so_far ^ string
        val out = ""
        val signatures = Incremental.signatures context
        val type_basis = Incremental.type_basis context

        val fixity = case parser_basis of
	  ParserEnv.B(_, _, ParserEnv.E(ParserEnv.FE fixity_map, _, _,_)) =>
	    fixity_map

        val BasisTypes.BASIS (_,_, functor_env, _, environment as
                              Datatypes.ENV (structure_env,
                                             type_env,
                                             value_env)) = type_basis
        val inter_env = Incremental.inter_env context

	fun print_one_fixity(symbol, ParserEnv.LEFT i) =
	  "infix " ^ Int.toString i ^ " " ^
	  ParserEnv.Ident.Symbol.symbol_name symbol
	  | print_one_fixity(symbol, ParserEnv.RIGHT i) =
	    "infixr " ^ Int.toString i ^ " " ^
	    ParserEnv.Ident.Symbol.symbol_name symbol
	  | print_one_fixity(symbol, ParserEnv.NONFIX) = ""

	fun print_fixity (out, fix) =
	  let
	    val string = print_one_fixity fix
	  in
	    if string = "" then out
	    else
	      print(out, string ^ "\n")
	  end

        fun print_typescheme_closed(out, scheme) =
          case scheme of
            Datatypes.SCHEME (arity, (ty,_)) =>
              let
                val (str,newcache) = 
                  Completion.cached_print_type(options,
                                               environment,ty,!cache_ref)
              in
                cache_ref := newcache;
                print (out,str)
              end
          | Datatypes.UNBOUND_SCHEME (ty,_) =>
              let
                val (str,newcache) = Completion.cached_print_type
                  (options,environment,ty,!cache_ref)
              in
                cache_ref := newcache;
                print (out,str)
              end
          | Datatypes.OVERLOADED_SCHEME _ =>
              print (out, "<strange overloaded scheme>")

        fun print_indent (out, 0) = out
          | print_indent (out, indent) =
            let
              fun reduce (out, 0) = out
                | reduce (out, indent) =
                  if indent >= 8 then
                    reduce (print (out, "        "), indent-8)
                  else if indent >= 4 then
                    reduce (print (out, "    "), indent-4)
                  else if indent >= 2 then
                    reduce (print (out, "  "), indent-2)
                  else 
                    print (out, " ")
            in
              reduce (out, indent)
            end

	fun tyname_name(Datatypes.TYNAME{2=name, ...}) = name
	  | tyname_name(Datatypes.METATYNAME{2=name, ...}) = name

        fun print_value (out, indent,
			 valid as Ident.VAR _,
			 typescheme, value_opt) =
            let
              val out = print_indent (out, indent)
              val out = print (out, "val ")
              val out = print (out, IdentPrint.printValId print_options valid)
              val out = print (out, " : ")
              val out = print_typescheme_closed (out, typescheme)
            in
              case value_opt of
                NONE => print (out, " = _\n")
              | SOME value => 
                  let
                    val out = print (out, " = ")
                    val out =
                      let
                        val string =
                          case typescheme of
                            Datatypes.SCHEME (arity, (ty,_)) =>
                              ValuePrinter.stringify_value false
                              (print_options, value,
                               Types.apply (Datatypes.TYFUN (ty, arity), make_tyvars arity), 
                               Incremental.debug_info context)
                          | Datatypes.UNBOUND_SCHEME (ty,_) =>
                              ValuePrinter.stringify_value false
                              (print_options, value, ty,
                               Incremental.debug_info context)
                          | Datatypes.OVERLOADED_SCHEME _ =>
                              "<strange overloaded value>"
                      in
                        print (out, string)
                      end
                    val out = print (out, "\n")
                  in
                    out
                  end
            end
        |   print_value (out, indent, valid as Ident.EXCON _, typescheme, _) =
          let
            val out = print_indent (out, indent)
            val out = print (out, "exception ")
            val out = print (out, IdentPrint.printValId print_options valid)
            val out =
              case typescheme of
                Datatypes.UNBOUND_SCHEME (ty as Datatypes.FUNTYPE (arg, exn),_) =>
                  if Types.type_eq (exn, Types.exn_type, true, true) then
                    print (print (out, " of "),
			   Types.print_type options arg)
                  else
                    print (print (out, " <strange function type> "),
			   Types.print_type options ty)
              | Datatypes.UNBOUND_SCHEME (ty,_) =>
                  if Types.type_eq (ty, Types.exn_type, true, true) then
                    out
                  else
                    print (print (out, " <strange type> "),
			   Types.print_type options ty)
              | scheme => 
                  print_typescheme_closed (print (out, " <strange scheme> "),
					   scheme)
            val out = print (out, "\n")
          in
            out
          end
        |   print_value (out, indent, valid as Ident.CON _, typescheme, _) =
            let
              val out = print_indent (out, indent)
              val out = print (out, "val ")
              val out = print (out, IdentPrint.printValId print_options valid)
              val out = print (out, " : ")
              val out = print_typescheme_closed (out, typescheme)
            in
              print (out, "\n")
            end
        |   print_value {1=out, ...} = out

        fun print_type (out, indent, tycon,
			Datatypes.TYSTR(tyfun, value_env as
						 Datatypes.VE (_, values))) =

	  case tyfun of

	    Datatypes.NULL_TYFUN _ =>
	      let
		val out = print_indent (out, indent)
		val out = print (out, "<strange null tyfun> ")
		val out = print (out, IdentPrint.printTyCon tycon)
		val out = print (out, "\n")
	      in
		out
	      end

	  | Datatypes.ETA_TYFUN tyname =>
	      (case tyname of
		 Datatypes.METATYNAME{1=ref tyfun', ...} =>
		   print_type(out, indent, tycon,
			      Datatypes.TYSTR(tyfun', value_env))
	       | _ =>
                   if Valenv.empty_valenvp value_env then
                     let
                       val tyvars = make_tyvars (Types.tyname_arity tyname)
                       val out = print_indent (out, indent)
                       val out = print (out,
                                        if Types.eq_attrib tyname then
                                          "eqtype "
                                        else
                                          "type ")
                       val out = print (out, Types.print_tyvars options tyvars)
                       val out = case tyvars of [] => out | _ => print (out," ")
                       val out = print (out, IdentPrint.printTyCon tycon)
                       val out = print (out, " = ")
                       val out = print (out, Types.print_type 
                                        options
                                        (Types.apply (tyfun, tyvars)))
                       val out = print (out, "\n")
                     in
                       out
                     end
                   else
                     let
                       val tyvars = make_tyvars (Types.tyname_arity tyname)

                       val out = print_indent (out, indent)
                       val out = print (out, "datatype ")
                       val out = print (out, Types.print_tyvars options tyvars)
                       val out = case tyvars of [] => out | _ => 
                                                        print (out," ")
                       val out = print (out, IdentPrint.printTyCon tycon)

                       val (out, _) =
                         Datatypes.NewMap.fold_in_order
                         (fn ((out, first), valid, typescheme) =>
                          let
                            val out = print (out, if first then " =\n" else " |\n")
                            val out = print_indent (out, indent+2)
                            val out = print (out, IdentPrint.printValId print_options valid)
                          in
                            (case typescheme of
                               Datatypes.UNBOUND_SCHEME (Datatypes.FUNTYPE (arg, _),_) =>
                                 print (print (out, " of "), 
                                        Types.print_type options arg)
                             | Datatypes.UNBOUND_SCHEME _ => out
                             | Datatypes.SCHEME (arity, (ty,_)) =>
                                 (case Types.apply (Datatypes.TYFUN (ty, arity), tyvars) of
                                    Datatypes.FUNTYPE (arg, _) =>
                                      print (print (out, " of "), 
                                             Types.print_type options arg)
                                  | _ => out)
                             | Datatypes.OVERLOADED_SCHEME _ =>
                                 print (out, " <strange overloaded scheme>"),
                                 false)
                          end)
                         ((out, true), values)

                       val out = print (out, "\n")
                     in
                       out
                     end)

(*
		 let
		   val tyvars = make_tyvars (Types.tyname_arity tyname)
		   val out = print_indent (out, indent)
		   val out = print (out, if Types.eq_attrib tyname then "eqtype " else "type ")
		   val out = print (out, Types.print_tyvars tyvars)
		   val out = case tyvars of [] => out | _ => print (out," ")
		   val out = print (out, IdentPrint.printTyCon tycon)
		 in
		   if Valenv.empty_valenvp value_env then
		     let
		       val out = print (out, " = ")
		       val out = print (out, Types.print_type options
                                               (Types.apply (tyfun, tyvars)))
		     in
		       print (out, "\n")
		     end
		   else
		     print (out, "\n")
		 end)
*)

	  | tyfun as Datatypes.TYFUN (ty, arity) =>
	      let
		val tyvars = make_tyvars arity
		val out = print_indent (out, indent)
		val out = print (out, if Types.equalityp tyfun then "eqtype " else "type ")
		val out = print (out, Types.print_tyvars options tyvars)
		val out = if arity = 0 then out else print (out," ")
		val out = print (out, IdentPrint.printTyCon tycon)
		val out = print (out, " = ")
		val out = print (out, Types.print_type options
                                              (Types.apply (tyfun, tyvars)))
		val out = print (out, "\n")
	      in
		out
	      end

        exception ExpandStr

        fun print_structure (out, indent, depth, strid,
                             str,
                             value_opt) =
          let
            val out = print_indent (out, indent)
            val out = print (out, "structure ")
            val out = print (out, IdentPrint.printStrId strid)
            val out = if show_structures then print (print (out, ": "), Env.string_str str) else out
            val lambda_env = Environ.make_str_env (str,generate_moduler)

            val (_,_,Datatypes.ENV (Datatypes.SE structures,
                                    Datatypes.TE types,
                                    Datatypes.VE (_, values))) =
              case Env.expand_str str of
                Datatypes.STR data => data
              | _ => raise ExpandStr

            fun sub_structure (value, index) =
              let
                val primary = MLWorks.Internal.Value.primary value
              in
                if primary = Tags.PAIRPTR then
                  SOME (MLWorks.Internal.Value.sub (value, index))
                else if primary = Tags.POINTER then
                  SOME (MLWorks.Internal.Value.sub (value, index+1))
                else
                  NONE
              end
          in
            if depth = 0 
              then print (out, " = struct ... end\n")
            else
              let
                val out = print (out, " =\n")
                val out = print_indent (out, indent+2)
                val out = print (out, "struct\n")

                val out =
                  Datatypes.NewMap.fold_in_order
                  (fn (out, strid, str) => 
                   let
                     val substructure =
                       case value_opt of
                         NONE => NONE
                       | SOME value =>
                           (case Environ.lookup_strid (strid, lambda_env) of
                              (_, Environ.EnvironTypes.FIELD {index, ...}, _) =>
                                sub_structure (value, index)
                            | _ => NONE)
                   in
                     print_structure (out, indent+4, depth-1, strid, str, substructure)
                   end)
                  (out, structures)
                  
                val out =
                  Datatypes.NewMap.fold_in_order
                  (fn (out, tycon, tystr) => print_type (out, indent+4, tycon, tystr))
                  (out, types)
                  
                val out =
                  Datatypes.NewMap.fold_in_order
                  (fn (out, valid, typescheme) => 
                   let
                     val subvalue =
                       case value_opt of
                         NONE => NONE
                       | SOME value =>
                           (case Environ.lookup_valid
				   (valid, lambda_env) of
                              Environ.EnvironTypes.FIELD {index, ...} =>
                                sub_structure (value, index)
                            | _ => NONE)
                   in
                     print_value (out, indent+4, valid, typescheme, subvalue)
                   end)
                  (out,values)

                val out = print_indent (out, indent+2)
                val out = print (out, "end\n")
              in
                out
              end
          end

        fun print_signature (out, indent, sigid, sigexp) =
          let
            val out = print_indent (out, indent)
            val out = print (out, "signature ")
            val out = print (out, IdentPrint.printSigId sigid)
            val out = 
              if show_structures then
                let
                  val sigma = Basis.lookup_sigid (sigid,type_basis)
                in
                  print (print (out,": "), Sigma.string_sigma Options.default_print_options sigma)
                end
              else out
            val Options.PRINTOPTIONS{maximum_sig_depth,...} = print_options
          in 
            if (maximum_sig_depth = 0)
            then print(out, " = sig ... end\n")
            else 
              let val out = print(out, " =\n");
                  val out = TopdecPrint.print_sigexp options
                    print (out, indent+2, sigexp)
                  val out = print (out, "\n")
               in
                  out
              end
          end

        fun print_functor (out, indent, funid) =
          let
            val out = print_indent (out, indent)
            val out = print (out, "functor ")
            val out = print (out, IdentPrint.printFunId funid)
            val out = print (out, "\n")
            val out = 
              if show_structures then
                let
                  val phi = Basis.lookup_funid (funid,type_basis)
                in
                  print (out, Sigma.string_phi Options.default_print_options phi)
                end
              else out
          in
            out
          end

        fun print_identifier (out, ident as Ident.SIGNATURE sigid) =
            (print_signature (out, 0, sigid, Map.apply' (signatures, sigid))
               handle Map.Undefined => print (out,"signature " ^ IdentPrint.printSigId sigid ^ "\n"))
          | print_identifier (out, ident as Ident.VALUE valid) =
            (print_value (out, 0, valid,
			  Valenv.lookup (valid, value_env),
                          (SOME
			    (Inter_EnvTypes.lookup_val
			       (valid, inter_env)))
                          handle Map.Undefined => NONE)
                              (* This handler exists for the special case when
                                 we're replicating built-in datatypes: their
                                 definitions do not exist in the inter_env *)
             handle Valenv.LookupValId _ => raise Undefined ident)
          | print_identifier (out, ident as Ident.TYPE tycon) =
            (print_type (out, 0, tycon, Tyenv.lookup (type_env, tycon))
               handle Tyenv.LookupTyCon _ => raise Undefined ident)
          | print_identifier (out, ident as Ident.STRUCTURE strid) =
            let
              val Options.PRINTOPTIONS{maximum_str_depth,...} = print_options
            in
              case Strenv.lookup (strid, structure_env) of
                SOME str =>
                  (print_structure (out, 0, maximum_str_depth, strid, 
                                    str,
                                    SOME(Inter_EnvTypes.lookup_str (strid, inter_env))))
              | _ => raise Undefined ident
            end
          | print_identifier (out, ident as Ident.FUNCTOR funid) =
            print_functor(out, 0, funid)

	fun group_by_class ([], sigs, funs, strs, types, values) =
	  (rev sigs, rev funs, rev strs, rev types, rev values)
	|   group_by_class ((ident as Ident.SIGNATURE _) :: t, sigs, funs, strs, types, values) =
	  group_by_class (t, ident :: sigs, funs, strs, types, values)
	|   group_by_class ((ident as Ident.FUNCTOR _) :: t, sigs, funs, strs, types, values) =
	  group_by_class (t, sigs, ident :: funs, strs, types, values)
	|   group_by_class ((ident as Ident.STRUCTURE _) :: t, sigs, funs, strs, types, values) =
	  group_by_class (t, sigs, funs, ident :: strs, types, values)
	|   group_by_class ((ident as Ident.TYPE _) :: t, sigs, funs, strs, types, values) =
	  group_by_class (t, sigs, funs, strs, ident :: types, values)
	|   group_by_class ((ident as Ident.VALUE _) :: t, sigs, funs, strs, types, values) =
	  group_by_class (t, sigs, funs, strs, types, ident :: values)

	val (sigs, funs, strs, types, values) =
	  group_by_class (identifiers, [], [], [], [], [])
      in
        diagnostic_fn
        (1,
	 fn (_, stream) =>
	 app
           (fn Ident.SIGNATURE sigid =>
	       TextIO.output(stream,
		      concat ["signature ", IdentPrint.printSigId sigid, "\n"]
	             )
             | Ident.STRUCTURE strid =>
	       TextIO.output(stream,
		      concat ["structure ", IdentPrint.printStrId strid, "\n"]
		     )
             | Ident.VALUE (valid as Ident.EXCON _) =>
	       TextIO.output(stream,
		      concat ["exception ", IdentPrint.printValId print_options valid, "\n"]
		     )
             | Ident.VALUE valid =>
	       TextIO.output(stream,
		      concat ["value ",     IdentPrint.printValId print_options valid, "\n"]
		     )
             | Ident.TYPE      tycon =>
	       TextIO.output(stream,
		      concat ["type ",      IdentPrint.printTyCon tycon, "\n"]
		     )
             | Ident.FUNCTOR   funid =>
	       TextIO.output(stream,
		      concat ["functor ",   IdentPrint.printFunId funid, "\n"]
		     )
	   )
           identifiers
	);
	map
	  (fn entry as (sym, fix) =>
	     (Ident.VALUE (Ident.VAR sym), print_fixity (out, entry)))
	  (ParserEnv.Map.to_list fixity)
	@ map (fn id => (id, print_identifier (out, id))) sigs
	@ map (fn id => (id, print_identifier (out, id))) funs
	@ map (fn id => (id, print_identifier (out, id))) strs
	@ map (fn id => (id, print_identifier (out, id))) types
	@ map (fn id => (id, print_identifier (out, id))) values
      end
  end
