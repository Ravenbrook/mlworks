(*
 * $Log: proj_properties.sml,v $
 * Revision 1.8  1999/04/30 16:17:08  johnh
 * [Bug #190552]
 * Change new_project to return success or failure.
 *
*Revision 1.7  1998/11/18  17:05:17  johnh
*[Bug #70214]
*Change comment relating to the close function becoming apply/reset function.
*
*Revision 1.6  1998/07/31  11:41:28  mitchell
*[Bug #30440]
*Modify test_save to optionally allow cancel
*
*Revision 1.5  1998/06/09  13:22:17  mitchell
*[Bug #30405]
*Change type of mk_configs_dialog
*
*Revision 1.4  1998/05/28  17:03:18  johnh
*[Bug #30369]
*Replace source path with a list of files.
*
*Revision 1.3  1998/05/14  15:00:58  johnh
*[Bug #30384]
*Add test_save to signature to be used by ProjWorkspace#close_window
*
*Revision 1.2  1998/02/06  15:55:50  johnh
*new unit
*[Bug #30071]
*Project Properties of the new Project Workspace tool.
*
 *  Revision 1.1.1.8  1998/01/15  10:19:18  johnh
 *  [Bug #30071]
 *  Introducing subprojects.
 *
 *  Revision 1.1.1.7  1998/01/09  17:03:00  johnh
 *  [Bug #30071]
 *  Split locations dialog in two.
 *
 *  Revision 1.1.1.6  1998/01/08  15:10:00  johnh
 *  [Bug #30071]
 *  Remove objects dir from configurations.
 *
 *  Revision 1.1.1.5  1998/01/06  13:34:46  johnh
 *  [Bug #30071]
 *  Add about dialog.
 *
 *  Revision 1.1.1.4  1997/12/10  13:41:00  johnh
 *  [Bug #30071]
 *  Add save_project_as
 *
 *  Revision 1.1.1.3  1997/11/07  13:16:10  johnh
 *  [Bug #30071]
 *  Configs properties dialog now needs to take an extra arg to update the PW.
 *
 *  Revision 1.1.1.2  1997/09/12  14:19:55  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 * 
 * Copyright (C) 1997.  The Harlequin Group Limited.  All rights reserved.
 *
 *)

signature PROJ_PROPERTIES = 
sig
  type Widget
  type config_details =
    {name: string,
     files: string list,
     library: string list}

  val need_saved: bool ref

  val new_project: Widget -> bool
  val save_project: Widget -> bool
  val save_project_as: Widget -> bool
  val open_project: Widget -> (unit -> unit) -> bool
  val test_save: Widget * bool -> bool

  (* parent, title, getFn, setFn -> (fn1, fn2) where
   * fn1 takes curried args of a caller update function and a title, and
   * fn2 applies or resets the dialog depending on whether the user has made any
   *     changes and wants those changes kept.
   *)
(*
  val mk_path_dialog:  Widget * string * (unit -> string list) * (string list -> unit) ->
			((string list -> unit) -> string -> unit) * (unit -> unit)
*)

  val mk_files_dialog:   Widget * (string list -> unit) -> (unit -> unit) * (unit -> unit)
  val mk_subprojects_dialog: 
	 Widget * (string list -> unit) * (bool -> unit) -> (unit -> unit) * (unit -> unit)
  val mk_targets_dialog:  Widget * (string list -> unit) -> (unit -> unit) * (unit -> unit)
  val mk_modes_dialog:    Widget * (string list -> unit) -> (unit -> unit) * (unit -> unit)
  val mk_configs_dialog:  Widget * (unit -> unit) 
				-> (unit -> unit) * (unit -> unit)

  val mk_library_dialog:  Widget * (string -> unit) -> (unit -> unit) * (unit -> unit)
  val set_objects_dir:	  Widget * bool ref * (string -> unit) -> unit
  val set_binaries_dir:	  Widget * bool ref * (string -> unit) -> unit

  val setRelObjBin: bool * (string -> unit) * (bool ref) -> bool -> unit

  val mk_about_dialog:    Widget -> (unit -> unit) * (unit -> unit)

end;