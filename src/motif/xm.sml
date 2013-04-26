(*  ==== MOTIF LIBRARY INTERFACE ====
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
 *  Description
 *  -----------
 *
 *  Revision Log
 *  ------------
 *  $Log: xm.sml,v $
 *  Revision 1.27  1998/06/30 15:42:24  johnh
 *  [Bug #30431]
 *  Add 'editable' argument type.
 *
 * Revision 1.26  1998/05/22  10:09:13  johnh
 * [Bug #30369]
 * Modifying list callback struct to handle multiple selection cases.
 *
 * Revision 1.25  1997/11/18  14:04:55  johnh
 * [Bug #30322]
 * Add visual functions and Pixel.{to,from}Word32 and set window attr functions.
 *
 * Revision 1.24  1997/11/06  14:05:50  johnh
 * [Bug #30125]
 * Add HELP_MENU_WIDGET arg.
 *
 * Revision 1.23  1997/05/09  11:12:05  daveb
 * [Bug #30020]
 * Added check_mlworks_resources function.
 *
 * Revision 1.22  1997/05/02  17:15:25  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.21.5.1.3.2  1997/11/18  12:18:04  johnh
 * [Bug #30322]
 * Add visual functions and Pixel.{to,from}Word32 and set window attr functions.
 *
 * Revision 1.21  1996/11/06  18:56:13  daveb
 * [Bug #1718]
 * Removed spurious comments, as users get to see this file.
 *
 * Revision 1.20  1996/11/04  11:50:26  daveb
 * [Bug #1699]
 * Changed Xm.GC.Copy to mimic the C function more closely.
 *
 * Revision 1.19  1996/11/01  17:32:00  daveb
 * [Bug #1694]
 * Removed obsolete items.
 *
 * Revision 1.18  1996/10/01  09:36:06  matthew
 * Adding a release colormap function
 *
 * Revision 1.17  1996/05/07  11:26:57  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.16  1996/04/18  14:38:47  daveb
 * Made Xm.Text.posToXY return an option type.
 *
 * Revision 1.15  1996/03/19  17:16:01  matthew
 * Changing type of convertList
 *
 * Revision 1.14  1996/03/12  11:00:49  matthew
 * Adding queryPointer
 *
 * Revision 1.13  1996/02/26  16:16:12  matthew
 * Revisions to Xm library
 *
 * Revision 1.12  1996/02/13  16:41:57  io
 * add Visual
 *
 * Revision 1.11  1996/02/08  16:05:36  daveb
 * Added List.setPos.
 *
 * Revision 1.10  1996/01/25  17:18:39  matthew
 * Adding set_selection function
 *
 * Revision 1.9  1996/01/05  13:57:04  matthew
 * Stuff
 *
 * Revision 1.8  1995/12/07  14:08:02  matthew
 * Adding selection operations for text widgets
 *
 * Revision 1.7  1995/11/15  12:55:31  matthew
 * Adding widget_eq
 *
 * Revision 1.6  1995/10/24  17:07:26  matthew
 * Changing Font.load to load a Font not a FontStruct
 *
 * Revision 1.5  1995/10/17  15:59:27  nickb
 * Add scale callback conversion.
 *
 * Revision 1.4  1995/10/04  10:27:07  brianm
 * Added Increment to ArgumentName etc.
 *
 * Revision 1.3  1995/09/25  12:05:32  brianm
 * Adding copying of graphics contexts and also queries for GCvalues in graphics contexts
 *
 * Revision 1.2  1995/09/22  10:42:01  daveb
 * Added Xm.Text.setHighlight.
 *
 * Revision 1.1  1995/07/26  13:19:27  matthew
 * new unit
 * New unit
 *
 *  Revision 1.47  1995/07/26  13:19:27  matthew
 *  Adding support for font dimensions etc.
 *
 *  Revision 1.46  1995/07/13  11:05:03  matthew
 *  Changing the way clip regions work for GC's
 *
 *  Revision 1.45  1995/07/07  14:45:03  daveb
 *  Added MarginHeight, MarginWidth and Spacing resources.
 *
 *  Revision 1.44  1995/07/03  16:31:57  matthew
 *  Expanding
 *
 *  Revision 1.43  1995/06/20  14:10:00  daveb
 *  Added Xm.List.setBottomPos.
 *
 *  Revision 1.42  1995/06/19  13:26:33  matthew
 *  More graphics functions
 *
 *  Revision 1.41  1995/06/08  13:23:26  matthew
 *  Adding drawing primitives
 *
 *  Revision 1.40  1995/05/03  16:11:03  matthew
 *  Adding popup and createMenuBar
 *
 *  Revision 1.39  1995/04/21  16:59:23  daveb
 *  Added ungrabPointer.
 *
 *  Revision 1.38  1995/04/13  16:46:13  daveb
 *  Changed mainLoop and doInput back to taking unit.  The runtime caches
 *  the main application shell again, and shares the application context
 *  with all application shells.
 *
 *  Revision 1.37  1995/04/07  16:04:50  daveb
 *  Removed createApplicationShell.
 *
 *  Revision 1.36  1995/04/07  10:43:28  daveb
 *  Repeated calls to initialize return a new application shell.
 *  mainLoop and related functions take an application shell argument.
 *
 *  Revision 1.35  1995/03/09  17:30:27  matthew
 *  Adding some new resources
 *
 *  Revision 1.34  1995/02/27  12:56:20  daveb
 *  Added ScrollBarDisplayPolicy resource.
 *
 *  Revision 1.33  1994/07/20  14:47:18  brianm
 *  Modification of X exception to avoid shadowing of constructor
 *
 *  Revision 1.32  1994/07/11  11:25:53  daveb
 *  Added DirSpec resource.
 *
 *  Revision 1.31  1994/06/29  14:44:19  nickh
 *  Add MLWorks message widget registration.
 *
 *  Revision 1.30  1994/06/22  16:30:46  daveb
 *  Added Xm.Widget.processTraversal.
 *
 *  Revision 1.29  1993/12/20  11:11:25  matthew
 *  Added map and unmap functions
 *
 *  Revision 1.28  1993/12/09  13:59:03  matthew
 *  Added window registering function.
 *
 *  Revision 1.27  1993/11/25  11:49:03  matthew
 *  Added exception SubLoopTerminated.
 *
 *  Revision 1.26  1993/10/08  16:53:09  matthew
 *  Merging in bug fixes
 *
 *  Revision 1.25.1.2  1993/10/08  10:19:09  matthew
 *  Added Destroy callback
 *  Added Text.getSelection and Text.removeSelection
 *
 *  Revision 1.25.1.1  1993/08/29  19:30:33  jont
 *  Fork for bug fixing
 *
 *  Revision 1.25  1993/08/29  19:30:33  daveb
 *  Added Directory resource.  Added fileSelectionDoSearch and selectPos.
 *
 *  Revision 1.24  1993/08/26  11:53:03  richard
 *  Moved the X exception here from the pervasive library where it was
 *  cluttering up the environment.
 *
 *  Revision 1.23  1993/08/10  09:42:06  matthew
 *  Added Display substructure with bell function.
 *
 *  Revision 1.22  1993/08/03  16:18:35  matthew
 *  Added toFront function
 *
 *  Revision 1.21  1993/07/29  14:50:27  matthew
 *  Added setBusy and unSetBusy functions.
 *
 *  Revision 1.20  1993/06/03  16:21:22  daveb
 *  Added messageBoxGetChild.
 *
 *  Revision 1.19  1993/05/25  11:28:03  matthew
 *  Added fileSelectionBoxGetChild & ancillary stuff
 *
 *  Revision 1.18  1993/05/19  11:56:34  daveb
 *  Added Packing resource, corrected spelling of RadioBehavior.
 *
 *  Revision 1.17  1993/05/10  10:30:44  matthew
 *  Added Unmap callback
 *
 *  Revision 1.16  1993/04/30  11:21:00  daveb
 *  Made Widgets and some other types admit equality.
 *
 *  Revision 1.15  1993/04/19  16:28:32  matthew
 *   Added ExtendedSelection, BrowseSelection and DefaultAction callbacks
 *  Added getSelectedPos function to List structure
 *
 *  Revision 1.14  1993/04/14  11:20:01  matthew
 *  Added IsHomogeneous argument type
 *
 *  Revision 1.13  1993/04/13  15:06:15  matthew
 *  Replaced missing log message
 *
 *  Revision 1.12  1993/04/08  17:43:33  matthew
 *  Added TextString and convert_string_text
 *
 *  Revision 1.11  1993/04/08  12:17:45  matthew
 *  Removed closeDisplay function
 *
 *  Revision 1.10  1993/04/08  10:13:51  daveb
 *  Added radioBehaviour resource.
 *
 *  Revision 1.9  1993/04/06  15:47:18  daveb
 *  Added Event structure and Callback structure, and functions to convert
 *  Events and Callback data structures to ML.  We need an FFI interface,
 *  whether or not there's a real FFI underneath it.
 *
 *  Revision 1.8  1993/04/01  16:58:48  matthew
 *  Added ApplyCallback
 *
 *  Revision 1.7  1993/03/25  15:52:56  matthew
 *  Added list and text utilities
 *   Changed callback types
 *  Added some callbacks
 *
 *  Revision 1.6  1993/03/23  14:16:08  matthew
 *   Added some callback names and argument types
 *  Richard's change to create_application_shell
 *
 *  Revision 1.5  1993/03/17  14:51:07  matthew
 *  Added closeDisplay and doInput functions.
 *
 *  Revision 1.4  1993/03/09  15:02:59  daveb
 *  Added Form widget class and associated resources.  Also added gadgets.
 *
 *  Revision 1.3  1993/03/03  16:09:14  daveb
 *  Added createScrolledText.
 *
 *  Revision 1.2  1993/02/12  15:14:33  daveb
 *  Many changes to support rewrite of X listeners.
 *  Also changed case conventions.
 *
 *  Revision 1.1  1993/01/26  11:57:50  richard
 *  Initial revision
 *
 *)

signature XM =
  sig

    eqtype display
    eqtype screen
    eqtype widget
    eqtype gc

    eqtype pixel
    eqtype font_struct
    eqtype font_list
    eqtype compound_string
    eqtype translations

    eqtype atom
    eqtype drawable	(* Window or Pixmap *)
    eqtype colormap
    eqtype font
    eqtype word32

    (* Miscellaneous X stuff *)
    val sync : display * bool -> unit
    val synchronize : display * bool -> unit

    structure Event:
    sig
      type state
      type event_data
      type button_code

      datatype common =      
        COMMON of
        {eventType: int, 
         serial: int, 
         send_event: bool, 
         display: display,
	 window: drawable}

      datatype key_event = KEY_EVENT of
        {common: common,
         root: drawable,
         subwindow: drawable,
         time: int,
         x: int, y: int, 
         x_root: int, y_root: int,
         state: state,
         key: string,
         same_screen: bool}

      datatype button_event = BUTTON_EVENT of
        {common: common,
         root: drawable,
         subwindow: drawable,
         time: int,
         x: int, y: int,
         x_root: int, y_root: int,
         state: state,
         button: button_code,
         same_screen: bool}

      datatype motion_event = MOTION_EVENT of
        {common: common, 
         root: drawable,
         subwindow: drawable,
         time: int,
         x: int, y: int,
         x_root: int, y_root: int,
         state: state,
         is_hint : int,
         same_screen: bool}

      datatype expose_event = EXPOSE_EVENT of
        {common: common,
         x : int, y : int, 
         width : int, height : int,
         count : int}

      (* Different types of event currently supported *)
      datatype event =
	KEY_PRESS of key_event |
        KEY_RELEASE of key_event |
        BUTTON_PRESS of button_event |
        BUTTON_RELEASE of button_event |
        MOTION_NOTIFY of motion_event |
	EXPOSE of expose_event |
        GRAPHICS_EXPOSE of expose_event | 
        ANY_EVENT of common

      datatype modifier =
	SHIFT | LOCK | CONTROL | MOD1 | MOD2 | MOD3 | MOD4 | MOD5

      datatype button = BUTTON1 | BUTTON2 | BUTTON3 | BUTTON4 | BUTTON5

      datatype mask = 
        KEY_PRESS_MASK
      | KEY_RELEASE_MASK
      | BUTTON_PRESS_MASK
      | BUTTON_RELEASE_MASK
      | ENTER_WINDOW_MASK
      | LEAVE_WINDOW_MASK
      | POINTER_MOTION_MASK
      | POINTER_MOTION_HINT_MASK
      | BUTTON1_MOTION_MASK
      | BUTTON2_MOTION_MASK
      | BUTTON3_MOTION_MASK
      | BUTTON4_MOTION_MASK
      | BUTTON5_MOTION_MASK
      | BUTTON_MOTION_MASK
      | KEYMAP_STATE_MASK
      | EXPOSURE_MASK
      | VISIBILITY_CHANGE_MASK
      | STRUCTURE_NOTIFY_MASK
      | RESIZE_REDIRECT_MASK
      | SUBSTRUCTURE_NOTIFY_MASK
      | SUBSTRUCTURE_REDIRECT_MASK
      | FOCUS_CHANGE_MASK
      | PROPERTY_CHANGE_MASK
      | COLORMAP_CHANGE_MASK
      | OWNER_GRAB_BUTTON_MASK

      (* XtAddEventHandler *)
      val addHandler : widget * mask list * bool * (event_data -> unit) -> unit
      val convertState: state -> modifier list
      val convertButton: button_code -> button
      val convertEvent: event_data -> event
    end;

    (* Miscellaneous window properties *)
    datatype edit_mode =
      MULTI_LINE_EDIT | SINGLE_LINE_EDIT

    datatype highlight_mode =
      HIGHLIGHT_NORMAL | HIGHLIGHT_SELECTED | HIGHLIGHT_SECONDARY_SELECTED

    datatype selection_policy =
      SINGLE_SELECT | MULTIPLE_SELECT | EXTENDED_SELECT | BROWSE_SELECT

    datatype label_type =
      PIXMAP_LABEL | STRING_LABEL

    datatype compound_string_direction =
      L_TO_R | R_TO_L | DEFAULT_DIRECTION

    datatype row_column_type =
      WORK_AREA | MENU_BAR | MENU_PULLDOWN | MENU_POPUP | MENU_OPTION

    datatype orientation =
      VERTICAL | HORIZONTAL

    datatype packing_type =
      PACK_TIGHT | PACK_COLUMN | PACK_NONE

    datatype scrolling_policy =
      AUTOMATIC | APPLICATION_DEFINED

    datatype scrollbar_display_policy =
      STATIC | AS_NEEDED

    datatype dialog_type =
      DIALOG_ERROR | DIALOG_INFORMATION | DIALOG_MESSAGE | DIALOG_QUESTION |
      DIALOG_WARNING | DIALOG_WORKING

    datatype delete_response =
      DESTROY | UNMAP | DO_NOTHING

    datatype attachment =
      ATTACH_NONE | ATTACH_FORM | ATTACH_OPPOSITE_FORM | ATTACH_WIDGET |
      ATTACH_OPPOSITE_WIDGET | ATTACH_POSITION | ATTACH_SELF

    datatype char_set = CHAR_SET of string

    (* Displays *)
    structure Display :
      sig
        val bell : display * int -> unit
        val queryPointer : display * drawable -> (drawable * drawable * int * int * int * int)

        datatype visual_type = 
	  STATIC_GRAY | GRAY_SCALE | STATIC_COLOR | PSEUDO_COLOR | TRUE_COLOR | DIRECT_COLOR

	val defaultDepth : display * screen -> int
	val defaultVisual : display * screen -> 
	  {vis_type: visual_type,
	   r_value: word32,
	   g_value: word32,
	   b_value: word32,
	   bits_rgb: int}
      end

    (* This is just here for doing modify-verify callbacks *)
    structure Boolean :
      sig
	type t
	val set: t * bool -> unit
      end

    structure Pixel :
      sig
        val screenBlack	: screen -> pixel
        val screenWhite	: screen -> pixel
        val fromWord32  : word32 -> pixel
        val toWord32    : pixel -> word32
      end

    structure Font :
      sig
        val load	: display * string -> font
        val free	: display * font_struct -> unit
        val query       : display * font -> font_struct
        val textExtents : 
          font_struct * string -> 
          {font_ascent : int,
           font_descent : int,
           ascent : int,
           descent : int,
           lbearing : int,
           rbearing : int,
           width : int}
      end

    (* Miscellaneous functions *)

    val isMotifWMRunning : widget -> bool
    val updateDisplay : widget -> unit

    datatype argument_name =
      EDIT_MODE | EDITABLE | SELECTION_POLICY | DIR_MASK | DIR_SPEC | TEXT_STRING |
      WHICH_BUTTON | LABEL_PIXMAP | LABEL_TYPE | LABEL_STRING | FONT | FONT_LIST |
      FOREGROUND | BACKGROUND | ROW_COLUMN_TYPE | RADIO_BEHAVIOR | PACKING |
      IS_HOMOGENEOUS | COMMAND_WINDOW | MENUBAR | MENU_HELP_WIDGET | MESSAGE_WINDOW |
      WIDTH | HEIGHT | X | Y | SUBMENU_ID | ALLOW_SHELL_RESIZE |
      RESIZE_WIDTH | RESIZE_HEIGHT | ORIENTATION | DIALOG_TYPE | INCREMENT |
      MESSAGE_STRING | COLUMNS | ROWS | MARGIN_HEIGHT | MARGIN_WIDTH | SPACING |
      SCROLL_HORIZONTAL | SCROLL_VERTICAL | SCROLL_LEFT_SIDE | SCROLL_TOP_SIDE |
      SCROLLING_POLICY | SCROLLBAR_DISPLAY_POLICY |
      SENSITIVE | SET | WORK_WINDOW | TITLE | ICON_NAME |
      TOP_ATTACHMENT | BOTTOM_ATTACHMENT | LEFT_ATTACHMENT | RIGHT_ATTACHMENT |
      TOP_WIDGET | BOTTOM_WIDGET | LEFT_WIDGET | RIGHT_WIDGET |
      TOP_POSITION | BOTTOM_POSITION | LEFT_POSITION | RIGHT_POSITION |
      TOP_OFFSET | BOTTOM_OFFSET | LEFT_OFFSET | RIGHT_OFFSET |
      DELETE_RESPONSE | DIRECTORY |
      VERTICAL_SCROLLBAR | HORIZONTAL_SCROLLBAR | VALUE | MAXIMUM | MINIMUM |
      SLIDER_SIZE

    datatype argument_value =
      INT of int |
      STRING of string |
      BOOL of bool |
      COMPOUND_STRING of compound_string |
      EDIT_MODE_VALUE of edit_mode |
      SELECTION_POLICY_VALUE of selection_policy |
      WINDOW of drawable |
      PIXMAP of drawable |
      LABEL_TYPE_VALUE of label_type |
      FONT_VALUE of font |
      FONT_LIST_VALUE of font_list |
      PIXEL of pixel |
      ROW_COLUMN_TYPE_VALUE of row_column_type |
      WIDGET of widget |
      ORIENTATION_VALUE of orientation |
      PACKING_VALUE of packing_type |
      DIALOG_TYPE_VALUE of dialog_type |
      SCROLLING_POLICY_VALUE of scrolling_policy |
      SCROLLBAR_DISPLAY_POLICY_VALUE of scrollbar_display_policy |
      ATTACHMENT of attachment |
      DELETE_RESPONSE_VALUE of delete_response

    exception ArgumentType of argument_name * argument_value

    structure Callback: 
    sig
      type callback_data
      datatype name =
        ACTIVATE | OK | APPLY | CANCEL | HELP | MOTION_VERIFY | MODIFY_VERIFY |
        LOSING_FOCUS | CASCADING | VALUE_CHANGED | DRAG |
	SINGLE_SELECTION | MULTIPLE_SELECTION | EXTENDED_SELECTION | BROWSE_SELECTION |
        DEFAULT_ACTION | UNMAP | DESTROY | EXPOSE | RESIZE | INPUT

      val convertToggleButton : callback_data -> int * Event.event * int
      val convertScale : callback_data -> int * Event.event * int
      val convertDrawingArea : callback_data -> int * Event.event * drawable
      val convertList : callback_data -> int * Event.event * compound_string * int * int * compound_string list * int * int list * int
      val convertTextVerify: callback_data -> int * Event.event * Boolean.t * int * int * int * int * string
      val convertAny: callback_data -> int * Event.event

      val add: widget * name * (callback_data -> unit) -> unit
    end;

    structure Widget :
    sig
      (* Motif widget classes *)
      datatype class_name = APPLICATION_SHELL | ARROW_BUTTON | BULLETIN_BOARD |
        CASCADE_BUTTON | COMMAND | DIALOG_SHELL | DRAWING_AREA  |
        DRAWN_BUTTON | FILE_SELECTION_BOX | FORM | FRAME | LABEL |
        LIST | MAIN_WINDOW | MENU_SHELL | MESSAGE_BOX | PANED_WINDOW |
        PUSH_BUTTON | ROW_COLUMN | SCALE | SCROLLBAR |
        SCROLLED_WINDOW | SELECTION_BOX | SEPARATOR | TEXT |
        TEXT_FIELD | TOGGLE_BUTTON | PRIMITIVE | MANAGER | SHELL |
        OVERRIDE_SHELL | WM_SHELL | TRANSIENT_SHELL | TOP_LEVEL_SHELL |
        ARROW_BUTTON_GADGET | LABEL_GADGET | PUSH_BUTTON_GADGET |
        SEPARATOR_GADGET | TOGGLE_BUTTON_GADGET | CASCADE_BUTTON_GADGET

      datatype grab_mode = GRAB_NONE | GRAB_NONEXCLUSIVE | GRAB_EXCLUSIVE

      datatype process_traversal =
        TRAVERSE_CURRENT | TRAVERSE_DOWN | TRAVERSE_HOME | TRAVERSE_LEFT |
        TRAVERSE_NEXT | TRAVERSE_NEXT_TAB_GROUP | TRAVERSE_PREV |
        TRAVERSE_PREV_TAB_GROUP | TRAVERSE_RIGHT | TRAVERSE_UP

      datatype backing_store = NOT_USEFUL | WHEN_MAPPED | ALWAYS

      val create             : string * class_name * widget * (argument_name * argument_value) list -> widget
      val createManaged      : string * class_name * widget * (argument_name * argument_value) list -> widget
      val createMenuBar      : widget * string * (argument_name * argument_value) list -> widget
      val createPopupShell   : string * class_name * widget * (argument_name * argument_value) list -> widget
      val createPulldownMenu : widget * string * (argument_name * argument_value) list -> widget
      val createScrolledText : widget * string * (argument_name * argument_value) list -> widget

      val destroy	: widget -> unit
      val manage	: widget -> unit
      val map    	: widget -> unit
      val unmanageChild : widget -> unit
      val unmap 	: widget -> unit
      val realize	: widget -> unit
      val unrealize	: widget -> unit
      val isRealized	: widget -> bool
      val popup         : widget * grab_mode -> unit

      val setBacking    : widget * backing_store * word32 * pixel -> unit
      val setSaveUnder  : widget * bool -> unit

      val valuesSet	: widget * (argument_name * argument_value) list -> unit
      val valuesGet	: widget * argument_name list -> argument_value list

      val display	: widget -> display
      val window	: widget -> drawable
      val screen	: widget -> screen
      val parent	: widget -> widget
      val name		: widget -> string

      val processTraversal : widget * process_traversal -> bool

      val toFront : widget -> unit
    end

    (* For ***.getChild functions *)
    structure Child :
      sig
        datatype name = NONE |
          APPLY_BUTTON |
          CANCEL_BUTTON |
          DEFAULT_BUTTON |
          OK_BUTTON |
          FILTER_LABEL |
          FILTER_TEXT |
          HELP_BUTTON |
          LIST |
          HISTORY_LIST |
          LIST_LABEL |
          MESSAGE_LABEL |
          SELECTION_LABEL |
          PROMPT_LABEL |
          SYMBOL_LABEL |
          TEXT |
          VALUE_TEXT |
          COMMAND_TEXT |
          SEPARATOR |
          DIR_LIST |
          DIR_LIST_LABEL |
          FILE_LIST |
          FILE_LIST_LABEL
      end

    structure Atom :
      sig
        val intern : display * string * bool -> atom
        val getName : display * atom -> string
      end

    structure CascadeButton :
      sig
        val highlight : widget * bool -> unit
      end

    structure CascadeButtonGadget :
      sig
        val highlight : widget * bool -> unit
      end

    structure CompoundString :
      sig
        val baseline            : font_list * compound_string -> int
        val byteCompare		: compound_string * compound_string -> bool
        val compare		: compound_string * compound_string -> bool
        val concat		: compound_string * compound_string -> compound_string
        val copy		: compound_string -> compound_string
        val create		: string * char_set -> compound_string
        val createLtoR		: string * char_set -> compound_string
        val createSimple	: string -> compound_string
        val directionCreate	: compound_string_direction -> compound_string
        val empty		: compound_string -> bool
        val extent		: font_list * compound_string -> int * int
        val free		: compound_string -> unit
        val hasSubstring        : compound_string * compound_string -> bool
        val height		: font_list * compound_string -> int
        val length		: compound_string -> int
        val lineCount		: compound_string -> int
        val nConcat		: compound_string * compound_string * int -> compound_string
        val nCopy		: compound_string * int -> compound_string
        val segmentCreate	: string * char_set * compound_string_direction * bool -> compound_string
        val separatorCreate	: unit -> compound_string
        val width		: font_list * compound_string -> int

        (* This isn't an Xm function *)
        val convertStringText : compound_string -> string
      end

    structure FileSelectionBox :
      sig
        val getChild : widget * Child.name -> widget
        val doSearch : widget * compound_string -> unit
      end
        
    structure FontList :
      sig
        val add		: font_list * font_struct * char_set -> font_list
        val copy	: font_list -> font_list
        val create	: font_struct  * char_set -> font_list
        val free	: font_list -> unit
      end

    structure List:
    sig
      val addItem : widget * compound_string * int -> unit
      val addItemUnselected : widget * compound_string * int -> unit
      val addItems : widget * compound_string list * int -> unit
      val deleteAllItems : widget -> unit
      val deleteItem : widget * compound_string -> unit
      val deleteItems : widget * compound_string   list -> unit
      val deleteItemsPos : widget * int * int -> unit
      val deletePos : widget * int -> unit
      val getSelectedPos : widget -> int MLWorks.Internal.Vector.vector
      val setBottomPos : widget * int -> unit
      val selectPos: widget * int * bool -> unit
      val setPos : widget * int -> unit
    end

    structure MessageBox :
      sig
        val getChild : widget * Child.name -> widget
      end

    structure Pixmap :
      sig
        val create	: display * drawable * int * int * int -> drawable
        val free	: display * drawable -> unit
        val get		: screen * string * pixel * pixel -> drawable 
        val destroy	: screen * drawable -> unit
      end

    structure Scale :
      sig
        val getValue : widget -> int
        val setValue : widget * int -> unit
      end

    structure ScrollBar :
      sig
        val getValues : widget -> int * int * int * int
        val setValues : widget * int * int * int * int * bool -> unit
      end

    structure ScrolledWindow :
      sig
        val setAreas : widget * widget * widget * widget -> unit
      end

    structure SelectionBox :
      sig
        val getChild : widget * Child.name -> widget
      end

    structure TabGroup :
      sig
        val add : widget -> unit
        val remove : widget -> unit
      end

    structure Text:
    sig
      val clearSelection : widget -> unit
      val copy : widget -> unit
      val cut : widget -> unit
      val getBaseline           : widget -> int
      val getEditable           : widget -> int
      val getMaxLength          : widget -> int
      val getInsertionPosition	: widget -> int
      val getLastPosition	: widget -> int
      val getSelection          : widget -> string
      val getSelectionPosition  : widget -> int * int
      val getString		: widget -> string
      val getTopCharacter       : widget -> int
      val insert		: widget * int * string -> unit
      val paste                 : widget -> unit
      val posToXY               : widget * int ->
					(int * int) option
      val remove                : widget -> unit
      val replace               : widget * int * int * string -> unit
      val scroll                : widget * int -> unit
      val setAddMode            : widget * bool -> unit
      val setEditable           : widget * bool -> unit
      val setHighlight          : widget * int * int * highlight_mode -> unit
      val setInsertionPosition	: widget * int -> unit
      val setMaxLength          : widget * int -> unit
      val setSelection          : widget * int * int -> unit
      val setString		: widget * string -> unit
      val setTopCharacter       : widget * int -> unit
      val showPosition          : widget * int -> unit
      val xyToPos               : widget * int * int -> int
    end

    structure ToggleButton :
      sig
        val getState : widget -> bool
        val setState : widget * bool -> unit
      end

    structure ToggleButtonGadget :
      sig
        val getState : widget -> bool
        val setState : widget * bool -> unit
      end

    structure Translations :
      sig
        val parseTable		: string -> translations
        val override : widget * translations -> unit
        val augment  : widget * translations -> unit
        val uninstall : widget -> unit
      end

    structure GC:
      sig
        datatype function =
          CLEAR | AND | AND_REVERSE | COPY | 
          AND_INVERTED | NOOP | XOR | OR | 
          NOR | EQUIV | INVERT | OR_REVERSE |
          COPY_INVERTED | OR_INVERTED | NAND | SET

        datatype line_style = LINE_SOLID | LINE_ONOFF_DASH | LINE_DOUBLE_DASH	
        datatype cap_style = CAP_NOT_LAST | CAP_BUTT | CAP_ROUND | CAP_PROJECTING
        datatype join_style = JOIN_MITER | JOIN_ROUND | JOIN_BEVEL
        datatype fill_style = FILL_SOLID | FILL_TILED | FILL_STIPPLED | FILL_OPAQUE_STIPPLED
        datatype fill_rule = EVEN_ODD_RULE | WINDING_RULE
        datatype arc_mode = ARC_CHORD | ARC_PIE_SLICE
        datatype sub_window_mode = CLIP_BY_CHILDREN | INCLUDE_INFERIORS
        datatype clip_spec = NO_CLIP_SPEC | PIXMAP of drawable

        type plane_mask
        datatype gc_value =
          FUNCTION of function | 
          PLANE_MASK of plane_mask | 
          FOREGROUND of pixel |
          BACKGROUND of pixel |
          LINE_WIDTH of int |
          LINE_STYLE of line_style |
          CAP_STYLE of cap_style |
          JOIN_STYLE of join_style |
          FILL_STYLE of fill_style |
          FILL_RULE of fill_rule |
          TILE of drawable |
          STIPPLE of drawable |
          TS_X_ORIGIN of int |
          TS_Y_ORIGIN of int |
          FONT of font |
          SUBWINDOW_MODE of sub_window_mode |
          GRAPHICS_EXPOSURES of bool |
          CLIP_X_ORIGIN of int |
          CLIP_Y_ORIGIN of int |
          CLIP_MASK of clip_spec |
          DASH_OFFSET of int |
          DASHES of int |
          ARC_MODE of arc_mode

        datatype ordering = UNSORTED | Y_SORTED | YX_SORTED | YX_BANDED
        val create : (display * drawable * gc_value list) -> gc
        val change : (display * gc * gc_value list) -> unit
        val free : display * gc -> unit
        val setClipRectangles : display * gc * int * int * (int * int * int * int) list * ordering -> unit

	datatype request =
	  REQUEST_FUNCTION           |
	  REQUEST_PLANE_MASK         |
	  REQUEST_FOREGROUND         |
	  REQUEST_BACKGROUND         |
	  REQUEST_LINE_WIDTH         |
	  REQUEST_LINE_STYLE         |
	  REQUEST_CAP_STYLE          |
	  REQUEST_JOIN_STYLE         |
	  REQUEST_FILL_STYLE         |
	  REQUEST_FILL_RULE          |
	  REQUEST_TILE               |
	  REQUEST_STIPPLE            |
	  REQUEST_TS_X_ORIGIN        |
	  REQUEST_TS_Y_ORIGIN        |
	  REQUEST_FONT               |
	  REQUEST_SUBWINDOW_MODE     |
	  REQUEST_GRAPHICS_EXPOSURES |
	  REQUEST_CLIP_X_ORIGIN      |
	  REQUEST_CLIP_Y_ORIGIN      |
	  REQUEST_CLIP_MASK          |
	  REQUEST_DASH_OFFSET        |
	  REQUEST_DASHES             |
	  REQUEST_ARC_MODE

        val getValues : (display * gc * request list) -> gc_value list
        val copy : (display * gc * request list * gc) -> unit
      end

    structure Draw:
      sig
        datatype coord_mode = ORIGIN | PREVIOUS
        datatype shape = COMPLEX | NONCONVEX | CONVEX
        val string : display * drawable * gc * int * int * string -> unit
        val imageString : display * drawable * gc * int * int * string -> unit
        val line : display * drawable * gc * int * int * int * int -> unit
        val lines : display * drawable * gc * (int * int) list * coord_mode -> unit
        val segments : display * drawable * gc * (int * int * int * int) list -> unit
        val fillPolygon : display * drawable * gc * (int * int) list * shape * coord_mode -> unit
        val point : display * drawable * gc * int * int -> unit
        val points : display * drawable * gc * (int * int) list * coord_mode -> unit
        val rectangle : display * drawable * gc * int * int * int * int -> unit
        val fillRectangle : display * drawable * gc * int * int * int * int -> unit
        val rectangles : display * drawable * gc * (int * int * int * int) list -> unit
        val fillRectangles : display * drawable * gc * (int * int * int * int) list -> unit
        val arc : display * drawable * gc * int * int * int * int * int * int -> unit
        val fillArc : display * drawable * gc * int * int * int * int * int * int -> unit
        val arcs : display * drawable * gc * (int * int * int * int * int * int) list -> unit
        val fillArcs : display * drawable * gc * (int * int * int * int * int * int) list -> unit
        val clearArea : display * drawable * int * int * int * int * bool -> unit
        val copyArea : display * drawable * drawable * gc * int * int * int * int * int * int -> unit
        val copyPlane : display * drawable * drawable * gc * int * int * int * int * int * int * int -> unit
      end

    structure Colormap :
      sig
        val default : screen -> colormap
        val allocColor : display * colormap * (real * real * real) -> pixel
        val allocNamedColor : display * colormap * string -> pixel
        val allocColorCells : display * colormap * bool * int * int -> (pixel MLWorks.Internal.Array.array * pixel MLWorks.Internal.Array.array)
        val freeColors : display * colormap * (pixel MLWorks.Internal.Array.array) * int -> unit
        val storeColor : display * colormap * pixel * (real * real * real) -> unit
        val storeNamedColor : display * colormap * pixel * string -> unit
      end

    exception NotInitialized
    exception XSystemError of string
    exception SubLoopTerminated

    val initialize :
	  string * string * (argument_name * argument_value) list -> widget

    val checkMLWorksResources : unit -> bool
    (* check that the app-defaults file has been found *)

    val mainLoop : unit -> unit
    val doInput : unit -> unit

  end
