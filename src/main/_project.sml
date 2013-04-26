(*
 * Copyright (C) 1996 The Harlequin Group Limited.  All rights reserved.
 *  
 * $Log: _project.sml,v $
 * Revision 1.73  1999/03/18 08:52:50  mitchell
 * [Bug #190532]
 * Implement map_dag
 *
 * Revision 1.72  1999/03/16  16:24:07  mitchell
 * [Bug #190526]
 * Fix problem with object_dir when no configuration
 *
 * Revision 1.71  1999/03/16  12:42:42  mitchell
 * [Bug #190526]
 * Put the dependency files below the config.
 *
 * Revision 1.70  1999/03/16  12:05:51  mitchell
 * [Bug #190526]
 * Fix problem with finding dependency files for subprojects
 *
 * Revision 1.68  1999/03/11  16:13:32  mitchell
 * [Bug #190526]
 * Move dependency precis files to object directory
 *
 * Revision 1.67  1999/03/10  14:33:37  mitchell
 * [Bug #190524]
 * File time comparisons should ignore fractions of a second if retrieved from encapsulator
 *
 * Revision 1.66  1999/02/19  10:44:06  mitchell
 * [Bug #190507]
 * Change dependency checking messages to diagnostic messages
 *
 * Revision 1.65  1999/02/18  10:44:14  mitchell
 * [Bug #190507]
 * Merge the CM dependency and existing require mechanisms
 *
 * Revision 1.64  1999/02/11  13:43:49  mitchell
 * [Bug #190507]
 * Require new dependency files, but ignore them for now.
 *
 * Revision 1.63  1999/02/09  09:50:01  mitchell
 * [Bug #190505]
 * Support for precompilation of subprojects
 *
 * Revision 1.62  1999/02/04  08:30:31  mitchell
 * [Bug #50108]
 * Change ModuleId from an equality type
 *
 * Revision 1.61  1999/02/02  16:01:07  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.60  1998/11/26  14:52:38  johnh
 * [Bug #70240]
 * Change delete function and add function to return units in main project only.
 *
 * Revision 1.59  1998/08/19  08:51:42  johnh
 * [Bug #30481]
 * Fix reading subprojects within different directories.
 *
 * Revision 1.58  1998/08/13  10:52:09  jont
 * [Bug #30468]
 * Change types of mkAbsolute and mkRelative to uses records with names fields
 *
 * Revision 1.57  1998/07/30  14:13:31  johnh
 * [Bug #30420]
 * Include name of project when reporting a unit does not exist.
 *
 * Revision 1.56  1998/06/30  13:20:12  johnh
 * [Bug #20111]
 * Fix incorrect case problems.
 *
 * Revision 1.55  1998/06/01  16:03:18  johnh
 * [Bug #30369]
 * Replace source path with a list of files.
 *
 * Revision 1.54  1998/05/12  15:27:16  johnh
 * [Bug #30385]
 * CHanging mode should affect compilation.
 *
 * Revision 1.53  1998/04/24  15:19:29  mitchell
 * [Bug #30389]
 * Keep projects more in step with projfiles
 *
 * Revision 1.52  1998/04/22  15:13:34  jont
 * [Bug #70091]
 * Remove req_name from DEPEND_LIST
 *
 * Revision 1.51  1998/04/03  14:16:14  jont
 * [Bug #30312]
 * Replacing OS.FileSys.modTime with system dependent version to sort out
 * MS time stamp problems.
 *
 * Revision 1.50  1998/03/24  10:38:24  johnh
 * [Bug #30377]
 * Add check to ensure we know when we are checking deps of a pervasive file.
 *
 * Revision 1.49  1998/03/16  14:54:38  johnh
 * [Bug #70078]
 * When making object directories apply OS.Path.fromUnixPath.
 *
 * Revision 1.48  1998/03/16  12:22:18  johnh
 * [Bug #30365]
 * Implement support for sub-projects.
 *
 * Revision 1.47  1998/02/26  11:35:34  johnh
 * [Bug #30362]
 * Use mode setting to determine where object files go.
 *
 * Revision 1.46  1998/02/19  08:57:05  mitchell
 * [Bug #30337]
 * Change uses of OS.Path.concat to take a string list, instead of a pair of strings.
 *
 * Revision 1.45  1998/02/06  11:24:42  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 * Added pervasiveObjectName.
 *
 * Revision 1.44  1998/01/26  17:21:31  jont
 * [Bug #30311]
 * Make sure we test for correct sequencing of timestamps on object files
 * and their dependents. If a depends on b, then a.mo should be no older
 * then b.mo
 *
 * Revision 1.43  1997/10/19  20:14:09  jont
 * [Bug #30089]
 * Remove use of OldOs.mtime in favour of OsFileSys.modTime
 *
 * Revision 1.42  1997/10/13  10:57:55  daveb
 * [Bug #20090]
 * Changed consistency info in object files to store the modification times
 * of the corresponding source files.
 * Ditto for loaded object files.
 *
 * Revision 1.41.2.12  1998/01/08  15:00:16  johnh
 * [Bug #30071]
 * Remove specification of objects and binaries locations from configurations.
 *
 * Revision 1.41.2.11  1997/12/04  16:43:42  daveb
 * [Bug #30071]
 * Made fromFileInfo take a project to update.
 * Removed update function.
 * Interpret relative library paths w.r.t. to projectDir, not current dir.
 *
 * Revision 1.41.2.10  1997/12/02  14:06:20  daveb
 * [Bug #30071]
 * Search library path for object files.  Remove "%S" option for objects.
 *
 * Revision 1.41.2.9  1997/12/01  12:24:48  daveb
 * [Bug #30071]
 * Unset diagnostics.
 *
 * Revision 1.41.2.8  1997/12/01  11:17:15  daveb
 * [Bug #30071]
 * Relative path names are relative to the directory containing the
 * project file -- ensure this in fromFileInfo.
 *
 * Revision 1.41.2.7  1997/11/26  16:17:08  daveb
 * [Bug #30071]
 *
 * Revision 1.41.2.6  1997/11/20  17:01:35  daveb
 * [Bug #30326]
 *
 * Revision 1.41.2.5  1997/11/06  16:22:28  daveb
 * [Bug #30071]
 * Removed temporary default values for project.
 * Added support for current configurations, modes and targets.
 *
 * Revision 1.41.2.4  1997/10/30  16:29:01  daveb
 * [Bug #30089]
 * Merged from trunk:
 * Remove use of OldOs.mtime in favour of OsFileSys.modTime
 *
 * Revision 1.41.2.3  1997/10/29  11:41:00  daveb
 * [Bug #20090]
 * Merged from trunk:
 * Changed consistency info in object files to store the modification times
 * of the corresponding source files.
 * Ditto for loaded object files.
 *
 * Revision 1.41.2.2  1997/09/17  15:57:37  daveb
 * [Bug #30071]
 * Converted build system to project workspace.
 *
 * Revision 1.41.2.1  1997/09/11  20:57:05  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.41  1997/06/13  16:19:09  jkbrook
 * [Bug #30158]
 * Merging in changes from 1.0r2c2 to 2.0m0
 *
 * Revision 1.40  1997/05/19  11:19:46  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.39  1997/05/12  16:05:11  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.38  1997/05/07  16:19:43  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 * Make sure reset_pervasives preserves dependencies for Encapsulate.decode_type_basis
 *
 * Revision 1.37  1997/02/12  13:22:47  daveb
 * Review edit <URI:spring://ML_Notebook/Review/basics/*module.sml>
 *
 * Revision 1.36  1996/11/06  11:29:07  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.35  1996/10/29  16:28:10  io
 * [Bug #1614]
 * updating toplevel String
 *
 * Revision 1.34  1996/10/03  16:56:24  daveb
 * [Bug #1660]
 * When check_source_load_times finds a unit loaded from source, but no
 * corresponding source file, it now assumes that the loaded module is up
 * to date.
 *
 * Revision 1.33  1996/08/14  15:52:35  daveb
 * [Bug #1220]
 * Changed the check_validity function in check_dep to return an list of out
 * of date files.  Then changed check_source so that if no source file exists,
 * it checks the object files instead.  Intermake now loads an object file if
 * no source file exists; together these changes allow source files to require
 * object files.
 *
 * Revision 1.32  1996/07/04  15:16:20  jont
 * Improve error message when loading object files which are out of date
 *
 * Revision 1.31  1996/07/04  08:55:38  daveb
 * Bug 1448/Support Calls 35 & 37: Added remove_file_info and modified checks
 * to permit missing file information.
 *
 * Revision 1.30  1996/04/30  17:19:07  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.29  1996/04/29  15:00:06  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.28  1996/04/23  11:10:49  daveb
 * Fixed bug whereby read_dependencies didn't recurse on units which only
 * had an object file.
 *
 * Revision 1.27  1996/04/02  11:14:28  daveb
 * Renamed load_dependencies to read_dependencies.
 *
 * Revision 1.26  1996/04/01  12:36:21  stephenb
 * Change any use of Os/OS to OldOs/OLD_OS to emphasise that it is using
 * the deprecated OS interface.
 *
 * Revision 1.25  1996/04/01  10:11:38  jont
 * Modification to check_aliases to prevent multiple compilations
 * of files.
 *
 * Revision 1.24  1996/03/25  11:29:44  daveb
 * Added delete function.
 *
 * Revision 1.23  1996/03/18  17:22:02  daveb
 * Added is_visible and set_visible functions.
 *
 * Revision 1.22  1996/03/15  16:59:55  daveb
 * Module.mo_name now takes an Info.options argument.
 *
 * Revision 1.21  1996/03/14  16:41:31  daveb
 * Changed type of loaded field to store just the basis and id_cache fields.
 *
 * Revision 1.20  1996/03/14  16:08:25  jont
 * Fix lack of warning when pervasive files not found
 * and pervasive recompilation requested
 *
 * Revision 1.19  1996/03/14  15:35:18  daveb
 * Changed visited_pervasives to mark_compiled instead of mark_visited.
 * Added some more diagnostics.  Corrected an error message.
 *
 *
 * Revision 1.18  1996/03/14  15:08:32  jont
 * Treat files where the filestamp info is corrupt as out of date
 *
 * Revision 1.17  1996/03/07  18:56:27  daveb
 * Fixed bug with bad requires.
 *
 * Revision 1.16  1996/03/07  12:23:44  daveb
 * Fixed update of source info, to make loadSource work properly.
 *
 * Revision 1.15  1996/03/06  14:36:16  daveb
 * Reset diagnostic level.
 *
 * Revision 1.14  1996/03/06  14:12:30  daveb
 * Fixed information stored for loaded modules, added validity check when
 * loading object files, fixed various details.
 *
 * Revision 1.13  1996/02/27  14:02:33  daveb
 * Hid implementation of the Unit type.
 *
 * Revision 1.12  1996/02/23  17:41:54  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.11  1996/02/21  10:16:22  daveb
 * Revised some error message to say 'object files' instead of 'mo files'.
 *
 * Revision 1.10  1996/01/05  16:37:48  daveb
 * Ensured that check_visited_map always uses the real module_ids, allowing for
 * symbolic links.  Passed a list of resolved module_ids as an argument to
 * check_dep; this builds up a list of the module_ids for the requires in a
 * given unit.
 *
 *  Revision 1.8  1995/12/15  13:28:34  jont
 *  Fixing bug whereby make doesn't always recompile all it should
 *
 *  Revision 1.7  1995/12/12  13:26:10  daveb
 *  Fixing bugs with load_object_dependencies
 *
 *  Revision 1.6  1995/12/07  17:24:27  daveb
 *  Replaced use of error_fn with Info.error.  Replaced an occurrence of
 *  mesg_fn with a diagnostic.  Improved format of mesg_fn output.
 *
 *)

require "../system/__link_support";  (* Just to make sure .mo is built *)

require "../basis/__int";
require "../basis/__real";
require "../basis/__list";
require "../basis/__string";
require "../system/__time";
require "^.system.__file_time";

require "../main/encapsulate";
require "../main/compiler";
require "../main/proj_file";
require "../utils/map";
require "../utils/crash";
require "../utils/lists";
require "../utils/diagnostic";
require "../make/depend";
require "../basics/module_id";
require "../basis/os";
require "options";
require "mlworks_io";

require "../dependency/_group_dag";
require "../dependency/module_dec_io.sml";
require "../dependency/import_export.sml";
require "../dependency/__ordered_set";

require "project";

functor Project (
  structure Encapsulate: ENCAPSULATE;
  structure ProjFile: PROJ_FILE;
  structure Compiler: COMPILER;
  structure Diagnostic: DIAGNOSTIC;
  structure NewMap: MAP;
  structure Crash: CRASH;
  structure ModuleId: MODULE_ID;
  structure Io: MLWORKS_IO;
  structure Depend: DEPEND;
  structure Options: OPTIONS;
  structure Lists: LISTS;
  structure OS : OS
  structure ModuleDecIO : MODULE_DEC_IO
  structure ImportExport : IMPORT_EXPORT

  sharing type Depend.ModuleId = ModuleId.ModuleId = Io.ModuleId
  sharing type Depend.Info.Location.T = ModuleId.Location
  sharing ModuleDecIO.ModuleDec = ImportExport.ModuleDec
  sharing type ImportExport.context = Compiler.Top_Env

): PROJECT =
struct
  structure Info = Depend.Info
  structure Location = Info.Location
  structure FileSys = OS.FileSys
  structure ModuleDec = ModuleDecIO.ModuleDec

  structure GD = GroupDagFun(structure ImportExport = ImportExport
                             structure ModuleId = ModuleId); 

  type Options = Options.options
  type ('a, 'b) Map = ('a, 'b) NewMap.map
  type ModuleId = ModuleId.ModuleId
  type CompilerBasis = Compiler.basis
  type IdCache = Compiler.id_cache
  type target_type = ProjFile.target_type

  val _ = Diagnostic.set 0

  fun diagnostic (level, output_function) =
    Diagnostic.output
      level
      (fn verbosity => output_function verbosity)

  (* This type is used by object files and loaded modules to store the
     time stamps of the object files or loaded modules on which they
     depend.  Using this type in both fields allows the dependency checking code
     to be shared. *)
  datatype Dependencies =
    DEPEND_LIST of
      {mod_name : string, time : Time.time} list
  
  datatype FileTime =
    OBJECT of Time.time
  | SOURCE of Time.time

  (* This is how the project manager represents a compilation unit.
     We store the following information:

     name:
       	In the presence of symbolic links, several module_ids may map to the
	same unit.  The module_id stored in the unit is the "real" module_id.
     source:
	The filename and modification time of the source file, if any.
	The recompilation process begins by re-loading all this information.
     requires:
	A triple of an explicit and an implicit list of dependencies, and
        a list of those dependencies external to the project.
        The explicit list of dependencies is read from the require declarations
        in the source file.  It is updated by the recompilation process if the
	modification time of the source file has changed.  The implicit list
        is obtained by doing a dependency analysis.  If the explicit list is
        non-empty and is a superset of the implicit list, then this list
        is used to drive the recompilation process.  If the explicit list is a
        subset of the implicit list then the implicit list is used. 
        Furthermore, in this case if the explicit list is non-empty then a 
        warning is issued.
     object:
	The filename, modification time, and consistency information of the
	object file, if any.  The consistency information contains the
	modification times of the source file, which is called the time stamp.
	It also contains the time stamps of (i.e. the modification times of the
	source files that correspond to) the pervasive library and all the
	object files that this file depends on.  The recompilation process
	begins by bringing this information up to date.  We assume at most
	one object file per source file.
	The consistency information is set when the file is written by
	Encapsulate.output_file, which is called from <URI:/_toplevel.sml>.
     loaded:
	Contains the modification time of the file from which the compilation
	unit was loaded (if a source file) or its time stamp (if an object file),
        the time that it was loaded, the compiled module, and the load times of
        the loaded modules on which it depends.
	This information is set when loading a module, in
        <URI://MLWinterpreter/_intermake.sml>.
     visible:
	Records whether the loaded unit is visible at top level, i.e. has
	been added to the user's Context.
     options:
	A place holder to record the options with which a loaded unit was
	compiled.  Currently unused.  If this support is added, then the
	object file format should probably be changed to store this
	information as well.
     mod_decls:
        A precis of the module imports and exports for this unit, together
        with a boolean indicating whether this information is only approximate,
        e.g. because of a syntax error in the source file.
  *)

  datatype Unit =
    UNIT of
    {name:     ModuleId.ModuleId, 
     source:   (string * Time.time) option ref,
     requires: {explicit: ModuleId.ModuleId list,
                implicit: ModuleId.ModuleId list,
                subreqs : ModuleId.ModuleId list} ref,
     object:   {file_time: Time.time,
		time_stamp: Time.time,
		file: string,
		stamps: int,
		consistency: Dependencies} option ref,
               (* The int is the stamps field returned by
		  Encapsulate.input_info *)
     loaded:   {file_time: FileTime,
		load_time: Time.time,
		basis: Compiler.basis,
		id_cache: Compiler.id_cache,
		module: MLWorks.Internal.Value.T,
		dependencies: Dependencies} option ref,
     visible:  bool ref,
     options:  Options.options option ref,
     mod_decls: (ModuleDec.Dec * bool) ref
    }
  
  (* The Project type is the definition of a project.  It has the following
     elements:

     units:  A map from module_ids to units.
     files:  A list of files to be included in the project.  Consists 
	only of ML source files at present.
     library_path:  A list of directories to search for libraries
       (libraries are currently implemented as object files).
     object_dir:  A specification of where to put new object files.
     current_targets:  A list of top-level files, in build order, and the
       sort of deliverable.
     disabled_targets:  A list targets that are temporarily disabled.
     dependency_info:  The inferred dependency information for this project.

     Currently the files and object path are global, and targets
     are specified on the command line.
   *)

  datatype Project =
    PROJECT of
      {name: string,
       units: (ModuleId.ModuleId, Unit) NewMap.map,
       files: string list,
       library_path: string list,
       object_dir: {base: string, config: string, mode: string},
       subprojects: Project list,
       current_targets: string list,
       disabled_targets: string list,
       dependency_info: Dependency_info
      }
  
  and Dependency_info = 
    DEPEND of
       (ImportExport.ModuleName.set * dag) list (* current targets *)
     * (ImportExport.ModuleName.set * dag) list (* other units *)

  withtype dag = (ModuleId.ModuleId OrderedSet.set) GD.dag
  
  type project_cache = ({filename: string,
                         targets: string list}, Project) NewMap.map
 
  fun string_list_lt([], []) = false
    | string_list_lt([], _)  = true
    | string_list_lt(h::t, []) = false
    | string_list_lt(h1::t1, h2::t2) = 
        String.<(h1,h2)
        orelse (h1 = h2 andalso string_list_lt(t1,t2))

  fun project_cache_lt 
      ({filename = f1, targets = tl1},
       {filename = f2, targets = tl2}) =
      String.<(f1, f2)
      orelse (f1 = f2
              andalso (string_list_lt(tl1, tl2)))

  val empty_project_cache : project_cache =
        NewMap.empty (project_cache_lt, op =)

  fun get_subprojects (proj as PROJECT{subprojects,...}) = subprojects

  fun set_subprojects (PROJECT{name,units,files,library_path,object_dir,
                               current_targets,disabled_targets,
                               dependency_info,...}, subprojects) =
    PROJECT{name=name,units=units,files=files,library_path=library_path,
            object_dir=object_dir,current_targets=current_targets,
            disabled_targets=disabled_targets,dependency_info=dependency_info,
            subprojects=subprojects}

  fun map_dag (f: Project -> Project) (p: Project) =
    let 
      val project_cache = ref empty_project_cache
      fun process (proj as PROJECT {name, current_targets, subprojects, ...}) =
        case NewMap.tryApply' (!project_cache, 
                   {filename = name, targets = current_targets}) of 
          SOME project => project
        | NONE => 
            let val proj' = f (set_subprojects(proj, map process subprojects))
             in 
               project_cache := 
                 NewMap.define (!project_cache, 
                   { filename=name, targets=current_targets }, 
                   proj');
               proj'
            end 
    in process p
    end
 
  val { union = union_mid_set, memberOf = member_mid_set, ... } =
              OrderedSet.gen { eq = ModuleId.eq, lt = ModuleId.lt }
  val empty_mid_set = OrderedSet.empty
  val singleton_mid_set = OrderedSet.singleton

  (* The NoSuchModule exception is raised when read_dependencies fails to find
     the module corresponding to some dependency information, or when
     set_object_info is called with an invalid module id. *)
  exception NoSuchModule of ModuleId.ModuleId

  (* The Kind type indicates whether a function is checking dependencies of
     a pervasive module or a user module. *)
  datatype Kind = PERVASIVE | USER

  fun currentTargets (PROJECT {current_targets, ...}) = current_targets

  fun combineOpt (NONE, NONE) = NONE
    | combineOpt (NONE, SOME a) = SOME a
    | combineOpt (SOME a, NONE) = SOME a
    | combineOpt (SOME a, SOME b) = SOME a

  fun module_id_in_project (PROJECT {units, ...}, m) = 
    case NewMap.tryApply' (units, m) of
      SOME _ => true
    | NONE => false

  fun get_unit (PROJECT {units, subprojects, ...}, m) = 
    case NewMap.tryApply' (units, m)
    of SOME unit => SOME unit
    |  NONE =>
      case subprojects of
	[] => NONE
      | (a::rest) => 
	foldl combineOpt NONE (map (fn p => get_unit(p, m)) subprojects)

  fun get_project_name (PROJECT {name, ...}) = name
    
  fun get_name (proj, m) =
    case get_unit (proj, m) 
    of SOME (UNIT {name, ...}) => name
    |  NONE =>
      (diagnostic (1,
         fn _ => ["No such module in get_name: `", ModuleId.string m, "'"]);
       raise NoSuchModule m)

  fun requires_from_unit 
        (UNIT {name, requires = ref {explicit,implicit,subreqs},...}) = 
      case explicit of
        [] => implicit
      | _  => explicit

  fun get_requires (proj, m) =
    case get_unit(proj, m) of
      SOME u => requires_from_unit u
    | NONE => 
      (diagnostic (1,
         fn _ => ["No such module in get_requires: `", ModuleId.string m, "'"]);
       raise NoSuchModule m)

  fun get_external_requires (proj as PROJECT{subprojects,...}) =
    let fun convert (subproject as PROJECT {name,...}) =
          map (fn t => (subproject, ModuleId.from_host (t, Location.FILE name)))
              (currentTargets subproject)
     in List.concat (map convert subprojects)
    end

  fun is_visible (proj, m) =
    case get_unit (proj, m)
    of SOME (UNIT {visible, ...}) => !visible
    |  NONE =>
      (diagnostic (1,
         fn _ => ["No such module in is_visible: `", ModuleId.string m, "'"]);
       raise NoSuchModule m)

  fun set_visible (proj, m, b) =
    case get_unit (proj, m)
    of SOME (UNIT {visible, ...}) => visible := b
    |  NONE =>
      (diagnostic (1,
	 fn _ => ["No such module in is_visible: `", ModuleId.string m, "'"]);
       raise NoSuchModule m)

  fun get_source_info (proj, m) =
    case get_unit (proj, m)
    of SOME (UNIT {source, ...}) => !source
    |  NONE => NONE
	
  fun set_source_info (proj, m, info) =
    case get_unit (proj, m)
    of SOME (UNIT {source, ...}) => source := info
    |  NONE =>
      (diagnostic (1,
         fn _ => ["No such module in set_source_info: `",
                  ModuleId.string m, "'"]);
       raise NoSuchModule m)

  fun get_object_info (proj, m) =
    case get_unit (proj, m)
    of SOME (UNIT {object, ...}) => !object
    |  NONE => NONE

  fun set_object_info (proj, m, info) =
    case get_unit (proj, m)
    of SOME (UNIT {object, ...}) => object := info
    |  NONE =>
      (diagnostic (1,
         fn _ => ["No such module in set_object_info: `",
                  ModuleId.string m, "'"]);
       raise NoSuchModule m)

  fun get_loaded_info (proj, m) =
    case get_unit (proj, m)
    of SOME (UNIT {loaded, ...}) => !loaded
    |  NONE => NONE

  fun set_loaded_info (proj, m, info) =
    case get_unit (proj, m)
    of SOME (UNIT {loaded, ...}) => loaded := info
    |  NONE => 
      (diagnostic (1,
         fn _ => ["No such module in set_loaded_info: `",
                  ModuleId.string m, "'"]);
       raise NoSuchModule m)

  fun clear_info pred (PROJECT {units, subprojects, ...}) = 
    (NewMap.iterate 
      (fn (m, UNIT u) =>
	 if pred m then
	   #loaded u := NONE
         else
	   ())
      units;
     app (clear_info pred) subprojects)

  fun clear_all_loaded_info (proj, pred) =
    clear_info pred proj

  fun mesg_fn (location, s) =
    print(Info.Location.to_string location ^ ": " ^ s ^ "\n")
  
  (* Given a module_id for a user module and a search path, findFile
     finds the corresponding file, and returns the file name and
     modification time. *)
  fun findFile ext (search_path, module_id) =
    let
      fun search [] =
        (diagnostic (2, fn _ => ["Failed to find file"]);
	 NONE)
      |   search (dir::rest) =
        let
          val filename =
	    OS.Path.joinDirFile
              {dir = dir,
	       file = ModuleId.module_unit_to_string (module_id, ext)}

          val _ =
            diagnostic (2, fn _ => ["searching: ", filename])
        in
	  let
            val mod_time = FileTime.modTime filename
	  in
	    diagnostic (2, fn _ => ["Found `", filename, "'"]);
	    SOME (filename, mod_time)
	  end
	  handle OS.SysErr _ =>
  	    search rest
        end
    in
      search search_path
    end

  val source_ext = "sml"
  val object_ext = "mo"

  (* findObject is more complicated than findSource.  The first place to
     look is in the object directory, which is simple enough.  If there
     isn't a file there, then there are two cases:
       1. If a source file exists, then stop.
       2. If there isn't a source file, then search the library path
	  for a library entry.  *)
  local
    (* objectName' finds the filename corresponding to an existing
       source file. *)
    fun objectName' ({base, config, mode}, module_id) =
      OS.Path.mkCanonical
        (OS.Path.concat
          [base, config, mode, 
           ModuleId.module_unit_to_string(module_id, object_ext)])

    fun search_lib_path (NONE, _) = NONE
    |   search_lib_path (SOME lib_path, module_id) =
      findFile object_ext (lib_path, module_id)
  in
    (* Given a module_id for a user module, and an optional library path,
       findObject finds the corresponding object file, and returns the
       file name and modification time. *)
    (* We should probably add an argument that specifies whether an object
       file is definitely required, or whether it's OK if it's missing. *)
    fun findObject (object_dir, lib_path_opt, module_id) =
      let
        val filename = objectName' (object_dir, module_id)
      in
	let
	  val mod_time = FileTime.modTime filename
	in
          diagnostic (2, fn _ => ["Found `", filename, "'"]);
          SOME (filename, mod_time)
        end
        handle OS.SysErr _ =>
          search_lib_path (lib_path_opt, module_id)
      end

    (* objectName is externally visible; it finds the object filename
       corresponding to an existing source file. *)
    fun objectName
          (error_info, loc)
	  (PROJECT {units, object_dir, subprojects, ...}, module_id) =
      let
	val top_unit = NewMap.tryApply' (units, module_id) 

	fun get_subproject_info ([], m) = (NONE, object_dir)
	  | get_subproject_info 
		((PROJECT {object_dir, subprojects, units, ...}) :: rest, m) = 
	      case NewMap.tryApply' (units, m) of 
		SOME unit => (SOME unit, object_dir)
	      | NONE => get_subproject_info (subprojects @ rest, m)

	val (unitOpt, object_dir) = 
	  if isSome(top_unit) then 
	    (top_unit, object_dir)
	  else
	    get_subproject_info (subprojects, module_id)

        val unit = 
          case top_unit of 
	    SOME unit => unit
	  | NONE =>
	      case unitOpt of 
		SOME unit => unit
	      | NONE => 
	        (* This is probably impossible *)
                (Info.default_error'
                   (Info.FATAL, loc,
                    (* LOCALE *)
                    "Missing unit information for module " ^
 	            ModuleId.string module_id))
      in
	case unit of
	  UNIT {object as ref (SOME {file, ...}), ...} =>
	    file
        | _ =>
          objectName' (object_dir, module_id)
      end   

    fun pervasiveObjectName module_id =
      objectName' ({base=Io.get_pervasive_dir(), config="", mode=""},module_id)

  end

  fun findPervasiveFile ext module_id =
    let
      val filename =
        OS.Path.joinDirFile
          {dir = Io.get_pervasive_dir(),
           file = ModuleId.module_unit_to_string (module_id, ext)}

      val _ = diagnostic (2, fn _ => ["looking for: ", filename])

      val mod_time = FileTime.modTime filename
    in
      diagnostic (2, fn _ => ["Found `", filename, "'"]);
      SOME (filename, mod_time)
    end
    handle
      OS.SysErr _ => NONE
    | Io.NotSet _ => NONE

  (* Given a module_id for a pervasive module, findPervasiveObject finds the
     corresponding mo file, and returns the file name and modification time. *)
  val findPervasiveObject = findPervasiveFile object_ext

  (* Given a module_id for a pervasive module, findPervasiveSource finds the
     corresponding source file, and returns the file name, module, and
     modification time. *)
  val findPervasiveSource = findPervasiveFile source_ext

  (* Given a module_id for a user module, and a list of source files, 
   * findSource finds the corresponding source file, and returns the 
   * file name and modification time. 
   *)
  fun findSource (file_list, module_id) =
    let
      val fname = 
	OS.Path.mkCanonical (ModuleId.module_unit_to_string (module_id, "sml"))

      fun search [] = 
        (diagnostic (2, fn _ => ["Failed to find file in Project file list"]);
	 NONE)
	| search (filename::rest) = 
	  if (fname = OS.Path.mkCanonical (OS.Path.file filename)) then 
	    let
	      val mod_time = FileTime.modTime filename
	    in
	      diagnostic (2, fn _ => ["Found `", filename, "'"]);
	      SOME (filename, mod_time)
	    end
	    handle OS.SysErr _ => 
	      (diagnostic (2, fn _ => ["File `", filename, "' cannot be inspected."]);
	       NONE)
	  else
	    search rest
    in
      search file_list
    end


  fun module_id_from_string (filename, is_pervasive) name =
    let val loc = Location.FILE filename
     in if is_pervasive
        then ModuleId.perv_from_require_string(name, loc)
        else ModuleId.from_require_string(name, loc)
    end


  (* This is called before storing a unit's list of required modules. *)
  fun module_name_from_require req_name =
    ModuleId.add_path (ModuleId.empty_path, req_name)
  
  (* load_src loads information about a source file from disk.  The project
     argument (and result) is actually one of the components (pervasive or
     user) of the project type. *)
  fun load_src (is_pervasive, error_info,
		SOME (filename, mod_time), unit,
                object_dir as {base, config, mode}) =
    let
      (* Get the names of the dependencies *)
      val (mod_decs, requires, partial) =
        ModuleDecIO.source_to_module_dec (filename, SOME mod_time, 
          if is_pervasive then Io.get_pervasive_dir() 
          else OS.Path.mkCanonical(OS.Path.concat[base, config]))
      val sub_modules =
        map ( module_name_from_require 
              o (module_id_from_string (filename, is_pervasive)) )
            requires 
    in
      case unit of
        UNIT {source, requires, mod_decls, ...} =>
  	(source := SOME (filename, mod_time);
         mod_decls := (mod_decs, partial);
         requires := {explicit=sub_modules,implicit=[],subreqs=[]})
    end
  | load_src (is_pervasive, error_info, NONE,
                UNIT {name, source, requires, mod_decls, ...}, 
                object_dir as {base, config, mode}) =
    let
      (* Hardwiring in the .sml extension here is undesirable.
         The source field in a Unit should contain the name of the file 
         as it exists in the project file, and just the time should
         be optional if the source file cannot be found. *) 
      val filename = ModuleId.module_unit_to_string(name, "sml")
      val (mod_decs, reqs, partial) =
        ModuleDecIO.source_to_module_dec (filename, NONE, 
          if is_pervasive then Io.get_pervasive_dir() 
          else OS.Path.mkCanonical(OS.Path.concat[base, config]))
      val sub_modules =
        map ( module_name_from_require 
              o (module_id_from_string (filename, is_pervasive)) )
            reqs 
    in
        (source := NONE;
         mod_decls := (mod_decs, partial);
         requires := {explicit=sub_modules,implicit=[],subreqs=[]})
    end  

  (* load_object loads information about a object file from disk.  The project
     argument (and result) is actually one of the components (pervasive or
     user) of the project type. *)
  fun load_object (SOME (filename, mod_time)) unit =
    (let
       val {time_stamp, consistency, mod_name, stamps} =
	 Encapsulate.input_info filename
     (* The mod_name is ignored here.  Does this matter? *)
     in
       case unit of
	 UNIT {object, ...} =>
	   object :=
	   SOME 
	   {file_time = mod_time, 
	    time_stamp = time_stamp,
	    file = filename,
	    stamps = stamps,
	    consistency = DEPEND_LIST consistency}
     end
   handle Encapsulate.BadInput str =>
     (print("Corrupt object file '" ^ filename ^ "' treating as out of date\n");
      case unit of
	UNIT {object, ...} => object := NONE))
    | load_object NONE unit =
      case unit of
	UNIT {object, ...} => object := NONE
  
  (* new_unit creates a new unit. *)
  fun new_unit
	error_info
	(is_pervasive, map, module_id, sml_info, mo_info, info_from_mo, object_dir) =
    let
      val unit =
        UNIT
          {name = module_id,
           source = ref NONE,
           requires = ref {explicit=[],implicit=[],subreqs=[]},
           loaded = ref NONE,
           visible = ref false,
           options = ref NONE,
           mod_decls = ref (ModuleDec.SeqDec [], false),
           object = ref NONE}
  
      (* We can do an optimisation here: if we have info_from_mo, and
	 the mo is up to date, then the consistency contains the list
	 of require names. *)
      val _ = load_src (is_pervasive, error_info, sml_info, unit, object_dir)

      (* We add the object info explicitly here, because we may have
	 already read the necessary info from the mo file, and we don't
	 want to open the file twice. *)
      val _ =
	case info_from_mo of
	  SOME {consistency, mod_name, time_stamp, stamps} =>
	    (case mo_info of
	       SOME (filename, mod_time) =>
		 (case unit of
		    UNIT {object, ...} =>
		      object :=
		      SOME 
		      {file_time = mod_time, 
	             time_stamp = time_stamp,
		       file = filename,
		       stamps = stamps,
		       consistency = DEPEND_LIST consistency})
	     | NONE =>
		  Crash.impossible ("new_unit has info_from_mo but no mo_info in `"
				    ^ ModuleId.string module_id ^ "'!"))
	| NONE =>
	    (* load_object will read the info from the mo file if necessary *)
            (diagnostic (3,
               fn _ => ["calling load_object from new_unit"]);
	     load_object mo_info unit;
	     case (mo_info, sml_info) of
	       (NONE, NONE) =>
		 if is_pervasive then
		   Info.error'
		   error_info
		   (Info.FATAL, Info.Location.UNKNOWN,
		    "No files found for pervasive file: `" ^ ModuleId.string module_id ^ "'")
		 else
		   ()
	     | _ => ())

      val map' = NewMap.define (map, module_id, unit)
    in
      (map', unit)
    end


  (* The StatusMap type stores information about those units for which
     information has been updated during a particular command.  There
     are currently two statuses that may be stored:
        visited: the dependency information is up to date
        compiled: the object file or loaded module is up to date.
   *)

  type StatusMap = (ModuleId, bool) Map

  fun mark_visited (v, m) = NewMap.define (v, m, false)
  fun mark_compiled (v, m) = NewMap.define (v, m, true)

  val empty_map = NewMap.empty (ModuleId.lt, ModuleId.eq)
  val visited_pervasives = mark_compiled (empty_map, Io.pervasive_library_id)

  fun no_targets (error_info, location) projectName = 
    let 
      val name = getOpt (ProjFile.getProjectName(), "")
      val err_project_str = 
	if (name = "") orelse
	   (OS.Path.mkCanonical projectName) = (OS.Path.mkCanonical name) then
	  "No targets specified in current project"
	else
	  "No targets specified in project: " ^ projectName
    in
      Info.error' error_info
	(Info.FATAL, location, err_project_str)
    end

  (* Check that the source info recorded in the project is still valid. *)
  fun check_src (unit as UNIT {source = src_info, ...}, module_id,
                 is_pervasive, files, error_info, location, object_dir)  =
      case !src_info of 
        sml_info as SOME (filename, time_stamp) =>
          (* Check whether the file on disk has changed *)
          (let val mod_time = FileTime.modTime filename
            in if time_stamp = mod_time 
               then ()
               else
                 load_src
                   (is_pervasive, error_info,
                    SOME (filename, mod_time), unit, object_dir)
           end
             handle OS.SysErr _ =>
                 (mesg_fn (location,
                           "Source file " ^ filename ^ " has disappeared");
                  if is_pervasive then
                    load_src
                      (true, error_info,
                       findPervasiveSource module_id,
                       unit, object_dir)
                  else
                    load_src
                      (false, error_info,
                       findSource (files, module_id),
                       unit, object_dir)))
      | NONE => 
          if is_pervasive 
          then
            load_src
                  (true, error_info,
                   findPervasiveSource module_id,
                   unit, object_dir)
          else
            load_src  (* we know this unit is not in a subproject *)
                  (false, error_info,
                   findSource (files, module_id),
                   unit, object_dir)
    
  fun getObject (unit as UNIT {source = src_info, ...}, module_id, 
                 is_pervasive, library_path, object_dir) = 
      if is_pervasive 
      then 
        findPervasiveObject module_id
      else
        let 
          (* Don't search the library path if a source file exists. *)
          val lib_path_opt = 
              if isSome (!src_info) then NONE else SOME library_path
        in
          findObject (object_dir, lib_path_opt, module_id)
        end

  (* Check that the object info recorded in the project is still valid. *)
  fun check_obj (unit as UNIT {object, ...}, module_id, 
                 is_pervasive, library_path, object_dir, location) =
      let 
        val get_object = getObject(unit, module_id, 
                                   is_pervasive, library_path, object_dir)
      in
        case !object of 
          SOME {file, time_stamp, file_time, stamps, consistency} =>
            (* Check whether the file on disk has changed *)
            (let val mod_time = FileTime.modTime file
              in
                case get_object of 
                  NONE => load_object NONE unit
                | SOME (obj_file, obj_time) =>
                    if (obj_file = file) then 
                      if time_stamp = mod_time then 
                        () 
                      else 
                        load_object (SOME (file, mod_time)) unit
                    else
                      load_object (SOME (obj_file, obj_time)) unit
             end handle OS.SysErr _ =>
                   (mesg_fn (location,
                           "Object file " ^ file ^ " has disappeared");
                    load_object get_object unit))
        | NONE => 
            load_object get_object unit
      end

  fun check_module (module_id, is_pervasive, 
                    units, files, subprojects, library_path, object_dir, error_info, location) =
      (* Do we have an entry for this unit in the project? *)
      case NewMap.tryApply' (units, module_id) of 
        SOME unit =>
          (check_src (unit, module_id, is_pervasive, files, error_info, location, object_dir);
           check_obj (unit, module_id, is_pervasive, library_path, object_dir, location);
           (units, SOME unit))
      | NONE =>
          if is_pervasive 
          then
            let
              val sml_info = findPervasiveSource module_id
              val mo_info =  findPervasiveObject module_id

              val (units', unit) = 
                  new_unit
                    error_info
                    (true, units, module_id, sml_info, mo_info, NONE, object_dir)
            in
              (units', SOME unit)
            end
          else
            let
              (* If unit is found in subprojects, then do nothing else
               * create a new unit *)

              val unit = 
                  foldl combineOpt 
                        NONE 
                        (map (fn p => get_unit(p, module_id)) subprojects)

              val returnUnits = 
                  if isSome(unit) then 
                    (units, NONE)
                  else 
                    let 
                      val src_info = findSource (files, module_id)

                      val _ = diagnostic (3, fn _ => ["calling new_unit"]);
                      val (units', unit) = 
                        new_unit
                        error_info
                          (false, units, module_id, src_info, NONE, NONE, object_dir);

                      (* Don't search library path if we have source *)
                      val lib_path_opt =
                        if isSome src_info then NONE else SOME library_path
                    in
                      diagnostic (3, fn _ => ["calling load_object"]);
                      load_object
                        (findObject (object_dir, lib_path_opt, module_id))
                         unit;
                      (units', SOME unit)
                    end
              in
                returnUnits
              end

  (* read_dependencies takes a file name and returns a Project that comprises
     the units required by the named file (including the file itself).
     The is_pervasive flag tells it whether it is checking pervasive or user
     files.  The algorithm used is the same in both cases, except that the
     files are found in different locations.
     The seen argument is a map of modules that are known to have up to date
     dependency info stored in the project.  It is used to avoid
     reading information for a module more than once.  *)
  fun do_read_dependencies
        (error_info, location)
        (PROJECT {name, units, files, library_path, object_dir, 
		  subprojects, current_targets, disabled_targets, dependency_info},
	 module_id, seen_init)
	subprojects_read: (Project * StatusMap) =
    let
      fun getCurTargets (PROJECT {name, current_targets, ...}) = 
	if null current_targets then 
	  no_targets (error_info, location) name
	else
          map (fn t => ModuleId.from_host(t, location)) current_targets

      fun read_subproj_dependencies proj = 
	let 
	  val (pervasive_proj, pervasive_smap) = 
	    do_read_dependencies (error_info, location)
				 (proj, Io.pervasive_library_id, empty_map)
				 true

	  fun read_sub_dep (m, (proj, smap)) = 
	    do_read_dependencies (error_info, location)
			         (proj, m, smap)
			         false

	in
	    #1 (foldl read_sub_dep (pervasive_proj, pervasive_smap) (getCurTargets proj))
	end

      val subprojects = subprojects
(*        
	if subprojects_read then subprojects
	else 
	  map read_subproj_dependencies subprojects
*)

      (* The ancestors argument is a list of modules that have been
	 traversed en route to this one.  It is used to detect circularities. *)
      (* I think it's a pain that we have to traverse the ancestors list on
	 every call.  We could combine this info with the seen map (storing
	 true if the module is an ancestor and false otherwise).  Since we
	 have to check the seen table already, this would save lookup time,
	 but it would require resetting the entry when leaving the function,
	 which would probably take just as long. *)
      fun read_dependencies'
	    (location, ancestors)
	    ((units, seen), module_id) =
	    let
          (* First define some auxiliary functions. *)

	  val mod_name = ModuleId.string module_id

	  (* At this point we are not sure whether the module_id is pervasive 
	   * or not because the return value of sub_units below could contain 
	   * a mixture of pervasive and non-pervasive module ids if the 
	   * dependencies are read from the object file.
	   *)
	  val is_pervasive = ModuleId.is_pervasive (module_id)

  	  val _ =
            diagnostic (2,
              fn _ => ["read_dependencies called with `", mod_name, "'"])
        
	    (* The function sub_units may return a mixture of dependencies of 
	     * pervasive and non-pervasive files depending on whether the 
	     * dependencies are looked up from the object file or not.
	     *)
	    fun sub_units (unit as UNIT {requires, source, object, ...}) =
	      case !source
	      of SOME _ => requires_from_unit unit
	      |  NONE =>
		case !object
		of SOME {consistency = DEPEND_LIST cons, ...} =>
		  map
		    (fn {mod_name, ...} =>
		       ModuleId.from_mo_string (mod_name, Location.UNKNOWN))
		    cons
		|  NONE =>
		  (* Could check for a loaded module here -- if it exists,
		     a load command can continue.  But a compilation will
		     fall over, so we have to be pessimistic.
		     Daveb, 4/12/97. *)
		  Info.error' 
		    error_info
		    (Info.FATAL, location, 
			"In project: " ^ name ^ ", no such unit exists: " ^ mod_name)
          in
	    (* First check for circularities *)
	    if Lists.member (mod_name, ancestors) then
              Info.error'
                error_info
                (Info.FATAL, Info.Location.FILE mod_name,
                 concat
                   ("Circular require structure within"
                    :: map (fn x => "\n" ^ x) ancestors))
	    (* Now check whether we have already seen this module during this
	       call of read_dependencies. *)
            else
	      case NewMap.tryApply'(seen, module_id)
	      of SOME _ =>
                (diagnostic (3, fn _ => ["seen it!"]);
	         (units, seen))
	      |  NONE =>
	        (case
                    check_module (module_id, is_pervasive, 
                    units, files, subprojects, library_path, object_dir, error_info, location) 
		 of (units', SOME unit) =>
  	           Lists.reducel
		     (read_dependencies'
			(Location.FILE mod_name, mod_name :: ancestors))
		     ((units', mark_visited (seen, module_id)),
		      sub_units unit)
		 |  (units', NONE) => (units', mark_visited (seen, module_id)))
                handle Io.NotSet _ =>
                  Info.error'
                    error_info
                    (Info.FATAL, location, "Pervasive directory not set")
	  end
  
	val (units', seen') =
	  read_dependencies'
	    (location, [])
	    ((units, seen_init), module_id)

      in
        (PROJECT
	   {name = name,
	    units = units',
	    files = files,
	    library_path = library_path,
	    object_dir = object_dir,
	    subprojects = subprojects,
	    disabled_targets = disabled_targets,
	    current_targets = current_targets,
            dependency_info = dependency_info},
	 seen')
      end


  (* read_object_dependencies takes a file name and returns a Project that
     comprises the units required by the named object file (including the
     file itself).  This is used for compiling a single file.  The algorithm
     is basically the same as that in read_dependencies.
     The seen argument is a map of modules that are known to have up to date
     dependency info stored in the project.  It is used to avoid
     reading information for a module more than once.  *)
  fun read_object_dependencies
        (error_info, location)
        (proj as PROJECT {name, units, files, library_path, object_dir, 
		  subprojects, current_targets, disabled_targets, dependency_info},
	 module_id, seen_init): Project * StatusMap =
    let
      fun getCurTargets (PROJECT {name, current_targets, ...}) = 
	if null current_targets then
	  no_targets (error_info, location) name
	else
          map (fn t => ModuleId.from_host(t, location)) current_targets

      fun read_subproj_dependencies subproj = 
	let 
	  val (pervasive_proj, pervasive_smap) = 
	    do_read_dependencies (error_info, location)
				 (subproj, Io.pervasive_library_id, empty_map)
				 true

	  fun read_sub_dep (m, (proj, smap)) = 
	    do_read_dependencies (error_info, location)
			         (proj, m, smap)
			         false
	in
	  #1 (foldl read_sub_dep (pervasive_proj, pervasive_smap) (getCurTargets proj))
	end

      val subprojects = 
	map read_subproj_dependencies subprojects

      (* The ancestors argument is a list of modules that have been
	 traversed en route to this one.  It is used to detect circularities.
	 The location argument is where this function was called from. *)
      fun read_object_dependencies'
	    (location, ancestors)
	    (module_id, (units, seen)) =
        let
          (* First define some auxiliary functions. *)

	  val mod_name = ModuleId.string module_id

  	  val _ =
            diagnostic (2,
              fn _ => ["read_object_dependencies called with `",
  		       mod_name, "'"])
        
	  fun getObject' (unit as UNIT {source = src_info, ...}) = 
	    let 
	      (* Don't search the library path if a source file exists. *)
	      val lib_path_opt = 
		if isSome (!src_info) then NONE else SOME library_path
	    in
	      findObject (object_dir, lib_path_opt, module_id)
	    end

  	  fun check_obj' (unit, object) =
  	    case !object
  	    of SOME {file, time_stamp, consistency, file_time, stamps} =>
  	      (* Check whether the file on disk has changed *)
	      (let
		 val mod_time = FileTime.modTime file
		 val get_object = getObject' unit
	       in
		 case get_object of 
		   NONE => load_object NONE unit
		 | SOME (obj_file, obj_time) =>
		     if (obj_file = file) then
		       if time_stamp = mod_time then
			 ()
		       else
			 load_object (SOME (file, mod_time)) unit
		     else
		       load_object (SOME (obj_file, obj_time)) unit
	       end handle OS.SysErr _ =>
		 (mesg_fn (location,
			   "Object file " ^ file ^ " has disappeared");
  	          load_object
	            (findObject (object_dir, SOME library_path, module_id))
		    unit))
  	    |  NONE => 
  	      load_object
	        (findObject (object_dir, SOME library_path, module_id))
		unit

	   (* This function does the bulk of the work *)
           fun check_module' () =
  	      (* Do we have an entry for this unit in the project? *)
  	      case NewMap.tryApply' (units, module_id)
  	      of SOME (unit as UNIT {object, ...}) =>
  	        (check_obj' (unit, object);
  	         (units, SOME unit))
  	      |  NONE =>
		let 
		  val unit = 
		    foldl combineOpt 
			  NONE 
			  (map (fn p => get_unit(p, module_id)) subprojects)
		in
		  case unit of
		    NONE => 
  	              let
		        (* XXX I'm not sure that this works.  The code used to
		         * check for the existence of the object file before
		         * creating the new unit.
		         * - Does findObject cope OK in this case?  (Probably,
		         *   now that we've dropped %S).
		         * - Should we retract the new unit before reporting
		         *   the error?
		         *)
		        val (units', unit) = 
	                  new_unit
	                    error_info
	                    (false, units, module_id, NONE, NONE, NONE, object_dir);
  	              in
	                case findObject (object_dir, SOME library_path, module_id)
		        of mo_info as SOME _ =>
		          (load_object mo_info unit;
		           (units', SOME unit))
		        |  NONE =>
                          Info.error'
                            error_info
                             (Info.FATAL, Info.Location.FILE mod_name,
		             "No object file.")
		      end
		  | SOME u => 
		    (units, NONE)
		end

	    fun recurse ((units, seen), 
			 {mod_name = sub_name, time}) =
	       read_object_dependencies'
		 (Location.FILE mod_name, mod_name :: ancestors)
		 (ModuleId.from_mo_string (sub_name, Location.FILE mod_name),
		  (units, mark_visited (seen, module_id)))
          in
	    (* First check for circularities *)
	    if Lists.member (mod_name, ancestors) then
              Info.error'
                error_info
                (Info.FATAL, Info.Location.FILE mod_name,
                 concat
                   ("Circular require structure within"
                    :: map (fn x => "\n" ^ x) ancestors))
	    (* Now check whether we have already seen this module during this
	       call of read_object_dependencies. *)
            else
	      case NewMap.tryApply'(seen, module_id)
              of SOME _ =>
		(diagnostic (3, fn _ => ["seen it!"]);
	         (units, seen))
	      |  NONE =>
	        (case check_module' () of
  	           (units', 
		    SOME (UNIT {object =
			    ref (SOME {consistency = DEPEND_LIST (_ :: const),
				       ...}),
			    (* We skip the pervasive library entry. *)
			  ...})) =>
  	             Lists.reducel recurse ((units', seen), const)
		 | (units', NONE) => (units', seen)
	         | _ =>
                     Info.error'
                       error_info
                       (Info.FATAL, Info.Location.FILE mod_name,
		        "Invalid consistency information"))
                 handle Io.NotSet _ =>
                   Info.error'
                     error_info
                     (Info.FATAL, location, "Pervasive directory not set")
	  end

	(* Even though this is read_object_dependencies, we still need
	   the source information for the main file, or else we can't
	   compile it! *)
  	fun check_src' (unit, src_info) =
  	  case !src_info
  	  of sml_info as SOME (filename, time_stamp) =>
  	    (* Check whether the file on disk has changed *)
	    (let
	       val mod_time = FileTime.modTime filename
	     in
	       if time_stamp = mod_time then
		 ()
	       else
		 load_src
		   (false, error_info, SOME (filename, mod_time), unit, object_dir)
	     end handle OS.SysErr _ => 
	       (mesg_fn (location,
			 "Source file " ^ filename ^ " has disappeared");
  	        load_src
		  (false, error_info,
		   findSource (files, module_id),
		   unit, object_dir)))
  	  |  NONE => 
  	    load_src
	      (false, error_info,
	       findSource (files, module_id),
	       unit, object_dir)
    
	(* First, load the source info for the file being compiled. *)
	val (units, UNIT unit) =
  	  case NewMap.tryApply' (units, module_id)
  	  of SOME (unit as UNIT {source, ...}) =>
  	    (check_src' (unit, source);
  	     (units, unit))
  	  |  NONE =>
  	    let
  	      val sml_info =
		findSource (files, module_id)
  	    in
	      new_unit
	        error_info
	        (false, units, module_id, sml_info, NONE, NONE, object_dir)
  	    end

        val (units', seen') =
	  let
	    val mod_name = ModuleId.string module_id

	    fun recurse ((units, seen), require_id) =
	      read_object_dependencies'
		(Location.FILE mod_name, [mod_name])
		(require_id, (units, mark_visited (seen, module_id)))
	  in
  	    Lists.reducel recurse ((units, seen_init), 
                                   requires_from_unit (UNIT unit))
	  end
      in
        (PROJECT
	   {name = name,
	    units = units',
	    files = files,
	    library_path = library_path,
	    object_dir = object_dir,
	    subprojects = subprojects,
	    current_targets = current_targets,
	    disabled_targets = disabled_targets,
            dependency_info = dependency_info},
	 seen')
      end

  (* The following functions check whether the info in a project is
     consistent. *)

  (* compare_timestamp allows time stamps to differ by up to 5 seconds from
     the modification time of the file, to allow for InstallShield's unpleasant
     behaviour.  Now that we store time stamps in the consistency information
     of object files, instead of the modification times of the dependent files
     themselves, this doesn't affect us directly.  But it could affect people
     who distribute both source and object files.
     This function should be used whenever a time stamp stored in an object
     file is compared against the actual modification time of a source file.
     It is not needed when two stored time stamps are compared, or when the
     modification times of two source files are compared.  All comparisons
     of file times in _project are commented to explain whether
     compare_timestamp is needed. *)     
  fun compare_timestamp (t1, t2) =
    let
      val diff =
	if Time.<(t1, t2) then Time.-(t2, t1) else Time.-(t1, t2)
      val rdiff = Time.toReal diff
    in
      rdiff < real(5)
    end

  (* check_one_mo checks the time stamp of a given mo file against a
     supplied time.  The supplied time is always from the consistency
     information stored in an object file.  Since both times are read
     from object files, there is no need to use compare_timestamp. *) 
  fun check_one_mo (location, time, UNIT unit, sub_module_name) =
    case !(#object unit)
    of SOME {time_stamp, ...} =>
      (* if time = time_stamp then *)
      (* The encapsulator dumps out times as two integers, and it produces
         these two integers by first converting the time to a real.  If the 
         original time contained fractions of a second then these can be lost
         in the conversion.  So if file modification times can contain 
         fractions of a second then a simple equality check at this point can
         fail.  This seems to happen on FAT file systems for example.  So until
         the encapsulater is changed to dump times in a more reliable fashion
         we check to see if the times are the same to within a second. *)
      if Real.abs(Time.toReal time - Time.toReal time_stamp) < 1.0 then
	(diagnostic (3, fn _ => ["Time OK for `", sub_module_name, "'"]);
	 true)
      else
	(diagnostic (3, fn _ => ["Time mismatch for `", sub_module_name, "'"]);
	 false)
    |  NONE =>
      (mesg_fn (location,
		"can't find object info for `" ^ sub_module_name ^ "'");
       false)

  (* check_one_loaded checks the load time of a given module against a
     supplied time.  This time is usually from the dependency list of
     a loaded module, which stores the time that the dependent module
     was loaded.  If the times differ, the module containing the dependency
     list is out of date.
     The exceptional case is when check_one_loaded is called from is_valid_object
     (see that definition for an explanation).
     Since these times are not the modification times of delivered files, 
     there is no need to use compare_timestamp.  *)
  fun check_one_loaded
	(location, load_time', UNIT unit, sub_module_name) =
    case !(#loaded unit)
    of SOME {load_time, ...} =>
      if load_time = load_time' then
	(diagnostic (2, fn _ => ["load time OK for `", sub_module_name, "'"]);
	 true)
      else
	(diagnostic (2,
   	   fn _ => ["old load time for `", sub_module_name, "'"]);
	 false)
    |  NONE =>
      (mesg_fn (location,
	        "can't find loaded info for `" ^ sub_module_name ^"'");
       false)
  
  (* check_sub_unit checks one entry from a consistency list against the info
     stored in a project.  It requires the project to hold up-to-date info. *)
  fun check_sub_unit
	(error_info, location, project, check_perv, check_normal)
	{mod_name, time} =
    case ModuleId.from_string' mod_name
    of NONE =>
      (mesg_fn
	 (location,
          "invalid module name `" ^ mod_name ^ "' -- treating as out of date");
       false)
    |  SOME sub_module_id =>
      case get_unit (project, sub_module_id)
      of SOME unit =>
	if ModuleId.is_pervasive sub_module_id then
	  (diagnostic (3, fn _ => ["Calling check_perv for `", mod_name, "'"]);
	  check_perv (location, time, unit, mod_name))
	else
	  check_normal (location, time, unit, mod_name)
      |  NONE =>
        (diagnostic (1,
           fn _ => ["Module name `", mod_name,
		    "' from object file not found in project\n",
	            "-- treating as out of date"]);
	 false)

  (* check_dependencies checks a dependency list against the info stored in
     a project.  It returns true if the information is consistent.  *)
  fun check_dependencies
	(error_info, location)
        (proj, dependencies, check_one) =
    Lists.forall
      (check_sub_unit (error_info, location, proj, check_one, check_one))
      dependencies
  
  (* The following functions are passed to check_dep, to parameterise it on
     the sort of compiled objects being checked, .mo files or loaded modules. *)

  (* These validity checks are called to check that the files are safe to
     be loaded at all, in circumstances when we can't bring them up to date
     (e.g. loading object files without recompiling). *)

  fun always_valid _ _ args = args

  fun is_valid_object
	(error_info, location)
	(proj, level, module_id, UNIT unit)
	args =
	case !(#object unit) of
	  NONE =>
	    Info.error'
	    error_info
	    (Info.FATAL, location,
	     "No object file for : `" ^ ModuleId.string module_id ^ "'")
	| SOME {file_time, time_stamp, consistency = DEPEND_LIST cons, ...} =>
	    (* This rather convoluted construct suggests that Lists.findp
	     should really return an option type. *)
 	    (* check_sub_unit is passed check_one_loaded to check the pervasive
	       library.  This works because when the GUI images are built, the
	       loaded info for the pervasive modules is reset to store the
	       time stamps of the files (see reset_pervasives, below). *)
	    (case
	       Lists.findp
	         (not o
		  (check_sub_unit
	           (error_info, location, proj, check_one_loaded, check_one_mo)))
	         cons of
	       {mod_name, ...} =>
		 Info.error'
		   error_info
                   (Info.FATAL, location,
                    "Object file '" ^ ModuleId.string module_id ^
		    "' is out of date with respect to `" ^ mod_name ^ "'"))
	    handle
	      Lists.Find =>
	        (diagnostic (3, fn _ => ["object is valid"]);
	         args)

  (* check_compile_times checks the timestamp in an object file against the
     modification time of the corresponding source file.  If they are equal,
     it then calls check_dependencies to check the object file's consistency
     information. *)
  fun check_compile_times
	(error_info, location)
	(project, module_id, UNIT unit) =
    case !(#source unit)
    of NONE =>
      (* If no source file exists, we assume that the object file
         is up to date. *)
      (diagnostic (2, fn _ => [" no source unit"]);
       true)
    |  SOME (s_file, s_time) =>
      case !(#object unit)
      of SOME {time_stamp, consistency = DEPEND_LIST dependencies, ...} =>
	(* Since we are comparing a stored time stamp against the modification
	   time of an actual file, we use compare_timestamp to allow for
           slippage. *)
        if compare_timestamp (time_stamp, s_time) then
	  (diagnostic (2,
   	     fn _ => ["`", ModuleId.string module_id, "': source stamp OK"]);
	   check_dependencies
	     (error_info, location)
	     (project, dependencies, check_one_mo))
	else
	  false
      |  NONE =>
        (diagnostic (2, fn _ => [" no object file"]);
  	 false)
  (* check_object_load_times and check_object_source_times check the 
     dependencies of a loaded module.  They are complicated by the fact
     that a module may have been loaded from either a source file or an
     object file.

     If the module was loaded from a source file, and the file being 
     loaded is a source file, then it is enough to compare the modification
     time of the file against that in the loaded information. 

     If the module was loaded from a source file, and the file being loaded
     is an object file, or vice versa, then the modification time in the loaded
     info is compared with both the modification time in the source info and
     the time stamp in the object file.  If they are all equal, then the object
     file is equivalent to the loaded module.

     If the module was loaded from an object file, and the file being loaded
     is an object file, then the timestamp of the file being loaded is compared
     against the "modification time" in the loaded information. *)

  fun check_object_load_times
	(error_info, location)
	(project, module_id, UNIT unit) =
    case !(#object unit)
    of NONE =>
      Crash.impossible
        ("No object file for : `" ^ ModuleId.string module_id ^ "'")
    |  SOME {file_time, time_stamp, consistency = DEPEND_LIST cons, ...} =>
      case !(#loaded unit)
      of SOME {file_time = OBJECT time,
	       dependencies = DEPEND_LIST deps, ...} =>
 	(* The time and time_stamp are both read from the object file, so we
           don't need to use compare_timestamp. *)
        if time = time_stamp then
	  (diagnostic (2, fn _ =>
	     ["`", ModuleId.string module_id, "': object stamp OK"]);
	   check_dependencies
	     (error_info, location)
	     (project, deps, check_one_loaded))
	else
	  (diagnostic (2, fn _ =>
	     ["`", ModuleId.string module_id, "': object stamp out of date"]);
	   false)
      |  SOME {file_time = SOURCE time,
	       dependencies = DEPEND_LIST deps, ...} =>
        (case !(#source unit)
         of NONE =>
	   (diagnostic (2,
              fn _ =>
	        ["No source file for loaded compilation unit in load_object: ",
	         ModuleId.string module_id]);
	    (* Assume loaded module is up to date *)
	    true)
         |  SOME (s_file, s_time) =>
           (* We are now comparing a time stamp from an object file with
      	      the actual modification time of the source file, so we use
	      compare_timestamp to allow for slippage.  *)
           if compare_timestamp (time, s_time) then
	     (diagnostic (2, fn _ =>
	        ["`", ModuleId.string module_id, "': source stamp OK"]);
              if compare_timestamp (time_stamp, s_time) then
	        (diagnostic (2, fn _ =>
		   ["`", ModuleId.string module_id, "': object stamp OK"]);
		 (* At this point we know that both the loaded source
		    module and the object file are up to date w.r.t. the
		    source file. *)
	         check_dependencies
	           (error_info, location)
	           (project, deps, check_one_loaded))
	      else
	        (* Object file is older than the source. *)
	        (diagnostic (2, fn _ =>
	           ["`", ModuleId.string module_id, "': old object stamp"]);
	         false))
	   else
	     (* The loaded module is out of date. *)
	     (diagnostic (2, fn _ =>
	        ["`", ModuleId.string module_id, "': old object stamp"]);
	      false))
      |  NONE =>
        (diagnostic (2, fn _ => [" not loaded"]);
         false)

  fun check_source_load_times
	(error_info, location)
	(project, module_id, UNIT unit) =
    case !(#loaded unit)
    of SOME {file_time = SOURCE time, dependencies = DEPEND_LIST deps, ...} =>
      (case !(#source unit)
       of NONE =>
	 (diagnostic (2,
            fn _ =>
	      ["No source file for loaded compilation unit in load_source: ",
	       ModuleId.string module_id]);
	  (* Assume loaded module is up to date, since we can't reload it
	     even if we wanted to. *)
	  true)
       |  SOME (s_file, s_time) =>
	 (* We are comparing the modification time of two source files directly,
   	    so we don't have to allow for slippage; therefore we don't use
	    compare_timestamp. *)
         if time = s_time then
	   (diagnostic (2,
   	      fn _ => ["`", ModuleId.string module_id, "': source stamp OK"]);
	    check_dependencies
	      (error_info, location)
	      (project, deps, check_one_loaded))
	 else
	   (diagnostic (2,
   	      fn _ => ["`", ModuleId.string module_id, "': old source stamp"]);
	    false))
    |  SOME {file_time = OBJECT time, dependencies = DEPEND_LIST deps, ...} =>
      (case !(#object unit)
       of NONE =>
	 (diagnostic (2,
            fn _ =>
	      ["No object file for loaded compilation unit in load_source: ",
	       ModuleId.string module_id]);
	  (* Assume loaded module is up to date *)
	  true)
       |  SOME {file_time, time_stamp, ...} =>
	 (* We are comparing time stamps read from object files, therefore we
	    don't need to use compare_timestamp. *)
         if time = time_stamp then
	   (diagnostic (2,
   	      fn _ => ["`", ModuleId.string module_id, "': object stamp OK"]);
	    case !(#source unit)
	    of NONE =>
	      (* We should allow source files to depend on object files *)
	      (diagnostic (2, fn _ =>
		 ["No source file for `", ModuleId.string module_id,
		  "' assuming object file up to date"]);
	       (* Should check that object file is up to date w.r.t. its
		  dependencies. *)
	       true)
            |  SOME (s_file, s_time) =>
	      (* We are now comparing a time stamp with the actual modification
	         time of a source file.  Therefore we have to allow for slippage
 		 by using compare_timestamp. *)
	      if compare_timestamp (time_stamp, s_time) then
	        (diagnostic (2, fn _ =>
		   ["`", ModuleId.string module_id, "': file time OK"]);
	         check_dependencies
	           (error_info, location)
	           (project, deps, check_one_loaded))
              else
	        (diagnostic (2,
   	           fn _ => ["`", ModuleId.string module_id,
			    "': old file time"]);
	         false))
         else
	   (diagnostic (2,
   	      fn _ => ["`", ModuleId.string module_id, "': old object stamp"]);
	    false))
    |  NONE =>
      (diagnostic (2, fn _ => [" not loaded"]);
       false)

  fun get_sub_mos (UNIT unit) =
    case !(#object unit)
    of NONE => []
    |  SOME {consistency = DEPEND_LIST l, ...} =>
      map
	(fn {mod_name, ...} =>
	   ModuleId.from_mo_string (mod_name, Location.UNKNOWN))
	l

  (* This is used in check_dep to check whether any of the entries in the
     list of requires have already been found to need recompiling. *)
  fun check_visited_map([], _) = true
  |   check_visited_map(x :: xs, visited) =
    case NewMap.tryApply'(visited, x)
    of NONE => check_visited_map(xs, visited)
    |  SOME true => check_visited_map(xs, visited)
    |  SOME false => false

  (* check_dep recursively traverses the info stored in a project, working out
     which files need to be recompiled.  It requires the project info to be
     up to date.  It does not actually compile the out-of-date units.
       check_validity: a function to check the validity of the current unit;
		       raises an exception if invalid; called before checking
		       dependencies.  Returns an updated (out_of_date, visited)
		       pair, which allows check_load_source to check the
		       time stamps of library object files.
       check_times: a function to check the time stamps of the current unit;
		    called only if the dependents are up to date.
       get_sub_units: a function that returns a list of sub_units
       project: the current project info
       module_id: the unit to recompile
       out_of_date: a list of units to be recompiled.
       visited: a status map; stored whether a unit has been visited, or
		up to date. 
       real_ids: a list of the module_ids corresponding to the requires
		in the parent file.
		
     Returns an updated (out_of_date, visited, real_ids) tuple.
     This function may be folded over a list of module_ids.
   *)

  (* This function should check the up-to-dateness of sub-projects as a whole.
   * A sub-project is out of date if any of its files are out of date.  This check
   * can be more easily done if the source path has been replaced by a list of 
   * files. 
   *)
  fun check_dep
        (error_info, level, get_sub_units,
	 check_times, check_validity, project as PROJECT {units, subprojects, ...})
        ((out_of_date, visited, real_ids), module_id) =
    (* The following test is commented out because we now only track the
       real module_id, which may be different (see below).  Possibly the
       read_dependencies function should add a pass so that the requires
       line of each unit contains only real module_ids.  It all depends
       where we want the time to go. *)
    (*
    if NewMap.exists (fn (m, _) => m = module_id) visited then
      (out_of_date, visited)
    else
    *)
      let
	val mod_name = ModuleId.string module_id
  
        val _ =
	  diagnostic (2,
   	    fn _ => [Int.toString level, " `", mod_name, "'"]);

	fun undefined_module mod_id  = 
  	  Crash.impossible ("Undefined module: " ^ ModuleId.string mod_id)

	fun get_defined_unit mod_id = 
	  case get_unit (project, mod_id)
	  of SOME unit => unit
	   | NONE => undefined_module mod_id

	val UNIT unit = get_defined_unit module_id
    
	val real_mod_id = #name unit
	(* The real module_id for this unit is #name unit.  This may differ
	   from the module_id that was passed as an argument, because
	   #name unit has resolved any symbolic links.  Not all aliases are
	   stored in a project, e.g.  if "system.__path" resolves to
	   "unix.__path", and this contains a require for "unix._unixpath",
	   then "system._unixpath" will not be found in the project, even
	   though it is a valid id. *)

	val unit_time = case !(#object unit) of
	  NONE => NONE
	| SOME{file_time, ...} => SOME file_time

	fun check_object_time module_id =
	  (* This function checks the relationship between the object files *)
	  (* for the module parameter to check_dep, and some module it depends on *)
	  (* It returns true for up to date, false for out of date *)
	  case unit_time of
	    NONE => false (* Definitely out of date, but probably shouldn't happen *)
	  | SOME unit_time =>
	      let
		val UNIT sub_unit = get_defined_unit module_id
	      in
		case !(#object sub_unit) of
		  NONE => false (* This shouldn't happen, as this case shouldn't be passed to check_object_time *)
		| SOME{file_time, ...} => Time.>=(unit_time, file_time)
	      end
      in
        if NewMap.exists (fn (m, _) => ModuleId.eq(m,real_mod_id)) visited then
	  (out_of_date, visited, real_mod_id :: real_ids)
	else
	  let
	    val (out_of_date, visited, _) =
	      check_validity
		(error_info, Location.FILE mod_name)
		(project, level, module_id, UNIT unit)
	        (out_of_date, visited, [])

	    val sub_units = get_sub_units (UNIT unit)

            (* Check all the sub_modules *)
            val (out_of_date_now, visited_now, real_sub_ids) =
              Lists.reducel
    	        (check_dep
	           (error_info, level + 1, get_sub_units,
		    check_times, check_validity, project))
    	        ((out_of_date, visited, []), sub_units)
          in
            (* We have to recompile this unit if any of its sub-units need to
               be recompiled, or if the source for this one has been changed
	       (or if it has no object file). *)
	    (*
            if out_of_date_now = out_of_date
	    We could add a quick test here, but comparing the whole list
	    is unnecessary.  If the first elements are different, that
	    will be enough (we would also need to check the nil case).
	    *)
	    if check_visited_map (real_sub_ids, visited_now) andalso
	      check_times
	      (error_info, Location.FILE mod_name)
	      (project, module_id, UNIT unit) andalso
	      Lists.forall check_object_time sub_units
	    then
  	      (* we are up to date *)
              (out_of_date_now, 
	       mark_compiled (visited_now, real_mod_id),
	       real_mod_id :: real_ids)
            else
              (real_mod_id :: out_of_date_now,
	       mark_visited (visited_now, real_mod_id),
	       real_mod_id :: real_ids)
          end
      end
    
  
  (* USER COMMANDS START HERE *)
  
  (* Initialise: create a new project.  Load info about the pervasive files.
     Load_dependencies: given a file name, recursively load source dependencies
        from that file.  If project already contains info about this unit,
        check the modification time of the source and object files.  If the
        project doesn't have info about this file, or the a file has changed,
        load info from disk.  If the source file has changed, read the requires
        from the new file.  If adding an entry, check for an object file.  If
        project contains no info and source file doesn't exist, check for an
        object file, but don't follow its dependencies.  (We will need to
        improve on this, differentiating source dependencies and object
        dependencies).
  *)
  
  (* list_units returns a list of the names of the modules in a project,
     as pairs of strings and module_ids, sorted alphabetically. *)
  fun list_units (PROJECT {units, ...}) =
    Lists.msort
      (fn ((s, _), (s', _)) => s < s')
      (map (fn m => (ModuleId.string m, m)) (NewMap.domain units))
  
  (* The initialize command creates an empty project *)
  fun initialize (error_info, location) =
    let
      val project =
        PROJECT
          {name = "",  (* WWW: should this be the empty string or something else? *)
	   units = NewMap.empty (ModuleId.lt, ModuleId.eq),
           files = [],
           library_path = [],
           object_dir = {base = "", config = "", mode = ""},
	   subprojects = [],
           current_targets = [],
           disabled_targets = [],
           dependency_info = DEPEND([],[])}
    in
      #1 (do_read_dependencies
            (error_info, location)
            (project, Io.pervasive_library_id, empty_map) false)
    end
  
  (* Not clear what this should do now. *)
  fun delete (PROJECT {name, units, files, library_path, object_dir,
		       subprojects, current_targets, disabled_targets, dependency_info}, 
	      module_id,
	      delete_from_sub) =
    PROJECT
      {name = name,
       units = NewMap.undefine (units, module_id),
       files = files,
       library_path = library_path,
       object_dir = object_dir,
       subprojects = if delete_from_sub then 
			map (fn p => delete (p, module_id, true)) subprojects
		     else 
		 	subprojects,
       current_targets = current_targets,
       disabled_targets = disabled_targets,
       dependency_info = DEPEND([],[])}

  fun display_dependency_info (info as h :: t) =
      let
        open MLWorks.Internal.Array
        val _ = print "Displaying dependencies\n"
        val max_node = 
            foldl (fn ((set, GD.DAG {seq_no,...}),max) => Int.max(max, seq_no))
                  0 info
        val info_array = array(max_node + 1, h)
        val _ = app (fn info_node as (set, GD.DAG {seq_no,...}) =>
                       update(info_array, seq_no, info_node)) info

        fun display_dependency 
              (set, GD.DAG {seq_no,marked,smlsource,symmap,intern,extern}) = 
            (print(ModuleId.string smlsource); print " (";
             print (ImportExport.ModuleName.setToString set); 
             print ")\n";
             app (fn GD.DAG {smlsource, ...} =>
                  print ("  -> " ^ (ModuleId.string smlsource) ^ "\n"))
                 (OrderedSet.makelist intern)
            )
(*
         fun loop n = if n > max_node then ()
                      else ( display_dependency(sub(info_array, n));
                             loop (n + 1) )
*)
       in (* loop 0; *)
          app display_dependency info;        
          print "Done\n"
      end
    | display_dependency_info [] = ()

  fun calculate_dependency_info (name, files, units, all_targets, env_fn) =
      let val _ = diagnostic (1, fn _ => ["Calculating dependencies for ", 
                                          name])
          val all_target_mids =
            map (fn t => ModuleId.from_host(t, Location.FILE t)) 
                all_targets
        
          fun is_target m =
              List.exists (fn m' => ModuleId.eq(m,m')) all_target_mids

          fun cvt m = 
              let val UNIT {mod_decls, ...} = valOf(NewMap.tryApply' (units, m))
               in (m, #1(!mod_decls), is_target m) end
              handle exn => 
                (print "cvt error!\n"; 
                 print("Looking for " ^ (ModuleId.string m) ^ "\n");
                 app (fn m => print("  " ^ (ModuleId.string m) ^ "\n"))
                     (NewMap.domain units);
                 raise exn)

          val units_list = 
              map cvt 
                (Lists.filterp (not o ModuleId.is_pervasive) (NewMap.domain units))
          fun eq_dag (GD.DAG { seq_no = s1, ... }: dag,
              GD.DAG { seq_no = s2, ... }) = s1 = s2
          fun lt_dag (GD.DAG { seq_no = s1, ... }: dag,
	      GD.DAG { seq_no = s2, ... }) = s1 < s2
          val { union = union_dag, addl = addl_dag, makeset = makeset_dag, ... } =
              OrderedSet.gen { eq = eq_dag, lt = lt_dag }

          val dependencies = 
              GD.analyze { union_dag = union_dag,
                       smlsources = units_list,
                       enone = empty_mid_set,
                       eglob = env_fn,
                       ecombine = union_mid_set,
                       seq_no = ref 0 }
          fun unit_of m = valOf(NewMap.tryApply' (units, m))

          fun update_requires
                (set, GD.DAG {seq_no,marked,smlsource,symmap,intern,extern}) = 
              let val UNIT unit = unit_of smlsource
                  val {implicit, explicit, subreqs} = !(#requires unit)
                  val implicit = 
                    map (fn GD.DAG {smlsource, ...} => smlsource)
                        (OrderedSet.makelist intern)
                  val subreqs = OrderedSet.makelist extern
                  fun eq m1 m2 = ModuleId.eq(m1,m2)
                  val explicit =
                    List.filter (not o (member_mid_set extern)) explicit
                  val (_, partial_info) = !(#mod_decls unit)
               in case explicit of
                    [] => #requires unit := {explicit=[], implicit=implicit,
                                             subreqs=subreqs}
                  | _ =>
                      let fun print_warning (m, missing, definite) =
                            if partial_info then () else
                            ( print ( "Require of " 
                                    ^ (ModuleId.string m)
                                    ^ " in unit " 
                                    ^ (ModuleId.string smlsource));
                              if missing
                              then
                                print " is missing.\n"
                              else if definite then 
                                print " is unnecessary.\n"
                              else
                                 print " may be unnecessary.\n" )
                      in
                        app (fn m =>
                               if List.exists (eq m) implicit
                               then ()
                               else 
                                 case NewMap.tryApply' (units, m) of
                                   NONE =>
                                     if true (* redundant_requires *)
                                     then ()
                                     else print_warning(m,false,true) 
                                 | SOME _ =>
                                     print_warning(m,false,false))
                            explicit;
                        app (fn m =>
                               if List.exists (eq m) explicit
                               then ()
                               else print_warning(m,true,false))
                            implicit;
                       
                        #requires unit := 
                        {explicit=explicit, implicit=implicit, subreqs=subreqs}
                      end
               end

       in app update_requires dependencies;        
          dependencies
    end handle _ => []


  fun read_dependencies info (p, m, smap) =
    let
      val _ = 
        diagnostic (1,
          fn _ => ["Calling read_dependencies on pervasive library"]);

      val (p', smap') =
	do_read_dependencies
	  info
	  (p, Io.pervasive_library_id, smap) 
	  true
    in
      diagnostic (1,
        fn _ => ["Calling read_dependencies on " ^ ModuleId.string m]);
      do_read_dependencies info (p', m, smap') false
    end

  (* The check commands take a module_id and calls check_dep to find which
     files need to be recompiled to bring that module up to date. *)
  fun check_load_objects (error_info, location) (project, module_id) = 
    let
      val (out_of_date, _, _) =
        check_dep
	  (error_info, 0, get_sub_mos,
	   check_object_load_times, is_valid_object, project)
	  (([], visited_pervasives, []), module_id)
    in
      rev out_of_date
    end

  fun source_exists
	(error_info, location)
	(project, level, module_id, UNIT unit)
	(out_of_date, visited, real_ids) =
    case !(#source unit)
    of NONE =>
      let
	(* If an object file exists, check it. *)
        val sub_units = get_sub_mos (UNIT unit)
      in
        (* Check all the sub_modules *)
        Lists.reducel
          (check_dep
            (error_info, level + 1, get_sub_mos,
	     check_object_load_times, is_valid_object, project))
    	   ((out_of_date, visited, []), sub_units)
      end
    |  _ => (out_of_date, visited, real_ids)

  fun check_load_source (error_info, location) (project, module_id) = 
    let
      val (out_of_date, _, _) =
        check_dep
	  (error_info, 0, requires_from_unit,
	   check_source_load_times, source_exists, project)
	  (([], visited_pervasives, []), module_id)
    in
      rev out_of_date
    end

  fun check_compiled (error_info, location) (project, module_id) = 
    let
      val (out_of_date, _, _) =
        check_dep
	  (error_info, 0, requires_from_unit,
	   check_compile_times, always_valid, project)
	  (([], visited_pervasives, []), module_id)
    in
      rev out_of_date
    end

  (* The check_compiled' command takes a module_id and calls check_dep
     to find which files need to be recompiled to bring that module up to
     date.  It differs from check_compiled in that it takes explicit
     (out_of_date, visited) arguments, and returns updated versions of both. *)
  fun check_compiled'
	(error_info, location) (project, module_id) (out_of_date, visited) =
    let
      val (out_of_date_now, visited_now, _) =
        check_dep
	  (error_info, 0, requires_from_unit,
	   check_compile_times, always_valid, project)
	  ((rev out_of_date, visited, []), module_id)
    in
      (rev out_of_date_now, visited_now)
    end

  (* The check_perv commands call check_dep to find which files need
     to be recompiled to bring the pervasive library up to date. *)
  fun check_perv_compiled (error_info, location) project = 
    let
      val (out_of_date, _, _) =
        check_dep
	  (error_info, 0, requires_from_unit,
	   check_compile_times, always_valid, project)
	  (([], empty_map, []), Io.pervasive_library_id)
    in
      rev out_of_date
    end

  fun check_perv_loaded (error_info, location) project = 
    let
      val (out_of_date, _, _) =
        check_dep
	  (error_info, 0, requires_from_unit,
	   check_source_load_times, always_valid, project)
	  (([], empty_map, []), Io.pervasive_library_id)
    in
      rev out_of_date
    end

  (* allObjects returns a list of all object files, ordered by
     dependency.  It is used to write a file for use by the loader. *)
  fun allObjects (error_info, location) (project, module_id) =
    let
      (* The check_times argument to check_dep always returns false,
	 so that every file is added to the list.
	 XXX I attempted to call is_valid_object to check that the object
	     files are up to date.  But is_valid_object checks validity
	     w.r.t. loaded pervasive library (i.e. for loading into the
	     GUI).
	 XXX I'm not sure about get_sub_mos: it silently returns an
	     empty list is the unit doesn't include any object info.
	     But is_valid_object should catch this case first. *)
      val (out_of_date, _, _) =
        check_dep
	  (error_info, 0, get_sub_mos,
	   fn _ => fn _ => false, always_valid, project)
	  (([], empty_map, []), module_id)
    in
      rev out_of_date
    end

  (* reset_pervasives is called after loading the pervasive files into
     the interpreter.  It ensures that the load time of the pervasive
     modules is kept, but that information about the files on disk is
     removed.  The key difference with remove_file_info (below) is that
     we currently compile the pervasives from source, but need to store
     info about the object files in the loaded field.  *)
  local
    fun reset_file_info (_, UNIT unit) =
      (* First we store the time_stamp of the compiled pervasive file in
         the loaded information, so that we don't load objects that were
         compiled with different pervasives. *)
      let
        val r = #loaded unit
      in
        case !(#object unit) of
	  SOME {time_stamp, file_time = object_time, ...} =>
	    (case !r of
	       SOME {basis, id_cache, module, dependencies, ...} =>
		 r := SOME
		 {file_time = OBJECT object_time,
		  load_time = time_stamp,
		  basis = basis,
		  id_cache = id_cache,
		  module = module,
		  dependencies = dependencies}
	     (* Preserve the dependencies, because type decapsulation needs them *)
	     | NONE =>
		 Crash.impossible
		 ("Can't find loaded info for `"
		  ^ ModuleId.string (#name unit)
		  ^ "' in reset_pervasives"))
        | NONE =>
	       Crash.impossible
	       ("Can't find object file for `"
		^ ModuleId.string (#name unit)
		^ "' in reset_pervasives");
	       #object unit := NONE;
	       #source unit := NONE;
	       #requires unit := {implicit=[],explicit=[],subreqs=[]}
      end
  in
    fun reset_pervasives (PROJECT {units, ...}) =
      NewMap.iterate 
        reset_file_info
        units
  end

  (* This is used to remove all path names when we save an image. *)
  local
    fun reset_file_info (_, UNIT unit) =
      (#object unit := NONE;
       #source unit := NONE;
       #requires unit := {implicit=[],explicit=[],subreqs=[]})
  in
    fun remove_file_info (PROJECT {units, subprojects, ...}) =
      (NewMap.iterate 
	reset_file_info
	units;
       app remove_file_info subprojects)
  end
    
  fun pad_out_units(files, units, updating, library_path, object_dir, error_info) =
      let fun pad ([], units) = units
            | pad (filename::t, units) =
                let val location = Location.FILE filename
                    val module_id = 
                      ModuleId.from_host (OS.Path.file filename, location) 
                 in case NewMap.tryApply' (units, module_id) of
                      SOME unit => 
                        if updating 
                        then 
                          ( check_src (unit, module_id, false, 
                                       files, error_info, location, object_dir);
                            check_obj (unit, module_id, false, 
                                       library_path, object_dir, location);
                            pad(t, units))
                        else 
                          pad(t, units)
                    | NONE =>
                        let val src_info = 
                              let
                                val mod_time = FileTime.modTime filename
                              in
                                SOME (filename, mod_time)
                              end
                              handle OS.SysErr _ => NONE
                            val (units', unit) = 
                              new_unit
                               error_info
                               (false, units, module_id, src_info, 
                                NONE, NONE, object_dir);

                            (* Don't search lib path if we have source *)
                            val lib_path_opt =
                              if isSome src_info 
                              then NONE else SOME library_path
                         in
                           load_object
                             (findObject (object_dir, lib_path_opt, module_id))
                             unit;
                           pad(t, units')
                        end
                end
         val units' = pad(files, units)

         val (units_plus_builtin,_) = 
            check_module(Io.builtin_library_id, true,
                   units',files,[],library_path,object_dir,
                   error_info, Location.UNKNOWN)
         val (units_plus_builtin_plus_pervasive,_) = 
            check_module(Io.pervasive_library_id, true,
                   units_plus_builtin,files,[],library_path,object_dir,
                   error_info, Location.UNKNOWN)
       in 
         units_plus_builtin_plus_pervasive
      end

  fun partition_dependencies current_targets dependencies =
      let 
        val current_target_mids =
          map (fn t => ModuleId.from_host(t, Location.FILE t)) 
              current_targets
          
        fun is_current_target m =
            List.exists (fn m' => ModuleId.eq(m,m')) current_target_mids
      in
        List.partition
          (fn (_, GD.DAG{smlsource, ...}) => is_current_target smlsource)
          dependencies
      end

  fun lookup_function units =
      let
        fun cvt m = 
            let val UNIT {mod_decls, ...} = valOf(NewMap.tryApply' (units, m))
             in (m, #1(!mod_decls)) end

        val (pervasives', _) = 
              Lists.partition ModuleId.is_pervasive (NewMap.domain units)
        val pervasives_list = map cvt pervasives'

        fun mk_lookup (name, decl, default) =
            ImportExport.imports (decl, empty_mid_set, default, union_mid_set, name)

        val Compiler.BASIS{lambda_environment, ...} =
            Compiler.initial_basis

        val initial_env_fn = 
            fn m => raise ImportExport.Undefined m

        val env_fn =
          case pervasives_list of
            [(builtin, builtin_dec), (pervasive, pervasive_dec)] =>
               let val env_fn' =
                     let val (f, i, _) =
                         mk_lookup(ModuleId.string builtin, 
                                   builtin_dec, initial_env_fn)
                      in fn m => (f m,i)
                     end
                   val env_fn'' =
                     let val (f, i, _) =
                         mk_lookup(ModuleId.string pervasive, 
                                   pervasive_dec, env_fn')
                      in fn m => (f m,i)
                     end
               in
                 fn m => env_fn'' m
                         handle ImportExport.Undefined _ =>
                                env_fn' m
                                handle ImportExport.Undefined _ => 
                                       initial_env_fn m
               end
          | _ => initial_env_fn

        fun lookup subprojects modulename =
          let open ImportExport
              fun search [] = 
                    env_fn modulename
                | search ((project as 
                           PROJECT {dependency_info = DEPEND (depinfo,_), 
                                    ...})
                          :: t) =
                    let fun find_in [] = search t
                          | find_in ((set, GD.DAG {symmap,smlsource, ...}) :: rest) =
                              if ModuleName.memberOf set modulename
                              then (symmap modulename, singleton_mid_set smlsource)
                              else find_in rest
                     in find_in depinfo end
           in search subprojects 
          end
   in lookup 
  end

  (* The idea of preserving the units is not to lose information about
     loaded files.  But this doesn't really work, because if the source
     path changes some of the loaded information will be out of date. *)
  fun fromFileInfo
	(error_info, loc)
	(proj as (PROJECT {units, subprojects, ...})) =
    let
      fun getFullFilename (filename, dirName) = 
        let 
          val local_name = OS.Path.fromUnixPath filename
	  val abs_name = OS.Path.mkAbsolute {path=local_name, relativeTo=dirName}
        in
	  abs_name
        end

      val (projName, projDir) = 
	(getOpt (ProjFile.getProjectName(), ""),
	 ProjFile.getProjectDir())

      val projectName = getFullFilename (projName, projDir)

      val (curTargets, disTargets, _) =
	ProjFile.getTargets ()

      val (libraryPath, objectsLoc, binariesLoc) =
	ProjFile.getLocations ()

      val (_, configDetails, currentConfig) = ProjFile.getConfigurations ()
      val (_, modeDetails, currentMode) = ProjFile.getModes ()

      fun toAbs s = OS.Path.mkAbsolute {path=s, relativeTo=projDir}

      val common_files = ProjFile.getFiles()

      val (filesC, libraryC, binariesC, config_ext) =
	case currentConfig of
	  NONE => (common_files, libraryPath, binariesLoc, "")
	| SOME name =>
	  (case ProjFile.getConfigDetails (name, configDetails) of
	     {files, library, ...} =>
	        (files @ common_files,
	         library @ libraryPath,
		 OS.Path.concat[binariesLoc, name],
                 name))
        (* XXX - handler needed for NoConfigDetailsFound -
	  or put this functionality in ProjFile *)

      val (files, library, binaries, mode_ext) = 
	case currentMode of 
	  NONE => (filesC, libraryC, binariesC, config_ext)
	| SOME modeName => 
	  (case ProjFile.getModeDetails (modeName, modeDetails) of 
	     {location, ...} => 
		(filesC, libraryC, 
		 OS.Path.concat[binariesC, !location],
		 !location))

      val (abs_files, abs_library, abs_objects, abs_binaries) =
	if OS.Path.isRelative projDir then
	  (* projDir should always be absolute, but we need to return some
	     value in the exceptional case. *)
	  (diagnostic (1, fn _ => ["Project Dir is relative: ", projDir]);
	   (files, library, 
            {base = objectsLoc, config = config_ext, mode = mode_ext},
            binaries))
	else
	  (diagnostic (1, fn _ => ["Project Dir is absolute: ", projDir]);
	   (map toAbs files,
	    map toAbs library,
	    {base = toAbs objectsLoc, config = config_ext, mode = mode_ext},
	    toAbs binaries))

      fun mkdir' s = 
	(if OS.FileSys.isDir(s) then 
	  () 
	else 
	  Info.error' error_info 
	    (Info.FATAL, loc,
            s ^ " is not a valid directory or is inaccessable."))
	handle OS.SysErr _ => 
	   (mkdir' (OS.Path.getParent s); OS.FileSys.mkDir s);

      fun mkdir s = mkdir' (OS.Path.fromUnixPath s)

      val mk_obj_dir =
        let val {base, config, mode} = abs_objects 
         in mkdir (OS.Path.mkCanonical(OS.Path.concat[base, config, mode]))
        end

(*      val mk_bin_dir = mkdir abs_binaries *)

      fun get_proj_units projName (PROJECT {name, subprojects, units, ...}) = 
	if (projName = name) then
	  SOME units
	else get_next_proj_units projName subprojects

      and get_next_proj_units projName [] = NONE
	| get_next_proj_units projName (p::rest) = 
	case (get_proj_units projName p) of
	  SOME u => SOME u
	| NONE => get_next_proj_units projName []

      val units' = pad_out_units(abs_files, units, false, abs_library, abs_objects, error_info) 

      val lookup = lookup_function units'

      val project_cache = ref empty_project_cache
 
      fun getSubDetails config filename = 
	let val filename = getFullFilename (filename, projDir)
            val {name, files, libraryPath, objectsLoc, binariesLoc, 
                 configDetails, modeDetails, subprojects, 
                 curTargets, disTargets, currentMode, ...} = 
                     ProjFile.peek_project filename
        in case NewMap.tryApply' (!project_cache, 
               {filename = filename, targets = curTargets}) of 
             SOME subproject => subproject
           | NONE =>
               let 
                   val {name=configName, files=filesC, library=libraryC} = 
                        ProjFile.getConfigDetails (getOpt(config, ""),
                                                   configDetails)
                        handle ProjFile.NoConfigDetailsFound c => 
                          {name = "", files = [], library = []}

                   val modeName = getOpt(currentMode, "")

                   val {location, ...} = 
                     ProjFile.getModeDetails (modeName, modeDetails)
                     handle ProjFile.NoModeDetailsFound m =>
                     Info.error' error_info
                       (Info.FATAL, loc, 
                        "No mode found or none set when getting details of sub projects")

                   val dir = OS.Path.dir name
                   fun mk_abs f = OS.Path.mkAbsolute {path=f, relativeTo=dir}
                   val abs_files = map mk_abs (files @ filesC)
                   val abs_library = map mk_abs (libraryPath @ libraryC)
                   val abs_objects = 
                     {base = 
                         OS.Path.mkAbsolute {path=objectsLoc, relativeTo=dir},
                      config = configName, mode = !location }
                   val abs_binaries = 
                     OS.Path.mkAbsolute 
                       {path=OS.Path.concat[binariesLoc, configName, !location], 
                        relativeTo=dir}

                   val subprojDir = OS.Path.dir filename
                   fun getProjName n = getFullFilename (n, subprojDir)
                   val subprojects = map getProjName subprojects
                   val units = getOpt (get_proj_units name proj, NewMap.empty (ModuleId.lt, ModuleId.eq))
                   val units' = pad_out_units(abs_files, units, false, abs_library, abs_objects, error_info) 
                   val subprojects = map (getSubDetails config) subprojects
                   val dependency_info = DEPEND([],[])
                   val subproject = 
                     PROJECT {name = name,
                       units = units',
                       files = abs_files,
                       library_path = abs_library,
                       object_dir = abs_objects,
                       subprojects = subprojects,
                       current_targets = curTargets,
                       disabled_targets = disTargets,
                       dependency_info = dependency_info}
                in
                  project_cache := 
                    NewMap.define (!project_cache, 
                       { filename=filename,
                         targets=curTargets }, 
                       subproject);
                  subproject
               end
	end 

      val subprojects = 
	if isSome(ProjFile.getProjectName()) then
	  let val proj_name = valOf(ProjFile.getProjectName())
	  in
	    map (getSubDetails currentConfig) (ProjFile.getSubprojects())
	  end
	else []

      val dependency_info = DEPEND([],[])

      val new_proj =
        PROJECT
          {name = projectName,
	   files = abs_files,
           library_path = abs_library,
           object_dir = abs_objects,
	   subprojects = subprojects,
           current_targets = curTargets,
           disabled_targets = disTargets,
           dependency_info = dependency_info,
           units = units'} (* getOpt (get_proj_units projectName proj, NewMap.empty' ModuleId.lt)} *)

    in
      ignore(ProjFile.changed());
      new_proj
    end
    
  fun update_dependencies (error_info, loc) proj =
  let 
    fun update (proj as PROJECT {name, units, files, library_path, object_dir,
                   subprojects, current_targets, disabled_targets,
                   dependency_info}) = 
        let   
          val units' = pad_out_units(files, units, true, library_path, 
                                     object_dir, error_info) 

          val lookup = lookup_function units'

          val (current, other) =
              partition_dependencies current_targets
                 (calculate_dependency_info(name, files, units',
                                            current_targets @ disabled_targets,
                                                  lookup subprojects))
          val dependency_info' =DEPEND (current,other)

          val proj' = PROJECT
            {name = name, units = units', files = files,
             library_path = library_path, object_dir = object_dir,
             subprojects = subprojects, dependency_info = dependency_info',
             current_targets=current_targets, disabled_targets=disabled_targets}

          val init_proj =
            #1 (do_read_dependencies
                 (error_info, loc)
                  (proj', Io.pervasive_library_id, empty_map)
    	      true)

          fun do_one (target, (p, smap)) =
            do_read_dependencies
        	  (error_info, loc)
	          (p, ModuleId.from_host (target, loc), smap)
	          false

          val result =
            if null current_targets then 
              no_targets (error_info, loc) name
            else
              #1 (foldl do_one (init_proj, empty_map) current_targets)
        in
         result
       end 
   in (* map_dag *) update proj
  end
end


