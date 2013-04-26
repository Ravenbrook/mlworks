(*  ==== COMPILER INTERFACE ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  This code packages up all stages of the compiler into a single
 *  interface.  See the comments in the signature for details.
 *
 *  Diagnostics (those in brackets are lies)
 *  -----------
 *    0  none
 *    1  displays a message on invocation
 *    2  displays the abstract syntax and optimised lambda
 *    3  (displays the optimised MIR code)
 *    4  (displays the machine code)
 *    5  displays the unoptimised lambda (and unoptimised MIR code)
 *
 *  Revision Log
 *  ------------
 *  $Log: compiler.sml,v $
 *  Revision 1.39  1997/05/01 12:44:03  jont
 *  [Bug #30088]
 *  Get rid of MLWorks.Option
 *
 * Revision 1.38  1996/03/18  15:42:29  daveb
 * Removed the identifiers field from the Compiler.result type.  This information
 * can be synthesised from the type basis.
 *
 * Revision 1.37  1996/02/23  17:38:16  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.36  1995/12/27  14:11:40  jont
 * Removing Option in favour of MLWorks.Option
 *
 *  Revision 1.35  1995/11/22  09:48:03  daveb
 *  Changed type Absyn.ModuleId to a local ModuleId type.
 *
 *  Revision 1.34  1995/07/13  11:37:06  matthew
 *  Moving Compiler.identifier type to Ident
 *
 *  Revision 1.33  1995/03/30  16:33:38  matthew
 *  Change Tyfun_id etc to Stamp
 *
 *  Revision 1.32  1995/03/03  11:18:46  daveb
 *  Added dummy identifier value.
 *
 *  Revision 1.31  1994/06/22  14:51:54  jont
 *  Update debugger information production
 *
 *  Revision 1.30  1994/06/17  13:19:16  daveb
 *  Added compare_identifiers and empty_basis.
 *
 *  Revision 1.29  1994/03/18  14:30:44  matthew
 *  Added add_debug_info function
 *
 *  Revision 1.28  1994/02/28  07:31:04  nosa
 *  Debugger environments for Modules Debugger.
 *
 *  Revision 1.27  1994/02/25  15:52:36  daveb
 *  Adding clear_debug functionality.
 *
 *  Revision 1.26  1994/01/26  18:04:54  matthew
 *  Simplification
 *
 *  Revision 1.25  1994/01/06  14:43:26  matthew
 *  Export extract_identifiers
 *  Added id_cache type (what a terrible name!) to record information about tyname_id's etc.
 *
 *  Revision 1.24  1993/09/07  16:34:08  jont
 *  Changed type of compile to indicate whether the file in question is pervasive
 *
 *  Revision 1.23  1993/07/30  14:52:06  daveb
 *  compile now takes a moduleid instead of a string.
 *
 *  Revision 1.22  1993/07/29  14:24:08  nosa
 *  structure Option.
 *
 *  Revision 1.21  1993/07/06  10:33:11  daveb
 *  Removed EXCEPTION identifier class.
 *
 *  Revision 1.20  1993/05/12  15:42:47  jont
 *  Changed signature to allow list of modules compiled to be passed in
 *  and returned by compile
 *
 *  Revision 1.19  1993/04/26  16:24:46  jont
 *  Added remove_str for getting rid of FullPervasiveLibrary_ from initial env
 *
 *  Revision 1.18  1993/04/02  13:27:15  matthew
 *  Removed Debugger_Types
 *
 *  Revision 1.17  1993/03/17  12:11:57  matthew
 *  Added parserbasis field to source type
 *
 *  Revision 1.16  1993/03/11  13:08:20  matthew
 *  Signature revisions
 *
 *  Revision 1.15  1993/03/09  13:51:00  matthew
 *  Options & Info changes
 *  Removed Parser and BasisTypes from signature
 *
 *  Revision 1.14  1993/02/09  10:01:20  matthew
 *  Typechecker structure changes
 *
 *  Revision 1.13  1993/02/04  13:29:01  matthew
 *  Changed sharing.
 *
 *  Revision 1.12  1992/12/09  12:39:02  clive
 *  Added some sharing
 *
 *  Revision 1.11  1992/12/08  20:40:30  jont
 *  Removed a number of duplicated signatures and structures
 *
 *  Revision 1.10  1992/12/02  18:02:21  daveb
 *  Added a sharing constraint
 *
 *  Revision 1.9  1992/12/01  12:38:11  daveb
 *  Changes to propagate compiler options as parameters instead of references.
 *
 *  Revision 1.8  1992/11/26  17:08:43  clive
 *  Added clear_debug_info function
 *
 *  Revision 1.7  1992/11/21  15:44:41  clive
 *  Changed the result type to allow the code to be deleted
 *
 *  Revision 1.6  1992/11/20  15:31:58  jont
 *  Modified sharing constraints to remove superfluous structures
 *
 *  Revision 1.5  1992/11/19  14:23:56  clive
 *  Added a few debug_info functions
 *
 *  Revision 1.4  1992/11/04  15:16:50  matthew
 *  Changed Error structure to Info
 *
 *  Revision 1.3  1992/10/14  12:09:26  richard
 *  Added location information to the `require' topdec and passed
 *  this through to the require function passed to compile.
 *
 *  Revision 1.2  1992/10/08  11:26:56  richard
 *  Added a source type to compile.
 *
 *  Revision 1.1  1992/10/07  15:41:48  richard
 *  Initial revision
 *
 *)

require "../utils/diagnostic";
require "../utils/map";
require "../main/info";
require "../main/options";
require "../basics/absyn";
require "pervasives";

signature COMPILER =
  sig
    structure Info              : INFO
    structure Absyn     	: ABSYN
    structure Pervasives	: PERVASIVES
    structure Diagnostic	: DIAGNOSTIC
    structure Options           : OPTIONS
    structure NewMap            : MAP

    sharing Info.Location = Absyn.Ident.Location

    (*  === COMPILER BASIS ===
     *
     *  A compiler basis encapsulates all the information needed to compile
     *  in the presence of some declarations.  In a sense it is the
     *  `interface' to declarations which have occured earlier or in other
     *  modules.
     *)

    type Top_Env (* EnvironTypes.Top_Env *)
    type DebuggerEnv (* EnvironTypes.DebuggerEnv *)
    type LambdaExp (* LambdaTypes.LambdaExp *)
    type Module  (* was MachTypes.Module *)
    type DebugInformation (* was Debugger_Types.information *)
    type TypeBasis
    type ParserBasis

    datatype basis =
      BASIS of {parser_basis		: ParserBasis,
                type_basis		: TypeBasis,
                lambda_environment	: Top_Env,
                debugger_environment	: DebuggerEnv,
                debug_info		: DebugInformation}

    val augment : Options.options * basis * basis -> basis
    val adjust_compiler_basis_debug_info : basis * DebugInformation -> basis
    val get_basis_debug_info : basis -> DebugInformation
    val clear_debug_info : string * basis -> basis
    val clear_debug_all_info : basis -> basis
    val make_external : basis -> basis
    val add_debug_info : Options.options * DebugInformation * basis -> basis

    (*  == Initial bases ==
     *
     *  initial_basis is a compiler basis which contains only the builtin
     *  declarations for primitives (but not all standard pervasives).  It
     *  should be used as the starting point for compiling normal ML.
     *
     *  initial_basis_for_builtin_library is a special compiler basis for
     *  compiling the builtin library module.  It does not contain bindings
     *  for much except that which cannot be declared, and the call_c
     *  interface function.
     *
     *  builtin_lambda_environment is the lambda environment which replaces
     *  that resulting from compiling the builtin library in order that the
     *  compiler recognise its contents as primitives.
     *)

    val empty_basis	: basis
    val initial_basis	: basis
    val initial_basis_for_builtin_library : basis
    val builtin_lambda_environment : Top_Env


    (*  == Compilation result ==
     *
     *  The compile function returns a compilation `result' consisting of:
     *
     *    basis		the basis which defines the new declarations (but
     *            	does not include the initial basis -- it is a
     *            	`delta')
     *    signatures	a mapping from new signature identifiers to their
     *            	abstract syntax, for information purposes
     *	  code		the machine code for the module
     *)

    val extract_identifiers : Absyn.Ident.Identifier list * TypeBasis -> Absyn.Ident.Identifier list

    datatype id_cache = ID_CACHE of {stamp_start:int,
                                     stamp_no:int}

    datatype result =
      RESULT of {basis		: basis,
                 signatures	: (Absyn.Ident.SigId, Absyn.SigExp) NewMap.map,
                 code		: Module option,
                 id_cache       : id_cache}

    (*  === COMPILER ===
     *
     *  The compiler consumes source code in the environment supplied by the
     *  basis parameter, returning a compilation result (see above).
     *
     *  Source code is taken from a source type with the following
     *  constructors:
     *    TOKENSTREAM  an entire token stream
     *    TOKENSTREAM1 a single topdec from the token stream
     *    TOPDEC       a topdec of abstract syntax (with associated source name)
     *
     *  In the compile function takes a function which is invoked if a
     *  `require' topdec is encountered.  This function should map the
     *  module name parameter of the require into a compiler basis for that
     *  module, which is the incorporated into the compilation (but does not
     *  appear in the result).  The 'a parameter to the require function is
     *  threaded through so that it can cache information, and this cache is
     *  also returned as part of the compilation result.
     *)

    type tokenstream

    datatype source =
      TOKENSTREAM of tokenstream |
      TOKENSTREAM1 of tokenstream |
      (* the ParserBasis is an augmentation *)
      TOPDEC of string * Absyn.TopDec * ParserBasis

    val compile :
      Info.options *
      Options.options ->
      ('a * string * Info.Location.T ->
       'a * string * basis) ->
      'a * basis * bool ->
      (bool * source) ->
      'a * result

    val remove_str : basis * Absyn.Ident.StrId -> basis
  end
