(*  ==== CAPI INTERFACE ====
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
 *  Revision Log
 *  ------------
 * $Log: capi.sml,v $
 * Revision 1.64  1998/07/14 10:43:30  jkbrook
 * [Bug #30435]
 * Remove license-prompting code
 *
 * Revision 1.63  1998/07/02  14:33:55  johnh
 * [Bug #30431]
 * Add attributes.
 *
 * Revision 1.62  1998/05/28  17:08:02  johnh
 * [Bug #30369]
 * Make file selection box allow multiple selection.
 *
 * Revision 1.61  1998/03/31  16:17:32  johnh
 * [Bug #30346]
 * Call Capi.getNextWindowPos().
 *
 * Revision 1.60  1998/03/26  11:39:18  johnh
 * [Bug #50035]
 * Allow keyboard accelerators to be platform specific.
 *
 * Revision 1.59  1998/02/17  16:43:36  johnh
 * [Bug #30344]
 * Allow windows to retain size and position.
 *
 * Revision 1.58  1998/01/27  14:12:18  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.57  1997/10/06  10:58:48  johnh
 * [Bug #30137]
 * Add make_messages_popup.
 *
 * Revision 1.56.2.3  1998/01/09  11:50:32  johnh
 * [Bug #30071]
 * Add Callback.VALUE_CHANGED.
 *
 * Revision 1.56.2.2  1997/09/12  14:46:47  johnh
 * [Bug #30071]
 * Implement new Project Workspace tool.
 *
 * Revision 1.56  1997/09/05  10:23:44  johnh
 * [Bug #30241]
 * Implementing proper Find Dialog.
 *
 * Revision 1.55  1997/08/05  13:33:15  brucem
 * [Bug #30224]
 * Add function makeYesNo.
 *
 * Revision 1.54  1997/07/23  09:16:38  johnh
 * [Bug #30182]
 * Add delete handler for Windows.
 *
 * Revision 1.53  1997/07/18  14:40:26  johnh
 * [Bug #20074]
 * Add comment previously forgot to add.
 *
 * Revision 1.52  1997/07/18  13:29:11  johnh
 * [Bug #20074]
 * Improve license dialog.
 *
 * Revision 1.51  1997/06/18  08:23:21  johnh
 * [Bug #30181]
 * Tidy interrupt button code.
 *
 * Revision 1.50  1997/06/17  16:18:12  johnh
 * [Bug #30179]
 * Fixing interrupt button on Unix - added register_interrupt_widget.
 *
 * Revision 1.49  1997/06/13  09:52:22  johnh
 * [Bug #30175]
 * Add extra arg to make_main_window to include window in dynamic menu.
 *
 * Revision 1.48  1997/05/20  15:57:18  johnh
 * On Windows only, moving interrupt button to toolbar.
 *
 * Revision 1.47  1997/05/16  15:35:57  johnh
 * Implementing single menu bar on Windows.
 * Re-organising menus for Motif.
 *
 * Revision 1.46  1997/05/01  12:32:54  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.45  1997/03/17  14:37:25  johnh
 * [Bug #1954]
 * Added set_min_window_size.
 *
 * Revision 1.44  1996/11/21  11:24:34  jont
 * [Bug #1799]
 * Modify check_insertion to truncate string if it would not fit at all
 *
 * Revision 1.43  1996/11/18  09:52:34  daveb
 * Added splash screen.
 *
 * Revision 1.42  1996/11/12  11:44:28  daveb
 * Adeded license_prompt and license_compaillain.
 *
 * Revision 1.41  1996/11/01  13:41:09  johnh
 * Enabling close from control box on top left of window.
 *
 * Revision 1.40  1996/10/30  13:17:52  johnh
 * Add interrupt button on Windows.
 *
 * Revision 1.39  1996/09/23  14:01:28  matthew
 * Adding register_interrupt_window to capi
 *
 * Revision 1.38  1996/09/19  12:59:22  johnh
 * [Bug #1583]
 * passing has_controlling_tty to exit_mlworks instead of passed ing false.
 *
 * Revision 1.37  1996/07/30  14:37:35  jont
 * Provide a system dependent line terminator
 *
 * Revision 1.36  1996/07/05  14:39:39  daveb
 * [Bug #1260]
 * Changed the Capi layout datatype so that the PANED constructor takes the
 * layout info for its sub-panes.  This enables the Windows layout code to
 * calculate the minimum size of each window.
 *
 * Revision 1.35  1996/05/31  16:12:14  daveb
 * Bug 1074: Capi.list_select now takes a function to be called on any key
 * press handled by the list widget itself.  In the listener, this pops the
 * completions widget down as if the key had been typed at the listener.
 *
 * Revision 1.34  1996/05/28  12:33:50  matthew
 * Adding reset function
 *
 * Revision 1.33  1996/05/16  09:29:40  matthew
 * Adding Text.convert_text
 *
 * Revision 1.32  1996/05/07  11:31:05  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.31  1996/04/18  09:53:29  matthew
 * Adding start/stop graphics functions
 *
 * Revision 1.30  1996/02/14  10:31:13  matthew
 * Adding clear_rectangle
 *
 * Revision 1.29  1996/02/09  11:27:29  daveb
 * Changed return type of make_scrolllist to a record, with an extra element
 * add_items.  Replaced set_bottom_pos with set_pos (which can be implemented
 * on windows).  Added add_items to the List structure.
 *
 * Revision 1.28  1996/01/25  17:20:51  matthew
 * Adding set_selection for text widgets
 *
 * Revision 1.27  1996/01/12  16:30:45  matthew
 * Adding insertion checks for the benefit of Windows
 *
 * Revision 1.26  1996/01/12  12:09:07  daveb
 * Added comment.
 *
 * Revision 1.25  1996/01/12  10:33:16  daveb
 * Added separate open_dir_dialog function.
 *
 * Revision 1.24  1996/01/10  12:32:52  daveb
 * Replaced find_file with save_as_dialog and open_file_dialog, for Windows.
 *
 * Revision 1.23  1996/01/09  13:48:11  matthew
 * Moving list_select to capi
 *
 * Revision 1.22  1995/12/13  10:15:07  daveb
 * Added FileType datatype and changed type of find_file.
 *
 * Revision 1.21  1995/12/07  14:05:24  matthew
 * Changing interface to clipboard functions
 *
 * Revision 1.20  1995/11/21  14:43:53  matthew
 * Adding transfer_focus function
 *
 * Revision 1.19  1995/11/17  11:15:57  matthew
 * Adding some stuff for listeners
 *
 * Revision 1.18  1995/11/15  15:17:46  matthew
 * Adding support for Windows menu
 *
 * Revision 1.17  1995/11/14  13:58:48  matthew
 * Changing the way we do mouse input to graphics ports
 *
 * Revision 1.16  1995/10/10  12:16:08  nickb
 * Add Resize callback.
 *
 * Revision 1.15  1995/10/04  13:04:19  brianm
 * Adding user-controllable graphics-positioning ... (mods to make_graphics).
 *
 * Revision 1.14  1995/10/02  10:53:18  brianm
 * Adding `with_graphics_port' and related facilities.
 *
 * Revision 1.13  1995/09/22  14:21:11  daveb
 * Added Capi.Text.set_highlight.
 *
 * Revision 1.12  1995/09/21  15:16:50  nickb
 * Make scroll bars on graphics ports optional.
 *
 * Revision 1.11  1995/09/18  12:40:08  brianm
 * Updating by adding Capi Point/Region datatypes
 *
 * Revision 1.10  1995/09/11  13:21:19  matthew
 * Changing top level window initialization
 *
 * Revision 1.9  1995/09/04  14:49:44  matthew
 * Adding make_message_text
 *
 * Revision 1.8  1995/08/30  13:23:43  matthew
 * Adding make_main_window
 *
 * Revision 1.7  1995/08/24  16:03:08  matthew
 * Abstracting text functionality
 *
 * Revision 1.6  1995/08/16  13:26:32  matthew
 * Undoing previous change
 *
 * Revision 1.1  1995/08/16  13:26:32  matthew
 * Initial revision
 * 
 * Revision 1.5  1995/08/16  11:54:10  io
 * sync datatype WidgetClass
 *
 * Revision 1.4  1995/08/15  10:36:09  matthew
 * Removing quit_on_exit
 *
 * Revision 1.3  1995/08/10  12:08:17  matthew
 * Adding make_buttons function to capi
 *
 * Revision 1.2  1995/08/02  15:53:40  matthew
 * Adding event handler stuff
 *
 * Revision 1.1  1995/07/27  11:13:56  matthew
 * new unit
 * Moved from library
 *
 *  Revision 1.6  1995/07/26  13:19:30  matthew
 *  Adding support for font dimensions etc.
 *
 *  Revision 1.5  1995/07/17  12:44:37  matthew
 *  Adding scroll_to functions
 *
 *  Revision 1.4  1995/07/14  14:38:18  matthew
 *  Adding new stuff, including preliminary graphics ports
 *
 *  Revision 1.3  1995/07/07  14:06:27  daveb
 *  Minor changes to paned windows.
 *
 *  Revision 1.2  1995/07/04  14:56:47  matthew
 *  More stuff
 *
 *  Revision 1.1  1995/06/29  15:58:22  matthew
 *  new unit
 *  New "window system independent" interface
 *
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

signature CAPI =
sig

  type Widget

  datatype Point = POINT of { x : int, y : int }

  datatype Region = REGION of { x : int, y :int, width : int, height :int }

  type Font

  exception SubLoopTerminated
  exception WindowSystemError of string

  val getNextWindowPos : unit -> int * int

  val initialize_application : string * string * bool -> Widget
  (* (name, title, has_controlling_tty) -> applicationShell *)

  datatype WidgetAttribute =
      PanedMargin of bool
    | Position of    int * int
    | Size of        int * int
    | ReadOnly of    bool

  datatype WidgetClass =
    (* RowColumn should be renamed ButtonPane *)
    Frame | Graphics | Label | Button | Text | RowColumn | Paned | Form
    
  val make_widget : 
    string * WidgetClass * Widget * WidgetAttribute list -> Widget

  val make_managed_widget : 
    string * WidgetClass * Widget * WidgetAttribute list -> Widget

  (* Used in various tools to add or remove window entries from the dynamic
   * windows menu under the tools menu when a window is hidden, or re-shown.
   *)
  val add_main_window : Widget * string -> unit
  val remove_main_window : Widget -> unit

  (* (name, title, parent, has_context_label, in_windows_menu) -> 
	(shell, form, menubar, contextlabel option) *)
  (* The shell is a toplevel shell. *)
  (* in_windows_menu (final bool argument) indicates whether the window to be 
   * created is to be added to the dynamic list of windows.  Any window
   * created by this function other than those contained in the tools menu 
   * should be added to the dynamic list.
   *)
  val make_main_window : 
    {name: 	   string,
     title: 	   string,
     parent: 	   Widget,
     contextLabel: bool,
     winMenu:	   bool,
     pos:	   int * int} -> Widget * Widget * Widget * Widget option    

  val get_main_windows : unit -> (Widget * string) list

  (* (name, title, parent, has_context_label) -> (shell, form, menubar, contextlabel option) *)
  (* The shell is a dialog shell. *)

  val make_main_popup : 
    {name:	   string,
     title:	   string,
     parent:	   Widget,
     contextLabel: bool,
     visibleRef:   bool ref,
     pos:	   int * int} -> Widget * Widget * Widget * Widget option    

  (* This is needed on Win32 platforms to specific a different parent than usual, 
   * which is the same parent as the Podium (ie. dummyWindow).  This is to handle 
   * window focus properly.  This window cannot be created as a main window because
   * it will then not be hidden properly on Motif.
   *)
  val make_messages_popup : Widget * bool ref ->
    Widget * Widget * Widget * Widget option

  (* (parent, has_context_label) -> (form, menubar, contextlabel option) *)
  (* The form window isn't managed *)
  val make_main_subwindows : 
    Widget * bool -> 
    Widget * Widget * Widget option    

  val make_subwindow : Widget -> Widget

  (* Convenience functions for different kinds of widget *)

  val make_popup_shell : string * Widget * WidgetAttribute list * bool ref -> Widget

  (* name, title,parent,attributes -> widget *)
  val make_toplevel_shell : string * string * Widget * WidgetAttribute list -> Widget

  (* Result is the scroll widget and the text widget *)
  val make_scrolled_text : string * Widget * WidgetAttribute list -> Widget * Widget

  (* The results are the scroll window, the list window, and the functions
     for setting and adding to the contents of the list window.  These are
     also passed (curried) to the select and action functions, so that they
     can (e.g.)  modify the contents. *)
  val make_scrolllist:
    {parent: Widget,
     name: string,
     select_fn:
       (Widget * Widget * ('b -> '_a list -> unit) * ('b -> '_a list -> unit))
       -> '_a -> unit,
     action_fn:
       (Widget * Widget * ('b -> '_a list -> unit) * ('b -> '_a list -> unit))
       -> '_a -> unit,
     print_fn: 'b -> '_a -> string}
    -> {scroll: Widget,
	list: Widget,
	set_items: 'b -> '_a list -> unit,
	add_items: 'b -> '_a list -> unit}

  val make_file_selection_box : string * Widget * WidgetAttribute list ->
    Widget * 
    {get_file : unit -> string,
     get_directory : unit -> string,
     set_directory : string -> unit,
     set_mask : string -> unit}

  val list_select :
    (Widget * string * (string -> unit)) ->
    ('_a list * ('_a -> unit) * ('_a -> string)) -> 
    (unit -> unit)

  val remove_menu : Widget -> unit
  val destroy : Widget -> unit
  val initialize_application_shell : Widget -> unit
  val initialize_toplevel : Widget -> unit
  val reveal : Widget -> unit
  val hide : Widget -> unit
  val to_front : Widget -> unit
  val set_min_window_size : Widget * int * int -> unit 

  val transfer_focus : Widget * Widget -> unit
  val set_sensitivity : Widget * bool -> unit
  val set_label_string : Widget * string -> unit
  val set_focus : Widget -> unit
  val parent : Widget -> Widget
  val set_busy : Widget -> unit
  val unset_busy : Widget -> unit
  val widget_size : Widget -> int * int
  val widget_pos : Widget -> int * int
  val set_message_widget : Widget -> unit
  val no_message_widget : unit -> unit
  val set_close_callback : Widget * (unit -> unit) -> unit

  (* miscellaneous utils *)
  val event_loop : bool ref -> unit
  val main_loop : unit -> unit

  (* pop up a file selection tool and return a pathname.  The string argument
     specifies a filename mask. *)
  val open_file_dialog : Widget * string * bool -> string list option 
  val open_dir_dialog : Widget -> string option

  (* Allows the creation of a new directory, but only on Unix. 
   * On Win32, this function is the same as open_dir_dialog *)
  val set_dir_dialog : Widget -> string option

  (* N.B. the Windows implementation of save_as_dialog currently ignores
     the mask argument. *)
  val save_as_dialog : Widget * string -> string option

  (* Create a popup window with an ok button *)
  val send_message : Widget * string -> unit
  (* Create a popup window with `Yes', `No' and 'Cancel' (optional) buttons,
     returns true if user clicks `Yes'. *)
  val makeYesNoCancel : Widget * string * bool -> unit -> bool option

  (* Create a find dialog with optional search facilities:  search direction, 
   * matching case, and/or match whole word.  Takes an search function which 
   * takes the settings of these facilities including the search string.
   *)
  val find_dialog : Widget * ({searchStr: string,
              searchDown: bool,
              matchCase: bool,
              wholeWord: bool} -> unit) 
             * {findStr: string,
                downOpt: bool option,
                wordOpt: bool option,
                caseOpt: bool option}  -> unit -> Widget 

  val with_message : Widget * string -> (unit -> 'a) -> 'a
  val beep : Widget -> unit

  structure Event:
    sig
      eqtype Modifier
      val meta_modifier : Modifier
      datatype Button = LEFT | RIGHT | OTHER
    end

  structure Callback:
    sig
      datatype Type =
	Activate
      | Destroy
      | Unmap
      | Resize
      | ValueChange

      val add : Widget * Type * (unit -> unit) -> unit
    end

  structure List:
    sig
      (* lifted directly from Motif *)
      val get_selected_pos : Widget -> int MLWorks.Internal.Vector.vector
      val select_pos : Widget * int * bool -> unit
      val set_pos : Widget * int -> unit
      val add_items: Widget * string list -> unit
    end

  structure Text:
    sig
      val add_del_handler : Widget * (unit -> unit) -> unit

      val get_key_bindings: 
	{startOfLine: 	 unit -> unit,
	 endOfLine:	 unit -> unit,
	 backwardChar:	 unit -> unit,
	 forwardChar:	 unit -> unit,
	 eofOrDelete:	 unit -> unit,
	 abandon:	 unit -> unit,
	 deleteToEnd:	 unit -> unit,
	 previousLine:	 unit -> unit,
	 nextLine:	 unit -> unit,
	 newLine:   	 unit -> unit,
	 delCurrentLine: unit -> unit,
	 checkCutSel:	 unit -> unit,
	 checkPasteSel:	 unit -> unit} -> (string * (unit -> unit)) list

      val insert : Widget * int * string -> unit
      val replace : Widget * int * int * string -> unit
      val set_insertion_position : Widget * int -> unit
      val get_insertion_position : Widget -> int
      val get_last_position : Widget -> int
      val get_string : Widget -> string
      val set_string : Widget * string -> unit
      val substring : Widget * int * int -> string
      val get_line_and_index : Widget * int -> string * int
      val current_line : Widget * int -> int
      val end_line : Widget * int -> int
      val get_line : Widget * int -> string
      val set_highlight : Widget * int * int * bool -> unit
      val get_selection : Widget -> string
      val set_selection : Widget * int * int -> unit
      val remove_selection : Widget -> unit
      val convert_text : string -> string
      val text_size : string -> int

      val cut_selection : Widget -> unit
      val paste_selection : Widget -> unit
      val delete_selection : Widget -> unit
      val copy_selection : Widget -> unit

      val add_handler : Widget * (string * Event.Modifier list -> bool) -> unit

      (* This isn't portable unfortunately *)
      (* the section of text affected, the new contents, the confirm function *)
      val add_modify_verify : Widget * ((int * int * string * (bool -> unit)) -> unit) -> unit

      (* This is a nasty hack *)
      val read_only_before_prompt : bool

      (* Truncate the widget if adding the string will make it too big *)
      (* Truncate the string if it would be too big to fit at all *)
      val check_insertion : Widget * string * int * int ref list -> string
    end

  val setAttribute : Widget * WidgetAttribute -> unit

  (* layout *)

  structure Layout:
    sig
      (* The lay_out function sets up the constraint resources for the children
       of a form such that they are laid out from top to bottom, in the order
         they appear in the list.  The first text widget in the list, if any,
         will resize to match any changes in the size of the form.
     
         All widgets will have space to the left and right, except for menu bars.
         *)

      datatype Class =
        MENUBAR of Widget
      | FLEX of Widget
      | FIXED of Widget
      | PANED of Widget * (Widget * Class list) list
      | FILEBOX of Widget
      | SPACE

      val lay_out: Widget * (int * int) option * Class list -> unit
    end

  val show_splash_screen : Widget -> unit

  structure GraphicsPorts:
    sig
      type GraphicsPort

      exception UnInitialized
      
      val initialize_gp : GraphicsPort -> unit
      val start_graphics : GraphicsPort -> unit
      val stop_graphics : GraphicsPort -> unit
      val with_graphics : GraphicsPort -> ('a -> 'b) -> 'a -> 'b
      val is_initialized : GraphicsPort -> bool
      val gp_widget : GraphicsPort -> Widget
      val get_offset : GraphicsPort -> Point
      val set_offset : GraphicsPort * Point -> unit
      val clear_clip_region : GraphicsPort -> unit
      val set_clip_region : GraphicsPort * Region -> unit
      val with_highlighting : GraphicsPort * ('a -> 'b) * 'a -> 'b
      val redisplay : GraphicsPort -> unit
      val reexpose : GraphicsPort -> unit
      val copy_gp_region : GraphicsPort * GraphicsPort * Region * Point -> unit
      val make_gp : string * string * Widget -> GraphicsPort
      val text_extent : GraphicsPort * string -> 
        {font_ascent : int,
         font_descent : int,
         ascent : int,
         descent : int,
         lbearing : int,
         rbearing : int,
         width : int}
      val draw_point : GraphicsPort * Point -> unit
      val draw_line : GraphicsPort * Point * Point -> unit
      val draw_rectangle : GraphicsPort * Region -> unit
      val clear_rectangle : GraphicsPort * Region -> unit
      val fill_rectangle : GraphicsPort * Region -> unit
      val draw_arc : GraphicsPort * Region * real * real -> unit
      val draw_image_string : GraphicsPort * string * Point -> unit
      val make_graphics : 
        string * string *			    (* name, title *)
        (GraphicsPort * Region -> unit) *           (* Draw function *)
        (unit -> int * int) *                       (* Extent function *)
	(bool * bool) *				    (* scroll bars? *) 
        Widget ->                                   (* Parent *)
          (Widget *                                 (* Scroll pane *)
           GraphicsPort *                           (* gp *)
           (unit -> unit) *                         (* scroll function *)
           (Point -> unit)                          (* set position *)
          )
      val add_input_handler : GraphicsPort * (Event.Button * Point -> unit) -> unit

      type PixMap

      datatype LineStyle = LINESOLID | LINEONOFFDASH | LINEDOUBLEDASH	
      
      datatype Attribute =
         FONT of Font
      |  LINE_STYLE of LineStyle
      |  LINE_WIDTH of int  
      |  FOREGROUND of PixMap
      |  BACKGROUND of PixMap

      datatype Request =
         REQUEST_FONT
      |  REQUEST_LINE_STYLE
      |  REQUEST_LINE_WIDTH
      |  REQUEST_FOREGROUND
      |  REQUEST_BACKGROUND

      val getAttributes : GraphicsPort * Request list -> Attribute list
      val setAttributes : GraphicsPort * Attribute list -> unit

      val with_graphics_port :(GraphicsPort * ('a -> 'b) * 'a) -> 'b

    end

  (* CLIPBOARD INTERFACE *)
  (* this just deals with text right now *)
  val clipboard_set : Widget * string -> unit
  val clipboard_get : Widget * (string -> unit) -> unit
  val clipboard_empty : Widget -> bool

  (* Reset things.  Call when restarting a saved image *)
  val restart : unit -> unit
    
  (* History saving *)
  val terminator : string

  val register_interrupt_widget : Widget -> unit
  val with_window_updates : (unit -> 'a) -> 'a
  val evaluating : bool ref

end
