(* Motif menu bar utilites *)
(*

$Log: _menus.sml,v $
Revision 1.55  1999/03/23 14:51:09  johnh
[Bug #190536]
Change help menu - add splash advert and about info.

 * Revision 1.54  1998/08/17  09:28:50  jkbrook
 * [Bug #30480]
 * Change case of HTML index pages
 *
 * Revision 1.53  1998/07/09  14:01:27  johnh
 * [Bug #30400]
 * remove main_windows arg from exit_dialog.
 *
 * Revision 1.52  1998/06/17  11:23:37  jkbrook
 * [Bug #30424]
 * Restore linking to doc
 *
 * Revision 1.51  1998/04/06  15:49:17  jkbrook
 * [Bug #50046]
 * Temporarily change HTML paths for Help menu
 *
 * Revision 1.50  1998/02/19  10:48:15  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.49  1997/11/06  14:06:09  johnh
 * [Bug #30125]
 * Add help menu.
 *
 * Revision 1.48  1997/10/28  12:32:56  johnh
 * [Bug #30059]
 * Add combo box OptionSpec type, although not implemented yet.
 * Also implement list boxes - both single and extended style.
 *
 * Revision 1.47  1997/09/18  15:17:15  daveb
 * [Bug #30077]
 * Explicitly set the labels of the buttons in the exit dialog, because
 * Solaris overrides the labels in MLWorks-mono.
 *
 * Revision 1.46  1997/09/08  08:49:26  johnh
 * [Bug #30241]
 * Implement proper find dialog.
 *
 * Revision 1.45  1997/06/16  14:46:31  johnh
 * [Bug #30174]
 * Moving stuff into platform specific podium.
 *
 * Revision 1.44  1997/06/13  09:35:09  johnh
 * [Bug #30175]
 * Changing dynamic menus implementation.
 *
 * Revision 1.43  1997/05/28  10:35:11  johnh
 * [Bug #30155]
 * Added get_graph_menuspec.
 *
 * Revision 1.42  1997/05/21  09:30:11  johnh
 * Implementing toolbar on Windows - added dummy function here.
 *
 * Revision 1.41  1997/05/16  14:51:40  johnh
 * Re-organising menus for Motif.
 *
 * Revision 1.40  1996/11/06  11:17:14  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.39  1996/10/30  19:49:08  io
 * moving String from toplevel
 *
 * Revision 1.38  1996/09/19  12:12:44  johnh
 * Bug #148.
 * Passed list of main windows to exit_dialog function so that they can
 * be killed.
 *
 * Revision 1.37  1996/08/09  15:25:32  nickb
 * Option dialog setter functions now return accept/reject.
 *
 * Revision 1.36  1996/07/12  16:47:09  andreww
 * Reset standard IO redirection mechanism to point to the terminal
 * after destroying GUI window.
 *
 * Revision 1.35  1996/05/28  10:47:29  matthew
 * Don't call update function with unchanged dialogs
 *
 * Revision 1.34  1996/05/01  10:36:41  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.33  1996/04/30  09:54:27  matthew
 * Use basis/integer
 *
 * Revision 1.32  1996/04/19  16:08:31  daveb
 * The activeFn argument to TOGGLE buttons was being ignored.  Fixed it.
 *
 * Revision 1.31  1996/02/26  15:25:24  matthew
 * Revisions to Xm library
 *
 * Revision 1.30  1995/10/17  16:23:03  nickb
 * Add sliders.
 *
 * Revision 1.29  1995/10/03  16:16:17  daveb
 * Made make_buttons return a set_focus function.
 *
 *  Revision 1.28  1995/08/30  10:02:43  matthew
 *  Removing OPTSUBMENU
 *
 *  Revision 1.27  1995/08/25  11:11:24  matthew
 *  Updating for Windows changes
 *
 *  Revision 1.26  1995/08/08  10:36:23  matthew
 *  Adding make_buttons function
 *
 *  Revision 1.25  1995/07/27  11:02:44  matthew
 *  Moved menus to gui
 *
 *  Revision 1.24  1995/07/26  14:12:26  matthew
 *  Restructuring directories
 *
 *  Revision 1.23  1995/07/06  13:31:58  matthew
 *  Changing the type of PUSHBUTTON callback type
 *
 *  Revision 1.22  1995/05/22  12:35:20  daveb
 *  Reinstated some lines commented out by the last change.
 *
 *  Revision 1.21  1995/05/04  10:04:48  matthew
 *  Fiddling about
 *  
 *  Revision 1.20  1995/04/20  12:27:53  matthew
 *  Moving set_sensitivity to motif_utils
 *  Added list managers
 *  New break/trace menu
 *  
 *  Revision 1.19  1993/10/13  11:57:01  daveb
 *  Merged in bug fix.
 *  
 *  Revision 1.18.1.2  1993/10/12  17:20:39  daveb
 *  Allowed negative numbers in OPTINT boxes.
 *  
 *  Revision 1.18.1.1  1993/08/19  14:25:05  jont
 *  Fork for bug fixing
 *  
 *  Revision 1.18  1993/08/19  14:25:05  matthew
 *  Added OPTSUBMENU to Option menu (a non-radio box submenu)
 *  
 *  Revision 1.17  1993/08/11  10:08:42  matthew
 *  Simplified interface.
 *  Return update function from create_dialog
 *  
 *  Revision 1.16  1993/08/10  13:02:16  matthew
 *  Bring options menu to front on managing
 *  
 *  Revision 1.15  1993/07/29  15:09:38  matthew
 *  Use modify verify callback to ensure digits in integer prompter
 *  
 *  Revision 1.14  1993/05/19  13:03:06  daveb
 *  Added the OPTRADIO constructor.
 *  
 *  Revision 1.13  1993/05/13  14:19:13  daveb
 *  create_dialog now takes a string to use for the title of the popup shell.
 *  
 *  Revision 1.12  1993/05/12  13:41:00  daveb
 *  Added comment about profligracy with callback ids in dynamic menus.
 *  
 *  Revision 1.11  1993/05/11  11:14:56  daveb
 *  Dynamic menus now create dummy submenus on startup.
 *  
 *  Revision 1.10  1993/05/05  11:13:23  matthew
 *  Added greying out of apply and reset buttons
 *  
 *  Revision 1.9  1993/04/30  13:29:56  matthew
 *  Added create_dialog_with_action.  This does something after a selection
 *  has been made.
 *  
 *  Revision 1.8  1993/04/19  15:14:45  matthew
 *  Added TOGGLE button class
 *  
 *  Revision 1.7  1993/04/16  14:23:24  daveb
 *  Added DYNAMIC menus.
 *  
 *  Revision 1.6  1993/04/14  12:10:28  matthew
 *  Made dialog boxes set to non-homogeneous
 *  ,
 *  
 *  Revision 1.5  1993/04/05  14:53:22  daveb
 *  Names of Callbacks have changed.
 *  
 *  Revision 1.4  1993/03/31  12:27:54  matthew
 *  Added OptionSpec type.  Simplified ButtonSpec and removed MenuSpec type
 *  Now separate functions for making an ordinary menu and an options menu
 *  
 *  Revision 1.3  1993/03/26  18:48:19  matthew
 *  Added create_dialog function
 *  Changed callback types
 *  
 *  Revision 1.2  1993/03/23  14:22:09  matthew
 *  Much changed
 *  Extended types of button specifications
 *  Uses gadgets instead of widgets
 *  Added updating functions
 *  Return "menu update function" rather than widget
 *  
 *  Revision 1.1  1993/03/17  16:32:33  matthew
 *  Initial revision
 *  
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
require "^.basis.__char";
require "^.basis.__list";
require "../motif/xm";
require "../utils/lists";
require "../utils/getenv";
require "../main/version";

require "../gui/menus";


(* some utility functions for specifying menus *)

functor Menus (structure Xm : XM
               structure Lists : LISTS
	       structure Getenv : GETENV
	       structure Version : VERSION
                 ) : MENUS =
  struct

    type Widget = Xm.widget

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

    fun env s = MLWorks.Internal.Value.cast (MLWorks.Internal.Runtime.environment s)

    fun k x y = x

    fun set_sensitivity (widget,sensitivity) =
      Xm.Widget.valuesSet (widget,[(Xm.SENSITIVE, Xm.BOOL sensitivity)])

(* Taken from _capi.sml *)
    fun send_message (parent,message) =
      let
        val dialog =
          Xm.Widget.createPopupShell ("messageDialog",
                                    Xm.Widget.DIALOG_SHELL,
                                    parent, [])
            
        val widget =
          Xm.Widget.create
          ("message", Xm.Widget.MESSAGE_BOX, dialog,
           [(Xm.MESSAGE_STRING, 
	     Xm.COMPOUND_STRING (Xm.CompoundString.createLtoR (message, Xm.CHAR_SET "")))])

        val _ =
          map 
           (fn c =>
             Xm.Widget.unmanageChild (Xm.MessageBox.getChild(widget,c)))
           [Xm.Child.CANCEL_BUTTON,
            Xm.Child.HELP_BUTTON]

        (* This really ought to reuse dialogs *)
        fun exit _ = Xm.Widget.destroy dialog
      in
        Xm.Callback.add (widget, Xm.Callback.OK, exit);
        Xm.Widget.manage widget
      end

    fun set_focus w =
      (ignore(Xm.Widget.processTraversal (w, Xm.Widget.TRAVERSE_CURRENT));
       ())

    (* The get_sensitive function is used to get the sensitivity of all the menu
     * items below a CASCADE menu item, and this is in turn used to set the 
     * sensitivity of the CASCADE item. *)
    fun get_sensitive SEPARATOR = false
      | get_sensitive (LABEL _) = false
      | get_sensitive (PUSH (name, act, sens)) = sens()
      | get_sensitive (SLIDER _) = false
      | get_sensitive (RADIO _) = false
      | get_sensitive (TOGGLE (name, get, act, sens)) = sens()
      | get_sensitive (DYNAMIC (name, blist, sens)) = sens()
      | get_sensitive (CASCADE (name, items, sens)) = 
		foldl (fn (a,b) => (get_sensitive a) orelse b) false items

    (* make_button returns an update function and a set_focus function *)
    fun make_button (parent,SEPARATOR) =
      let
        val widget = Xm.Widget.createManaged ("separator",
                                              Xm.Widget.SEPARATOR_GADGET,
                                              parent,[])
      in
        (fn _ => (), fn () => set_focus widget)
      end

      | make_button (parent,LABEL name) =
      let
        val widget =
          Xm.Widget.createManaged (name,
                                   Xm.Widget.LABEL_GADGET,
                                   parent, [])
      in
        (fn _ => (), fn () => set_focus widget)
      end
      
      | make_button (parent,TOGGLE(name,get_value,set_value,activefn)) =
        let
          val widget =
            Xm.Widget.createManaged (name,
                                     Xm.Widget.TOGGLE_BUTTON_GADGET,
                                     parent,[])
          fun callback_fun data =
            let
              val (_,_,n) = Xm.Callback.convertToggleButton data
              val value = not (n = 0)
            in
              set_value value
            end

        in
          Xm.Callback.add (widget,
                                 Xm.Callback.VALUE_CHANGED,
                                 callback_fun);
          (fn _ =>
             (Xm.Widget.valuesSet (widget,[(Xm.SET,Xm.BOOL (get_value()))]);
              set_sensitivity (widget,activefn ())),
	   fn () => set_focus widget)
        end

      | make_button (parent, RADIO (name, get, set, activefn)) = 
        make_button (parent, TOGGLE(name, get, set, activefn))

      | make_button (parent, SLIDER (name,min,max, set_value)) = 
	let
	  val widget = 
	    Xm.Widget.createManaged (name,
				     Xm.Widget.SCALE,
				     parent,[(Xm.MINIMUM, Xm.INT min),
					     (Xm.MAXIMUM, Xm.INT max)])
	  fun callback_fun data  =
	    let val (_,_,n) = Xm.Callback.convertScale data
	    in set_value n
	    end
	in
	  Xm.Callback.add (widget,
				 Xm.Callback.VALUE_CHANGED,
				 callback_fun);
	  Xm.Callback.add (widget,
				 Xm.Callback.DRAG,
				 callback_fun);
	  (fn _ => (),
	   fn () => set_focus widget)
	end
      | make_button (parent,PUSH (name,callback,activefn)) =
        let
          val widget =
            Xm.Widget.createManaged (name,
                                    Xm.Widget.PUSH_BUTTON_GADGET,
                                     parent, [])
        in
          Xm.Callback.add (widget,
                                 Xm.Callback.ACTIVATE,
                                 fn _ => callback ());
          (fn _ => set_sensitivity (widget,activefn ()),
	   fn () => set_focus widget)
        end
      
      | make_button (parent,CASCADE (name,submenuspec,activefn)) =
        let
          val menu =
            Xm.Widget.createPulldownMenu (parent,
                                          name ^ "Menu",
                                          [])
          val {update, ...} = make_buttons (menu,submenuspec)
          val widget =
            Xm.Widget.createManaged (name,
                                     Xm.Widget.CASCADE_BUTTON_GADGET,
                                     parent,
                                     [(Xm.SUBMENU_ID, Xm.WIDGET menu)])

	  fun active_fn () = get_sensitive (CASCADE (name, submenuspec, activefn))
        in
          Xm.Callback.add (widget,
                                 Xm.Callback.CASCADING,
                                 fn _ => update());
          (fn _ => set_sensitivity (widget,active_fn ()),
	   fn () => set_focus widget)
        end

      | make_button (parent,DYNAMIC (name,submenuspecfn,activefn)) =
        let
          val widget =
            Xm.Widget.createManaged (name,
                                     Xm.Widget.CASCADE_BUTTON_GADGET,
                                     parent,[])

	  (* Make a dummy menu to set the cascade marker when appropriate. *)
          val menu =
            Xm.Widget.createPulldownMenu (parent,
                                          name ^ "Menu",
                                          [])

	  val _ = Xm.Widget.valuesSet (widget, [(Xm.SUBMENU_ID, Xm.WIDGET menu)])

          fun update_function _ =
	    (* NB. This is rather wasteful of callback ids. *)
	    let
              val menu =
                Xm.Widget.createPulldownMenu (parent,
                                              name ^ "Menu",
                                              [])

	      val {update, ...} = make_buttons (menu,submenuspecfn());
            in
	      update ();
              Xm.Widget.valuesSet (widget, [(Xm.SUBMENU_ID, Xm.WIDGET menu)])
            end
        in
          Xm.Callback.add (widget,
                                 Xm.Callback.CASCADING,
                                 update_function);
          (fn _ => set_sensitivity (widget,activefn ()),
	   fn () => set_focus widget)
        end

    (* main function *)
    and make_buttons (parent, menuspec) =
      let
        val res_list = 
	  (map (fn buttonspec => make_button (parent,buttonspec)) menuspec)
      in
        {update = fn () => app (fn (f, _) => f ()) res_list,
	 set_focus = fn n => (#2 (Lists.nth (n, res_list))) ()} (* should be changed to List.nth repercussions? *)
      end

    (* make_buttons and make_submenus need to be separate for Windoze *)
    fun make_submenus (menuBar, menuSpec) =
      let 
        val menu =
          Xm.Widget.createPulldownMenu (menuBar, "HelpMenu", [])

        val help_menu =
          Xm.Widget.createManaged ("help_menu",
                                   Xm.Widget.CASCADE_BUTTON_GADGET,
                                   menuBar,
                                   [(Xm.SUBMENU_ID, Xm.WIDGET menu)])
	
	val open_web_location : string -> string = env "x open web location"

	val doc_path_opt = Getenv.get_doc_dir()
	val doc_path = getOpt(doc_path_opt, "")

	fun open_help_file path () = 
	  let val result_str = open_web_location (doc_path ^ path ^ "/INDEX.HTM")
	  in
	    if (result_str <> "") then send_message(menuBar, result_str) else ()
	  end

	fun aboutMLW () = send_message (menuBar, Version.versionString())
      in
	ignore(make_buttons (menu,
	    [PUSH ("HM_userGuide", 	  open_help_file "/guide/htm/unix",   fn _ => true),
	     PUSH ("HM_referenceMan", 	  open_help_file "/reference/htm",    fn _ => true),
	     PUSH ("HM_installationHelp", open_help_file "/install/htm/unix", fn _ => true),
	     PUSH ("HM_releaseNotes", 	  open_help_file "/relnotes/htm",     fn _ => true),
	     SEPARATOR] @
	    [PUSH ("HM_aboutMLW", aboutMLW, fn _ => true)]));
        Xm.Widget.valuesSet (menuBar, [(Xm.MENU_HELP_WIDGET, Xm.WIDGET help_menu)]);
	ignore(make_buttons (menuBar, menuSpec));
	()
      end

    fun make_menus (parent, menuSpec, isPodium) = make_submenus (parent, menuSpec)
    fun quit () = ()

    (* The dependency graph and the tools menu have different menu structures between
     * Motif and Windows - see the signature file for details.
     *)
    fun get_graph_menuspec (close, graph) = 
      [CASCADE ("action", [close], fn _ => true),
       CASCADE ("view", [graph], fn _ => true)]
    fun get_tools_menuspec (tools_buttons, update_fn) = 
      DYNAMIC ("tools", fn _ => (tools_buttons @ [SEPARATOR] @ update_fn()), k true)

    datatype ToolButton = TB_SEP | TB_TOGGLE | TB_PUSH | TB_GROUP | TB_TOGGLE_GROUP
    datatype ToolState = CHECKED | ENABLED | HIDDEN | GRAYED | PRESSED | WRAP
    datatype ToolButtonSpec = TOOLBUTTON of 
	{style:	ToolButton,
	 states: ToolState list,
	 tooltip_id: int,
	 name: string}

    fun make_toolbar (parent, bmp_id, tbSpec) = 
	Xm.Widget.create("dummy", Xm.Widget.SEPARATOR_GADGET, parent, [])

    fun make_option (parent,OPTSEPARATOR,select_fn) =
      let
        val widget = Xm.Widget.createManaged ("separator",
                                              Xm.Widget.SEPARATOR_GADGET,
                                              parent,[])
      in
        (fn _ => (),fn _ => ())
      end

      | make_option (parent,OPTLABEL name,select_fn) =
      let
        val widget =
          Xm.Widget.createManaged (name,
                                   Xm.Widget.LABEL_GADGET,
                                   parent, [])
      in
        (fn _ => (),fn _ => ())
      end
      
      | make_option (parent,OPTTOGGLE (name,get_value,set_value),select_fn) =
      let
        val widget =
          Xm.Widget.createManaged (name,
                                   Xm.Widget.TOGGLE_BUTTON_GADGET,
                                   parent, [])
	fun show () = Xm.Widget.valuesSet (widget,
					   [(Xm.SET,Xm.BOOL (get_value()))])
	fun set () = let
		       val xval = Xm.Widget.valuesGet (widget,[Xm.SET])
		       val settable =
			 case xval of
			   [Xm.BOOL b] => set_value b
			 | _ => false
		     in
		       if settable then () else
			 Xm.Display.bell (Xm.Widget.display parent, 0)
		     end
      in
        Xm.Callback.add(widget,Xm.Callback.VALUE_CHANGED,select_fn);
        (show, set)
      end

      | make_option (parent, OPTTEXT (name,get_value,set_value),select_fn) =
        let
          val frame =
            Xm.Widget.createManaged ("textInputFrame",
                                     Xm.Widget.ROW_COLUMN,
                                     parent,[])
          val text =
            Xm.Widget.createManaged ("textInput",
                                     Xm.Widget.TEXT,
                                     frame,[])
          val label =
            Xm.Widget.createManaged (name,
                                     Xm.Widget.LABEL,
                                     frame,[])
	  fun show () = Xm.Text.setString(text, get_value())
	  fun set () = let val settable = set_value (Xm.Text.getString text)
		       in if settable then () else
			 (Xm.Display.bell (Xm.Widget.display parent, 0);
			  show())
		       end
        in
          Xm.Callback.add(text,Xm.Callback.MODIFY_VERIFY,select_fn);
          (show,set)
        end

      | make_option (parent, OPTLIST (name, get_value, set_value, sel_type), select_fn) = 
	let
	  fun get_sel_pos _ [] = ~1
	    | get_sel_pos item ((s,pos)::rest) = 
		if item = s then pos
		else get_sel_pos item rest

	  fun sel_pos [] pos_items = []
	    | sel_pos (item::rest) pos_items = 
		let val pos = get_sel_pos item pos_items
		in
		  if pos <> ~1 then pos::(sel_pos rest pos_items)
		  else sel_pos rest pos_items
		end

          val listScroll = 
	    Xm.Widget.createManaged ("scroll", Xm.Widget.SCROLLED_WINDOW, parent,[])

	  val listbox = 
	    Xm.Widget.createManaged ("listbox", Xm.Widget.LIST, listScroll,
				     (if sel_type = EXTENDED then
					[(Xm.HEIGHT, Xm.INT 120),
					 (Xm.SELECTION_POLICY,
					  Xm.SELECTION_POLICY_VALUE Xm.EXTENDED_SELECT)]
				      else 
					[(Xm.HEIGHT, Xm.INT 80),
					 (Xm.SELECTION_POLICY,
					  Xm.SELECTION_POLICY_VALUE Xm.SINGLE_SELECT)]))

	  fun show () = 
	    let 
              val (items, sel_items) = get_value()
              val (pos_items, _) = Lists.number_from_by_one (items, 1, fn n => n)
	      val sel_positions = sel_pos sel_items pos_items
	    in
	      Xm.List.deleteAllItems listbox;
              Xm.List.addItems (listbox, map Xm.CompoundString.createSimple items, 0);
	      app (fn pos => Xm.List.selectPos (listbox, pos, false)) sel_positions;
	      ()
	    end

	  fun set () = 
	    let 

              val (items, sel_items) = get_value()
              val (pos_items, _) = Lists.number_from_by_one (items, 1, fn n => n)

	      val pos_vector = Xm.List.getSelectedPos listbox
	      val num_sel = MLWorks.Internal.Vector.length pos_vector
	      fun set_sel n = 
		if n = num_sel then []
		else MLWorks.Internal.Vector.sub (pos_vector, n) :: (set_sel (n+1))
	      val select_pos = set_sel 0

	      fun get_item_by_pos [] _ = ""
		| get_item_by_pos ((item, pos2)::rest) pos = 
		    if pos = pos2 then item else get_item_by_pos rest pos

	      val new_sel_items = map (get_item_by_pos pos_items) select_pos

	      val settable = set_value new_sel_items
	    in
	      if settable then () else
		(Xm.Display.bell (Xm.Widget.display parent, 0);
		 show())
	    end

	  val modify_callback = 
	    if sel_type = EXTENDED then 
	      Xm.Callback.EXTENDED_SELECTION 
	    else Xm.Callback.SINGLE_SELECTION
	in
	  Xm.Callback.add(listbox, modify_callback, select_fn);
          (show,set)
	end

      | make_option (parent, OPTCOMBO (name, get, set), select_fn) = 
	  make_option (parent, OPTLIST (name, 
					fn () => (#2(get()), [#1(get())]), 
					fn [] => false
					 | (a::rest) => set a,
					SINGLE), select_fn)

      | make_option (parent, OPTINT (name,get_value,set_value),select_fn) =
        let
          fun modifyVerify callback_data =
            let
              val (_,_,doit,_,_,start_pos,end_pos,str) =
                Xm.Callback.convertTextVerify callback_data


	      (* replace this when enough time *)
              val yesno =
		case explode str
		  of #"~" :: l => List.all Char.isDigit l
		|  l => List.all Char.isDigit l
	    (* replace this *)
		  

		  
            in
              Xm.Boolean.set (doit,yesno);
              if yesno then select_fn callback_data else ()
            end

          val frame =
            Xm.Widget.createManaged ("intInputFrame",
                                     Xm.Widget.ROW_COLUMN,
                                     parent,[])
          val text =
            Xm.Widget.createManaged ("intInput",
                                     Xm.Widget.TEXT,
                                     frame,[])
          val label =
            Xm.Widget.createManaged (name,
                                     Xm.Widget.LABEL,
				     frame,[])
	  fun show () = Xm.Text.setString(text,Int.toString(get_value()))
	  fun set () = let
			 val num = Int.fromString (Xm.Text.getString text)
			 val settable = 
			   (case num of
			      SOME n => set_value n
			    | NONE => false)
		       in
			 if settable then () else
			   (Xm.Display.bell (Xm.Widget.display parent, 0);
			    show())
		       end
        in
          Xm.Callback.add(text,Xm.Callback.MODIFY_VERIFY,modifyVerify);
          (show,set)
        end
      | make_option (parent, OPTRADIO (optionspec), select_fn) =
        let
          val frame =
            Xm.Widget.createManaged ("radioFrame",
                                     Xm.Widget.ROW_COLUMN,
                                     parent,
				     [(Xm.RADIO_BEHAVIOR, Xm.BOOL true),
				      (Xm.PACKING, Xm.PACKING_VALUE Xm.PACK_TIGHT)])
        in
	  (* Should possibly do something with select_fn, but it doesn't match
	     the type of the select_fn expected by make_options_with_select. *)
	  make_options_with_select' (frame, optionspec, select_fn)
        end
    and make_options_with_select' (parent, optionspec, select_fn) =
      let
        val functions =
	  map (fn spec => make_option(parent,spec,select_fn)) optionspec
      in
        (fn () => app (fn (f,g) => f()) functions,
         fn () => app (fn (f,g) => g()) functions)
      end
          
    and make_options_with_select (parent, optionspec, select_fn) =
       make_options_with_select' (parent, optionspec, fn _ => select_fn ())

    and make_options  (parent, optionspec) =
      make_options_with_select (parent,optionspec,fn () => ())

    fun create_dialog (parent,title,name,action,optionsspec) =
      let
        val shell = Xm.Widget.createPopupShell (name,
                                                Xm.Widget.DIALOG_SHELL,
                                                parent,
						[(Xm.TITLE, Xm.STRING title),
     						 (Xm.ICON_NAME, Xm.STRING title)])
        val form = Xm.Widget.create ("optionsForm",
                                     Xm.Widget.FORM,
                                     shell,[])
        val frame = Xm.Widget.createManaged (name,
                                             Xm.Widget.ROW_COLUMN,
                                             form,
                                             [])
        (* Hack to make all dialog boxes non-homogeneous *)
        (* else radio boxes with labels generate warnings *)
        val _ = Xm.Widget.valuesSet(frame,[(Xm.IS_HOMOGENEOUS,Xm.BOOL false)])
        val separator = Xm.Widget.createManaged ("separator",
                                                 Xm.Widget.SEPARATOR,
                                                 form,[])
        val dialogButtons = Xm.Widget.createManaged ("dialogButtons",
                                                     Xm.Widget.ROW_COLUMN,
                                                     form,
                                                     [])
        val values_selected = ref false
        val set_selected_hook = ref (fn () => ())
        fun set_selected () = (!set_selected_hook) ()
        fun selection_made () =
          if not (!values_selected)
            then
              (values_selected := true;
               set_selected ())
          else ()
        val (update_fn,apply_fn) = make_options_with_select (frame,optionsspec,selection_made)
        fun maybe_fn _ =
          if !values_selected then (apply_fn (); action ())
          else ()

        val {update = buttons_update_fn, ...} = 
          make_buttons
          (dialogButtons,
           [PUSH ("ok",
                  fn _ => (maybe_fn ();
                           Xm.Widget.unmanageChild form),
                  fn _ => true),
            PUSH ("apply",
                  fn _ => (apply_fn ();
                           values_selected := false;
                           set_selected();
                           action()),
                  fn _ => !values_selected),
            PUSH ("reset",
                  fn _ => (update_fn ();
                           values_selected := false;
                           set_selected()),
                  fn _ => !values_selected),
            PUSH ("cancel",
                  fn _ => Xm.Widget.unmanageChild form,
                  fn _ => true)])
      in
        set_selected_hook := buttons_update_fn;
        Xm.Widget.valuesSet (frame,
                             [(Xm.TOP_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_FORM),
                              (Xm.LEFT_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_FORM),
                              (Xm.RIGHT_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_FORM),
                              (Xm.BOTTOM_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_WIDGET),
                              (Xm.BOTTOM_WIDGET, Xm.WIDGET separator)]);
        Xm.Widget.valuesSet (separator,
                             [(Xm.TOP_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_NONE),
                              (Xm.LEFT_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_FORM),
                              (Xm.RIGHT_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_FORM),
                              (Xm.BOTTOM_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_WIDGET),
                              (Xm.BOTTOM_WIDGET, Xm.WIDGET dialogButtons)]);
        Xm.Widget.valuesSet (dialogButtons,
                             [(Xm.TOP_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_NONE),
                              (Xm.LEFT_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_FORM),
                              (Xm.RIGHT_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_FORM),
                              (Xm.BOTTOM_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_FORM)]);

        (fn _ =>
         (update_fn ();
          values_selected := false;
          buttons_update_fn();
          Xm.Widget.manage form;
          Xm.Widget.map shell; (* Sometimes the window is unmapped on being popped down! *)
          Xm.Widget.toFront shell),
         fn _ =>
         (update_fn ();
          values_selected := false;
          buttons_update_fn()))
          
      end

    (* This function should only be called for the special purpose of quitting *)
    (* So I haven't put it in xm.sml *)
    local 
      fun env s = MLWorks.Internal.Value.cast (MLWorks.Internal.Runtime.environment s)
    in
      val quit_on_exit : unit -> unit = env "x quit on exit"
    end

    fun exit_dialog (parent,applicationShell,has_controlling_tty) =
      let
        val shell =
          Xm.Widget.createPopupShell ("quitDialog",
                                      Xm.Widget.DIALOG_SHELL,
                                      parent, [])

        (* To make life easy, we use a standard MessageBox widget and
         change the labels and actions around.  *)
        val message =
          Xm.Widget.create
          ("message", Xm.Widget.MESSAGE_BOX, shell,
           [])
                
        fun tty _ = (MLWorks.Internal.StandardIO.resetIO();
                     Xm.Widget.destroy applicationShell)
        fun exit _ = (quit_on_exit(); Xm.Widget.destroy applicationShell);
        fun cancel _ = Xm.Widget.destroy shell
      in
        if not has_controlling_tty then
          Xm.Widget.unmanageChild
          (Xm.MessageBox.getChild
           (message, Xm.Child.OK_BUTTON))
        else 
          ();
	Xm.Widget.valuesSet
          (Xm.MessageBox.getChild (message, Xm.Child.OK_BUTTON),
	   [(Xm.LABEL_STRING,
	     Xm.COMPOUND_STRING
	       (Xm.CompoundString.createSimple "End X Session"))]);
	Xm.Widget.valuesSet
          (Xm.MessageBox.getChild (message, Xm.Child.CANCEL_BUTTON),
	   [(Xm.LABEL_STRING, 
	     Xm.COMPOUND_STRING
	       (Xm.CompoundString.createSimple "Exit MLWorks"))]);
	Xm.Widget.valuesSet
          (Xm.MessageBox.getChild (message, Xm.Child.HELP_BUTTON),
	   [(Xm.LABEL_STRING, 
	     Xm.COMPOUND_STRING
	       (Xm.CompoundString.createSimple "Cancel"))]);
        Xm.Callback.add (message, Xm.Callback.OK, tty);
        Xm.Callback.add (message, Xm.Callback.HELP, cancel);
        Xm.Callback.add (message, Xm.Callback.CANCEL, exit);
        Xm.Widget.manage message
      end
  end
