(* Replacement for Listener *)
(*
 *  $Log: _evaluator.sml,v $
 *  Revision 1.33  1998/02/18 16:57:40  jont
 *  [Bug #70070]
 *  Remove MLWorks.IO.terminal_out in favour of Terminal.output
 *
 * Revision 1.32  1997/05/01  13:09:17  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.31  1996/11/06  11:15:57  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.30  1996/05/10  14:45:45  daveb
 * Added edit_possible field to ToolData.edit_menu.
 *
 * Revision 1.29  1996/05/01  11:22:55  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.28  1996/04/30  10:04:27  matthew
 * Replacing MLWorks.Integer with basis file
 *
 * Revision 1.27  1996/03/07  16:43:16  daveb
 * Corrected behaviour of window close function.
 *
 * Revision 1.26  1996/02/19  16:18:26  daveb
 * Converting this to be a source browser.
 *
 * Revision 1.25  1996/01/23  15:38:30  daveb
 * Type of GuiUtils.value_menu has changed.
 *
 * Revision 1.24  1996/01/17  11:45:52  matthew
 * Reordering top level menus.
 *
 * Revision 1.23  1996/01/09  14:03:57  matthew
 * Moved list_select to capi
 *
 * Revision 1.22  1995/12/18  10:49:52  matthew
 * Fixing problem with busy cursor
 *
 * Revision 1.21  1995/12/07  14:34:39  matthew
 * Changing interface to edit_menu
 *
 * Revision 1.20  1995/11/23  11:30:14  matthew
 * Adding call to transfer_focus
 *
 * Revision 1.19  1995/11/17  11:08:49  matthew
 * Fixing problem with last change
 *
 * Revision 1.17  1995/11/16  13:17:06  matthew
 * Changing button resources
 *
 * Revision 1.16  1995/11/15  16:50:12  matthew
 * Adding windows menu
 *
 * Revision 1.15  1995/11/13  17:27:28  matthew
 * Simplifying capi interface.
 *
 * Revision 1.14  1995/10/26  15:16:46  daveb
 * Now creates a new list widget each time that completion is asked for, so that
 * it pops up with the correct size under TWM.
 *
 * Revision 1.13  1995/10/25  12:28:19  nickb
 * Make profile tool a child of the application shell.
 *
 * Revision 1.12  1995/10/20  10:09:32  daveb
 * Renamed ShellUtils.edit_source to ShellUtils.edit_location.
 *
 * Revision 1.11  1995/10/18  13:45:06  nickb
 * Add profiler to the shelldata made here.
 *
 * Revision 1.10  1995/10/09  11:43:46  daveb
 * The search_opt field of the context menu now takes a boolean component which
 * controls whether users are given the option of which contexts to search.
 * In input tools this should be true, in the context browser it should be false.
 *
 * Revision 1.9  1995/10/05  13:31:10  daveb
 * Added search facility.
 *
 * Revision 1.8  1995/10/04  13:41:18  daveb
 * Moved breakpoints_menu to podium.
 *
 * Revision 1.7  1995/10/03  16:25:28  daveb
 * Menus.make_buttons now returns a record of functions.
 *
 * Revision 1.6  1995/09/22  13:41:40  daveb
 * Added highlight function, for highlighting errors in the input text window.
 *
 * Revision 1.5  1995/09/11  15:29:24  matthew
 * Changing top level window initialization
 *
 * Revision 1.4  1995/08/30  13:23:37  matthew
 * Changes to Capi text widget
 *
 * Revision 1.3  1995/08/11  10:07:11  matthew
 * Adding make_buttons function to capi
 *
 * Revision 1.2  1995/07/27  10:56:13  matthew
 * Moved capi etc. to gui
 *
 * Revision 1.1  1995/07/26  14:38:31  matthew
 * new unit
 * New unit
 *
 *  Revision 1.59  1995/07/13  11:16:33  matthew
 *  Removing Incremental from Ml_Debugger
 *
 *  Revision 1.58  1995/07/07  15:25:24  daveb
 *  Minor changes to layout.
 *
 *  Revision 1.57  1995/07/04  15:10:41  matthew
 *  Capification
 *
 *  Revision 1.56  1995/07/04  10:28:39  daveb
 *  Replaced input and output windows with a console window.
 *
 *  Revision 1.55  1995/06/30  09:30:11  daveb
 *  Replaced explicit setting of constraint resources with Layout functions.
 *
 *  Revision 1.53  1995/06/16  10:31:38  daveb
 *  Added Time button.
 *
 *  Revision 1.52  1995/06/15  15:58:15  daveb
 *  Moved code that resets state to outside the exception handlers (in
 *  the evaluate function).
 *
 *  Revision 1.51  1995/06/15  13:14:52  daveb
 *  Hid details of WINDOWING type in ml_debugger.
 *
 *  Revision 1.50  1995/06/14  13:54:17  daveb
 *  Made use of error browser depend on preferences.
 *  Type of Ml_Debugger.ml_debugger, ShellUtils.edit_* and OutputWindow.create
 *  have changed.
 *
 *  Revision 1.49  1995/06/12  15:03:07  daveb
 *  Ensured that the result strings are not overwritten by the
 *  selection mechanism.
 *
 *  Revision 1.48  1995/06/06  14:17:17  daveb
 *  Added history commands.
 *
 *  Revision 1.47  1995/06/05  13:55:26  daveb
 *  Changed sensitivity argument of view_options to SENSE_ALL, because
 *  the shell functions now set the current selection.
 *
 *  Revision 1.46  1995/06/05  13:10:54  daveb
 *  Made evaluator sensitive to current selection.  The current definition
 *  is preserved when necessary.
 *
 *  Revision 1.45  1995/06/01  11:37:21  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.44  1995/05/23  14:09:44  matthew
 *  Changing interface to list_select.
 *
 *  Revision 1.43  1995/05/23  08:57:23  daveb
 *  Made contexts only visible if full_menus set.
 *
 *  Revision 1.42  1995/05/16  09:46:35  matthew
 *  Adding escape key functionality
 *
 *  Revision 1.41  1995/05/04  09:46:13  matthew
 *  Removed script from ml_debugger
 *
 *  Revision 1.40  1995/04/28  16:58:40  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.39  1995/04/24  14:21:52  daveb
 *  Added breakpoint menu.  Removed value menu.
 *
 *  Revision 1.38  1995/04/19  10:57:28  daveb
 *  Changes to context_menu.
 *
 *  Revision 1.37  1995/04/13  11:28:08  daveb
 *  Added catch for ShellTypes.DebuggerTrapped in evaluate function.
 *
 *  Revision 1.36  1995/04/06  15:47:21  daveb
 *  Input widget now takes an applicationShell argument.
 *
 *  Revision 1.35  1995/03/31  14:51:04  daveb
 *  Ensured that we always use a windowing debugger.
 *
 *  Revision 1.34  1995/03/31  13:35:26  daveb
 *  Removed unimplemented menu items.
 *
 *  Revision 1.33  1995/03/30  13:49:36  daveb
 *  Removed the history pane to the new context tool.
 *
 *  Revision 1.32  1995/03/17  12:27:36  daveb
 *  Merged ShellTypes.get_context_name and ShellTypes.string_context_name.
 * 
 *  Revision 1.31  1995/03/16  15:49:09  daveb
 *  Removed context_function from register when closing the window.
 * 
 *  Revision 1.30  1995/03/15  17:42:31  daveb
 *  Changed to share current context with other tools..
 * 
 *  Revision 1.29  1995/03/10  17:01:42  daveb
 *  Replaced "inspect" command with automatic updating of context selection.
 * 
 *  Revision 1.28  1995/03/06  12:29:18  daveb
 *  Added contexts to history info.  Also replaced evaluation sequence
 *  with ShellTypes.process_result.
 * 
 *  Revision 1.27  1995/03/02  13:31:24  matthew
 *  Changes to Parser & Lexer structures
 * 
 *  Revision 1.26  1995/03/01  15:14:26  daveb
 *  Removed redundant code.
 * 
 *  Revision 1.25  1995/02/27  14:05:44  daveb
 *  Fixed timing of call to ActionQueue.do_actions.
 * 
 *  Revision 1.24  1995/02/20  15:31:38  daveb
 *  Changed name of output pane so that resources can make it read-only.
 * 
 *  Revision 1.23  1995/02/20  14:21:11  daveb
 *  Made use update the history of the context, and regenerated the
 *  history from the context every time.
 * 
 *  Revision 1.22  1995/02/16  16:49:59  daveb
 *  Added shortcuts for the buttons.
 * 
 *  Revision 1.21  1995/02/16  15:02:45  daveb
 *  Removed the augment button, and all that depended on it.
 * 
 *  Revision 1.20  1995/01/13  16:17:47  daveb
 *  Replaced Option structure with references to MLWorks.Option.
 * 
 *  Revision 1.19  1994/11/30  18:30:21  daveb
 *  Fixed bug in form layout code for MIPS.  Also simplified this code
 *  by replacing separator widgets with Xm.*Offset values.  Also added
 *  an initial call to Xm.Widget.processTraversal for correct
 *  behaviour on the MIPS.
 * 
 *  Revision 1.18  1994/09/21  12:29:15  brianm
 *  Adding value menu (Edit/Trace/Untrace)
 * 
 *  Revision 1.17  1994/08/11  11:11:06  daveb
 *  Ensured that accept function augmented the correct context.
 * 
 *  Revision 1.16  1994/08/11  10:53:58  daveb
 *  Added semicolons when saving history.
 * 
 *  Revision 1.15  1994/08/09  12:55:02  daveb
 *  Changed type of InterPrint.strings.  Renamed source_result to result.
 *  A minor change to how results are used.
 * 
 *  Revision 1.14  1994/08/02  16:55:52  daveb
 *  Made error browser handle edit operation correctly.
 * 
 *  Revision 1.13  1994/08/02  09:20:37  daveb
 *  Passed token_stream to Incremental.compile_source instead of a parsed
 *  topdec, thus ensuring correct error handling.  Also made errors from
 *  the action queue invoke an error browser.
 * 
 *  Revision 1.11  1994/07/28  11:41:39  daveb
 *  Corrected sensitivity of history menu items.  Removed edit and inspect
 *  entries until they actually work.
 * 
 *  Revision 1.10  1994/07/28  10:24:12  daveb
 *  Excised unimplemented parts of user-interface.
 * 
 *  Revision 1.9  1994/07/27  14:32:52  daveb
 *  Cut-down menus for novices.
 * 
 *  Revision 1.8  1994/07/19  13:20:42  daveb
 *  Corrected misnamed "print_options" to the correct "options".
 * 
 *  Revision 1.7  1994/07/12  16:03:57  daveb
 *  ToolData.works_menu takes different arguments.
 * 
 *  Revision 1.6  1994/07/11  17:51:04  daveb
 *  Made accept button insensitive when there is no current result.
 * 
 *  Revision 1.5  1994/07/05  19:05:23  daveb
 *  Added input widget.
 * 
 *  Revision 1.4  1994/06/30  17:39:36  daveb
 *  Ensured that source is saved in user contexts.  Set history from user
 *  contexts.  Added facility to save the source of the current context.
 *  Also disabled entries in Output menu as appropriate.
 * 
 *  Revision 1.3  1994/06/23  10:55:32  jont
 *  Update debugger information production
 * 
 *  Revision 1.2  1994/06/23  10:36:04  daveb
 *  Added calls to Xm.Widget.processTraversal.  Also cleared output window
 *  before evaluating.
 * 
 *  Revision 1.1  1994/06/21  18:50:43  daveb
 *  new file
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

require "../basis/__int";
require "^.utils.__terminal";

require "../main/info";
require "../utils/lists";
require "../main/preferences";
require "../main/user_options";
require "tooldata";
require "gui_utils";
require "capi";
require "menus";
require "evaluator";

functor Evaluator (
  structure Lists: LISTS
  structure UserOptions : USER_OPTIONS
  structure Preferences : PREFERENCES
  structure ToolData : TOOL_DATA
  structure Menus : MENUS
  structure GuiUtils : GUI_UTILS
  structure Capi : CAPI
  structure Info : INFO

  sharing type Preferences.user_preferences =
	       ToolData.ShellTypes.user_preferences =
	       GuiUtils.user_preferences

  sharing type GuiUtils.user_context_options =
	       ToolData.UserContext.user_context_options =
	       UserOptions.user_context_options

  sharing type ToolData.ShellTypes.user_options =
	       GuiUtils.user_tool_options =
	       UserOptions.user_tool_options

  sharing type Menus.Widget = 
	       ToolData.Widget = GuiUtils.Widget =
	       Capi.Widget

  sharing type Menus.ButtonSpec = GuiUtils.ButtonSpec = ToolData.ButtonSpec

  sharing type ToolData.ShellTypes.user_context =
	       GuiUtils.user_context 

  sharing type Preferences.preferences =
               ToolData.ShellTypes.preferences

  sharing type GuiUtils.MotifContext = ToolData.MotifContext
): EVALUATOR =
struct
  structure Location = Info.Location
  structure ShellTypes = ToolData.ShellTypes
  structure Options = ShellTypes.Options
  structure UserContext = ToolData.UserContext
  structure Option = MLWorks.Option

  type Widget = Capi.Widget
  type Context = ShellTypes.Context
  type UserOptions = UserOptions.user_tool_options

  type ToolData = ToolData.ToolData

  val evaluator_number = ref 1

  val do_debug = false
  fun debug s =
    if do_debug then Terminal.output(s ^ "\n") else ()

  fun create (parent,
	      tooldata as ToolData.TOOLDATA
		{args, current_context, motif_context, tools, ...},
	      destroy_fn) =
    let
      val ShellTypes.LISTENER_ARGS {user_options,
                                    user_preferences,
                                    prompter,
                                    mk_xinterface_fn,
                                    ...} = args

      val (full_menus, update_fns) =
	case user_preferences
	of Preferences.USER_PREFERENCES ({full_menus, ...}, update_fns) =>
	  (!full_menus, update_fns)

      val title =
        let
          val n = !evaluator_number
        in
          evaluator_number := n+1;
          "Source Browser #" ^ Int.toString n
        end

      (*** Make the windows ***)
      val (shell,frame,menuBar,contextLabel) =
        Capi.make_main_window ("evaluator", title, parent, false)

      val paned =
        Capi.make_managed_widget ("paned", Capi.Paned, frame, [])

      val sourcePane =
  	Capi.make_managed_widget ("sourcePane", Capi.Form, paned,[]);

      val sourceTitleLabel =
  	Capi.make_managed_widget
	  ("sourceTitleLabel", Capi.Label, sourcePane, [])

      val (sourceScroll,sourceText) =
	Capi.make_scrolled_text ("sourceText", sourcePane, [])

      val resultPane =
	Capi.make_managed_widget ("resultPane", Capi.Form, paned, [])

      val resultTitleLabel =
  	Capi.make_managed_widget
	  ("resultTitleLabel", Capi.Label, resultPane, [])

      val (resultScroll,resultText) =
	Capi.make_scrolled_text ("resultText", resultPane, [])

      (*** Local Motif Context ***)

      val local_context = ref motif_context

      fun get_user_context () = GuiUtils.get_user_context (!local_context)
      fun get_context () = UserContext.get_context (get_user_context ())

      fun get_user_options () = user_options

      fun beep _ = Capi.beep shell

      fun get_user_options () = user_options

      fun close_window _ =
	(destroy_fn ();
	 Capi.destroy shell)

      val do_automatic = ref false
      val current_item_ref = ref NONE

      fun get_value () = !current_item_ref

      fun duplicate (src, res) =
	let
	  val f = create (parent, tooldata, fn _ => ())
	in
	  f false (src, res)
	end

      val main_menu =
        Menus.CASCADE
          ("main",
           [Menus.TOGGLE
	      ("autoSelection",
               fn _ => !do_automatic,
               fn b => do_automatic := b,
               fn _ => true),
            Menus.PUSH
	      ("duplicate",
               fn _ =>
		 case get_value () of
                   SOME x => duplicate x
                 | _ => (),
               fn _ =>
                 case get_value () of
                   SOME x => true
                 | _ => false),
            Menus.SEPARATOR,
            Menus.PUSH ("close", close_window, fn _ => true)],
           fn _ => true)

      val view_options =
	GuiUtils.view_options
	  {parent = shell, title = title, user_options = user_options,
	   user_preferences = user_preferences,
	   caller_update_fn = fn _ => (),
	   view_type = GuiUtils.VIEW_ALL}

      val view_menu =
	Menus.CASCADE ("view", view_options, fn _ => true)

      fun show_defn auto (src, res) =
	if auto andalso not (!do_automatic) then
	  ()
	else
	  (Capi.Text.set_string (sourceText, src);
	   Capi.Text.set_string (resultText, res);
	   current_item_ref := SOME (src, res);
	   Capi.to_front shell)

      fun get_selection _ =
        let
          val s1 = Capi.Text.get_selection sourceText
        in
          if s1 = "" then Capi.Text.get_selection resultText
          else s1
        end

      val menuspec =
        [main_menu,
         ToolData.edit_menu
           (shell,
            {cut = NONE,
             paste = NONE,
             copy = SOME (fn _ => Capi.Text.copy_selection sourceText),
             delete = NONE,
	     edit_possible = fn _ => false,
             selection_made = fn _ => get_selection () <> "",
	     tail = []}),
	 view_menu]

      val sep_size = 10

    in
      Menus.make_submenus (menuBar,menuspec);
      Capi.Layout.lay_out
        (sourcePane,
         [Capi.Layout.FIXED sourceTitleLabel,
          Capi.Layout.FLEX sourceScroll,
          Capi.Layout.SPACE]);
      Capi.Layout.lay_out
        (resultPane,
         [Capi.Layout.FIXED resultTitleLabel,
          Capi.Layout.FLEX resultScroll,
          Capi.Layout.SPACE]);
      case contextLabel
      of MLWorks.SOME w =>
        Capi.Layout.lay_out
        (frame,
         [Capi.Layout.MENUBAR menuBar,
          Capi.Layout.FIXED w,
          Capi.Layout.PANED paned])
      |  MLWorks.NONE => 
        Capi.Layout.lay_out
        (frame,
         [Capi.Layout.MENUBAR menuBar,
          Capi.Layout.SPACE,
          Capi.Layout.PANED paned]);
      Capi.initialize_toplevel shell;
      show_defn
    end

  fun show_defn (parent, tooldata) =
    let
      val display_fun = ref NONE
      fun destroy_fun _ = display_fun := NONE
    in
      fn auto =>
      fn (src, res) =>
        case !display_fun of
          SOME f => f auto (src, res)
        | _ =>
          if auto then
 	    ()
          else
            let
	      val f = create (parent, tooldata, destroy_fun)
            in
	      f false (src, res);
              display_fun := SOME f
            end
    end

end;
