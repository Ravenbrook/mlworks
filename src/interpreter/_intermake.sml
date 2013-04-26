(*  ==== INTERPRETER MAKE SYSTEM ====
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: _intermake.sml,v $
 *  Revision 1.112  1998/04/22 17:09:07  jont
 *  [Bug #70091]
 *  removing req_name from consistency info
 *
 * Revision 1.111  1998/01/29  15:00:02  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.110  1997/11/25  10:30:50  jont
 * [Bug #30328]
 * Add environment parameter to decode_type_basis
 * for finding pervasive type names
 *
 * Revision 1.109  1997/10/20  17:35:43  jont
 * [Bug #30089]
 * Remove use of OldOs.mtime in favour of OsFileSys.modTime
 *
 * Revision 1.108  1997/10/10  17:47:27  daveb
 * [Bug #20090]
 * Projects now store the time stamps of object files in the loaded info,
 * instead of their modification times.
 *
 * Revision 1.107.2.6  1997/11/26  15:16:12  daveb
 * [Bug #30071]
 *
 * Revision 1.107.2.5  1997/11/20  16:58:04  daveb
 * [Bug #30326]
 *
 * Revision 1.107.2.4  1997/10/29  13:53:34  daveb
 * [Bug #30089]
 * Merged from trunk:
 * Remove use of OldOs.mtime in favour of OsFileSys.modTime
 *
 * Revision 1.107.2.3  1997/10/29  11:58:49  daveb
 * [Bug #20090]
 * Merged from trunk:
 * Projects now store the time stamps of object files in the loaded info,
 * instead of their modification times.
 *
 * Revision 1.107.2.2  1997/09/17  15:52:41  daveb
 * [Bug #30071]
 * Converted build system to project workspace.
 *
 * Revision 1.107.2.1  1997/09/11  20:55:00  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.107  1997/05/28  10:44:56  daveb
 * [Bug #30090]
 * Converted lexer to Basis IO.
 *
 * Revision 1.106  1997/05/12  16:15:18  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.105  1997/05/07  14:51:30  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.104  1997/04/09  16:30:33  jont
 * [Bug #2040]
 * Make InterMake.load take an options argument
 *
 * Revision 1.103  1997/03/21  10:41:53  johnh
 * [Bug #1965]
 * Added a comment about an unhandled NotSet exception in commented code.
 *
 * Revision 1.102  1996/10/30  12:26:57  io
 * moving String from toplevel
 *
 * Revision 1.101  1996/08/14  11:42:09  daveb
 * [Bug #1220]
 * Made compile' load an object file if no source file is available.
 *
 * Revision 1.100  1996/08/13  16:41:33  jont
 * [bug: 1543]
 * Sort out problems mixing loadObject and loadSource
 *
 * Revision 1.99  1996/08/06  14:28:44  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_scheme.sml and _types.sml
 *
 * Revision 1.98  1996/07/19  14:36:23  jont
 * Add control of printing of compilation messages
 *
 * Revision 1.97  1996/05/30  12:55:08  daveb
 * The Io exception is no longer at top level.
 *
 * Revision 1.96  1996/05/16  10:34:23  daveb
 * Marked every loaded module not visible, until it is explicitly added to the
 * context by code elsewhere.  (Fixes bug 1337).
 *
 * Revision 1.95  1996/05/03  09:15:06  daveb
 * Removed Interrupted and Error exceptions.
 * The load and load' functions side-effect their project arguments instead
 * of returning an updated value.
 *
 * Revision 1.94  1996/05/01  09:43:41  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.93  1996/03/26  13:00:16  stephenb
 * Change any use of Os/OS to OldOs/OLD_OS to emphasise that it is using
 * the deprecated OS interface.
 *
 * Revision 1.92  1996/03/26  11:49:16  daveb
 * Removed unnecessary verbosity.
 *
 * Revision 1.91  1996/03/19  16:20:53  daveb
 * Got rid of the "hacked up mini module naming system".
 *
 * Revision 1.90  1996/03/18  16:09:55  daveb
 * Removed the identifiers field from the Compiler.result type.  This information
 * can be synthesised from the type basis.
 *
 * Revision 1.89  1996/03/14  16:17:18  daveb
 * Added get_mo_information (again) and get_src_information.
 * Reduced amount of information stored in projects for loaded units.
 *
 * Revision 1.88  1996/03/11  17:30:02  daveb
 * Changed test for pervasive modules in compile: instead of testing whether
 * the list of preloaded modules is NONE, is uses ModuleId.is_pervasive.
 *
 * Revision 1.87  1996/03/04  17:16:07  daveb
 * Changed information stored in project for loaded compilation units.
 *
 * Revision 1.86  1995/12/27  14:55:02  jont
 * Removing Option in favour of MLWorks.Option
 *
 *  Revision 1.85  1995/12/11  16:46:06  daveb
 *  Now passes debug info around as accumulated info instead of a basis.
 *
 *  Revision 1.84  1995/11/29  14:55:15  daveb
 *  Changed to use projects.
 *
 *  Revision 1.83  1995/07/28  16:13:37  matthew
 *  Improving error message for being unable to find an mo file.
 *
 *  Revision 1.82  1995/07/28  12:01:16  matthew
 *  Improving load_mo errors
 *
 *  Revision 1.81  1995/04/28  15:30:59  jont
 *  New module naming stuff
 *
 *  Revision 1.80  1995/04/20  14:04:16  jont
 *  Change type of decode_type_basis to take a btree
 *
 *  Revision 1.79  1995/03/24  16:24:02  matthew
 *  Change Tyfun_id etc to Stamp
 *
 *  Revision 1.78  1995/02/14  13:26:56  matthew
 *  Changes to Debugger_Types and CompilerOptions
 *
 *  Revision 1.77  1995/01/30  16:08:46  daveb
 *  Replaced UNIX-specific pathname mangling.
 *
 *  Revision 1.76  1995/01/30  11:26:25  matthew
 *  Changes to type of Encapsulate.decode_type_basis
 *
 *  Revision 1.75  1995/01/17  14:55:10  daveb
 *  Replaced Option structure with references to MLWorks.Option.
 *
 *  Revision 1.74  1994/12/08  17:53:23  jont
 *  Move OS specific stuff into a system link directory
 *
 *  Revision 1.73  1994/12/07  11:37:00  matthew
 *  Changing uses of cast
 *
 *  Revision 1.72  1994/10/13  15:34:38  matthew
 *  Make NewMap return pervasive option
 *
 *  Revision 1.71  1994/07/26  10:12:25  daveb
 *  Removed code from the results of a load.  The necessary information is
 *  in the module.  This saves 240K of unnecessary pervasive code in the
 *  motif image.  Also removed inter_env component of Result type.
 *
 *  Revision 1.70  1994/06/22  15:16:08  jont
 *  Update debugger information production
 *
 *  Revision 1.69  1994/06/21  14:14:29  matthew
 *  Catch user exceptions raised during Interload.load
 *
 *  Revision 1.68  1994/04/13  12:59:18  jont
 *  Fix require file names in consistency info.
 *  Ensure canonical module names are used in the internal tables,
 *   and placed in saved mo files.
 *
 *  Revision 1.67  1994/04/08  10:01:51  jont
 *  Add original require file names to consistency info.
 *
 *  Revision 1.66  1994/03/25  17:21:33  daveb
 *  Changed make and delete_module to take module ids.
 *
 *  Revision 1.65  1994/03/17  17:06:38  matthew
 *  Changes to the way dependency checking works.
 *
 *  Revision 1.64  1994/03/16  12:55:59  matthew
 *  Changed name of pervasive stream to <Pervasive> (helps with debug info)
 *
 *  Revision 1.63  1994/03/14  10:48:35  matthew
 *  Reinstated load_time in Result
 *  Dependencies also contain load_time value
 *  I don't think it is broken any more.
 *
 *  Revision 1.62  1994/03/07  14:15:52  matthew
 *  Use action_required to determine if recompilation is necessary in function check
 *  rather than the times.
 *
 *  Revision 1.61  1994/02/22  11:47:59  nosa
 *  Deleted compiler option debug_polyvariables in Debugger_Types.INFO;
 *  Debugger environments for Modules Debugger.
 *
 *  Revision 1.60  1994/02/08  14:34:08  matthew
 *  get_mo_file makes an error if the file can't be found
 *  Don't return the file itself and the pervasive library when getting the dependencies
 *
 *  Revision 1.59  1994/02/01  17:00:33  daveb
 *  make now takes a MOdule argument instead of a file name argument.
 *
 *  Revision 1.58  1994/01/28  16:21:47  matthew
 *  Better locations in error messages
 *
 *  Revision 1.57  1994/01/26  18:18:56  matthew
 *  Numerous changes and simplifications:
 *  Removed load_time
 *  Made various accumulators refs within make
 *  Simplified interface to compiler.
 *
 *  Revision 1.56  1994/01/10  17:02:07  matthew
 *  Fixed a non-exhaustive binding.
 *
 *  Revision 1.55  1994/01/10  14:35:29  matthew
 *  Added functions for reading mo type information.
 *  Added functions for writing out type information from interpreter.
 *
 *  Revision 1.54  1993/12/23  12:35:24  daveb
 *  Changed error message for non-existent modules.
 *
 *  Revision 1.53  1993/12/16  15:04:06  daveb
 *  Removed EnvironPrint parameter.
 *
 *  Revision 1.52  1993/12/15  15:08:03  matthew
 *  Renamed Encapsulate.Basistypes to Encapsulate.BasisTypes
 *
 *  Revision 1.51  1993/11/18  13:22:04  jont
 *  Changed to make the consistency information correct when mo files are
 *  saved from the interpreter. Part of ongoing work to make them fully
 *  fledged mo files.
 *
 *  Revision 1.50  1993/11/15  14:09:54  nickh
 *  New pervasive time structure.
 *
 *  Revision 1.49  1993/11/10  15:35:17  daveb
 *  Removed an extraneous parameter from check.
 *
 *  Revision 1.48  1993/10/13  16:26:10  daveb
 *  Ensured __pervasive_library entries in dependency lists are treated as
 *  pervasive.
 *
 *  Revision 1.47  1993/10/06  11:45:45  jont
 *  Added save function for writing out .mo files
 *
 *  Revision 1.46  1993/09/27  08:34:49  nosa
 *  Deleted output message.
 *
 *  Revision 1.45  1993/09/23  11:23:40  nosa
 *  Record compiler option debug_polyvariables in Debugger_Types.INFO
 *  for recompilation purposes.
 *
 *  Revision 1.44  1993/09/02  17:08:22  matthew
 *  Merging in bug fixes
 *
 *  Revision 1.43.1.2  1993/09/01  15:03:26  matthew
 *  Added with_debug_information and current_debug_information to
 *  control global debug information.
 *
 *  Revision 1.43  1993/08/28  17:49:13  daveb
 *  FileName.find_sml now takes a filename cache.
 *
 *  Revision 1.42  1993/08/26  11:22:16  daveb
 *  FileName.find_file has been replaced with FileName.find_sml.
 *
 *  Revision 1.41  1993/08/25  14:16:45  daveb
 *  ModuleId.from_string now takes a location parameter.
 *  Io.get_pervasive_dir can raise Io.NotSet.
 *
 *  Revision 1.40  1993/08/17  16:53:41  daveb
 *  Major changes: to use ModuleIds and search path.
 *
 *  Revision 1.39  1993/08/10  11:34:37  matthew
 *  Added missing Interrupt handlers.
 *
 *  Revision 1.38  1993/07/30  14:40:27  nosa
 *  structure Option.
 *
 *  Revision 1.37  1993/07/29  15:59:19  matthew
 *  Changed some unknown locations to file locations
 *  Added Interrupted exception to indicate if a make was interrupted.
 *
 *  Revision 1.36  1993/06/16  13:17:13  matthew
 *  delete_module no longer generates error when module not in table.
 *
 *  Revision 1.35  1993/05/27  09:16:50  matthew
 *  Use full filename in making tokenstream & thence in locations
 *
 *  Revision 1.34  1993/05/18  15:16:11  jont
 *  Removed integer parameter
 *
 *  Revision 1.33  1993/05/14  13:17:12  jont
 *  Implemented make -n functionality
 *
 *  Revision 1.32  1993/05/11  12:58:51  matthew
 *  Added error_list to Error exception
 *
 *  Revision 1.31  1993/04/16  15:46:26  matthew
 *  error list field added to Info.Stop
 *
 *  Revision 1.30  1993/04/02  13:39:31  matthew
 *  Signature changes
 *
 *  Revision 1.29  1993/03/11  13:31:23  matthew
 *  Signature revisions
 *
 *  Revision 1.28  1993/03/09  14:53:49  matthew
 *  Options & Info changes
 *
 *  Revision 1.27  1993/02/24  14:33:03  daveb
 *  Changed type of name_monitor field; indenting now done in this file.
 *
 *  Revision 1.26  1993/02/04  15:29:52  matthew
 *  Substructure changes.
 *
 *  Revision 1.25  1993/01/07  14:30:26  matthew
 *  Put in some simple checks for circularity of requires.  Checks
 *  are done at the start of up_to_date and compile.  Both of these
 *   may not be necessary.
 *
 *  Revision 1.24  1993/01/06  13:59:33  matthew
 *  Changed check on loading time to be <= rather than <
 *
 *  Revision 1.23  1992/12/18  11:16:13  clive
 *  We also pass the current module forward for the source_displayer
 *
 *  Revision 1.22  1992/12/17  17:32:11  clive
 *  Changed debug info to have only module name - needed to pass module table through to window stuff
 *
 *  Revision 1.21  1992/12/16  16:49:43  clive
 *  Keep the debug information up to date during a load
 *
 *  Revision 1.20  1992/12/10  16:25:49  clive
 *  If Interrupt is hit, the partially updated module table is returned
 *  so that work does not have to be re-done later
 *
 *  Revision 1.19  1992/12/09  14:03:58  clive
 *  Changes to reflect lower level signature changes
 *
 *  Revision 1.18  1992/12/09  11:00:16  clive
 *  Added find_module for the source_displayer
 *
 *  Revision 1.17  1992/12/09  10:39:21  daveb
 *  Fixed sharing constraint to match new constraint in result signature.
 *
 *  Revision 1.16  1992/12/04  13:05:34  richard
 *  Make now checks the preloaded module list before attempting to load
 *  the results of a compilation.
 *
 *  Revision 1.15  1992/12/03  12:56:33  clive
 *  Added the load_time slot to the result
 *
 *  Revision 1.14  1992/12/02  17:05:12  daveb
 *  Changes to propagate compiler options as parameters instead of references.
 *
 *  Revision 1.13  1992/11/30  17:45:05  clive
 *  Propgate an up-to-date environment in case the make breaks - this might
 *  be rather space inefficient
 *
 *  Revision 1.12  1992/11/27  18:02:12  daveb
 *  Changes to make show_id_class and show_eq_info part of Info structure
 *  instead of references.
 *
 *  Revision 1.11  1992/11/26  12:14:19  clive
 *  Keeps an up-to-date compiler_basis in case the debugger needs it
 *
 *  Revision 1.10  1992/11/25  17:25:04  matthew
 *  Change to error message.
 *
 *  Revision 1.9  1992/11/23  16:53:24  clive
 *  Started working on load dependencies between file - if the compilation options change,
 *  then we do not need to recompile files above the given file - we simply need to
 *  re-load them.
 *  Propagated debug information to get it up to date when the debugger could be called
 *
 *  Revision 1.8  1992/11/20  15:41:27  jont
 *  Modified sharing constraints to remove superfluous structures
 *
 *  Revision 1.7  1992/11/19  14:43:04  clive
 *  Propogated debugging information all over the shop
 *
 *  Revision 1.6  1992/11/18  18:00:12  matthew
 *  More Error -> Info revision
 *
 *  Revision 1.5  1992/11/17  17:47:43  matthew
 *  Changed Error structure to Info
 *
 *  Revision 1.4  1992/11/02  16:28:37  richard
 *  Changes to pervasives and representation of time.
 *
 *  Revision 1.3  1992/10/20  16:31:07  richard
 *  Introduced make options as distinct from compiler options.
 *  Added a name monitor to watch the progress of compilations.
 *  Changed the way the require function works in order to return a
 *  partially complete module table if an error occurs.
 *
 *  Revision 1.2  1992/10/16  13:57:54  clive
 *  Changes for windowing listener
 *
 *  Revision 1.1  1992/10/14  15:26:49  richard
 *  Initial revision
 *
 *)

require "../basis/__text_io";
(* Require this structure to avoid clashes with the IO signature. *)
require "../basis/__io";
require "../system/__time";

require "../basics/module_id";
require "../main/project";
require "../utils/lists";
require "../utils/diagnostic";
require "../typechecker/basis";
require "../typechecker/stamp";
require "../main/compiler";
require "../main/mlworks_io";
require "../main/encapsulate";
require "../utils/crash";
require "../lexer/lexer";
require "interload";
require "intermake";

functor InterMake (
  structure ModuleId: MODULE_ID
  structure Project: PROJECT
  structure Lists : LISTS
  structure Compiler : COMPILER
  structure Lexer : LEXER
  structure InterLoad : INTERLOAD
  structure MLWorksIo : MLWORKS_IO
  structure Encapsulate : ENCAPSULATE
  structure Basis : BASIS
  structure Stamp : STAMP
  structure Crash : CRASH
  structure Diagnostic : DIAGNOSTIC

  sharing InterLoad.Inter_EnvTypes.Options = Compiler.Options
  sharing Encapsulate.BasisTypes = Basis.BasisTypes
  sharing Compiler.NewMap = InterLoad.Inter_EnvTypes.EnvironTypes.NewMap =
          Encapsulate.ParserEnv.Map
  sharing InterLoad.Inter_EnvTypes.EnvironTypes = Encapsulate.EnvironTypes
  sharing Project.Info = Compiler.Info
  sharing Compiler.Options = Encapsulate.Debugger_Types.Options

  sharing type Compiler.Top_Env = Encapsulate.EnvironTypes.Top_Env
  sharing type Basis.BasisTypes.Basis = Compiler.TypeBasis
  sharing type Encapsulate.ParserEnv.pB = Compiler.ParserBasis
  sharing type Compiler.DebugInformation =
	       Encapsulate.Debugger_Types.information
  sharing type Lexer.TokenStream = Compiler.tokenstream
  sharing type Encapsulate.Module = InterLoad.Module = Compiler.Module
  sharing type ModuleId.ModuleId = MLWorksIo.ModuleId = Project.ModuleId
  sharing type ModuleId.Location = Compiler.Absyn.Ident.Location.T
  sharing type Encapsulate.EnvironTypes.LambdaTypes.Ident.ValId =
	       Compiler.Absyn.Ident.ValId
  sharing type Encapsulate.EnvironTypes.LambdaTypes.Ident.StrId =
	       Compiler.Absyn.Ident.StrId
  sharing type Encapsulate.EnvironTypes.DebuggerEnv = Compiler.DebuggerEnv
  sharing type Basis.BasisTypes.Datatypes.Stamp = Stamp.Stamp
  sharing type Basis.BasisTypes.Datatypes.StampMap = Stamp.Map.T
  sharing type Project.CompilerBasis = Compiler.basis
  sharing type Project.IdCache = Compiler.id_cache
) : INTERMAKE =
  struct
    structure Debugger_Types = Encapsulate.Debugger_Types
    structure Compiler = Compiler
    structure Diagnostic = Diagnostic
    structure Inter_EnvTypes = InterLoad.Inter_EnvTypes
    structure Ident = Compiler.Absyn.Ident
    structure Info = Compiler.Info
    structure Options = Compiler.Options
    structure Map = Inter_EnvTypes.EnvironTypes.NewMap
    structure Token = Lexer.Token
    structure Location = Ident.Location
    structure Datatypes = Encapsulate.BasisTypes.Datatypes
(*     structure FileSys = OS.FileSys *)

    type Project = Project.Project
    type ModuleId = ModuleId.ModuleId

    fun diagnostic (level, output_function) =
      Diagnostic.output level
      (fn verbosity => "InterMake: " :: (output_function verbosity))

    fun augment_accumulated_info(options, basis, basis') =
      Compiler.augment(options, basis, Compiler.make_external basis')

    val get_basis_debug_info = Compiler.get_basis_debug_info

    exception GetSubRequires of string
    (* This should get the subrequires info *)
    fun get_subrequires (acc, modname, project) =
      let
        fun test [] = false
          | test ((m', _, _)::l) = modname = m' orelse test l

        fun lookupmodname modname =
	  let
	    val mod_id = ModuleId.from_mo_string (modname, Location.UNKNOWN)
	  in
	    case Project.get_loaded_info (project, mod_id)
	    of SOME {id_cache, dependencies, ...} =>
              let
                val Compiler.ID_CACHE{stamp_start,stamp_no} = id_cache
              in
                (stamp_start, stamp_no, dependencies)
              end
	    |  NONE =>
	      Crash.impossible ("Unknown module: " ^ ModuleId.string mod_id)
	  end
      in
        if test acc
          then acc
        else
          let
            val (stamps, stamp_no, Project.DEPEND_LIST dependencies) =
	      lookupmodname modname

            val acc' =
              Lists.reducel
                (fn (acc, modname) =>
                   get_subrequires (acc, modname, project))
              ((modname, stamps,stamp_no) :: acc,
               (map #mod_name dependencies))
          in
            acc'
          end
      end

    val Basis.BasisTypes.BASIS(_, _, _, _, initial_env_for_normal_file) = Basis.initial_basis

    fun get_mo_information (project, location) module_id =
      let
	val modname = ModuleId.string module_id
        val dir = ModuleId.path_string (ModuleId.path module_id)

        val mo_name =
          case Project.get_object_info (project, module_id)
          of SOME {file, ...} =>
	    file
          |  NONE =>
            raise MLWorks.Internal.Runtime.Loader.Load "cannot find mo file"

        val {parser_env, type_env, lambda_env, stamps, consistency,
	     time_stamp = src_time, mod_name} =
          Encapsulate.input_all mo_name

        val stamp_count = Stamp.read_counter ()

        val _ = Stamp.reset_counter (stamp_count + stamps)

        val id_cache = Compiler.ID_CACHE{stamp_start = stamp_count,
                                         stamp_no = stamps}

        val subnames = map #mod_name consistency

        (* And make the require list *)
	(* This returns a list that maps module names to the corresponding
	   (stamp_count, stamps) information, for each of the dependencies. *)
        val require_list =
          Lists.reducel
            (fn (acc,modname) =>
                 get_subrequires (acc, modname, project))
            ([(modname, stamp_count, stamps)], subnames)

	val require_table =
	  Map.from_list'
	    op<
	    (map (fn (x as (name, _, _)) => (name, x)) require_list)

        val (parser_env, lambda_env, type_basis, debug_info) =
          Encapsulate.decode_all
	  {parser_env=parser_env,
	   lambda_env=lambda_env,
	   type_env=type_env,
	   file_name=mod_name,
	   sub_modules=require_table,
	   decode_debug_information=false,
	   pervasive_env=initial_env_for_normal_file}

        val compiler_basis =
	  Compiler.BASIS
	    {parser_basis = parser_env,
             type_basis = type_basis,
             lambda_environment = lambda_env,
             debugger_environment =
               Inter_EnvTypes.EnvironTypes.DENV
                 (Map.empty (Ident.valid_lt,Ident.valid_eq),
                  Map.empty (Ident.strid_lt,Ident.strid_eq)),
             debug_info = debug_info}

        val compiler_result =
	  Compiler.RESULT
	    {basis = compiler_basis,
             signatures = Map.empty (Ident.sigid_lt,Ident.sigid_eq),
             code = NONE,
             id_cache = id_cache}
      in
        compiler_result
      end

    (* This is the exported function, for loading an object file. *)
    fun load options (project, location) module_id =
      let
	val Options.OPTIONS
	  {compiler_options = Options.COMPILEROPTIONS
	   {print_messages, ...},
	   ...} =
	  options

        val _ =
	  if print_messages then
	    print ("Loading mo module " ^ ModuleId.string module_id ^ "\n")
	  else
	    ()
        val (mo_name, time, dependencies) =
          case Project.get_object_info (project, module_id)
          of SOME {file, time_stamp,
		   consistency = Project.DEPEND_LIST (_ :: cons), ...} =>
	    (file, time_stamp, cons)
	  |  SOME _ =>
	    Crash.impossible "No entry for pervasive library in consistency"
	    (* This should possibly be done in a neater way *)
          |  NONE =>
            raise MLWorks.Internal.Runtime.Loader.Load "cannot find mo file"

        val (module_id', module) =
          MLWorks.Internal.Runtime.Loader.load_module mo_name

        val compiler_result =
          get_mo_information (project, location) module_id

	val (id_cache, basis) =
	  case compiler_result
	  of Compiler.RESULT {id_cache, basis, ...} => (id_cache, basis)

	fun get_load_time {mod_name, time} =
	  case
	    Project.get_loaded_info
	      (project, ModuleId.from_string (mod_name, Location.UNKNOWN))
	  of SOME {load_time, ...} =>
	    {mod_name = mod_name, time = load_time}
	  |  NONE => Crash.impossible ("no loaded info for `" ^ mod_name ^ "'")
      in
	Project.set_visible (project, module_id, false);
        Project.set_loaded_info
          (project, module_id,
	   SOME
	     {file_time = Project.OBJECT time,
	      load_time = Time.now (),
	      basis = basis,
	      id_cache = id_cache,
	      module = module,
	      dependencies =
		Project.DEPEND_LIST (map get_load_time dependencies)});
        (compiler_result, module)
      end
      handle
        MLWorks.Internal.Runtime.Loader.Load s =>
          Info.error'
	    (Info.make_default_options ())
	    (Info.FATAL,
	     Info.Location.FILE (ModuleId.string module_id),
             "Load failed: " ^ s)
      | Encapsulate.BadInput s =>
          Info.error'
	    (Info.make_default_options ())
	    (Info.FATAL,
	     Info.Location.FILE (ModuleId.string module_id),
             "Load failed: " ^ s)

    val debug_info_ref = ref Debugger_Types.empty_information

    fun with_debug_information debug_info f =
      let
        val old = !debug_info_ref
        val _ = debug_info_ref := debug_info
        val result = f () handle exn => (debug_info_ref := old;raise exn)
      in
        debug_info_ref := old;
        result
      end

    fun current_debug_information () = !debug_info_ref

    (* This is extracted from the old make function. *)
    local
      (* Load a compiler_result and return an updated project and debug_info. *)
      fun load' debugger
             initial_inter_env
	     (error_info, location, options)
	     preloaded_opt
             (project, module_id, module_str, accumulated_info,
              compiler_result, src_time, consistency) =
           let
             val _ = diagnostic (4, fn _ => ["loading ", module_str])

	     val generate_debug_info =
	       case options of
	         Options.OPTIONS
	           {compiler_options =
		      Options.COMPILEROPTIONS {generate_debug_info, ...},
		    ...} =>
		 generate_debug_info

             val Compiler.RESULT
		   {code, basis, signatures, id_cache} =
	       compiler_result

             val Compiler.BASIS {lambda_environment, ...} = basis

             val accumulated_info =
               Debugger_Types.augment_information
	         (generate_debug_info,
		  accumulated_info,
                  get_basis_debug_info basis)

             val module =
	       case preloaded_opt
	       of SOME preloaded =>
                 (* When compiling pervasives get module from preloaded list.
		    This is derived from MLWorks.Internal.Runtime.modules *)
                 (Lists.assoc (module_str, preloaded)
                  handle Lists.Assoc =>
		    Crash.impossible "No pervasive modules!")
               | NONE =>
                   (* This is code that is normally executed *)
                   let
                     fun module_map module_str =
		       case Project.get_loaded_info
			      (project, ModuleId.from_mo_string
					  (module_str, Info.Location.UNKNOWN))
		       of SOME {module, ...} => module
		       |  NONE =>
			 Crash.impossible
			   ("Can't find compilation unit `" ^ module_str
			    ^ "' in project when loading")
                   in
                     case code of
                       NONE =>
			 Info.error'
			   error_info
			   (Info.FATAL, location,
			    concat
			      ["`", module_str,
			       "' database entry has no code recorded."])
                     | SOME code' =>
                         with_debug_information
                           accumulated_info
                           (fn () =>
                              InterLoad.load
                                debugger
			        (initial_inter_env, module_map)
			        code')
                   end

             val compiler_result =
               Compiler.RESULT
	         {code=NONE,
		  basis=basis,
		  signatures=signatures,
		  id_cache=id_cache}

	     val _ =
	       Project.set_visible (project, module_id, false);

	     val _ =
	       Project.set_loaded_info
		 (project,
		  module_id,
		  SOME
		    {load_time = Time.now(),
		     file_time = Project.SOURCE src_time,
		     basis = basis,
		     id_cache = id_cache,
		     module = module,
		     dependencies = Project.DEPEND_LIST consistency})

             val _ = diagnostic (2, fn _ => ["finished ", module_str])
           in
             (compiler_result, module, accumulated_info)
           end

      fun compile'
            initial_compiler_basis
            (error_info, location, options)
            (project, module_id, filename, time) =
	let
	  val module_str = ModuleId.string module_id
	
	  val is_pervasive = ModuleId.is_pervasive module_id

	  val Options.OPTIONS
		{compiler_options = Options.COMPILEROPTIONS
		   {print_messages, ...},
		 ...} =
	    options

	  val _ =
	    if print_messages then
	      print ("Compiling " ^ module_str ^ "\n")
	    else
	      ()

          val _ = diagnostic
		    (2, fn _ => ["Compiling ", module_str, " as ", filename]);

          val (dependencies, compiler_result) =
            let
              val instream =
		TextIO.openIn filename
                handle IO.Io {name, cause, ...} =>
		  let
		    val message = exnMessage cause ^ " in: " ^ name
		  in
                    Info.error'
		      error_info
		        (Info.FATAL, Info.Location.FILE filename,
                         "Io error during make, " ^ message)
		  end
            in
              let
                val token_stream =
                  let
                    val stream_name =
                      if is_pervasive then "<Pervasive>"
                      else filename
                  in
                    Lexer.mkFileTokenStream (instream, stream_name)
                  end

                fun require_function
		      (dependencies, sub_module_name, source_location) =
                  let
                    val _ = diagnostic (3, fn _ =>
			      [ModuleId.string module_id, " requiring ",
                               sub_module_name])

		    val (full_module_id, loaded_info) =
                      if is_pervasive orelse
		         sub_module_name = MLWorksIo.pervasive_library_name then
			let
			  val m =
			    ModuleId.perv_from_require_string
			      (sub_module_name, source_location)
			in
			  (m, Project.get_loaded_info (project, m))
			end
		      else
			let
			  val m =
			    ModuleId.add_path
			      (ModuleId.empty_path,
			       ModuleId.from_require_string
			         (sub_module_name, source_location))
			in
			  (Project.get_name (project, m),
                           Project.get_loaded_info (project, m))
			end

		    val (sub_time, basis) =
		      case loaded_info
		      of NONE =>
			Crash.impossible
			  ("No loaded info for `"
			   ^ sub_module_name ^ "' in project")
		      |  SOME {load_time, basis, ...} =>
			(load_time, basis)
                  in
                    ({mod_name = ModuleId.string full_module_id,
		      time = sub_time}
		      :: dependencies,
                      ModuleId.string full_module_id,
		      basis)
                  end

                val (dependencies, compiler_result) =
                  Compiler.compile
		    (error_info, options)
		    require_function
                    ([], initial_compiler_basis, true)
                    (is_pervasive, Compiler.TOKENSTREAM token_stream)

              in
                TextIO.closeIn instream;
                (dependencies, compiler_result)
              end
              handle exn => (TextIO.closeIn instream; raise exn)
            end
        in
          (module_str, compiler_result, time, dependencies)
        end

    in
      fun compile
	    debugger
            (initial_compiler_basis, initial_inter_env)
            (error_info, location, options)
	    preloaded_opt
            (project, module_id, accumulated_info) =
	case Project.get_source_info (project, module_id)
	of NONE =>
	  (* No source file, so load the object file *)
	  let
	    val (compilerResult, module) =
	      load options (project, location) module_id
	  in
	    (compilerResult, module, accumulated_info)
	  end
	|  SOME (filename, time) =>
          let
	    val (module_str, compiler_result, time, dependencies) =
	      compile'
                initial_compiler_basis
                (error_info, location, options)
                (project, module_id, filename, time)

            val result =
              load'
	        debugger
	        initial_inter_env
	        (error_info, location, options)
	        preloaded_opt
	        (project, module_id, module_str, accumulated_info,
                 compiler_result, time, dependencies)
          in
            result
          end

      fun get_src_information
            initial_compiler_basis
            (error_info, location, options)
            (project, module_id) =
	case Project.get_source_info (project, module_id)
	of NONE =>
          Info.error'
	    error_info
	      (Info.FATAL, location,
	       "can't find compilation unit `" ^
	       ModuleId.string module_id ^ "'")
	|  SOME (filename, time) =>
          let
	    val (_, compiler_result, _, _) =
	      compile'
                initial_compiler_basis
                (error_info, location, options)
                (project, module_id, filename, time)
	  in
	    compiler_result
	  end
    end
end
