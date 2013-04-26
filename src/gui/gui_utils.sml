(*
 * $Log: gui_utils.sml,v $
 * Revision 1.22  1998/03/24 17:17:55  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.21  1998/01/27  16:05:22  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.20.2.3  1997/11/20  17:06:38  johnh
 * [Bug #30071]
 * Remove Paths menu.
 *
 * Revision 1.20.2.1  1997/09/11  20:52:16  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.20  1997/06/09  10:26:54  johnh
 * [Bug #30068]
 * Removed breakpoints_menu - now in break_trace.
 *
 * Revision 1.19  1997/05/16  15:36:37  johnh
 * Implementing single menu bar on Windows.
 * Re-organising menus for Motif.
 *
 * Revision 1.18  1997/05/01  12:33:07  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.17  1996/05/24  13:22:25  daveb
 * Changed view_options so that it can show just the value printer menu item.
 *
 * Revision 1.16  1996/05/14  11:58:12  daveb
 * Added save_hist to signature.
 *
 * Revision 1.15  1996/05/01  10:42:06  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.14  1996/03/12  13:55:51  matthew
 * Adding path menu
 *
 * Revision 1.13  1996/02/29  14:21:15  matthew
 * Adding extra params to setup_menu
 *
 * Revision 1.12  1996/02/08  11:20:38  daveb
 * Removed the Sensitivity type.
 *
 * Revision 1.11  1996/01/23  14:12:45  daveb
 * Minor changes to menu interfaces.
 *
 * Revision 1.10  1996/01/19  16:28:04  daveb
 * Added make_history function.
 *
 * Revision 1.9  1996/01/18  14:37:35  matthew
 * Changing interface to value_menu
 *
 * Revision 1.8  1996/01/17  14:10:21  matthew
 * Adding Inspect to value menu
 *
 * Revision 1.7  1996/01/09  13:47:06  matthew
 * Moving list_select to capi
 *
 * Revision 1.6  1995/12/07  14:32:27  matthew
 * Changing clipboard interface
 *
 * Revision 1.5  1995/10/13  14:42:41  brianm
 * Another Menu utility ...
 *
 * Revision 1.4  1995/10/13  12:23:26  brianm
 * Adding some PopUp Menu utility functions : (int_value, etc.)
 *
 * Revision 1.3  1995/10/09  11:43:02  daveb
 * The search_opt field of the context menu now takes a boolean component which
 * controls whether users are given the option of which contexts to search.
 * In input tools this should be true, in the context browser it should be false.
 *
 * Revision 1.2  1995/10/04  12:52:41  daveb
 * setup_menu now takes a get_context function argument.  This is because the
 * mode options have been moved into this menu until we implement the full
 * contexts-as-menus plan.
 *
 * Revision 1.1  1995/07/26  14:33:09  matthew
 * new unit
 * New unit
 *
 *  Revision 1.25  1995/07/04  13:47:40  matthew
 *  Moving various functions to CAPI
 *
 *  Revision 1.24  1995/06/05  13:19:52  daveb
 *  Added NO_SENSE_SELECTION option for Sensitivity type.
 *
 *  Revision 1.23  1995/06/01  10:28:14  daveb
 *  Added new type MotifContext, which combines a user_context with
 *  dialog boxes for context-specific options.  Changed context_menu to
 *  incorporate entries for popping up the options dialogs for the current
 *  context.  Put the remaining options dialogs, for tool-specific options,
 *  in the view_options function, which returns items for use in "view"
 *  menus.
 *
 *  Revision 1.22  1995/05/22  10:51:12  matthew
 *  Changing interface to list_select.
 *
 *  Revision 1.21  1995/04/20  13:11:27  matthew
 *  Added set_sensitivity and input_string
 *
 *  Revision 1.20  1995/04/18  14:31:43  daveb
 *  Added get_context argument to context_menu.
 *
 *  Revision 1.19  1995/03/16  18:20:22  daveb
 *  Made context_menu ignore constant contexts if asked to do so.
 *
 *  Revision 1.18  1995/03/10  15:04:27  daveb
 *  Added support for selections to the options menu.
 *
 *  Revision 1.17  1994/09/21  16:05:06  brianm
 *  Adding value menu implementation ...
 *
 *  Revision 1.16  1994/06/20  11:13:12  daveb
 *  Replaced ContextRef with user_context.
 *
 *  Revision 1.15  1994/04/06  11:31:20  daveb
 *  Added breakpoints menu.
 *
 *  Revision 1.14  1993/12/10  11:01:36  daveb
 *  Added context_menu function.
 *
 *  Revision 1.13  1993/10/08  16:46:50  matthew
 *  Merging in bug fixes
 *
 *  Revision 1.12  1993/09/13  09:16:20  daveb
 *  Merged in bug fix.
 *
 *  Revision 1.11.1.3  1993/10/08  10:35:18  matthew
 *  Added beep and cut buffer operations
 *
 *  Revision 1.11.1.2  1993/09/10  11:13:07  daveb
 *  Added name parameter to MotifUtils.list_select.
 *
 *  Revision 1.11.1.1  1993/08/10  16:54:49  jont
 *  Fork for bug fixing
 *
 *  Revision 1.11  1993/08/10  16:54:49  matthew
 *  Return update function from options_menu
 *
 *  Revision 1.10  1993/07/29  11:28:46  matthew
 *  Added with_message function
 *
 *  Revision 1.9  1993/05/27  16:14:35  matthew
 *  Return exit function from list_select
 *
 *  Revision 1.8  1993/05/13  10:06:51  daveb
 *  options_menu now takes a string to use for the title of the options
 *  dialogs.
 *
 *  Revision 1.7  1993/05/06  13:45:39  daveb
 *  Added make_outstream.
 *
 *  Revision 1.6  1993/05/04  16:22:09  matthew
 *  Added fileselect function
 *
 *  Revision 1.5  1993/04/30  14:40:04  daveb
 *  Moved Editor options dialog to new setup menu.
 *
 *  Revision 1.4  1993/04/28  10:04:25  daveb
 *  Changes to make_scrolllist.
 *
 *  Revision 1.3  1993/04/27  12:39:32  daveb
 *  Added options_menu code from _listener and _fileselect.
 *
 *  Revision 1.2  1993/04/23  14:19:59  matthew
 *  Added send_message function
 *
 *  Revision 1.1  1993/04/21  12:11:37  daveb
 *  Initial revision
 *
 *
 * Copyright (c) 1993 Harlequin Ltd.
 *
 *)

require "^.basis.__text_io";

signature GUI_UTILS =
sig
  type Widget
  type ButtonSpec
  type OptionSpec
  type Type

  type user_context_options
  type user_tool_options
  type user_preferences
  type user_context

  val make_outstream : (string -> unit) -> TextIO.outstream
  (* make_outstream uses a local buffer to implement an outstream.  It uses
     its argument to actually display the text. *)

  type MotifContext
  (* A MotifContext combines a user_context with some option dialogs. *)

  val listener_properties:
    Widget * (unit -> MotifContext) -> ButtonSpec

  val setup_menu:
    Widget * (unit -> MotifContext) * user_preferences * (unit -> user_context_options) -> 
	(string * (unit -> unit) * (unit -> bool)) list

  datatype Writable = WRITABLE | ALL

  val make_context: user_context * Widget * user_preferences -> MotifContext

  val makeInitialContext: Widget * user_preferences -> unit

  val getInitialContext: unit -> MotifContext

  val get_user_context: MotifContext -> user_context

  val get_context_name: MotifContext -> string

  (* A context menu includes entries for setting the current mode, saving the
     source to a file, and creating a new context.  The writable argument 
     controls whether the menu contains the entries for creating new contexts.
     If full_menus is set, it also contains entries for selecting the current
     context and for setting individual options. *)
  val context_menu :
    {set_state: MotifContext -> unit,
     get_context: unit -> MotifContext,
     writable: Writable,
     applicationShell: Widget,
     shell: Widget,
     user_preferences: user_preferences}
    -> ButtonSpec

  val search_button :
    Widget * (unit -> MotifContext) * (string -> unit) * bool
    -> ButtonSpec

  (* view_options returns a list of items for inclusion in a view menu.
     These items pop-up dialogs for setting the tool-specific options.
     The ViewOptions type controls which dialogs the funtion creates.
     The string argument is the title of the dialog shells. *)
  datatype ViewOptions = SENSITIVITY | VALUE_PRINTER | INTERNALS

  val view_options :
    {parent: Widget,
     title: string,
     user_options: user_tool_options, 
     user_preferences: user_preferences,
     caller_update_fn: user_tool_options -> unit,
     view_type: ViewOptions list}
    -> ButtonSpec 

  (* Value menu : Edit, Trace, Untrace, etc. *)
  val value_menu :
    {parent: Widget,
     user_preferences: user_preferences ,
     inspect_fn: ((string * (MLWorks.Internal.Value.T * Type))->unit)
							option,
     get_value: unit -> (string * (MLWorks.Internal.Value.T * Type))
							option,
     enabled: bool,
     tail: ButtonSpec list}
    -> ButtonSpec

  (* Some PopUp Menu utilities *)

  val toggle_value : string * ''a ref * ''a -> OptionSpec
  val bool_value : string * bool ref -> OptionSpec
  val text_value : string * string ref -> OptionSpec
  val int_value : string * int ref -> OptionSpec

  (* save the source of the declarations in the current context *)
  val save_history : bool * user_context * Widget -> unit

  (* tool-specific input history *)
  val make_history :
    user_preferences * (string -> unit) ->
    {update_history: string list -> unit,
     prev_history: unit -> unit,
     next_history: unit -> unit,
     history_end: unit -> bool,
     history_start: unit -> bool,
     history_menu: ButtonSpec}

end
