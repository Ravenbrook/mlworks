(* Types for passing to motif tools.
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Log: tooldata.sml,v $
 * Revision 1.13  1998/07/09 12:51:59  johnh
 * [Bug #30400]
 * remove main_windows arg from exit_mlworks.
 *
 * Revision 1.12  1997/06/12  13:53:15  johnh
 * [Bug #30175]
 * Remove windows menu.
 *
 * Revision 1.11  1997/05/16  15:36:45  johnh
 * Implementing single menu bar on Windows.
 * Re-organising menus for Motif.
 *
 * Revision 1.10  1997/05/01  12:33:49  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.9  1996/09/19  11:23:55  johnh
 * Bug #148.
 * Passed list of main windows to exit_dialog function so that they can be killed.
 *
 * Revision 1.8  1996/05/14  13:56:39  daveb
 * Replaced works_menu and application_works_menu with tools_menu.
 *
 * Revision 1.7  1996/05/10  14:32:53  daveb
 * Added edit_possible field to ToolData.edit_menu.
 *
 * Revision 1.6  1996/02/05  17:31:09  daveb
 * UserContext no longer includes a user_tool_options type.
 *
 * Revision 1.5  1996/01/23  15:23:36  daveb
 * Added tail field to edit_menu argument.
 *
 * Revision 1.4  1995/12/07  14:02:24  matthew
 * Adding widget parameter to edit_menu
 *
 * Revision 1.3  1995/11/16  13:58:33  matthew
 * Changing interface to tool_data
 *
 * Revision 1.2  1995/11/15  16:54:48  matthew
 * Adding window menu
 *
 * Revision 1.1  1995/05/29  13:57:29  matthew
 * new unit
 * New unit
 *
 *  Revision 1.10  1995/05/29  13:57:29  daveb
 *  Separated user_options into tool-specific and context-specific parts.
 *
 *  Revision 1.9  1995/04/28  17:01:03  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.8  1995/03/17  11:24:21  daveb
 *  Added a Writable parameter to add_context_fn.
 *  
 *  Revision 1.7  1995/03/15  15:57:31  daveb
 *  Added current_context type, and unit associated functions.
 *  
 *  Revision 1.6  1994/07/14  14:30:24  daveb
 *  Changed second parameter of exit_mlworks to ApplicationData, and
 *  extended that type with a flag set to true if the GUI is launched from
 *  a TTY listener.
 *  
 *  Revision 1.5  1994/07/12  15:49:31  daveb
 *  Modified works menu to show Exit or Close, not both.  Added exit_mlworks.
 *  
 *  Revision 1.4  1993/10/22  17:02:22  daveb
 *  Merged in bug fix.
 *  
 *  Revision 1.3.1.2  1993/10/21  13:59:17  daveb
 *  Changed ToolData.works_menu to take a (unit -> bool) function that
 *  controls whether the Close menu option is enabled.
 *  
 *  Revision 1.3.1.1  1993/05/05  12:26:14  jont
 *  Fork for bug fixing
 *  
 *  Revision 1.3  1993/05/05  12:26:14  daveb
 *  Added tools argument to works_menu(),
 *  removed exitApplication from TOOLDATA (works_menu now accesses it directly).
 *  
 *  Revision 1.2  1993/04/30  13:07:11  daveb
 *  Added function to create Works menu.
 *  
 *  Revision 1.1  1993/04/16  17:18:18  matthew
 *  Initial revision
 *  
 *
 *)

require "../interpreter/shell_types";
require "../interpreter/user_context";

signature TOOL_DATA =
  sig
    structure ShellTypes : SHELL_TYPES
    structure UserContext : USER_CONTEXT

    sharing ShellTypes.Options = UserContext.Options
    sharing type ShellTypes.Context = UserContext.Context
    sharing type ShellTypes.user_context = UserContext.user_context

    type MotifContext
    type Widget
    type ButtonSpec
    type current_context
    datatype Writable = WRITABLE | ALL

    datatype ApplicationData =
      APPLICATIONDATA of {applicationShell : Widget, has_controlling_tty: bool}

    datatype ToolData =
      TOOLDATA of
	{args: ShellTypes.ListenerArgs,
         appdata : ApplicationData,
	 current_context : current_context,
	 motif_context : MotifContext,
         tools : (string * (ToolData -> unit) * Writable) list}

    val add_context_fn :
      current_context
      * ((MotifContext -> unit)
	 * (unit -> ShellTypes.user_options)
	 * Writable)
      -> int
    (* add_change_fn (c, (select_fn, mk_user_options, writable)).  The
       current settings of the user options are checked before calling the
       callback.  If writable = WRITABLE then constant contexts are ignored. *)
  
    val remove_context_fn : current_context * int -> unit
  
    val set_current :
      current_context * int * ShellTypes.user_options * MotifContext
      -> unit

    val get_current : current_context -> MotifContext
    val make_current : MotifContext -> current_context

    val exit_mlworks: Widget * ApplicationData -> unit

    val tools_menu:
      (unit -> ToolData) * (unit -> ShellTypes.user_context)
      -> ButtonSpec

    (* Takes a ButtonSpec which is assumed to be a CASCADE, and retrieves the action
     * and sensitivity functions of any PUSH buttons in the structure. *)
    val extract : ButtonSpec -> (string * (unit -> unit) * (unit -> bool)) list

    val edit_menu :
      Widget *
      {cut : (unit -> unit) option,
       paste : (unit -> unit) option,
       copy : (unit -> unit) option,
       delete : (unit -> unit) option,
       selection_made : unit -> bool,
       edit_possible : unit -> bool,
       edit_source: ButtonSpec list,
       delete_all: (string * (unit -> unit) * (unit -> bool)) option} -> ButtonSpec

     val file_menu : (string * (unit -> unit) * (unit -> bool)) list -> ButtonSpec
     val set_global_file_items : (string * (unit -> unit) * (unit -> bool)) list -> ButtonSpec
     val debug_menu : (string * (unit -> unit) * (unit -> bool)) list -> ButtonSpec
     val usage_menu : (string * (unit -> unit) * (unit -> bool)) list *
                    (string * (unit -> bool) * (bool -> unit) * (unit -> bool)) list 
                       -> ButtonSpec
     val set_global_usage_items : (string * (unit -> unit) * (unit -> bool)) list *
                    (string * (unit -> bool) * (bool -> unit) * (unit -> bool)) list 
                       -> ButtonSpec
  end
