(* Motif menu bar utilites *)
(*

$Log: menus.sml,v $
Revision 1.18  1998/07/09 12:30:18  johnh
[Bug #30400]
remove main_windows arg from exit_dialog.

 * Revision 1.17  1997/11/06  13:04:29  johnh
 * [Bug #30125]
 * Move implementation of send_message from Capi to Menus.
 *
 * Revision 1.16  1997/10/27  16:20:26  johnh
 * [Bug #30059]
 * Add Combo boxes to create_dialog function.
 *
 * Revision 1.15  1997/09/08  08:46:23  johnh
 * [Bug #30241]
 * Implement proper find dialog.
 *
 * Revision 1.14  1997/06/16  14:45:48  johnh
 * [Bug #30174]
 * Moving stuff into platform specific podium.
 *
 * Revision 1.13  1997/06/13  09:32:52  johnh
 * [Bug #30175]
 * Add structure of tools menu.
 *
 * Revision 1.12  1997/05/28  11:21:28  johnh
 * [Bug #30155]
 * Added get_graph_menuspec.
 *
 * Revision 1.11  1997/05/21  09:03:07  johnh
 * Implementing toolbar on Windows.
 *
 * Revision 1.10  1997/05/16  15:36:02  johnh
 * Implementing single menu bar on Windows.
 *
 * Revision 1.9  1996/09/19  11:24:42  johnh
 * Bug #148.
 * Passed list a of main windows to exit_dialog function so that they can be killed.
 *
 * Revision 1.8  1996/08/09  15:25:50  nickb
 * Option dialog setter functions now return accept/reject.
 *
 * Revision 1.7  1995/10/17  15:51:41  nickb
 * Add sliders.
 *
 * Revision 1.6  1995/10/03  15:45:58  daveb
 * Made make_buttons return a set_focus function.
 *
 * Revision 1.5  1995/08/30  13:23:44  matthew
 * Removing OPTSUBMENU
 *
 * Revision 1.4  1995/08/24  15:49:34  matthew
 * Moving exit_dialog in here.
 *
 * Revision 1.3  1995/08/15  14:32:01  matthew
 * Removing make_options
 *
 * Revision 1.2  1995/08/08  10:31:49  matthew
 * Adding make_buttons function to capi
 *
 * Revision 1.1  1995/07/27  11:15:00  matthew
 * new unit
 * Moved from library
 *
# Revision 1.1  1995/07/06  13:31:31  matthew
# new unit
# New unit
#
Revision 1.13  1995/07/06  13:31:31  matthew
Changing the type of PUSHBUTTON callback type

Revision 1.12  1995/05/29  13:09:45  daveb
Replaced spurious type variable in result of create_dialog with unit.

Revision 1.11  1993/08/19  14:24:43  matthew
Added OPTSUBMENU to Option menu (a non-radio box submenu)

Revision 1.10  1993/08/11  10:08:28  matthew
Return update function from create_dialog
Simplified interface.

Revision 1.9  1993/05/18  16:40:12  daveb
Added the OPTRADIO constructor.

Revision 1.8  1993/05/13  10:05:36  daveb
create_dialog now takes a string to use for the title of the popup shell.

Revision 1.7  1993/04/30  13:30:53  matthew
Added create_dialog_with_action

Revision 1.6  1993/04/19  14:53:15  matthew
Added TOGGLE button class

Revision 1.5  1993/04/15  18:24:28  daveb
Added DYNAMIC menus.

Revision 1.4  1993/03/31  12:27:17  matthew
Removed MenuSpec type, added OptionSpec type and make_options and
create_dialog

Revision 1.3  1993/03/26  18:51:05  matthew
Added create_dialog function

Revision 1.2  1993/03/23  14:21:01  matthew
Extended ButtonSpec class

Revision 1.1  1993/03/17  16:28:47  matthew
Initial revision


Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*)

signature MENUS =
  sig
    type Widget

    datatype ButtonSpec =
        SEPARATOR |
        LABEL of string |
        (* fun 1 gets initial value, fun 2 is callback function, fun 3 is a sensitive function *)
        TOGGLE of string * (unit -> bool) * (bool -> unit) * (unit -> bool) |
	(* name, min, max, callback *)
	SLIDER of string * int * int * (int -> unit) |
	RADIO of string * (unit -> bool) * (bool -> unit) * (unit -> bool) |
        PUSH of string * (unit -> unit) * (unit -> bool) |
        DYNAMIC of string * (unit -> ButtonSpec list) * (unit -> bool) |
        CASCADE of string * ButtonSpec list * (unit -> bool)

    datatype selection = SINGLE | EXTENDED

    (* First function is get the value for the widget
       second is set the value for the widget, and returns accept/reject *)
    datatype OptionSpec =
      OPTSEPARATOR |
      OPTLABEL of string |
      OPTTOGGLE of string * (unit -> bool) * (bool -> bool) |
      OPTTEXT of string * (unit -> string) * (string -> bool) |
      OPTINT of string * (unit -> int) * (int -> bool) |
      OPTRADIO of OptionSpec list |
      OPTCOMBO of string * (unit -> string * string list) * (string -> bool) |
      (* OPTLIST args: (name, fn () => (all_items, selected_items), 
			fn new_sel_items => bool, 
			single_or_extended_selection) 
       *)
      OPTLIST of string * 
		 (unit -> string list * string list) * 
		 (string list -> bool) * 
		 selection
      
    (* make the menus for a tool menubar *)
    val make_submenus : Widget * ButtonSpec list -> unit
    val make_menus : Widget * ButtonSpec list * bool -> unit
    val quit : unit -> unit

    val send_message : Widget * string -> unit

    (* The menuspec for the tools menu is different between Motif and Windows.
     * The reason for this is due to interaction between dynamic menus and storing
     * the menu references on Win32.  On Win32, the references need to be stored on
     * creation, so that they exist when invoked, but on Motif the dynamic menu items
     * are not created until they are invoked.  Solution:  on Motif, for the partially
     * dynamic tools menu to work, the whole menu is made dynamic, and on Windows, the
     * main tools need to be created first, then add the dynamic menu items below them.
     *)
    val get_tools_menuspec : ButtonSpec list * (unit -> ButtonSpec list) -> ButtonSpec

    (* The menuspec for the dependency graph is different between Motif and Windows.
     * This function returns the menuspec when given the close push button and the
     * graph preferences push button.
     *)
    val get_graph_menuspec : ButtonSpec * ButtonSpec -> ButtonSpec list

    datatype ToolButton = TB_SEP | TB_TOGGLE | TB_PUSH | TB_GROUP | TB_TOGGLE_GROUP
    datatype ToolState = CHECKED | ENABLED | HIDDEN | GRAYED | PRESSED | WRAP
    datatype ToolButtonSpec = TOOLBUTTON of 
	{style:	ToolButton,
	 states: ToolState list,
	 tooltip_id: int,
	 name: string}

    val make_toolbar : Widget * int * ToolButtonSpec list -> Widget

    (* returns an update function *)
    val make_buttons :
      Widget * ButtonSpec list
      -> {update: unit -> unit, set_focus: int -> unit}

    (* This utility function makes a popup dialog with a menu inside *)
    (* apply the action function after a change has been made *)
    val create_dialog :
      Widget * string * string * (unit -> unit) * OptionSpec list ->
      ((unit -> unit) * (unit -> unit))  (* return popup and update function *)

    val exit_dialog : Widget * Widget * bool -> unit
  end

