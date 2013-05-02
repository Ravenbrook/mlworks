(*  ==== INCREMENTAL COMPILER ====
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
 *  Description
 *  -----------
 *  The incremental compiler allows individual topdecs to be compiled in a
 *  context, yielding a new context.  Each topdec may refer to items
 *  previously compiled in a context.
 *
 *  Revision Log
 *  ------------
 *  $Log: incremental.sml,v $
 *  Revision 1.69  1998/01/29 16:18:50  johnh
 *  [Bug #30071]
 *  Merge in Project Workspace changes.
 *
 * Revision 1.67.2.5  1997/12/03  12:12:43  daveb
 * [Bug #30017]
 * Rationalised Shell/GUI Project commands:
 * Moved check_mo to ShellUtils, ditto for Project manipulation part of
 * load_mo.  Left the core part as load_mos, which loads all files in a list.
 *
 * Revision 1.67.2.4  1997/12/02  16:38:42  daveb
 * [Bug #30071]
 * Removed functions for loading from source files.
 *
 * Revision 1.67.2.3  1997/11/26  11:47:51  daveb
 * [Bug #30071]
 * match_{source,object}_path are no longer needed.
 *
 * Revision 1.67.2.2  1997/11/11  16:14:00  johnh
 * [Bug #30203]
 * Merging - checking files to be recompiled.
 *
 * Revision 1.67.2.1  1997/09/11  20:54:51  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.68  1997/09/17  15:50:08  brucem
 * [Bug #30203]
 * make check_mo (and check_module) return module ids.
 *
 * Revision 1.67  1997/05/01  12:39:22  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.66  1996/07/02  09:40:06  daveb
 * Bug 1448/Support Call 35: Added remove_file_info to project and incremental,
 * and called it from _save_image.
 *
 * Revision 1.65  1996/05/03  09:16:32  daveb
 * Removed Error exception.  The project is updated locally in the case of
 * errors.
 *
 * Revision 1.64  1996/04/02  11:34:05  daveb
 * Added read_dependencies.
 *
 * Revision 1.63  1996/03/26  09:43:45  daveb
 * Added match_source_path and match_object_path, which do some of the work
 * that Module.with_source_path used to do, plus checking for attempts to use
 * different files with the same unit name.
 * Changed type of some other functions for use with these new ones.
 *
 * Revision 1.62  1996/03/19  12:17:27  daveb
 * Added check_mo.
 *
 * Revision 1.61  1996/03/18  17:29:36  daveb
 * Changed load_mo and add_module return a Result option.
 *
 * Revision 1.60  1996/03/14  17:28:28  daveb
 * Added preload function.
 *
 * Revision 1.59  1996/02/23  17:53:37  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.58  1995/12/11  15:18:20  daveb
 * Reversing previous change.
 *
 *  Revision 1.57  1995/12/11  10:12:58  daveb
 *  Added debugging_options.
 *
 *  Revision 1.56  1995/12/06  17:47:10  daveb
 *  Reinstated delete_module and delete_all_modules.
 *
 *  Revision 1.55  1995/11/29  10:32:26  daveb
 *  Modifications to use new project stuff.
 *
 *  Revision 1.54  1995/07/13  12:00:07  matthew
 *  Moved identifier to Ident
 *
 *  Revision 1.53  1995/06/01  16:18:20  matthew
 *  Adding delete_all_modules
 *
 *  Revision 1.52  1995/03/30  13:21:22  matthew
 *  Adding delete all modules function
 *
 *  Revision 1.51  1995/03/02  12:49:39  daveb
 *  Merged identifier list into Result type.
 *
 *  Revision 1.50  1994/08/09  14:46:55  daveb
 *  Renamed SourceResult to Result, and added comments.
 *
 *  Revision 1.49  1994/07/28  14:56:29  daveb
 *  Made load_mo return a SourceResult value.
 *
 *  Revision 1.48  1994/07/19  17:35:23  daveb
 *  Changed add_module to return a SourceResult.  Added check_module.
 *
 *  Revision 1.47  1994/06/22  15:00:54  jont
 *  Update debugger information production
 *
 *  Revision 1.46  1994/06/21  16:15:05  daveb
 *  Added empty context (initial contexts aren't empty).
 *  Changed Context components of Error and Interrupted exceptions to a set
 *  of new modules, so that the user_context can be updated appropriately.
 *  Added update_modules to aid this task.
 *
 *  Revision 1.45  1994/05/06  16:20:12  jont
 *  Add function to give parser basis from source result
 *
 *  Revision 1.44  1994/03/25  16:22:30  daveb
 *  Changed add_module and delete_module and load_mo to take ModuleIds.
 *
 *  Revision 1.43  1994/03/18  14:26:42  matthew
 *  Added add_debug_info
 *  add_module returns file list
 *
 *  Revision 1.42  1994/02/25  15:50:12  daveb
 *  Adding clear_debug functionality.
 *
 *  Revision 1.41  1994/02/01  16:50:15  daveb
 *   _add_module now takes a MOdule argument instead of a file name.
 *
 *  Revision 1.40  1994/01/28  16:27:12  matthew
 *  Improvements to error locations
 *
 *  Revision 1.39  1994/01/06  16:04:03  matthew
 *  Added load_mo functions
 *
 *  Revision 1.38  1993/08/12  16:18:56  daveb
 *  Changed types of delete_module and add_module to take strings (representing
 *  moduleids) instead of filenames.
 *
 *  Revision 1.37  1993/07/29  15:28:19  matthew
 *  Added Interrupted exception to indicate if a make was interrupted.
 *
 *  Revision 1.36  1993/06/04  15:56:01  daveb
 *  Deleted the name component of the context type.
 *
 *  Revision 1.35  1993/05/26  17:11:54  matthew
 *  Added error_info param to eval_exp_topdec
 *
 *  Revision 1.34  1993/05/14  12:23:39  jont
 *  Signature clean up
 *
 *  Revision 1.33  1993/05/12  10:27:20  matthew
 *  Exported NotAnExpression
 *
 *  Revision 1.32  1993/05/11  12:46:25  matthew
 *  Added error list to Error exception
 *
 *  Revision 1.31  1993/05/10  14:08:47  daveb
 *  Removed error_info field from ListenerArgs, ShellData and Incremental.options
 *
 *  Revision 1.30  1993/05/06  13:44:47  matthew
 *  Removed name_monitor field
 *  Added monitor function parameter to add_module
 *
 *  Revision 1.29  1993/04/02  13:40:33  matthew
 *  Signature changes
 *  Added evaluate_exp_topdec function
 *
 *  Revision 1.28  1993/03/29  17:48:15  matthew
 *  Removed string param from debugger field in options
 *
 *  Revision 1.27  1993/03/26  16:05:37  jont
 *  Removed get_pervasive_dir, using one in io instead
 *
 *  Revision 1.26  1993/03/19  11:09:19  matthew
 *  Replaced add_source with compile_source and add_definitions
 *
 *  Revision 1.25  1993/03/17  12:10:39  matthew
 *  Formatting changes
 *
 *  Revision 1.24  1993/03/11  13:10:35  matthew
 *  Signature revisions
 *
 *  Revision 1.23  1993/03/09  15:00:13  matthew
 *  Options & Info changes
 *  Changed context to Context
 *
 *  Revision 1.22  1993/02/19  18:48:05  jont
 *  put get_pervasive_dir in the signature of incremental
 *
 *  Revision 1.21  1993/02/09  10:22:06  matthew
 *  Typechecker structure changes
 *
 *  Revision 1.20  1993/02/04  13:16:08  matthew
 *  Signature changes.
 *
 *  Revision 1.19  1992/12/18  10:06:40  clive
 *  We also pass the current module forward for the source_displayer
 *
 *  Revision 1.18  1992/12/09  12:41:46  clive
 *  Added find_module
 *
 *  Revision 1.17  1992/12/08  20:53:21  jont
 *  Removed a number of duplicated signatures and structures
 *
 *  Revision 1.16  1992/12/03  20:25:35  daveb
 *  Added a sharing constraint.
 *
 *  Revision 1.15  1992/12/03  11:43:46  clive
 *  Added delete_module
 *
 *  Revision 1.14  1992/12/02  17:22:49  daveb
 *  Changes to propagate compiler options as parameters instead of references.
 *
 *  Revision 1.13  1992/11/26  17:03:42  clive
 *  Added clear_debug_info function
 *
 *  Revision 1.12  1992/11/20  16:17:37  jont
 *  Modified sharing constraints to remove superfluous structures
 *
 *  Revision 1.11  1992/11/17  17:01:47  matthew
 *  Changed Error structure to Info
 *
 *  Revision 1.10  1992/11/12  10:02:46  daveb
 *  Added env function to extract the environment from a context.
 *
 *  Revision 1.9  1992/10/26  17:56:19  clive
 *  Got exit working, and passed through enough for debugger to bind frame arguments to it
 *  on invoking a sub-shell
 *
 *  Revision 1.8  1992/10/20  12:27:57  richard
 *  Added an Error exception to allow add_module to return a partially
 *  augmented context in the case of an error during make.
 *
 *  Revision 1.7  1992/10/16  11:05:41  clive
 *  Changes for windowing listener
 *
 *  Revision 1.6  1992/10/14  15:07:51  richard
 *  Incorporated the make system.
 *
 *  Revision 1.5  1992/10/08  11:32:27  richard
 *  Changed add_topdec to add_source of compiler source type.
 *
 *  Revision 1.4  1992/10/08  08:16:12  richard
 *  Added return of identifiers from add_value and add_structure.
 *
 *  Revision 1.3  1992/10/07  15:42:08  richard
 *  The incremental compiler now uses the generalised Compiler structure.
 *
 *  Revision 1.2  1992/10/06  14:15:00  richard
 *  Removed add_source_file as this doesn't express the idea of `use' properly.
 *
 *  Revision 1.1  1992/10/01  17:19:28  richard
 *  Initial revision
 *
 *)

require "intermake";
require "../typechecker/datatypes";
require "../utils/diagnostic";

signature INCREMENTAL =
  sig
    structure InterMake		: INTERMAKE
    structure Diagnostic	: DIAGNOSTIC
    structure Datatypes         : DATATYPES

    sharing InterMake.Compiler.Absyn.Ident = Datatypes.Ident
    sharing InterMake.Compiler.NewMap = Datatypes.NewMap

    type ModuleId

    datatype Context =
      CONTEXT of
	{topdec	 : int,
         compiler_basis : InterMake.Compiler.basis,
         inter_env      : InterMake.Inter_EnvTypes.inter_env,
         signatures	: (InterMake.Compiler.Absyn.Ident.SigId,
                           InterMake.Compiler.Absyn.SigExp) Datatypes.NewMap.map}

    datatype options =
      OPTIONS of
      {options	: InterMake.Inter_EnvTypes.Options.options,
       debugger	: (MLWorks.Internal.Value.T -> MLWorks.Internal.Value.T) ->
                  (MLWorks.Internal.Value.T -> MLWorks.Internal.Value.T)}

    (* The interpreter maintains a global Project value that stores
       information about compilation units, including the results of
       interactive compilations.  The get_project function allows this
       to be manipulated by the user interface. *)
    val get_project 	: unit -> InterMake.Project
    val set_project 	: InterMake.Project -> unit
    val reset_project	: unit -> unit
    val delete_from_project : ModuleId -> unit

    val remove_file_info : unit -> unit

    (* Compilation Managers and similar tools may register update functions
       to be called whenever set_project is called. *)
    type register_key
    val add_update_fn : (unit -> unit) -> register_key
    val remove_update_fn : register_key -> unit

    val empty_context	: Context
    val initial		: Context       (* Initial context *)

    val clear_debug_info        : string * Context -> Context
    val clear_debug_all_info    : Context -> Context

    val add_debug_info          : InterMake.Inter_EnvTypes.Options.options * InterMake.Compiler.DebugInformation * Context -> Context

    val topdec			: Context -> int
    val compiler_basis		: Context -> InterMake.Compiler.basis
    val parser_basis		: Context -> InterMake.Compiler.ParserBasis
    val type_basis		: Context -> InterMake.Compiler.TypeBasis
    val lambda_environment	: Context -> InterMake.Compiler.Top_Env
    val debug_info		: Context -> InterMake.Compiler.DebugInformation
    val inter_env		: Context -> InterMake.Inter_EnvTypes.inter_env
    val signatures		: Context -> (InterMake.Compiler.Absyn.Ident.SigId, InterMake.Compiler.Absyn.SigExp) InterMake.Compiler.NewMap.map
    val env			: Context -> Datatypes.Env

    (* The Result type provides a uniform interface for the result of
       compiling source interactively (as done by the use command,
       a listener or an evaluator), making a module in the interpreter,
       and loading an mo file into the interpreter.  A value of this
       type contains the objects defined by the source or module.
       add_definitions must be used to add these objects to a context. *)
    type Result

    val identifiers_from_result: Result -> InterMake.Compiler.Absyn.Ident.Identifier list
    val pb_from_result: Result -> InterMake.Compiler.ParserBasis

    val compile_source :
      InterMake.Compiler.Info.options ->
      options * Context * InterMake.Compiler.source ->
      Result

    exception NotAnExpression

    val evaluate_exp_topdec :
       InterMake.Compiler.Info.options ->
      (options * Context * InterMake.Compiler.Absyn.TopDec) ->
      (MLWorks.Internal.Value.T * Datatypes.Type)

    val add_definitions :
      InterMake.Inter_EnvTypes.Options.options * Context * Result -> Context

    val load_mos :
      InterMake.Compiler.Info.options
      -> InterMake.Inter_EnvTypes.Options.options * Context *
	 InterMake.Project * ModuleId * ModuleId list *
	 InterMake.Compiler.Info.Location.T
      -> Result option

    (* Incremental now uses a global reference of type InterMake.Project
       to store compiled compilation units.  So the following functions
       no longer take a context argument. *)

    val read_dependencies :
          string -> InterMake.Compiler.Info.options -> ModuleId -> unit
    (* read_dependencies toplevel_name error_info module_id; recursively
       reads the dependency information for module_id. *)

    val delete_module : InterMake.Compiler.Info.options -> ModuleId -> unit

    val delete_all_modules : bool -> unit

    val check_module :
      InterMake.Compiler.Info.options -> ModuleId * string -> ModuleId list

    (*
    val preload : Context * string -> unit
    val get_preload : unit -> Result
    (* preload (c, s); this takes a module name and loads that module
       (and all its dependencies) from source in such a way that the
       compiled code is shared with the compiler itself.  The result is
       stored, and can be accessed by getPreload.  Preload must be
       called before the user's image is saved, e.g. in xinterpreter. *)
    *)

    val add_value :
      Context * string * Datatypes.Typescheme * MLWorks.Internal.Value.T ->
      Context * InterMake.Compiler.Absyn.Ident.Identifier list

    val add_structure :
      Context * string * Datatypes.Structure * MLWorks.Internal.Value.T ->
      Context * InterMake.Compiler.Absyn.Ident.Identifier list
  end;
