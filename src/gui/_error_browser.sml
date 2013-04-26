(*
 * Copyright (c) 1994 Harlequin Ltd.
 * $Log: _error_browser.sml,v $
 * Revision 1.29  1998/04/29 15:03:26  johnh
 * [Bug #50076]
 * Called the correct quit function so that EB is not destroyed twice.
 *
 * Revision 1.28  1998/03/31  15:15:06  johnh
 * [Bug #30346]
 * Call Capi.getNextWindowPos.
 *
 * Revision 1.27  1998/02/17  16:36:20  johnh
 * [Bug #30344]
 * Allow windows to retain size and position.
 *
 * Revision 1.26  1998/01/27  15:57:14  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.25  1997/10/30  09:49:55  johnh
 * [Bug #30296]
 * Add buttons for the three main actions.
 *
 * Revision 1.24  1997/09/24  10:48:18  johnh
 * [Bug #30231]
 * Put call to Capi.remove_main_window in quit functions.
 *
 * Revision 1.23.2.2  1997/11/20  17:04:44  johnh
 * [Bug #30071]
 * Remove Paths menu.
 *
 * Revision 1.23.2.1  1997/09/11  20:52:01  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.23  1997/06/12  16:41:53  johnh
 * [Bug #30175]
 * Combine tools and windows menu - goodbye windows menu.
 *
 * Revision 1.22  1997/05/16  15:35:40  johnh
 * Implementing single menu bar on Windows.
 *
 * Revision 1.21  1997/04/14  17:55:25  jont
 * [Bug #2049]
 * Make sure file location is used in error browser title where appropriate
 *
 * Revision 1.20  1996/12/03  20:52:44  daveb
 * Replaced the hacky mswindows simulation of unmap callbacks with a call
 * to Capi.set_close_callback.
 *
 * Revision 1.19  1996/11/06  11:15:52  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.18  1996/10/09  16:06:13  io
 * moving String from toplevel
 *
 * Revision 1.17  1996/07/05  14:24:04  daveb
 * [Bug #1260]
 * Changed the Capi layout datatype so that the PANED constructor takes the
 * layout info for its sub-panes.  This enables the Windows layout code to
 * calculate the minimum size of each window.
 *
 * Revision 1.16  1996/05/08  18:28:08  daveb
 * quit_fun can now be called more than once, so we have to make this safe.
 *
 * Revision 1.15  1996/05/08  14:40:33  daveb
 * Made create return a function that kills the browser.
 *
 * Revision 1.14  1996/05/07  11:40:04  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.13  1996/05/01  10:54:30  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.12  1996/04/30  10:02:17  matthew
 * Replacing MLWorks.Integer with basis file
 *
 * Revision 1.11  1996/02/23  11:34:09  daveb
 * Made the error_to_string function exportable.
 *
 * Revision 1.10  1996/02/22  16:58:50  daveb
 * Added close_action.
 *
 * Revision 1.9  1996/02/05  11:51:18  daveb
 * Capi.make_scrolllist now returns a record, with an add_items field.
 *
 * Revision 1.8  1996/01/25  14:44:21  daveb
 * Replaced title text widgets with labels.
 *
 * Revision 1.7  1996/01/22  12:11:39  daveb
 * Corrected title.
 *
 * Revision 1.6  1995/09/22  13:44:47  daveb
 * Changed edit_action parameter to return both a quit_fn and a clean_fn, with
 * each new call to edit_error calling the previous clean_fn.  (This is used
 * to remove highlighting in the evaluator).
 *
 * Revision 1.5  1995/09/11  15:25:19  matthew
 * Changing top level window initialization
 *
 * Revision 1.4  1995/08/30  13:23:36  matthew
 * Renaming layout constructors
 *
 * Revision 1.3  1995/08/10  12:19:27  matthew
 * Adding make_buttons function to capi
 *
 * Revision 1.2  1995/07/27  10:56:07  matthew
 * Moved capi etc. to gui
 *
 * Revision 1.1  1995/07/26  14:46:08  matthew
 * new unit
 * New unit
 *
 *  Revision 1.7  1995/07/07  15:24:46  daveb
 *  Minor changes to layout.
 *
 *  Revision 1.6  1995/07/04  13:58:15  matthew
 *  Capification
 *
 *  Revision 1.5  1995/05/25  17:40:26  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.4  1994/08/02  10:22:57  daveb
 *  Added sensitivity to edit button on actions menu.
 *
 *  Revision 1.3  1994/07/26  16:25:38  daveb
 *  Changed menu slightly.  Made first item be selected on startup.
 * 
 *  Revision 1.2  1994/05/20  11:55:44  daveb
 *  Revised interface.
 * 
 *  Revision 1.1  1994/05/13  15:55:04  daveb
 *  new file
 * 
 *)

require "../basis/__int";
require "../utils/lists";
require "capi";
require "menus";
require "../interpreter/shell_utils";
require "gui_utils";
require "tooldata";
require "error_browser";

functor ErrorBrowser(
  structure Lists : LISTS
  structure Capi : CAPI
  structure Menus : MENUS
  structure GuiUtils : GUI_UTILS
  structure ShellUtils : SHELL_UTILS
  structure ToolData : TOOL_DATA

  sharing type Capi.Widget = Menus.Widget = GuiUtils.Widget = ToolData.Widget
  sharing type Menus.ButtonSpec = GuiUtils.ButtonSpec = ToolData.ButtonSpec
  sharing type GuiUtils.user_tool_options = ShellUtils.UserOptions
               
) : ERROR_BROWSER =
  struct
    structure Info = ShellUtils.Info
    structure Location = Info.Location

    type Widget = Capi.Widget
    type Context = ShellUtils.Context
    type options = ShellUtils.Options.options
    type error = Info.error
    type location = Location.T
    type ToolData = ToolData.ToolData
    type user_context = ToolData.ShellTypes.user_context

    fun first_line message =
      let
        fun aux ([],acc) = acc
          | aux (#"\n" :: _,acc) = acc
          | aux (c::l,acc) = aux(l,c::acc)
      in
	 implode (rev (aux (explode message, [])))
      end
        
    fun location_line location =
      case location of
          Location.UNKNOWN => ""
        | Location.FILE s => ""
        | Location.LINE(_,l) => "Line " ^ Int.toString l
        | Location.POSITION (_,l,_) => "Line " ^ Int.toString l
        | Location.EXTENT {s_line,e_line,...} =>
            if s_line = e_line
              then "Line " ^ Int.toString s_line
            else "Line " ^ Int.toString s_line ^ " to " ^ Int.toString e_line
                
    fun error_location (Info.ERROR(_,location,message)) = location

    fun error_to_string (Info.ERROR(severity,location,message)) =
      (case location_line location of
         "" => "error: " ^ first_line message
        | l => l ^ ": error: " ^ first_line message)

    fun print_fn _ (Info.ERROR(severity,location,message)) =
      (case location_line location of
         "" => first_line message
        | l => l ^ ": " ^ first_line message)

    val posRef = ref NONE
    val sizeRef = ref NONE

    fun create
      {parent, errors, file_message, editable, edit_action, 
	redo_action, close_action, mk_tooldata, get_context} =
      let 
        val (shell,mainWindow,menuBar,_) =
          Capi.make_main_popup {name = "errorBrowser", 
				title = "Error Browser",
                                parent = parent, 
				contextLabel = false, 
				visibleRef = ref true,
				pos = getOpt (!posRef, Capi.getNextWindowPos())}

        val frame =
	  Capi.make_managed_widget
	    ("errorBrowserFrame", Capi.Paned, mainWindow, [Capi.PanedMargin true])

        val listPane = Capi.make_managed_widget ("listPane", Capi.Form, frame, [])

        val reason = Capi.make_managed_widget
	  ("errorBrowserTitle", Capi.Label, listPane, [])

        val textPane = Capi.make_managed_widget ("textPane", Capi.Form, frame, [])

        val textTitle = Capi.make_managed_widget
	      ("errorTextLabel", Capi.Label, textPane, [])

        val (textScroll,text) =
	  Capi.make_scrolled_text ("errorBrowserText", textPane, [])

        fun message_fun s = Capi.send_message (shell,s)

        val quit_funs = ref []
	  (* These are evaluated when the Close or Redo actions are selected *)

	val good_clean_fun = ref (fn () => ())
	  (* This is evaluated (and then updated) when the Edit action is selected. *)

        fun do_quit_funs _ = Lists.iterate (fn f => f ()) (!quit_funs)

        fun edit_error _ (Info.ERROR(_,location,_)) =
          let
	    val _ = (!good_clean_fun) ();
            val {quit_fn, clean_fn} = edit_action location
          in
            quit_funs := quit_fn :: (!quit_funs);
	    good_clean_fun := clean_fn
          end
        handle ShellUtils.EditFailed s =>
          message_fun ("Edit failed: " ^ s)

        fun show_full_message _ (Info.ERROR(_,_,message)) =
          Capi.Text.set_string(text,message)

        val {scroll,list,set_items,...} =
	  Capi.make_scrolllist
	    {parent = listPane, name = "errorBrowser",
	     select_fn = show_full_message,
             action_fn = edit_error,
             print_fn = print_fn}

        fun edit_fun _ =
          let
            val selected_items = Capi.List.get_selected_pos list
          in
            case MLWorks.Internal.Vector.length selected_items of
               0 => message_fun "No item selected"
             | 1 =>
                 let val index = MLWorks.Internal.Vector.sub(selected_items,0)
                 in
                   edit_error (scroll,list,set_items) 
				(Lists.nth (index-1,errors))
                 end
             | _ => message_fun "Multiple selections"
          end

	fun can_edit _ =
	  let
            val selected_items = Capi.List.get_selected_pos list
          in
	    if MLWorks.Internal.Vector.length selected_items = 1 then
	      let
		val index = MLWorks.Internal.Vector.sub(selected_items,0)
	      in
		case Lists.nth (index-1,errors) of
		   Info.ERROR(_,location,_) => editable location
	      end
	    else
	      false
          end

	local
	  val destroyed = ref false
	in
	  fun quit_fun _ =
	    if not (!destroyed) then
              (* Widget should be reused *)
              (* Though we would like to have more than one at once *)
	      ((!good_clean_fun) ();
	       do_quit_funs();
	       destroyed := true;
	       Capi.remove_main_window shell;
	       Capi.destroy shell)
	     else ()
	end

	fun redo_fun _ =
	  (quit_fun ();
	   redo_action ())

	fun close_fun _ =
	  (quit_fun ();
	   close_action ())

	fun storeSizePos () = 
	  (sizeRef := SOME (Capi.widget_size shell);
	   posRef := SOME (Capi.widget_pos shell))

	val buttonPane =
	  Capi.make_managed_widget ("buttonPane", Capi.RowColumn, textPane, []);

	val _ = 
	  Menus.make_buttons
	    (buttonPane,
	     [Menus.PUSH ("repeatButton", redo_fun, fn _ => true),
	      Menus.PUSH ("editSourceButton", edit_fun, can_edit),
	      Menus.PUSH ("closeButton", close_fun, fn _ => true)])

        val menuspec =
          [ToolData.file_menu [("close", close_fun, fn _ => true)],
           ToolData.edit_menu
           (shell,
            {cut = NONE,
             paste = NONE,
	     copy = SOME (fn _ => Capi.clipboard_set (text,Capi.Text.get_selection text)),
             delete = NONE,
             selection_made = fn _ => Capi.Text.get_selection text <> "",
	     edit_possible = fn _ => false,
	     delete_all = NONE,
	     edit_source = [Menus.PUSH ("editSource", edit_fun, can_edit)] }),
	   ToolData.tools_menu (mk_tooldata, get_context),
	   ToolData.usage_menu ([("repeat", redo_fun, fn _ => true)], []),
	   ToolData.debug_menu []]

	val textPaneLayout =
	  (textPane,
	   [Capi.Layout.FIXED textTitle,
	    Capi.Layout.FLEX textScroll,
	    Capi.Layout.SPACE,
	    Capi.Layout.FIXED buttonPane]);
	    
	val listPaneLayout =
	  (listPane,
           [Capi.Layout.FIXED reason,
	    Capi.Layout.FLEX scroll]);
      in
        quit_funs := Menus.quit :: (!quit_funs);
        quit_funs := storeSizePos :: (!quit_funs);
	quit_funs := (fn _ => Capi.remove_main_window shell) :: (!quit_funs);
        Capi.Layout.lay_out
          (mainWindow, !sizeRef,
           [Capi.Layout.MENUBAR menuBar,
            Capi.Layout.PANED (frame, [textPaneLayout, listPaneLayout]),
            Capi.Layout.SPACE]);
            (* Note the destroy method is added to the parent of the popup shell *)
        Menus.make_submenus(menuBar,menuspec);
        Capi.Callback.add (mainWindow, Capi.Callback.Unmap, quit_fun);
        Capi.set_close_callback (mainWindow, close_fun);
        Capi.Callback.add (Capi.parent shell, Capi.Callback.Destroy, quit_fun);
        set_items ShellUtils.Options.default_print_options errors;
        Capi.set_label_string (reason, "Location: " ^ file_message);
        Capi.reveal mainWindow;
	Capi.List.select_pos (list, 1, false);
        show_full_message (scroll,list,set_items) (Lists.nth (0,errors));
	quit_fun
      end

  end;
