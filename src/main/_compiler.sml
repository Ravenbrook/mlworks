(*  ==== COMPILER INTERFACE ====
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
 *  Notes
 *  -----
 *  Do not use module-global state!  This module needs to be used in a
 *  referentially transparent manner.
 *
 *  Revision Log
 *  ------------
 *  $Log: _compiler.sml,v $
 *  Revision 1.77  1998/01/30 09:42:54  johnh
 *  [Bug #30326]
 *  Merge in change from branch MLWorks_workspace_97
 *
 * Revision 1.76  1997/11/13  11:18:30  jont
 * [Bug #30089]
 * Modify TIMER (from utils) to be INTERNAL_TIMER to keep bootstrap happy
 *
 * Revision 1.75.2.2  1997/11/20  17:12:17  daveb
 * [Bug #30326]
 *
 * Revision 1.75.2.1  1997/09/11  20:56:36  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.75  1997/05/21  17:15:13  jont
 * [Bug #30090]
 * Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.74  1997/05/12  15:58:40  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.73  1996/12/02  16:12:27  matthew
 * lambda code changed
 *
 * Revision 1.72  1996/10/29  17:05:47  io
 * moving String from toplevel
 *
 * Revision 1.71  1996/09/25  10:40:23  matthew
 * Adding location to Lexer.ungetToken
 *
 * Revision 1.70  1996/08/06  12:54:28  andreww
 * [Bug #1521]
 * propagating changes made to typechecker/_types.sml
 * (pass options rather than print_options)
 *
 * Revision 1.69  1996/04/30  17:15:43  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.68  1996/04/29  14:58:15  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.67  1996/03/28  11:13:37  matthew
 * Adding where type clause
 *
 * Revision 1.66  1996/03/21  10:00:15  matthew
 * Making extract_identifiers return items in lexicographical order
 *
 * Revision 1.65  1996/03/19  16:44:36  matthew
 * Change for value polymorphism
 *
 * Revision 1.64  1996/03/18  16:03:21  daveb
 * Removed the identifiers field from the Compiler.result type.  This information
 * can be synthesised from the type basis.
 *
 * Revision 1.63  1996/02/23  17:40:12  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.62  1996/01/16  12:53:45  daveb
 * Added location information to Absyn.SIGNATUREtopdec.
 *
 *  Revision 1.61  1995/12/27  14:16:17  jont
 *  Removing Option in favour of MLWorks.Option
 *
 *  Revision 1.60  1995/11/22  09:49:01  daveb
 *  Removed no_execute.
 *
 *  Revision 1.59  1995/09/05  14:48:21  daveb
 *  LambdaTypes.changes.
 *
 *  Revision 1.58  1995/08/18  10:12:57  jont
 *  Start assemblies from basis for builtin library compilation
 *
 *  Revision 1.57  1995/08/01  14:25:33  matthew
 *  Adding environment simplication function
 *
 *  Revision 1.56  1995/07/13  11:34:21  matthew
 *  Moving Compiler.identifier type to Ident
 *
 *  Revision 1.55  1995/06/12  14:17:15  daveb
 *  Corrected minor mistake in order of identifiers in result list.
 *
 *  Revision 1.54  1995/06/12  13:42:18  daveb
 *  Added some explanatory comments.
 *
 *  Revision 1.53  1995/05/30  12:02:32  matthew
 *  Added make_debug_code to miroptimiser.optimise
 *
 *  Revision 1.52  1995/04/05  14:45:28  matthew
 *  Change Tyfun_id etc to Stamp
 *
 *  Revision 1.51  1995/03/06  11:43:11  daveb
 *  Added dummy identifier value.
 *
 *  Revision 1.50  1995/02/14  14:18:35  matthew
 *  Change to augment_information
 *
 *  Revision 1.49  1994/10/14  09:19:07  matthew
 *  Changed Map.fold to Map.fold_in_rev_order
 *  so identifier list is in alphabetic sequence
 *
 *  Revision 1.48  1994/07/19  16:20:09  matthew
 *  Multiple arguments to functions
 *
 *  Revision 1.47  1994/06/22  14:53:36  jont
 *  Update debugger information production
 *
 *  Revision 1.46  1994/06/17  13:21:53  daveb
 *  Added compare_identifiers and empty_basis.
 *
 *  Revision 1.45  1994/03/18  14:32:21  matthew
 *  Added add_debug_info function
 *
 *  Revision 1.44  1994/02/28  08:28:46  nosa
 *  Debugger environments for Modules Debugger.
 *
 *  Revision 1.43  1994/02/25  15:57:47  daveb
 *  Removed old parameter to trans_top_dec, added clear_debug functionality.
 *
 *  Revision 1.42  1994/01/26  18:03:35  matthew
 *  Simplification.
 *
 *  Revision 1.41  1994/01/07  14:37:40  matthew
 *  Added information on tyname_ids etc. to result
 *
 *  Revision 1.40  1993/12/20  10:07:26  matthew
 *  Added level parameter to basis. (This should have been revision 1.38, but it got lost).
 *
 *  Revision 1.39  1993/12/17  15:31:34  io
 *   Moved over from machine/ for SPARC/MIPS targetting
 *
 *  Revision 1.37  1993/10/06  11:42:09  jont
 *  Changed type of compile to indicate whether the file in question is pervasive
 *
 *  Revision 1.36  1993/08/16  11:18:35  daveb
 *  Removed spurious ".sml" from require declarations.
 *
 *  Revision 1.35  1993/08/12  17:01:09  daveb
 *  Removed Io parameter.
 *
 *  Revision 1.34  1993/08/03  17:50:16  jont
 *  Modified to disallow mid file requires
 *
 *  Revision 1.33  1993/07/29  14:28:36  nosa
 *  structure Option.
 *
 *  Revision 1.32  1993/07/09  10:16:34  daveb
 *  Augmented tyoe basis before passing it to trans_topdec.
 *
 *  Revision 1.31  1993/07/06  10:32:47  daveb
 *  Added basis argument to Lambda.trans_top_dec.
 *  Removed EXCEPTION identifier class.
 *
 *  Revision 1.30  1993/06/02  17:41:40  jont
 *  Changed to use new mod_rules interface. All unnecessary
 *  assembly calculations removed. More needs to be done, to decouple
 *  assemblies for Shell.Make.make from those for use
 *
 *  Revision 1.29  1993/05/27  17:10:54  matthew
 *  Added Location parameter to Info.wrap
 *
 *  Revision 1.28  1993/05/25  16:52:54  jont
 *  Changes because Assemblies now has Basistypes instead of Datatypes
 *
 *  Revision 1.27  1993/05/18  19:02:51  jont
 *  Removed integer parameter
 *
 *  Revision 1.26  1993/05/12  16:32:57  jont
 *  Changed compile to return list of modules compiled. Also implemented
 *  no_execute option for make to give make -n behaviouor
 *
 *  Revision 1.25  1993/05/11  12:53:05  jont
 *  Changes to lambda optimiser to allow removal of inlining for tracing
 *
 *  Revision 1.24  1993/04/26  16:28:54  jont
 *  Added remove_str for getting rid of FullPervasiveLibrary_ from initial env
 *
 *  Revision 1.23  1993/04/02  13:30:39  matthew
 *  Removed Debugger_Types from the signature
 *
 *  Revision 1.22  1993/03/17  12:18:25  matthew
 *  Added parserbasis field to source type
 *
 *  Revision 1.21  1993/03/12  11:57:12  matthew
 *  Options changes
 *  Signature revisions
 *
 *  Revision 1.20  1993/03/09  14:46:04  matthew
 *  Options & Info changes
 *  Removed Parser and BasisTypes substructures from signature
 *
 *  Revision 1.19  1993/02/09  10:05:27  matthew
 *  Changes for typechecker BASISTYPES signature
 *
 *  Revision 1.18  1993/02/04  15:06:55  matthew
 *  Changed functor parameter
 *
 *  Revision 1.17  1993/01/28  15:16:56  jont
 *  Modified to print abstract syntax, lambda calculus etc on request
 *
 *  Revision 1.16  1993/01/04  15:57:57  jont
 *  Modified to deal with extra options for code listing
 *
 *  Revision 1.15  1992/12/08  20:46:23  jont
 *  Removed a number of duplicated signatures and structures
 *
 *  Revision 1.14  1992/12/03  12:09:44  daveb
 *  Fixed sharing constraint
 *
 *  Revision 1.13  1992/12/02  15:58:56  daveb
 *  Changes to propagate compiler options as parameters instead of references.
 *
 *  Revision 1.12  1992/12/02  15:34:41  jont
 *  Modified to remove redundant info signatures
 *
 *  Revision 1.11  1992/11/27  15:43:12  daveb
 *  Changes to make show_id_class and show_eq_info part of Info structure
 *  instead of references.
 *
 *  Revision 1.10  1992/11/26  17:21:18  clive
 *  Added clear_debug_info function
 *
 *  Revision 1.9  1992/11/21  15:45:12  clive
 *  Changed the result type to allow the code to be deleted
 *
 *  Revision 1.8  1992/11/20  15:26:34  jont
 *  Modified sharing constraints to remove superfluous structures
 *
 *  Revision 1.7  1992/11/19  14:50:47  clive
 *  Added a few debug_info functions
 *
 *  Revision 1.6  1992/11/17  14:35:01  matthew
 *  Changed Error structure to Info
 *
 *  Revision 1.5  1992/11/04  12:37:48  richard
 *  Removed an obsolete sharing constraint.
 *
 *  Revision 1.4  1992/10/27  18:35:01  jont
 *  Modified to use sigid_lt instead of sigid_order
 *
 *  Revision 1.3  1992/10/14  12:09:23  richard
 *  Added location information to the `require' topdec and passed
 *  this through to the require function passed to compile.
 *
 *  Revision 1.2  1992/10/08  11:26:40  richard
 *  Added a source type and split parsing away from the rest of compilation
 *  in order to implement it.
 *
 *  Revision 1.1  1992/10/07  16:10:32  richard
 *  Initial revision
 *
 *)

require "../basis/__text_io";

require "../utils/diagnostic";
require "../parser/parser";
require "../lambda/lambda";
require "../lambda/lambdaoptimiser";
require "../lambda/lambdamodule";
require "../lambda/lambdaprint";
require "../lambda/topdecprint";
require "../mir/mir_cg";
require "../mir/miroptimiser";
require "../mir/mirprint";
require "mach_cg";
require "machprint";
require "../utils/lists";
require "../utils/crash";
require "../lambda/environ";
require "../lambda/environprint";
require "../typechecker/mod_rules";
require "../typechecker/basis";
require "../typechecker/stamp";
require "../main/primitives";
require "../main/pervasives";
require "../main/mlworks_io";
require "compiler";

functor Compiler (include sig
                  structure Parser : PARSER
                  structure Lambda : LAMBDA
                  structure LambdaOptimiser : LAMBDAOPTIMISER
                  structure LambdaModule : LAMBDAMODULE
                  structure LambdaPrint : LAMBDAPRINT
                  structure Environ : ENVIRON
                  structure EnvironPrint : ENVIRONPRINT
                  structure Mir_Cg : MIR_CG
                  structure MirOptimiser : MIROPTIMISER
		  structure MirPrint : MIRPRINT 
                  structure Mach_Cg : MACH_CG
                  structure MachPrint : MACHPRINT
                  structure Mod_Rules : MODULE_RULES
                  structure Basis : BASIS
                  structure Stamp : STAMP
                  structure Primitives : PRIMITIVES
                  structure Pervasives : PERVASIVES
		  structure Io : MLWORKS_IO
                  structure Lists : LISTS
                  structure Crash : CRASH
                  structure TopdecPrint : TOPDECPRINT
                  structure Diagnostic : DIAGNOSTIC

                  sharing Lambda.Options =
		    LambdaPrint.Options =
		    TopdecPrint.Options =
		    LambdaOptimiser.Options =
		    EnvironPrint.Options =
                    Mod_Rules.Options =
                    Mir_Cg.Options =
                    Mach_Cg.Options
                  sharing Parser.Lexer.Info =
		    Lambda.Info =
                    Mod_Rules.Info =
                    Mach_Cg.Info =
                    Mir_Cg.Info
                  sharing LambdaOptimiser.LambdaTypes =
                    LambdaPrint.LambdaTypes =
                    Mir_Cg.LambdaTypes =
		    Environ.EnvironTypes.LambdaTypes
                  sharing Environ.EnvironTypes =
                    LambdaModule.EnvironTypes =
                    Lambda.EnvironTypes =
                    Primitives.EnvironTypes =
		    EnvironPrint.EnvironTypes
                  sharing MirOptimiser.MirTypes =
                    Mir_Cg.MirTypes =
                    Mach_Cg.MirTypes =
		    MirPrint.MirTypes
                  sharing MirOptimiser.MachSpec = Mach_Cg.MachSpec
                  sharing Mod_Rules.Assemblies.Basistypes = Basis.BasisTypes
                  sharing Parser.Absyn = Mod_Rules.Absyn =
                    Lambda.Absyn = TopdecPrint.Absyn

                  sharing Basis.BasisTypes.Datatypes.NewMap = Environ.EnvironTypes.NewMap
                  sharing Basis.BasisTypes.Datatypes.Ident = Parser.Absyn.Ident =
                    Environ.EnvironTypes.LambdaTypes.Ident

                  sharing type Lambda.DebugInformation = Mir_Cg.MirTypes.Debugger_Types.information
                  sharing type Parser.Lexer.Options = Lambda.Options.options
		  sharing type Basis.BasisTypes.Basis = Lambda.BasisTypes.Basis
		  sharing type Mach_Cg.Opcode = MachPrint.Opcode
                  sharing type Mir_Cg.MirTypes.Debugger_Types.Type = 
                    Parser.Absyn.Type = Basis.BasisTypes.Datatypes.Type
                  sharing type Pervasives.pervasive = Environ.EnvironTypes.LambdaTypes.Primitive
                  sharing type Basis.BasisTypes.Datatypes.Stamp = Stamp.Stamp
                  sharing type Basis.BasisTypes.Datatypes.StampMap = Stamp.Map.T
                    end where type Environ.EnvironTypes.LambdaTypes.LVar = int

) : COMPILER =



  struct

    structure Diagnostic = Diagnostic
    structure Parser = Parser
    structure Lexer = Parser.Lexer
    structure Token = Lexer.Token
    structure Assemblies = Mod_Rules.Assemblies
    structure BasisTypes = Basis.BasisTypes
    structure EnvironTypes = Environ.EnvironTypes
    structure LambdaTypes = EnvironTypes.LambdaTypes
    structure Pervasives = Pervasives
    structure MirTypes = Mir_Cg.MirTypes
    structure Debugger_Types = MirTypes.Debugger_Types
    structure Map = BasisTypes.Datatypes.NewMap
    structure Info = Lexer.Info
    structure Options = LambdaPrint.Options
    structure NewMap = Map
    structure Location = Info.Location

    structure Absyn = Parser.Absyn
    structure Datatypes = BasisTypes.Datatypes
    structure Ident = Datatypes.Ident

    type Top_Env = EnvironTypes.Top_Env
    type DebuggerEnv = EnvironTypes.DebuggerEnv
    type LambdaExp = LambdaTypes.LambdaExp
    type Module = Mach_Cg.Module
    type ParserBasis = Parser.ParserBasis
    type TypeBasis = BasisTypes.Basis
    type DebugInformation = Debugger_Types.information
    type tokenstream = Lexer.TokenStream

    val (str_ass, ty_ass) =
      Assemblies.new_assemblies_from_basis Basis.initial_basis_for_builtin_library
    val str_ass = ref str_ass
    val ty_ass = ref ty_ass

    fun diagnostic (level, output_function) =
      Diagnostic.output level
      (fn verbosity => "Compiler: " :: (output_function verbosity))

    fun diagnostic_fn (level, output_function) =
      Diagnostic.output_fn level
      (fn (verbosity, stream) => (TextIO.output (stream, "Compiler: "); output_function (verbosity, stream)))

    datatype basis =
      BASIS of {parser_basis		: Parser.ParserBasis,
                type_basis		: BasisTypes.Basis,
                lambda_environment	: EnvironTypes.Top_Env,
                debugger_environment	: DebuggerEnv,
                debug_info		: Debugger_Types.information}

    val empty_basis =
      BASIS
        {parser_basis = Parser.empty_pB,
         type_basis = Basis.empty_basis,
         lambda_environment = Environ.empty_top_env,
         debugger_environment =
           EnvironTypes.DENV
             (Map.empty (Ident.valid_lt,Ident.valid_eq),
              Map.empty (Ident.strid_lt,Ident.strid_eq)),
         debug_info = Debugger_Types.empty_information}

    fun augment (Options.OPTIONS{compiler_options = Options.COMPILEROPTIONS{generate_debug_info,...},...},
		 BASIS {parser_basis, type_basis, lambda_environment, debugger_environment, debug_info},
                 BASIS {parser_basis = delta_parser_basis,
                        type_basis = delta_type_basis,
                        lambda_environment = delta_lambda_environment,
                        debugger_environment = delta_debugger_environment,
                        debug_info = delta_debug_info}) =
      BASIS {parser_basis = Parser.augment_pB (parser_basis, delta_parser_basis),
             type_basis = Basis.basis_circle_plus_basis (type_basis, delta_type_basis),
             lambda_environment = Environ.augment_top_env (lambda_environment, delta_lambda_environment),
             debugger_environment = Environ.augment_denv (debugger_environment, delta_debugger_environment),
             debug_info = Debugger_Types.augment_information (generate_debug_info, debug_info, delta_debug_info)}

    fun add_debug_info (Options.OPTIONS{compiler_options = Options.COMPILEROPTIONS{generate_debug_info,...},...},
                        new_debug_info,
                        BASIS {parser_basis, type_basis, lambda_environment, debugger_environment, debug_info}) =
      BASIS {parser_basis = parser_basis,
             type_basis = type_basis,
             lambda_environment = lambda_environment,
             debugger_environment = debugger_environment,
             debug_info = Debugger_Types.augment_information (generate_debug_info, debug_info, new_debug_info)}

    fun remove_str(BASIS {parser_basis, type_basis, lambda_environment, debugger_environment, debug_info},
		   strid) =
      BASIS{parser_basis = Parser.remove_str(parser_basis, strid),
	    type_basis = Basis.remove_str(type_basis, strid),
	    lambda_environment = lambda_environment,
	    debugger_environment = debugger_environment,
	    debug_info = debug_info}

    fun adjust_compiler_basis_debug_info(BASIS{parser_basis,type_basis,lambda_environment,debugger_environment,...},
					 new_debug_info) =
      BASIS{parser_basis=parser_basis,
	    type_basis=type_basis,
	    lambda_environment=lambda_environment,
	    debugger_environment=debugger_environment,
	    debug_info=new_debug_info}

    fun get_basis_debug_info(BASIS{debug_info,...}) = debug_info

    fun clear_debug_info
	  (name,
	   BASIS{parser_basis,type_basis,lambda_environment,debugger_environment,debug_info}) =
      BASIS{parser_basis=parser_basis,
	    type_basis=type_basis,
	    lambda_environment=lambda_environment,
	    debugger_environment=debugger_environment,
	    debug_info = Debugger_Types.clear_information (name, debug_info)}

    fun clear_debug_all_info
	  (BASIS{parser_basis,type_basis,lambda_environment,debugger_environment,...}) =
      BASIS{parser_basis=parser_basis,
	    type_basis=type_basis,
	    lambda_environment=lambda_environment,
	    debugger_environment=debugger_environment,
	    debug_info = Debugger_Types.empty_information}

    fun make_external (BASIS {parser_basis, type_basis, lambda_environment,
                                       debugger_environment, debug_info}) =
      BASIS {parser_basis = parser_basis,
             type_basis = type_basis,
             lambda_environment = Environ.make_external lambda_environment,
             debugger_environment = debugger_environment,
             debug_info = debug_info}

    (*  == Initial bases ==
     *
     *  These are assembled from other parts of the compiler.  No extra
     *  information is added here.
     *)

    local
      val initial_top_env =
        EnvironTypes.TOP_ENV (Primitives.env_for_not_ml_definable_builtins, Environ.empty_fun_env)
      val initial_top_env_for_builtin_library =
        EnvironTypes.TOP_ENV (Primitives.initial_env_for_builtin_library, Environ.empty_fun_env)
      val builtin_top_env = EnvironTypes.TOP_ENV (Primitives.env_after_builtin, Environ.empty_fun_env)
    in
      val initial_basis =
        BASIS {parser_basis = Parser.initial_pB,
               type_basis = Basis.initial_basis,
               lambda_environment = initial_top_env,
               debugger_environment = Environ.empty_denv,
               debug_info = Debugger_Types.empty_information}

      val initial_basis_for_builtin_library =
        BASIS {parser_basis = Parser.initial_pB_for_builtin_library,
               type_basis = Basis.initial_basis_for_builtin_library,
               lambda_environment = initial_top_env_for_builtin_library,
               debugger_environment = Environ.empty_denv,
               debug_info = Debugger_Types.empty_information}

      val builtin_lambda_environment = builtin_top_env
    end

    datatype id_cache = ID_CACHE of {stamp_start:int,
                                     stamp_no:int}

    datatype result =
      RESULT of {basis		: basis,
                 signatures	: (Ident.SigId, Parser.Absyn.SigExp) Map.map,
                 code		: Module option,
                 id_cache       : id_cache}

    (*  == Extract signatures from absyn ==
     *
     *  This function augments the signatures map with any signatures in the
     *  abstract syntax.  It is applied after parsing in order to return the
     *  signatures information to the user.
     *)

    fun extract_signatures
	  (signatures, Parser.Absyn.SIGNATUREtopdec (sigbinds, _)) =
        Lists.reducel
        (fn (map, Parser.Absyn.SIGBIND bindings) =>
         Lists.reducel
         (fn (map, (ident, exp, _)) => Map.define (map, ident, exp))
         (map, bindings))
        (signatures, sigbinds)
      | extract_signatures (signatures, _) = signatures


    (*  == Extract identifiers from type basis ==
     *
     *  This function augments the identifier list with any identifiers
     *  found in a type basis.  It is applied to the type basis that results
     *  from the compilation in order to supply the identifiers information
     *  to the user.
     *)

    fun extract_identifiers (identifiers,
                             BasisTypes.BASIS (_,_,
                                               BasisTypes.FUNENV functor_env,
                                               BasisTypes.SIGENV signature_env,
                                               Datatypes.ENV (Datatypes.SE structure_env,
                                                              Datatypes.TE type_env,
                                                              Datatypes.VE (_, value_env)))) =
      let
        val identifiers =
          Map.fold_in_rev_order
          (fn (identifiers, valid, _) => (Ident.VALUE valid)::identifiers)
          (identifiers, value_env)

        val identifiers =
          Map.fold_in_rev_order
          (fn (identifiers, tycon, _) => (Ident.TYPE tycon)::identifiers)
          (identifiers, type_env)

        val identifiers =
          Map.fold_in_rev_order
          (fn (identifiers, strid, _) => (Ident.STRUCTURE strid)::identifiers)
          (identifiers, structure_env)

        val identifiers =
          Map.fold_in_rev_order
          (fn (identifiers, funid, _) => (Ident.FUNCTOR funid)::identifiers)
          (identifiers, functor_env)

        val identifiers =
          Map.fold_in_rev_order
          (fn (identifiers, sigid, _) => (Ident.SIGNATURE sigid)::identifiers)
          (identifiers, signature_env)
      in
        identifiers
      end


    (*  === COMPILER ===
     *
     *  This applies each stage of compilation in a straighforward manner.
     *  The only subtlety is the compile_topdec function which is invoked
     *  once or many times depending on the `consume' parameter.
     *)

    datatype source =
      TOKENSTREAM of Lexer.TokenStream |
      TOKENSTREAM1 of Lexer.TokenStream |
      (* the parser basis is an augmentation *)
      TOPDEC of string * Parser.Absyn.TopDec * ParserBasis

    fun compile (info_opts,
                 options as (Options.OPTIONS
                             {listing_options = Options.LISTINGOPTIONS list_opts,
                              compiler_options =
			      Options.COMPILEROPTIONS{generate_debug_info,
                                                      generate_moduler, ...},
                              print_options,
                              compat_options =
                              Options.COMPATOPTIONS{old_definition,...},
                              ...}))
                 require_function
                 (require_value, 
                  BASIS {parser_basis = initial_parser_basis,
                         type_basis = initial_type_basis,
                         lambda_environment = initial_lambda_environment,
                         debugger_environment = initial_debugger_environment,
                         ...}, 
                 making)
                (pervasive, source) =
      let
        (* Record the stamp count at the beginning *)
        val stamp_start = ref (Stamp.read_counter ())

        val (filename, token_stream) =
          case source of
            TOKENSTREAM token_stream =>
	      (Lexer.associated_filename token_stream, SOME token_stream)
          | TOKENSTREAM1 token_stream =>
	      (Lexer.associated_filename token_stream, SOME token_stream)
          | TOPDEC (filename,_,_) => (filename, NONE)

        fun error_wrap arg = Info.wrap info_opts (Info.FATAL, Info.RECOVERABLE, Info.FAULT, Location.FILE filename) arg

        val _ = diagnostic
          (1, fn _ =>
           case source of
             TOKENSTREAM _ => ["Consuming token stream `", filename, "'"]
           | TOKENSTREAM1 _ => ["Consuming one topdec from token stream `", filename, "'"]
           | TOPDEC _ => ["Consuming absyn topdec from source `", filename, "'"])

        val (require_value,
             _, _, _, _,
             parser_basis, type_basis,
             lambda_environment, debugger_environment, lambda_bindings, debug_info,
             signatures, _) =
          let
          (*  == Topdec compiling functions ==
           *
	   *  This scope contains two functions:
	   * 
           *  parse_topdec:
           *    environments * token_stream -> environments * Absyn.Topdec
           *  compile_topdec:
           *    environments * Absyn.Topdec -> environments
	   *
	   *  parse_topdec preserves most of its arguments unchanged, just
	   *  updating the parser_bases.  It has the above type because of
	   *  the way it is used to make an argument for compile_topdec later
	   *  in the file:
           *      fun until_eof environments =
           *        if Parser.Lexer.eof token_stream then
           *          environments
           *        else
           *          until_eof
	   *            (compile_topdec
	   *               (parse_topdec (environments, token_stream)))
           *
           *  Two sets of bases are maintained while compiling topdecs: one
           *  is a `total' which includes all declarations made so far
           *  including those from other modules and the initial basis, the
           *  other is the sum of the topdecs actually compiled here, and
           *  forms the result.
	   *
           *)

            fun compile_topdec ((require_value,
                                 total_parser_basis, total_type_basis, total_lambda_environment, total_debugger_environment,
                                 parser_basis, type_basis, lambda_environment, debugger_environment,
                                 lambda_bindings, debug_info,
                                 signatures, had_topdec),
                                absyn) =
	      (* There are two cases of topdecs.  Require topdecs must occur
		 before all other topdecs in the file.  The had_topdec
		 parameter keeps track of this. *)
              case absyn of
                Absyn.REQUIREtopdec (module, location) =>
		  if had_topdec then
		    Info.error'
		    info_opts
		    (Info.FATAL, location, concat ["Too late for require statement"])
		  else
		    let
		      val (require_value,
			   full_module_name,
			   BASIS {parser_basis = require_parser_basis,
				  type_basis = require_type_basis,
				  lambda_environment = require_lambda_environment,
				  debugger_environment = require_debugger_environment,
				  ...}) =
			require_function (require_value, module, location)

                      val module_expression =
                        LambdaTypes.APP
                        (LambdaTypes.BUILTIN Pervasives.LOAD_STRING,
                         ([LambdaTypes.SCON (Ident.STRING full_module_name, NONE)],[]),
                         NONE)

		      val (require_lambda_environment, require_bindings) =
			LambdaModule.unpack (require_lambda_environment, module_expression)
		    in
                      (* Update counters if another file has been done *)
                      stamp_start := Stamp.read_counter ();

		      (require_value,
		       Parser.augment_pB (total_parser_basis, require_parser_basis),
		       Basis.basis_circle_plus_basis (total_type_basis, require_type_basis),
		       Environ.augment_top_env (total_lambda_environment, require_lambda_environment),
                       Environ.augment_denv (total_debugger_environment,require_debugger_environment),
		       parser_basis,
		       type_basis,
		       lambda_environment,
		       debugger_environment,
		       lambda_bindings @ require_bindings,
		       debug_info,
		       signatures,
		       false)
		    end
              | absyn =>
		    let
		      val topdec_type_basis =
			error_wrap Mod_Rules.check_topdec
			(options,false,absyn, total_type_basis,
			 Mod_Rules.ASSEMBLY(!str_ass, !ty_ass))
		      val (str_ass', ty_ass') =
			Assemblies.compose_assemblies
			(Assemblies.new_assemblies_from_basis topdec_type_basis,
			 (!str_ass, !ty_ass), topdec_type_basis, total_type_basis)
		      val _ = str_ass := str_ass'
		      val _ = ty_ass := ty_ass'
		      (* This gives the same semantics as before *)
		      (* Watch this space for more improvements *)
		      val _ =
			if #show_absyn list_opts then
			  (Info.listing_fn
			   info_opts
			   (3, fn stream => TextIO.output(stream, "The abstract syntax\n"));
			   Info.listing_fn
			   info_opts
			   (3, fn stream =>
			    TextIO.output(stream, 
                           TopdecPrint.topdec_to_string options absyn));
			   Info.listing_fn
			   info_opts
			 (3, fn stream => TextIO.output(stream, "\n"))
			 )
			else ()

		      val result_type_basis =
			Basis.basis_circle_plus_basis
			  (total_type_basis, topdec_type_basis)

		      val (topdec_lambda_environment, topdec_debugger_environment, topdec_lambda_bindings, debug_info) =
			error_wrap
			  Lambda.trans_top_dec
			  (options,absyn, total_lambda_environment, total_debugger_environment,
			   debug_info, result_type_basis, false)
		    in
		      (require_value,
		       total_parser_basis,
		       result_type_basis,
		       Environ.augment_top_env
			 (total_lambda_environment, topdec_lambda_environment),
		       Environ.augment_denv
			 (total_debugger_environment, topdec_debugger_environment),
		       parser_basis,
		       Basis.basis_circle_plus_basis
			 (type_basis, topdec_type_basis),
		       Environ.augment_top_env
			 (lambda_environment, topdec_lambda_environment),
		       Environ.augment_denv
			 (debugger_environment, topdec_debugger_environment),
		       lambda_bindings @ topdec_lambda_bindings,
		       debug_info,
		       extract_signatures (signatures, absyn),
		       true)
		    end

            fun parse_topdec ((require_value,
                               total_parser_basis, total_type_basis, total_lambda_environment, total_debugger_environment,
                               parser_basis, type_basis, lambda_environment, debugger_environment,
                               lambda_bindings, debug_info,
                               signatures, had_topdec),
                              token_stream) =
              let
                val (absyn, topdec_parser_basis) = error_wrap Parser.parse_topdec (options,token_stream, total_parser_basis)
              in
                diagnostic (2, fn _ => ["parsed topdec:\n", 
                                        TopdecPrint.topdec_to_string 
                                        options absyn]);
                ((require_value,
                  Parser.augment_pB (total_parser_basis, topdec_parser_basis),
                  total_type_basis,
                  total_lambda_environment,
                  total_debugger_environment,
                  Parser.augment_pB (parser_basis, topdec_parser_basis),
                  type_basis,
                  lambda_environment,
                  debugger_environment,
                  lambda_bindings,
                  debug_info,
                  signatures,
		  had_topdec),
                 absyn)
              end

            val environments =
              (require_value,
               initial_parser_basis,
               initial_type_basis,
               initial_lambda_environment,
               initial_debugger_environment,
               (case source of
                  TOPDEC(_,_,parserbasis) => parserbasis
                | _ => Parser.empty_pB),
               Basis.empty_basis,
               Environ.empty_top_env,
               Environ.empty_denv,
               [],
               Debugger_Types.empty_information,
               Map.empty' Datatypes.Ident.sigid_lt,
               false)

	    val _ =
	      if pervasive orelse not making then
		() (* Don't add anything if pervasive or use*)
	      else
		let
		  val the_token_list =
		    [Token.RESERVED(Token.REQUIRE),
		     Token.STRING(Io.pervasive_library_name),
		     Token.RESERVED(Token.SEMICOLON)]
		  val token_stream = case token_stream of
		    SOME token_stream => token_stream
		  | _ => Crash.impossible "Non-pervasive make with no stream"
		in
		  app
		  (fn token => Lexer.ungetToken((token,Info.Location.UNKNOWN), token_stream))
		  (rev the_token_list)
		end

          in
            case source of
              TOPDEC (_, absyn,_) =>
		 compile_topdec (environments, absyn)
            | TOKENSTREAM1 token_stream =>
                compile_topdec (parse_topdec (environments, token_stream))
            | TOKENSTREAM token_stream =>
                let
                  fun until_eof environments =
                    if Parser.Lexer.eof token_stream then
                      environments
                    else
                      until_eof (compile_topdec (parse_topdec (environments, token_stream)))
                in
                  until_eof environments
                end
          end

        (* Close the lambda bindings into a single expression to be compiled *)
        (* into the new module. *)

        val stamp_no = Stamp.read_counter () - !stamp_start

        val new_id_cache = ID_CACHE{stamp_start = !stamp_start,
                                    stamp_no = stamp_no}
      in
	  let
	    val (lambda_environment, lambda_expression) =
	      LambdaModule.pack (lambda_environment, lambda_bindings)

	    val _ =
	      if #show_lambda list_opts then
		(Info.listing_fn
		 info_opts
		 (3, fn stream => TextIO.output(stream, "The unoptimised lambda code\n"));
		 Info.listing_fn info_opts
		 (3, fn stream =>
		  LambdaPrint.output_lambda options (stream, lambda_expression)))
	      else ()

	    (* Optimise the lambda expression *)

	    val lambda_expression = LambdaOptimiser.optimise options lambda_expression

	    val _ =
	      if #show_opt_lambda list_opts then
		(Info.listing_fn
		 info_opts
		 (3, fn stream => TextIO.output(stream, "The optimised lambda code\n"));
		 Info.listing_fn info_opts
		 (3, fn stream =>
		  LambdaPrint.output_lambda options (stream, lambda_expression)))
	      else ()

            val lambda_environment = Environ.simplify_topenv (lambda_environment,lambda_expression)

	    val _ =
	      if #show_environ list_opts then
		(Info.listing_fn
		 info_opts
		 (3, fn stream => TextIO.output(stream, "The environment\n"));
		 Info.listing_fn info_opts
		 (3, EnvironPrint.printtopenv print_options lambda_environment);
		 Info.listing_fn
		 info_opts
		 (3, fn stream => TextIO.output(stream, "\n")))
	      else ()

	    (* Generate intermediate code from the lambda expression and *)
	    (* optimise it *)

	    val (mir, debug_info) =
	      error_wrap
	      Mir_Cg.mir_cg
	      (options, lambda_expression, filename, debug_info)
	    val _ =
	      if #show_mir list_opts then
		(Info.listing_fn
		 info_opts
		 (3, fn stream => TextIO.output(stream, "The unoptimised intermediate code\n"));
		 Info.listing_fn info_opts (3, MirPrint.print_mir_code mir))
	      else
		()

	    val mir = MirOptimiser.optimise (mir,generate_debug_info)
	    val _ =
	      if #show_opt_mir list_opts then
		(Info.listing_fn
		 info_opts
		 (3, fn stream => TextIO.output(stream, "The optimised intermediate code\n"));
		 Info.listing_fn info_opts (3, MirPrint.print_mir_code mir))
	      else
		()

	    (* Generate the module machine code from the MIR *)

	    val ((code, debug_info), code_list_list) =
	      let
		val {gc, non_gc, fp} = MirOptimiser.machine_register_assignments
	      in
		error_wrap
		Mach_Cg.mach_cg
		(options, mir, (gc, non_gc, fp), debug_info)
	      end
	    val _ =
	      if #show_mach list_opts then
		(Info.listing_fn
		 info_opts
		 (3, fn stream => TextIO.output(stream, "The final machine code\n"));
		 Info.listing_fn info_opts (3, MachPrint.print_mach_code code_list_list))
	      else
		()

	  in
	    (require_value,
	     RESULT {basis = BASIS {parser_basis = parser_basis,
				    type_basis = type_basis,
				    lambda_environment = lambda_environment,
				    debugger_environment = debugger_environment,
				    debug_info = debug_info},
		     signatures = signatures,
                     id_cache = new_id_cache,
		     code = SOME code})
	  end
      end

  end
