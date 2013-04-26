(*
 * $Log: _proj_properties.sml,v $
 * Revision 1.38  1999/04/30 16:17:07  johnh
 * [Bug #190552]
 * Change new_project to return success or failure.
 *
 * Revision 1.37  1999/04/29  16:01:08  johnh
 * [Bug #190557]
 * reset project so that units are displayed in PW when project first opened.
 *
 * Revision 1.36  1999/03/18  12:05:06  daveb
 * [Bug #190521]
 * OS.FileSys.readDir now returns an option type.
 *
 * Revision 1.35  1999/03/18  10:19:55  mitchell
 * [Bug #190534]
 * Ensure projects created by Shell.Project have Debug and Release modes as default
 *
 * Revision 1.34  1999/02/03  23:15:21  mitchell
 * [Bug #50108]
 * Change ModuleId from an equality type
 *
 * Revision 1.33  1999/02/02  15:59:29  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.32  1998/12/15  14:22:51  johnh
 * [Bug #190497]
 * Make sure setConfigurations is done before setCurrentConfiguration.
 *
 * Revision 1.31  1998/12/09  15:26:30  johnh
 * [Bug #70240]
 * Remove confiugration files from project unit list when changing current configuration.
 *
 * Revision 1.30  1998/12/08  16:38:01  johnh
 * [Bug #190494]
 * Check for duplicate module ids when adding new files and changing configurations.
 *
 * Revision 1.29  1998/11/24  11:18:05  johnh
 * [Bug #70214]
 * add check to save changes when properties dialogs close.
 *
 * Revision 1.28  1998/08/19  13:12:27  mitchell
 * [Bug #30482]
 * Clear units when opening a new project
 *
 * Revision 1.27  1998/08/17  10:58:11  mitchell
 * [Bug #30474]
 * Replace orig_proj reference by a project stack for subprojects
 *
 * Revision 1.26  1998/08/14  14:00:55  johnh
 * [Bug #50102]
 * reset dialogs if no changes made by user so that dialogs are kept up to date with ProjFile.
 *
 * Revision 1.25  1998/08/13  12:34:11  jont
 * [Bug #30468]
 * Change types of mkAbsolute and mkRelative to uses records with names fields
 *
 * Revision 1.24  1998/08/13  12:28:07  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 * Revision 1.23  1998/07/31  11:41:20  mitchell
 * [Bug #30440]
 * Modify test_save to optionally allow cancel
 *
 * Revision 1.22  1998/07/29  14:01:47  johnh
 * [Bug #30453]
 * Check for a new target being in the list of files.
 *
 * Revision 1.21  1998/07/03  09:42:03  johnh
 * [Bug #50088]
 * Fix SysErr exception problem when adding files from directory.
 *
 * Revision 1.20  1998/06/17  15:53:21  johnh
 * [Bug #30423]
 * remove units for a new project.
 *
 * Revision 1.19  1998/06/16  11:18:39  mitchell
 * [Bug #30422]
 * Prompt for working directory when creating a new project
 *
 * Revision 1.18  1998/06/09  13:22:18  mitchell
 * [Bug #30405]
 * Fix update of display when configuration changes
 *
 * Revision 1.17  1998/06/08  12:20:08  mitchell
 * [Bug #30418]
 * Handle broken project files gracefully
 *
 * Revision 1.16  1998/06/01  16:01:36  johnh
 * [Bug #30369]
 * Replace source path with a list of files.
 *
 * Revision 1.15  1998/05/14  14:57:58  johnh
 * [Bug #30384]
 * Fix test_save.
 *
 * Revision 1.14  1998/05/01  12:40:48  mitchell
 * [Bug #50071]
 * setCurrentConfiguration now takes an option
 *
 * Revision 1.13  1998/04/30  11:46:22  johnh
 * [Bug #30407]
 * Temporarily remove target type.
 *
 * Revision 1.12  1998/04/24  14:40:36  jkbrook
 * [Bug #30376]
 * Change default mode to Release so that our distributed objects
 * can be found
 *
 * Revision 1.11  1998/04/22  16:37:38  mitchell
 * [Bug #70095]
 * Check for bogus characters in modes and configurations
 *
 * Revision 1.10  1998/04/22  10:23:54  johnh
 * [Bug #50073]
 * Give warning when saving new project or saving project in different place.
 *
 * Revision 1.9  1998/03/31  16:23:42  johnh
 * [Bug #30346]
 * Call Capi.getNextWindowPos().
 *
 * Revision 1.8  1998/03/17  11:12:20  johnh
 * [Bug #30365]
 * Fix warning.
 *
 * Revision 1.7  1998/03/12  16:48:58  johnh
 * [Bug #30365]
 * No need for per-target modes or configurations now that subprojects are here.
 *
 * Revision 1.6  1998/02/26  11:16:46  johnh
 * [Bug #30362]
 * Setting current mode changes object file location.
 *
 * Revision 1.5  1998/02/19  19:51:41  mitchell
 * [Bug #30337]
 * Change uses of OS.Path.concat to take a string list, instead of a pair of strings.
 *
 * Revision 1.4  1998/02/17  17:56:14  johnh
 * [Bug #30344]
 * Allow windows to retain size and position.
 *
 * Revision 1.3  1998/02/06  16:51:30  johnh
 * [Bug #30071]
 * Fixing require bug.
 *
 * Revision 1.2  1998/02/06  15:55:48  johnh
 * new unit
 * [Bug #30071]
 * Project Properties of the new Project Workspace tool.
 *
 *  Revision 1.1.1.16  1998/01/21  14:03:02  johnh
 *  [Bug #30071]
 *  Introducing subprojects.
 *
 *  Revision 1.1.1.15  1998/01/12  15:15:56  johnh
 *  [Bug #30071]
 *  Split locations dialog in two.
 *
 *  Revision 1.1.1.14  1998/01/09  11:55:46  johnh
 *  [Bug #30071]
 *  Add directory location for modes.
 *  Remove objects location from configurations.
 *
 *  Revision 1.1.1.13  1998/01/06  15:01:46  johnh
 *  [Bug #30071]
 *  Fix problems with setting library path.
 *
 *  Revision 1.1.1.12  1997/12/12  11:09:54  johnh
 *  [Bug #30071]
 *  Add save_project_as
 *  when properties dialog closes, set focus to project workspace.
 *
 *  Revision 1.1.1.11  1997/12/02  16:38:38  johnh
 *  [Bug #30071]
 *  Fixed mk_path_dialog so that the relative paths radio button has a unique action id.
 *
 *  Revision 1.1.1.10  1997/12/01  15:18:30  johnh
 *  [Bug #30071]
 *  Use ProfFile.getProjectName returning SOME "" to mean new project created.
 *
 *  Revision 1.1.1.9  1997/12/01  13:22:48  johnh
 *  [Bug #30071]
 *  Comment out any reference to binaries for the time being.
 *
 *  Revision 1.1.1.8  1997/12/01  11:16:18  daveb
 *  [Bug #30071]
 *  ProjFile.getProjectName now returns an option.
 *  Use ProjFile.getProjectDir instead of getBasePath.
 *
 *  Revision 1.1.1.7  1997/11/19  11:25:06  johnh
 *  [Bug #30071]
 *  Further improvements.
 *
 *  Revision 1.1.1.6  1997/11/18  17:36:55  daveb
 *  [Bug #30071]
 *  Make targets be just the file name.
 *  Also replaced use of Path by OS.Path.
 *
 *  Revision 1.1.1.5  1997/11/11  11:23:38  johnh
 *  [Bug #30071]
 *  Make further improvements.
 *  Current mode and config added, improved save/load.
 *
 *  Revision 1.1.1.4  1997/11/04  10:14:37  daveb
 *  [Bug #30071]
 *  Added support for current configurations, modes and targets.
 *
 *  Revision 1.1.1.3  1997/11/03  15:57:46  johnh
 *  [Bug #30071]
 *   Continuing work for Project Workspace - adding option for storing relative pathnames
 *
 *  Revision 1.1.1.2  1997/09/12  14:21:47  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 * 
 * Copyright (C) 1997.  The Harlequin Group Limited.  All rights reserved.
 *
 *)

require "../utils/__lists";
require "../basis/__char";
require "../basis/__string";

require "../basis/list";
require "../basis/os";
require "../basics/module_id";
require "../main/machspec";
require "../main/info";
require "../main/toplevel";
require "../main/proj_file";
require "../main/project";

require "../interpreter/incremental";

require "capi";
require "menus";
require "proj_properties";

functor ProjProperties (
  structure List: LIST
  structure MachSpec: MACHSPEC
  structure Info: INFO
  structure TopLevel: TOPLEVEL
  structure Capi: CAPI
  structure Menus: MENUS
  structure ProjFile: PROJ_FILE
  structure OS: OS
  structure Incremental: INCREMENTAL
  structure ModuleId: MODULE_ID
  structure Project: PROJECT

  sharing type Capi.Widget = Menus.Widget
  sharing type Info.Location.T = ProjFile.location = ModuleId.Location
  sharing type Info.options = ProjFile.error_info
  sharing type Incremental.InterMake.Project = Project.Project
  sharing type Incremental.ModuleId = Project.ModuleId = ModuleId.ModuleId
): PROJ_PROPERTIES = 
struct
  structure Options = TopLevel.Options

  type Widget = Capi.Widget

  type targetType = ProjFile.target_type
  type mode_details = ProjFile.mode_details
  type config_details = ProjFile.config_details

  (* parse_name removes leading and trailing spaces from the input *)
  fun parse_name(widget, parent) =
      let val name = Capi.Text.get_string widget
       in case String.tokens Char.isSpace name of
            [] => (Capi.Text.set_string (widget, ""); "")
          | [s] => 
              if List.length(String.fields Char.isCntrl s) <> 1 then
                (Capi.send_message (parent, 
                  "String contains illegal characters: '" ^ (String.toString name) ^ "'");
                 "")
              else s
          | _ =>
              (Capi.send_message (parent, 
                "String contains multiple tokens: '" ^ (String.toString name) ^ "'");
               "")
      end

  fun renumber_up (s, n) = (s, n + 1)
  fun renumber_down (s, n) = (s, n - 1)

  val need_saved = ref false
  val proj_stack = ref []

  fun confirm_save parent = 
    case ProjFile.getProjectName()
    of SOME "" => 
      (Capi.send_message (parent, "Not saved"); 
       false) 
    | SOME file =>
      (Capi.send_message (parent, "Saved project to " ^ file);
       need_saved := false;
       true)
    | NONE => false

  (* There is some checking here to warn the user that relative path names
   * specified in the project will become invalid if they save the project
   * to a different directory.
   *)
  fun save_project_as parent = 
    let 
      val old_dir = ProjFile.getProjectDir()
      val saved_cwd = OS.FileSys.getDir()
      val _ = OS.FileSys.chDir old_dir
      val filename = Capi.save_as_dialog (parent, ".mlp")
      val _ = OS.FileSys.chDir saved_cwd
      fun not_saved () = 
	(Capi.send_message (parent, "Project not saved");
	 false)
    in
      case filename of 
	SOME file => 
	  let
	    val new_dir = OS.Path.dir file
	    val continue = 
	      if (OS.Path.mkCanonical(new_dir) <> OS.Path.mkCanonical(old_dir)) then 
	        Capi.makeYesNoCancel (parent, 
                  "Any relative paths specified in the project will become invalid.  Continue saving?", false) ()
	      else
	        SOME true 
	  in
	    case continue of
	      SOME true => 
	        (ProjFile.save_proj file;
	         confirm_save parent)
	    | SOME false => (* user clicked 'no' *)
		not_saved()
	    | NONE => 	    (* user clicked 'cancel' - not applicable in this case *)
		not_saved()		
	  end
      | NONE => not_saved()
    end 

  fun save_project parent = 
    case ProjFile.getProjectName()
    of SOME "" => save_project_as parent
    |  SOME file =>
      (ProjFile.save_proj file;
       confirm_save parent)
    |  NONE =>
      (Capi.send_message (parent, "Error getting project name - project not saved");
       false)

  (* returns false if the user clicks cancel either when asked to save or 
   * when asked for a filename to save to *)
  fun test_save (parent, cancel) = 
    if (!need_saved) then
      let 
        val askSave =
	  Capi.makeYesNoCancel (parent, "Save the current project?", cancel)
	val answer = askSave()
	val yesOrNo = isSome answer
      in 
        if yesOrNo then 
	  if valOf(answer) then 
	    if (save_project parent) then 
	      (need_saved := false; (* needed when test_save called from outside *)
	       true)
	     else false
	  else true
	else false
      end
    else 
      true

  fun new_project parent = 
    if test_save (parent, true) then 
      case Capi.open_dir_dialog parent of
        NONE => false
      | SOME dir =>
          (need_saved := false;
           ProjFile.new_proj dir;
	   Incremental.reset_project();
           proj_stack := [];
           ProjFile.setInitialModes();
           ProjFile.setCurrentMode
	     (Info.make_default_options (),
	      Info.Location.FILE "Project Properties")
	     "Release";
	   true)
    else false

  fun open_project parent open_ok = 
    if test_save (parent, true) then 
      let 
	val files = Capi.open_file_dialog (parent, ".mlp", false)
      in
        if isSome(files) then 
	  (ProjFile.new_proj "";  (* needed here so that projectName <> NONE 
				    * otherwise a dialog will pop up asking the 
				    * user to create a new project or open one. *)
           Incremental.reset_project();
	   ignore(open_ok());
           let val selected_proj = OS.Path.mkCanonical (hd(valOf(files)))
               fun find [] = []
                 | find (h::t) = if h = selected_proj then t else find t
            in ProjFile.open_proj selected_proj;
               Incremental.reset_project();
               proj_stack := find (!proj_stack) 
           end
             handle ProjFile.InvalidProjectFile s => 
                      (Capi.send_message (parent, 
                         "Error in project file: " ^ s); ());
	   need_saved := false;
	   true)
	else false
      end
    else false

  local 
    fun apply_changes (shell, title, changed) = 
      if changed then 
	getOpt (Capi.makeYesNoCancel (shell, title, false)(), false)
      else 
	false

    fun get_file shell =
      case Capi.open_file_dialog (shell, ".sml", false) of
	 SOME s => OS.Path.mkCanonical (hd(s))
      |  NONE => ""

    fun get_files shell = 
      case Capi.open_file_dialog (shell, ".sml", true) of
	SOME f => map OS.Path.mkCanonical f
      | NONE => []

    datatype dirExist = MAY_EXIST | MUST_EXIST

    fun get_directory (shell, exist) =
      let 
	val dirOpt = 
	  if (exist = MUST_EXIST) then 
	    Capi.open_dir_dialog shell
	  else
	    Capi.set_dir_dialog shell
      in
	case dirOpt of 
           SOME s => OS.Path.mkCanonical s
        |  NONE => ""
      end

    fun list2str [] = ""
      | list2str (h::t) = h ^ "; " ^ list2str t

    fun number_entries ([], _) = []
      | number_entries (h::t, n) = (h, n) :: number_entries (t, n + 1)
    
    fun duplicate_mod_ids [] ids = NONE
      | duplicate_mod_ids (a::rest) ids =
	let 
	  val filen = OS.Path.file a
	  val id = ModuleId.from_host (filen, Info.Location.FILE "Project Properties")
	in
	  if (List.exists (fn id' => ModuleId.eq(id,id')) ids) then (SOME filen)
	  else duplicate_mod_ids rest (id :: ids)
	end

    fun duplicate_id (shell, f) = 
      Capi.send_message (shell, "No duplicate filenames allowed. <" ^ f ^ "> already exists")

    exception PW_Find
    fun find_nth n [] = raise PW_Find
      | find_nth n' ((h as (s, n))::t) = 
          if n = n' then (s,n) else find_nth n' t

    (* is_in, get_position, and moveup functions operate on lists of tuples of
     * type (string * int).  The items in the list are numerically ordered *)

    fun is_in (n:string, []) = false
      | is_in (n, (n', _)::t) = n = n' orelse is_in (n, t)
	infix is_in

    fun get_position (s, []) = 0
      | get_position (s, (s', n) :: rest) = 
          if s = s' then n
           else get_position (s, rest)

    (* moveup: moves the given tuple item one place up the list *)
    fun moveup (s,n) [] = []
      | moveup (s,n) (h::t) = 
         if (s = #1 h) then
           (s,n - 1)::(moveup (s,n) t)
         else
           if (n - 1 = #2 h) then
    	     (#1 h, n)::(moveup (s,n) t)
           else 
    	     h::(moveup (s,n) t)

    fun remove_nth ([], _) = []
      | remove_nth (h::t, n) =
        if n = #2 h then
          map renumber_down t
        else
          h :: remove_nth (t, n)

    (* moveup:  function for moving an item in a listbox. 
     * The function takes the item to be moved up, the list of items, a 
     * selection reference, and the (dec/inc)rement of the move.
     *)
    fun move (s,n) item_list (sel, changed) inc = 
      if ((s,n) <> ("",0) andalso (n > 1) andalso (item_list <> [])) then
        let 
          val result = moveup (s,n) item_list 
          val (name, pos) = valOf(!sel)
        in
          sel := SOME (find_nth (pos + inc) result);
	  changed := true;
          result
        end
      else item_list

    (* removeSelCB:  generalised function for removing a selection from a listbox.
     * The function takes the selection reference, the items list reference, and 
     * an update function for redisplaying the list and any other redisplay that may
     * be necessary.
     *)
    fun removeSelCB (sel, items, changed) updateFn =
      if isSome (!sel) then 
        let 
          val (name, pos) = valOf(!sel)
          val new_items = remove_nth (!items, pos)
        in
          if new_items = [] then 
            sel := NONE
          else 
            sel := SOME (find_nth pos new_items)
	  handle PW_Find => sel := SOME (find_nth 1 new_items);
	  changed := true;
          updateFn new_items
        end
      else ()

    fun moveUpCB (sel_ref, items_ref, changed) update_fn = 
      if (isSome (!sel_ref)) then 
	 update_fn (move (valOf (!sel_ref)) (!items_ref) (sel_ref, changed) (~1))
      else ()

    fun moveDownCB (sel_ref, items_ref, changed) update_fn = 
      if (isSome (!sel_ref)) then
        let 
          val item_below = find_nth (#2 (valOf (!sel_ref)) + 1) (!items_ref)
    			handle PW_Find => ("",0)
          val new_items = move item_below (!items_ref) (sel_ref, changed) 1
        in
          update_fn new_items
        end
      else ()

    (* select_fn:  function that is called when a selection is made in a listbox. *)
    fun select_fn store _ (s,n) = store := SOME (s,n)

    fun print_fn _ (s,_) = s
    fun action_fn _ _ = ()

    (* mk_list:  general function for creating a listbox control.
     *  Takes a tuple of parent shell, and name of listbox followed by curried args 
     *  of the selection reference, a function reference (+), and the item list 
     *	reference.  The function returns the list widget, and an update function 
     *  which can be called to update the display of the listbox control.
     * The passed update function is called when the user selects an item in the 
     * list and also when the returned update function is called. 
     *)
    fun mk_list (parent, name) sel_ref update_ref items_ref = 
      let
        fun selectFn opts (s,n) = (select_fn sel_ref opts (s,n); (!update_ref)())

        val {scroll, list, set_items, add_items} =
          Capi.make_scrolllist
    			{parent = parent,
    			 name = name,
    			 select_fn = selectFn,
    			 action_fn = action_fn,
    			 print_fn = print_fn}

        fun update new_items = 
          (items_ref := Lists_.msort (fn ((a,b), (a',b')) => b < b') new_items;
           set_items Options.default_print_options (!items_ref);
           if isSome(!sel_ref) then
	     let 
		val pos = #2 (valOf (!sel_ref))
		val set_pos = if (pos > 2) then pos - 2 else 1
	     in
		Capi.List.select_pos (list, pos, false);
		Capi.List.set_pos (list, set_pos)
	     end
           else
             ();
           (!update_ref)())
      in
        (scroll, update)
      end

    fun mkCloseButtons {parent, apply, reset, close, changed} = 
      let 
	val closeRC = Capi.make_managed_widget 
				("closeRC", Capi.RowColumn, parent, [])

	(* Note that calling apply() has the effect of changing the result
	 * of calling changed().  Calling apply() before calling changed() 
	 * will result in changed() always returning false.
	 *)

	fun ok () = 
	  let val change = changed()
	  in
	    if apply() then 
	      (if change then need_saved := true else ();
	       close())
	    else ()
	  end

	fun cancel () = (reset(); close())

	fun apply_fn () = 
	  if changed() andalso apply() then 
	    need_saved := true
	  else ()

	val {update, ...} = 
	  Menus.make_buttons (closeRC, 
		[Menus.PUSH ("PWP_Ok",     ok,       fn _ => true),
		 Menus.PUSH ("PWP_Apply",  apply_fn, changed),
		 Menus.PUSH ("PWP_Reset",  reset,    changed),
		 Menus.PUSH ("PWP_Cancel", cancel,   fn _ => true)])
      in
	(closeRC, update)
      end

    fun toRel []              f = []
      | toRel ((a,pos)::rest) f = 
	let
	  val newPath =
	    OS.Path.mkCanonical
	      (OS.Path.mkRelative {path=a, relativeTo=ProjFile.getProjectDir()})
	in
	  ignore(f (a, newPath));
	  (newPath, pos) :: (toRel rest f)
	end

    fun toAbs []              f = []
      | toAbs ((a,pos)::rest) f = 
	let 
	  val newPath =
	    OS.Path.mkCanonical
	      (OS.Path.mkAbsolute {path=a, relativeTo=ProjFile.getProjectDir()})
	in
	  ignore(f (a, newPath));
	  (newPath, pos) :: (toAbs rest f)
	end

    val noConfigSelStr = "No configuration selected"

  in

    (* mk_path_dialog:  creates a dialog which allows the user to construct a path.
     *  Takes the parent shell and two functions:
     * get: unit -> string list:  a function to display the initial path when the dialog
     * 				  is brought up.
     * set: string option * string list -> unit:  a function to set the path given 
     * 	    a new list of directories.  The string option is used in the case when 
     *	    the path dialog was created by the configurations dialog to display a 
     * 	    path belonging to a particular configuration.
     *)
    fun mk_path_dialog (parent, caller_id, get, set) = 
      let 
	val visible = ref false
	val pathChanged = ref false
	val relativePaths = ref false

	(* DO NOT change these strings (of caller_id) as they as also used 
	 * in app-defaults/MLWorks-labels and mswindows/__labelstrings.sml
	 *)
	(* caller_id is used as a label identifier below and is needed so 
	 * that with each call to mk_path_dialog, controls created using
	 * this label id can have unique action ids on Windows (see 
	 * Labelstrings for each entry associated with each caller_id)
	 *)
	val title = 
	  case caller_id of 
	     "config_lib" => "Configuration Library Path"
	   | "lib_path"   => "Set Library Path"
	   | _ => ""

	val (shell, frame, menuBar, _) = 
	  Capi.make_main_popup {name = "propFilesDialog", 
				title = title,
				parent = parent, 
				contextLabel = false, 
				visibleRef = visible,
				pos = Capi.getNextWindowPos()}

	val label = Capi.make_managed_widget 
				("PWP_propFilesLabel", Capi.Label, frame, [])

        val path_items = ref (number_entries (get(), 1))

	val dir_selection = 
	  ref (if !path_items = [] 
		then NONE 
		else SOME (find_nth 1 (!path_items)))

	(* This update function is called when set_new_path is called or when 
	 * a selection is made in the listbox control. 
	 *)
	val updatePathsRef = ref (fn () => ())

	val (scroll, set_new_path) = 
	  mk_list (frame, "file_list")
	    dir_selection updatePathsRef path_items

	fun addNewCB () = 
	  let 
	    val rawDir = get_directory (shell, MUST_EXIST)
	    val dir = 
	      if (!relativePaths) then 
		OS.Path.mkCanonical
		  (OS.Path.mkRelative {path=rawDir, relativeTo=ProjFile.getProjectDir ()})
	      else
		rawDir
	  in
	    if rawDir = "" orelse dir is_in !path_items then ()
	    else 
	      let
	        val new_path_items = 
		  (dir, 1) :: (map renumber_up (!path_items))
	      in
		dir_selection := SOME (dir, 1);
		pathChanged := true;
		set_new_path new_path_items		
	      end
	  end

	fun removeAllCB () = 
	  (dir_selection := NONE;
	   pathChanged := true;
	   set_new_path [])

	fun removeSel () = removeSelCB (dir_selection, path_items, pathChanged) set_new_path
	fun moveUp () = moveUpCB (dir_selection, path_items, pathChanged) set_new_path
	fun moveDown () = moveDownCB (dir_selection, path_items, pathChanged) set_new_path

	val removeRC = Capi.make_managed_widget 
				("PWP_removeRC", Capi.RowColumn, frame, [])

	val {update, ...} = 
	  Menus.make_buttons (removeRC, 
		[Menus.PUSH ("PWP_addButton", addNewCB, fn _ => true),
		 Menus.PUSH ("PWP_moveUp", moveUp, fn () => isSome (!dir_selection)),
		 Menus.PUSH ("PWP_moveDown", moveDown, fn () => isSome (!dir_selection)),
		 Menus.PUSH ("PWP_removeSel", removeSel, fn () => isSome (!dir_selection)),
		 Menus.PUSH ("PWP_removeAll", removeAllCB, fn () => true)])

	fun getRel () = (!relativePaths)
	fun setRel b = 
	  if b then 
	    (relativePaths := true;
	     pathChanged := true;
	     path_items := toRel (!path_items) (fn _ => ());
	     set_new_path (!path_items))
	  else
	    (relativePaths := false;
	     pathChanged := true;
	     path_items := toAbs (!path_items) (fn _ => ());
	     set_new_path (!path_items))

	val relativeRC = Capi.make_managed_widget 
				("PWP_relativeRC", Capi.RowColumn, frame, [])

	(* Please note the comment at the start of this function
	 * about the caller_id string.
	 *)
	val {update = updateRel, ...} = 
	  Menus.make_buttons (relativeRC, 
		[Menus.TOGGLE ("PWP_" ^ caller_id, getRel, setRel, fn _ => true)])


	(* title_ref is used not only to display the title of the path dialog, 
	 * but also to keep a record of which configuration the path information 
	 * belongs to.
	 *)
	val title_ref = ref ""


	(* In the function apply(), the set command must come after the change to
	 * the pathChanged reference.  This is needed when (at least) the path 
	 * dialog was created by the configurations dialog.  In that case, this set 
	 * command is bound to setConfigFiles which updates the configurations and
	 * this has the side effect that the applyReset function of this path dialog
	 * is called therefore causing the applyReset check to be made - see the end
	 * of this function.  During this applyReset call, this dialog is updated, 
	 * and therefore, strictly speaking the set_new_path call below is not 
	 * needed.  It should be kept though as it does no harm and guards against
	 * having to depend on the set call to do the update implicitly.
	 *)
	fun apply () = 
	  (pathChanged := false;
	   ignore(set (SOME (!title_ref), map #1 (!path_items)));
	   set_new_path (!path_items);
	   true)

	fun reset () = 
	  (path_items := number_entries (get(), 1);
	   dir_selection := NONE;
	   pathChanged := false;
	   set_new_path (!path_items))

	fun close () = 
	  (reset();
	   visible := false;
	   Capi.set_focus (Capi.parent shell);
	   Capi.hide shell)

	val (closeRC, updateCloseButtons) = 
	  mkCloseButtons {parent = frame, 
			  apply = apply,
			  reset = reset,
			  close = close,
			  changed = fn () => (!pathChanged)}

	fun do_layout () = 
	  Capi.Layout.lay_out (frame, NONE,
		[Capi.Layout.FIXED label,
		 Capi.Layout.FIXED relativeRC,
		 Capi.Layout.SPACE,
		 Capi.Layout.FLEX scroll,
		 Capi.Layout.SPACE,
		 Capi.Layout.FIXED removeRC,
		 Capi.Layout.SPACE,
		 Capi.Layout.FIXED closeRC,
		 Capi.Layout.SPACE])

	fun tempUpdatePaths () = 
	  (Capi.set_label_string (label, !title_ref);
	   update(); 
	   updateCloseButtons(); 
	   if (!path_items) <> [] then
	     relativePaths := OS.Path.isRelative (#1(hd(!path_items)))
	   else ();
	   updateRel())

    in 
      Capi.remove_menu menuBar;
      Capi.set_close_callback (frame, close);
      do_layout();

      updatePathsRef := tempUpdatePaths;
      reset();

      (* returns two functions:
       * update_fn: ((string list -> unit) -> string -> unit)
       *  This function takes a callerUpdate function (see mk_path_dialog call
       *    from ProjWorkspace), creates the path dialog, and returns a function
       *    which displays the dialog showing the correct label at the top 
       *    (ie. to indicate what the dialog is for).
       * apply_reset_fn: (unit -> unit)
       *  This function is used by ProjWorkspace and Podium for updating the 
       *    display of the properties dialogs to be consistent with both the 
       *    project workspace and the ProjFile info.
       *)
     ((fn getMiniTitle => 
	 (updatePathsRef := 
	    (fn () => 
		(title_ref := getMiniTitle();
	       	if ((!title_ref) = noConfigSelStr) then
		  (visible := false;
		   Capi.set_focus (Capi.parent shell);
		   Capi.hide shell)
	        else
	          tempUpdatePaths()));
    	  visible := true;
	  if not (!pathChanged) then reset() else ();
    	  set_new_path (!path_items);
    	  Capi.reveal frame;
    	  Capi.reveal shell;
    	  Capi.to_front shell)),
      fn () => 
	(if apply_changes(shell, "Apply changes in path dialog?", !pathChanged) then 
	   ignore(apply())
	 else ();
	 reset())
      )
    end

    fun mk_get_files_dialog (parent, caller_id, get, set) = 
      let 
	val visible = ref false
	val filesChanged = ref false
	val relativePaths = ref false

	val (title, configs) = 
	  case caller_id of 
	     "files"        => ("Project Properties - Common Files", false)
	   | "config_files" => ("Configuration Files", true)
	   | _ => ("", false)

	val (shell, frame, menuBar, _) = 
	  Capi.make_main_popup {name = "propFilesDialog", 
				title = title,
				parent = parent, 
				contextLabel = false, 
				visibleRef = visible,
				pos = Capi.getNextWindowPos()}

	val label = Capi.make_managed_widget 
				("PWF_propFilesLabel", Capi.Label, frame, [])

        val files = ref (number_entries (get(), 1))

	val file_selection = 
	  ref (if !files = [] 
		then NONE 
		else SOME (find_nth 1 (!files)))

	(* This update function is called when set_new_files is called or 
	 * when a selection is made in the listbox control. 
	 *)
	val updateFilesRef = ref (fn () => ())

	val (scroll, set_new_files) = 
	  mk_list (frame, "file_list")
	    file_selection updateFilesRef files

	fun addFromDirCB () = 
	  let 
	    val rawDir = get_directory (shell, MUST_EXIST)

	    val relFn = 
	      if (!relativePaths) then 
		fn f => OS.Path.mkCanonical
		  (OS.Path.mkRelative {path=f, relativeTo=ProjFile.getProjectDir ()})
	      else
		fn f => f

	    fun getFiles dirstream = 
	      case OS.FileSys.readDir dirstream
	      of NONE => []
	      |  SOME raw_f =>
                  let
		    val f = OS.Path.mkCanonical raw_f
	       
		    val ss = (String.extract(f, size(f) - 4, NONE) = ".sml"
			handle Subscript => false)
		  in
		    if ss then 
		      relFn(OS.Path.concat [rawDir, f]) :: (getFiles dirstream)
		    else 
		      getFiles dirstream
		  end

	    fun add_file (file_list, f) = 
	      if f is_in file_list then file_list
	      else
		(f, 1) :: (map renumber_up file_list)

	    fun do_add dirstream = 
	      let 
	        val new_files = getFiles dirstream
 		val new_file_list = Lists_.reducel add_file (!files, new_files)
	      in
		file_selection := SOME (find_nth 1 new_file_list);
		filesChanged := true;
		set_new_files new_file_list;
		OS.FileSys.closeDir dirstream
	      end

	  in
	    if rawDir <> "" then
	      do_add (OS.FileSys.openDir rawDir)
	    else
	      ()
	  end

	(* Allows user to select more than one file from the file dialog *)
	fun addFilesCB () = 
	  let
	    val new_files = get_files shell

	    val relFn = 
	      if (!relativePaths) then 
		fn f =>  (* OS.Path.mkCanonical *) 
		  (OS.Path.mkRelative {path=f, relativeTo=ProjFile.getProjectDir ()})
	      else
		fn f => f

	    fun add_file (file_list, f) = 
	      if f is_in file_list then file_list
	      else 
		(f, 1) :: (map renumber_up file_list)
	  in
	    if (new_files = []) then () 
	    else
	      let
		val new_file_list = 
		  Lists_.reducel (fn (l, f) => add_file (l, relFn f)) (!files, new_files)
	      in
	        file_selection := SOME (find_nth 1 new_file_list);
		filesChanged := true;
		set_new_files new_file_list
	      end
	  end


	fun removeAllCB () = 
	  (file_selection := NONE;
	   filesChanged := true;
	   set_new_files [])

	fun removeSel () = removeSelCB (file_selection, files, filesChanged) set_new_files

	val removeRC = Capi.make_managed_widget 
				("PWF_removeRC", Capi.RowColumn, frame, [])

	val {update, ...} = 
	  Menus.make_buttons (removeRC, 
		[Menus.PUSH ("PWF_addButton", addFromDirCB, fn _ => true),
		 Menus.PUSH ("PWF_addFiles", addFilesCB, fn _ => true),
		 Menus.PUSH ("PWF_removeSel", removeSel, fn () => isSome (!file_selection)),
		 Menus.PUSH ("PWF_removeAll", removeAllCB, fn () => true)])

	fun getRel () = (!relativePaths)
	fun setRel b = 
	  if b then 
	    (relativePaths := true;
	     filesChanged := true;
	     files := toRel (!files) (fn _ => ());
	     set_new_files (!files))
	  else
	    (relativePaths := false;
	     filesChanged := true;
	     files := toAbs (!files) (fn _ => ());
	     set_new_files (!files))

	val relativeRC = Capi.make_managed_widget 
				("PWF_relativeRC", Capi.RowColumn, frame, [])

	(* Please note the comment at the start of this function
	 * about the caller_id string.
	 *)
	val {update = updateRel, ...} = 
	  Menus.make_buttons (relativeRC, 
		[Menus.TOGGLE ("PWP_" ^ caller_id, getRel, setRel, fn _ => true)])

	(* Used for storing the configuration name that these files belong to 
	 * as well as being used for the title of the listbox.
	 *)
	val title_ref = ref ""

	(* IMPORTANT - see comment for apply function in mk_path_dialog above. *)
	(* Also the set function here returns true if the update was not successful *)
	fun apply () = 
	  (filesChanged := false;
	   filesChanged := set (SOME (!title_ref), (map #1 (!files)));
	   set_new_files (!files);
	   true)

	fun reset () = 
	  (files := number_entries (get(), 1);
	   file_selection := NONE;
	   filesChanged := false;
	   set_new_files (!files))

	fun close () = 
	  (reset();
	   visible := false;
	   Capi.set_focus (Capi.parent shell);
	   Capi.hide shell)

	val (closeRC, updateCloseButtons) = 
	  mkCloseButtons {parent = frame, 
			  apply = apply,
			  reset = reset,
			  close = close,
			  changed = fn () => (!filesChanged)}

	fun do_layout () = 
	  Capi.Layout.lay_out (frame, NONE,
		[Capi.Layout.FIXED label,
		 Capi.Layout.FIXED relativeRC,
		 Capi.Layout.SPACE,
		 Capi.Layout.FLEX scroll,
		 Capi.Layout.SPACE,
		 Capi.Layout.FIXED removeRC,
		 Capi.Layout.SPACE,
		 Capi.Layout.FIXED closeRC,
		 Capi.Layout.SPACE])

      fun tempUpdateFiles () =
	(Capi.set_label_string (label, !title_ref);
	 update(); 
	 updateCloseButtons(); 
	 if (!files) <> [] then
	   relativePaths := OS.Path.isRelative (#1(hd(!files)))
	 else ();
	 updateRel())

    in 
      Capi.remove_menu menuBar;
      Capi.set_close_callback (frame, close);
      do_layout();

      updateFilesRef := tempUpdateFiles;
      reset();

      (* returns two functions:
       * update_fn: ((string list -> unit) -> string -> unit)
       *  This function takes a callerUpdate function (see mk_path_dialog call
       *    from ProjWorkspace), creates the path dialog, and returns a function
       *    which displays the dialog showing the correct label at the top 
       *    (ie. to indicate what the dialog is for).
       * apply_reset_fn: (unit -> unit)
       *  This function is used by ProjWorkspace and Podium for updating the 
       *    display of the properties dialogs to be consistent with both the 
       *    project workspace and the ProjFile info.
       *)
     ((fn getTitle => 
	 (updateFilesRef := 
	    (fn () =>
	      (title_ref := getTitle();
	       if (getTitle() = noConfigSelStr) then
		 (visible := false;
		  Capi.set_focus (Capi.parent shell);
		  Capi.hide shell)
	       else
	         tempUpdateFiles()));
    	  visible := true;
	  if not (!filesChanged) then reset() else ();
	  set_new_files (!files);
    	  Capi.reveal frame;
    	  Capi.reveal shell;
    	  Capi.to_front shell)),
      fn () =>
	(if apply_changes (shell, "Apply changes in files dialog?", !filesChanged) then
	   ignore(apply())
	 else ();
	 reset())
      )
    end

    fun mk_files_dialog (parent, updateFiles: string list -> unit) = 
      let
	fun c_files () = 
	  let val (configs, c_details, curConfig) = ProjFile.getConfigurations()
	  in
	    case curConfig of 
	      NONE => []
	    | SOME c => #files (ProjFile.getConfigDetails (c, c_details))
	  end

	val (mk_new_files_dialog, applyResetFiles) = 
          mk_get_files_dialog (parent,
		       	  "files", 
	    		  ProjFile.getFiles,
			  fn (config_, newFiles) => 
			    case (duplicate_mod_ids (c_files() @ newFiles) []) of
			      NONE =>
			        (ProjFile.setFiles newFiles;
			         updateFiles newFiles;
			         false)
			    | SOME f => 
				(duplicate_id (parent, f); 
				 true))

        fun files_dialog () = 
	  mk_new_files_dialog 
    	    (fn () => "List of files belonging to current project:")
      in
	(files_dialog, applyResetFiles)
      end

    fun mk_subprojects_dialog (parent, callerUpdate, updatePW) = 
      let
	val visible = ref false
	val subChange = ref false
	val subSel = ref NONE
	val subprojects = ref []
	val relSubproj = ref false

	fun isSel () = isSome(!subSel)

	val (shell, frame, menuBar, _) = 
	  Capi.make_main_popup {name = "propSubProjectsDialog", 
				title = "Project Properties - Subprojects", 
				parent = parent, 
				contextLabel = false, 
				visibleRef = visible,
				pos = Capi.getNextWindowPos()}

	val label = Capi.make_managed_widget 
				("PWS_subprojLabel", Capi.Label, frame, [])

	val updateSubsRef = ref (fn () => ())

	val (scroll, set_new_projs) = 
	  mk_list (frame, "proj_list")
	    subSel updateSubsRef subprojects

	fun apply () = 
	  (ProjFile.setSubprojects (map #1 (!subprojects));
	   ignore(callerUpdate (map #1 (!subprojects)));
	   subChange := false;
	   set_new_projs (!subprojects);
	   true)

	fun reset () = 
	  (subprojects := number_entries (ProjFile.getSubprojects(), 1);
	   subSel := NONE;
	   subChange := false;
	   set_new_projs (!subprojects))

	fun close () = 
	  (reset();
	   visible := false;
	   Capi.set_focus (Capi.parent shell);
	   Capi.hide shell)

	fun addNewProj () = 
	  let 
	    val rawText = 
	      case Capi.open_file_dialog (shell, ".mlp", true) of
	         NONE => ""
	      |  SOME (a::rest) => OS.Path.mkCanonical a
	      |  SOME [] => ""

	    val file = 
	      if (!relSubproj) then 
		OS.Path.mkCanonical
		  (OS.Path.mkRelative {path=rawText, relativeTo=ProjFile.getProjectDir ()})
	      else
		rawText

	    fun isCurProj n = 
	      n = OS.Path.mkCanonical (valOf (ProjFile.getProjectName()))
	  in
	    if rawText = "" orelse file is_in !subprojects then ()
	    else 
	      if isSome (List.find isCurProj (ProjFile.getAllSubProjects rawText)) then 
		Capi.send_message(shell, 
			"Can't add subproject - results in circular reference")
	      else
	        let
	          val new_projects = 
		    (file, 1) :: (map renumber_up (!subprojects))
	        in
		  subSel := SOME (file, 1);
		  subChange := true;
		  set_new_projs new_projects		
	        end
	  end

	fun removeSel () = removeSelCB (subSel, subprojects, subChange) set_new_projs
	fun openProj' () = 
	  if test_save (shell, true) then
            let val sub_project = 
                    OS.Path.mkAbsolute{path= #1(valOf(!subSel)), 
                                       relativeTo=ProjFile.getProjectDir()}
                val parent_proj = ProjFile.getProjectName()
	    in 
              ProjFile.open_proj sub_project;
              case parent_proj of
                SOME "" => (* User declined to save new project *)
                  proj_stack := []
              | SOME s => 
                  proj_stack := (OS.Path.mkCanonical s) :: (!proj_stack)
              | NONE => proj_stack := [] (* Should never happen *);
              updatePW true;
	      need_saved := false
            end
	  else ()

	fun openProj () = 
	  (if (!subChange) then need_saved := true else ();
	   ignore(apply());
	   openProj'())

	val projRC = Capi.make_managed_widget 
				("PWS_projRC", Capi.RowColumn, frame, [])

	fun backProj' () = 
	  if test_save (shell, true) then
	    (case (!proj_stack) of
	       [] => (* This shouldn't happen *) ()
	     | h :: t => (ProjFile.open_proj h; proj_stack := t);
	     updatePW true)
	  else ()

	fun backProj () = 
	  (if (!subChange) then need_saved := true else ();
	   ignore(apply());
	   backProj'())

	fun backSens () = not(null(!proj_stack))

	val {update, ...} = 
	  Menus.make_buttons (projRC, 
		[Menus.PUSH ("PWS_addProj", addNewProj, fn _ => true),
		 Menus.PUSH ("PWS_removeProj", removeSel, isSel),
		 Menus.PUSH ("PWS_openProj", openProj, isSel),
		 Menus.PUSH ("PWS_backProj", backProj, backSens)])

	fun getRel () = (!relSubproj)
	fun setRel b = 
	  if b then 
	    (relSubproj := true;
	     subChange := true;
	     subprojects := toRel (!subprojects) (fn _ => ());
	     set_new_projs (!subprojects))
	  else
	    (relSubproj := false;
	     subChange := true;
	     subprojects := toAbs (!subprojects) (fn _ => ());
	     set_new_projs (!subprojects))

	val relProjRC = Capi.make_managed_widget 
				("PWS_relProjRC", Capi.RowColumn, frame, [])

	val {update = updateRel, ...} = 
	  Menus.make_buttons (relProjRC, 
		[Menus.TOGGLE ("PWS_relProj", getRel, setRel, fn _ => true)])

	val (closeRC, updateCloseButtons) = 
	  mkCloseButtons {parent = frame, 
			  apply = apply,
			  reset = reset,
			  close = close,
			  changed = fn () => (!subChange)}

	fun do_layout () = 
	  Capi.Layout.lay_out (frame, NONE,
		[Capi.Layout.FIXED label,
		 Capi.Layout.FIXED relProjRC,
		 Capi.Layout.SPACE,
		 Capi.Layout.FLEX scroll,
		 Capi.Layout.SPACE,
		 Capi.Layout.FIXED projRC,
		 Capi.Layout.SPACE,
		 Capi.Layout.FIXED closeRC,
		 Capi.Layout.SPACE])

      in 
        Capi.remove_menu menuBar;
        Capi.set_close_callback (frame, close);
        do_layout();

        updateSubsRef := 
	  (fn () => 
	    (update(); 
	     updateCloseButtons(); 
	     if (!subprojects) <> [] then
	       relSubproj := OS.Path.isRelative (#1(hd(!subprojects)))
	     else ();
	     updateRel()));

       ((fn () => 
	 (visible := true;
	  if not (!subChange) then reset() else ();
	  set_new_projs (!subprojects);
    	  Capi.reveal frame;
    	  Capi.reveal shell;
    	  Capi.to_front shell)),
	 fn () =>
	   if apply_changes (shell, "Apply changes in subprojects dialog?", !subChange) then
	     ignore(apply())
	   else
	     reset()
	)

      end (* mk_subprojects_dialog *)

    fun mk_targets_dialog (parent, callerUpdate) = 
      let 
	val visible = ref false
	val changed = ref false
	val curSel = ref NONE
	val disTargets = ref []
	val curTargets = ref []
	val targetDetails = ref []

	fun isCurSel () = isSome(!curSel)

	val disSel = ref NONE

	val (shell, frame, menuBar, _) = 
	  Capi.make_main_popup {name = "propTargetsDialog", 
				title = "Project Properties - Targets", 
				parent = parent, 
				contextLabel = false, 
				visibleRef = visible,
				pos = Capi.getNextWindowPos()}
	val label = Capi.make_managed_widget 
				("PWT_targetsLabel", Capi.Label, frame, [])

	(* Rowcolumn widget which stores five buttons:
	 * addTarget for selecting a new (current) target to add to the list,
	 * moveUp for moving a target up the ordered list - to be built earlier.
	 * moveDown for moving a target down the build order.
	 * disable for disabling the selected target.
	 * reomveTarget for removing the selected target from the list.
	 *)
	val targetRC = Capi.make_managed_widget 
				("PWT_targetRC", Capi.RowColumn, frame, [])

	(* addDetails: takes a list of targets ((name, pos) tuples) and returns a
	 * list of the details of the specified targets.
	 * This is used to keep the targetDetails list consistent with the all the 
	 * targets (inc disabled ones) by:  targetDetails := addDetails <allTargets>;
	 *)
	fun addDetails [] = []
	  | addDetails ((name, p)::t) = 
	      let 
		val details = List.find (fn (n,_) => n=name) (!targetDetails)
	      in
		if isSome details then
		  valOf(details) :: (addDetails t)
		else
		  (name, ProjFile.OBJECT_FILE) :: (addDetails t)
	      end

	(* This update function is called whenever a selection of the current 
	 * targets is made - see end of mk_targets_dialog function where this 
	 * reference is set.
         *) 
	val updateTargetsRef = ref (fn () => ())

	(* List of all current targets *)
	val (curScroll, updateTargets) = 
	  mk_list (frame, "curList")
		   curSel 
		   updateTargetsRef
		   curTargets

	(* Modifies the details associated with the selected current target *)
	fun modifyTarget (name, tarType) = 
	  let 
	    val (name', t) = 
	      valOf (List.find (fn (n,_) => n=name) (!targetDetails))
	    val others = List.filter (fn (n,_) => n <> name) (!targetDetails);
	  in 
	    targetDetails := (name, tarType) :: others
	  end

	(* get_details:  get the details of the selected current target *)
	fun get_details () = 
	  let 
	    val name = #1 (valOf (!curSel))
	  in
	    ProjFile.getTargetDetails (name, !targetDetails)
	    handle ProjFile.NoTargetDetailsFound n => 
	      (Capi.send_message (shell, 
		 "Error in targets.  No details found for target: " ^ n);
	       (n, ProjFile.OBJECT_FILE))
	  end


	(* Adds a new target to the list of current targets if it isn't already 
	 * in the current targets OR in the disabled targets.
	 *)
	fun addTargetCB () = 
	  let 
	    val rawText = get_file shell
	    val text = OS.Path.file rawText

	    fun valid_target target = 
	      not (target is_in (!curTargets)) andalso
	      not (target is_in (!disTargets)) andalso
	      target <> ""

	    fun add_target target = 
	      let 
		val new = (target, 1) :: (map renumber_up (!curTargets))
	      in
		curSel := SOME (target, 1);
		changed := true;
		updateTargets new
	      end

	    val files = ProjFile.getFiles()

	    val (_, configDetails, currentConfig) = ProjFile.getConfigurations()
	    val cc_files = 
	      case currentConfig of 
		NONE => []
	      | SOME cc => #files (ProjFile.getConfigDetails (cc, configDetails))

	    fun modified_target file_list = 
	      case file_list of 
		[] => rawText
	      | (f::rest) => 
		  if OS.Path.isRelative(f) then 
		    OS.Path.mkRelative{path=rawText, relativeTo=ProjFile.getProjectDir()}
		  else rawText

	  in 
	    if valid_target(text) then
	      if (not (List.exists (fn t => t=modified_target(files)) files)) andalso
		 (not (List.exists (fn t => t=modified_target(cc_files)) cc_files)) then 
		Capi.send_message (shell, "Target " ^ rawText ^ 
					" not in list of ML files specified in this project")
	      else
		add_target text
	    else ()
	  end

	val disableLabel = Capi.make_managed_widget
				("PWT_disableLabel", Capi.Label, frame, [])

	local 
	  fun tarType () = 
	    if isCurSel() then 
	      SOME (#2 (get_details ()))
	    else NONE

	  fun setType whichType = 
	    if isCurSel() then 
	      let val (name, curType) = get_details()
	      in
		changed := true;
		modifyTarget (name, whichType);
		updateTargets (!curTargets)
	      end
	    else ()

	in
	  fun is_exe () = tarType() = SOME ProjFile.EXECUTABLE
	  fun is_dynlib () = tarType() = SOME ProjFile.LIBRARY
	  fun is_image () = tarType() = SOME ProjFile.IMAGE
	  fun is_objfile () = tarType() = SOME ProjFile.OBJECT_FILE

	  fun set_exe b = if b then setType ProjFile.EXECUTABLE else ()
	  fun set_dynlib b = if b then setType ProjFile.LIBRARY else ()
	  fun set_image b = if b then setType ProjFile.IMAGE else ()
	  fun set_objfile b = if b then setType ProjFile.OBJECT_FILE else ()
	end

(* TTT: temporarily removed

	val typesRC = Capi.make_managed_widget
				("PWT_typesRC", Capi.RowColumn, frame, [])

	val {update=updateTypes, ...} = 
	  Menus.make_buttons (typesRC, 
	    [Menus.RADIO ("PWT_exeRadio",    is_exe,    set_exe,     fn () => true),
	     Menus.RADIO ("PWT_dynlibRadio", is_dynlib, set_dynlib,  fn () => true),
	     Menus.RADIO ("PWT_imageRadio",  is_image,  set_image,   fn () => true),
	     Menus.RADIO ("PWT_objfileRadio",is_objfile,set_objfile, fn () => true)])
*)

	val updateDisabledRef = ref (fn () => ())

	(* updateDetails needs to be called by the select_fn as well as the 
	 * returned update function.
	 *)
	val (disScroll, updateDisabled) = 
	  mk_list (frame, "disList")
	    disSel updateDisabledRef disTargets

	(* Disables the selected current target - adds it to the list of 
	 * disabled targets and removes it from the list of current targets.
	 * The order of this operation is important - it must be added to the
	 * list first otherwise, during updating, the details of the target
	 * are lost.
	 *)
	fun disableCB () = 
	  if isCurSel() then 
	    let 
	      val (s,n) = valOf(!curSel)
	      val new_disabled = (s,1) :: (map renumber_up (!disTargets))
	    in
	      disSel := SOME (s,1);
	      updateDisabled new_disabled;
	      removeSelCB (curSel, curTargets, changed) updateTargets
	    end
	  else ()

	(* Enables the selected disabled target - adds it to the list of
	 * current targets and removes it from the list of current targets.
	 * The order of this operation is important - it must be added to the
	 * list first otherwise, during updating, the details of the target
	 * are lost.
	 *)
	fun enableCB () = 
	  if isSome(!disSel) then 
	    let 
	      val (s,n) = valOf(!disSel)
	      val new_enabled = (s,1) :: (map renumber_up (!curTargets))
	    in
	      curSel := SOME (s,1);
	      updateTargets new_enabled;
	      removeSelCB (disSel, disTargets, changed) updateDisabled
	    end
	  else ()

	val delTarget = 
	  Capi.makeYesNoCancel (shell, "Remove the selected target?", false)

	(* When removing a target, the selected disabled target (if any) is 
	 * deselected so that the user is clear as to which target is being 
	 * removed, ie. the selected CURRENT target.
	 *)
	fun removeTarget () = 
	  (disSel := NONE; 
	   updateDisabled (!disTargets);
	   if valOf(delTarget()) then 
	     (changed := true;
	     removeSelCB (curSel, curTargets, changed) updateTargets)
	   else ())

	fun moveUp () = moveUpCB (curSel, curTargets, changed) updateTargets
	fun moveDown () = moveDownCB (curSel, curTargets, changed) updateTargets

	val {update=updateTargetButtons, ...} = 
	  Menus.make_buttons (targetRC, 
		[Menus.PUSH ("PWT_addTarget", addTargetCB, fn _ => true),
		 Menus.PUSH ("PWT_moveUp", moveUp, isCurSel),
		 Menus.PUSH ("PWT_moveDown", moveDown, isCurSel),
		 Menus.PUSH ("PWT_disable", disableCB, isCurSel),
		 Menus.PUSH ("PWT_removeTarget", removeTarget, isCurSel)])

	val disableRC = Capi.make_managed_widget 
				("PWT_disableRC", Capi.RowColumn, frame, [])

	val {update=updateDisableButtons, ...} = 
	  Menus.make_buttons (disableRC, 
		[Menus.PUSH ("PWT_enableTarget", enableCB, fn _ => isSome(!disSel))])

(* TTT: temporarily removed
	val detailsLabel = Capi.make_managed_widget
				("PWT_detailsLabel", Capi.Label, frame, [])
	val typeLabel = Capi.make_managed_widget
				("PWT_typeLabel", Capi.Label, frame, [])
*)

	fun update () = 
	  (updateTargets (!curTargets);
	   updateDisabled (!disTargets))

	fun apply () =
	  let 
	    val cur = map #1 (!curTargets) and dis = map #1 (!disTargets)
	  in
	    ProjFile.setTargets(cur, dis, !targetDetails);
	    changed := false;
	    update();
	    ignore(callerUpdate cur);
	    true
	  end
	  handle ProjFile.InvalidTarget t => 
	    (Capi.send_message (shell, "Target " ^ t ^ " not specified in the list of files");
	     false)

	fun reset () = 
	  let 
	    val (current, disabled, details) = ProjFile.getTargets ()
	  in
	    curTargets := number_entries (current, 1);
	    disTargets := number_entries (disabled, 1);
	    targetDetails := details;
	    curSel := NONE;
	    disSel := NONE;
	    changed := false;
	    update()
	  end

	(* On closing the dialog, the selections in the listbox must be desselected,
	 * for the following reason:  if a NewProject command is given, the reference
	 * lists are reset, but the selection references are not as they are out of 
	 * scope, so when NewProject command is given, the dialogs are closed to 
	 * reset the selection references to avoid inconsistencies. 
	 *)
	fun close () = 
	  (reset ();
	   visible := false;
	   Capi.set_focus (Capi.parent shell);
	   Capi.hide shell)

	val (closeRC, updateCloseButtons) = 
	  mkCloseButtons {parent = frame, 
			  apply = apply,
			  reset = reset,
			  close = close,
			  changed = fn () => (!changed)}

	(* Updates the display of the details of the selected current target *)
	fun updateDetails () = 
	  ((* TTT: temporarily removed
	   updateTypes();
	   *)
	   updateCloseButtons())

	fun do_layout () = 
	  Capi.Layout.lay_out (frame, NONE,
		[Capi.Layout.FIXED label,
		 Capi.Layout.FLEX curScroll,
		 Capi.Layout.SPACE,
		 Capi.Layout.FIXED targetRC,
		 Capi.Layout.SPACE,
		 Capi.Layout.FIXED disableLabel,
		 Capi.Layout.FIXED disScroll,
		 Capi.Layout.FIXED disableRC,
		 Capi.Layout.SPACE,

(* TTT: temporarily removed 
		 Capi.Layout.FIXED detailsLabel,
		 Capi.Layout.FIXED typeLabel,
		 Capi.Layout.FIXED typesRC,
		 Capi.Layout.SPACE, 
*)
		 Capi.Layout.FIXED closeRC,
		 Capi.Layout.SPACE])

      in
	(* Steps in updating the targets (order not important):
	 * 1)	Keep targetDetails consistent with targets
	 * 2)	Update sensitivity of buttons applying to list of current targets
	 * 3)	Call the update function passed in by the caller
	 * 4)	Update buttons for changing the mode and configuration of a target
	 * 5)	Update the display of the details of the selected current target
	 *)
	updateTargetsRef := 
	  (fn () => (targetDetails := addDetails ((!curTargets) @ (!disTargets));
		     updateTargetButtons();
		     updateDetails()));
	updateDisabledRef := 
	  (fn () => (updateDisableButtons();
		     updateCloseButtons()));

	Capi.remove_menu menuBar;
	Capi.set_close_callback (frame, close);
	do_layout();
	(fn () => (visible := true;
 		  if not (!changed) then reset() else ();
		  update();
		  Capi.reveal frame;
		  Capi.reveal shell;
		  Capi.to_front shell),
	 fn () =>
	   if apply_changes (shell, "Apply changes in targets dialog?", !changed) then
	     ignore(apply())
	   else
	     reset()
	)
      end  (* mk_targets_dialog *)

    (* This caller update function isn't needed as in prop_config_dialog *)
    fun mk_modes_dialog (parent, callerUpdate) =
      let
	val modeSel = ref NONE
	val modeChanged = ref false
	val modes = ref []
	val modeDetails = ref ([]: mode_details list)
	val curMode = ref ""

	val visible = ref false
	val (shell, frame, menuBar, _) = 
	  Capi.make_main_popup {name = "propModesDialog", 
				title = "Project Properties - Modes", 
				parent = parent, 
				contextLabel = false, 
				visibleRef = visible,
				pos = Capi.getNextWindowPos()}

	val label = Capi.make_managed_widget 
				("PWM_modeLabel", Capi.Label, frame, [])

	val curLabel = Capi.make_managed_widget
				("PWM_curLabel", Capi.Label, frame, [])

	fun initModeDetails modeName = 
	  {name 			= modeName, 
	   location			= ref modeName,  (* default of name of mode *)
	   generate_interruptable_code  = ref true,
	   generate_interceptable_code  = ref true,
	   generate_debug_info		= ref true,
	   generate_variable_debug_info = ref true,
	   optimize_leaf_fns		= ref false,
	   optimize_tail_calls		= ref false,
	   optimize_self_tail_calls	= ref false,
	   mips_r4000			= ref true,
	   sparc_v7			= ref false}

	fun get_mode_details () = 
	  let val name = #1 (valOf (!modeSel)) 
	  in
	    ProjFile.getModeDetails (#1 (valOf (!modeSel)), !modeDetails)
	    handle ProjFile.NoModeDetailsFound m =>
	      (Capi.send_message (shell, 
		 "Error in modes.  No details found for mode: " ^ m);
	       initModeDetails m)
	  end

	val modeList = 
	  [("PWM_genInterruptCode"),
	   ("PWM_genInterceptCode"),
	   ("PWM_genDebugInfo"),
	   ("PWM_genVarDebugInfo"),
	   ("PWM_optLeaf"),
	   ("PWM_optTail"),
	   ("PWM_optSelfTail")] @ 
          (case MachSpec.mach_type of
             MachSpec.MIPS =>  [("PWM_mipsR4000")]
           | MachSpec.SPARC => [("PWM_sparcV7")]
           | MachSpec.I386 =>  [])

	fun getBoolRef s (r: mode_details) = 
	  case s of 
	     "PWM_genInterruptCode" 	=> #generate_interruptable_code r
           | "PWM_genInterceptCode" 	=> #generate_interceptable_code r
      	   | "PWM_genDebugInfo"		=> #generate_debug_info r
      	   | "PWM_genVarDebugInfo"	=> #generate_variable_debug_info r
    	   | "PWM_optLeaf"		=> #optimize_leaf_fns r
    	   | "PWM_optTail"		=> #optimize_tail_calls r
      	   | "PWM_optSelfTail"		=> #optimize_self_tail_calls r
       	   | "PWM_mipsR4000"		=> #mips_r4000 r
       	   | "PWM_sparcV7"		=> #sparc_v7 r
     	   | _ => ref false

	val updateModesRef = ref (fn () => ())

	val (modeScroll, updateModes) = 
	  mk_list (frame, "modeList")
	    modeSel updateModesRef modes

	fun modeGet s () = 
	  if isSome (!modeSel) then 
	    let val details = get_mode_details()
	    in !(getBoolRef s details)
	    end
	  else false

	fun modeSet s value = 
	  if isSome (!modeSel) then 
	    let val details = get_mode_details()
	    in
	      (getBoolRef s details) := value;
	      modeChanged := true;
	      updateModes (!modes)
	    end
	  else ()

	fun addModeDetails [] = []
	  | addModeDetails ((name, p)::t) = 
	    let 
	      val details = 
		List.find (fn {name=n,...} => name=n) (!modeDetails)
	    in
	      if isSome details then
		valOf(details) :: (addModeDetails t)
	      else
		(initModeDetails name) :: (addModeDetails t)
	    end

	fun create_opt s = 
	  let 
	    val detailsRC = Capi.make_managed_widget
				("PWM_detailsRC", Capi.RowColumn, frame, [])
	    val {update, ...} = 
	      Menus.make_buttons (detailsRC, 
		[Menus.TOGGLE (s, modeGet s, modeSet s, fn _ => true)])
	  in
	    (detailsRC, update)
	  end

	val details = map create_opt modeList

	fun updateModeDetails () = 
	  (modeDetails := addModeDetails (!modes);
	   app (fn a => (#2 a)()) details)

	val modesRC = Capi.make_managed_widget 
				("PWM_modesRC", Capi.RowColumn, frame, [])

	fun removeModeCB () =
	  removeSelCB (modeSel, modes, modeChanged) updateModes

	fun updateCurMode newCurMode = 
	  (curMode := newCurMode;
	   Capi.set_label_string(curLabel, "Current Mode:  " ^ newCurMode))

	fun setCurModeCB () =
	  let 
	    val (selection, pos) = getOpt(!modeSel, ("",0))
	  in
	    if (selection <> "") then 
	      (updateCurMode selection;
	       modeChanged := true;
	       updateModes (!modes))
	    else
	      Capi.beep parent
	  end

	val {update=updateModeButtons, ...} = 
	  Menus.make_buttons (modesRC, 
		[Menus.PUSH ("PWM_removeMode", removeModeCB, fn _ => isSome(!modeSel)),
		 Menus.PUSH ("PWM_setCurMode", setCurModeCB, fn _ => isSome(!modeSel))])

	val newMode = Capi.make_managed_widget
				("PWM_newMode", Capi.Text, frame, [])

	val addModeRC = Capi.make_managed_widget 
				("PWM_addModeRC", Capi.RowColumn, frame, [])

	fun addModeCB () = 
	  let 
	    val mode = parse_name (newMode, parent)
	  in 
	    if not (mode is_in (!modes)) andalso mode <> "" then 
	      let 
		val new_modes = (mode,1) :: (map renumber_up (!modes))
	      in
		modeSel := SOME (mode,1);
		Capi.Text.set_string (newMode, "");
		modeChanged := true;
		updateModes new_modes
	      end
	    else ()
	  end

	val {update, ...} = 
	  Menus.make_buttons (addModeRC, 
		[Menus.PUSH ("PWM_addMode", addModeCB, fn _ => true)])

	val locLabel = Capi.make_managed_widget
				("PWM_locLabel", Capi.Label, frame, [])
	val locText = Capi.make_managed_widget
				("PWM_locText", Capi.Text, frame, [])

	val locChangeRC = Capi.make_managed_widget
				("PWM_locChangeRC", Capi.RowColumn, frame, [])

	fun locChangeCB () = 
	  if isSome (!modeSel) then
	    let 
	      val dirName = parse_name (locText, parent)
	      val {name, location, ...} = get_mode_details()
	      val (_, _, curConfig) = ProjFile.getConfigurations()
	      val (lib, obj, bin) = ProjFile.getLocations()
	      val legal_location = 
		(ignore (OS.Path.concat [obj, getOpt(curConfig, ""), dirName]);
		 true)
		 handle OS.Path.Path => 
		   (Capi.send_message (shell, "Invalid directory name for mode: " ^ name);
		    false)
	    in
	      if legal_location then 
	        (location := dirName;
	         Capi.Text.set_string (locText, "");
	         modeChanged := true;
	         updateModes (!modes))
	      else ()
	    end
	  else ()

	val {update=updateLocButton, ...} = 
	  Menus.make_buttons (locChangeRC, 
		[Menus.PUSH ("PWM_locChange", locChangeCB, fn _ => isSome(!modeSel))])

	fun updateModeLoc () = 
	  if isSome(!modeSel) then
	    let 
	      val {location, ...} = get_mode_details()
	    in
	      Capi.set_label_string (locLabel, "Mode directory name:  " ^ (!location))
	    end
	  else
	    Capi.set_label_string (locLabel, "Mode directory name:  <No mode selected>")

	val modeDetailsLabel = Capi.make_managed_widget 
				("PWM_modeDetailsLabel", Capi.Label, frame, [])

	fun update () = updateModes (!modes)

	fun apply () = 
	  let
	    val modeNames = map #1 (!modes)
	    val modeExists = List.find (fn c => c = (!curMode)) modeNames
	  in
	    if isSome(modeExists) then
	      (ProjFile.setModes (modeNames, !modeDetails);
	       ProjFile.setCurrentMode
		 (Info.make_default_options (),
		  Info.Location.FILE "Project Properties")
		 (!curMode);
	       ignore(callerUpdate modeNames);
	       modeChanged := false;
	       update();
	       true)
	    else 
	      (Capi.send_message (shell, "Invalid current mode or none set");
	       false)
	  end

	fun reset () = 
	  let 
	    val (modeList, details, currentMode) = ProjFile.getModes()
	  in
	    modes := number_entries (modeList, 1);
	    modeDetails := details;
	    curMode := getOpt(currentMode, "");
	    modeChanged := false;
	    modeSel := NONE;
	    update()
	  end

	fun close () = 
	  (reset();
	   visible := false;
	   Capi.set_focus (Capi.parent shell);
	   Capi.hide shell)

	val (closeRC, updateCloseButtons) = 
	  mkCloseButtons {parent = frame, 
			  apply = apply,
			  reset = reset,
			  close = close,
			  changed = fn () => (!modeChanged)}

	fun do_layout () = 
	  Capi.Layout.lay_out (frame, NONE,
		[Capi.Layout.FIXED label,
		 Capi.Layout.FLEX modeScroll,
		 Capi.Layout.FIXED curLabel,
		 Capi.Layout.FIXED modesRC,
		 Capi.Layout.SPACE,
		 Capi.Layout.FIXED newMode,
		 Capi.Layout.FIXED addModeRC,
		 Capi.Layout.SPACE,
		 Capi.Layout.FIXED locLabel,
		 Capi.Layout.FIXED locText,
		 Capi.Layout.FIXED locChangeRC,
		 Capi.Layout.FIXED modeDetailsLabel] @ 
		(map Capi.Layout.FIXED (map (fn (a,b) => a) details)) @
		[Capi.Layout.SPACE,
		 Capi.Layout.FIXED closeRC,
		 Capi.Layout.SPACE])

      in
 	updateModesRef := (fn () => (updateCurMode(!curMode);
				     updateModeDetails(); 
				     updateCloseButtons();
				     updateModeButtons();
				     updateModeLoc();
				     updateLocButton()));
	Capi.remove_menu menuBar;
	Capi.set_close_callback (frame, close);
	do_layout();
	(fn () => (visible := true;
		  if not (!modeChanged) then reset() else ();
		  update();
		  Capi.reveal frame;
		  Capi.reveal shell;
		  Capi.to_front shell),
	 fn () =>
	   if apply_changes (shell, "Apply changes in modes dialog?", !modeChanged) then
	     ignore(apply())
	   else
	     reset()
	 )
      end  (* mk_modes_dialog *)

    fun mk_configs_dialog (parent, callerUpdate) = 
      let
	val configSel = ref NONE
	val pathSel = ref NONE
	val configChanged = ref false
	val configs = ref []
	val configDetails = ref ([]: ProjFile.config_details list)
	val curConfig = ref ""

	fun is_sel () = isSome(!configSel)

	val visible = ref false
	val (shell, frame, menuBar, _) = 
	  Capi.make_main_popup {name = "propConfigDialog", 
				title = "Project Properties - Configurations", 
				parent = parent, 
				contextLabel = false, 
				visibleRef = visible,
				pos = Capi.getNextWindowPos()}

	val label = Capi.make_managed_widget 
				("PWC_configLabel", Capi.Label, frame, [])

	val curLabel = Capi.make_managed_widget
				("PWC_curLabel", Capi.Label, frame, [])

	val configUpdateRef = ref (fn () => ())

	fun initConfigDetails name = 
	  {name = name, 
	   files = [],
	   library = []}

	fun modifyConfigDetails ((n, files, lib), configRef) = 
	  ProjFile.modifyConfigDetails
	    ({name=n, files=files, library=lib}, !configRef)
	  handle ProjFile.NoConfigDetailsFound c =>
	      (Capi.send_message (shell, 
		 "Error in configurations.  No details found for configuration: " ^ c);
	       (!configDetails))

	fun get_cf_details () = 
	  let val configName = #1 (valOf (!configSel))
	  in
	    ProjFile.getConfigDetails (configName, !configDetails)
	    handle ProjFile.NoConfigDetailsFound c =>
	      (Capi.send_message (shell, 
		 "Error in configurations.  No details found for configuration: " ^ c);
	       initConfigDetails configName)
	     | Option => 
	      (Capi.send_message (shell, "No configuration selected");
		initConfigDetails configName)
	  end

	val (configScroll, updateConfigs) = 
	  mk_list (frame, "configList")
	    configSel configUpdateRef configs

	val configRC = Capi.make_managed_widget 
				("PWC_configRC", Capi.RowColumn, frame, [])

	fun removeConfigCB () = 
	  removeSelCB (configSel, configs, configChanged) updateConfigs

	fun updateCurConfig newCurConfig = 
	  (curConfig := newCurConfig;
	   Capi.set_label_string(curLabel, "Current Configuration:  " ^ newCurConfig))

	fun setCurConfigCB () =
	  let 
	    val (selection, pos) = getOpt(!configSel, ("",0))
	  in
	    if (selection <> "") then 
	      (updateCurConfig selection;
	       configChanged := true;
	       updateConfigs(!configs))
	    else
	      Capi.beep parent
	  end

	val {update=updateConfigButtons, ...} = 
	  Menus.make_buttons (configRC, 
		[Menus.PUSH ("PWC_removeConfig", removeConfigCB, is_sel),
		 Menus.PUSH ("PWC_setCurConfig", setCurConfigCB, is_sel)])

	val addConfig = Capi.make_managed_widget
				("PWC_addConfig", Capi.Text, frame, [])

	fun addConfigCB () =
	  let 
	    val config = parse_name (addConfig, parent)
	  in 
	    if not (config is_in (!configs)) andalso config <> "" then 
	      let 
		val new_configs = (config,1) :: (map renumber_up (!configs))
	      in
		configSel := SOME (config,1);
		Capi.Text.set_string (addConfig, "");
		configChanged := true;
		updateConfigs new_configs
	      end
	    else ()
	  end

	val addConfigRC = Capi.make_managed_widget 
				("PWC_addConfigRC", Capi.RowColumn, frame, [])

	val {update, ...} = 
	  Menus.make_buttons (addConfigRC, 
		[Menus.PUSH ("PWC_addConfig", addConfigCB, fn _ => true)])

	val libraryLabel = Capi.make_managed_widget 
				("PWC_libraryLabel", Capi.Label, frame, [])
	val libraryText = Capi.make_managed_widget 
				("PWC_libraryText", Capi.Text, frame, [])

	val configPathRC = Capi.make_managed_widget 
				("PWC_configPathRC", Capi.RowColumn, frame, [])

	fun getConfigFiles () = 
	  if is_sel() then 
	    #files (get_cf_details())
	  else 
	    []

	fun setConfigFiles_no_check (changed_config, theList) = 
	  let 
	    val the_config = valOf (changed_config)
	    val {name, files, library} = 
	      ProjFile.getConfigDetails (the_config, !configDetails)
	  in
	    configDetails := 
		modifyConfigDetails ((name, theList, library), 
				     configDetails);
	    configChanged := true;
 	    updateConfigs (!configs);
	    false    (* Indicates that the files dialog contains
		      * no changes after this update *)
	  end
	  handle ProjFile.NoConfigDetailsFound c =>
	    (Capi.send_message (shell, 
		 "Error in configurations.  No details found for configuration: " ^ c);
	     true)

	(* This checks for duplicate module ids with any configuration + common files *)
	fun setConfigFiles (config, theList) = 
	  case (duplicate_mod_ids (theList @ ProjFile.getFiles()) []) of
	    NONE => setConfigFiles_no_check (config, theList)
	  | SOME f => (duplicate_id (shell, f); true)

	val filesDialog = mk_get_files_dialog (shell,
					 "config_files", 
			    		 getConfigFiles,
			    		 setConfigFiles)

	fun getConfigLibraryPath () = 
	  if is_sel() then 
	    #library (get_cf_details())
	  else []

	fun setConfigLibraryPath (changed_config, theList) =
	  let 
	    val the_config = valOf (changed_config)
	    val {name, files, library} = 
	      ProjFile.getConfigDetails (the_config, !configDetails)
	  in
	    configDetails := 
		modifyConfigDetails ((name, files, theList), 
				     configDetails);
	    configChanged := true;
	    updateConfigs (!configs);
	    Capi.Text.set_string (libraryText, list2str theList)
	  end
	  handle ProjFile.NoConfigDetailsFound c =>
	      Capi.send_message (shell, 
		 "Error in configurations.  No details found for configuration: " ^ c)

	val libPath = mk_path_dialog (shell,
				      "config_lib", 
			    	      getConfigLibraryPath,
			    	      setConfigLibraryPath)

	fun get_config_sel () = 
	  #1 (valOf (!configSel))
	  handle Option => noConfigSelStr

	fun setPathCB (setPath, applyReset) () =
	  if is_sel() then 
	    (pathSel := (!configSel);
	    setPath get_config_sel)
	  else
 	    applyReset()

	val {update=updateSetButtons, ...} = 
	  Menus.make_buttons (configPathRC, 
		[Menus.PUSH ("PWC_files", setPathCB filesDialog, is_sel),
		 Menus.PUSH ("PWC_libraryPath", setPathCB libPath, is_sel)])

	fun addCFdetails [] = []
	  | addCFdetails ((configName, p)::t) = 
	      let 
		val details = 
		  List.find (fn {name=n, ...} => n = configName) (!configDetails)
	      in
		if isSome details then
		  valOf(details) :: (addCFdetails t)
		else
		  (initConfigDetails configName) :: (addCFdetails t)
	      end

	fun rem_old_config_units (configs, c_details, old_config) new_config =
          let
	    fun get_c_files config = 
	      #files (ProjFile.getConfigDetails (config, c_details))
	    fun get_c_modules config = 
	      map (fn f => ModuleId.from_host(OS.Path.file f,
                                              Info.Location.FILE "Project Properties"))
		  (get_c_files config)
            fun remove_unit (mod_id, proj) = Project.delete(proj, mod_id, false)
            val init_proj = Incremental.get_project()
            val set = Incremental.set_project
          in
            case (old_config, new_config) of
              (NONE, _) => ()
	    | (SOME old, NONE) =>
		set (foldl remove_unit init_proj (get_c_modules old))
            | (SOME old, SOME new) =>
		if (old = new) then ()
		else
                  set (foldl remove_unit init_proj (get_c_modules old))
          end
          handle ProjFile.NoConfigDetailsFound c => ()

	fun apply () = 
	  let 
	    val configNames = map #1 (!configs)
	    val configExists = List.find (fn c => c = (!curConfig)) configNames
	    val details = 
	      (if isSome(configExists) then
		SOME (ProjFile.getConfigDetails((!curConfig), (!configDetails)))
	      else
		NONE)
	      handle ProjFile.NoConfigDetailsFound c =>
		(Capi.send_message (shell, 
		   "Error in configurations.  No details found for configuration: " ^ c);
		 NONE)
	    val c_files = case details of NONE => [] | SOME d => #files d

	    fun invalid_config () = 
	      (Capi.send_message (shell, "Invalid current configuration or none set");
	       false)
	    val newConfig = if (configNames <> []) then SOME (!curConfig) else NONE
	    val oldDetails = ProjFile.getConfigurations()

	    (* the configChanged reference should be reset before calling rem_old_config
	     * because the applyReset function for configurations is called as a result 
	     * of calling Incremental.set_project (via ProjectWorkspace.updateDisplay).
	     * This also means that rem_old_config_units should be called after the 
	     * calls to ProjFile otherwise the dialog will be reset before applied. 
	     * Also setCurrentConfiguration should be called after setConfigurations. *)
	    fun apply_it () = 
	      (configChanged := false;
	       ProjFile.setConfigurations (configNames, !configDetails);
	       ProjFile.setCurrentConfiguration
		 (Info.make_default_options (),
		  Info.Location.FILE "Project Properties")
		  newConfig;
	       (* callerUpdate should be called after the current configuration
		* is set as the callerUpdate calls ProjFile.getConfigurations.   
		*)
	       rem_old_config_units oldDetails newConfig;
               ignore(callerUpdate());
	       updateConfigs (!configs);
	       true)

	    fun check_apply () = 
	      case (duplicate_mod_ids (ProjFile.getFiles() @ c_files) []) of
		NONE => apply_it()
	      | SOME f => (duplicate_id (shell, f); false)
	  in
	    case configExists of 
	      NONE => if (configNames = []) then 
			(curConfig := "";
	                 Capi.set_label_string(curLabel, "Current Configuration:");
			 check_apply())
		      else 
			invalid_config()
	    | SOME c => check_apply()
	  end

	fun reset () = 
	  let 
	    val (configList, details, currentConfig) = ProjFile.getConfigurations()
	  in
	    configs := number_entries (configList, 1);
	    configDetails := details;
	    curConfig := getOpt(currentConfig, "");
	    configChanged := false;
	    configSel := NONE;
	    updateConfigs (!configs)
	  end

	fun close () = 
	  (reset();
	   visible := false;
	   Capi.set_focus (Capi.parent shell);
	   Capi.hide shell)

	val (closeRC, updateCloseButtons) = 
	  mkCloseButtons {parent = frame, 
			  apply = apply,
			  reset = reset,
			  close = close,
			  changed = fn () => (!configChanged)}

	fun updateCFdetails () = 
	  (configDetails := addCFdetails (!configs);
	   updateCloseButtons();
	   if is_sel() then 
	     let 
	       val {name, files, library} = get_cf_details()
	     in
	       Capi.Text.set_string (libraryText, list2str library)
	     end
	   else ())

	fun do_layout () = 
	  Capi.Layout.lay_out (frame, NONE,
		[Capi.Layout.FIXED label,
		 Capi.Layout.FLEX configScroll,
		 Capi.Layout.FIXED curLabel,
		 Capi.Layout.FIXED configRC,
		 Capi.Layout.SPACE,
		 Capi.Layout.FIXED addConfig,
		 Capi.Layout.FIXED addConfigRC,
		 Capi.Layout.SPACE,
 		 Capi.Layout.FIXED libraryLabel,
		 Capi.Layout.FIXED libraryText,
		 Capi.Layout.SPACE,
		 Capi.Layout.FIXED configPathRC,
		 Capi.Layout.SPACE, 
		 Capi.Layout.FIXED closeRC,
		 Capi.Layout.SPACE])


	val closing_dialogs = ref false
      in
	configUpdateRef := 
	    (fn () => 
		let 
		  (* This must be called before filesDialog and libPath are called, 
		   * so that the configuration details are up to date, otherwise
		   * an attempt is made to access details which will be out of 
		   * date after adding a new configuration.
		   *)
		  val _ = updateCFdetails()
		  val (F, applyResetF) = filesDialog
		  val (L, applyResetL) = libPath

		  fun applyResetThem () = 
		    if (!closing_dialogs) then ()
		    else 
		      (closing_dialogs := true;
		       applyResetF(); applyResetL(); updateCFdetails();
		       closing_dialogs := false)

		in
		  applyResetThem();
		  updateCurConfig(!curConfig);
		  updateConfigButtons();
		  updateSetButtons()
		end);
	Capi.remove_menu menuBar;
	Capi.set_close_callback (frame, close);
	do_layout();
	(fn () => (visible := true;
 		  if not (!configChanged) then reset() else ();
		  updateConfigs (!configs);
		  Capi.reveal frame;
		  Capi.reveal shell;
		  Capi.to_front shell),
	 fn () =>
	   if apply_changes (shell, "Apply changes in configurations dialog?", !configChanged) then
	     ignore(apply())
	   else
	     reset()
	)
      end  (* mk_configs_dialog *)

    fun mk_library_dialog (parent, callerUpdate) = 
      let
	fun getLibPath() = #1 (ProjFile.getLocations())

	fun setLibPath (config_, dirList) = 
	  let
	    val (libPath, objDir, binDir) = ProjFile.getLocations()
	  in
	    ignore(callerUpdate (list2str dirList));
	    ProjFile.setLocations (dirList, objDir, binDir)
	  end

	val (mkLibPath, applyResetLibPath) = 
	  mk_path_dialog (parent, "lib_path", getLibPath, setLibPath)

      in
	((fn () => 
	   mkLibPath (fn () => "Ordered list of directories where library files are found:")),
	 applyResetLibPath)
      end

    fun set_objects_dir (parent, objRelativeRef, callerUpdate) = 
      let 
	val rawText = get_directory (parent, MAY_EXIST)
	val text = 
	  if (!objRelativeRef) then 
	    OS.Path.mkCanonical
	      (OS.Path.mkRelative {path=rawText, relativeTo=ProjFile.getProjectDir ()})
	  else
	    rawText

	val (libPath, objDir, binDir) = ProjFile.getLocations()
      in
	if (rawText <> "") andalso (text <> objDir) then 
	  (need_saved := true;
	   ProjFile.setLocations (libPath, text, binDir);
	   callerUpdate text)
	else ()
      end

    fun set_binaries_dir (parent, binRelativeRef, callerUpdate) = 
      let 
	val rawText = get_directory (parent, MAY_EXIST)
	val text = 
	  if (!binRelativeRef) then 
	    OS.Path.mkCanonical
	      (OS.Path.mkRelative {path=rawText, relativeTo=ProjFile.getProjectDir ()})
	  else
	    rawText

	val (libPath, objDir, binDir) = ProjFile.getLocations()
      in
	if (text <> "") andalso (text <> binDir) then 
	  (need_saved := true;
	   ProjFile.setLocations (libPath, objDir, text);
	   callerUpdate text)
	else ()
      end

    fun setRelObjBin (objChange, callerUpdate, relRef) b = 
      let
	val (lib, obj, bin) = ProjFile.getLocations()
	val relAbs = if b then OS.Path.mkRelative else OS.Path.mkAbsolute
	val valueChange = if objChange then obj else bin
	val newValue = 
	  OS.Path.mkCanonical (relAbs {path=valueChange, relativeTo=ProjFile.getProjectDir ()})
      in
	relRef := b;
	need_saved := true;
	if objChange then 
	  ProjFile.setLocations (lib, newValue, bin)
	else
	  ProjFile.setLocations (lib, obj, newValue);
	callerUpdate newValue
      end	

    fun mk_about_dialog parent = 
      let 
        val description = ref ""
        val version = ref ""
        val visible = ref false

	val (shell, frame, menuBar, _) = 
	  Capi.make_main_popup {name = "propAboutDialog", 
				title = "Project Properties - About Project", 
				parent = parent, 
				contextLabel = false, 
				visibleRef = visible,
				pos = Capi.getNextWindowPos()}

	val descLabel = Capi.make_managed_widget 
				("PWA_descLabel", Capi.Label, frame, [])
	val descText = Capi.make_managed_widget
				("PWA_descText", Capi.Text, frame, [])
	val verLabel = Capi.make_managed_widget 
				("PWA_verLabel", Capi.Label, frame, [])
	val verText = Capi.make_managed_widget
				("PWA_verText", Capi.Text, frame, [])

	val updateRef = ref (fn () => ())
	fun update () = (!updateRef)()

	fun about_changed () = 
	  let
	    val desc = Capi.Text.get_string descText
	    val ver = Capi.Text.get_string verText
	  in
	    (desc <> (!description)) orelse (ver <> (!version))
	  end

	fun apply () = 
	  if about_changed() then
	    (description := Capi.Text.get_string descText;
	     version := Capi.Text.get_string verText;
	     ProjFile.setAboutInfo (!description, !version);
	     update();
	     true)
	  else
	    true

	fun reset () = 
	  let 
	    val (desc, ver) = ProjFile.getAboutInfo()
	  in
	    description := desc;
	    version := ver;
	    update()
	  end

	fun close () = 
	  (reset();
	   visible := false;
	   Capi.set_focus (Capi.parent shell);
	   Capi.hide shell)

	val (closeRC, updateCloseButtons) = 
	  mkCloseButtons {parent = frame,
			  apply = apply,
			  reset = reset,
			  close = close,
			  changed = about_changed}

	fun setAbout (descript, ver) =
	  (description := descript;
	   version := ver;
	   Capi.Text.set_string (descText, descript);
	   Capi.Text.set_string (verText, ver);
	   updateCloseButtons())

	fun updateAbout () = 
	  (setAbout (!description, !version);
	   updateCloseButtons())

	fun do_layout () = 
	  Capi.Layout.lay_out (frame, NONE,
	    [Capi.Layout.FIXED descLabel,
	     Capi.Layout.FLEX descText,
	     Capi.Layout.FIXED verLabel,
	     Capi.Layout.FIXED verText,
	     Capi.Layout.SPACE,
	     Capi.Layout.FIXED closeRC,
	     Capi.Layout.SPACE])

      in
	updateRef := updateAbout;
	Capi.Callback.add (descText, Capi.Callback.ValueChange, updateCloseButtons);
	Capi.Callback.add (verText, Capi.Callback.ValueChange, updateCloseButtons);
	Capi.remove_menu menuBar;
	Capi.set_close_callback (frame, close);
	do_layout();
	reset();
	(fn () => (visible := true;
		  if not (about_changed()) then reset() else ();
		  update();
		  Capi.reveal frame;
		  Capi.reveal shell;
		  Capi.to_front shell),
	 fn () => 
	   if apply_changes (shell, "Apply changes in about dialog?", about_changed()) then
	     ignore(apply())
	   else
	     reset()
	)

      end  (* mk_about_dialog *)

    end  (* local containing mk_???_dialogs *)

end  (* struct *)


