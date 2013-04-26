(*
 * Copyright (c) 1993 Harlequin Ltd.
 *  $Log: _browser_tool.sml,v $
 *  Revision 1.59  1998/03/31 15:15:52  johnh
 *  [Bug #30346]
 *  Call Capi.getNextWindowPos.
 *
 * Revision 1.58  1998/03/16  10:59:10  mitchell
 * [Bug #50061]
 * Fix tools so they restart in a saved image
 *
 * Revision 1.57  1998/02/13  15:57:54  johnh
 * [Bug #30344]
 * Allow windows to retain size and position.
 *
 * Revision 1.56  1998/01/27  15:58:40  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.55.2.2  1997/11/20  17:02:32  johnh
 * [Bug #30071]
 * Remove Paths menu.
 *
 * Revision 1.55.2.1  1997/09/11  20:52:25  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.55  1997/09/05  09:49:58  johnh
 * [Bug #30241]
 * Implement proper find dialog.
 *
 * Revision 1.54  1997/08/06  14:58:09  brucem
 * [Bug #30224]
 * Add search facility.
 * (And change `selection' from text entry box to a text label).
 *
 * Revision 1.53  1997/06/12  15:02:57  johnh
 * [Bug #30175]
 * Combine tools and windows menus.
 *
 * Revision 1.52  1997/06/11  12:34:13  johnh
 * [Bug #30075]
 * Duplicating tool by cloning only.
 *
 * Revision 1.51  1997/05/16  15:35:23  johnh
 * Implementing single menu bar on Windows.
 * Re-organising menus for Motif.
 *
 * Revision 1.50  1997/05/06  09:33:01  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.49  1997/03/19  13:18:22  matthew
 * Removing debugger argument from eval.
 *
 * Revision 1.48  1996/11/06  11:15:37  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.47  1996/11/01  10:19:48  johnh
 * Enabling close from control box on top left of window.
 *
 * Revision 1.46  1996/08/09  15:25:45  nickb
 * Option dialog setter functions now return accept/reject.
 *
 * Revision 1.45  1996/08/07  11:45:12  andreww
 * [Bug #1521]
 * propagating changes to typechecker/_types.sml
 *
 * Revision 1.44  1996/06/11  11:20:28  matthew
 * Removing call to reposition function as this is no longer used.
 *
 * Revision 1.43  1996/05/28  14:26:00  matthew
 * Changed GraphWidget.make
 *
 * Revision 1.42  1996/05/28  09:35:22  daveb
 * Removed unused debugging code (that referenced MLWorks.RawIO).
 *
 * Revision 1.41  1996/05/24  14:04:09  daveb
 * Changes in Graph controls.
 *
 * Revision 1.40  1996/05/14  14:07:08  daveb
 * Added File menu.
 *
 * Revision 1.39  1996/05/10  14:45:05  daveb
 * Added edit_possible field to ToolData.edit_menu.
 *
 * Revision 1.38  1996/05/07  11:48:07  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.37  1996/04/30  10:03:36  matthew
 * Replacing MLWorks.Integer with basis file
 *
 * Revision 1.36  1996/04/17  12:54:14  nickb
 * Pervasive browser title numbers are knackered.
 *
 * Revision 1.35  1996/04/04  11:14:33  matthew
 * Changing graph interface
 *
 * Revision 1.34  1996/02/08  11:28:31  daveb
 * UserContext.add_update_function now expects update functions that take
 * a list of history entries.
 * Removed the sensitivity type.
 *
 * Revision 1.33  1996/01/25  13:15:26  matthew
 * Changed interface to graph widget
 *
 * Revision 1.32  1996/01/23  15:30:00  daveb
 * Type of GuiUtils.value_menu has changed.
 *
 * Revision 1.31  1996/01/22  16:35:08  matthew
 * Using Info.null_options in call to eval
 *
 * Revision 1.30  1996/01/19  11:41:04  matthew
 * Changing inspector interface.
 *
 * Revision 1.29  1996/01/17  16:12:19  matthew
 * Reordering top level menus.
 *
 * Revision 1.28  1996/01/09  16:25:41  matthew
 * Make pervasive and non-pervasive browsers have different titles.
 *
 * Revision 1.27  1995/12/07  14:31:07  matthew
 * Changing interface to edit_menu
 *
 * Revision 1.26  1995/11/16  16:46:44  matthew
 * Changin layout parameters
 *
 * Revision 1.25  1995/11/16  13:52:11  matthew
 * Changing button resources
 *
 * Revision 1.24  1995/11/15  17:01:40  matthew
 * Adding windows menu
 *
 * Revision 1.23  1995/10/26  10:43:06  daveb
 * Removed context menu, because the search tool wasn't linked to anything.
 *
 * Revision 1.22  1995/10/24  16:53:52  daveb
 * Browser now recognises updates to the context.
 *
 * Revision 1.21  1995/10/15  14:23:51  brianm
 * Made modifications due to introduction of GraphWidget.Extent etc.
 *
 * Revision 1.20  1995/10/10  16:04:58  brianm
 * Modifications due to changes in GraphSpec.
 *
 * Revision 1.19  1995/10/09  11:39:40  daveb
 * Now that we have hidden contexts from the user, the pervasive browser has
 * to be treated somewhat specially.
 *
 * Revision 1.18  1995/10/08  21:50:48  brianm
 * Updates to allow for changed graph widget repositioning interface.
 *
 * Revision 1.17  1995/10/06  12:33:40  brianm
 * Modification to take account of change to graph_widget change and moved
 * graph selection stuff from here to graph_widget ...
 *
 * Revision 1.16  1995/10/05  17:20:52  brianm
 * Adding graphical selection repositioning ...
 *
 * Revision 1.15  1995/10/05  12:51:17  daveb
 * Type of context_menu has changed.
 *
 * Revision 1.14  1995/10/02  15:38:50  brianm
 * Removing the list pane component and associated parts (e.g. history).
 *
 * Revision 1.13  1995/10/02  12:14:43  brianm
 * Adding update of list entry by graph selection ...
 *
 * Revision 1.12  1995/09/18  14:33:23  brianm
 * Updating by adding Capi Point/Region datatypes
 *
 * Revision 1.11  1995/09/11  13:18:54  matthew
 * Changing top level window initialization
 *
 * Revision 1.10  1995/09/07  13:45:55  matthew
 * Extending GraphSpec type
 *
 * Revision 1.9  1995/09/06  15:19:07  matthew
 * Changing for new graph interface
 *
 * Revision 1.8  1995/08/31  12:02:51  matthew
 * Correcting typo
 *
 * Revision 1.7  1995/08/31  11:57:07  matthew
 * Renaming layout constructors
 *
 * Revision 1.6  1995/08/15  14:52:47  matthew
 * Adding some stuff into the menubar
 *
 * Revision 1.5  1995/08/10  12:12:43  matthew
 * Adding make_buttons function to capi
 *
 * Revision 1.4  1995/08/03  09:50:38  matthew
 * Improvements to graphs
 *
 * Revision 1.3  1995/07/27  10:55:16  matthew
 * Moved capi etc. to gui
 *
 * Revision 1.1  1995/07/26  14:42:29  matthew
 * new unit
 * New unit
 *
 *  Revision 1.63  1995/07/26  13:20:39  matthew
 *  Adding support for font dimensions etc.
 *
 *  Revision 1.62  1995/07/20  16:17:04  matthew
 *  Adding scroll_to functions
 *
 *  Revision 1.61  1995/07/17  11:47:52  matthew
 *  Graphics functions abstraction
 *
 *  Revision 1.60  1995/07/14  16:49:34  io
 *  add searching, offload bits to entry for listener use.
 *
 *  Revision 1.59  1995/07/07  15:42:54  daveb
 *  Minor changes to layout.
 *
 *  Revision 1.58  1995/07/04  14:01:27  matthew
 *  Adding graphing functionality
 *
 *  Revision 1.57  1995/06/13  14:19:55  daveb
 *  Made value constructors be displayed with the "con" pseudo-keyword.
 *
 *  Revision 1.56  1995/06/01  10:31:22  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.55  1995/05/22  14:42:00  daveb
 *  Made contexts only visible if full_menus set.
 *
 *  Revision 1.54  1995/05/22  09:54:00  daveb
 *  Added create_initial.
 *
 *  Revision 1.53  1995/05/04  09:51:33  matthew
 *  Changing createPopupShell to create
 *
 *  Revision 1.52  1995/04/28  16:56:05  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.51  1995/04/19  11:57:11  daveb
 *  A new tool is now passed the right user context.
 *
 *  Revision 1.49  1995/04/06  12:35:32  matthew
 *  Replacing Tyfun_id etc. with Stamp
 *
 *  Revision 1.48  1995/03/31  16:52:58  daveb
 *  Added the history number to items in the history.
 *
 *  Revision 1.47  1995/03/31  08:55:32  daveb
 *  Empty lists are now handled automatically by GuiUtils.make_scrolllist.
 *
 *  Revision 1.46  1995/03/17  11:28:26  daveb
 *  Merged ShellTypes.get_context_name and ShellTypes.string_context_name.
 *
 *  Revision 1.45  1995/03/16  11:46:58  daveb
 *  Removed context_function from register when closing the window.
 *
 *  Revision 1.44  1995/03/15  16:41:09  daveb
 *  Changed to share current context with other tools..
 *
 *  Revision 1.43  1995/03/10  15:44:13  daveb
 *  Registered select function with current context.
 *  Also simplified manipulation of pathStack slightly - no need to store
 *  toplevel items on the stack, as they're always calculated anew.
 *
 *  Revision 1.42  1995/03/02  13:30:32  matthew
 *  Parser and Lexer revisions
 *
 *  Revision 1.41  1995/02/24  16:51:19  daveb
 *  Moved parent and toplevel buttons from the history menu to the main window.
 *
 *  Revision 1.40  1995/02/24  15:29:32  daveb
 *  Added View menu and Filter dialog box.  Made empty structures display
 *  the word "<empty">.
 *
 *  Revision 1.39  1994/11/30  16:26:17  daveb
 *  Simplified Form constraints.
 *
 *  Revision 1.38  1994/09/21  16:19:16  brianm
 *  Adding value menu ...
 *
 *  Revision 1.37  1994/08/09  17:02:24  daveb
 *  Fixed bugs with toplevel command and update behaviour.
 *
 *  Revision 1.36  1994/07/19  08:34:25  daveb
 *  Added automatic updates.
 *
 *  Revision 1.35  1994/07/12  16:04:16  daveb
 *  ToolData.works_menu now takes different arguments.
 *
 *  Revision 1.34  1994/06/20  15:25:19  daveb
 *  Changed context refs to user_contexts.
 *
 *  Revision 1.33  1994/05/05  16:37:05  daveb
 *  Overloaded schemes now include the type variable being overloaded.
 *
 *  Revision 1.32  1994/02/22  00:44:22  nosa
 *  TYCON' for type function functions in lambda code for Modules Debugger;
 *  Extra TYNAME valenv for Modules Debugger.
 *
 *  Revision 1.31  1993/12/15  15:35:12  matthew
 *  Added level field to Basis.
 *
 *  Revision 1.30  1993/12/10  15:34:44  daveb
 *  Added context menu, ensured that changes do the right thing, ensured that
 *  new selection is passed on to child tools.
 *
 *  Revision 1.29  1993/12/09  19:34:19  jont
 *  Added copyright message
 *
 *  Revision 1.28  1993/11/30  14:07:23  matthew
 *  Added is_abs field to TYNAME and METATYNAME
 *
 *  Revision 1.27  1993/11/25  14:25:31  daveb
 *  Changed the way constructors are displayed, so that selecting and pasting
 *  them makes sense.  This involved making two factors orthogonal: namely
 *  whether a component is the last component on a path and whether it has
 *  any entries (a datatype satisfies both of these conditions).
 *
 *  Revision 1.26  1993/10/22  16:59:01  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.25  1993/10/08  16:28:40  matthew
 *  Merging in bug fixes
 *
 *  Revision 1.24  1993/09/16  16:06:03  nosa
 *  Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.
 *
 *  Revision 1.23.1.3  1993/10/21  14:03:54  daveb
 *  Changed ToolData.works_menu to take a (unit -> bool) function that
 *  controls whether the Close menu option is enabled.
 *
 *  Revision 1.23.1.2  1993/10/07  15:43:12  matthew
 *  Uses history utilities in ShellUtils
 *
 *  Revision 1.23.1.1  1993/08/11  11:05:10  jont
 *  Fork for bug fixing
 *
 *  Revision 1.23  1993/08/11  11:05:10  matthew
 *  Get update function from options_menu and put in user_options
 *  Removed preferences menu
 *
 *  Revision 1.22  1993/08/10  10:27:23  matthew
 *  Get maximum history length from options
 *
 *  Revision 1.21  1993/07/30  13:57:37  nosa
 *  Changed type of constructor NULL_TYFUN for value printing in
 *  local and closure variable inspection in the debugger.
 *
 *  Revision 1.20  1993/06/30  16:47:56  daveb
 *  Removed exception environments.
 *
 *  Revision 1.19  1993/05/18  19:05:42  jont
 *  Removed integer parameter
 *
 *  Revision 1.18  1993/05/14  14:27:42  daveb
 *  Changed names of history menu buttons.
 *
 *  Revision 1.17  1993/05/13  12:48:19  daveb
 *  All tools now set their own titles and pass them to their options menus.
 *
 *  Revision 1.16  1993/05/12  16:25:33  daveb
 *  Added pop_history command.
 *
 *  Revision 1.15  1993/05/12  15:38:16  daveb
 *  Added previous fix to update function as well.
 *
 *  Revision 1.14  1993/05/12  15:32:14  daveb
 *  Fixed bug in display of current selection.  Set max history to sensible
 *  number.
 *
 *  Revision 1.13  1993/05/11  15:58:12  matthew
 *  Change to layout resources
 *
 *  Revision 1.12  1993/05/05  12:10:17  daveb
 *  Added tools argument to works_menu(),
 *  removed exitApplication from TOOLDATA (works_menu now accesses it directly).
 *
 *  Revision 1.11  1993/05/04  17:24:52  matthew
 *  Added label with context name
 *  Changed context ref handling
 *
 *  Revision 1.10  1993/05/04  15:19:51  daveb
 *  Removed duplicates from history and restricted history length.
 *  Added selected values (etc.) to the selection display.
 *
 *  Revision 1.9  1993/04/30  14:45:58  daveb
 *  Reorganised menus.
 *
 *  Revision 1.8  1993/04/29  13:49:09  daveb
 *  Added dynamic history and update facility.
 *  Corrected reversed ordering of variables and exceptions.
 *
 *  Revision 1.7  1993/04/28  15:09:55  daveb
 *  Added selection text widget and improved the layout.
 *
 *  Revision 1.6  1993/04/28  10:39:02  daveb
 *  Changes to make_scrolllist.
 *
 *  Revision 1.5  1993/04/27  11:21:25  daveb
 *  Fixed printing of exceptions.  Filtered out value constructors from list.
 *
 *  Revision 1.4  1993/04/26  18:53:45  daveb
 *  Fixed printing of type variables.
 *
 *  Revision 1.3  1993/04/22  08:49:55  daveb
 *  Removed now spurious reference to Valenv.Options.  That version of valenv
 *  was never checked in, as it turned out not to be needed.
 *
 *  Revision 1.2  1993/04/21  16:34:34  daveb
 *  Now browses datatypes, and ignores types and vals.
 *
 *  Revision 1.1  1993/04/21  14:15:43  daveb
 *  Initial revision
 *  
 *  
 *)

require "../basis/__int";

require "capi";
require "menus";
require "../utils/lists";
require "../main/user_options";
require "../main/preferences";
require "../utils/crash";
require "../interpreter/shell_utils";
require "../interpreter/save_image";
require "../interpreter/entry";
require "inspector_tool";
require "graph_widget";
require "gui_utils";
require "tooldata";
require "browser_tool";

functor BrowserTool (
  structure Capi : CAPI
  structure GraphWidget : GRAPH_WIDGET
  structure Crash : CRASH
  structure Lists : LISTS
  structure UserOptions : USER_OPTIONS
  structure Preferences : PREFERENCES
  structure Menus : MENUS
  structure InspectorTool : INSPECTORTOOL
  structure GuiUtils : GUI_UTILS
  structure ToolData : TOOL_DATA
  structure ShellUtils : SHELL_UTILS
  structure SaveImage : SAVE_IMAGE
  structure Entry : ENTRY

  sharing UserOptions.Options = 
	  ToolData.ShellTypes.Options =
          ShellUtils.Options
  sharing type Entry.options = UserOptions.Options.options
  sharing type ToolData.UserContext.identifier = Entry.Identifier
  sharing type UserOptions.user_tool_options =
	       ToolData.ShellTypes.user_options =
	       GuiUtils.user_tool_options = ShellUtils.UserOptions
  sharing type Menus.Widget = GuiUtils.Widget = ToolData.Widget = Capi.Widget =
               GraphWidget.Widget = InspectorTool.Widget
  sharing type Capi.GraphicsPorts.GraphicsPort = GraphWidget.GraphicsPort
  sharing type Menus.ButtonSpec = GuiUtils.ButtonSpec = ToolData.ButtonSpec
  sharing type ToolData.ShellTypes.Context =
               Entry.Context = ShellUtils.Context
  sharing type ToolData.ShellTypes.user_context = GuiUtils.user_context
  sharing type GuiUtils.user_context_options =
	       ToolData.UserContext.user_context_options = 
               UserOptions.user_context_options
  sharing type ShellUtils.user_preferences =
	       ToolData.ShellTypes.user_preferences =
	       Preferences.user_preferences =
	       GuiUtils.user_preferences
  sharing type GuiUtils.Type = ShellUtils.Type = InspectorTool.Type
  sharing type GuiUtils.MotifContext = ToolData.MotifContext
  sharing type GraphWidget.Point = Capi.Point
  sharing type GraphWidget.Region = Capi.Region
  sharing type InspectorTool.ToolData = ToolData.ToolData
) : BROWSERTOOL =
struct
    structure UserContext = ToolData.UserContext
    structure Options = UserOptions.Options
    structure Info = ShellUtils.Info
    structure ShellTypes = ToolData.ShellTypes

    type Widget = Capi.Widget
    type UserOptions = UserOptions.user_tool_options
    type ShellData = ShellTypes.ShellData
    type ToolData = ToolData.ToolData


    fun title () = "Browser"
    fun initial_title () = "System Browser"

    (* The following two references store whether these browsers are already created, 
     * and if so, the handle to the window is stored so that the window can be brought
     * to the front.
     *)
    val context_browser = ref NONE
    val system_browser = ref NONE

    (* These references store the number of the duplicated browsers. *)
    val context_number = ref 1
    val system_number = ref 1

    val sizeRef = ref NONE
    val posRef = ref NONE

    (* browser_ref is the option reference for storing the handle to the window, 
     * number_ref stores the number of the latest duplicated browser, and
     * the 'duplicated' boolean indicates whether the number should be included
     * in the title.  The original browsers (ie. those invoked from the tools menu)
     * do not include the number in the title.
     *)

    fun create_internal (browser_ref, number_ref, duplicated) (tooldata, orig_title) =
      let
        val ToolData.TOOLDATA {args,appdata,current_context,motif_context,tools} =
          tooldata
	val ShellTypes.LISTENER_ARGS
	      {user_options, user_preferences, user_context,
	       mk_xinterface_fn, prompter, ...} = args

	val ToolData.APPLICATIONDATA {applicationShell,...} =
	  appdata

	val full_menus =
	  case user_preferences
	  of Preferences.USER_PREFERENCES ({full_menus, ...}, _) =>
	    !full_menus

	val local_context = ref motif_context

	fun get_user_context () = GuiUtils.get_user_context (!local_context)

        fun get_user_context_options () =
	  UserContext.get_user_options
	    (GuiUtils.get_user_context (!local_context))

        fun get_compiler_options () =
          UserOptions.new_options (user_options, get_user_context_options())

	fun getItemsFromContext () = let
	  val context = UserContext.get_delta (get_user_context ())
	in
	  Entry.context2entry context
	end

        val title = 
	  if not duplicated then orig_title
	  else 
	    (number_ref := (!number_ref) + 1;
	     orig_title ^ " #" ^ (Int.toString (!number_ref - 1)))

        val (shell,frame,menuBar,contextLabel) =
          Capi.make_main_window 
		{name = "browser",
		 title = title,
		 parent = applicationShell,
		 contextLabel = full_menus, 
		 winMenu = duplicated,
		 pos = getOpt (!posRef, Capi.getNextWindowPos())}

	val listLabel = Capi.make_managed_widget ("listLabel",Capi.Label,frame,[])
	val selectionLabel =
          Capi.make_managed_widget ("selectionLabel",Capi.Label,frame,[])

	fun get_context () = UserContext.get_context (get_user_context ())

        fun set_context_label motif_context =
	  case contextLabel
	  of SOME w =>
            let
              val context_name =
	        GuiUtils.get_context_name motif_context

              val string = "Context: " ^ context_name
            in
              Capi.set_label_string (w,string)
            end
	  |  NONE => ()

	fun get_user_options () = user_options

	local 
          val browse_options = Entry.new_options ()
          val Entry.BROWSE_OPTIONS 
            {show_vars,
             show_cons,
             show_exns,
             show_types,
             show_strs,
             show_sigs,
             show_funs,
             show_conenvs} = browse_options
        in
	  val filter_entries = 
            Entry.filter_entries browse_options


	  fun getter r () = !r
	  fun setter r b = (r := b; true)
	  fun toggle (s,r) = Menus.OPTTOGGLE(s,getter r, setter r)
	      
	  val filter_spec =
	    [toggle ("show_sigs", show_sigs),
	     toggle ("show_funs", show_funs),
	     toggle ("show_strs", show_strs),
	     toggle ("show_types", show_types),
	     toggle ("show_conenvs", show_conenvs),
	     toggle ("show_exns", show_exns),
	     toggle ("show_cons", show_cons),
	     toggle ("show_vars", show_vars)]
	end (* local *)


        (* graph display *)

        datatype Node = ROOT | NODE of Entry.Entry

        fun print_node item =
          let
            val compilerOptions = get_compiler_options()
          in
            case item of
              ROOT => "Top Level"
            | NODE entry => Entry.printEntry compilerOptions entry
          end

        val baseline_height = 3
        fun max (x,y) = if x > y then x else y

        datatype Item = ITEM of Node * Node list * (string * int * int * int) option ref

        fun get_item_data (ITEM (entry,selection,extents),gp) =
          case !extents of
            SOME data => data
          | _ =>
              let
                val s = print_node entry
                val {font_ascent,font_descent,width,...} = Capi.GraphicsPorts.text_extent (gp,s)
                val data = (s,font_ascent,font_descent,width)
              in
                extents := SOME data;
                data
              end

        fun entry_draw_item (item,selected,gp,Capi.POINT{x,y}) =
          let
            val (s,font_ascent,font_descent,width) = get_item_data (item,gp)
            val left = width div 2
            val right = width - left
            fun doit () = 
              ((* Capi.GraphicsPorts.draw_fill_rectangle (gp,
                                                       x-left-1,
                                                       y-font_ascent-baseline_height-1,
                                                       left+right+4,
                                                       font_ascent + font_descent + 4); *)
               Capi.GraphicsPorts.draw_image_string
               (gp,s,Capi.POINT{x=x - left, y=y - baseline_height}))
          in
            if selected 
              then Capi.GraphicsPorts.with_highlighting (gp,doit, ())
            else doit ()
          end

        fun entry_extent (item,gp) =
          let
            val (s,font_ascent,font_descent,width) = get_item_data (item,gp)
            val left = width div 2
            val right = width - left
          in
            GraphWidget.EXTENT{
               left  = left,
               right = right+2,
               up    = baseline_height + font_ascent+1,
               down  = max (0,font_descent+3-baseline_height)
            }
          end
    
        fun make_context_graph () =
          let
            fun entryfun selection entry = ITEM (NODE entry,selection,ref NONE)
            fun top_entry entry = ITEM (NODE entry, [], ref NONE)
            fun toplevel_items () = map top_entry (filter_entries (getItemsFromContext ()))
            fun get_children (ITEM (ROOT,_,_)) = toplevel_items ()
              | get_children (ITEM (node as NODE entry,selection,_)) = 
                map (entryfun (node :: selection)) (filter_entries (Entry.browse_entry true entry))
            fun get_node (ITEM (node,_,_)) = node
            val nodes_ref = ref []
            val iref = ref 0
            fun do_node item =
              let
                val node = get_node item
                val children = get_children item
                val index = !iref
                val children_ref = ref []
                val _ = nodes_ref := (item,children_ref) :: !nodes_ref
                val _ = iref := 1 + !iref
                val children_ids = map do_node (get_children item)
              in
                children_ref := children_ids;
                index
              end
            val _ = do_node (ITEM (ROOT,[],ref NONE))
            val nodes =
              MLWorks.Internal.Array.arrayoflist
              (rev (map (fn (node,ref children) => (node,children)) (!nodes_ref)))
          in
            (nodes,[0])
          end

            
        val graph_spec =
          GraphWidget.GRAPH_SPEC {child_position = ref GraphWidget.BELOW,
                                  child_expansion = ref GraphWidget.TOGGLE,
                                  default_visibility = ref false,
				  show_root_children = ref true,
                                  indicateHiddenChildren = ref false,
                                  orientation = ref GraphWidget.HORIZONTAL,
                                  line_style = ref GraphWidget.STEP,
                                  horizontal_delta = ref 20,
                                  vertical_delta = ref 1,
				  graph_origin = ref (3,3),
                                  show_all = ref false}

        val {widget=graph_window,
             initialize=init_graph,
             update=update_graph,
             set_position, 
             initialiseSearch,
             ...} = 
         GraphWidget.make ("browserGraph","BrowserGraph",title,
                            frame,
                            graph_spec,
                            make_context_graph,
                            entry_draw_item,
                            entry_extent)


(*

        val {reposition_fn,
             h_position,
             v_position,
             h_offset,
	     v_offset,...
            } = GraphWidget.reposition_graph_selection(graph_window,set_position)

        (* Default values *)
        val _ = (h_position := GraphWidget.NONE;
                 v_position := GraphWidget.NONE;
                 h_offset := 20;
                 v_offset := 20)
*)

	val selectionStr = ref ""
        val selectionLength = ref 0
        val shortSelectionStr = ref "" (* this should be the type or val
                                          name, e.g. `option' rather than
                                          `Option.option'.  Also, no
                                          `<type>' postfix *)

        fun removePostfix s = (* change "array<type>" into "array" *)
          let
            fun f [] = []
              | f (#"<" :: t) = []
              | f (h::t) = h::(f t)
          in
            implode (f (explode s))
          end

        fun getShortName ROOT = ""
          | getShortName (NODE entry) = removePostfix (#1(Entry.get_id entry))

        val do_select_fn = ref (fn () => ())

        fun graph_select_fn (item as ITEM (node,selection,_),reg) =
          let
            fun node_string (ROOT) = "ROOT"
              | node_string (NODE entry) = #1 (Entry.get_id entry)
            fun printit (node,[]) = node_string node
              | printit (node,node'::selection) =
                case node' of
                  ROOT => printit (node,selection)
                | NODE(entry) =>
                    if Entry.is_tip(entry)
		    then printit(node,selection)
		    else node_string node' ^ "." ^ printit (node,selection)
            val string = printit (node,rev selection)
            val shortString = getShortName node
          in
(*
            reposition_fn(reg);
*)
            (*Capi.Text.replace (selectionText, 0, !selectionLength, string);*)
            Capi.set_label_string (selectionLabel, "Selection: "^string);
            (*reset_selectionText();*)
            selectionLength := size string;
            selectionStr := string;
            shortSelectionStr := shortString;
            (* For the inspector *)
            (!do_select_fn) ()
          end

        fun initialize_graph () = init_graph graph_select_fn

	val filter_popup =
          #1 (Menus.create_dialog
	      (shell, "Browser Settings", "browserDialog",
	       update_graph, filter_spec))

	val quit_funs = ref []
	  
	fun do_quit_funs _ = Lists.iterate (fn f => f ()) (!quit_funs)

        val update_register_key =
          ref (UserContext.add_update_fn
		 (get_user_context (), fn _ => update_graph ()))

        fun with_no_context browser_ref f arg1 arg2 =
            let 
              val browser = !browser_ref
              val user_context = GuiUtils.get_user_context (!local_context)
            in
              browser_ref := NONE;
              UserContext.remove_update_fn
                (user_context, !update_register_key);
              ignore(f arg1 arg2 
                     handle exn => (browser_ref := browser; 
                                    update_register_key :=
                                      UserContext.add_update_fn
                                        (user_context, fn _ => update_graph ());
                                    raise exn));
              browser_ref := browser;
              update_register_key :=
                UserContext.add_update_fn
                  (user_context, fn _ => update_graph ())
            end

	fun set_context c =
	  let
	    val old_user_context = GuiUtils.get_user_context (!local_context)
	    val new_user_context = GuiUtils.get_user_context c
	  in
	    local_context := c;
	    set_context_label c;
            UserContext.remove_update_fn
              (old_user_context, !update_register_key);

            update_register_key :=
              UserContext.add_update_fn
		(new_user_context, fn _ => update_graph ());
            update_graph ()
	  end
  
	val context_key =
	  ToolData.add_context_fn
	  (current_context, (set_context, get_user_options, ToolData.ALL))
	  
	val _ =
	  quit_funs :=
	  (fn _ =>
	   let
	     val user_context = GuiUtils.get_user_context (!local_context)
	   in
	     ToolData.remove_context_fn
	       (current_context, context_key);
             UserContext.remove_update_fn
               (user_context, !update_register_key)
	   end)
	  :: (fn _ => (browser_ref := NONE))
	  :: !quit_funs

        fun select_context user_context =
          (set_context user_context;
           ToolData.set_current
	   (current_context, context_key, user_options, user_context))

        fun close_window _ =
          (do_quit_funs ();
           Capi.destroy shell)

        fun mk_tooldata () =
	  let
	    val user_options = UserOptions.copy_user_tool_options user_options
	  in
            case user_options
            of UserOptions.USER_TOOL_OPTIONS
                 ({set_selection, sense_selection, set_context, sense_context, ...},
                  _) =>
              (set_selection := true;
  	       sense_selection := true;
               set_context := true;
               sense_context := true);
            ToolData.TOOLDATA
              {args = ShellTypes.LISTENER_ARGS
                        {user_options = user_options,
		         user_preferences = user_preferences,
                         user_context =
			   user_context,
			   (*  We used to get the user context from the
		               current motif context, but now that we've 
			       hidden contexts from users we no longer wish
			       to do this.
			   GuiUtils.get_user_context (!local_context),
			   *)
                         prompter = prompter,
                         mk_xinterface_fn = mk_xinterface_fn},
               appdata = appdata,
               current_context = current_context,
	       motif_context = (* !local_context, *)
	         ToolData.get_current current_context,
               tools = tools}
	    end

	val sep_size = 10

        val view_menu =
          GuiUtils.view_options
            {parent = shell, title = title, user_options = user_options,
	     user_preferences = user_preferences,
	     caller_update_fn = fn (_) => (),
	     view_type = [GuiUtils.SENSITIVITY]}

        fun get_current_value () =
          if !selectionStr = ""
            then NONE
          else
            SOME 
            (!selectionStr,
             ShellUtils.eval
             Info.null_options
             (!selectionStr,
              (ShellTypes.new_options (user_options, user_context)),
              UserContext.get_context user_context))
            handle _ => NONE
          
        val inspect_fn = InspectorTool.inspect_value (shell,false, mk_tooldata())
          
        val _ =
          do_select_fn :=
          (fn _ =>
           case get_current_value () of
             NONE => ()
           | SOME x => inspect_fn true x)

	fun duplicate () = create_internal (ref NONE, number_ref, true) (tooldata, orig_title)

	val value_menu = 
	  GuiUtils.value_menu
	     {parent = shell,
              user_preferences = user_preferences, 
              inspect_fn = SOME (inspect_fn false),
              get_value = get_current_value,
	      enabled = not (UserContext.is_const_context 
				(GuiUtils.get_user_context (!local_context))),
	      tail = []}
	val values = ToolData.extract value_menu
	val view = ToolData.extract view_menu

        val search = 
          let
            (* Function to check for substrings, used in the graph search *)
            (* This function also appears in gui._comp_manager, it would
               be nice to have in the utils directory.  *)
            fun isSubstring (s1, s2) =
              let
                val l1 = explode s1   val l2 = explode s2
                fun isSub l =
                     let
                       fun isPre ([], _) = true
                         | isPre (l, []) = false
                         | isPre ((h1::t1), (h2::t2)) =
                             (h1=h2) andalso (isPre (t1, t2))
                     in
                       (isPre (l1, l)) orelse
                       (case l of (h::t) => isSub t | _ => false)
                     end
              in
                isSub l2
              end

            fun getDefault () = (!shortSelectionStr)
            fun matchWeak string (ITEM(entry,_,_))  = 
                  isSubstring(string, getShortName entry)
            fun matchStrong string (ITEM(entry,_,_))  = 
                  string = getShortName entry
          in
            initialiseSearch getDefault (matchStrong, matchWeak)
          end

        val menuSpec =
          [ToolData.file_menu [("save", fn _ =>
		       GuiUtils.save_history (false, get_user_context (), applicationShell),
		     fn _ =>
		       not (UserContext.null_history (get_user_context ()))
		       andalso UserContext.saved_name_set (get_user_context ())),
	    ("saveAs", fn _ => GuiUtils.save_history
			     (true, get_user_context (), applicationShell),
		       fn _ => not (UserContext.null_history (get_user_context ()))),
	    ("close", close_window, fn _ => true)],
           ToolData.edit_menu
           (shell,
            {cut = NONE,
             paste = NONE,
             copy = SOME (fn _ => Capi.clipboard_set (shell,!selectionStr)),
             delete = NONE,
             selection_made = fn _ => !selectionStr <> "",
	     edit_possible = fn _ => false,
	     delete_all = NONE,
	     edit_source = [value_menu]}),
	   ToolData.tools_menu (mk_tooldata, fn () => user_context),
	   ToolData.usage_menu (("filter", filter_popup, fn _ => true) :: 
				("duplicate", duplicate, fn _ => true) ::
                                ("search", search, fn _ => true) ::
                                values @ view, []),
	   ToolData.debug_menu values]

	fun storeSizePos () = 
	  (sizeRef := SOME (Capi.widget_size shell);
	   posRef := SOME (Capi.widget_pos shell))

      in
        SaveImage.add_with_fn (with_no_context browser_ref);
	browser_ref := SOME shell;
        quit_funs := Menus.quit :: (!quit_funs);
        quit_funs := storeSizePos :: (!quit_funs);
        Menus.make_submenus (menuBar,menuSpec);
        Capi.Layout.lay_out
        (frame, !sizeRef,
         [Capi.Layout.MENUBAR menuBar] @
         (case contextLabel of
            SOME w => [Capi.Layout.FIXED w]
          | _ => [Capi.Layout.SPACE]) @
         [Capi.Layout.FIXED selectionLabel,
          Capi.Layout.SPACE,
          Capi.Layout.FIXED listLabel,
          Capi.Layout.FLEX graph_window,
          Capi.Layout.SPACE]);
	Capi.set_close_callback(frame, close_window);
        Capi.Callback.add (frame, Capi.Callback.Destroy, do_quit_funs);
        set_context_label (!local_context);
        Capi.initialize_toplevel shell;
        initialize_graph ()
      end

    fun create_initial
	  (ToolData.TOOLDATA
	     {args = ShellTypes.LISTENER_ARGS
		{user_context, user_options, user_preferences, prompter,
		 mk_xinterface_fn},
	      appdata, tools, motif_context, current_context, ...}) =
      let
	val initial = GuiUtils.getInitialContext ()
      in
	case user_options
	of UserOptions.USER_TOOL_OPTIONS
	     ({set_selection, sense_selection, set_context, sense_context, ...},
	      _) =>
	  (set_selection := false;
	   sense_selection := false;
	   set_context := false;
	   sense_context := false);

	if isSome (!system_browser) then 
	  Capi.to_front (valOf (!system_browser))
	else
          create_internal (system_browser, system_number, false)
	    (* We have hidden contexts from the user, so we want to pass through
	       the user's context to the tooldata. *)
	    (ToolData.TOOLDATA
             {args =
		ShellTypes.LISTENER_ARGS
		  {user_context = user_context, (* GuiUtils.get_user_context initial, *)
		   user_preferences = user_preferences,
		   user_options = user_options,
		   prompter = prompter,
		   mk_xinterface_fn = mk_xinterface_fn},
	      appdata = appdata,
	      motif_context = initial,
	      current_context = current_context, (* ToolData.make_current (initial), *)
	      tools = tools},
             initial_title ())
      end

    fun create tooldata =
      if isSome (!context_browser) then 
	Capi.to_front (valOf (!context_browser))
      else
        create_internal (context_browser, context_number, false) (tooldata,title())

  end


