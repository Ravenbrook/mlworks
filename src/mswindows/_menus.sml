(* Windows menu bar utilites *)
(*
 * $Log: _menus.sml,v $
 * Revision 1.65  1999/03/23 14:44:44  johnh
 * [Bug #190536]
 * Change help menu.
 *
 * Revision 1.64  1998/07/09  13:56:15  johnh
 * [Bug #30400]
 * Fix returning to and from tty mode.
 *
 * Revision 1.63  1998/04/16  17:02:20  johnh
 * [Bug #30318]
 * Add createDialog to Windows structure.
 *
 * Revision 1.62  1998/04/01  12:17:42  jont
 * [Bug #70086]
 * WINDOWS becomes WINDOWS_GUI, Windows becomesd WindowsGui
 *
 * Revision 1.61  1998/02/20  11:34:03  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.60  1998/02/18  17:10:28  jont
 * [Bug #70070]
 * Remove MLWorks.IO.terminal_out in favour of Terminal.output
 *
 * Revision 1.59  1998/01/30  14:31:12  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.58  1997/11/06  13:00:32  johnh
 * [Bug #30125]
 * Move implementation of send_message to Menus.
 *
 * Revision 1.57  1997/10/29  11:06:12  johnh
 * [Bug #30233]
 * editor dialog now stored as resource.
 *
 * Revision 1.56  1997/10/28  16:02:44  johnh
 * [Bug #30059]
 * Implement interface to Win32 resource dialogs.
 *
 * Revision 1.55  1997/09/19  14:29:50  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.54.2.2  1997/09/12  14:48:42  johnh
 * [Bug #30071]
 * Redesign Compilation Manager -> Project Workspace.
 * Implement Radio and Toggle buttons in make_buttons function.
 *
 * Revision 1.54  1997/09/08  08:52:32  johnh
 * [Bug #30241]
 * Implement proper find dialog.
 *
 * Revision 1.53  1997/07/15  15:39:26  johnh
 * [Bug #30124]
 * Creating help menu.
 *
 * Revision 1.52  1997/06/16  15:30:21  johnh
 * [Bug #30174]
 * Moving stuff into platform specific podium.
 *
 * Revision 1.51  1997/06/13  09:35:01  johnh
 * [Bug #30175]
 * Combine tools and windows menus - need to change implementation of dynamic menus.
 *
 * Revision 1.50  1997/06/09  10:29:51  johnh
 * [Bug #30068]
 * Add a toolbar button for the BreakTrace manager top level tool.
 *
 * Revision 1.49  1997/05/28  10:32:04  johnh
 * [Bug #30155]
 * Added get_graph_menuspec.
 *
 * Revision 1.48  1997/05/22  16:35:49  johnh
 * [Bug #20059]
 * Menus.windowHandle made global and set from actions of some menu items.
 *
 * Revision 1.47  1997/05/21  09:37:27  johnh
 * Implementing toolbar.
 *
 * Revision 1.46  1997/05/16  15:34:38  johnh
 * Implementing single menu bar on Windows.
 *
 * Revision 1.45  1997/05/06  10:37:00  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.44  1997/03/17  14:23:09  johnh
 * [Bug #1954]
 * Improved slider functionality - added range checking.
 *
 * Revision 1.43  1997/03/14  13:17:05  johnh
 * [Bug #1923]
 * Removed system menu from exit dialog.
 *
 * Revision 1.42  1997/03/13  13:55:03  johnh
 * [Bug #1772]
 * Attaching Esc to 'Cancel' button on dialogs.
 *
 * Revision 1.41  1996/11/20  12:15:09  daveb
 * Reinstated the help menus.
 *
 * Revision 1.40  1996/11/06  11:17:58  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.39  1996/11/05  12:45:06  johnh
 * [Bug #1727]
 * Add ES_AUTOHSCROLL to text boxes to input past the end of textbox.
 *
 * Revision 1.38  1996/10/30  20:11:16  io
 * [Bug #1614]
 * sorting out a typo
 *
 * Revision 1.37  1996/10/30  20:01:27  io
 * moving String from toplevel
 *
 * Revision 1.36  1996/09/19  11:28:52  johnh
 * [Bug #1481]
 * Passed list of main windows to exit_dialog function so that they can
 * be killed.
 *
 * Revision 1.35  1996/08/12  10:48:51  nickb
 * Option dialog setter functions now return accept/reject.
 *
 * Revision 1.34  1996/08/01  12:59:12  daveb
 * [Bug #1517]
 * make_buttons now adds a command handler to the grandparent of the button,
 * which in our code is the top level widget.  This allows accelerators to
 * refer to buttons.  This is a fragile feature; changes in the nesting of
 * windows will break it.
 *
 * Revision 1.33  1996/07/12  16:51:53  andreww
 * Adding code to redirect standard IO back to the terminal.
 * Since current implementation ignores has_controlling_tty, we can always
 * do it anyway.
 *
 * Revision 1.32  1996/06/28  15:42:06  jont
 * Static command handlers changed to be dynamic to improve delivery
 *
 * Revision 1.31  1996/06/25  15:19:05  daveb
 * Added handlers around all calls to Capi.getStockObject.
 *
 * Revision 1.30  1996/06/24  12:58:26  daveb
 * Removed the Help menus.
 *
 * Revision 1.29  1996/06/24  10:51:05  daveb
 * Corrected sizes of buttons in the light of the recent font change.
 *
 * Revision 1.28  1996/06/18  13:18:49  daveb
 * Made buttons use the DEFAULT_GUI_FONT, when defined, and ANSI_VAR_FONT
 * otherwise.
 *
 * Revision 1.27  1996/05/29  10:09:51  matthew
 * More on last change
 *
 * Revision 1.26  1996/05/28  15:14:17  matthew
 * Improving exit_dialog
 *
 * Revision 1.25  1996/05/28  11:00:22  matthew
 * Don'
 * Don't do action after OK with nothing selected
 *
 * Revision 1.24  1996/05/01  13:49:03  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.23  1996/05/01  12:09:08  matthew
 * Removing Integer structure
 *
 * Revision 1.22  1996/04/30  13:24:32  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.21  1996/04/04  14:34:40  matthew
 * Fixing sliders
 *
 * Revision 1.20  1996/03/05  16:25:30  matthew
 * Changes to windows structure
 *
 * Revision 1.19  1996/02/27  15:48:25  matthew
 * Changes to Windows signature
 *
 * Revision 1.18  1996/01/31  12:18:44  matthew
 * Changing representation of Widgets
 *
 * Revision 1.17  1996/01/24  15:26:36  matthew
 * Adding slider controls
 *
 * Revision 1.16  1996/01/08  16:13:06  matthew
 * More stuff.
 *
 * Revision 1.15  1996/01/04  16:33:41  matthew
 * Make buttons variable width, depending on string size
 *
 * Revision 1.14  1995/12/15  12:09:39  matthew
 * Changing some windows styles
 *
 * Revision 1.13  1995/12/13  12:19:06  matthew
 * Changing message handling
 *
 * Revision 1.12  1995/11/23  12:36:12  matthew
 * More stuff
 *
 * Revision 1.11  1995/11/22  16:12:01  matthew
 * More stuff
 *
 * Revision 1.10  1995/11/08  10:30:44  matthew
 * Trying to fix radio buttons
 *
 * Revision 1.9  1995/10/17  16:08:15  nickb
 * Add sliders.
 *
 * Revision 1.8  1995/10/04  09:35:15  daveb
 * make_buttons now returns a record of functions.
 *
 * Revision 1.7  1995/09/19  14:16:18  matthew
 * Attempting to do dynamic menus
 *
 * Revision 1.6  1995/09/05  11:52:30  matthew
 * ** No reason given. **
 *
 * Revision 1.5  1995/08/31  11:25:06  matthew
 * Adding text and int input.
 *
 * Revision 1.4  1995/08/25  10:33:17  matthew
 * Adding dialogs
 *
 * Revision 1.3  1995/08/15  14:37:22  matthew
 * Extending
 *
 * Revision 1.2  1995/08/10  09:33:01  matthew
 * Making it all work
 *
 * Revision 1.1  1995/08/03  12:52:41  matthew
 * new unit
 * MS Windows GUI
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
 *)

require "^.utils.__terminal";
require "../basis/__int";
require "../basis/__list";

require "../utils/lists";
require "../utils/crash";
require "../utils/getenv";
require "windows_gui";
require "capitypes";
require "labelstrings";
require "control_names";
require "../main/version";

require "../gui/menus";

(* some utility functions for specifying menus *)

functor Menus (structure Lists : LISTS
               structure Crash : CRASH
               structure WindowsGui : WINDOWS_GUI
               structure CapiTypes : CAPITYPES
               structure LabelStrings : LABELSTRINGS
	       structure ControlName : CONTROL_NAME
	       structure Getenv : GETENV
	       structure Version : VERSION

               sharing type LabelStrings.word = WindowsGui.word
               sharing type CapiTypes.Hwnd = WindowsGui.hwnd
                 ) : MENUS =
  struct
    type Widget = CapiTypes.Widget
    type word = WindowsGui.word

    fun env s = MLWorks.Internal.Value.cast (MLWorks.Internal.Runtime.environment s)

    fun dummy s = Terminal.output(s ^ " unimplemented \n")

    val P = Int.toString
    val W = Int.toString o WindowsGui.wordToInt

    fun k x y = x

    val print = Terminal.output

    (* some constants, which should be derived from winmain.h *)

    val IDM_HELPCONTENTS = WindowsGui.intToWord 400
    val IDM_HELPSEARCH   = WindowsGui.intToWord 401
    val IDM_HELPHELP     = WindowsGui.intToWord 402
    val IDM_ABOUT        = WindowsGui.intToWord 403

    val null_item = WindowsGui.ITEM WindowsGui.nullWord

    (* use a list of these to specify the top level menu *)
    datatype ButtonSpec =
        (* a separator widget *)
        SEPARATOR
      | LABEL of string
        (* fun 1 is a function to get initial value, fun 2 is callback function, fun 3 is a sensitive function *)
      | TOGGLE of string * (unit -> bool) * (bool -> unit) * (unit -> bool)
	(* name, min, max, callback *)
      |	SLIDER of string * int * int * (int -> unit)
        (* name and callback function and test sensitivity *)
      | PUSH of string * (unit -> unit) * (unit -> bool)
	(* name, get function, and callback function (set) and sensitive function*)
      | RADIO of string * (unit -> bool) * (bool -> unit) * (unit -> bool)
        (* cascade button and submenu specification *)
      | CASCADE of string * ButtonSpec list * (unit -> bool)
	(* cade button and function to create submenu specification *)
      | DYNAMIC of string * (unit -> ButtonSpec list) * (unit -> bool)

    (* cache of ids to reuse for dynamic menus *)
    val id_cache = ref []

    (* toggles:  (string * (bool -> unit) ref * (unit -> bool) ref) list *)
    (* This references stores all the toggle menu items along with their 
     * checked references and  sensitivity functions *)
    val toggles = ref []

    (* dynamics: (string * ButtonSpec list ref * (unit -> bool) ref) list *)
    (* This reference stores all the dynamic menu cascade items. *)
    val dynamics = ref []

    (* menuItems: (string * (unit -> unit) ref * (unit -> bool) ref) list *)
    (* This stores all the menu items (inc. toggles) and their associated action
     * and sensitivity functions *)
    val menuItems = ref []

    (* Handle of current window - used to set the focus back to current window 
     * after selecting a menu item *)
    val windowHandle = ref WindowsGui.nullWindow

    (* Stores the function which resets the menu items associated with a window,
     * when that window is closed. *)
    val deactivate_fun = ref (fn () => ())

     (* Used to reset the menu to the initial state in the situation when all the 
     * other windows are closed *)
    val initial_fn = ref (fn () => ())

    (* used to reset the menu when a window is closed *)
    fun quit () = ((!deactivate_fun) ();
                   deactivate_fun := (fn () => ());
                   (!initial_fn) ())

    (* get the reference within itemListRef associated with the name 'name' *)
    fun getMenuRef name itemListRef = 
      Lists.findp (fn (s,_,_) => (s = name)) (!itemListRef) 

    (* Adds a menu item to the reference list - called when creating the menu *)
    fun addRef name = 
      (if Lists.member (name, map (fn (s,_,_) => s) (!menuItems)) then ()
       else menuItems := (name, ref (fn () => ()), ref (fn () => true)) :: (!menuItems);
       getMenuRef name menuItems)

    fun addDynamicRef name = 
      (if Lists.member (name, map (fn (s,_,_) => s) (!dynamics)) then ()
      else dynamics := (name, ref (fn () => []), ref (fn () => true)) :: (!dynamics);
      getMenuRef name dynamics)

    (* Changes the action and sensitivity functions of a push button menu item *)
    fun changeItem (name, new_act, new_sens) = 
      let 
        val (name, act_ref, sens_ref) = getMenuRef name menuItems
       (* This exception is raised if the item 'name' cannot be found in the reference
        * list in which case the programmer has either got the name wrong in one of the
	* tools or has not added the name to the menu structure in the podium. *)
          handle Lists.Find => (print (name ^ " menu item not found in reference list\n");
                                ("", ref (fn () => ()), ref (fn () => false)))
      in
        act_ref := (fn () => (ignore(new_act()); 
                              ignore(WindowsGui.setFocus (!windowHandle)); 
                              ()));
	sens_ref := new_sens
      end

    (* Changes the action and sensitivity functions of a DYNAMIC menu item *)
    (* Also there is a subtle difference between changeItem and changeDynamic in 
     * changeItem calls WindowsGui.setFocus to set the focus back to the window which 
     * had the focus before selecting a menu item.  This is not done on dynamic
     * menus because the Windows menu is dynamic and we do not want to the focus
     * to the wrong window after selecting an item from the Windows menu *)
    fun changeDynamic (name, new_act, new_sens) = 
      let
        val (name, act_ref, sens_ref) = getMenuRef name dynamics
          handle Lists.Find => (print (name ^ " dynamic menu item not found in reference list\n");
                                ("", ref (new_act), ref (fn () => false)))
      in
        act_ref := new_act;
        sens_ref := new_sens
      end

    (* Changes the action and sensitivity function of a toggle menu item *)
    fun changeToggleItem (name, new_get, new_act, new_sens) = 
      let 
        val (name, act_ref, sens_ref) = getMenuRef name menuItems
          handle Lists.Find => (print (name ^ " menu item not found in reference list\n");
                                ("", ref (fn () => ()), ref (fn () => false)))

        val (name, toggle_ref, get_ref) =
          Lists.findp (fn (s,_,_) => (s = name)) (!toggles)
          handle Lists.Find => (print (name ^ " toggle menu item not found in reference list\n");
                                ("", ref false, ref (fn () => false)))
      in
        get_ref := new_get;
        act_ref := (fn () => (toggle_ref := not (!toggle_ref);
                              ignore(new_act (!toggle_ref));
                              ignore(WindowsGui.setFocus (!windowHandle)); ()));
        sens_ref := new_sens
      end

    (* This is used to store a function for updating the toolbar, ie. enabling and 
     * disabling buttons appropriately.  This function is attached to some message
     * handlers when the toolbar is created, and is also called when the menu items
     * change so that the menus and the toolbar are kept consistent with each other.
     *)
    val update_ref = ref (fn () => ())

    (* changeItems takes a widget, a ButtonSpec list and does the following:
     * This function is called by all windows, except the podium and is used to set up
     * a WM_ACTIVATE message handler to change the actions and sensitivity of the 
     * menu items when window focus changes. *)

    (* setItems is called by the Podium only, and sets up a function to change the 
     * menu actions back to their original state when all other windows have been
     * closed by the user. *)
    local
      fun get_sensitive SEPARATOR = false
        | get_sensitive (LABEL _) = false
        | get_sensitive (PUSH (name, act, sens)) = sens()
        | get_sensitive (SLIDER _) = false
        | get_sensitive (RADIO _) = false
        | get_sensitive (TOGGLE (name, get, act, sens)) = sens()
        | get_sensitive (DYNAMIC (name, blist, sens)) = sens()
        | get_sensitive (CASCADE (name, items, sens)) = 
		foldl (fn (a,b) => (get_sensitive a) orelse b) false items
      fun convertItems ((casc as (CASCADE (name, items, sens))) :: rest) sens_fn = 
             (changeItem (name, fn () => (), fn () => get_sensitive casc); 
	      convertItems (items @ rest) sens_fn)
        | convertItems ((PUSH (name, act, sens)) :: rest) sens_fn = 
              (changeItem (name, act, sens_fn sens); 
	       convertItems rest sens_fn)
        | convertItems ((TOGGLE (name, get, act, sens)) :: rest) sens_fn = 
              (changeToggleItem (name, get, act, sens_fn sens); 
	       convertItems rest sens_fn)
        | convertItems (SEPARATOR :: rest) sens_fn = convertItems rest sens_fn
        | convertItems ((LABEL _) :: rest) sens_fn = convertItems rest sens_fn
        | convertItems ((SLIDER _) :: rest) sens_fn = convertItems rest sens_fn
        | convertItems ((RADIO _) :: rest) sens_fn = convertItems rest sens_fn
        | convertItems ((DYNAMIC (name, act, sens)) :: rest) sens_fn = 
              (changeDynamic (name, act, sens_fn sens); 
	       convertItems rest sens_fn)
        | convertItems [] sens_fn = ()
    in
      fun changeItems (parent, itemList) = 
	let 
	  fun reset () = (convertItems itemList (fn _ => (fn _ => false)))
          fun convert () = (convertItems itemList (fn f => f))
          fun activate (WindowsGui.WPARAM w, WindowsGui.LPARAM l) =
            let
              val deactivated = 
                (WindowsGui.loword w) = (WindowsGui.convertWaValue WindowsGui.WA_INACTIVE)
            in
              windowHandle := CapiTypes.get_real parent;
              if (not deactivated) then 
           	((!deactivate_fun) ();
            	deactivate_fun := reset;
            	convert())
              else ();
	      (!update_ref) ();
              NONE
            end
	in
          WindowsGui.addMessageHandler(CapiTypes.get_real parent, WindowsGui.WM_ACTIVATE, activate)
	end

      fun setItems itemList = initial_fn := (fn () => (convertItems itemList (fn f => f)))
    end

    fun send_message (parent,message) =
      (WindowsGui.messageBeep WindowsGui.MB_ICONQUESTION;
       ignore(WindowsGui.messageBox (CapiTypes.get_real parent,message,"MLWorks",
                                  [WindowsGui.MB_OK,WindowsGui.MB_APPLMODAL]));
       ())

    (* These should use something from labelstrings *)
    (* Anyway, global ids will do *)
    val ok_env : int = env "win32 ok id"
    val cancel_env : int = env "win32 cancel id"
    val i2w = WindowsGui.intToWord

    (* the ids for apply and reset need to be the same for each dialog, 
     * therefore an id symbol is given to each of the controls in the 
     * resource editor, and this id symbol is used here to reference 
     * each control.
     *)
    val ok_id = i2w ok_env
    val apply_id = i2w (ControlName.getResID "IDAPPLY")
    val reset_id = i2w (ControlName.getResID "IDRESET")
    val cancel_id = i2w cancel_env

    (* This is called by every window, except the podium, and is used to change the 
     * actions and sensitivity functions of the menu items when window focus changes *)
    fun make_submenus (parent, itemList) = changeItems (parent, itemList)

    fun minimizefun window (WindowsGui.WPARAM w, l) = 
      (if (w = WindowsGui.nullWord) then 
         WindowsGui.showWindow(window, WindowsGui.SW_HIDE)
       else
         WindowsGui.showWindow(window, WindowsGui.SW_SHOW);
       NONE)

   (* Parent should be the top level window here *)
    fun make_menus (parent, menuspec, isPodium) =
      let
        val real_parent = CapiTypes.get_real parent
	val itemCount = ref 0
        fun add_item menu isSubmenu item =
	  (itemCount := (!itemCount) + 1;
           case item of
             SEPARATOR =>
               (WindowsGui.appendMenu (menu,[WindowsGui.MF_SEPARATOR],null_item,"");
                NONE)
           | LABEL name => 
               let
                 val label = LabelStrings.get_label name
                 val value = WindowsGui.ITEM WindowsGui.nullWord
               in
                 WindowsGui.appendMenu (menu, [WindowsGui.MF_STRING,WindowsGui.MF_DISABLED],value,label);
                 NONE
               end
           | TOGGLE (name,get,action,sensitive) =>
               let
                 val label = LabelStrings.get_label name
                 val id = LabelStrings.get_action name 
                 val value = WindowsGui.ITEM id
                 val checked = ref false
                 val get_ref = ref get

		(* Note here that the item 'name' is added to two lists - one called
		 * toggles which stores the get function reference and the checked 
		 * reference and the other list is the normal reference list to store
		 * the action and sensitivity functions. *)
                 val _ = if Lists.member (name, map (fn (s,_,_) => s) (!toggles)) then ()
                         else 
                           toggles := (name, checked, get_ref) :: (!toggles)
                 val (_, actionRef, sensitiveRef) = addRef name
               in
                 actionRef := (fn () => (checked := not (!checked);
                                         action (!checked)));
                 sensitiveRef := sensitive;
                 WindowsGui.appendMenu (menu,[WindowsGui.MF_STRING],value,label);
                 WindowsGui.addCommandHandler (real_parent,
                                            id,
                                            fn _ => (!actionRef) ());
                 SOME (fn _ =>
                              (checked := (!get_ref) ();
                               WindowsGui.enableMenuItem
                               (menu,
                                id,
                                [if (!sensitiveRef) ()
                                   then WindowsGui.MF_ENABLED
                                 else WindowsGui.MF_GRAYED]);
                               WindowsGui.checkMenuItem
                               (menu,
                                id,
                                [if !checked 
                                   then WindowsGui.MF_CHECKED
                                 else WindowsGui.MF_UNCHECKED])))
               end
           | SLIDER (name,min,max,set_value) =>
	      Crash.impossible "No sliders in MS Windows"
           | RADIO _ =>
	      Crash.impossible "No radio buttons in menus in MS Windows"
           | PUSH (name,action,sensitive) =>
               let
                 val label = LabelStrings.get_label name
                 val id = LabelStrings.get_action name 
                 val (_, actionRef, sensitiveRef) = addRef name
               in
                 actionRef := action;
                 sensitiveRef := sensitive;
                 WindowsGui.appendMenu (menu,[WindowsGui.MF_STRING],WindowsGui.ITEM id,label);
                 WindowsGui.addCommandHandler (real_parent,id,fn _ => (!actionRef) ());
                 SOME
                 (fn _ =>
                  WindowsGui.enableMenuItem
                  (menu,
                   id,
                   [if (!sensitiveRef) ()
                      then WindowsGui.MF_ENABLED
                    else WindowsGui.MF_GRAYED]))
               end
           (* we can use the same set of identifiers for all dynamic menus *)
           | DYNAMIC (name,f,sensitive) =>
               (* We need to handle a WM_INITMENUPOPUP message *)
               let
		 val (_, actionRef, sensitiveRef) = addDynamicRef name
                 val label = LabelStrings.get_label name
                 val submenu = WindowsGui.createPopupMenu()
                 val count_ref = ref 0
                 val all_ids = ref []
		 val base_count = (!itemCount) - 1

                 (* This should also delete the handler entries for the menu *)
		 fun loopto (dmenu, r, q) = 
		   if r <= q then ()
		   else
		     (WindowsGui.deleteMenu (dmenu,WindowsGui.intToWord (r-1),WindowsGui.MF_BYPOSITION);
		      loopto (dmenu, r-1, q))
                 fun loop n = loopto (submenu, n, 0)
                 fun get_id () =
                   case !id_cache of
                     [] => 
                       let
                         val id = WindowsGui.newControlId ()
                       in
                         all_ids := id :: !all_ids; id
                       end
                   | (id::rest) =>
                       (id_cache := rest;
                        all_ids := id :: !all_ids;
                        id)

                 fun add_dynamic_item menu (PUSH (name,action,sensitive)) =
                   let
                     val id = get_id ()
                   in
                     WindowsGui.appendMenu (menu,[WindowsGui.MF_STRING],WindowsGui.ITEM id,name);
                     WindowsGui.addCommandHandler (real_parent,id,fn _ => action ());
                     (fn _ =>
                      WindowsGui.enableMenuItem
                      (menu,id,
                       [if sensitive ()
                          then WindowsGui.MF_ENABLED
                        else WindowsGui.MF_GRAYED]))
                   end
                 | add_dynamic_item _ _ = Crash.impossible "add_dynamic_item"
                 (* This attempts to reuse the identifiers *)
                 fun init (the_menu, loop_fn) = 
                   (ignore(loop_fn (!count_ref));
                    id_cache := !all_ids @ !id_cache; (* add currently used ids to cache *)
                    all_ids := [];
                    let
                      val subfns = map (add_dynamic_item the_menu) ( (!actionRef) () )
                    in
                      count_ref := length subfns;
                      app (fn f => f ()) subfns
                    end)
               in
                 actionRef := f;
                 sensitiveRef := sensitive;
		 if name = "" then 
		   SOME (fn _ =>
		     (init (menu, fn n => loopto (menu, (!count_ref) + base_count, base_count))))
		 else
                   (WindowsGui.appendMenu (menu,[WindowsGui.MF_POPUP],WindowsGui.SUBMENU submenu,label);
                    SOME (fn _ => (init (submenu, loop))))
               end
           | CASCADE (name,subitems,sensitive) =>
               let
                 val label = LabelStrings.get_label name

		 (* Using LabelStrings.get_action to retrieve the id for some reason 
		  * retrieves an incorrect id and hence enabling and disabling a cascade
		  * menu item doesn't work.  A workaround is in place which uses the
		  * position of the cascade menu item to enable or disable it.  Also 
		  * only those cascade menu items which do not appear on the main menubar
		  * are ever disabled - this is intended. *)
		 val id = WindowsGui.intToWord ((!itemCount) - 1)
		 val temp = (!itemCount)
		 val _ = itemCount := 0
                 val (_, actionRef, sensitiveRef) = addRef name
                 val submenu = WindowsGui.createPopupMenu ()
		 fun enable_fn () = 
		   WindowsGui.enableMenuItem (menu, id, 
		      if (!sensitiveRef)() orelse (not isSubmenu) then 
			[WindowsGui.MF_ENABLED, WindowsGui.MF_BYPOSITION]
		      else
			[WindowsGui.MF_GRAYED, WindowsGui.MF_BYPOSITION])

                 val subfns = (SOME enable_fn) :: (map (add_item submenu true) subitems)
		 val _ = itemCount := temp
               in
		 sensitiveRef := sensitive;
		 if (!sensitiveRef)() orelse (not isSubmenu) then 
		   WindowsGui.appendMenu (menu, [WindowsGui.MF_POPUP,
					      WindowsGui.MF_ENABLED], 
							WindowsGui.SUBMENU submenu, label)
		 else
       	       	   WindowsGui.appendMenu (menu,[WindowsGui.MF_POPUP,
					     WindowsGui.MF_GRAYED],WindowsGui.SUBMENU submenu,label);
                 SOME
                 (fn _ =>
                  app (fn (SOME f) => f () | NONE => ()) subfns)
               end)
            
	(* This function is more general than necessary for Version 1.0,
	   but is useful for a more complete Help menu. *)
        fun add_help menu =
          let
            val help_menu = WindowsGui.createPopupMenu ()
            datatype Item = ITEM of string * WindowsGui.word | SEPARATOR
            fun add_item (ITEM (name,id)) =
                WindowsGui.appendMenu
		  (help_menu,[WindowsGui.MF_STRING],WindowsGui.ITEM id,name)
              | add_item SEPARATOR =
                WindowsGui.appendMenu (help_menu,[WindowsGui.MF_SEPARATOR],null_item,"")
	    fun help_item (name, action) = 
	      let 
                val label = LabelStrings.get_label name
                val id = LabelStrings.get_action name 
	      in
	        WindowsGui.addCommandHandler(real_parent, id, fn _ => action());
		ITEM (label, id)
	      end

	    fun getBitmap args = 
        	(MLWorks.Internal.Runtime.environment "win32 get splash bitmap") args
	    fun paintBitmap dc = 
		(MLWorks.Internal.Runtime.environment "win32 paint splash bitmap") dc  

	    val adWindow = ref WindowsGui.nullWindow
	    val licWindow = ref WindowsGui.nullWindow

	    fun mkDialog (resourceName, windowRef, creationFn) = 
	      let
		val w = 
		  if (WindowsGui.isWindow (!windowRef)) then (!windowRef) 
		  else WindowsGui.createDialog(WindowsGui.getModuleHandle(""), 
					       real_parent, resourceName)
		
		val _ = if (w = WindowsGui.nullWindow) then 
			  Crash.impossible "dialog resource not found\n"
			else ()

		fun destroyW _ = (WindowsGui.destroyWindow w; 
				  windowRef := WindowsGui.nullWindow)

		fun addCommands () = 
		  (WindowsGui.addCommandHandler(w, ok_id, destroyW);
                   WindowsGui.addMessageHandler(real_parent, WindowsGui.WM_SHOWWINDOW, 
                    			        minimizefun w))
              in
		if ((!windowRef) = WindowsGui.nullWindow) then
		  (ignore (creationFn w);
		   addCommands();
		   windowRef := w)
		else ();
		WindowsGui.showWindow (w, WindowsGui.SW_SHOW);
		WindowsGui.bringWindowToTop w
	      end

	    val help_items = 
	      let
		val open_web_location : string -> unit = env "win32 open web location"
		val source_path_opt = Getenv.get_source_path()
		val source_path = 
		  if isSome(source_path_opt) then 
		    valOf(source_path_opt)
		  else ""
		val doc_path = source_path ^ "\\documentation\\"
		fun guide () = 
		  open_web_location (doc_path ^ "guide\\html\\index.htm")
		fun reference () = 
		  open_web_location (doc_path ^ "reference\\html\\index.htm")
		fun install () = 
		  open_web_location (doc_path ^ "installation-notes\\html\\index.htm")
		fun relnotes () = 
		  open_web_location (doc_path ^ "release-notes\\html\\index.htm")
	      in
		(map help_item 
		  [("userGuide", guide),
		   ("referenceMan", reference),
		   ("installationHelp", install),
		   ("releaseNotes", relnotes)]) @ 
	      end

          in
            app add_item 
              (help_items @ [ITEM ("&About MLWorks...",       IDM_ABOUT)]);
            WindowsGui.appendMenu
	      (menu,[WindowsGui.MF_POPUP],WindowsGui.SUBMENU help_menu,"&Help")
          end

        val menu = WindowsGui.createMenu ()
        val itemfns = map (add_item menu false) menuspec
        fun update_fn _ =
          (app
           (fn NONE => ()
             | SOME f => f ())
           itemfns;
           SOME WindowsGui.nullWord)
      in
        add_help menu;
        WindowsGui.addMessageHandler (real_parent,WindowsGui.WM_INITMENU,update_fn);
	if isPodium then 
	  setItems menuspec
	else
	  changeItems (parent, menuspec);
        WindowsGui.setMenu (real_parent,menu)
      end

    (* The dependency graph and the tools menu have different menu structures between
     * Motif and Windows - see the signature file for details.
     *)
    fun get_graph_menuspec (close, graph) = [close, graph]
    fun get_tools_menuspec (tools_buttons, update_fn) = 
      CASCADE ("tools", tools_buttons @ 
			[SEPARATOR, 
			DYNAMIC ("", update_fn, k true)], fn _ => true)

    datatype ToolButton = TB_SEP | TB_TOGGLE | TB_PUSH | TB_GROUP | TB_TOGGLE_GROUP
    datatype ToolState = CHECKED | ENABLED | HIDDEN | GRAYED | PRESSED | WRAP
    datatype ToolButtonSpec = TOOLBUTTON of 
	{style:	ToolButton,
	 states: ToolState list,
	 tooltip_id: int,
	 name: string}

(* The following function shares the reference lists for storing the actions
 * and sensitivity functions of the menu items.  These functions can then
 * be obtained when only the name of the menu item is given, and also keeps
 * the tool buttons consistent with their associated menu items.
 *)
    fun make_toolbar (parent, bmp_id, buttonSpec) = 
      let 
	val i2w = WindowsGui.intToWord
	val pwin = CapiTypes.get_real parent
	val toolbar_id = WindowsGui.newControlId()
	val num_buttons = Lists.length buttonSpec
	val button_count = ref 0

        fun add_button (TOOLBUTTON
	    {style = style, states = states,
	     tooltip_id = tip_id, name = name}) = 
          let
 	    val id = if (style = TB_PUSH) orelse (style = TB_TOGGLE) then 
	        WindowsGui.newControlId() 
	      else
	        WindowsGui.nullWord
	    val style = 
	      case style of 
	          TB_SEP => WindowsGui.TBSTYLE_SEP
	        | TB_TOGGLE => WindowsGui.TBSTYLE_CHECK
	        | TB_PUSH => WindowsGui.TBSTYLE_BUTTON
	        | TB_GROUP => WindowsGui.TBSTYLE_GROUP
	        | TB_TOGGLE_GROUP => WindowsGui.TBSTYLE_CHECKGROUP
	    fun get_state state = 
	      case state of
	          CHECKED => WindowsGui.TBSTATE_CHECKED
	        | ENABLED => WindowsGui.TBSTATE_ENABLED
	        | HIDDEN => WindowsGui.TBSTATE_HIDDEN
	        | GRAYED => WindowsGui.TBSTATE_INDETERMINATE
	        | PRESSED => WindowsGui.TBSTATE_PRESSED
	        | WRAP => WindowsGui.TBSTATE_WRAP
	    val tb_states = map get_state states
	    fun addCommand () = 
	      let 
	(* Given a name of a menu item to be duplicated as a toolbutton, the action and
	 * sensitivity functions can be obtained from the reference lists used to update
	 * the single menu bar.
	 *)
		val (name, act_ref, sens_ref) = getMenuRef name menuItems
		  handle Lists.Find => 
			if (name <> "interruptButton") then raise Lists.Find 
			else ("interruptButton", ref (fn () => ()), ref (fn () => true))
	        fun command _ = (!act_ref)()
	      in 
	        (WindowsGui.addCommandHandler(pwin, id, command); 
	         sens_ref)
	      end
	    val sens_ref_opt = case style of 
	        WindowsGui.TBSTYLE_CHECK => SOME (addCommand())
	      | WindowsGui.TBSTYLE_BUTTON => SOME (addCommand())
	      | _ => NONE

	    val bitmap_index = 
	      if (style = WindowsGui.TBSTYLE_SEP) then
		0
	      else
		(!button_count)
          in
	    if (style <> WindowsGui.TBSTYLE_SEP) then button_count := (!button_count) + 1 else ();

	(* sens function followed by a further tuple containing:
	 *	(bitmap index, id, states, styles, res id of tooltip, string index) *)
	    (name, sens_ref_opt, (bitmap_index, id, tb_states, [style], i2w tip_id, 0))
          end

	val buttonList = map add_button buttonSpec
	val buttons = map #3 buttonList

	val widg = WindowsGui.createToolbarEx
                {parent = pwin, styles = [WindowsGui.TBSTYLE_TOOLTIPS, WindowsGui.WS_CHILD],
                 bmp_id = i2w bmp_id, toolbar_id = toolbar_id,
                 num_bmps = num_buttons, num_buttons = num_buttons,
                 x_bitmap = 16, y_bitmap = 16,
                 x_button = 16, y_button = 16,
                 buttons = buttons}

	val processNotify : WindowsGui.hwnd * WindowsGui.wparam * WindowsGui.lparam -> unit = 
		env "win32 process notify"
        fun process_notify (w,l) = (processNotify (widg,w,l); NONE)

	(* get_sens function takes a list of button info as returned by a mapped call
	 * to add_button, and returns a list of tuples storing (name, id, sens_function)
	 *)
	fun get_sens (name, sens, (_,id,_,_,_,_)) = (name, id, fn () => (!(valOf(sens))) () )

	(* sens_list stores a list of button info for those buttons that have a sensitivity 
	 * function, ie. only those of type TB_TOGGLE or TB_PUSH
	 *)
	val sens_list = Lists.filterp (fn (_,sens_ref_opt,_) => isSome sens_ref_opt) buttonList

	(* idsensList is a list of tuples (see comment on get_sens) for those buttons which 
	 * have a sensitivity function.  This list is used to update the toolbar so that the
	 * right buttons are enabled at the right time.
	 *)
	val idsensList = map get_sens sens_list

	fun setButtonState (id, states) = 
	  WindowsGui.sendMessage(widg, WindowsGui.TB_SETSTATE, WindowsGui.WPARAM id, 
	    WindowsGui.LPARAM (WindowsGui.tbStatesToWord states))

	fun isToggle name = Lists.member (name, map (fn (s,_,_) => s) (!toggles))
	fun toggleChecked name = 
	  if isToggle name then 
	    !(#2 (Lists.findp (fn (s,_,_) => (s = name)) (!toggles)))
	  else 
	    false

	fun get_states (name, sens_fn) = 
	  (if sens_fn() then WindowsGui.TBSTATE_ENABLED else WindowsGui.TBSTATE_INDETERMINATE) :: 
	  (if (isToggle name) andalso (toggleChecked name) then [WindowsGui.TBSTATE_CHECKED] 
	  else [])

	fun update_one (name, id, sens_fn) = setButtonState (id, get_states(name, sens_fn))

	fun update _ = (app (ignore o update_one) idsensList; NONE)
	val interrupt = env "win32 interrupt"
	val set_interrupt_window = env "nt set interrupt window"

	val (_,_,(_,interrupt_id,_,_,_,_)) = 
	  Lists.findp (fn (name,_,_) => (name = "interruptButton")) buttonList
      in
	ignore(set_interrupt_window widg);
	WindowsGui.addCommandHandler(pwin, interrupt_id, fn _ => interrupt());
	update_ref := (fn () => (app (ignore o update_one) idsensList; ()));
	WindowsGui.addMessageHandler(pwin, WindowsGui.WM_NCACTIVATE, update);
	WindowsGui.addMessageHandler(pwin, WindowsGui.WM_PARENTNOTIFY, update);
	WindowsGui.addMessageHandler(pwin, WindowsGui.WM_INITMENU, update);
        WindowsGui.addMessageHandler(pwin, WindowsGui.WM_NOTIFY, process_notify);
	CapiTypes.REAL (widg, parent)
      end	

    val sendMessageNoResult = ignore o WindowsGui.sendMessage;

    fun set_gui_font window =
      let
        val WindowsGui.OBJECT gui_font =
          WindowsGui.getStockObject (WindowsGui.DEFAULT_GUI_FONT)
          handle
            WindowsGui.WindowSystemError _ =>
              WindowsGui.getStockObject (WindowsGui.ANSI_VAR_FONT)
      in
        sendMessageNoResult
          (window,
           WindowsGui.WM_SETFONT,
           WindowsGui.WPARAM gui_font,
           WindowsGui.LPARAM (WindowsGui.intToWord 0))
      end
      handle WindowsGui.WindowSystemError _ => ()

    fun make_buttons (parent, menuspec) =
      (* parent is a "frame" type widget *)
      let
        val real_parent = CapiTypes.get_real parent
        (* This should calculate how big the buttons need to be *)
        val right_margin = 5
        val spacing = 5
        val top_margin = 5
        val height = 20
	val internal_space = 25
        val xref = ref right_margin
        (* now some stuff for calculating the text sizes *)
        val dc = WindowsGui.getDC real_parent

	val first_radio = ref true

	(* To change the font used by the button, we have to send a
	   WM_SETFONT message after the window is created.  But this
	   doesn't change the size of the window to match the text, so
	   we also change the font in the display context before working
	   out the size of the displayed string.  Changing the display
	   context alone does not change the font used in the display.
	 *)
	val _ =
	  let
            val WindowsGui.OBJECT gui_font =
              WindowsGui.getStockObject (WindowsGui.DEFAULT_GUI_FONT)
              handle
                WindowsGui.WindowSystemError _ =>
                  WindowsGui.getStockObject (WindowsGui.ANSI_VAR_FONT)
	  in
	    ignore(WindowsGui.selectObject (dc, WindowsGui.OBJECT gui_font));
	    ()
          end
	  handle WindowsGui.WindowSystemError _ => ()

        fun do_one (PUSH (name,callback,sensitive)) =
          let
            val id = LabelStrings.get_action name
            val label = LabelStrings.get_label name
            val (twidth,_) = WindowsGui.getTextExtentPoint (dc,label)
            val width = twidth + internal_space
            val button = 
              WindowsGui.createWindow
              {class = "BUTTON",
               name = label,
               styles = [WindowsGui.WS_CHILD,WindowsGui.BS_PUSHBUTTON],
               width = 10,
               height = 10,
               parent = real_parent,
               menu = id}
            fun set_sensitivity () =
              (ignore(WindowsGui.enableWindow (button,sensitive()));
               ())
          in
	    set_gui_font button;
            WindowsGui.moveWindow (button,!xref,top_margin,width,height,false);
            WindowsGui.showWindow (button,WindowsGui.SW_SHOW);
            WindowsGui.updateWindow button;
            xref := !xref + width + spacing;
            (* This should check what the notification event is *)
            WindowsGui.addCommandHandler (real_parent,id,fn n => callback ());
	    (* Push buttons add a command handler to their grandparent as
	       well.  In the MLWorks GUI, this is the top level widget.
	       This allows accelerators to refer to buttons as well as
	       menu entries.  It is fragile; changes in the window hierarchy
	       will break this. *)
            WindowsGui.addCommandHandler
	      (WindowsGui.getParent real_parent, id, fn n => callback ());
            set_sensitivity
          end
	| do_one (TOGGLE (name, get, set, sensitive)) =
	  let
            val id = LabelStrings.get_action name
            val label = LabelStrings.get_label name
            val (twidth,_) = WindowsGui.getTextExtentPoint (dc,label)
            val width = twidth + internal_space
            val button = 
              WindowsGui.createWindow
              {class = "BUTTON",
               name = label,
               styles = [WindowsGui.WS_CHILD,WindowsGui.BS_AUTOCHECKBOX],
               width = 10,
               height = 10,
               parent = real_parent,
               menu = id}
            fun set_sensitivity () =
              (WindowsGui.checkDlgButton (real_parent, id, if get() then 1 else 0);
	       ignore(WindowsGui.enableWindow (button,sensitive()));
               ())
	  in
	    set_gui_font button;
            WindowsGui.moveWindow (button,!xref,top_margin,width,height,false);
            WindowsGui.showWindow (button,WindowsGui.SW_SHOW);
            WindowsGui.updateWindow button;
            xref := !xref + width + spacing;
            WindowsGui.addCommandHandler 
	      (WindowsGui.getParent real_parent, id, fn n => set(not(get())));
            WindowsGui.addCommandHandler 
	      (WindowsGui.getParent (WindowsGui.getParent real_parent), id, fn n => set(not(get())));
            set_sensitivity
          end

	| do_one (RADIO (name, get, set, sensitive)) =
          let
            val id = LabelStrings.get_action name
            val label = LabelStrings.get_label name
            val (twidth,_) = WindowsGui.getTextExtentPoint (dc,label)
            val width = twidth + internal_space
            val button = 
              WindowsGui.createWindow
              {class = "BUTTON",
               name = label,
               styles = [WindowsGui.WS_CHILD,WindowsGui.BS_AUTORADIOBUTTON] @ 
			(if (!first_radio) then [WindowsGui.WS_GROUP] else []),
               width = 10,
               height = 10,
               parent = real_parent,
               menu = id}
            fun set_sensitivity () =
              (WindowsGui.checkDlgButton (real_parent, id, if get() then 1 else 0);
	       ignore(WindowsGui.enableWindow (button,sensitive()));
               ())
          in
	    set_gui_font button;
	    first_radio := false;
            WindowsGui.moveWindow (button,!xref,top_margin,width,height,false);
            WindowsGui.showWindow (button,WindowsGui.SW_SHOW);
            WindowsGui.updateWindow button;
            xref := !xref + width + spacing;

(* WWW *)  (* This should check what the notification event is *)
            WindowsGui.addCommandHandler 
	      (real_parent, id, fn n => set true);
            WindowsGui.addCommandHandler 
	      (WindowsGui.getParent real_parent, id, fn n => set true);
            WindowsGui.addCommandHandler 
	      (WindowsGui.getParent (WindowsGui.getParent real_parent), id, fn n => set true);
	
	    (* Push buttons add a command handler to their grandparent as
	       well.  In the MLWorks GUI, this is the top level widget.
	       This allows accelerators to refer to buttons as well as
	       menu entries.  It is fragile; changes in the window hierarchy
	       will break this. *)

            set_sensitivity
          end

        | do_one (LABEL (name)) =
          let
            val label = LabelStrings.get_label name
            val (twidth,_) = WindowsGui.getTextExtentPoint (dc,label)
            val width = twidth + internal_space
            val button =
              WindowsGui.createWindow
              {class = "STATIC",
               name = label,
               styles = [WindowsGui.WS_CHILD,WindowsGui.SS_CENTER],
               width = 10,
               height = 10,
               parent = real_parent,
               menu = WindowsGui.nullWord}
          in
	    set_gui_font button;
            WindowsGui.moveWindow (button,!xref,top_margin,width,height,false);
            WindowsGui.showWindow (button,WindowsGui.SW_SHOW);
            WindowsGui.updateWindow button;
            xref := !xref + width + spacing;
            fn _ => ()
          end
        | do_one (SLIDER (name,min,max,set_value)) =
            let
              val width = 300
              val id = LabelStrings.get_action name
              val label = LabelStrings.get_label name
              val curpos = ref 0
              val line_increment = (max - min) div 50
	      val page_increment = (max - min) div 10
              val slider =
                WindowsGui.createWindow
                {class = "SCROLLBAR",
                 name = label,
                 styles = [WindowsGui.WS_CHILD,WindowsGui.SBS_HORZ],
                 width = 10,
                 height = 10,
                 parent = real_parent,
                 menu = id}
                fun handler (WindowsGui.WPARAM wparam, WindowsGui.LPARAM lparam) =
                  let
                    val code = WindowsGui.loword wparam
		    val convert = WindowsGui.convertSbValue
		    val pos = 
		      if code = convert WindowsGui.SB_THUMBPOSITION then
			WindowsGui.hiword wparam
		      else if code = convert WindowsGui.SB_LINELEFT then 
			let val temp_pos = !curpos - line_increment
			in
			  if (temp_pos < min) then min else temp_pos
			end
		      else if code = convert WindowsGui.SB_LINERIGHT then
			let val temp_pos = !curpos + line_increment
			in
			  if (temp_pos > max) then max else temp_pos
			end
		      else if code = convert WindowsGui.SB_PAGELEFT then
			let val temp_pos = !curpos - page_increment
			in
			  if (temp_pos < min) then min else temp_pos
			end
		      else if code = convert WindowsGui.SB_PAGERIGHT then
			let val temp_pos = !curpos + page_increment
			in
			  if (temp_pos > max) then max else temp_pos
			end
		      else !curpos
                  in
		    set_value pos;
		    curpos := pos;
		    WindowsGui.setScrollPos (slider, WindowsGui.SB_CTL, pos, true);
                    SOME WindowsGui.nullWord
                  end
            in
              WindowsGui.setScrollRange (slider,WindowsGui.SB_CTL,min,max,false);
              WindowsGui.moveWindow (slider,!xref,top_margin,width,height,false);
              WindowsGui.showWindow (slider,WindowsGui.SW_SHOW);
              WindowsGui.updateWindow slider;
              xref := !xref + width + spacing;
              WindowsGui.addMessageHandler (real_parent,WindowsGui.WM_HSCROLL,handler);
              fn _ => ()
            end
        | do_one _ = (fn _ => ())
        val set_sensitivity_fns = map do_one menuspec
      in
        WindowsGui.releaseDC (real_parent,dc);
        {update = fn _ => app (fn f => f ()) set_sensitivity_fns,
	 set_focus = fn _ => ()}
      end

    (* DIALOGS *)

    datatype ItemTemplate =
      ITEMTEMPLATE of
      {styles: WindowsGui.window_style list,
       x: int,
       y: int,
       width: int,
       height: int,
       id : WindowsGui.word,
       class : string,
       text: string}

    (* For the moment, no menu, standard dialog class *)
    datatype Template =
      TEMPLATE of
      {styles: WindowsGui.window_style list,
       x: int,
       y: int,
       width: int,
       height: int,
       title: string,
       items: ItemTemplate list,
       nitems: int}

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
      OPTLIST of string * 
		 (unit -> string list * string list) * 
		 (string list -> bool) * 
		 selection

    val create_dialog_indirect : Template * WindowsGui.hwnd -> WindowsGui.hwnd = env "nt create dialog indirect"
    val dialog_box_indirect : Template * WindowsGui.hwnd -> int = env "nt dialog box indirect"

    (* Next 4 functions taken straight from _capi, need some sharing here *)
    fun munge_string s =
      let
        fun munge ([],acc) = implode (rev acc)
          | munge (#"\013" :: #"\010" :: rest,acc) = munge (rest, #"\010" :: #"\013" :: acc)
          | munge (#"\n" ::rest,acc) = munge (rest, #"\010" :: #"\013" :: acc)
          | munge (c::rest,acc) = munge (rest,c::acc)
      in
        munge (explode s,[])
      end


    fun set_text (window,s) =
      let
        val string_word = WindowsGui.makeCString (munge_string s)
      in
        sendMessageNoResult (window,WindowsGui.WM_SETTEXT,
                             WindowsGui.WPARAM (WindowsGui.nullWord),
                             WindowsGui.LPARAM string_word);
        WindowsGui.free string_word
      end

    fun text_size text =
      WindowsGui.wordToInt (WindowsGui.sendMessage (text,
                                              WindowsGui.WM_GETTEXTLENGTH,
                                              WindowsGui.WPARAM WindowsGui.nullWord,
                                              WindowsGui.LPARAM WindowsGui.nullWord))
    fun get_text (window) =
      let
        val size = text_size window
        (* What happens if the text changes at this point? *)
        val buffer = WindowsGui.malloc (size+1) (* extra for null termination *)
        (* should check for malloc failure here *)
        val _ = WindowsGui.sendMessage (window,
                                     WindowsGui.WM_GETTEXT,
                                     WindowsGui.WPARAM (WindowsGui.intToWord (size+1)), (* add 1 for the last null character *)
                                     WindowsGui.LPARAM buffer)
        val _ = WindowsGui.setByte (buffer,size,0) (* null terminate *) (* probably not necessary *)
        val result = WindowsGui.wordToString buffer
      in
        WindowsGui.free buffer;
        result
      end

    (* some dimensions *)
    val x_margin = 4
    val y_margin = 4
    val item_height = 10
    val text_height = 12
    val item_sep = 4
    val item_width = 150
    val text_width = 75
    val int_width = 40

    fun bell () = WindowsGui.messageBeep WindowsGui.MB_OK
      
    exception InvalidControl of string

    (* Once all dialogs created using Menus.create_dialog have been converted
     * to resources, the function convert_spec below will be superseeded by
     * resource_convert_spec, and should then be removed.
     *)
    fun convert_spec (title,action,speclist) =
      let
        val yref = ref y_margin
        fun do_spec (acc as (templates,initializers,setters,ids),spec) =
          case spec of
           OPTSEPARATOR => 
              let
                val template =
                  ITEMTEMPLATE
                  {styles = [WindowsGui.SS_GRAYRECT,
                             WindowsGui.WS_CHILD,
                             WindowsGui.WS_VISIBLE],
                   x = 0,
                   y = !yref,
                   width = item_width + x_margin + x_margin,
                   height = 1,
                   class = "STATIC",
                   text = "",
                   id = WindowsGui.nullWord}
              in
                yref := !yref + item_sep; 
                (template :: templates,initializers,setters,ids)
              end
          | OPTLABEL string =>
              let
                val template =
                  ITEMTEMPLATE
                  {styles = [WindowsGui.SS_LEFT,
                             WindowsGui.WS_CHILD,
                             WindowsGui.WS_VISIBLE],
                   x = x_margin,
                   y = !yref,
                   width = item_width,
                   height = item_height,
                   class = "STATIC",
                   text = LabelStrings.get_label string,
                   id = WindowsGui.nullWord}
              in
                yref := !yref + item_height + item_sep;
                (template :: templates,initializers,setters,ids)
              end
          | OPTTOGGLE (string,get,set) =>
              let
                val id = LabelStrings.get_action string
                val template =
                  ITEMTEMPLATE
                  {styles = [WindowsGui.BS_AUTOCHECKBOX,
                             WindowsGui.WS_CHILD,
                             WindowsGui.WS_TABSTOP,
                             WindowsGui.WS_VISIBLE],
                   x = x_margin,
                   y = !yref,
                   width = item_width,
                   height = item_height,
                   class = "BUTTON",
                   text = LabelStrings.get_label string,
                   id = id}
                fun initializer hwnd =
                  let val value = get ()
                  in WindowsGui.checkDlgButton (hwnd,id,if value then 1 else 0)
                  end
                fun setter hwnd =
                  let
		    val value = (WindowsGui.isDlgButtonChecked (hwnd,id) = 1)
		    val settable =  set value
		  in
		    if settable then () else (bell ();
					      initializer hwnd)
                  end
              in
                yref := !yref + item_height + item_sep;
                (template :: templates,
                 initializer:: initializers,
                 setter :: setters,
                 id :: ids)
              end
          | OPTTEXT (string,get,set) =>
              let
                val id = LabelStrings.get_action string
                val text_template =
                  ITEMTEMPLATE
                  {styles = [WindowsGui.WS_CHILD,
                             WindowsGui.WS_TABSTOP,
                             WindowsGui.WS_BORDER,
                             WindowsGui.WS_VISIBLE,
			     WindowsGui.ES_AUTOHSCROLL],
                   x = x_margin,
                   y = !yref,
                   width = text_width,
                   height = text_height,
                   class = "EDIT",
                   text = "",
                   id = id}
                val label_template =
                  ITEMTEMPLATE
                  {styles = [WindowsGui.WS_CHILD,
                             WindowsGui.SS_LEFT,
                             WindowsGui.WS_VISIBLE],
                   x = x_margin + text_width + 2,
                   y = !yref + text_height - item_height,
                   width = item_width - text_width,
                   height = item_height,
                   class = "STATIC",
                   text = LabelStrings.get_label string,
                   id = WindowsGui.nullWord}
                fun get_input_pane hwnd = WindowsGui.getDlgItem (hwnd,id)
                fun initializer hwnd = set_text (get_input_pane hwnd,get ())
                fun setter hwnd =
		  let val settable = set (get_text (get_input_pane hwnd))
		  in if settable then () else (bell();
					       initializer hwnd)
		  end
              in
                yref := !yref + text_height + item_sep;
                (label_template :: text_template :: templates,
                 initializer:: initializers,
                 setter :: setters,
                 id :: ids)
              end
	  | OPTCOMBO _ => raise InvalidControl "Combo box only available as resource"
	  | OPTLIST _ => raise InvalidControl "List box only available as resource"
          | OPTINT (string,get,set) =>
              let
                val id = LabelStrings.get_action string
                val text_template =
                  ITEMTEMPLATE
                  {styles = [WindowsGui.WS_CHILD,
                             WindowsGui.WS_BORDER,
                             WindowsGui.WS_TABSTOP,
                             WindowsGui.WS_VISIBLE],
                   x = x_margin,
                   y = !yref,
                   width = int_width,
                   height = text_height,
                   class = "EDIT",
                   text = "",
                   id = id}
                val label_template =
                  ITEMTEMPLATE
                  {styles = [WindowsGui.WS_CHILD,
                             WindowsGui.SS_LEFT,
                             WindowsGui.WS_VISIBLE],
                   x = x_margin + int_width + 2,
                   y = !yref + text_height - item_height,
                   width = item_width - int_width,
                   height = item_height,
                   class = "STATIC",
                   text = LabelStrings.get_label string,
                   id = WindowsGui.nullWord}
                fun get_input_pane hwnd = WindowsGui.getDlgItem (hwnd,id)
                fun initializer hwnd = set_text (get_input_pane hwnd,Int.toString (get ()))
                fun setter hwnd = 
		  let
		    val num = Int.fromString (get_text (get_input_pane hwnd))
		    val settable =
		      (case num of
			 SOME n => set n
		       | _ => false)
		  in
		    if settable then () else
		      (bell();
		       initializer hwnd)
		  end
              in
                yref := !yref + text_height + item_sep;
                (label_template :: text_template :: templates,
                 initializer:: initializers,
                 setter :: setters,
                 id :: ids)
              end
          | OPTRADIO (itemspecs) =>
              let
                val first = ref true
                fun do_one (OPTTOGGLE (string,get,set)) =
                  let
                    val is_first = !first
                    val _ = first := false
                    val id = LabelStrings.get_action string
                    val text = LabelStrings.get_label string
(*
                    val _ = print ("Radio: " ^ string ^ " " ^ W id ^ "\n")
*)
                    val template =
                      ITEMTEMPLATE
                      {styles = (if is_first then [WindowsGui.WS_GROUP,
                                                   WindowsGui.WS_TABSTOP]
                                 else []) @
                                [WindowsGui.WS_CHILD,
                                 WindowsGui.WS_VISIBLE,
                                 WindowsGui.BS_AUTORADIOBUTTON],
                       x = x_margin,
                       y = !yref,
                       width = item_width,
                       height = item_height,
                       class = "BUTTON",
                       text = text,
                       id = id}
                  in
                    yref := !yref + item_height + item_sep;
                    (template,(get,id,string),(set,id))
                  end
                  | do_one _ = Crash.impossible "Non toggle button in OPTRADIO"
                val stuff = map do_one itemspecs
                val new_templates = map #1 stuff
                val getids = map #2 stuff
                val setids = map #3 stuff
                val new_ids = map #2 getids
                fun get_ends (a::rest) =
                  let
                    fun aux [] = (a,a)
                      | aux [b] = (a,b)
                      | aux (b::rest) = aux rest
                  in
                    aux rest
                  end
                | get_ends _ = Crash.impossible "get_ends"
                val (first,last) = get_ends new_ids
                fun initializer hwnd =
                  Lists.iterate
                  (fn (get,id,string) =>
                   WindowsGui.checkDlgButton (hwnd,id,if get() then 1 else 0))
                  getids
(* check_radio_button seems to assume that the identifiers are in order *)                  
(* so we don't use it here *)
(*
                fun initializer hwnd =
                  Lists.iterate
                  (fn (get,id,string) =>
                   if get () then
                     (print ("Checking: " ^ string ^ " " ^ W first ^ " " ^ W last ^ " " ^ W id ^ "\n");
                      WindowsGui.checkRadioButton (hwnd,first,last,id))
                   else ())
                  getids
*)
                fun setter hwnd =
                  Lists.iterate
                  (fn (set,id) =>
                   if WindowsGui.isDlgButtonChecked (hwnd,id) = 1
                     then set true
                   else true)
                  setids
              in
                (* The templates etc. are accumulated in _reverse_ order *)
                (rev new_templates @ templates,
                 initializer :: initializers,
                 setter :: setters,
                 rev new_ids @ ids)
              end
        val (itemspecs,initializers,setters,ids) = Lists.reducel do_spec (([],[],[],[]),speclist)
        val button_specs =
          ITEMTEMPLATE
          {styles = [WindowsGui.SS_GRAYRECT,
                     WindowsGui.WS_CHILD,
                     WindowsGui.WS_VISIBLE],
           x = 0,
           y = !yref,
           width = item_width + x_margin + x_margin,
           height = 1,
           class = "STATIC",
           text = "",
           id = WindowsGui.nullWord} ::
          map 
          (fn (x,text,id,default) =>
           ITEMTEMPLATE
           {styles = [WindowsGui.WS_CHILD,
                      if default then WindowsGui.BS_DEFPUSHBUTTON
                      else WindowsGui.BS_PUSHBUTTON,
                      WindowsGui.WS_VISIBLE],
            x = x,
            y = !yref + item_sep,
            width = 30,
            height = 10,
            class = "BUTTON",
            text = text,
            id = id})
          [(x_margin,"OK",ok_id,true),
           (x_margin + 35,"Apply",apply_id,false),
           (x_margin + 70,"Reset",reset_id,false),
           (x_margin + 105,"Cancel",cancel_id,false)]
        val items = rev itemspecs @ button_specs
      in
        (TEMPLATE
         {styles = [WindowsGui.WS_POPUP,
                    WindowsGui.WS_CAPTION,
                    (* WindowsGui.WS_DLGFRAME, *) (* This seems to do nothing *)
                    WindowsGui.WS_SYSMENU,
                    WindowsGui.WS_VISIBLE],
          x = 40,
          y = 40,
          width = item_width + x_margin + x_margin + 2,
          height = !yref + y_margin + item_sep + 10,
          title = title,
          items = items,
          nitems = length items},
         rev initializers, rev setters, (* these fns in same order as the definition *)
         ids,
         (ok_id,apply_id,reset_id,cancel_id))
      end

    fun strip_string_controls (s:string):string =
      implode (List.filter (fn c=>not(c < #" ")) (explode s))

    local
      fun itemTextWidth (hwnd, combo) (_, (itemIndex, maxWidth)) =
        let
       	  val w = WindowsGui.WPARAM (WindowsGui.intToWord itemIndex)
          val l = WindowsGui.LPARAM WindowsGui.nullWord
	  val message = 
	    if combo then 
		WindowsGui.CB_GETLBTEXTLEN 
	    else 
		WindowsGui.LB_GETTEXTLEN
          val r = WindowsGui.sendMessage (hwnd, message, w, l)
          val maxWidth' = Int.max (WindowsGui.wordToInt r, maxWidth)
        in
          (itemIndex+1, maxWidth')
        end
    in
      fun itemsMaxTextWidth (hwnd, items, combo) = 
        let
          val (_, maxWidth) = 
	    List.foldl (itemTextWidth (hwnd, combo)) (0, 0) items
        in
          maxWidth
        end
    end  (* local *)

    (* add_items is used to add listbox and combobox items, therefore need to 
     * know whether to send the LB_ADDSTRING or CB_ADDSTRING Win32 API message *)
    fun add_items (hwnd, items, message) = 
      let 
        fun do_one item = 
          let val CString = WindowsGui.makeCString (strip_string_controls item)
          in
            sendMessageNoResult (hwnd, message,
    			         WindowsGui.WPARAM WindowsGui.nullWord,
	   			 WindowsGui.LPARAM CString);
	    WindowsGui.free CString
          end
      in
        Lists.iterate do_one items
      end

    fun resource_convert_spec speclist = 
      let 
	fun getResID name = WindowsGui.intToWord (ControlName.getResID name)
	fun do_spec ((initializers, setters, ids), idspec) = 
	  case idspec of
	    OPTTOGGLE (name, get, set) =>
	      let 
		val id = getResID name
		fun initializer hwnd = 
		  let val value = get()
		  in WindowsGui.checkDlgButton (hwnd, id, if value then 1 else 0)
		  end
		fun setter hwnd = 
		  let val settable = set (WindowsGui.isDlgButtonChecked (hwnd, id) = 1)
		  in if settable then () else (bell(); initializer hwnd)
		  end
	      in 
		(initializer :: initializers,
		setter :: setters,
		id :: ids)
	      end
	  | OPTTEXT (name, get, set) =>
	      let 
		val id = getResID name
		fun get_input_pane hwnd = WindowsGui.getDlgItem (hwnd,id)
		fun initializer hwnd = set_text (get_input_pane hwnd, get())
		fun setter hwnd = 
			(* get_text replaced with GetDlgItemText? *)
		  let val settable = set (get_text (get_input_pane hwnd))
		  in if settable then () else (bell();
					       initializer hwnd)
		  end
	      in
		(initializer :: initializers,
		setter :: setters,
		id :: ids)
	      end
	  | OPTCOMBO (name, get, set) => 
	      let
		val id = getResID name

		fun set_horizontal_extent hwnd = 
		  let 
		    val i2w = WindowsGui.intToWord
		    val charWidthInPixels = WindowsGui.loword(WindowsGui.getDialogBaseUnits())
		    val (init_string, items) = get()
		    val maxTextWidth = itemsMaxTextWidth (hwnd, items, true)
		  in
		    if maxTextWidth > 0 then
		      sendMessageNoResult
  			(hwnd, WindowsGui.CB_SETHORIZONTALEXTENT, 
			 WindowsGui.WPARAM (i2w (maxTextWidth * charWidthInPixels)),
			 WindowsGui.LPARAM WindowsGui.nullWord)
		    else ()
		  end

		fun initializer dialog = 
		  let 
		    val hwnd = WindowsGui.getDlgItem (dialog, id)
		  in
		    sendMessageNoResult(hwnd, WindowsGui.CB_RESETCONTENT, 
					WindowsGui.WPARAM WindowsGui.nullWord,
					WindowsGui.LPARAM WindowsGui.nullWord);
		    add_items (hwnd, #2(get()), WindowsGui.CB_ADDSTRING);
 		    set_horizontal_extent hwnd;
		    set_text (hwnd, #1(get()))
		  end

		fun setter dialog = 
		  let 
		    val new_text = get_text (WindowsGui.getDlgItem (dialog, id))
		    val settable = set new_text
		  in
		    if settable then () else
			(bell();
			initializer dialog)
		  end

	      in
		(initializer :: initializers,
		setter :: setters,
		id :: ids)
	      end
	  | OPTLIST (name, get, set, sel_type) =>
	      let
		val id = getResID name
		val null_w = WindowsGui.WPARAM WindowsGui.nullWord
		val null_l = WindowsGui.LPARAM WindowsGui.nullWord

		fun set_horizontal_extent hwnd = 
		  let 
		    val i2w = WindowsGui.intToWord
		    val charWidthInPixels = WindowsGui.loword(WindowsGui.getDialogBaseUnits())
		    val (items, sel_items) = get()
		    val maxTextWidth = itemsMaxTextWidth (hwnd, items, false)
		  in
		    if maxTextWidth > 0 then
		      sendMessageNoResult
  			(hwnd, WindowsGui.LB_SETHORIZONTALEXTENT, 
			 WindowsGui.WPARAM (i2w (maxTextWidth * charWidthInPixels)),
			 null_l) 
		    else ()
		  end

		fun select_items hwnd [] = ()
		  | select_items hwnd (str::rest) = 
		    let 
		      val w = WindowsGui.WPARAM (WindowsGui.intToWord (~1))
		      val CString = WindowsGui.makeCString (strip_string_controls str)
		      val l = WindowsGui.LPARAM CString
		    in
		      (* To select a value in an extended selection listbox, need
		       * to find the string in the listbox, given the index, then 
		       * use LB_SETSEL.  To select a value in a single selection 
		       * listbox, LB_SELECTSTRING can be used. *)
                      if sel_type = EXTENDED then 
			let val index = 
			      WindowsGui.sendMessage(hwnd, WindowsGui.LB_FINDSTRING, w, l)
			in
			  sendMessageNoResult
			    (hwnd, 
			     WindowsGui.LB_SETSEL, 
			     WindowsGui.WPARAM (WindowsGui.intToWord 1),
			     WindowsGui.LPARAM index)
			end
		      else
			sendMessageNoResult(hwnd, WindowsGui.LB_SELECTSTRING, w, l);
		      WindowsGui.free CString;
		      select_items hwnd rest
		    end

		fun initializer dialog = 
		  let 
		    val hwnd = WindowsGui.getDlgItem (dialog, id)
		    val (all_items, sel_items) = get()
		  in
		    sendMessageNoResult(hwnd, WindowsGui.LB_RESETCONTENT, null_w, null_l);
		    add_items (hwnd, all_items, WindowsGui.LB_ADDSTRING);
 		    set_horizontal_extent hwnd;
		    select_items hwnd sel_items
		  end

		fun setter dialog = 
		  let
		    val i2w = WindowsGui.intToWord
		    val hwnd = WindowsGui.getDlgItem (dialog, id)
		    val (all_items, sel_items) = get()
		    val maxWidth = itemsMaxTextWidth (hwnd, all_items, false)

		    fun get_list_string index = 
		      let
			val w = WindowsGui.WPARAM (WindowsGui.intToWord index)
		        val size = WindowsGui.wordToInt (WindowsGui.sendMessage 
				      (hwnd, WindowsGui.LB_GETTEXTLEN, w, null_l))

		        val buffer = WindowsGui.malloc (size+1)
		        (* should check for malloc failure here *)
		        val _ = WindowsGui.sendMessage 
				   (hwnd,
		                    WindowsGui.LB_GETTEXT, w,
		                    WindowsGui.LPARAM buffer)
		        val _ = WindowsGui.setByte (buffer,size,0) (* null terminate *)
		        val result = WindowsGui.wordToString buffer
		      in
		        WindowsGui.free buffer;
		        result
		      end

		    fun get_count () = 
		      WindowsGui.wordToInt 
			(WindowsGui.sendMessage
			   (hwnd, WindowsGui.LB_GETCOUNT, null_w, null_l))

		    (* The listbox can be sorted so we can't assume that the 
		     * selections appear in the list in the order they are given.
		     * Also this method of getting the selection strings applies 
		     * to both single and extended selection listboxes. *)
		    fun get_sel 0 sel_list = sel_list
		      | get_sel i sel_list = 
		        let
			  val w = WindowsGui.WPARAM (WindowsGui.intToWord (i-1))
			  val selected = 
			    (WindowsGui.sendMessage (hwnd, WindowsGui.LB_GETSEL, w, null_l)) <>
			    WindowsGui.nullWord
			  val new_sel_list = 
			    if selected then 
			      (get_list_string (i-1)) :: sel_list
			    else sel_list
			in
			  get_sel (i-1) new_sel_list
			end

		    val settable = set (get_sel (get_count()) [])

		  in
		    if settable then () else
			(bell();
			initializer dialog)
		  end (* fun setter *)

	      in
		(initializer :: initializers,
		setter :: setters,
		id :: ids)
	      end

	  | OPTINT (name, get, set) =>
	      let 
		val id = getResID name

		(* should be the following (setDlgItemInt):
		fun initializer hwnd = setDlgItemInt(hwnd, id, get(), true) *)

		fun get_input_pane hwnd = WindowsGui.getDlgItem (hwnd, id)
		fun initializer hwnd = set_text (get_input_pane hwnd,
						Int.toString (get()))
                fun setter hwnd = 
		  let
		    val num = Int.fromString (get_text (get_input_pane hwnd))
		    val settable = (case num of
			 		SOME n => set n
				       | _ => false)
		  in
		    if settable then () else
		      (bell(); initializer hwnd)
		  end
	      in 
		(initializer :: initializers,
		setter :: setters,
		id :: ids)
	      end
	  | OPTRADIO toggle_list =>
	      let 
		fun do_one (OPTTOGGLE (name, get, set)) =
		  (getResID name, get, set)
	          | do_one _ = Crash.impossible "Non toggle button in OPTRADIO"
	        val idgetset_list = map do_one toggle_list
		fun initializer hwnd = 
		  Lists.iterate (fn (id, get, set) => 
		    WindowsGui.checkDlgButton (hwnd, id, if get() then 1 else 0))
		    idgetset_list
		fun setter hwnd = 
		  Lists.iterate (fn (id, get, set) =>
		    if WindowsGui.isDlgButtonChecked (hwnd, id) = 1 then
		      set true
		    else true) idgetset_list
		val new_ids = map #1 idgetset_list
	      in
		(initializer :: initializers,
		setter :: setters,
		rev new_ids @ ids)
	      end
	  | _ => (initializers, setters, ids)
	val (initializers, setters, ids) = Lists.reducel do_spec (([],[],[]), speclist)
      in
	(TEMPLATE {styles=[], height=0, width=0, x=0, y=0, title="", items=[], nitems=0}, 
initializers, setters, ids, (ok_id, apply_id, reset_id, cancel_id))
      end


    (* isResourceDialog is temporary until all the dialogs have been
     * converted to resource dialogs.
     *)
    fun isResourceDialog str =
      case str of 
	"modeOptions" => true
      | "editorOptions" => true
      | "environmentOptions" => true
      | "languageOptions" => true
      | "compilerOptions" => true
      | _ => false 

    fun resourceDialog (window, resName) = 
      WindowsGui.createDialog (WindowsGui.getModuleHandle(""), window, resName)

    fun create_dialog (parent, title, name, action, spec) =
      let
        val (template,initializers,setters,ids,(ok_id,apply_id,reset_id,cancel_id)) = 
	  if (isResourceDialog name) then 
	    resource_convert_spec spec
	  else
	    convert_spec (title, action, spec)
        val window_ref = ref (WindowsGui.nullWindow)
        val changed_ref = ref false
        fun set_sensitivity window =
          (ignore(WindowsGui.enableWindow (WindowsGui.getDlgItem (window,apply_id),!changed_ref));
           ignore(WindowsGui.enableWindow (WindowsGui.getDlgItem (window,reset_id),!changed_ref));
           ())
        val real_parent = CapiTypes.get_real parent
      in
       (fn _ => 
        if WindowsGui.isWindow (!window_ref)
          then (windowHandle := (!window_ref);
		WindowsGui.bringWindowToTop (!window_ref))
        else
          let
            val dbox = if (isResourceDialog name) then
		resourceDialog (real_parent, name)
	      else
		create_dialog_indirect (template,real_parent)

	    val _ = if (dbox = WindowsGui.nullWindow) then 
		Crash.impossible "no resource for dialog\n"
		else ()
	    val _ = windowHandle := dbox

            val _ = WindowsGui.registerPopupWindow (dbox)
            fun destroy _ =
              (WindowsGui.unregisterPopupWindow dbox;
               WindowsGui.destroyWindow dbox)
          in
            WindowsGui.addMessageHandler(real_parent, WindowsGui.WM_SHOWWINDOW, 
                minimizefun dbox);
            (* We should attempt to remove these menu identifiers when we have finished *)
            Lists.iterate
            	(fn id => WindowsGui.addCommandHandler(dbox, id,
              	    fn _ => 
			if not (!changed_ref)
                	then (changed_ref := true;
                   	      set_sensitivity dbox; ())
              		else ()))
                ids;
            WindowsGui.addCommandHandler(dbox, ok_id,
             fn _ => (if !changed_ref
                      	then (Lists.iterate (fn f => f dbox) setters; action ())
                      	else ();
              	      destroy()));
            WindowsGui.addCommandHandler(dbox, apply_id,
             fn _ => (app (fn f => f dbox) setters;
              	      changed_ref := false;
              	      set_sensitivity dbox;
              	      action ()));
            WindowsGui.addCommandHandler(dbox, reset_id,
             fn _ => (app (fn f => f dbox) initializers;
		     changed_ref := false;
              	     set_sensitivity dbox));
            WindowsGui.addCommandHandler(dbox, cancel_id, destroy);
            window_ref := dbox;
            app (fn f => f dbox) initializers;
            changed_ref := false;
            set_sensitivity dbox;
            WindowsGui.showWindow (dbox,WindowsGui.SW_SHOW)
          end,
        fn _ => if WindowsGui.isWindow (!window_ref)
          	  then 
            	    (app (fn f => f (!window_ref)) initializers;
             	     changed_ref := false;
             	     set_sensitivity (!window_ref))
        	  else ())
      end

local
      fun tty_action (hwnd,_) =
        WindowsGui.endDialog (hwnd,2)
      fun exit_action (hwnd,_) =
        WindowsGui.endDialog (hwnd,1)
      fun cancel_action (hwnd,_) =
        WindowsGui.endDialog (hwnd,0)
      val quit_on_exit : unit -> unit = env "nt quit on exit"
    in
      fun exit_dialog (parent,applicationShell,has_controlling_tty) =
        let
          (* Currently ignores has_controlling_tty *)
	  (* a fixed set of control identifiers here *)
	  val tty_id = WindowsGui.newControlId ()
	  val exit_id = WindowsGui.newControlId ()
	  val cancel_id = i2w cancel_env
	  val _ =
	    (WindowsGui.addCommandHandler (WindowsGui.nullWindow,
					tty_id,tty_action);
	     WindowsGui.addCommandHandler (WindowsGui.nullWindow,
					exit_id,exit_action);
	     WindowsGui.addCommandHandler (WindowsGui.nullWindow,
					cancel_id,cancel_action))
          val button_y = 20
          val (dialog_width,items) =
            if has_controlling_tty
              then
                (190,
                 [ITEMTEMPLATE
                 {styles = [WindowsGui.WS_CHILD,
                            WindowsGui.SS_CENTER,
                            WindowsGui.WS_VISIBLE],
                  x = 0,
                  y = 5,
                  width = 190,
                  height = 15,
                  class = "STATIC",
                  text = "Select an action:",
                  id = WindowsGui.nullWord},
                 ITEMTEMPLATE
                 {styles = [WindowsGui.WS_CHILD,WindowsGui.BS_DEFPUSHBUTTON,
                            WindowsGui.WS_VISIBLE],
                  x = 5,
                  y = button_y,
                  width = 60,
                  height = 12,
                  class = "BUTTON",
                  text = "Return to TTY",
                  id = tty_id},
                 ITEMTEMPLATE
                 {styles = [WindowsGui.WS_CHILD,WindowsGui.BS_DEFPUSHBUTTON,
                            WindowsGui.WS_VISIBLE],
                  x = 75,
                  y = button_y,
                  width = 60,
                  height = 12,
                  class = "BUTTON",
                  text = "Exit MLWorks",
                  id = exit_id},
                 ITEMTEMPLATE
                 {styles = [WindowsGui.WS_CHILD,WindowsGui.BS_PUSHBUTTON,
                            WindowsGui.WS_VISIBLE],
                  x = 145,
                  y = button_y,
                  width = 40,
                  height = 12,
                  class = "BUTTON",
                  text = "Cancel",
                  id = cancel_id}])
            else
              (120,
               [ITEMTEMPLATE
                 {styles = [WindowsGui.WS_CHILD,
                            WindowsGui.SS_CENTER,
                            WindowsGui.WS_VISIBLE],
                  x = 0,
                  y = 5,
                  width = 100,
                  height = 15,
                  class = "STATIC",
                  text = "Select an action:",
                  id = WindowsGui.nullWord},
                 ITEMTEMPLATE
                 {styles = [WindowsGui.WS_CHILD,WindowsGui.BS_DEFPUSHBUTTON,
                            WindowsGui.WS_VISIBLE],
                  x = 5,
                  y = button_y,
                  width = 60,
                  height = 12,
                  class = "BUTTON",
                  text = "Exit MLWorks",
                  id = exit_id},
                 ITEMTEMPLATE
                 {styles = [WindowsGui.WS_CHILD,WindowsGui.BS_PUSHBUTTON,
                            WindowsGui.WS_VISIBLE],
                  x = 75,
                  y = button_y,
                  width = 40,
                  height = 12,
                  class = "BUTTON",
                  text = "Cancel",
                  id = cancel_id}])
          val template =
            TEMPLATE
            {styles = [WindowsGui.WS_POPUP,
                       WindowsGui.WS_CAPTION,
                       WindowsGui.DS_MODALFRAME], 
            x = 40,
            y = 40,
            width = dialog_width,
            height = 40,
            title = "Exit Dialog",
            items = items,
            nitems = length items}
          val result = dialog_box_indirect (template,CapiTypes.get_real parent)

	  fun do_destroy () = 
	    (WindowsGui.destroyWindow (CapiTypes.get_real applicationShell);
	     MLWorks.Internal.StandardIO.resetIO())

	  val uninitialise : unit -> unit = 
	    MLWorks.Internal.Runtime.environment "uninitialise mlworks"
        in
          case result of
            0 => ()
          | 1 => (do_destroy o quit_on_exit) ()
          | 2 => (do_destroy o uninitialise) ()
          | _ => print "Bad return from exit dialog"
        end
    end
  end

