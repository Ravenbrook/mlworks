(*  Copyright (c) 1993 Harlequin Ltd.
 *
 *  $Log: _debugger_window.sml,v $
 *  Revision 1.57  1998/03/31 16:02:16  johnh
 *  [Bug #30346]
 *  Call Capi.getNextWindowPos.
 *
 * Revision 1.56  1998/02/18  11:42:34  johnh
 * [Bug #30344]
 * Allow windows to retain size and position.
 *
 * Revision 1.55  1998/02/10  15:34:47  jont
 * [Bug #70065]
 * Remove uses of MLWorks.IO.messages and use the Messages structure
 *
 * Revision 1.54  1998/01/27  15:56:02  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.53  1997/10/09  11:02:20  johnh
 * [Bug #30193]
 * Output backtrace to system messages window.
 *
 * Revision 1.52.2.2  1997/11/20  17:05:02  johnh
 * [Bug #30071]
 * Remove Paths menu.
 *
 * Revision 1.52.2.1  1997/09/11  20:52:22  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.52  1997/08/04  13:26:02  johnh
 * [Bug #30111]
 * Silently fail view source when source not available, except for explicit action.
 *
 * Revision 1.51  1997/06/13  10:52:23  johnh
 * [Bug #30175]
 * Combine tools and windows menus .
 *
 * Revision 1.50  1997/05/16  15:35:29  johnh
 * Implementing single menu bar on Windows.
 * Re-organising menus for Motif.
 *
 * Revision 1.49  1997/05/06  09:25:19  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.48  1997/02/26  15:08:24  johnh
 * [Bug #1421]
 * update the variable window when settings are changed.
 *
 * Revision 1.47  1996/12/19  12:15:47  jont
 * [Bug #1825]
 * Remove use of old structure
 *
 * Revision 1.46  1996/12/03  20:55:24  daveb
 * Replaced the hacky mswindows simulation of unmap callbacks with a call
 * to Capi.set_close_callback.
 *
 * Revision 1.45  1996/10/09  11:53:19  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.44  1996/08/09  15:25:15  nickb
 * Option dialog setter functions now return accept/reject.
 *
 * Revision 1.43  1996/08/07  11:22:52  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_types.sml
 *
 * Revision 1.42  1996/07/29  09:35:03  daveb
 * [Bug #1478]
 * Added Unmap callback.  Corrected definition of editable frames to excluse
 * C frames and Setup frames.  Added quit_fn that reset viewer_fn_ref.
 *
 * Revision 1.41  1996/07/05  14:23:11  daveb
 * [Bug #1260]
 * Changed the Capi layout datatype so that the PANED constructor takes the
 * layout info for its sub-panes.  This enables the Windows layout code to
 * calculate the minimum size of each window.
 *
 * Revision 1.40  1996/06/25  09:54:11  daveb
 * Made button buttons have different names from menu buttons, so that
 * Windows can distinguish between them, and so let us put mnemonics on
 * the menu items but not the buttons.
 *
 * Revision 1.39  1996/06/19  12:10:16  stephenb
 * Fix #1423 - duplicate anonymous frames not hidden correctly.
 *
 * Revision 1.38  1996/06/18  12:48:42  stephenb
 * Add a handler for FilewViewer.ViewFailed to show_fn so that something
 * sensible is done if the file cannot be viewed.  This is part of a fix
 * for #1413.
 *
 * Revision 1.37  1996/05/29  16:00:47  daveb
 * make_debugger_window now returns a pair of functions.  The second of these
 * is to be run at the end of the evaluation, and clears the windows, etc.
 * This reduces flicker (Bug 1065), and stops the debugger from always popping
 * to the top.
 *
 * Revision 1.35  1996/05/23  16:58:42  daveb
 * Changed interface to file viewer.
 * Added button to pop file viewer back up if it has been closed.
 *
 * Revision 1.34  1996/05/14  14:28:25  matthew
 * Fixing layout
 *
 * Revision 1.33  1996/05/07  11:37:54  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.32  1996/05/01  10:53:22  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.31  1996/04/23  13:27:30  daveb
 * Added FileViewer.
 *
 * Revision 1.30  1996/03/15  16:17:56  stephenb
 * Remove some redundant Trace.set_stepping calls now that the
 * Trace module takes care of keeping all this stuff internally
 * consistent.
 *
 * Revision 1.29  1996/03/05  14:27:14  stephenb
 * Fix the frame filtering mechanism so that it doesn't drop
 * the top frame if it is a delivered frame.
 *
 * Revision 1.28  1996/02/29  11:18:47  stephenb
 * Modify the tty->gui interface so that the gui debugger knows
 * which frame to apply Trace.next to.
 * Rewrote the frame filtering so that it correctly hides frames that
 * result from the new step/next/break mechanism.
 * Added a "next" button and "next" menu item to the action menu and
 * hooked them up so that the call Trace.next.
 *
 * Revision 1.27  1996/02/26  16:00:16  stephenb
 * Unify control of hiding and revealing frames in the tty&gui debuggers.
 *
 * Revision 1.26  1996/02/19  17:11:06  daveb
 * Made select_fn for local variables call the inspect_fn with auto = true.
 *
 * Revision 1.25  1996/02/19  10:47:51  stephenb
 * Updated wrt to Trace.step_status -> Trace.stepping name change.
 *
 * Revision 1.24  1996/02/05  11:48:09  daveb
 * Capi.make_scrolllist now returns a record, with an add_items field.
 *
 * Revision 1.23  1996/01/26  09:36:30  daveb
 * Revised layout.
 *
 * Revision 1.22  1996/01/24  15:39:21  matthew
 * Make inspector window sibling of debugger window
 *
 * Revision 1.21  1996/01/19  11:00:42  matthew
 * Changing interface to inspector
 *
 * Revision 1.20  1996/01/16  15:04:37  matthew
 * Changes to what is done with full_menus
 *
 * Revision 1.19  1995/11/22  15:58:17  jont
 * Fix bug 1079
 * Done by as part of abort_action, as well as continue_action and step_action
 *
 * Revision 1.18  1995/11/21  16:44:48  jont
 * Modify to display local variable info on full menus
 *
 * Revision 1.17  1995/11/16  13:14:39  matthew
 * Changing button resources
 *
 * Revision 1.16  1995/11/14  16:50:09  jont
 * Some tidying up and a little documentation added
 * This should make it easier for the next person to look at this stuff
 *
 * Revision 1.15  1995/11/06  16:39:18  jont
 * Remove duplication of function information in debugger frame window
 *
 * Revision 1.14  1995/10/26  10:18:27  nickb
 * Hide some additional frames.
 *
 * Revision 1.13  1995/10/24  16:05:17  daveb
 * Moved call of set_active_buttons to after popup, so that focus is set
 * correctly.
 *
 * Revision 1.11  1995/10/20  10:51:19  daveb
 * Renamed ShellUtils.edit_string to ShellUtils.edit_source
 * (and ShellUtils.edit_source to ShellUtils.edit_location).
 *
 * Revision 1.10  1995/10/04  09:09:08  daveb
 * Changed run_debugger to select the appropriate button for default action.
 *
 * Revision 1.9  1995/10/03  15:18:55  daveb
 * Made debugger show source of current frame in emacs, when possible.
 * This is a stop-gap implementation - we need a source browser for non-emacs
 * users.
 *
 * Revision 1.8  1995/09/05  10:27:13  matthew
 * Fixing some problems with running under Win32
 *
 * Revision 1.7  1995/08/30  13:23:35  matthew
 * Renaming layout constructors
 *
 * Revision 1.6  1995/08/25  14:17:56  matthew
 * Fixing problem with empty frame list
 *
 * Revision 1.5  1995/08/24  16:26:40  matthew
 * Bring window to front when entered.
 *
 * Revision 1.4  1995/08/15  10:31:11  matthew
 * Using Menus.make_buttons for buttons
 *
 * Revision 1.3  1995/08/10  12:18:03  matthew
 * Adding make_buttons function to capi
 *
 * Revision 1.2  1995/07/27  10:56:02  matthew
 * Moved capi etc. to gui
 *
 * Revision 1.1  1995/07/26  14:42:57  matthew
 * new unit
 * New unit
 *
 *  Revision 1.46  1995/07/07  14:58:28  daveb
 *  Minor changes to layout.
 *
 *  Revision 1.45  1995/07/04  14:31:13  matthew
 *  Capification
 *
 *  Revision 1.44  1995/06/28  13:07:36  daveb
 *  Made edit action disabled for functions defined in the listener.
 *
 *  Revision 1.43  1995/06/15  15:01:21  daveb
 *  Hid details of WINDOWING type in ml_debugger.
 *  Removed edit function from parameters of run_debugger, and hardwired it
 *  in this file.
 *
 *  Revision 1.42  1995/06/08  13:44:11  daveb
 *  InspectorTool no longer contains a Widget Type.
 *
 *  Revision 1.41  1995/06/08  09:45:42  daveb
 *  Types of the InspectorTool functions have changed.  Also corrected
 *  spelling of InspectorTool (from Inspector_Tool).
 *
 *  Revision 1.40  1995/06/01  13:28:58  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.39  1995/05/26  15:52:17  matthew
 *  Changing uses of substring
 *
 *  Revision 1.38  1995/05/22  15:20:50  daveb
 *  Made breakpoints menu visible to novices.
 *
 *  Revision 1.37  1995/04/27  11:09:11  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.36  1995/04/24  15:06:26  matthew
 *  Cosmetic debugger changes
 *
 *  Revision 1.35  1995/04/24  11:04:58  daveb
 *  Added call to Xm.ungrabPointer to event-handling subloop.
 *
 *  Revision 1.34  1995/04/19  14:41:36  matthew
 *  Added extra buttons for abort etc.
 *  First version of new stepping functionality
 *
 *  Revision 1.33  1995/04/13  17:10:43  daveb
 *  Xm.doInput is back to taking unit.
 *
 *  Revision 1.32  1995/04/06  15:31:12  daveb
 *  Type of Xm.doInput has changed.
 *
 *  Revision 1.31  1995/01/13  15:38:20  daveb
 *  Replaced Option structure with references to MLWorks.Option.
 *
 *  Revision 1.30  1994/07/27  16:12:07  daveb
 *  Cut-down menus for novices.
 *
 *  Revision 1.29  1994/07/12  16:17:02  daveb
 *  Changes to reflect minor changes in inspector_tool.
 *
 *  Revision 1.28  1994/04/06  15:30:13  daveb
 *  Disabled stepper and breakpoint actions when appropriate, and removed
 *  irrelevant entries ffrom inspect submenu.  Moved breakpoint menu into
 *  GUI_UTILS, and into the menu bar.  Simplified stepper interface.
 *
 *  Revision 1.27  1994/03/15  14:11:43  matthew
 *  Changed resource names
 *
 *  Revision 1.26  1994/02/28  08:55:55  nosa
 *  Menus for Step and breakpoints Debugger.
 *
 *  Revision 1.25  1993/12/10  16:52:08  daveb
 *  Added exists_frame_info to disable frames menu entry when no frame info
 *  exists.
 *
 *  Revision 1.24  1993/12/10  10:32:11  daveb
 *  Added copyright notice.
 *
 *  Revision 1.23  1993/09/09  09:34:01  nosa
 *  Restricted strings in inspect frame info menu to 80 characters;
 *  Hiding instance-frames for polymorphic debugger.
 *
 *  Revision 1.22  1993/08/28  17:59:07  daveb
 *  Changed Options menu to Settings menu, to avoid confusion.
 *
 *  Revision 1.21  1993/08/24  16:31:36  matthew
 *  Improved label names etc.
 *
 *  Revision 1.20  1993/08/11  12:02:19  matthew
 *  create_dialog interface change
 *
 *  Revision 1.19  1993/08/09  16:57:34  nosa
 *  Inspector now invoked for values of local and closure variables;
 *  new action "InspectFrameInfo".
 *
 *  Revision 1.18  1993/08/05  11:01:30  nosa
 *  New option ShowFrameInfo in debugger window.
 *
 *  Revision 1.17  1993/08/03  11:13:16  matthew
 *  Combined frame and action menus. Renamed quit to abort
 *
 *  Revision 1.16  1993/07/28  15:54:56  nosa
 *  Reversed logic for frame filters.
 *  More user-friendly labels.
 *
 *  Revision 1.15  1993/05/20  11:43:46  matthew
 *  Fixed bug with item selection
 *
 *  Revision 1.14  1993/05/13  18:22:13  daveb
 *  Renamed file menu to action menu.
 *
 *  Revision 1.13  1993/05/13  15:26:03  daveb
 *  create_dialog now requires a title argument.
 *
 *  Revision 1.12  1993/05/12  14:43:35  matthew
 *  Added message function to debugger window
 *
 *  Revision 1.11  1993/05/10  10:42:52  matthew
 *  Change to termination protocol
 *
 *  Revision 1.10  1993/05/07  17:10:14  matthew
 *  Added Quit and Continue buttons
 *  Enter event handling loop before exitting.
 *
 *  Revision 1.9  1993/05/05  19:30:54  daveb
 *  Gave sensible names to the shell and form widgets.
 *
 *  Revision 1.8  1993/04/30  14:24:22  matthew
 *  Added menubar, frame suppression, editor interface
 *
 *  Revision 1.7  1993/04/28  10:24:16  daveb
 *  Changes to make_scrolllist.
 *
 *  Revision 1.6  1993/04/26  13:50:16  daveb
 *  Now uses GuiUtils.make_scrolllist.
 *
 *  Revision 1.5  1993/04/19  09:46:25  matthew
 *  Used Xm callback conversion function.
 *
 *  Revision 1.4  1993/04/05  14:55:08  daveb
 *  Names of Callbacks have changed.
 *
 *  Revision 1.3  1993/03/30  14:46:56  matthew
 *  Removed MENUSPEC data constructor
 *
 *  Revision 1.2  1993/03/26  18:27:32  matthew
 *  Changed widget names
 *
 *  Revision 1.1  1993/03/25  17:07:11  matthew
 *  Initial revision
 *
 *
 *)

require "capi";
require "menus";
require "../utils/lists";
require "^.utils.__messages";
require "../main/preferences";
require "../debugger/newtrace";
require "../debugger/ml_debugger";
require "../typechecker/types";
require "tooldata";
require "inspector_tool";
require "gui_utils";
require "file_viewer";
require "../interpreter/shell_utils";
require "../debugger/stack_frame";
require "debugger_window";
require "../main/user_options";
require "^.basis.__string";

functor DebuggerWindow(
  structure Capi : CAPI
  structure Lists : LISTS
  structure Trace : TRACE
  structure InspectorTool : INSPECTORTOOL
  structure FileViewer : FILE_VIEWER
  structure UserOptions : USER_OPTIONS
  structure Types : TYPES
  structure Menus : MENUS
  structure GuiUtils: GUI_UTILS
  structure ShellUtils: SHELL_UTILS
  structure ToolData: TOOL_DATA
  structure Preferences: PREFERENCES
  structure StackFrame : STACK_FRAME
  structure Ml_Debugger : ML_DEBUGGER

  sharing UserOptions.Options = ToolData.ShellTypes.Options =
    ShellUtils.Options = Types.Options

  (* The only function from Types used here is printTypes.  Perhaps that
     should be (or is, for all I know) available elsewhere? *)
  sharing type Types.Datatypes.Type = InspectorTool.Type
  sharing type Types.Options.print_options = ShellUtils.Options.print_options
  sharing type Menus.Widget = GuiUtils.Widget = ToolData.Widget = Capi.Widget =
               InspectorTool.Widget = FileViewer.Widget
  sharing type Menus.ButtonSpec = GuiUtils.ButtonSpec = ToolData.ButtonSpec
  sharing type ToolData.ToolData = InspectorTool.ToolData = FileViewer.ToolData
  sharing type ToolData.ShellTypes.user_preferences =
               Preferences.user_preferences
  sharing type ShellUtils.preferences = Preferences.preferences
  sharing type FileViewer.Location.T = ShellUtils.Info.Location.T
  sharing type GuiUtils.MotifContext = ToolData.MotifContext
  sharing type UserOptions.user_tool_options = ToolData.ShellTypes.user_options
  sharing type GuiUtils.user_context = ToolData.UserContext.user_context
  sharing type UserOptions.user_context_options = ToolData.UserContext.user_context_options
) : DEBUGGERWINDOW =
  struct
    structure Options = ShellUtils.Options
    structure UserContext = ToolData.UserContext

    type Widget = Capi.Widget
    type ToolData = InspectorTool.ToolData
    type Type = InspectorTool.Type

    local
      type part_of_a_frame =
        (string
         * (Type * MLWorks.Internal.Value.ml_value * string)
         ) list

      type frame_details =
        string
        * string
        * (Type * MLWorks.Internal.Value.ml_value * string)
        * (unit -> string * part_of_a_frame,
           string * part_of_a_frame)
          Ml_Debugger.union ref option

      type frame =
        {name : string, loc : string, details: frame_details}
    in
      datatype Frame =
        FRAME of frame

      (* This type must be the same as that in _ml_debugger. *)
      type debugger_window =
        {parameter_details: string,
         frames: frame list,
         quit_fn: (unit -> unit) option,
         continue_fn: (unit -> unit) option,
         top_ml_user_frame: MLWorks.Internal.Value.Frame.frame option}
        -> unit
    end

    fun make_debugger_window (parent,title,tooldata) =
      let
        val ToolData.TOOLDATA
              {args as ToolData.ShellTypes.LISTENER_ARGS
                        {user_preferences as Preferences.USER_PREFERENCES
                                          ({full_menus, ...}, _),
                         user_options,user_context,prompter,mk_xinterface_fn,...},
               appdata as ToolData.APPLICATIONDATA {applicationShell, ...},
               current_context, motif_context, tools, ...} =
          tooldata

        fun get_user_context_options () =
	  UserContext.get_user_options
	    (GuiUtils.get_user_context (motif_context))

        fun get_compiler_options () =
          UserOptions.new_options (user_options, get_user_context_options())

        val title = "Stack Browser"

        (* Some state variables *)

        val show_debug_info = ref true
        val show_variable_debug_info = ref(true)

	val visible = ref false

        val (shell,form,menuBar,_) =
          Capi.make_main_popup 
		{name = "debugger",
		 title = title, 
		 parent = parent,
		 contextLabel = false, 
		 visibleRef = visible,
		 pos = Capi.getNextWindowPos()}

        (* Controls local event handling loop *)
        val continue = ref true

        fun popup () =
          (Capi.reveal form;
           Capi.to_front shell;
	   Capi.add_main_window (shell, title);
	   visible := true)

        fun popdown () =
	  (Capi.hide form;
	   visible := false)

        val buttonPane =
          Capi.make_managed_widget ("buttonPane", Capi.RowColumn, form, [])

        val text = Capi.make_managed_widget
                     ("debuggerText", Capi.Text, form,[])

        val debuggerFrame =
          Capi.make_managed_widget
            ("debuggerFrame", Capi.Paned, form, [Capi.PanedMargin true])

        val varPane =
          Capi.make_managed_widget ("varPane", Capi.Form, debuggerFrame, []);

        val argsLabel =
          Capi.make_managed_widget
            ("debuggerArgsLabel", Capi.Label, varPane, [])

        val argsText =
          Capi.make_managed_widget
            ("debuggerArgsText", Capi.Text, varPane, [])

        val framePane =
          Capi.make_managed_widget ("framePane", Capi.Form, debuggerFrame, []);

        val framesLabel =
          Capi.make_managed_widget
            ("debuggerFramesLabel", Capi.Label, framePane, [])

	val quit_fns = ref [fn () => Capi.remove_main_window shell];

        fun do_quit_fns () = Lists.iterate (fn f => f ()) (!quit_fns)
	
	local
	  val viewer_fn_ref = ref NONE
	in
	  fun viewer_fn auto location =
	    case !viewer_fn_ref
	    of SOME f =>
	      f auto (FileViewer.LOCATION location)
	    |  NONE =>
	      let
		val the_fn = FileViewer.create (parent, true, tooldata)
	      in
		viewer_fn_ref := SOME (the_fn);
		quit_fns :=
		  (fn _ => viewer_fn_ref := NONE) :: !quit_fns;
		the_fn false (FileViewer.LOCATION location)
	      end
	end

        val frames_ref = ref [] : Frame list ref
        val displayed_frames = ref [] : Frame list ref
        val present_name = ref "";

        val logical_top_frame : MLWorks.Internal.Value.Frame.frame option ref =
          ref NONE

        val present_frame_info : (InspectorTool.Type * MLWorks.Internal.Value.ml_value
                                       * string) option ref =
          ref NONE

        val present_variable_frame_info :
          (unit -> string * ((string * (InspectorTool.Type * MLWorks.Internal.Value.ml_value
                                       * string)) list),
           string * ((string * (InspectorTool.Type * MLWorks.Internal.Value.ml_value
                               * string)) list)) Ml_Debugger.union ref ref =
          ref(ref(Ml_Debugger.INR("",[])))

        (* The inspector can't be a child of the debugger itself *)
        val inspect_fn = InspectorTool.inspect_value (parent,true,tooldata)

        fun fetch_frame_info (info' as ref(Ml_Debugger.INL info_fn)) =
          let val info as (_,info'') = info_fn ()
          in
            info' := Ml_Debugger.INR info;
            info''
          end
        |   fetch_frame_info (ref(Ml_Debugger.INR(_,info))) = info

        fun exists_frame_info () =
          case (!present_frame_info,
                fetch_frame_info (!present_variable_frame_info))
          of (NONE, []) => false
          |  _ => true

	fun print_frames [] = 
	      Capi.send_message (shell, "See System Messages window for backtrace")
	  | print_frames (frame1::rest) = 
	      let 
		val FRAME {details, ...} = frame1
		val (name, _, (_, _, info), _) = details
	      in
		Messages.output(name ^ info ^ "\n");
		print_frames rest
	      end

        val max_length = 80
        fun strip str =
          if size str <= max_length then str
          else substring (* could raise Substring *)(str,0,max_length-3) ^ "..."

        val current_var = ref NONE

        fun exists_current_var () =
          case !current_var
          of NONE => false
          |  _ => true

        fun inspect_current_var () =
          case !current_var
          of NONE => ()
          |  SOME (var,(ty,value,valuestr)) =>
            inspect_fn false (var,(value,ty))

        val {scroll = varsScroll, list = varsList,
             set_items = set_var_items, ...} =
          Capi.make_scrolllist
            {parent = varPane,
             name = "debuggerVars",
             select_fn = fn _ =>
               fn x as (var,(ty,value,valuestr)) =>
                 (current_var := SOME x;
                  inspect_fn true (var,(value,ty))),
             action_fn = fn _ =>
               fn (var,(ty,value,valuestr)) =>
                 inspect_fn false (var,(value,ty)),
             print_fn = fn _ =>
               (* This is what prints the args in the middle window *)
               fn (var,(ty,value,valuestr)) =>
                 "val " ^ var
                 ^ ": " ^ Types.print_type (get_compiler_options()) ty ^
                 " = " ^ strip valuestr}

	fun is_editable ("<Cframe>", _) = false
	|   is_editable ("<Setup>", _) = false
	|   is_editable (_, location) = ShellUtils.editable location

	(* show_fn shows the source for the current frame in the editor,
	   or the file viewer if the editor doesn't support incremental
	   update.  It is used for displaying the current source while
	   stepping. *)
        fun show_fn (auto, name, loc) =
	  let
	    val location = ShellUtils.Info.Location.from_string loc
	  in
	    if is_editable (name, location) then
              (ShellUtils.show_source
                 (loc, Preferences.new_preferences user_preferences))
               handle ShellUtils.EditFailed s =>
	         (viewer_fn auto location
                   handle FileViewer.ViewFailed filename =>
                     if not auto then
		       Capi.send_message (shell, "Cannot view: " ^ filename)
	             else ())
	    else
	      ()
	  end

	(* edit_fn shows source for the current frame in the editor,
	   whether it supports incremental update or not.  It is
	   used for the edit menu command. *)
        fun edit_fn (name, loc) =
	  let
	    val location = ShellUtils.Info.Location.from_string loc
	  in
            if is_editable (name, location) then
              let
		val quit_fn =
		  ShellUtils.edit_source
                    (loc, Preferences.new_preferences user_preferences)
	      in
		quit_fns := quit_fn :: !quit_fns
	      end
              handle ShellUtils.EditFailed s =>
                Capi.send_message (shell, "Edit failed: " ^ s)
	    else
              Capi.send_message (shell, "Can't edit: " ^ loc)
	  end

        (* This prints stuff in the middle window *)
        fun show_vars NONE = ()
        |   show_vars (SOME info') =
          (present_variable_frame_info := info';
           if !show_variable_debug_info then
             case !present_frame_info of
               NONE =>
                 set_var_items
                   Options.default_print_options
                   (fetch_frame_info(!present_variable_frame_info))
             | SOME x =>
                 set_var_items
                   Options.default_print_options
                   (("frame argument", x)
                    :: fetch_frame_info (!present_variable_frame_info))
           else
	     set_var_items Options.default_print_options [])

        fun frame_select_fn _ frame =
          let val FRAME
                    {name, loc, details = (a,b,(ty,value,valuestr),info'),...} =
                frame
          in
            (case valuestr of
               "" => ()
             | "_" => ()
             | _ => present_frame_info := SOME(ty,value,valuestr));
             present_name := name;
             Capi.Text.set_string (argsText, b);
             show_vars info';
	     show_fn (true, name, loc)
          end

        val {scroll=framesScroll, list=framesList,
             set_items=set_frame_items, ...} =
          Capi.make_scrolllist
            {parent = framePane,
             name = "debuggerFrames",
             select_fn = frame_select_fn,
             action_fn = fn _ => fn FRAME{name, loc, ...} =>
	       (show_fn (false, name, loc); 
		Capi.set_focus shell),
             print_fn =
             fn _ =>
             fn FRAME {details = (a,_,(_,_,info),_),...} =>
             a ^ (if !show_debug_info then info else "")
             (* This is what prints the args in the lower window *)}

	fun getter r () = !r
	fun setter r b = (r := b; true)
	fun toggle (s,r) = Menus.OPTTOGGLE(s,getter r, setter r)

        val settings_spec =
	  toggle ("hideAnonymousFrames", StackFrame.hide_anonymous_frames)
          :: toggle ("hideHandlerFrames", StackFrame.hide_handler_frames)
          :: (if !full_menus then
                [toggle ("hideSetupFrames", StackFrame.hide_setup_frames),
		 toggle ("hideCFrames", StackFrame.hide_c_frames),
                 toggle ("hideDeliveredFrames",
			 StackFrame.hide_delivered_frames),
		 toggle ("hideDuplicateFrames",
			 StackFrame.hide_duplicate_frames)]
              else
                nil)



        (* The following is a variant of classify_frames in
         * ../debugger/_ml_debugger.sml.  The differences are due to :-
         *
         * 1. The gui and tty debuggers work on different types of frame
         *    This is something that should definitely be change in
         *    a future version!
         *
         * 2. The tty debugger keeps the user's current position in
         *    the stack.  As a consequence all the frames are classifed
         *    first since it is easier to do this in one go rather
         *    than on the fly as the user moves through the stack.
         *    The gui debugger doesn't need to keep the user's position
         *    since the user is presented with stack and they can point
         *    at any frame they want.  Consequently each time the hide/reveal
         *    status of a frame type is changed, the list of visible
         *    frames is recalculated.
         *
         * 3. As a consequence of 2., it is more difficult to determine
         *    if a frame is a duplicate or not.
         *)

        local
          fun classify "<Cframe>" (cframe, _, _, _, _) = cframe ()
            | classify "<Setup>"  (_, setup, _, _, _) = setup ()
            | classify "<anon>"   (_, _, anon, _, _) = anon ()
            | classify "<handle>" (_, _, _, handler, _) = handler ()
            | classify    _       (_, _, _, _, user) = user ()

          fun user_frame loc = size loc > 0 andalso String.sub (loc, 0) <> #" "

        in
          fun filter ([], acc, _) = acc
            | filter ((f as FRAME{name,loc,...})::rest, acc, previousDelivered) =
                let
                  fun keep_it () = filter (rest, f::acc, false)
                  fun skip_it () = filter (rest, acc, false)
                  fun loop var = if var then skip_it () else keep_it ()
                  fun cframe () =    loop (!StackFrame.hide_c_frames)
                  fun setup () =     loop (!StackFrame.hide_setup_frames)
                  fun anon () =      loop (!StackFrame.hide_anonymous_frames orelse (previousDelivered andalso (!StackFrame.hide_duplicate_frames)))
                  fun handler () =   loop (!StackFrame.hide_handler_frames)
                  fun delivered () = loop (!StackFrame.hide_delivered_frames)
                  fun user () =
                    if user_frame loc then
                      loop (previousDelivered andalso (!StackFrame.hide_duplicate_frames))
                    else
                      if (!StackFrame.hide_delivered_frames)
                      then filter (rest, acc, true)
                      else filter (rest, f::acc, true)
                in
                  classify name (cframe, setup, anon, handler, user)
                end


          fun filter_frames frames = filter (rev frames, [], false)

        end



        val info_settings_spec =
          [toggle ("showDebugInfo",show_debug_info),
           toggle ("showVariableDebugInfo", show_variable_debug_info)]

        fun update_items () =
          let
            val frame_list = filter_frames (!frames_ref)
          in
            displayed_frames := frame_list;
	    show_vars (SOME (!present_variable_frame_info));
            set_frame_items Options.default_print_options frame_list
          end

        fun clear_window () =
          (frames_ref := [];
           update_items ();
           set_var_items
             Options.default_print_options
             [];
           Capi.Text.set_string(text,"");
           Capi.Text.set_string(argsText,""))

        fun item_selected _ =
          MLWorks.Internal.Vector.length (Capi.List.get_selected_pos framesList) = 1

        fun show_callback _ =
          let
            val pos = Capi.List.get_selected_pos framesList
          in
            if MLWorks.Internal.Vector.length pos = 1
              then
                let
                  val index = MLWorks.Internal.Vector.sub (pos,0)
                  val FRAME{name, loc, ...} =
		    Lists.nth (index-1,!displayed_frames)
                in
                  show_fn (false, name, loc)
                end
                handle Lists.Nth => ()
            else ()
          end

        fun edit_callback _ =
          let
            val pos = Capi.List.get_selected_pos framesList
          in
            if MLWorks.Internal.Vector.length pos = 1
              then
                let
                  val index = MLWorks.Internal.Vector.sub (pos,0)
                  val FRAME{name, loc, ...} =
		    Lists.nth (index-1,!displayed_frames)
                in
                  edit_fn (name, loc)
                end
                handle Lists.Nth => ()
            else ()
          end

        fun can_edit _ =
          let
            val pos = Capi.List.get_selected_pos framesList
          in
            if MLWorks.Internal.Vector.length pos = 1
              then
                let
                  val index = MLWorks.Internal.Vector.sub (pos,0)
                  val FRAME{name, loc,...} =
		    Lists.nth (index-1,!displayed_frames)
                  val location = ShellUtils.Info.Location.from_string loc
                in
		  is_editable (name, location)
                end
                handle Lists.Nth =>
                  false
            else
              false
          end

        val settings_popup =
          #1 (Menus.create_dialog (shell,
                                   "Debugger Settings",
                                   "debuggerDialog",
                                   update_items,
                                   settings_spec))
        val info_settings_popup =
          #1(Menus.create_dialog (shell,
                                  "Debugger Settings",
                                  "debuggerDialog",
                                  update_items,
                                  info_settings_spec))

        val quit_fn_ref = ref NONE
        val continue_fn_ref = ref NONE

        fun present (ref NONE) = false
        |   present (ref (SOME _)) = true

        fun abort_present _ = present quit_fn_ref
        fun continue_present _ = present continue_fn_ref
        fun next_present _ = present continue_fn_ref andalso
                             present logical_top_frame

        fun abort_action _ =
	  (do_quit_fns ();
           case !quit_fn_ref of
             NONE => ()
           | SOME f =>
               (continue := false;
                clear_window ();
                popdown();
                f ()))

	(* unmap_action is assigned to the Unmap callback.   It is similar to
	   abort_action, but doesn't hide the window because the window
	   manager will already do that. *)
        fun unmap_action _ =
	  (do_quit_fns ();
	   clear_window ();
	   visible := false;
	   continue := false;
           case !quit_fn_ref of
             NONE => ()
           | SOME f => f ())

        val set_active_buttons = ref (fn () => ())

        fun continue_action _ =
          case !continue_fn_ref of
            NONE => ()
          | SOME f =>
              (continue_fn_ref := NONE;
               continue := false;
	       (*
               (!set_active_buttons) ();
               clear_window ();
	       *)
               f ())

        fun step_action _ =
          case !continue_fn_ref of
            NONE => ()
          | SOME f =>
              (Trace.set_stepping true;
               continue_fn_ref := NONE;
               continue := false;
	       (*
               (!set_active_buttons) ();
               clear_window ();
	       *)
               f ())

        fun next_action _ =
          case !continue_fn_ref of
            NONE => ()
          | SOME f =>
              case !logical_top_frame of
                NONE => ()
              | SOME frame =>
                  (Trace.next frame;
                  continue_fn_ref := NONE;
                  continue := false;
		  (*
                  (!set_active_buttons) ();
                  clear_window ();
		  *)
                  f ())

        val _ =
          let
            val {update, set_focus} =
              Menus.make_buttons
                (buttonPane,
                 [Menus.PUSH ("abortButton", abort_action, abort_present),
                  Menus.PUSH
		    ("continueButton", continue_action, continue_present),
                  Menus.PUSH ("stepButton", step_action, continue_present),
                  Menus.PUSH ("nextButton", next_action, next_present)])

            fun do_set_focus () =
              if continue_present () then
                if Trace.stepping () then
                  set_focus 2
                else
                  set_focus 1
              else
                set_focus 0
          in
            set_active_buttons := (do_set_focus o update)
          end

        fun mk_tooldata () =
          ToolData.TOOLDATA
          {args = ToolData.ShellTypes.LISTENER_ARGS
           {user_options = user_options,
            user_preferences = user_preferences,
            user_context =
            GuiUtils.get_user_context motif_context,
            prompter = prompter,
            mk_xinterface_fn = mk_xinterface_fn},
           current_context = current_context,
           appdata = appdata,
           motif_context = motif_context,
           tools = tools}

	fun get_user_context () = GuiUtils.get_user_context (motif_context)

        val menuspec =
          [ToolData.file_menu [("save", fn _ =>
		       GuiUtils.save_history (false, get_user_context (), applicationShell),
		     fn _ =>
		       not (UserContext.null_history (get_user_context ()))
		       andalso UserContext.saved_name_set (get_user_context ())),
	    ("saveAs", fn _ => GuiUtils.save_history
			     (true, get_user_context (), applicationShell),
		       fn _ => not (UserContext.null_history (get_user_context ()))),
	    ("close", abort_action, abort_present)],
	   ToolData.edit_menu
	   (shell, {cut = NONE, paste = NONE, copy = NONE, delete = NONE,
	     edit_possible = fn _ => false, selection_made = fn _ => false,
	     edit_source = [Menus.PUSH ("editSource",edit_callback,can_edit)],
	     delete_all = NONE}),
	   ToolData.tools_menu (mk_tooldata, get_user_context),
	   ToolData.usage_menu 
	       ([("show_defn",show_callback,can_edit),
		("inspect", fn _ => inspect_current_var (), fn _ => exists_current_var ()),
		("filterFrames", fn _ => settings_popup (), fn _ => true),
		("showFrameInfo", fn _ => info_settings_popup (), fn _ => true),
		("backtrace", fn _ => print_frames (!frames_ref), fn _ => true)], []),
	   ToolData.debug_menu [("abort",abort_action,abort_present),
				("continue",continue_action,continue_present),
				("step",step_action,continue_present),
				("next", next_action, next_present)]]

        fun run_debugger {parameter_details, frames, quit_fn, continue_fn, top_ml_user_frame} =
          (frames_ref := map FRAME frames;
           continue := true;
           quit_fn_ref := quit_fn;
           continue_fn_ref := continue_fn;
           logical_top_frame := top_ml_user_frame;
           update_items ();
           case !displayed_frames of
             [] => ()
           | _ =>
              Capi.List.select_pos (framesList, 1, true);
           Capi.Text.set_string(text, parameter_details);
	   if not (!visible) then
             popup()
	   else
	     ();
           (!set_active_buttons) ();
           (* Go into a local event loop while the window is displayed *)
           (* Loop terminated when window is unmapped *)
           Capi.event_loop continue)

	fun clean_debugger () =
	  clear_window ()

        val varPaneLayout =
          (varPane,
           [Capi.Layout.FIXED argsLabel,
            Capi.Layout.FIXED argsText,
            Capi.Layout.FLEX varsScroll]);

        val framePaneLayout =
          (framePane,
           [Capi.Layout.FIXED framesLabel,
            Capi.Layout.FLEX framesScroll]);
      in
        quit_fns := Menus.quit :: (!quit_fns);
	Menus.make_submenus (menuBar, menuspec);
        (* Add a callback to terminate loop when popup is unmapped *)
        Capi.Callback.add
	  (form, Capi.Callback.Unmap, unmap_action);
	Capi.set_close_callback (form, abort_action);
        Capi.Layout.lay_out
          (form, NONE,
           [Capi.Layout.MENUBAR menuBar,
            Capi.Layout.FIXED buttonPane,
            Capi.Layout.FIXED text,
            Capi.Layout.PANED (debuggerFrame, [varPaneLayout, framePaneLayout]),
            Capi.Layout.SPACE]);
        (run_debugger, clean_debugger)
      end
  end;
