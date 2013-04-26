(*
 * $Log: project.sml,v $
 * Revision 1.19  1999/03/18 08:50:49  mitchell
 * [Bug #190532]
 * Export map_dag
 *
 * Revision 1.18  1999/02/09  09:50:01  mitchell
 * [Bug #190505]
 * Support for precompilation of subprojects
 *
 * Revision 1.17  1998/11/26  10:46:05  johnh
 * [Bug #70240]
 * Change delete function and add function to return units in main project only.
 *
 * Revision 1.16  1998/04/24  15:30:43  mitchell
 * [Bug #30389]
 * Keep projects more in step with projfiles
 *
 * Revision 1.15  1998/04/22  14:41:54  jont
 * [Bug #70091]
 * Remove req_name from DEPEND_LIST
 *
 * Revision 1.14  1998/02/06  11:24:32  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 * Added pervasiveObjectName.
 *
 * Revision 1.13  1997/10/20  16:33:43  jont
 * [Bug #30089]
 * Replacing MLWorks.Time with Time from the basis
 *
 * Revision 1.12.2.5  1997/12/03  19:22:34  daveb
 * [Bug #30071]
 * Made fromFileInfo take a project to update.
 * Removed update function.
 *
 * Revision 1.12.2.4  1997/11/26  16:23:04  daveb
 * [Bug #30071]
 * Removed Module type.
 *
 * Revision 1.12.2.3  1997/10/29  11:48:46  daveb
 * Merged from trunk:
 * Replacing MLWorks.Time with Time from the basis
 *
 * Revision 1.12.2.2  1997/09/17  15:41:44  daveb
 * [Bug #30071]
 * Converted build system to project workspace.
 *
 * Revision 1.12.2.1  1997/09/11  20:57:09  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.12  1997/05/01  12:44:33  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.11  1996/07/30  11:17:18  daveb
 * Added comment to explain StatusMap argument to check_compiled'.
 *
 * Revision 1.10  1996/07/02  09:24:18  daveb
 * Bug 1448/Support Calls 35 & 37: Added remove_file_info and modified checks
 * to permit missing file information.
 *
 * Revision 1.9  1996/04/02  11:10:28  daveb
 * Renamed load_dependencies to read_dependencies.
 *
 * Revision 1.8  1996/03/20  16:11:13  daveb
 * Added delete function.
 *
 * Revision 1.7  1996/03/18  17:19:56  daveb
 * Added is_visible and set_visible functions.
 *
 * Revision 1.6  1996/03/14  10:51:06  daveb
 * Changed type of loaded field to store just the basis and id_cache fields
 * of the Compiler.Result type.
 *
 * Revision 1.5  1996/03/06  13:15:15  daveb
 * Fixed information stored for loaded modules.
 *
 * Revision 1.4  1996/02/27  14:54:57  daveb
 * Hid implementation of the Unit type.
 *
 * Revision 1.3  1995/12/07  17:03:23  daveb
 * Added header.
 *
 *  
 * Copyright (c) 1995 Harlequin Ltd.
 *)

require "../main/info";
require "../system/__time";

signature PROJECT =
sig
  structure Info: INFO

  type ModuleId

  type ('a, 'b) Map
  type CompilerBasis
  type IdCache

  (* This is the consistency information stored in each .mo file. *)
  datatype Dependencies =
    DEPEND_LIST of
      {mod_name : string, time : Time.time} list

  (* This is the information stored for each loaded compilation unit. *)
  datatype FileTime =
    OBJECT of Time.time
  | SOURCE of Time.time

  (* The target_type type specifies the possible types of deliverable. *)
  type target_type

  (* This is the type that stores information about all compilation units
     needed by a program. *)
  type Project

  (* Map a project transformer over a project and all its subprojects,
     preserving the dag structure.  In this operation two projects are 
     considered equal if they have the same name and current targets *)
  val map_dag: (Project -> Project) -> Project -> Project

  val currentTargets:
	Project -> string list

  val get_project_name: Project -> string

  val get_name:
	Project * ModuleId -> ModuleId

  val module_id_in_project:
        Project * ModuleId -> bool

  val get_requires:
	Project * ModuleId -> ModuleId list

  val get_external_requires:
	Project -> (Project * ModuleId) list 

  val get_subprojects:
        Project -> Project list

  val set_subprojects:
        Project * Project list -> Project

  (* The "visible" attribute records whether the contents of a loaded module 
     have been added to the user's context. *)
  val is_visible:
	Project * ModuleId -> bool

  val set_visible:
	Project * ModuleId * bool -> unit


  val get_source_info:
	Project * ModuleId
	-> (string * Time.time) option

  val set_source_info:
	Project * ModuleId
	* (string * Time.time) option
	-> unit

  val get_object_info:
	Project * ModuleId
	-> {file: string,
	    file_time: Time.time,
	    time_stamp: Time.time,
	    stamps: int,
	    consistency: Dependencies} option

  val set_object_info:
	Project * ModuleId
	* {file: string,
	   file_time: Time.time,
	   time_stamp: Time.time,
	   stamps: int,
	   consistency: Dependencies} option
	-> unit

  val get_loaded_info:
	Project * ModuleId
        -> {file_time: FileTime,
            load_time: Time.time,
            basis: CompilerBasis,
            id_cache: IdCache,
            module: MLWorks.Internal.Value.T,
            dependencies: Dependencies} option

  val set_loaded_info:
	Project * ModuleId
        *  {file_time: FileTime,
            load_time: Time.time,
            basis: CompilerBasis,
            id_cache: IdCache,
            module: MLWorks.Internal.Value.T,
            dependencies: Dependencies} option
	-> unit

  val clear_all_loaded_info:
	Project * (ModuleId -> bool) -> unit
  (* clear_all_loaded_info (proj, pred); sets the loaded field to NONE
     for all units in the project that satisfy pred. *)

  val initialize: (Info.options * Info.Location.T) -> Project

  val delete: Project * ModuleId * bool -> Project

  val list_units: Project -> (string * ModuleId) list

  (* The StatusMap type stores information about those units for which
     information has been updated during a particular command.  There
     are currently two statuses that may be stored:
	visited: the dependency information is up to date
	compiled: the object file is up to date.
   *)
  type StatusMap

  val empty_map : StatusMap
  val visited_pervasives : StatusMap
  val mark_visited : StatusMap * ModuleId -> StatusMap
  val mark_compiled : StatusMap * ModuleId -> StatusMap

  (* The map argument to read_dependencies is a map of modules that are
     known to have up to date information stored in the project.  This
     is used to avoid reading information from files unnecessarily. *)
  val read_dependencies:
	(Info.options * Info.Location.T)
	-> (Project * ModuleId * StatusMap)
	-> (Project * StatusMap)

  val read_object_dependencies:
	(Info.options * Info.Location.T)
	-> (Project * ModuleId * StatusMap)
	-> (Project * StatusMap)

  val check_load_objects:
	(Info.options * Info.Location.T)
	-> Project * ModuleId
	-> ModuleId list

  val check_load_source:
	(Info.options * Info.Location.T)
	-> Project * ModuleId
	-> ModuleId list

  val check_perv_loaded:
	(Info.options * Info.Location.T)
	-> Project
	-> ModuleId list

  val check_compiled:
	(Info.options * Info.Location.T)
	-> Project * ModuleId
	-> ModuleId list

  (* The check_compiled' command differs from check_compiled in that it takes
     explicit (out_of_date, visited) arguments, and returns updated versions
     of both. The visited argument stores whether a unit has been visited or
     is up to date.  It must be kept distinct from maps passed to
     read_dependences. *)
  val check_compiled':
	(Info.options * Info.Location.T)
	-> Project * ModuleId
	-> (ModuleId list * StatusMap)
	-> (ModuleId list * StatusMap)

  val check_perv_compiled:
	(Info.options * Info.Location.T)
	-> Project
	-> ModuleId list

  val allObjects:
	(Info.options * Info.Location.T)
	-> Project * ModuleId
	-> ModuleId list

  val objectName:
	(Info.options * Info.Location.T) 
	-> (Project * ModuleId)
	-> string

  val pervasiveObjectName: ModuleId -> string

  val reset_pervasives: Project -> unit
  (* reset_pervasives removes all information about the pervasive files
     from the project, leaving only the information about the loaded
     modules.  This allows the batch compilation to use a different set of
     pervasives from those in the interpreter.  *)

  val remove_file_info: Project -> unit
  (* remove_file_info removes all information about the files associated
     with all units in the project, leaving only the information about
     the loaded modules.  This is used for creating distribution images. *)

  (* fromFileInfo updates the Project argument with information from
     the current project file.  This replaces the source path, library
     path, etc. information in the Project.  It leaves the existing
     file information in place. *)
  val fromFileInfo: 
	(Info.options * Info.Location.T)
	-> Project
	-> Project

  val update_dependencies: 
	(Info.options * Info.Location.T)
	-> Project
	-> Project
end

