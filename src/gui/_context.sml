(*  Context window
 *
 *  $Log: _context.sml,v $
 *  Revision 1.35  1998/03/31 15:15:28  johnh
 *  [Bug #30346]
 *  Call Capi.getNextWindowPos.
 *
 * Revision 1.34  1998/03/16  11:28:18  mitchell
 * [Bug #50061]
 * Fix tools so they restart in a saved image
 *
 * Revision 1.33  1998/02/13  15:58:04  johnh
 * [Bug #30344]
 * Allow windows to retain size and position.
 *
 * Revision 1.32  1998/01/27  15:55:36  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.31  1997/09/18  15:13:35  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.30.2.2  1997/11/20  17:05:12  johnh
 * [Bug #30071]
 * Remove Paths menu.
 *
 * Revision 1.30.2.1  1997/09/11  20:52:27  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.30  1997/08/04  12:03:29  johnh
 * [Bug #30111]
 * Start file viewer on double click.
 *
 * Revision 1.29  1997/06/12  15:03:15  johnh
 * [Bug #30175]
 * Combine tools and windows menus.
 *
 * Revision 1.28  1997/06/10  11:20:02  johnh
 * [Bug #30075]
 * Allowing only one instance of tools.
 *
 * Revision 1.27  1997/05/16  15:35:36  johnh
 * \Implementing single menu bar on Windows.
 *
 * Revision 1.26  1996/11/01  11:03:06  johnh
 * Enabling close from control box on top left of window.
 *
 * Revision 1.25  1996/10/09  11:53:17  io
 * moving String from toplevel
 *
 * Revision 1.24  1996/08/15  14:25:57  daveb
 * [Bug #1519]
 * Changed the type of history entries (in UserContext) so that when a single
 * expression defines several identifiers, only the first stores the string.
 * Also replaced code in get_current_item with a call to
 * ShellUtils.value_from_history_entry.
 *
 * Revision 1.23  1996/08/07  11:36:39  daveb
 * [Bug #1531]
 * Unset the current item when after a delete command.
 *
 * Revision 1.22  1996/05/24  13:43:21  daveb
 * Type of GuiUtils.view_option has changed.
 *
 * Revision 1.21  1996/05/23  15:49:38  daveb
 * Replace Evaluator with File Viewer.
 *
 * Revision 1.20  1996/05/14  15:08:19  daveb
 * Added File menu.
 *
 * Revision 1.19  1996/05/10  14:45:30  daveb
 * Added edit_possible field to ToolData.edit_menu.
 *
 * Revision 1.18  1996/05/01  11:24:46  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.17  1996/04/11  16:02:01  daveb
 * Added ability to delete entries.
 *
 * Revision 1.16  1996/03/07  17:04:07  daveb
 * Disabled show_defn menu entry when no item selected.
 *
 * Revision 1.15  1996/02/19  16:36:29  daveb
 * Added "output-only" evaluator to display source and result of selected entry
 *
 * Revision 1.14  1996/02/19  14:13:50  daveb
 * Removed redundant function definition.
 *
 * Revision 1.13  1996/02/08  15:59:16  daveb
 * Stopped the update from always selecting the newly updated item.
 * Capi.make_scrolllist now returns a record, with an add_items field.
 * Removed the old sensitivity code.
 *
 * Revision 1.12  1996/01/23  15:56:13  daveb
 * Type of GuiUtils.value_menu has changed.
 *
 * Revision 1.11  1996/01/22  16:35:18  matthew
 * Using Info.null_options in call to eval
 *
 * Revision 1.10  1996/01/19  11:00:05  matthew
 * Changing inspector interface.
 *
 * Revision 1.9  1996/01/17  17:28:22  matthew
 * Reordering top level menus.
 *
 * Revision 1.8  1995/12/07  14:40:01  matthew
 * Changing interface to edit_menu
 *
 * Revision 1.7  1995/11/15  16:50:28  matthew
 * Adding windows menu
 *
 * Revision 1.6  1995/10/04  13:01:16  daveb
 * Type of context_menu has changed.
 *
 * Revision 1.5  1995/09/11  13:19:12  matthew
 * Changing top level window initialization
 *
 * Revision 1.4  1995/08/30  13:23:34  matthew
 * Changing layout
 *
 * Revision 1.3  1995/08/10  12:22:31  matthew
 * Adding make_buttons function to capi
 *
 * Revision 1.2  1995/07/27  10:55:56  matthew
 * Moved capi etc. to gui
 *
 * Revision 1.1  1995/07/26  14:42:46  matthew
 * new unit
 * New unit
 *
 *  Revision 1.17  1995/07/07  15:31:21  daveb
 *  Minor changes to layout.
 *
 *  Revision 1.16  1995/07/04  14:04:00  matthew
 *  More capification
 *
 *  Revision 1.15  1995/06/29  10:05:23  matthew
 *  Capification
 *
 *  Revision 1.14  1995/06/20  14:37:37  daveb
 *  Added call to Xm.List.setBottomPos, to ensure that selected item is
 *  always visible.
 *
 *  Revision 1.13  1995/06/08  14:20:49  daveb
 *  Ensured that current selection is highlighted after an update.
 *
 *  Revision 1.12  1995/06/06  10:38:12  daveb
 *  Made the context history highlight the current selection on start up.
 *
 *  Revision 1.11  1995/06/01  12:57:45  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.10  1995/05/23  09:27:14  daveb
 *  Made contexts only visible if full_menus set.
 *
 *  Revision 1.9  1995/05/04  09:46:49  matthew
 *  Changing createPopupShell to create
 *
 *  Revision 1.8  1995/04/28  15:00:41  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.7  1995/04/24  14:51:52  daveb
 *  Changed title to Context History.
 *
 *  Revision 1.6  1995/04/19  12:17:10  daveb
 *  A new tool is now passed the right user context.
 *
 *  Revision 1.4  1995/04/06  16:08:23  daveb
 *  FileDialog.find_file now takes an applicationShell parameter.
 *
 *  Revision 1.3  1995/03/31  17:44:02  daveb
 *  Added the history number to items in the history, and made this tool
 *  sensitive to selections elsewhere.
 *
 *  Revision 1.2  1995/03/31  13:27:29  daveb
 *  Tidied writing of history to files.
 *  Also disabled "save" menu item when there is no name for the save file.
 *  Also fixed bug that stopped version 1.1 from compiling at all!!
 *
 *  Revision 1.1  1995/03/31  09:14:08  daveb
 *  new unit
 *  Context history window.
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
 *)

require "capi";
require "menus";
require "../utils/lists";
require "../main/user_options";
require "../main/preferences";

require "../interpreter/shell_utils";
require "../interpreter/save_image";

require "tooldata";
require "inspector_tool";
require "file_viewer";
require "gui_utils";
require "context";

functor ContextHistory (
  structure Capi : CAPI
  structure ToolData : TOOL_DATA
  structure Menus : MENUS
  structure GuiUtils : GUI_UTILS
  structure FileViewer : FILE_VIEWER
  structure InspectorTool : INSPECTORTOOL
  structure ShellUtils : SHELL_UTILS
  structure Lists: LISTS
  structure UserOptions : USER_OPTIONS
  structure Preferences : PREFERENCES
  structure SaveImage : SAVE_IMAGE

  sharing ToolData.ShellTypes.Options = UserOptions.Options = ShellUtils.Options

  sharing type Preferences.user_preferences =
	       ToolData.ShellTypes.user_preferences =
	       GuiUtils.user_preferences

  sharing type GuiUtils.user_context_options =
	       ToolData.UserContext.user_context_options

  sharing type ToolData.ShellTypes.user_options =
	       GuiUtils.user_tool_options =
	       UserOptions.user_tool_options

  sharing type Menus.Widget = ToolData.Widget = FileViewer.Widget =
	       GuiUtils.Widget = Capi.Widget = InspectorTool.Widget

  sharing type Menus.ButtonSpec = GuiUtils.ButtonSpec = ToolData.ButtonSpec

  sharing type ToolData.ShellTypes.user_context = GuiUtils.user_context

  sharing type GuiUtils.MotifContext = ToolData.MotifContext

  sharing type InspectorTool.ToolData = ToolData.ToolData = FileViewer.ToolData

  sharing type ShellUtils.Context = ToolData.ShellTypes.Context
  sharing type GuiUtils.Type = ShellUtils.Type = InspectorTool.Type
  sharing type ShellUtils.history_entry = ToolData.UserContext.history_entry

): CONTEXT_HISTORY =
struct
  
  structure UserContext = ToolData.UserContext
  structure ShellTypes = ToolData.ShellTypes
  structure Options = UserOptions.Options

  structure Info = ShellUtils.Info

  type ToolData = ToolData.ToolData

  val history_tool = ref NONE

  val sizeRef = ref NONE
  val posRef = ref NONE

  fun create_history (tooldata as ToolData.TOOLDATA
                {args,appdata,current_context,motif_context,tools}) =
    let
      val ShellTypes.LISTENER_ARGS {user_options,
                                    user_preferences,
                                    prompter,
                                    mk_xinterface_fn,
                                    ...} = args
      val ToolData.APPLICATIONDATA {applicationShell,...} = appdata

      val full_menus =
	case user_preferences
	of Preferences.USER_PREFERENCES ({full_menus, ...}, _) =>
          !full_menus

      val title = "History"

      (*** Make the windows ***)
      val (shell,frame,menuBar,contextLabel) = 
        Capi.make_main_window 
	       {name = "context",
		title = title,
		parent = applicationShell,
		contextLabel = full_menus, 
		winMenu = false,
		pos = getOpt (!posRef, Capi.getNextWindowPos())}

      val local_context = ref motif_context

      fun get_user_context () =
	GuiUtils.get_user_context (!local_context)

      val history = ref []: UserContext.history_entry list ref;

      fun empty_history () =
	case !history
	of [] => true
	|  _  => false

      val curr_string = ref ""
      val curr_item = ref NONE
      val do_select_fn = ref (fn () => ())
      val do_action_fn = ref (fn () => ())

      fun unset_selection _ =
	(curr_string := "";
	 curr_item := NONE)

      fun select_fn
	    _
            (entry as UserContext.ITEM (item as {result, ...})) =
        (curr_string := result;
         curr_item := SOME entry;
         (!do_select_fn) ())

      fun action_fn _ (entry as UserContext.ITEM (item as {result, ...})) = 
	(curr_string := result;
	 curr_item := SOME entry;
	 (!do_action_fn) ())

      val {scroll, list, set_items, add_items} =
        Capi.make_scrolllist
          {parent = frame, name = "context_window",
           print_fn =
             fn _ => fn (UserContext.ITEM {result, ...}) => result,
           select_fn = select_fn,
           action_fn = action_fn}

      fun get_print_options () =
        UserOptions.new_print_options user_options

      fun set_history_from_context user_context  =
        let
          val hist = UserContext.get_history user_context
        in
          history := hist;
          set_items(get_print_options ()) (rev hist)
        end

      fun delete_selection () =
	case !curr_item
	of NONE => ()
	|  SOME x =>
	  (UserContext.delete_from_history (get_user_context (), x);
	   unset_selection ())

      fun delete_all_duplicates () =
        (UserContext.remove_duplicates_from_history (get_user_context ());
	 unset_selection ())
      
      fun delete_all () =
        (UserContext.delete_entire_history (get_user_context ());
	 unset_selection ())
      
      fun update_fn NONE =
	set_history_from_context (get_user_context ())
      |   update_fn (SOME new_items) =
	(* This is partly to avoid flicker; partly an optimisation. *)
	(history := new_items @ !history;
         add_items(get_print_options ()) (rev new_items))

      val update_register_key =
        ref (UserContext.add_update_fn (get_user_context (), update_fn))

      fun with_no_history f arg1 arg2 =
	  let 
	    val history = !history_tool
            val user_context = get_user_context ()
	  in
	    history_tool := NONE;
            UserContext.remove_update_fn
              (user_context, !update_register_key);
	    ignore(f arg1 arg2 
                   handle exn => (history_tool := history; 
                                  update_register_key :=
                                    UserContext.add_update_fn
                                      (user_context, update_fn);
                                  raise exn));
	    history_tool := history;
            update_register_key :=
              UserContext.add_update_fn(user_context, update_fn)
	  end

      fun set_state motif_context =
        let
          val context_name = GuiUtils.get_context_name motif_context

          val cstring = "Context: " ^ context_name

	  val old_user_context = get_user_context ()

	  val new_user_context = GuiUtils.get_user_context motif_context
        in
          UserContext.remove_update_fn
            (old_user_context, !update_register_key);
	  case contextLabel
	  of SOME w =>
            Capi.set_label_string (w,cstring)
	  |  NONE => ();
          local_context := motif_context;
          set_history_from_context new_user_context;
          update_register_key :=
            UserContext.add_update_fn (new_user_context, update_fn)
        end

      val _ = set_state (!local_context)

      val context_key =
        ToolData.add_context_fn
          (current_context,
	   (set_state, fn () => user_options, ToolData.WRITABLE))

      fun select_state motif_context =
        (set_state motif_context;
         ToolData.set_current
           (current_context, context_key, user_options, motif_context))

      val quit_funs = ref []

      fun do_quit_funs _ = Lists.iterate (fn f => f ()) (!quit_funs)

      val _ =
        quit_funs :=
          (fn _ =>
	     let
	       val user_context = get_user_context ()
	     in
	       ToolData.remove_context_fn (current_context, context_key);
	       UserContext.remove_update_fn
                 (user_context, !update_register_key)
	     end)
          :: (fn _ => (history_tool := NONE))
	  :: !quit_funs

      fun close_window _ =
        (do_quit_funs ();
         Capi.destroy shell)

      fun mk_tooldata () =
        ToolData.TOOLDATA
          {args = ToolData.ShellTypes.LISTENER_ARGS
                    {user_options = user_options,
                     user_context = get_user_context (),
		     user_preferences = user_preferences,
                     prompter = prompter,
                     mk_xinterface_fn = mk_xinterface_fn},
           appdata = appdata,
	   motif_context = !local_context,
           current_context = current_context,
           tools = tools}

      val view_options =
        GuiUtils.view_options
          {parent = shell, title = title, user_options = user_options,
	   user_preferences = user_preferences,
           caller_update_fn = fn _ => (),
	   view_type = [GuiUtils.SENSITIVITY]}

      (* What this is doing is taking a history item (UserContext.Item)
	 and evaluating it in the context contained in the item *)
      fun get_current_value () =
        case !curr_item of
          NONE => NONE
        | SOME item =>
	  ShellUtils.value_from_history_entry
	    (item, ShellTypes.new_options (user_options, get_user_context()))

      val inspect_fn = InspectorTool.inspect_value (shell,false, mk_tooldata())

      fun is_selection () =
	case !curr_item
	of SOME _ => true
	|  NONE => false

      val show_defn_fn = FileViewer.create (shell, true, mk_tooldata())

      fun show_defn auto =
        case !curr_item of
          NONE => ()
        | SOME (item as UserContext.ITEM {source, ...}) =>
	   case source
	   of UserContext.STRING src => 
             show_defn_fn auto (FileViewer.STRING src)
	   |  UserContext.COPY src => 
             show_defn_fn auto (FileViewer.STRING src)

      val _ = 
        do_select_fn := 
	  (fn () =>
             (show_defn true;
	      case get_current_value () of
                SOME x => (inspect_fn true x)
              | _ => ()))

      (* set_focus needs to be done here so that once the file viewer is popped up,
       * focus is returned back to the History tool.
       *)
      val _ = do_action_fn := (fn () => (show_defn false;
					Capi.set_focus shell))

      val edit_menu =
         ToolData.edit_menu
           (shell,
            {cut = NONE,
             paste = NONE,
             copy = SOME (fn _ => Capi.clipboard_set (shell,!curr_string)),
             delete = SOME delete_selection,
             selection_made = fn _ => !curr_string <> "",
	     edit_possible = fn _ => true,
	     delete_all = SOME ("deleteAll",
		           fn _ => delete_all (),
		           fn _ => not (empty_history ())),
	     edit_source = [] })

      val value_menu =
	GuiUtils.value_menu
	  {parent = shell,
           user_preferences = user_preferences,
           inspect_fn = SOME (inspect_fn false),
           get_value = get_current_value,
	   enabled = true,
	   tail =
             [Menus.PUSH
                ("show_defn",
		 fn _ => show_defn false,
		 fn _ => is_selection ())]}

      val view = ToolData.extract view_options
      val values = ToolData.extract value_menu

      val menuspec =
        [ToolData.file_menu 
	    [("save",
		fn _ => GuiUtils.save_history
                 	(false, get_user_context (), applicationShell),
	        fn _ => not (UserContext.null_history (get_user_context ()))
         	        andalso UserContext.saved_name_set (get_user_context ())),
	     ("saveAs", 
		fn _ => GuiUtils.save_history
		        (true, get_user_context (), applicationShell),
		fn _ => not (UserContext.null_history (get_user_context ()))),
	     ("close", close_window, fn _ => true) ],
	 edit_menu,
	 ToolData.tools_menu (mk_tooldata, get_user_context),
	 ToolData.usage_menu 
	       (("removeDuplicates", 
		 fn _ => delete_all_duplicates (),
		 fn _ => not (empty_history ())) :: (values @ view), []),
	 ToolData.debug_menu (values)]

      val sep_size = 10

      fun storeSizePos () = 
	(sizeRef := SOME (Capi.widget_size shell);
	 posRef := SOME (Capi.widget_pos shell))

    in
      SaveImage.add_with_fn with_no_history;
      history_tool := SOME shell;
      Menus.make_submenus (menuBar,menuspec);
      quit_funs := Menus.quit :: (!quit_funs);
      quit_funs := storeSizePos :: (!quit_funs);
      Capi.Layout.lay_out
      (frame, !sizeRef,
       [Capi.Layout.MENUBAR menuBar] @
       (case contextLabel of
          SOME w => [Capi.Layout.FIXED w]
        | _ => [Capi.Layout.SPACE]) @
       [Capi.Layout.FLEX scroll,
        Capi.Layout.SPACE]);
      Capi.set_close_callback(frame, close_window);
      Capi.Callback.add (shell, Capi.Callback.Destroy,do_quit_funs);
      Capi.initialize_toplevel shell
    end

  fun create tooldata = 
    if isSome (!history_tool) then 
      Capi.to_front (valOf (!history_tool))
    else
      create_history tooldata

end;
