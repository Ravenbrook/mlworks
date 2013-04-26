(* PROJ_FILE.  Operations for reading and writing project files.
 *
 * $Log: proj_file.sml,v $
 * Revision 1.11  1999/03/18 10:19:31  mitchell
 * [Bug #190534]
 * Ensure projects created by Shell.Project have Debug and Release modes as default
 *
 *  Revision 1.10  1998/07/29  08:37:08  johnh
 *  [Bug #30453]
 *  Extra exceptions added to inform when consistency checks fail.
 *
 *  Revision 1.9  1998/06/16  10:55:36  mitchell
 *  [Bug #30422]
 *  Add setProjectDir
 *
 *  Revision 1.8  1998/06/08  12:20:08  mitchell
 *  [Bug #30418]
 *  Export InvalidProjectFile exception
 *
 *  Revision 1.7  1998/05/28  17:02:50  johnh
 *  [Bug #30369]
 *  Replace source path with a list of files.
 *
 *  Revision 1.6  1998/05/01  11:21:52  mitchell
 *  [Bug #50071]
 *  Extend interface to support close project, and fix parsing of description and version info
 *
 *  Revision 1.5  1998/04/24  14:09:54  mitchell
 *  [Bug #30389]
 *  Keep projects more in step with projfiles
 *
 *  Revision 1.4  1998/03/12  16:23:58  johnh
 *  [Bug #30365]
 *  Implement support for sub-projects.
 *
 *  Revision 1.3  1998/02/23  14:36:34  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *  Revision 1.1.1.7  1998/01/21  11:25:34  johnh
 *  [Bug #30071]
 *  Introducing subprojects.
 *
 *  Revision 1.1.1.6  1998/01/08  15:12:36  johnh
 *  [Bug #30071]
 *  Adding directory location for different modes.
 *  Remove objects lcoation from configurations.
 *
 *  Revision 1.1.1.5  1998/01/06  10:49:02  johnh
 *  [Bug #30071]
 *  Add about information.
 *
 *  Revision 1.1.1.4  1997/11/28  14:32:23  daveb
 *  [Bug #30071]
 *  Made getProjectName return an option type; removed setProjectName;
 *  removed old comments.
 *  Added getProjectDir.
 *
 *  Revision 1.1.1.3  1997/11/04  10:56:56  daveb
 *  [Bug #30071]
 *  Added support for current configurations, modes and targets.
 *
 *  Revision 1.1.1.2  1997/09/12  14:34:39  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 * 
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 *)

signature PROJ_FILE =
sig
  type error_info
  type location
  exception InvalidProjectFile of string

  val  changed : unit -> bool

  datatype target_type = IMAGE | OBJECT_FILE | EXECUTABLE | LIBRARY

  type target_details = (string * target_type)
  exception NoTargetDetailsFound of string
  val getTargetDetails: string * target_details list -> target_details

  type mode_details =
    {name:                                      string,
     location:					string ref,
     generate_interruptable_code:               bool ref,
     generate_interceptable_code:               bool ref,
     generate_debug_info:                       bool ref,
     generate_variable_debug_info:              bool ref,
     optimize_leaf_fns:                         bool ref,
     optimize_tail_calls:                       bool ref,
     optimize_self_tail_calls:                  bool ref,
     mips_r4000:                                bool ref,
     sparc_v7:                                  bool ref}

  exception NoModeDetailsFound of string
  val getModeDetails: string * mode_details list -> mode_details

  type config_details =
    {name: string,
     files: string list,
     library: string list}

  exception NoConfigDetailsFound of string
  val getConfigDetails: string * config_details list -> config_details
  val modifyConfigDetails:
    config_details * config_details list -> config_details list

  (* getProjectName returns the full path of the current project file,
     if any.
     getProjectDir returns the directory containing the current project
     file, or the current directory if there is no open project.
   *)
  val getProjectName: unit -> string option
  val getProjectDir: unit -> string
  val getFiles: unit -> string list
  val getSubprojects: unit -> string list
  val getTargets: unit -> string list * string list * target_details list
  val getModes: unit -> (string list * mode_details list *
			 string option)
  val getConfigurations: unit -> (string list * config_details list *
  				  string option)
  val getLocations: unit -> string list * string * string
  val getAboutInfo: unit -> string * string

  val setFiles: string list -> unit
  val setSubprojects: string list -> unit

  exception InvalidTarget of string
  val setTargets: string list * string list * target_details list -> unit
  val setModes: string list * mode_details list -> unit
  val setInitialModes: unit -> unit 
  val setConfigurations: string list * config_details list -> unit
  val setLocations: string list * string * string -> unit
  val setAboutInfo: string * string -> unit

  (* setCurrentConfiguration and setCurrentMode set the current configuration
     or mode to that specified by the string argument.  If no configuration
     or mode exists with that name, an error is raised. *)
  val setCurrentConfiguration: (error_info * location) -> string option -> unit
  val setCurrentMode: (error_info * location) -> string -> unit

  (* setCurrentTargets sets the current targets to those specified by the
     string list argument.  All other targets are disabled.  If the list
     contains a string that does not name a valid target, an error is
     raised. *)
  val setCurrentTargets: (error_info * location) -> string list -> unit

  val new_proj: string -> unit
  val open_proj: string -> unit
  val save_proj: string -> unit
  val close_proj: unit -> unit

  val peek_project: string -> 
	{name: string,
	 files: string list,
	 curTargets: string list,
	 disTargets: string list, 
	 subprojects: string list,
	 libraryPath: string list,
	 objectsLoc: string,
	 binariesLoc: string,
	 currentConfig: string option,
	 configDetails: config_details list,
	 currentMode: string option,
	 modeDetails: mode_details list}


  val getAllSubProjects: string -> string list
  val getSubTargets: string -> string list
end

