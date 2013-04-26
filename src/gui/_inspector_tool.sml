(*
 * Copyright (c) 1993 Harlequin Ltd.
 * $Log: _inspector_tool.sml,v $
 * Revision 1.61  1998/03/31 16:02:40  johnh
 * [Bug #30346]
 * Call Capi.getNextWindowPos.
 *
 * Revision 1.60  1998/03/02  15:07:22  mitchell
 * [Bug #70074]
 * Add depth limit support for signature printing
 *
 * Revision 1.59  1998/02/19  20:15:40  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.58  1998/02/18  17:00:54  jont
 * [Bug #70070]
 * Remove MLWorks.IO.terminal_out in favour of Terminal.output
 *
 * Revision 1.57  1998/02/17  16:41:36  johnh
 * [Bug #30344]
 * Allow windows to retain size and position.
 *
 * Revision 1.56  1998/01/27  15:58:18  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.55  1997/09/18  15:16:09  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.54.2.2  1997/11/20  17:04:04  johnh
 * [Bug #30071]
 * Remove Paths menu.
 *
 * Revision 1.54.2.1  1997/09/11  20:52:09  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.54  1997/07/28  13:16:50  brucem
 * [Bug #30202]
 * Add `indicateHiddenChildren' to GraphSpecs.
 *
 * Revision 1.53  1997/07/25  13:31:48  johnh
 * [Bug #30210]
 * Add value printer update function for inspector.
 *
 * Revision 1.52  1997/06/13  11:00:31  johnh
 * [Bug #30175]
 * Combine tools and windows menus.
 *
 * Revision 1.51  1997/06/11  12:40:07  johnh
 * [Bug #30075]
 * Adding numbers to the titles of the duplicated windows.
 *
 * Revision 1.50  1997/05/16  15:35:32  johnh
 * Implementing single menu bar on Windows.
 * Re-organising menus for Motif.
 *
 * Revision 1.49  1997/05/02  17:27:07  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.48  1997/03/06  17:28:18  matthew
 * Fixing equality
 *
 * Revision 1.47  1996/10/09  15:59:06  io
 * moving String from toplevel
 *
 * Revision 1.46  1996/09/30  09:39:04  johnh
 * [Bug #1597]
 * [Bug #1597]
 * Used CAPI function reveal to manage the shell and frame in order.
 *
 * Revision 1.45  1996/08/15  12:52:45  daveb
 * [Bug #1519]
 * Replaced make_value_from_item with ShellUtils.value_from_history_entry.
 *
 * Revision 1.44  1996/08/07  10:46:44  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_types.sml
 *
 * Revision 1.43  1996/05/28  14:23:51  matthew
 * Attempting to give dialogs more meaningful names
 *
 * Revision 1.42  1996/05/24  16:21:18  daveb
 * Changed to have a single inspector.
 *
 * Revision 1.41  1996/05/24  14:39:15  daveb
 * Improvements to Graph dialogs.
 *
 * Revision 1.40  1996/05/10  14:46:19  daveb
 * Added edit_possible field to ToolData.edit_menu.
 *
 * Revision 1.39  1996/05/07  11:36:22  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.38  1996/05/01  10:50:28  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.37  1996/04/19  16:17:47  daveb
 * Stopped inspector from calling to_front when called with an automatic
 * selection.  Disabled the auto_select menu item in duplicate inspectors.
 *
 * Revision 1.36  1996/04/04  13:44:48  matthew
 * Pass graph layout settings around.
 *
 * Revision 1.35  1996/02/08  15:31:42  daveb
 * Removed sensitivity field from argument to view_options.
 *
 * Revision 1.34  1996/01/25  13:11:42  matthew
 * Changed interface to graph widget
 *
 * Revision 1.33  1996/01/23  16:09:42  daveb
 * Type of GuiUtils.value_menu has changed.
 *
 * Revision 1.32  1996/01/22  16:35:47  matthew
 * Removing (for the moment) abbreviated nodes.
 *
 * Revision 1.31  1996/01/22  11:12:47  daveb
 * Removed history menu.
 *
 * Revision 1.30  1996/01/19  14:55:25  matthew
 * Changing interface to allow inspector reuse.
 *
 * Revision 1.29  1996/01/17  17:24:23  matthew
 * Various small changes
 *
 * Revision 1.28  1995/12/07  14:18:45  matthew
 * Changing interface to edit_menu
 *
 * Revision 1.27  1995/11/23  12:58:12  matthew
 * Fiddling with draw_item
 *
 * Revision 1.26  1995/11/21  14:43:02  matthew
 * Fixing drawing function
 *
 * Revision 1.25  1995/11/16  13:18:37  matthew
 * Changing button resources
 *
 * Revision 1.24  1995/11/15  16:56:22  matthew
 * Adding windows menu
 *
 * Revision 1.23  1995/11/14  14:01:15  matthew
 * Changing capi interface
 *
 * Revision 1.22  1995/10/30  16:14:44  daveb
 * Added display controls dialog to view menu.
 *
 * Revision 1.21  1995/10/25  12:59:59  brianm
 * Ensuring that atomic values cannot be root candidates - they are always
 * expanded otherwise.
 *
 * Revision 1.20  1995/10/19  15:33:43  matthew
 * Fixing having to click twice on "Previous Roots"
 *
 * Revision 1.19  1995/10/18  11:08:55  matthew
 * Adding a SPACE at the bottom of the layout
 *
 * Revision 1.18  1995/10/18  11:01:55  brianm
 * Changed defaults for `show_atoms' from false to true.
 *
 * Revision 1.17  1995/10/15  16:12:10  brianm
 * Added large number of features:
 *   - middle button provides popup-menu:
 *     - Value/Type display
 *     - Show atomic values?
 *     - Equal values shared?
 *     - Display all children?
 *     - Graph Arity/Depth limits.
 *   - right button acts to contract nodes.
 *
 *   - Added Roots/Previous Roots/Original Root facilities.
 *   - Removed list menu
 * Made modifications due to introduction of GraphWidget.Extent etc.
 *
 * Revision 1.15  1995/10/11  09:36:12  brianm
 * Modifications due to changes in GraphSpec.
 *
 * Revision 1.14  1995/10/10  08:56:12  brianm
 * Switched to child-expansion behaviour, modified label printing for strings and
 * gave lables more `surround' (the code for this made easily modifiable).
 *
 * Revision 1.13  1995/10/09  08:42:20  brianm
 * Made the graph update the value and type display - changed print depth in the
 * graph label to 2 - to get a template effect.
 *
 * Revision 1.12  1995/10/06  12:37:10  brianm
 * Modification to take account of change to graph_widget interface.
 *
 * Revision 1.11  1995/10/04  13:26:12  daveb
 * Type of context_menu has changed.
 *
 * Revision 1.10  1995/09/18  14:45:06  brianm
 * Updating by adding Capi Point/Region datatypes
 *
 * Revision 1.9  1995/09/11  13:20:16  matthew
 * Changing top level window initialization
 *
 * Revision 1.8  1995/09/08  15:36:27  matthew
 * Extending GraphSpec type
 *
 * Revision 1.7  1995/09/06  13:56:59  matthew
 * Changing interface to graph widget
 *
 * Revision 1.6  1995/08/30  13:23:42  matthew
 * Renaming layout constructors
 *
 * Revision 1.5  1995/08/10  12:17:02  matthew
 * Adding mak_buttons function to capi
 *
 * Revision 1.4  1995/08/02  15:07:06  matthew
 * Changing interface to grapher
 *
 * Revision 1.3  1995/07/27  10:57:51  matthew
 * Moved capi etc. to gui
 *
 * Revision 1.2  1995/07/27  10:32:47  matthew
 * Moved graph_widget to gui directory
 *
 * Revision 1.1  1995/07/26  14:44:43  matthew
 * new unit
 * New unit
 *
 *  Revision 1.79  1995/07/26  13:20:35  matthew
 *  Adding support for font dimensions etc.
 *
 *  Revision 1.78  1995/07/20  16:17:40  matthew
 *  Adding Graphs
 *
 *  Revision 1.77  1995/07/13  11:54:33  matthew
 *  Moving identifier type to Ident
 *
 *  Revision 1.76  1995/07/07  15:31:31  daveb
 *  Minor changes to layout.
 *
 *  Revision 1.75  1995/07/04  13:53:27  matthew
 *  Capification
 *
 *  Revision 1.74  1995/06/14  13:21:33  daveb
 *  ShellUtils.edit_* functions no longer require a context argument.
 *
 *  Revision 1.73  1995/06/08  13:39:44  daveb
 *  Removed require "output".
 *
 *  Revision 1.72  1995/06/08  09:29:26  daveb
 *  Removed Output widget and debugger function.
 *
 *  Revision 1.71  1995/06/06  16:07:48  daveb
 *  Removed input window.  Moved parent and toplevel buttons to main
 *  window from menu.  Added source text.
 *
 *  Revision 1.70  1995/06/06  10:30:03  daveb
 *  Removed inspect_variable.  Made create inspect current selection on
 *  start-up, instead of evaluating "it".
 *
 *  Revision 1.69  1995/06/01  10:32:09  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.68  1995/05/23  14:12:51  matthew
 *  Changing interface to list_select.
 *
 *  Revision 1.67  1995/05/23  08:47:12  daveb
 *  Made contexts only visible if full_menus set.
 *
 *  Revision 1.66  1995/05/04  09:58:46  matthew
 *  Use create for making top level shell
 *  Removing exception EditObject
 *
 *  Revision 1.65  1995/04/28  16:49:08  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.64  1995/04/18  14:50:53  daveb
 *  Changes to context_menu.
 *  
 *  Revision 1.63  1995/03/31  16:41:11  daveb
 *  Added the history number to items in the history.
 *  
 *  Revision 1.62  1995/03/31  13:43:51  daveb
 *  Removed redundant require.
 *  
 *  Revision 1.61  1995/03/17  11:29:07  daveb
 *  Merged ShellTypes.get_context_name and ShellTypes.string_context_name.
 *  
 *  Revision 1.60  1995/03/16  14:32:43  daveb
 *  Removed context_function from register when closing the window.
 *  
 *  Revision 1.59  1995/03/15  16:19:47  daveb
 *  Changed to share current context with other tools..
 *  
 *  Revision 1.58  1995/03/10  15:28:23  daveb
 *  Added calls to register select function in current context.
 *  
 *  Revision 1.57  1995/03/02  17:13:33  daveb
 *  Added inspect_variable, with takes a context and looks the value up
 *  in that.
 *  
 *  Revision 1.56  1995/02/27  13:08:21  daveb
 *  Changed valLabel and typeLabel widgets to text widgets (and renamed
 *  them), so that we can constrain the number of columns.
 *  
 *  Revision 1.55  1995/02/06  16:58:36  daveb
 *  Removed argument from value_menu.
 *  
 *  Revision 1.54  1995/01/13  15:22:45  daveb
 *  Replaced Option structure with references to MLWorks.Option.
 *  
 *  Revision 1.53  1994/11/30  16:16:02  daveb
 *  Simplified Form constraints.
 *  
 *  Revision 1.52  1994/09/21  16:28:29  brianm
 *  Adding value menu ...
 *  
 *  Revision 1.51  1994/08/10  11:41:01  matthew
 *  Add flush output
 *  
 *  Revision 1.50  1994/08/01  10:30:22  daveb
 *  Moved preferences to separate structure.
 *  
 *  Revision 1.48  1994/07/12  16:11:34  daveb
 *  ToolData.works_menu takes different arguments.
 *  
 *  Revision 1.47  1994/06/20  11:33:53  daveb
 *  Moved output window code to separate file.
 *  Replaced context refs with user_contexts.
 *  
 *  Revision 1.46  1994/03/14  16:43:55  matthew
 *  Added untrace value facility
 *  
 *  Revision 1.45  1994/02/23  17:02:19  nosa
 *  Boolean indicator for Monomorphic debugger decapsulation;
 *  Debugger scripts for tracing tool using debugger.
 *  
 *  Revision 1.44  1994/02/02  11:53:29  daveb
 *  Changed substructure of InterMake.
 *  
 *  Revision 1.43  1993/12/20  12:57:49  matthew
 *  Changed name of output window
 *  
 *  Revision 1.42  1993/12/10  15:16:20  daveb
 *  Added context menu, ensured that changes do the right thing, ensured that
 *  new selection is passed on to child tools.
 *  
 *  Revision 1.41  1993/12/09  19:34:46  jont
 *  Added copyright message
 *  
 *  Revision 1.40  1993/12/06  14:37:38  daveb
 *  Ensured that output window is automatically shown when appropriate
 *  preference is set.
 *  
 *  Revision 1.39  1993/11/26  12:25:38  matthew
 *  Improvements to debugger calling.
 *  
 *  Revision 1.38  1993/10/22  16:59:47  daveb
 *  Merged in bug fix.
 *  
 *  Revision 1.37  1993/10/08  16:33:41  matthew
 *   Merging in bug fixes
 *  
 *  Revision 1.36.1.3  1993/10/21  14:03:30  daveb
 *  Changed ToolData.works_menu to take a (unit -> bool) function that
 *  controls whether the Close menu option is enabled.
 *  
 *  Revision 1.36.1.2  1993/10/08  14:02:45  matthew
 *  Added horizontal scrollbar to input pane
 *  Tests for editability and scrollability of objects
 *  Uses history utilities
 *  Added name completion
 *  
 *  Revision 1.36.1.1  1993/08/29  16:47:08  jont
 *  Fork for bug fixing
 *  
 *  Revision 1.36  1993/08/29  16:47:08  daveb
 *  Changed name of file menu to window.
 *  
 *  Revision 1.35  1993/08/25  15:03:22  matthew
 *  Return quit function from ShellUtils.edit_string
 *  
 *  Revision 1.34  1993/08/24  13:44:40  matthew
 *  Improved editing and tracing error handling
 *  
 *  Revision 1.33  1993/08/12  18:05:30  daveb
 *  Removed spurious sharing constraint.
 *  
 *  Revision 1.32  1993/08/11  11:25:19  matthew
 *  Changes to user options
 *  Removed preferences menu
 *  Options update
 *  
 *  Revision 1.31  1993/08/10  14:46:45  nosa
 *  Debugger-window now passed to Inspector-tool functions.
 *  
 *  Revision 1.30  1993/08/10  10:28:17  matthew
 *  Get maximum history length from options
 *  
 *  Revision 1.29  1993/08/03  14:39:12  matthew
 *  Changed history mechanism.
 *  
 *  Revision 1.28  1993/06/16  16:34:40  matthew
 *  Added value menu with edit and trace options
 *  
 *  Revision 1.27  1993/06/04  10:07:16  daveb
 *  Removed popHistory button.
 *  
 *  Revision 1.26  1993/06/03  17:03:51  matthew
 *  Clear text input on selection from history
 *  
 *  Revision 1.25  1993/06/03  11:54:57  matthew
 *  Limit error messages to first line.
 *  
 *  Revision 1.24  1993/05/28  16:05:01  matthew
 *  Added tty_ok value to WINDOWING
 *  Added history
 *  
 *  Revision 1.23  1993/05/26  17:18:30  matthew
 *  Changed error handling for eval
 *  
 *  Revision 1.22  1993/05/13  11:34:33  daveb
 *  All tools now set their own titles and pass them to their options menus.
 *  
 *  Revision 1.21  1993/05/13  10:00:22  matthew
 *  Fixed problem with debugger window.
 *  
 *  Revision 1.20  1993/05/12  13:09:00  matthew
 *  Uses ShellUtils more
 *  
 *  Revision 1.19  1993/05/11  17:17:07  matthew
 *  Changed layout.
 *  Better debugger interface
 *  
 *  Revision 1.18  1993/05/10  16:03:36  daveb
 *  Changed type of ml_debugger.
 *  
 *  Revision 1.17  1993/05/10  14:25:22  daveb
 *  Removed error_info field from ListenerArgs, ShellData and Incremental.options
 *  
 *  Revision 1.16  1993/05/07  17:25:13  matthew
 *  Added sharing constraint
 *  
 *  Revision 1.15  1993/05/07  11:02:15  daveb
 *  Replaced some stuff with GuiUtils.make_scrolllist.
 *  Greatly improved layout.
 *  
 *  Revision 1.14  1993/05/06  16:08:25  matthew
 *  Removed printer_descriptors
 *  
 *  Revision 1.13  1993/05/06  14:57:36  daveb
 *  Added output widget for showing type errors, etc.
 *  
 *  Revision 1.12  1993/05/05  19:11:53  daveb
 *  Renamed inspect to create, and changed its type so that inspectors can
 *  be added to the list of tools on the Works menu.
 *  
 *  Revision 1.11  1993/05/05  12:00:34  matthew
 *  Print type using completion
 *  
 *  Revision 1.10  1993/04/30  14:01:00  matthew
 *  textInput widget now called textIO
 *  
 *  Revision 1.9  1993/04/23  14:53:09  matthew
 *  Immediately inspect "it" on startup.  Added inspect_value function
 *  Simple error handling for user defined methods
 *  
 *  Revision 1.8  1993/04/21  16:45:28  matthew
 *  Cleaned up
 *  
 *  Revision 1.7  1993/04/20  10:25:26  matthew
 *  Renamed Inspector_Values to InspectorValues
 *  
 *  Revision 1.6  1993/04/06  17:50:36  daveb
 *  Names of Callbacks have changed.
 *  
 *  Revision 1.5  1993/04/06  16:25:10  jont
 *  Moved user_options and version from interpreter to main
 *  
 *  Revision 1.4  1993/04/02  17:51:07  matthew
 *  Added text input window with expression evaluation
 *  
 *  Revision 1.2  1993/03/30  16:35:14  matthew
 *  Removed MENUSPEC data constructor
 *  
 *  Revision 1.1  1993/03/26  16:50:09  matthew
 *  Initial revision
 *  
 *)

require "^.utils.__terminal";
require "capi";
require "menus";
require "../main/user_options";
require "../main/preferences";
require "../utils/lists";
require "../utils/lisp";
require "../interpreter/inspector_values";
require "../interpreter/shell_utils";
require "gui_utils";
require "graph_widget";
require "tooldata";

require "inspector_tool";
require "^.basis.__int";

functor InspectorTool (
  structure Capi : CAPI
  structure GraphWidget : GRAPH_WIDGET
  structure UserOptions : USER_OPTIONS
  structure Preferences : PREFERENCES
  structure Lists : LISTS
  structure LispUtils : LISP_UTILS
  structure InspectorValues : INSPECTOR_VALUES
  structure ShellUtils : SHELL_UTILS
  structure Menus : MENUS
  structure GuiUtils : GUI_UTILS
  structure ToolData : TOOL_DATA

  sharing UserOptions.Options = ToolData.ShellTypes.Options =
    ShellUtils.Options

  sharing type UserOptions.user_tool_options =
	       ToolData.ShellTypes.user_options =
               GuiUtils.user_tool_options = ShellUtils.UserOptions
  sharing type UserOptions.user_context_options =
	       GuiUtils.user_context_options =
	       ToolData.UserContext.user_context_options
  sharing type InspectorValues.options = UserOptions.Options.options
  sharing type InspectorValues.Type = ShellUtils.Type = GuiUtils.Type
  sharing type Menus.Widget = Capi.Widget = GuiUtils.Widget = ToolData.Widget = GraphWidget.Widget
  sharing type Capi.GraphicsPorts.GraphicsPort = GraphWidget.GraphicsPort
  sharing type Capi.Region = GraphWidget.Region
  sharing type Capi.Point = GraphWidget.Point
  sharing type ToolData.ShellTypes.Context = ShellUtils.Context
  sharing type Menus.OptionSpec = GuiUtils.OptionSpec
  sharing type ToolData.ButtonSpec = Menus.ButtonSpec = GuiUtils.ButtonSpec
  sharing type GuiUtils.user_context = ToolData.ShellTypes.user_context = ShellUtils.user_context
  sharing type Preferences.preferences = ShellUtils.preferences
  sharing type ShellUtils.user_preferences = Preferences.user_preferences =
  	       ToolData.ShellTypes.user_preferences =
	       GuiUtils.user_preferences
  sharing type GuiUtils.MotifContext = ToolData.MotifContext
  sharing type ToolData.UserContext.history_entry = ShellUtils.history_entry
) : INSPECTORTOOL =
struct
    structure Options = UserOptions.Options
    structure ShellTypes = ToolData.ShellTypes
    structure UserContext = ToolData.UserContext
    structure Info = ShellUtils.Info

    type Widget = Capi.Widget
    type Point = Capi.Point
    type Region = Capi.Region
    type ToolData = ToolData.ToolData
    type Type = InspectorValues.Type

    fun debug_output s = Terminal.output(s ^"\n")
    val unwind_protect = LispUtils.unwind_protect
    val inspector_number = ref 0

    val do_abbreviations = false

    datatype GraphType = VALUE | TYPE

    datatype GraphOptions =
      GRAPH_OPTIONS of {graph_type : GraphType,
                        show_atoms : bool,
                        show_strings : bool,
                        graph_sharing : bool,
                        graph_arity : int,
                        graph_depth : int,
                        default_visibility : bool,
                        child_position : GraphWidget.ChildPosition,
                        child_expansion : GraphWidget.ChildExpansion,
                        show_root_children : bool,
                        indicateHiddenChildren : bool,
                        orientation : GraphWidget.Orientation,
                        line_style : GraphWidget.LineStyle,
                        horizontal_delta : int,
                        vertical_delta : int,
                        graph_origin : int * int,
                        show_all : bool
                        }

    val default_options = 
      GRAPH_OPTIONS {graph_type = VALUE,
                     show_atoms = true,
                     show_strings = true,
                     graph_sharing = true,
                     graph_arity = 4,
                     graph_depth = 5,
                     default_visibility = false,
                     child_position = GraphWidget.CENTRE,
                     child_expansion = GraphWidget.TOGGLE,
                     show_root_children = false,
                     indicateHiddenChildren = false,
                     orientation = GraphWidget.VERTICAL,
                     line_style = GraphWidget.STRAIGHT,
                     horizontal_delta = 20,
                     vertical_delta = 30,
                     graph_origin = (8,8),
                     show_all = false}

    val posRef = ref NONE
    val sizeRef = ref NONE

    fun make_inspector_window (initial_item, options,
                               select_auto, debugger_print,
                               parent,tooldata,destroy_fun) =
      let
        val ToolData.TOOLDATA
	      {args as ShellTypes.LISTENER_ARGS
                 {user_options, user_context, user_preferences,
                  prompter, mk_xinterface_fn},
               appdata,current_context, motif_context, tools, ...} =
          tooldata

        (* select_auto is now also used to tell whether the inspector was duplicated *)
        val duplicated = not (isSome select_auto)

        val title = 
	  if duplicated then 
	    (inspector_number := (!inspector_number) + 1;
	     "Inspector #" ^ Int.toString (!inspector_number))
	  else
	    "Inspector"

        val (full_menus, update_fns) =
	  case user_preferences
	  of Preferences.USER_PREFERENCES ({full_menus, ...}, update_fns) =>
	    (!full_menus, update_fns)

        val do_automatic =
	  case select_auto
	  of NONE => ref false
	  |  SOME b => ref b

        val (shell,frame,menuBar,_) =
          Capi.make_main_popup {name = "inspector",
				title = title,
				parent = parent,
				contextLabel = false, 
				visibleRef = ref true,
				pos = getOpt (!posRef, Capi.getNextWindowPos())}

        val valText = Capi.make_managed_widget ("valText",Capi.Text,frame, [])
        val typeText = Capi.make_managed_widget ("typeText", Capi.Text,frame, [])
        val srcText = Capi.make_managed_widget  ("srcText", Capi.Text, frame, [])
	val local_context = ref motif_context

        fun get_current_context () =
	  (UserContext.get_context
	     (GuiUtils.get_user_context (!local_context)))

        fun message_fun s =
          Capi.send_message (shell, s)

        fun get_user_tool_options () = user_options

        fun get_user_context_options () =
	  UserContext.get_user_options
	    (GuiUtils.get_user_context (!local_context))


        fun get_compiler_options () =
          UserOptions.new_options (user_options, get_user_context_options())

	fun get_options () =
	  ShellTypes.new_options (user_options, user_context)

        fun print_fn print_options (label, typed_value) =
	  label ^ ": "
	  ^ ShellUtils.print_value
	      (typed_value,print_options,get_current_context())

        local
          val new_user_options = UserOptions.copy_user_tool_options user_options

          fun make_compiler_options () =
              UserOptions.new_options (new_user_options,
                                       get_user_context_options())

          val UserOptions.USER_TOOL_OPTIONS(r,_) = new_user_options

          val _ =
	    ( #show_fn_details(r) := false;
	      #show_exn_details(r) := false;
	      #maximum_depth(r) := 2;
	      #maximum_ref_depth(r) := 1;
	      #maximum_str_depth(r) := 1;
	      #maximum_sig_depth(r) := 1;
	      #maximum_string_size(r) := 1;
	      #maximum_seq_size(r) := 10
	    )

          val normal_compiler_options = make_compiler_options ()

          val graph_string_size = 5

          val _ = (#maximum_string_size(r) := graph_string_size)

          val graph_label_string_options = make_compiler_options ()

          val compiler_options = ref(normal_compiler_options)
          
          val string_abbreviation    = InspectorValues.string_abbreviation
          val normal_string_ellipsis  = !string_abbreviation
          val graph_label_string_ellipsis   = " .."

          fun set_string_abbrev () =
              string_abbreviation := graph_label_string_ellipsis

          fun reset_string_abbrev () =
              string_abbreviation := normal_string_ellipsis

          fun set_print_string_size (ty) =
              if InspectorValues.is_string_type ty
	      then  compiler_options := graph_label_string_options
              else  compiler_options := normal_compiler_options

          fun print_options (Options.OPTIONS{print_options,...})
            = print_options

        in
          
          fun graph_print_value (typed_value as (_,ty)) =
              ( set_print_string_size(ty);
                set_string_abbrev();
		unwind_protect
                   (fn () =>
                       ShellUtils.print_value
                         (typed_value,(print_options (!compiler_options)),
                                       get_current_context())
                   )
                   reset_string_abbrev
              )

          fun graph_print_type (_,ty) =
              ShellUtils.print_type
              (ty,!compiler_options,get_current_context())
        end

	val (initial_str, initial_item) = initial_item

        val current_root = ref initial_item   (* root of value *)
        val current_string = ref ""

        val select_fn = ref (fn () => ())

        val current_item_ref = ref NONE

        fun set_state (item as (value,ty)) =
          let
            val compiler_options = UserOptions.new_options 
                                      (user_options,get_user_context_options())
            val print_options = UserOptions.new_print_options user_options
            val context = get_current_context ()

            fun print_type ty =
              ShellUtils.print_type (ty,compiler_options,context)

            fun print_value value =
              ShellUtils.print_value (item,print_options,context)
            val value_string = print_value item
            val type_string = print_type ty
          in
	    Capi.Text.set_string (valText, value_string);
	    Capi.Text.set_string (typeText, type_string);
            current_string := value_string;
            current_item_ref := SOME (value_string,item)
          end

        fun eq ( (v,_), (v',_) ) =
          let
            fun cast x = (MLWorks.Internal.Value.cast x) : int ref
          in 
            cast v = cast v'
          end


        fun inspect_root (new_item) =
	    ( current_root := new_item;
	      set_state (new_item)
	    )

        (* Inspector Graph - Application State *)

        val hide_child_flag = ref false 
        fun hide_child(_) = !hide_child_flag

        local
          val GRAPH_OPTIONS {graph_type,show_atoms,show_strings,graph_sharing,graph_arity,
                             graph_depth,default_visibility,child_position,child_expansion,
                             show_root_children, indicateHiddenChildren, orientation,line_style,
                             horizontal_delta,vertical_delta,graph_origin,show_all} =
            options
        in
          val graph_type    =    ref graph_type (* VALUE *)
          val show_atoms    =    ref show_atoms (* true *)
          val show_strings  =    ref show_strings (* true *)
          val graph_sharing =    ref graph_sharing (* true *)
          val graph_arity   =    ref graph_arity (* 4 *)
          val graph_depth   =    ref graph_depth (* 5 *)
          val default_visibility = ref default_visibility (* false *)
          val gspec = {child_position = ref child_position,
                       child_expansion = ref child_expansion,
                       default_visibility = default_visibility,
                       show_root_children = ref show_root_children,
                       indicateHiddenChildren = ref indicateHiddenChildren,
                       orientation = ref orientation,
                       line_style = ref line_style,
                       horizontal_delta = ref horizontal_delta,
                       vertical_delta = ref vertical_delta,
                       graph_origin = ref graph_origin,
                       show_all = ref show_all
                       }
        end

        val graph_spec = GraphWidget.GRAPH_SPEC gspec

        fun make_options () =
          GRAPH_OPTIONS {graph_type = !graph_type,
                         show_atoms = !show_atoms,
                         show_strings = !show_strings,
                         graph_sharing = !graph_sharing,
                         graph_arity = !graph_arity,
                         graph_depth = ! graph_depth,
                         default_visibility = !default_visibility,
                         child_position = !(#child_position gspec),
                         child_expansion = !(#child_expansion gspec),
                         show_root_children = !(#show_root_children gspec),
                         indicateHiddenChildren = !(#indicateHiddenChildren gspec),
                         orientation = !(#orientation gspec),
                         line_style = !(#line_style gspec),
                         horizontal_delta = !(#horizontal_delta gspec),
                         vertical_delta = !(#vertical_delta gspec),
                         graph_origin = !(#graph_origin gspec),
                         show_all = !(#show_all gspec)
                         }

        datatype Item = ITEM of ((MLWorks.Internal.Value.T * Type) *
                                 bool ref *
                                 bool ref *
                                 (string * int * int * int) option ref
                                )
            (* Bundle up a node, abbrev. flag, plus
               some cached display information:-

	       ITEM( (v,ty), atomic, abbrev , extents )
		 - v = MLWorks value
		 - ty = MLWorks type
                 - atomic  = true when atomic value (used to control abbreaviation)
		 - abbrev  = true when graph limits are exceeded ...
		 - extents = cached screen extents data
             *)

        fun abbreviate   (ITEM(_,ref(atom),abbrev,_)) = abbrev := not atom
        fun unabbreviate (ITEM(_,_,abbrev,_)) = abbrev := false

        (* String used to signify node abbreviations in the graph *)
        val abbrev_string = " *** "

        fun massage_graph (root,get_children,eq) =
          let
            (* Build list of items *)
            fun list_items init_depth root =
              let
                val items = ref []  (* lists of triples - (depth,node,children) *)

                fun add (depth,node) =
                  if do_abbreviations andalso (depth > !graph_depth) 
                    then ( abbreviate(node); true ) 
                  else
                    let
                      fun lookup (node,[]) = true
                        | lookup (node,(_,a,_)::b) =
                          if eq (node,a) then false
                          else lookup (node,b)
                    in
                      lookup (node,!items)
                    end

                fun scan (item as (depth,node)) =
                    if add item
                    then let val children = get_children item
                         in
			     items := (depth,node,children) :: !items;
		             app scan children
                         end
                    else ()

              in
                scan (init_depth,root);
                rev(!items)
              end

            (* Index the items and return the graph's list of nodes *)
            fun transform_items itemlist =
              let
                exception Index

                fun index' (node,[],n) = raise Index
                  | index' (node,(_,node',_)::rest,n) =
                    if eq(node,node') then n
                    else index' (node,rest,n+1)

                fun index (_,node) = index' (node,itemlist,0)
              in
                MLWorks.Internal.Array.arrayoflist
                (map 
                 (fn (item as (_,node,children)) => (node,map index children))
                 itemlist)
              end

            val itemlist = list_items 0 root

            val nodes = transform_items itemlist
          in

            nodes

          end

        fun make_graph root =
          let
            fun get_children (depth,ITEM (item,_,ref false,_)) = 
		let
                  val new_depth = depth + 1

                  val not_show_atoms   = not(!show_atoms)
                  val not_show_strings = not(!show_strings)

		  fun is_atomic (x as (v,ty)) =
		      ( InspectorValues.is_scalar_value x
			orelse
			( not_show_strings
                          andalso
			  InspectorValues.is_string_type ty
			)
		      )

                  fun new_item(x,abbrev) =
		      ITEM (x,ref(is_atomic x),ref abbrev,ref NONE)

                  fun push_scan (abbrev_flag, x, acc) =
		      if not_show_atoms andalso (is_atomic x) 
		      then acc
		      else (new_depth,new_item(x,abbrev_flag)):: acc

		  fun scan (_,[],acc) = rev acc
		    | scan (n,(_,x)::rest,acc) =
                      let val abbrev = do_abbreviations andalso (n < 0)
			  val new_acc = push_scan(abbrev,x,acc)
                          val rest'  = if abbrev then [] else rest 
                      in
                          scan (n-1,rest',new_acc)
                      end

                  val inspect_items =
                      InspectorValues.get_inspector_values 
                                 (get_compiler_options()) debugger_print item
		in
		  scan (!graph_arity,inspect_items,[])
		end
              | get_children(_,_) = []

            val cast : 'a -> int ref = MLWorks.Internal.Value.cast

            (* This identifies pointer-equal objects *)
            fun equal_values (ITEM ((v1,ty1),_,_,_), ITEM ((v2,ty2),_,_,_)) =
                cast v1 = cast v2 andalso InspectorValues.type_eq (ty1,ty2)

            (* This function only identifies values that are of reference type *)
            (* r1 and r2 are internal identifiers *)
            fun equal_items (ITEM((v1,ty1),_,r1,_), ITEM((v2,ty2),_,r2,_)) = 
              if InspectorValues.is_ref_type ty1 andalso 
                InspectorValues.is_ref_type ty2
                then cast v1 = cast v2
              else r1 = r2

            val equality_fn = if !graph_sharing then equal_values else equal_items

            val root_item = ITEM (root,ref false,ref false,ref NONE)
            val items = massage_graph (root_item, get_children, equality_fn)
          in
            (items,[0])
          end

        fun make_value_graph () = make_graph (!current_root)

        fun item_string (gp,item,abbrev) =
            if abbrev then abbrev_string else
            case !graph_type of
              VALUE => graph_print_value (item)
            | TYPE  => graph_print_type (item)

        fun get_item_data (ITEM (item,_,ref(abbrev),extents),gp) =
          case !extents of
            SOME data => data
          | _ =>
              let
                val s = item_string  (gp,item,abbrev)
                val {font_ascent,font_descent,width,...} =
                          Capi.GraphicsPorts.text_extent (gp,s)
                val data = (s,font_ascent,font_descent,width)
              in
                extents := SOME data;
                data
              end

        val baseline_height = 3

        val surround = 3
        val topleft_width = 1
        val bottomright_width = 3

	val topleft_w      = surround + topleft_width
	val bottomright_w  = surround + bottomright_width
        val tot_w          = topleft_w + bottomright_w
	val bgnd_w         = topleft_width + bottomright_width

	fun item_draw_item (item,selected,gp,Capi.POINT{x,y}) =
	    let
	      val (s,font_ascent,font_descent,width) = get_item_data (item,gp)
	      val left = width div 2
	      val right = width - left

	      val new_x = x - (left+1+topleft_w)
	      val new_y = y - (font_ascent+1+topleft_w)
	      val new_width = (width+tot_w)
	      val new_height = (font_ascent+font_descent+tot_w)

	      val backgnd_region =
		  Capi.REGION {x = new_x, y = new_y,
			       width= new_width, height= new_height}

	      val foregnd_region =
		  Capi.REGION {x = new_x+topleft_width, y = new_y+topleft_width,
			       width= new_width-bgnd_w, height= new_height-bgnd_w}

	      val new_point = Capi.POINT{x=x - left,y=y}
            in
              Capi.GraphicsPorts.draw_rectangle (gp,foregnd_region);
              if selected then
                Capi.GraphicsPorts.with_highlighting
                (gp,Capi.GraphicsPorts.draw_image_string, (gp,s,new_point))
              else Capi.GraphicsPorts.draw_image_string (gp,s,new_point)
	    end

	fun item_extent (item,gp) =
	    let
	      val (s,font_ascent,font_descent,width) = get_item_data (item,gp)
	      val left = width div 2
	      val right = width - left
	    in
	      GraphWidget.EXTENT {
		 left  = left+topleft_w+1,
		 right = right+bottomright_w,
		 up    = font_ascent+topleft_w,
		 down  = font_descent+bottomright_w
              }
	    end

        val {widget=graph_window,
             initialize=init_graph,
             update=update_graph,
             popup_menu=graph_menu,
             set_position,
             set_button_actions,...} = 
          GraphWidget.make ("inspectorGraph","InspectorGraph",title,frame,
                            graph_spec,make_value_graph,
                            item_draw_item,item_extent)

        val new_root_item = ref NONE

        fun graph_select_fn (item as ITEM (entry,_,ref(abbrev),_),reg) =
            if abbrev then 
              new_root_item := SOME(entry)

                 (* This is some (necessary) jiggery-pokery to _postpone_
                    the graph update needed for setting a new root until
		    after the reset of the selection function (internal to the
		    graph widget) has run (because of highlighting).

		    The rest of the required computation is in the
		    function `try_set_new_root()' 
                 *)
            else
	      set_state (entry)

         fun try_set_new_root () =
	     case !new_root_item of
	       SOME(entry) =>
		 ( new_root_item := NONE;
		   inspect_root(entry);
		   update_graph()
		 )
	     | _ => ()

        fun initialize_graph () = init_graph graph_select_fn

        val insp_item_menu_spec = 
            [ Menus.OPTLABEL "Content",
              Menus.OPTRADIO
                 [ GuiUtils.toggle_value("content_value",graph_type,VALUE),
		   GuiUtils.toggle_value("content_type",graph_type,TYPE)
		 ],
              Menus.OPTSEPARATOR,
	      GuiUtils.bool_value("show_all", (#show_all gspec)),
	      GuiUtils.bool_value("show_atoms",show_atoms),
(* Commented out for the moment: ineffective due to repn.
	      GuiUtils.bool_value("show_strings",show_strings),
*)
              GuiUtils.bool_value("graph_sharing",graph_sharing)] @
            (if do_abbreviations
               then  [Menus.OPTSEPARATOR,
                      GuiUtils.int_value("graph_arity",graph_arity),
                      GuiUtils.int_value("graph_depth",graph_depth)]
             else [])

        val insp_item_popup =
            #1 (Menus.create_dialog
	           (shell, title ^ ": Display Controls","inspectorItemMenu",
                    update_graph, insp_item_menu_spec
                   )
               )

        local
           fun left_action (pa,_) =
               ( ignore(pa ()); try_set_new_root () )

           fun middle_action (_)  = insp_item_popup ()

           fun set_hide_flag ()   = (hide_child_flag := true)
           fun reset_hide_flag () = (hide_child_flag := false)

           fun right_action (pa,_) =
	       ( set_hide_flag (); unwind_protect pa reset_hide_flag )
        in
           val _ = set_button_actions
                      { left = left_action,
		        middle = middle_action,
			right = right_action }
        end

        val quit_funs = ref [fn () => Capi.remove_main_window shell];

        fun do_quit_funs _ = 
          ((* debug_output "Doing destroy actions"; *)
           app (fn f => f ()) (!quit_funs);
           destroy_fun())

        fun set_root (item) =
	    ( current_root := item;
	      set_state (item);
	      update_graph()
	    )
    
        fun set_previous_roots (item,l) =
            ( set_root (item)
            )
    
        val valTitleLabel = 
          Capi.make_managed_widget ("valTitleLabel",Capi.Label,frame,[])
        val typeTitleLabel = 
          Capi.make_managed_widget ("typeTitleLabel",Capi.Label,frame,[])
        val graphLabel = 
          Capi.make_managed_widget ("graphLabel",Capi.Label,frame,[])
        val srcTitleLabel =
	  Capi.make_managed_widget ("srcTitleLabel", Capi.Label, frame, [])

        fun first_line (message) =
          let
            fun aux ([],_) = message
              | aux ((#"\n" :: _),acc) = implode (rev acc)
              | aux ((a::b),acc) = aux (b,a::acc)
          in
            aux (explode message,[])
          end

      fun select_fn item =
	case ShellUtils.value_from_history_entry (item, get_options ()) of
          SOME (s, v) =>
            (Capi.Text.set_string (srcText, s);
             inspect_root (v);
             update_graph ())
        |  _ => ()

      fun mk_tooldata () =
        ToolData.TOOLDATA
        {args = ShellTypes.LISTENER_ARGS
         {user_options = user_options,
          user_preferences = user_preferences,
          user_context =
          GuiUtils.get_user_context (!local_context),
          prompter = prompter,
          mk_xinterface_fn = mk_xinterface_fn},
         current_context = current_context,
         appdata = appdata,
         motif_context = !local_context,
         tools = tools}

        fun duplicate value =
          (ignore(make_inspector_window
	     (value, make_options(), NONE, debugger_print,
	      parent, mk_tooldata(), fn _ => ()));
           ())

	val sep_size = 10

        fun close_window _ =
          (do_quit_funs ();
           Capi.destroy shell)

        fun storeSizePos () = 
	  (sizeRef := SOME (Capi.widget_size shell);
	   posRef := SOME (Capi.widget_pos shell))

        fun caller_update _ = 
	  if isSome (!current_item_ref) then 
	    set_state (#2 (valOf (!current_item_ref)))
	  else
	    ()

        val view_menu =
          GuiUtils.view_options
            {parent = shell, title = title, user_options = user_options,
	     user_preferences = user_preferences,
             caller_update_fn = caller_update,
	     view_type = [GuiUtils.VALUE_PRINTER]}

        fun get_value () = !current_item_ref
          
	val value_menu = 
	  GuiUtils.value_menu
	     {parent = shell,
	      user_preferences = user_preferences,
	      inspect_fn = NONE,
	      get_value = get_value,
	      enabled = true,
	      tail = []}
	val values = ToolData.extract value_menu
	val view = ToolData.extract view_menu 

	fun get_user_context () = GuiUtils.get_user_context (!local_context)

	val menuSpec =
	  [ToolData.file_menu [("save", fn _ =>
		       GuiUtils.save_history (false, get_user_context (), shell),
		     fn _ =>
		       not (UserContext.null_history (get_user_context ()))
		       andalso UserContext.saved_name_set (get_user_context ())),
	    ("saveAs", fn _ => GuiUtils.save_history
			     (true, get_user_context (), shell),
		       fn _ => not (UserContext.null_history (get_user_context ()))),
	    ("close", close_window, fn _ => true)],
           ToolData.edit_menu
           (shell,
            {cut = NONE,
             paste = NONE,
             copy = SOME (fn _ => Capi.clipboard_set (shell,!current_string)),
             delete = NONE,
	     edit_possible = fn _ => false,
             selection_made = fn _ => !current_string <> "",
	     delete_all = NONE,
	     edit_source = [value_menu]}),
           (* Need a better interface here -- what is the currently selected object? *)

	   ToolData.tools_menu (mk_tooldata, 
				fn () => GuiUtils.get_user_context (!local_context)),
	   ToolData.usage_menu (values @ view @
	     [("duplicate", 
		fn _ => case get_value () of SOME x => duplicate x | _ => (),
                fn _ => case get_value () of SOME x => true | _ => false),
	      ("graph", graph_menu, fn _ => true),
	      ("insp_item", insp_item_popup, fn _ => true)],
	     [("autoSelection",
	       fn _ => !do_automatic,
               fn b => do_automatic := b,
               fn _ => case select_auto of NONE => false | _ => true)]),
	   ToolData.debug_menu values]
      in
        quit_funs := Menus.quit :: (!quit_funs);
        quit_funs := storeSizePos :: (!quit_funs);
	Menus.make_submenus (menuBar, menuSpec);
        Capi.Layout.lay_out
        (frame, !sizeRef,
         [Capi.Layout.MENUBAR menuBar,
          Capi.Layout.SPACE,
          Capi.Layout.FIXED srcTitleLabel,
          Capi.Layout.FIXED srcText,
          Capi.Layout.FIXED valTitleLabel,
          Capi.Layout.FIXED valText,
          Capi.Layout.FIXED typeTitleLabel,
          Capi.Layout.FIXED typeText,
          Capi.Layout.FIXED graphLabel,
          Capi.Layout.FLEX  graph_window,
          Capi.Layout.SPACE]);
        Capi.Text.set_string (srcText, initial_str);
        Capi.Callback.add (frame, Capi.Callback.Destroy, do_quit_funs);
	inspect_root (!current_root);
        Capi.reveal frame;
        initialize_graph ();
        fn (auto,str,item) => 
          if auto andalso not (!do_automatic) then
	    ()
          else
            (inspect_root (item);
             update_graph ();
	     Capi.reveal shell;    (* Required for MSWindows to bring up the shell again *)
	     Capi.reveal frame;    (* Required for unix since frame needs to be managed 
				    * AFTER the shell. *)
             Capi.Text.set_string (srcText,str);
	     if auto then
	       ()
	     else
               Capi.to_front shell)
      end

    local
      val display_fun = ref NONE
      fun destroy_fun _ = display_fun := NONE
    in
      fun inspect_value (parent,debugger_print,tooldata) = 
        fn auto =>
        fn (str,v) =>
        case !display_fun of 
          SOME f => f (auto,str,v)
        | _ =>
            if auto then ()
            else
              let
                val f =
		  make_inspector_window
		    ((str,v), default_options, SOME false,
		     debugger_print, parent, tooldata, destroy_fun)
              in
                display_fun := SOME f
              end
    end

  end
