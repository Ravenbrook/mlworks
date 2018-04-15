(*  ==== Motif LIBRARY INTERFACE ====
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
 *  Implementation
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: _xm.sml,v $
 *  Revision 1.37  1998/06/30 15:41:50  johnh
 *  [Bug #30431]
 *  Add 'editable' argument type.
 *
 * Revision 1.36  1998/05/22  10:11:18  johnh
 * [Bug #30369]
 * Modifying list callback struct to handle multiple selection cases.
 *
 * Revision 1.35  1998/02/19  20:17:10  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.34  1998/02/18  17:06:40  jont
 * [Bug #70070]
 * Remove MLWorks.IO.terminal_out in favour of Terminal.output
 *
 * Revision 1.33  1997/11/18  14:03:33  johnh
 * [Bug #30322]
 * Add visual functions and Pixel.{to,from}Word32 and set window attr functions.
 *
 * Revision 1.32  1997/11/06  14:05:57  johnh
 * [Bug #30125]
 * Add HELP_MENU_WIDGET arg.
 *
 * Revision 1.31  1997/10/10  09:51:10  johnh
 * [Bug #30204]
 * Fix binding of runtime exceptions.
 *
 * Revision 1.30  1997/05/09  11:14:07  daveb
 * [Bug #30020]
 * Added check_mlworks_resources function.
 *
 * Revision 1.29  1997/05/02  17:16:03  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.28.5.1.3.2  1997/11/18  12:16:44  johnh
 * [Bug #30322]
 * Add visual functions and Pixel.{to,from}Word32 and set window attr functions.
 *
 * Revision 1.28  1996/11/04  12:28:38  daveb
 * [Bug #1699]
 * Changed Xm.GC.Copy to mimic the C function more closely.
 *
 * Revision 1.27  1996/11/01  17:38:15  daveb
 * [Bug #1694]
 * Removed obsolete items.
 *
 * Revision 1.26  1996/10/01  09:36:28  matthew
 * Adding a release colormap function
 *
 * Revision 1.25  1996/09/27  13:39:48  johnh
 * [Bug #1617]
 * Added a check to ensure that XSystemError exn is not overwritten.
 *
 * Revision 1.24  1996/08/16  13:49:59  johnh
 * Fixed the BUTTON_PRESS and BUTTON_RELEASE order.
 *
 * Revision 1.23  1996/05/17  09:59:36  matthew
 * Moved Bits to MLWorks.Internal
 *
 * Revision 1.22  1996/05/07  16:18:10  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.21  1996/05/01  10:33:20  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output
 * and end_of_stream now only available from MLWorks.IO
 *
 * Revision 1.20  1996/04/18  16:50:30  jont
 * initbasis moves to basis
 *
 * Revision 1.19  1996/04/18  14:38:01  daveb
 * Made Xm.Text.posToXY return an option type.
 *
 * Revision 1.18  1996/03/19  17:21:56  matthew
 * Changes for value polymorphism
 *
 * Revision 1.17  1996/03/12  10:53:41  matthew
 * Adding queryPointer
 *
 * Revision 1.16  1996/02/26  16:17:51  matthew
 * Revisions to Xm library
 *
 * Revision 1.15  1996/02/16  17:44:11  nickb
 * a WidgetClass is actually an int ref. Change the type (which is not actually
 * used anywhere) to prevent others from getting as confused as I did.
 *
 * Revision 1.14  1996/02/13  16:10:23  io
 * adding Visual
 *
 * Revision 1.13  1996/02/08  16:25:22  daveb
 * Added List.setPos.
 *
 * Revision 1.12  1996/01/25  17:18:31  matthew
 * Adding set_selection function
 *
 * Revision 1.11  1996/01/05  14:16:11  matthew
 * Added synchronize
 *
 * Revision 1.10  1995/12/07  14:12:44  matthew
 * Adding selection operations for text widgets
 *
 * Revision 1.9  1995/11/15  12:56:15  matthew
 * Adding widget_eq
 *
 * Revision 1.8  1995/10/24  17:08:25  matthew
 * Changing Font.load to load a font not a font_struct
 *
 * Revision 1.7  1995/10/17  16:00:34  nickb
 * Add scale callback conversion.
 *
 * Revision 1.6  1995/10/12  13:21:22  matthew
 * Changing labelPixmap argument type to ARGINT
 *
 * Revision 1.5  1995/10/04  10:31:48  brianm
 * Added Increment to ArgumentName etc.
 *
 * Revision 1.4  1995/09/27  09:52:04  brianm
 * Dummy revision ...
 *
 * Revision 1.3  1995/09/26  10:25:52  brianm
 * Adding copying of graphics contexts and
 * queries for Gc_values in graphics contexts.
 *
 * Revision 1.2  1995/09/22  14:36:27  daveb
 * Added Xm.Text.setHighlight.
 *
 * Revision 1.1  1995/07/26  13:19:22  matthew
 * new unit
 * New unit
 *
 *  Revision 1.50  1995/07/26  13:19:22  matthew
 *  Adding support for font dimensions etc.
 *
 *  Revision 1.49  1995/07/13  11:06:07  matthew
 *  Changing the way clip regions work for GC's
 *
 *  Revision 1.48  1995/07/07  14:45:29  daveb
 *  Added MarginHeight, MarginWidth and Spacing resources.
 *
 *  Revision 1.47  1995/07/06  09:30:26  matthew
 *  Removing real constants
 *
 *  Revision 1.46  1995/06/23  10:41:13  matthew
 *  Adding documentation and expanding
 *
 *  Revision 1.45  1995/06/20  14:09:39  daveb
 *  Added Xm.List.setBottomPos.
 *
 *  Revision 1.44  1995/06/19  13:56:50  matthew
 *  \\nMore graphics functions
 *
 *  Revision 1.43  1995/06/08  13:23:54  matthew
 *  Adding drawing primitives
 *
 *  Revision 1.42  1995/05/10  12:07:55  matthew
 *  Adding popup and createMenuBar
 *
 *  Revision 1.41  1995/05/05  11:40:13  daveb
 *  Changed require statements to use generic module id syntax.
 *
 *  Revision 1.40  1995/04/21  17:01:10  daveb
 *  Added ungrabPointer.
 *
 *  Revision 1.39  1995/04/20  19:53:00  daveb
 *  Made this depend on basis/lists.sml instead of utils/lists.sml.
 *
 *  Revision 1.38  1995/04/13  16:50:05  daveb
 *  Changed mainLoop and doInput back to taking unit.  The runtime caches
 *  the main application shell again, and shares the application context
 *  with all application shells.
 *
 *  Revision 1.37  1995/04/07  16:48:54  daveb
 *  Removed createApplicationShell.
 *
 *  Revision 1.36  1995/04/07  10:43:22  daveb
 *  Repeated calls to initialize return a new application shell.
 *  mainLoop and related functions take an application shell argument.
 *
 *  Revision 1.35  1995/03/09  16:50:20  matthew
 *  Adding some new resources
 *
 *  Revision 1.34  1995/02/27  12:58:08  daveb
 *  Added ScrollBarDisplayPolicy resource.
 *
 *  Revision 1.33  1994/07/20  14:50:43  brianm
 *  Modification of X exception to avoid shadowing of constructor
 *
 *  Revision 1.32  1994/07/11  11:27:33  daveb
 *  Added DirSpec resource.
 *
 *  Revision 1.31  1994/06/30  11:01:45  nickh
 *  Add MLWorks message widget registration.
 *
 *  Revision 1.30  1994/06/23  09:24:16  daveb
 *  Added Xm.Widget.processTraversal.
 *
 *  Revision 1.29  1993/12/20  11:12:19  matthew
 *   Added map and unmap functions
 *
 *  Revision 1.28  1993/12/09  13:58:33  matthew
 *  Added window registering function.
 *
 *  Revision 1.27  1993/11/26  12:13:34  matthew
 *  Added exception SubLoopTerminated, with a handler for it round callbacks.
 *  This is to ensure callbacks always terminate properly when Motif is exitted.
 *  C function do_input returns boolean used to determine if the event loop is to
 *  be aborted.
 *
 *  Revision 1.26  1993/10/08  16:54:31  matthew
 *  Merging in bug fixes
 *
 *  Revision 1.25.1.2  1993/10/08  10:39:13  matthew
 *  Added Destroy callback
 *  Added getSelection and removeSelection to Text structure
 *
 *  Revision 1.25.1.1  1993/08/29  19:31:53  jont
 *  Fork for bug fixing
 *
 *  Revision 1.25  1993/08/29  19:31:53  daveb
 *  Added Directory resource.  Added fileSelectionDoSearch and selectPos.
 *
 *  Revision 1.24  1993/08/26  11:53:02  richard
 *  Moved the X exception here from the pervasive library where it was
 *  cluttering up the environment.
 *
 *  Revision 1.23  1993/08/10  09:36:50  matthew
 *  Added Display substructure with bell function.
 *
 *  Revision 1.22  1993/08/03  16:19:16  matthew
 *  Added toFront function
 *
 *  Revision 1.21  1993/07/29  14:52:36  matthew
 *  Added setBusy and unSetBusy functions.
 *
 *  Revision 1.20  1993/06/03  16:25:50  daveb
 *  Added messageBoxGetChild.
 *
 *  Revision 1.19  1993/05/25  11:41:10  matthew
 *  Added fileSelectionBoxGetChild & ancillary stuff
 *
 *  Revision 1.18  1993/05/19  11:56:21  daveb
 *  Added Packing resource, corrected spelling of RadioBehavior.
 *
 *  Revision 1.17  1993/05/10  10:31:17  matthew
 *  Added Unmap callback
 *
 *  Revision 1.16  1993/04/30  11:20:31  daveb
 *  Made Widgets and some other types admit equality.
 *
 *  Revision 1.15  1993/04/19  16:31:27  matthew
 *   Added ExtendedSelection, BrowseSelection and DefaultAction callbacks
 *  Added getSelectedPos function to List structure
 *
 *  Revision 1.14  1993/04/14  11:20:31  matthew
 *   Added IsHomogeneous argument type
 *
 *  Revision 1.13  1993/04/13  15:07:10  matthew
 *  Replaced missing log message
 *
 *  Revision 1.12  1993/04/08  18:10:00  matthew
 *  Added convert_string_text to CompoundString
 *  Added TextString type
 *
 *  Revision 1.11  1993/04/08  12:31:44  matthew
 *  Removed closeDisplay function
 *
 *  Revision 1.10  1993/04/08  10:13:27  daveb
 *  Added radioBehaviour resource.
 *
 *  Revision 1.9  1993/04/06  15:45:54  daveb
 *  Added Event structure and Callback structure, and functions to convert
 *  Events and Callback data structures to ML.  We need an FFI interface,
 *  whether or not there's a real FFI underneath it.
 *
 *  Revision 1.8  1993/04/01  16:58:44  matthew
 *  Added ApplyCallback
 *
 *  Revision 1.7  1993/03/25  15:54:35  matthew
 *  Added list and text utilities
 *  Changed callback types
 *  Added some callbacks
 *
 *  Revision 1.5  1993/03/17  14:50:29  matthew
 *  Added closeDisplay and doInput functions.
 *
 *  Revision 1.4  1993/03/09  15:02:47  daveb
 *  Added Form widget class and associated resources.  Also added gadgets.
 *
 *  Revision 1.3  1993/03/03  16:12:52  daveb
 *  Added createScrolledText.
 *
 *  Revision 1.2  1993/02/12  16:35:02  daveb
 *  Many changes to support rewrite of X listeners.
 *  Also changed case conventions.
 *
 *  Revision 1.1  1993/01/26  11:57:52  richard
 *  Initial revision
 *
 *)

require "^.utils.__terminal";
require "^.basis.list";
require "xm";

require "^.basis.__word32";

functor Xm (structure List: LIST) : XM =

  struct

    structure Bits = MLWorks.Internal.Bits

    datatype display = DISPLAY of int (* a C pointer: Display* *)
    datatype screen = SCREEN of int
    datatype region = REGION of int (* a C pointer *)
    datatype widget = WIDGET of int (* a C pointer *)
    datatype gc = GC of int         (* a C pointer *)
    datatype widget_class = WIDGETCLASS of int ref (* a C pointer *)

    datatype pixel = PIXEL of MLWorks.Internal.Value.T
    datatype font_struct = FONTSTRUCT of MLWorks.Internal.Value.T
    datatype font_list = FONTLIST of MLWorks.Internal.Value.T
    datatype compound_string = COMPOUNDSTRING of MLWorks.Internal.Value.T
    datatype translations = TRANSLATIONS of MLWorks.Internal.Value.T

    datatype atom = ATOM of int (* This is an unsigned long.  We shift it *)
    datatype gcontext = GCONTEXT of int  (* An XID -- needs a shift *)
    datatype drawable = DRAWABLE of int  (* An XID -- needs a shift *) (* Includes pixmaps and windows *)
    datatype cursor = CURSOR of int      (* An XID -- needs a shift *)
    datatype colormap = COLORMAP of int  (* An XID -- needs a shift *)
    datatype font = FONT of int          (* An XID -- needs a shift *)
    datatype keysym = KEYSYM of int      (* An XID -- needs a shift *)

    type word32 = Word32.word

    exception SubLoopTerminated

    fun debug_output s = Terminal.output(s ^"\n")

    fun env s = MLWorks.Internal.Value.cast (MLWorks.Internal.Runtime.environment s)

    structure Event =
    struct
      datatype event_data = EVENT_DATA of MLWorks.Internal.Value.T

      datatype common = COMMON of
	{eventType: int, serial: int, send_event: bool, display: display,
	 window: drawable}
      (* Boring stuff, common to all events *)

      datatype state = STATE of int
      datatype button_code = BUTTON_CODE of int

      datatype expose_event = EXPOSE_EVENT of
        {common: common,
         x : int, y : int, width : int, height : int, count : int}

      datatype key_event = KEY_EVENT of
        {common: common, root: drawable, subwindow: drawable, time: int,
         x: int, y: int, x_root: int, y_root: int, state: state,
         key: string, same_screen: bool}

      datatype button_event = BUTTON_EVENT of
        {common: common, root: drawable, subwindow: drawable, time: int,
         x: int, y: int, x_root: int, y_root: int, state: state,
         button: button_code, same_screen: bool}

      datatype motion_event = MOTION_EVENT of
        {common: common, root: drawable, subwindow: drawable, time: int,
         x: int, y: int, x_root: int, y_root: int, state: state,
         is_hint : int,same_screen: bool}

      datatype event =
	KEY_PRESS of key_event | KEY_RELEASE of key_event |
        BUTTON_PRESS of button_event | BUTTON_RELEASE of button_event |
        MOTION_NOTIFY of motion_event |
        EXPOSE of expose_event | GRAPHICS_EXPOSE of expose_event |
	ANY_EVENT of common

      datatype modifier =
	SHIFT | LOCK | CONTROL | MOD1 | MOD2 | MOD3 | MOD4 | MOD5

      val convertAny_ = env "x convert AnyEvent"
      val convertKeyEvent_ = env "x convert KeyEvent"
      val convertButtonEvent_ = env "x convert ButtonEvent"
      val convertMotionEvent_ = env "x convert MotionEvent"
      val convertExposeEvent_ = env "x convert ExposeEvent"

      val convertAny: MLWorks.Internal.Value.T -> common = convertAny_
      val convertKeyEvent: common * MLWorks.Internal.Value.T -> key_event =
	    convertKeyEvent_
      val convertButtonEvent: common * MLWorks.Internal.Value.T -> button_event =
	    convertButtonEvent_
      val convertMotionEvent: common * MLWorks.Internal.Value.T -> motion_event =
	    convertMotionEvent_
      val convertExposeEvent: common * MLWorks.Internal.Value.T -> expose_event =
        convertExposeEvent_

      fun convertEvent (EVENT_DATA mlval) =
	let val common = convertAny mlval
	    val COMMON {eventType, ...} = common
	in if eventType = 2 then
             KEY_PRESS (convertKeyEvent (common, mlval))
	   else if eventType = 3 then
	     KEY_RELEASE (convertKeyEvent (common, mlval))
	   else if eventType = 4 then
	     BUTTON_PRESS (convertButtonEvent (common, mlval))
	   else if eventType = 5 then
	     BUTTON_RELEASE (convertButtonEvent (common, mlval))
	   else if eventType = 6 then
             MOTION_NOTIFY (convertMotionEvent (common, mlval))
	   else if eventType = 12 then
	     EXPOSE (convertExposeEvent (common, mlval))
	   else if eventType = 13 then
	     GRAPHICS_EXPOSE (convertExposeEvent (common, mlval))
	   else
	     ANY_EVENT common
	end

      fun convertState (STATE n) =
	let fun check_bit (index, result) =
	      if Bits.andb (n, Bits.lshift (1, index)) <> 0 then
		[result]
	      else
		[]
	    val a_list = [(0, SHIFT), (1, LOCK), (2, CONTROL), (3, MOD1),
		          (4, MOD2),  (5, MOD3), (6, MOD4),    (7, MOD5)]
	in
	  List.foldl op@ [] (map check_bit a_list)
        end

      datatype button = BUTTON1 | BUTTON2 | BUTTON3 | BUTTON4 | BUTTON5

      exception ConvertButton
      fun convertButton (BUTTON_CODE 1) = BUTTON1
      |   convertButton (BUTTON_CODE 2) = BUTTON2
      |   convertButton (BUTTON_CODE 3) = BUTTON3
      |   convertButton (BUTTON_CODE 4) = BUTTON4
      |   convertButton (BUTTON_CODE 5) = BUTTON5
      |   convertButton _ = raise ConvertButton

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

      fun mask_to_int mask =
        case mask of
          KEY_PRESS_MASK => 0
        | KEY_RELEASE_MASK => 1
        | BUTTON_PRESS_MASK => 2
        | BUTTON_RELEASE_MASK => 3
        | ENTER_WINDOW_MASK => 4
        | LEAVE_WINDOW_MASK => 5
        | POINTER_MOTION_MASK => 6
        | POINTER_MOTION_HINT_MASK => 7
        | BUTTON1_MOTION_MASK => 8
        | BUTTON2_MOTION_MASK => 9
        | BUTTON3_MOTION_MASK => 10
        | BUTTON4_MOTION_MASK => 11
        | BUTTON5_MOTION_MASK => 12
        | BUTTON_MOTION_MASK => 13
        | KEYMAP_STATE_MASK => 14
        | EXPOSURE_MASK => 15
        | VISIBILITY_CHANGE_MASK => 16
        | STRUCTURE_NOTIFY_MASK => 17
        | RESIZE_REDIRECT_MASK => 18
        | SUBSTRUCTURE_NOTIFY_MASK => 19
        | SUBSTRUCTURE_REDIRECT_MASK => 20
        | FOCUS_CHANGE_MASK => 21
        | PROPERTY_CHANGE_MASK => 22
        | COLORMAP_CHANGE_MASK => 23
        | OWNER_GRAB_BUTTON_MASK => 24

      val internalAddHandler : widget * int list * bool * (event_data -> unit) -> unit =
        env "x add event handler"

      fun addHandler (widget,masklist,nonmaskable,handler) =
        internalAddHandler (widget,map mask_to_int masklist,nonmaskable,handler)
    end;

    local

      (* ArgRep is used by the runtime system to determine the *)
      (* representation to use for the argument when passing it to X.  The *)
      (* constructor tags are referenced explicitly.  If you change this *)
      (* type you will have to change rts/OS/common/x.c. *)

      (* This type is inappropriate as we need fine distinctions between *)
      (* different int types *)
      datatype ArgRep =
        ARGBOOL of bool ref |				(* tag 0 *)
        ARGBOXED of MLWorks.Internal.Value.T ref |	(* tag 1 *)
        ARGINT of int ref |				(* tag 2 *)
        ARGSHORT of int ref |				(* tag 3 *)
        ARGSTRING of string ref |			(* tag 4 *)
        ARGUNBOXED of MLWorks.Internal.Value.T ref	(* tag 5 *)
        
    in
      
      datatype edit_mode =
	MULTI_LINE_EDIT | SINGLE_LINE_EDIT

      datatype highlight_mode =
	HIGHLIGHT_NORMAL | HIGHLIGHT_SELECTED | HIGHLIGHT_SECONDARY_SELECTED

      datatype selection_policy =
        SINGLE_SELECT | MULTIPLE_SELECT | EXTENDED_SELECT | BROWSE_SELECT

      datatype label_type =
	PIXMAP_LABEL | STRING_LABEL

      datatype char_set =
	CHAR_SET of string

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

      datatype attachment =
        ATTACH_NONE | ATTACH_FORM | ATTACH_OPPOSITE_FORM | ATTACH_WIDGET |
	ATTACH_OPPOSITE_WIDGET | ATTACH_POSITION | ATTACH_SELF

      datatype delete_response =
	DESTROY | UNMAP | DO_NOTHING

      datatype compound_string_direction = L_TO_R | R_TO_L | DEFAULT_DIRECTION

      fun convertStringDirection L_TO_R = 0
        | convertStringDirection R_TO_L = 1
        | convertStringDirection DEFAULT_DIRECTION = 255

      structure Display =
        struct
          val bell_ = env "x bell"
          val bell : display * int -> unit = bell_
          val queryPointer : display * drawable -> (drawable * drawable * int * int * int * int) = env "x query pointer"

 	  val defaultDepth : display * screen -> int = env "x default depth"

          datatype visual_type = 
	    STATIC_GRAY | GRAY_SCALE | STATIC_COLOR | PSEUDO_COLOR | TRUE_COLOR | DIRECT_COLOR

	  fun convert_to_visual_type 0 = STATIC_GRAY
	    | convert_to_visual_type 1 = GRAY_SCALE
	    | convert_to_visual_type 2 = STATIC_COLOR
	    | convert_to_visual_type 3 = PSEUDO_COLOR
	    | convert_to_visual_type 4 = TRUE_COLOR
	    | convert_to_visual_type 5 = DIRECT_COLOR
	    | convert_to_visual_type _ = STATIC_GRAY

	  val get_default_visual = env "x default visual"

 	  fun defaultVisual (d, s) = 
	    let val (vis_type_num, r, g, b, bits) = get_default_visual (d, s)
	    in
	      {vis_type = convert_to_visual_type vis_type_num, 
	       r_value = r,
	       g_value = g,
	       b_value = b,
	       bits_rgb = bits}
	    end
        end

      structure Boolean =
      struct 
        datatype t = BOOLEAN of MLWorks.Internal.Value.T
        val set_ = env "x boolean set"
        val set: t * bool -> unit = set_
      end;

      structure Pixel =
        struct
          val screen_black_	= env "x pixel screen black"
          val screen_white_	= env "x pixel screen white"
          val screenBlack = screen_black_: screen -> pixel
          val screenWhite = screen_white_: screen -> pixel

          fun fromWord32 w = PIXEL (MLWorks.Internal.Value.cast w)
          fun toWord32 (PIXEL p) = MLWorks.Internal.Value.cast p
        end

      (* Real Motif stuff *)
    val isMotifWMRunning : widget -> bool = env"x is motif wm running"
    val updateDisplay : widget -> unit = env"x update display"

    structure Atom =
      struct
        val intern : display * string * bool -> atom = env"x atom intern"
        val getName : display * atom -> string = env"x atom get name"
      end

      structure TabGroup =
        struct
          val add : widget -> unit = env "x tabgroup add"
          val remove : widget -> unit = env "x tabgroup remove"
        end

      structure Pixmap =
        struct
          val create: display * drawable * int * int * int -> drawable = env "x pixmap create"
          val free: display * drawable -> unit = env "x pixmap free"
          val get: screen * string * pixel * pixel -> drawable = env "x pixmap get"
          val destroy: screen * drawable -> unit = env "x pixmap destroy"
        end

      structure Font =
        struct
          val load : display * string -> font = env "x font load"
          (* Do we need a free for Fonts too? *)
          val free : display * font_struct -> unit = env "x fontstruct free"
          val query : display * font -> font_struct = env "x query font"

          val textExtents :
          font_struct * string -> 
          {font_ascent : int,
           font_descent : int,
           ascent : int,
           descent : int,
           lbearing : int,
           rbearing : int,
           width : int} = env "x text extents"
        end
      
      structure FontList =
        struct
          val create_	= env "x fontlist create"
          val add_	= env "x fontlist add"
          val copy_	= env "x fontlist copy"
          val free_	= env "x fontlist free"
          val create : font_struct * char_set -> font_list = create_
          val add : font_list * font_struct * char_set -> font_list = add_
          val copy: font_list -> font_list = copy_
          val free: font_list -> unit = free_
        end

      structure CompoundString =
        struct
          val create_		= env "x string create"
          val direction_create_	= env "x string direction create"
          val separator_create_	= env "x string separator create"
          val segment_create_	= env "x string segment create"
          val create_l_to_r_	= env "x string create l to r"
          val create_simple_	= env "x string create simple"
          val free_		= env "x string free"
          val compare_		= env "x string compare"
          val bytecompare_	= env "x string bytecompare"
          val copy_		= env "x string copy"
          val ncopy_		= env "x string ncopy"
          val concat_		= env "x string concat"
          val nconcat_		= env "x string nconcat"
          val empty_		= env "x string empty"
          val length_		= env "x string length"
          val linecount_	= env "x string linecount"
          val extent_		= env "x string extent"
          val height_		= env "x string height"
          val width_		= env "x string width"
          val convert_string_text_    = env "x string convert text"

          val baseline : font_list * compound_string -> int = env "x string baseline"

          val convertStringText : compound_string -> string = convert_string_text_

          val create: string * char_set -> compound_string = create_

          fun directionCreate (direction: compound_string_direction): compound_string =
            direction_create_ (convertStringDirection direction)

          val separatorCreate: unit -> compound_string = separator_create_

          fun segmentCreate (string: string, charset: char_set,
			     direction: compound_string_direction,
			     withSeparator: bool
			    ): compound_string =
            segment_create_ (string, charset, convertStringDirection direction, withSeparator)

          val createLtoR: string * char_set -> compound_string = create_l_to_r_
          val createSimple: string -> compound_string = create_simple_
          val free: compound_string -> unit = free_

          val hasSubstring        : compound_string * compound_string -> bool = env "x string has substring"
          val compare: compound_string * compound_string -> bool = compare_
          val byteCompare: compound_string * compound_string -> bool = bytecompare_
          val copy: compound_string -> compound_string = copy_
          val nCopy: compound_string * int -> compound_string = ncopy_
          val concat: compound_string * compound_string -> compound_string = concat_
          val nConcat: compound_string * compound_string * int -> compound_string =
	    nconcat_

          val empty: compound_string -> bool = empty_
          val length: compound_string -> int = length_
          val lineCount: compound_string -> int = linecount_

          val extent: font_list * compound_string -> int * int = extent_
          val height: font_list * compound_string -> int = height_
          val width: font_list * compound_string -> int = width_
        end

      structure Translations =
        struct
          val augment:    widget * translations -> unit = env "x translations augment"
          val override:   widget * translations -> unit = env "x translations override"
          val parseTable: string -> translations        = env "x translations parse table"
          val uninstall:  widget -> unit                = env "x translations uninstall"
        end

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
      exception ArgumentRep of string * ArgRep

      structure Callback =
      struct
        datatype callback_data = CALLBACK_DATA of MLWorks.Internal.Value.T
        datatype name =
          ACTIVATE | OK | APPLY | CANCEL | HELP | MOTION_VERIFY | MODIFY_VERIFY |
          LOSING_FOCUS | CASCADING | VALUE_CHANGED | DRAG |
          SINGLE_SELECTION | MULTIPLE_SELECTION | EXTENDED_SELECTION | BROWSE_SELECTION |
          DEFAULT_ACTION | UNMAP | DESTROY | EXPOSE | RESIZE | INPUT

	(* This function is local to this file *)
        fun convert ACTIVATE = "activateCallback"
          | convert OK = "okCallback"
          | convert APPLY = "applyCallback"
          | convert CANCEL = "cancelCallback"
          | convert HELP = "helpCallback"
          | convert MOTION_VERIFY = "motionVerifyCallback"
          | convert MODIFY_VERIFY = "modifyVerifyCallback"
          | convert LOSING_FOCUS = "losingFocusCallback"
          | convert CASCADING = "cascadingCallback"
          | convert VALUE_CHANGED = "valueChangedCallback"
          | convert DRAG = "dragCallback"
          | convert SINGLE_SELECTION = "singleSelectionCallback"
          | convert MULTIPLE_SELECTION = "multipleSelectionCallback"
          | convert EXTENDED_SELECTION = "extendedSelectionCallback"
          | convert BROWSE_SELECTION = "browseSelectionCallback"
          | convert DEFAULT_ACTION = "defaultActionCallback"
          | convert UNMAP = "unmapCallback"
          | convert DESTROY = "destroyCallback"
          | convert EXPOSE = "exposeCallback"
          | convert RESIZE = "resizeCallback"
          | convert INPUT = "inputCallback"

        val convertToggleButton_ = env "x convert ToggleButtonCallbackStruct"
        val convertScale_ = env "x convert ScaleCallbackStruct"
        val convertList_ = env "x convert ListCallbackStruct"
        val convertTextVerify_ = env "x convert TextVerifyCallbackStruct"
        val convertDrawingArea_ = env "x convert DrawingAreaCallbackStruct"
        val convertAny_ = env "x convert AnyCallbackStruct"

	(* These functions are exported. *)
        fun convertDrawingArea (mlval: callback_data) =
	  let 
            val (reason: int, event, window:drawable) = convertDrawingArea_ mlval
	  in 
            (reason, Event.convertEvent event, window)
	  end

	(* These functions are exported. *)
        fun convertToggleButton (mlval: callback_data) =
	  let 
            val (a: int, event, b: int) = convertToggleButton_ mlval
	  in 
            (a, Event.convertEvent event, b)
	  end

        fun convertScale (mlval: callback_data) =
	  let 
            val (a: int, event, b: int) = convertScale_ mlval
	  in 
            (a, Event.convertEvent event, b)
	  end

        val convertList : callback_data -> int * Event.event * compound_string * int * int * compound_string list * int * int list * int =
        fn mlval =>
        let 
          val (a, event, b, c, d, e, f, g, h) =
            convertList_ mlval
        in 
          (a, Event.convertEvent event, b, c, d, e, f, g, h)
        end

        fun convertTextVerify (mlval: callback_data) =
	  let 
            val (a: int, event, b: Boolean.t, c: int, d: int,
                 e: int, f: int, g: string) =
              convertTextVerify_ mlval
	  in 
            (a, Event.convertEvent event, b, c, d, e, f, g)
	  end

        fun convertAny (mlval: callback_data) =
	  let val (a: int, event) = convertAny_ mlval
	  in (a, Event.convertEvent event)
	  end

        val callback_add_		= env "x widget callback add"
        fun add (widget: widget,
                         callback: name,
                         f: callback_data -> unit
                         ): unit =
          callback_add_ (widget, convert callback, 
                         (fn arg => (f arg handle SubLoopTerminated => ())))

      end;

      local
        val cast = MLWorks.Internal.Value.cast

        fun attachToRep ATTACH_NONE = ARGINT (ref 0)
          | attachToRep ATTACH_FORM = ARGINT (ref 1)
          | attachToRep ATTACH_OPPOSITE_FORM = ARGINT (ref 2)
          | attachToRep ATTACH_WIDGET = ARGINT (ref 3)
          | attachToRep ATTACH_OPPOSITE_WIDGET = ARGINT (ref 4)
          | attachToRep ATTACH_POSITION = ARGINT (ref 5)
          | attachToRep ATTACH_SELF = ARGINT (ref 6)

	exception RepToAttach of int

        fun repToAttach 0 = ATTACH_NONE
          | repToAttach 1 = ATTACH_FORM
          | repToAttach 2 = ATTACH_OPPOSITE_FORM
          | repToAttach 3 = ATTACH_WIDGET
          | repToAttach 4 = ATTACH_OPPOSITE_WIDGET
          | repToAttach 5 = ATTACH_POSITION
          | repToAttach 6 = ATTACH_SELF
	  | repToAttach x = raise RepToAttach x
      in
        fun pairToRep (EDIT_MODE, EDIT_MODE_VALUE MULTI_LINE_EDIT) =
	      ("editMode", ARGINT (ref 0))
          | pairToRep (EDIT_MODE, EDIT_MODE_VALUE SINGLE_LINE_EDIT) =
	      ("editMode", ARGINT (ref 1))
	  | pairToRep (EDITABLE, BOOL b) = 
	      ("editable", ARGBOOL (ref b))
          | pairToRep (SELECTION_POLICY, SELECTION_POLICY_VALUE SINGLE_SELECT) =
	      ("selectionPolicy", ARGINT (ref 0))
          | pairToRep (SELECTION_POLICY, SELECTION_POLICY_VALUE MULTIPLE_SELECT)=
	      ("selectionPolicy", ARGINT (ref 1))
          | pairToRep (SELECTION_POLICY, SELECTION_POLICY_VALUE EXTENDED_SELECT)=
	      ("selectionPolicy", ARGINT (ref 2))
          | pairToRep (SELECTION_POLICY, SELECTION_POLICY_VALUE BROWSE_SELECT) =
	      ("selectionPolicy", ARGINT (ref 3))
          | pairToRep (DIRECTORY, COMPOUND_STRING s) =
	      ("directory", ARGUNBOXED (ref (cast s)))
          | pairToRep (DIR_MASK, COMPOUND_STRING s) =
	      ("dirMask", ARGUNBOXED (ref (cast s)))
          | pairToRep (DIR_SPEC, COMPOUND_STRING s) =
	      ("dirSpec", ARGUNBOXED (ref (cast s)))
          | pairToRep (TEXT_STRING, COMPOUND_STRING s) =
	      ("textString", ARGUNBOXED (ref (cast s)))
          | pairToRep (WHICH_BUTTON, INT i) =
	      ("whichButton", ARGINT (ref i))
          | pairToRep (LABEL_PIXMAP, PIXMAP p) =
	      ("labelPixmap", ARGINT (ref (cast p)))
          | pairToRep (LABEL_TYPE, LABEL_TYPE_VALUE STRING_LABEL) =
	      ("labelType", ARGINT (ref 2))
          | pairToRep (LABEL_TYPE, LABEL_TYPE_VALUE PIXMAP_LABEL) =
	      ("labelType", ARGINT (ref 1))
          | pairToRep (LABEL_STRING, COMPOUND_STRING s) =
	      ("labelString", ARGUNBOXED (ref (cast s)))
          | pairToRep (MESSAGE_STRING, COMPOUND_STRING s) =
	      ("messageString", ARGUNBOXED (ref (cast s)))
          | pairToRep (FONT, FONT_VALUE f) =
	      ("fontList", ARGINT (ref (cast f)))
          | pairToRep (FONT_LIST, FONT_LIST_VALUE f) =
	      ("fontList", ARGUNBOXED (ref (cast f)))
          | pairToRep (FOREGROUND, PIXEL p) =
	      ("foreground", ARGBOXED (ref (cast p)))
          | pairToRep (BACKGROUND, PIXEL p) =
	      ("background", ARGBOXED (ref (cast p)))
          | pairToRep (ROW_COLUMN_TYPE, ROW_COLUMN_TYPE_VALUE WORK_AREA) =
	      ("rowColumnType", ARGINT (ref 0))
          | pairToRep (ROW_COLUMN_TYPE, ROW_COLUMN_TYPE_VALUE MENU_BAR) =
	      ("rowColumnType", ARGINT (ref 1))
          | pairToRep (ROW_COLUMN_TYPE, ROW_COLUMN_TYPE_VALUE MENU_PULLDOWN) =
	      ("rowColumnType", ARGINT (ref 2))
          | pairToRep (ROW_COLUMN_TYPE, ROW_COLUMN_TYPE_VALUE MENU_POPUP) =
	      ("rowColumnType", ARGINT (ref 3))
          | pairToRep (ROW_COLUMN_TYPE, ROW_COLUMN_TYPE_VALUE MENU_OPTION) =
	      ("rowColumnType", ARGINT (ref 4))
          | pairToRep (RADIO_BEHAVIOR, BOOL b) =
	      ("radioBehavior", ARGBOOL (ref b))
          | pairToRep (PACKING, PACKING_VALUE PACK_TIGHT) =
	      ("packing", ARGINT (ref 1))
          | pairToRep (PACKING, PACKING_VALUE PACK_COLUMN) =
	      ("packing", ARGINT (ref 2))
          | pairToRep (PACKING, PACKING_VALUE PACK_NONE) =
	      ("packing", ARGINT (ref 3))
          | pairToRep (IS_HOMOGENEOUS, BOOL b) =
	      ("isHomogeneous", ARGBOOL (ref b))
          | pairToRep (COMMAND_WINDOW, WIDGET w) =
	      ("commandWindow", ARGUNBOXED (ref (cast w)))
          | pairToRep (MENUBAR, WIDGET w) =
	      ("menuBar", ARGUNBOXED (ref (cast w)))
	  | pairToRep (MENU_HELP_WIDGET, WIDGET w) = 
	      ("menuHelpWidget", ARGUNBOXED (ref (cast w)))
          | pairToRep (MESSAGE_WINDOW, WIDGET w) =
	      ("messageWindow", ARGUNBOXED (ref (cast w)))
          | pairToRep (WIDTH, INT i) =
	      ("width", ARGSHORT (ref i ))
          | pairToRep (HEIGHT, INT i) =
	      ("height", ARGSHORT (ref i))
          | pairToRep (X, INT i) =
	      ("x", ARGINT (ref i))
          | pairToRep (Y, INT i) =
	      ("y", ARGINT (ref i))
          | pairToRep (SUBMENU_ID, WIDGET w) =
	      ("subMenuId", ARGUNBOXED (ref (cast w)))
          | pairToRep (RESIZE_HEIGHT, BOOL b) =
	      ("resizeHeight", ARGBOOL (ref b))
          | pairToRep (RESIZE_WIDTH, BOOL b) =
	      ("resizeWidth", ARGBOOL (ref b))
          | pairToRep (ORIENTATION, ORIENTATION_VALUE VERTICAL) =
	      ("orientation", ARGINT (ref 1))
          | pairToRep (ORIENTATION, ORIENTATION_VALUE HORIZONTAL) =
	      ("orientation", ARGINT (ref 2))
          | pairToRep (INCREMENT, INT i) =
	      ("increment", ARGINT (ref i))
          | pairToRep (DIALOG_TYPE, DIALOG_TYPE_VALUE DIALOG_ERROR) =
	      ("dialogType", ARGINT (ref 1))
          | pairToRep (DIALOG_TYPE, DIALOG_TYPE_VALUE DIALOG_INFORMATION) =
	      ("dialogType", ARGINT (ref 2))
          | pairToRep (DIALOG_TYPE, DIALOG_TYPE_VALUE DIALOG_MESSAGE) =
	      ("dialogType", ARGINT (ref 3))
          | pairToRep (DIALOG_TYPE, DIALOG_TYPE_VALUE DIALOG_QUESTION) =
	      ("dialogType", ARGINT (ref 4))
          | pairToRep (DIALOG_TYPE, DIALOG_TYPE_VALUE DIALOG_WARNING) =
	      ("dialogType", ARGINT (ref 5))
          | pairToRep (DIALOG_TYPE, DIALOG_TYPE_VALUE DIALOG_WORKING) =
	      ("dialogType", ARGINT (ref 6))
          | pairToRep (SCROLL_HORIZONTAL, BOOL b) =
	      ("scrollHorizontal", ARGBOOL (ref b))
          | pairToRep (SCROLL_VERTICAL, BOOL b) =
	      ("scrollVertical", ARGBOOL (ref b))
          | pairToRep (SCROLL_LEFT_SIDE, BOOL b) =
	      ("scrollLeftSide", ARGBOOL (ref b))
          | pairToRep (SCROLL_TOP_SIDE, BOOL b) =
	      ("scrollTopSide", ARGBOOL (ref b))
          | pairToRep (SCROLLING_POLICY, SCROLLING_POLICY_VALUE AUTOMATIC) =
	      ("scrollingPolicy", ARGINT (ref 0))
          | pairToRep (SCROLLING_POLICY, SCROLLING_POLICY_VALUE APPLICATION_DEFINED) =
	      ("scrollingPolicy", ARGINT (ref 1))
          | pairToRep (SCROLLBAR_DISPLAY_POLICY, SCROLLBAR_DISPLAY_POLICY_VALUE STATIC) =
	      ("scrollBarDisplayPolicy", ARGINT (ref 0))
          | pairToRep (SCROLLBAR_DISPLAY_POLICY, SCROLLBAR_DISPLAY_POLICY_VALUE AS_NEEDED) =
	      ("scrollBarDisplayPolicy", ARGINT (ref 1))
          | pairToRep (SENSITIVE, BOOL b) =
	      ("sensitive", ARGBOOL (ref b))
          | pairToRep (SET, BOOL b) =
	      ("set", ARGBOOL (ref b))
          | pairToRep (WORK_WINDOW, WIDGET w) =
	      ("workWindow", ARGUNBOXED (ref (cast w)))
          | pairToRep (VERTICAL_SCROLLBAR, WIDGET w) =
	      ("verticalScrollBar", ARGUNBOXED (ref (cast w)))
          | pairToRep (HORIZONTAL_SCROLLBAR, WIDGET w) =
	      ("horizontalScrollBar", ARGUNBOXED (ref (cast w)))
          | pairToRep (VALUE, INT i) =
              ("value", ARGINT (ref (cast i)))
          | pairToRep (MAXIMUM, INT i) =
              ("maximum", ARGINT (ref (cast i)))
          | pairToRep (MINIMUM, INT i) =
              ("minimum", ARGINT (ref (cast i)))
          | pairToRep (SLIDER_SIZE, INT i) =
              ("sliderSize", ARGINT (ref (cast i)))
          | pairToRep (COLUMNS, INT i) =
	      ("columns", ARGINT (ref i))
          | pairToRep (SPACING, INT i) =
	      ("spacing", ARGINT (ref i))
          | pairToRep (MARGIN_HEIGHT, INT i) =
	      ("marginHeight", ARGINT (ref i))
          | pairToRep (MARGIN_WIDTH, INT i) =
	      ("marginWidth", ARGINT (ref i))
          | pairToRep (ROWS, INT i) =
	      ("rows", ARGINT (ref i))
          | pairToRep (TITLE, STRING s) =
	      ("title", ARGSTRING (ref s))
          | pairToRep (ICON_NAME, STRING s) =
	      ("iconName", ARGSTRING (ref s))
          | pairToRep (ALLOW_SHELL_RESIZE, BOOL b) =
	      ("allowShellResize", ARGBOOL (ref b))
          | pairToRep (TOP_ATTACHMENT, ATTACHMENT x) =
	      ("topAttachment", attachToRep x)
          | pairToRep (BOTTOM_ATTACHMENT, ATTACHMENT x) =
	      ("bottomAttachment", attachToRep x)
          | pairToRep (LEFT_ATTACHMENT, ATTACHMENT x) =
	      ("leftAttachment", attachToRep x)
          | pairToRep (RIGHT_ATTACHMENT, ATTACHMENT x) =
	      ("rightAttachment", attachToRep x)
          | pairToRep (TOP_WIDGET, WIDGET w) =
	      ("topWidget", ARGUNBOXED (ref (cast w)))
          | pairToRep (BOTTOM_WIDGET, WIDGET w) =
	      ("bottomWidget", ARGUNBOXED (ref (cast w)))
          | pairToRep (LEFT_WIDGET, WIDGET w) =
	      ("leftWidget", ARGUNBOXED (ref (cast w)))
          | pairToRep (RIGHT_WIDGET, WIDGET w) =
	      ("rightWidget", ARGUNBOXED (ref (cast w)))
          | pairToRep (TOP_POSITION, INT i) =
	      ("topPosition", ARGINT (ref i))
          | pairToRep (BOTTOM_POSITION, INT i) =
	      ("bottomPosition", ARGINT (ref i))
          | pairToRep (LEFT_POSITION, INT i) =
	      ("leftPosition", ARGINT (ref i))
          | pairToRep (RIGHT_POSITION, INT i) =
	      ("rightPosition", ARGINT (ref i))
          | pairToRep (TOP_OFFSET, INT i) =
	      ("topOffset", ARGINT (ref i))
          | pairToRep (BOTTOM_OFFSET, INT i) =
	      ("bottomOffset", ARGINT (ref i))
          | pairToRep (LEFT_OFFSET, INT i) =
	      ("leftOffset", ARGINT (ref i))
          | pairToRep (RIGHT_OFFSET, INT i) =
	      ("rightOffset", ARGINT (ref i))
          | pairToRep (DELETE_RESPONSE, DELETE_RESPONSE_VALUE DESTROY) =
	      ("deleteResponse", ARGINT (ref 0))
          | pairToRep (DELETE_RESPONSE, DELETE_RESPONSE_VALUE UNMAP) =
	      ("deleteResponse", ARGINT (ref 1))
          | pairToRep (DELETE_RESPONSE, DELETE_RESPONSE_VALUE DO_NOTHING) =
	      ("deleteResponse", ARGINT (ref 2))
          | pairToRep pair = raise ArgumentType pair

        fun dummyRep EDIT_MODE =
	      ("editMode", ARGINT (ref 0))
	  | dummyRep EDITABLE = 
	      ("editable", ARGBOOL (ref false))
          | dummyRep SELECTION_POLICY =
	      ("selectionPolicy", ARGINT (ref 0))
          | dummyRep DIRECTORY =
	      ("directory", ARGUNBOXED (ref (cast 0)))
          | dummyRep DIR_MASK =
	      ("dirMask", ARGUNBOXED (ref (cast 0)))
          | dummyRep DIR_SPEC =
	      ("dirSpec", ARGUNBOXED (ref (cast 0)))
          | dummyRep TEXT_STRING =
	      ("textString", ARGUNBOXED (ref (cast 0)))
          | dummyRep WHICH_BUTTON =
	      ("whichButton", ARGINT (ref 0))
          | dummyRep LABEL_PIXMAP =
	      ("labelPixmap", ARGINT (ref (cast 0)))
          | dummyRep LABEL_TYPE =
	      ("labelType", ARGINT (ref 0))
          | dummyRep LABEL_STRING =
	      ("labelString", ARGUNBOXED (ref (cast 0)))
          | dummyRep MESSAGE_STRING =
	      ("messageString", ARGUNBOXED (ref (cast 0)))
          | dummyRep FONT =
	      ("font", ARGINT (ref (cast 0)))
          | dummyRep FONT_LIST =
	      ("fontList", ARGUNBOXED (ref (cast 0)))
          | dummyRep FOREGROUND =
	      ("foreground", ARGBOXED (ref (cast ())))
          | dummyRep BACKGROUND =
	      ("background", ARGBOXED (ref (cast ())))
          | dummyRep ROW_COLUMN_TYPE =
	      ("rowColumnType", ARGINT (ref 0))
          | dummyRep RADIO_BEHAVIOR =
	      ("radioBehavior", ARGBOOL (ref false))
          | dummyRep IS_HOMOGENEOUS =
            ("isHomogeneous", ARGBOOL (ref false))
          | dummyRep COMMAND_WINDOW =
	      ("commandWindow", ARGUNBOXED (ref (cast 0)))
          | dummyRep MENUBAR =
	      ("menuBar", ARGUNBOXED (ref (cast 0)))
	  | dummyRep MENU_HELP_WIDGET = 
	      ("menuHelpWidget", ARGUNBOXED (ref (cast 0)))
          | dummyRep MESSAGE_WINDOW =
	      ("messageWindow", ARGUNBOXED (ref (cast 0)))
          | dummyRep SUBMENU_ID =
	      ("subMenuId", ARGUNBOXED (ref (cast 0)))
          | dummyRep WIDTH =
	      ("width", ARGSHORT (ref 0))
          | dummyRep HEIGHT =
	      ("height", ARGSHORT (ref 0))
          | dummyRep X =
	      ("x", ARGINT (ref 0))
          | dummyRep Y =
	      ("y", ARGINT (ref 0))
          | dummyRep RESIZE_WIDTH =
	      ("resizeWidth", ARGBOOL (ref false))
          | dummyRep RESIZE_HEIGHT =
	      ("resizeHeight", ARGBOOL (ref false))
          | dummyRep ORIENTATION =
	      ("orientation", ARGINT (ref 0))
          | dummyRep INCREMENT =
	      ("increment", ARGINT (ref 1))
          | dummyRep PACKING =
	      ("packing", ARGINT (ref 0))
          | dummyRep DIALOG_TYPE =
	      ("dialogType", ARGINT (ref 0))
          | dummyRep SCROLL_HORIZONTAL =
	      ("scrollHorizontal", ARGBOOL (ref false))
          | dummyRep SCROLL_VERTICAL =
	      ("scrollVertical", ARGBOOL (ref false))
          | dummyRep SCROLL_LEFT_SIDE =
	      ("scrollLeftSide", ARGBOOL (ref false))
          | dummyRep SCROLL_TOP_SIDE =
	      ("scrollTopSide", ARGBOOL (ref false))
          | dummyRep SCROLLING_POLICY =
	      ("scrollingPolicy", ARGINT (ref 0))
          | dummyRep SCROLLBAR_DISPLAY_POLICY =
	      ("scrollBarDisplayPolicy", ARGINT (ref 0))
          | dummyRep SENSITIVE =
	      ("sensitive", ARGBOOL (ref false))
          | dummyRep SET =
	      ("set", ARGBOOL (ref false))
          | dummyRep WORK_WINDOW =
	      ("workWindow", ARGUNBOXED (ref (cast 0)))
          | dummyRep VERTICAL_SCROLLBAR =
	      ("verticalScrollBar", ARGUNBOXED (ref (cast 0)))
          | dummyRep HORIZONTAL_SCROLLBAR =
	      ("horizontalScrollBar", ARGUNBOXED (ref (cast 0)))
          | dummyRep VALUE =
	      ("value", ARGINT (ref 0))
          | dummyRep MAXIMUM =
	      ("maximum", ARGINT (ref 0))
          | dummyRep MINIMUM =
	      ("minimum", ARGINT (ref 0))
          | dummyRep SLIDER_SIZE =
	      ("sliderSize", ARGINT (ref 0))
          | dummyRep COLUMNS =
	      ("columns", ARGINT (ref 0))
          | dummyRep SPACING =
	      ("spacing", ARGINT (ref 0))
          | dummyRep MARGIN_WIDTH =
	      ("marginWidth", ARGINT (ref 0))
          | dummyRep MARGIN_HEIGHT =
	      ("marginHeight", ARGINT (ref 0))
          | dummyRep ROWS =
	      ("rows", ARGINT (ref 0))
          | dummyRep TITLE =
	      ("title", ARGSTRING (ref ""))
          | dummyRep ICON_NAME =
	      ("iconName", ARGSTRING (ref ""))
          | dummyRep ALLOW_SHELL_RESIZE =
	      ("allowShellResize", ARGBOOL (ref false))
          | dummyRep TOP_ATTACHMENT =
	      ("topAttachment", ARGINT (ref 0))
          | dummyRep BOTTOM_ATTACHMENT =
	      ("bottomAttachment", ARGINT (ref 0))
          | dummyRep LEFT_ATTACHMENT =
	      ("leftAttachment", ARGINT (ref 0))
          | dummyRep RIGHT_ATTACHMENT =
	      ("rightAttachment", ARGINT (ref 0))
          | dummyRep TOP_WIDGET =
	      ("topWidget", ARGUNBOXED (ref (cast 0)))
          | dummyRep BOTTOM_WIDGET =
	      ("bottomWidget", ARGUNBOXED (ref (cast 0)))
          | dummyRep LEFT_WIDGET =
	      ("leftWidget", ARGUNBOXED (ref (cast 0)))
          | dummyRep RIGHT_WIDGET =
	      ("rightWidget", ARGUNBOXED (ref (cast 0)))
          | dummyRep TOP_POSITION =
	      ("topPosition", ARGINT (ref 0))
          | dummyRep BOTTOM_POSITION =
	      ("bottomPosition", ARGINT (ref 0))
          | dummyRep LEFT_POSITION =
	      ("leftPosition", ARGINT (ref 0))
          | dummyRep RIGHT_POSITION =
	      ("rightPosition", ARGINT (ref 0))
          | dummyRep TOP_OFFSET =
	      ("topOffset", ARGINT (ref 0))
          | dummyRep BOTTOM_OFFSET =
	      ("bottomOffset", ARGINT (ref 0))
          | dummyRep LEFT_OFFSET =
	      ("leftOffset", ARGINT (ref 0))
          | dummyRep RIGHT_OFFSET =
	      ("rightOffset", ARGINT (ref 0))
          | dummyRep DELETE_RESPONSE =
	      ("deleteResponse", ARGINT (ref 0))

        fun repToValue ("editMode", ARGINT (ref 0)) =
	      EDIT_MODE_VALUE MULTI_LINE_EDIT
          | repToValue ("editMode", ARGINT (ref 1)) =
	      EDIT_MODE_VALUE SINGLE_LINE_EDIT
	  | repToValue ("editable", ARGBOOL (ref b)) = 
	      BOOL b
          | repToValue ("selectionPolicy", ARGINT (ref 0)) =
	      SELECTION_POLICY_VALUE SINGLE_SELECT
          | repToValue ("selectionPolicy", ARGINT (ref 1)) =
	      SELECTION_POLICY_VALUE MULTIPLE_SELECT
          | repToValue ("selectionPolicy", ARGINT (ref 2)) =
	      SELECTION_POLICY_VALUE EXTENDED_SELECT
          | repToValue ("selectionPolicy", ARGINT (ref 3)) =
	      SELECTION_POLICY_VALUE BROWSE_SELECT
          | repToValue ("directory", ARGUNBOXED (ref s)) =
	      COMPOUND_STRING (cast s)
          | repToValue ("dirMask", ARGUNBOXED (ref s)) =
	      COMPOUND_STRING (cast s)
          | repToValue ("dirSpec", ARGUNBOXED (ref s)) =
	      COMPOUND_STRING (cast s)
          | repToValue ("textString", ARGUNBOXED (ref s)) =
	      COMPOUND_STRING (cast s)
          | repToValue ("whichButton", ARGINT (ref i)) =
	      INT i
          | repToValue ("labelPixmap", ARGINT (ref p)) =
	      PIXMAP (cast p)
          | repToValue ("labelType", ARGINT (ref 2)) =
	      LABEL_TYPE_VALUE STRING_LABEL
          | repToValue ("labelType", ARGINT (ref 1)) =
	      LABEL_TYPE_VALUE PIXMAP_LABEL
          | repToValue ("labelString", ARGUNBOXED (ref s)) =
	      COMPOUND_STRING (cast s)
          | repToValue ("messageString", ARGUNBOXED (ref s)) =
	      COMPOUND_STRING (cast s)
          | repToValue ("foz", ARGINT (ref f)) =
              FONT_VALUE (cast f)
          | repToValue ("font", ARGINT (ref f)) =
              FONT_VALUE (cast f)
          | repToValue ("fontList", ARGUNBOXED (ref f)) =
	      FONT_LIST_VALUE (cast f)
          | repToValue ("foreground", ARGBOXED (ref p)) =
	      PIXEL (cast p)
          | repToValue ("background", ARGBOXED (ref p)) =
	      PIXEL (cast p)
          | repToValue ("rowColumnType", ARGINT (ref 0)) =
	      ROW_COLUMN_TYPE_VALUE WORK_AREA
          | repToValue ("rowColumnType", ARGINT (ref 1)) =
	      ROW_COLUMN_TYPE_VALUE MENU_BAR
          | repToValue ("rowColumnType", ARGINT (ref 2)) =
	      ROW_COLUMN_TYPE_VALUE MENU_PULLDOWN
          | repToValue ("rowColumnType", ARGINT (ref 3)) =
	      ROW_COLUMN_TYPE_VALUE MENU_POPUP
          | repToValue ("rowColumnType", ARGINT (ref 4)) =
	      ROW_COLUMN_TYPE_VALUE MENU_OPTION
          | repToValue ("radioBehavior", ARGBOOL (ref b)) =
	      BOOL b
          | repToValue ("isHomogeneous", ARGBOOL (ref b)) =
	      BOOL b
          | repToValue ("commandWindow", ARGUNBOXED (ref w)) =
	      WIDGET (cast w)
          | repToValue ("menuBar", ARGUNBOXED (ref w)) =
	      WIDGET (cast w)
          | repToValue ("messageWindow", ARGUNBOXED (ref w)) =
	      WIDGET (cast w)
          | repToValue ("subMenuId", ARGUNBOXED (ref w)) =
	      WIDGET (cast w)
          | repToValue ("width", ARGSHORT (ref i)) =
	      INT i
          | repToValue ("height", ARGSHORT (ref i)) =
	      INT i
          | repToValue ("x", ARGINT (ref i)) =
	      INT i
          | repToValue ("y", ARGINT (ref i)) =
	      INT i
          | repToValue ("resizeWidth", ARGBOOL (ref b))	 =
	      BOOL b
          | repToValue ("resizeHeight", ARGBOOL (ref b)) =
	      BOOL b
          | repToValue ("orientation", ARGINT (ref 1)) =
	      ORIENTATION_VALUE VERTICAL
          | repToValue ("orientation", ARGINT (ref 2)) =
	      ORIENTATION_VALUE HORIZONTAL
          | repToValue ("packing", ARGINT (ref 1)) =
	      PACKING_VALUE PACK_TIGHT
          | repToValue ("packing", ARGINT (ref 2)) =
	      PACKING_VALUE PACK_COLUMN
          | repToValue ("packing", ARGINT (ref 3)) =
	      PACKING_VALUE PACK_NONE
          | repToValue ("dialogType", ARGINT (ref 1)) =
	      DIALOG_TYPE_VALUE DIALOG_ERROR
          | repToValue ("dialogType", ARGINT (ref 2)) =
	      DIALOG_TYPE_VALUE DIALOG_INFORMATION
          | repToValue ("dialogType", ARGINT (ref 3)) =
	      DIALOG_TYPE_VALUE DIALOG_MESSAGE
          | repToValue ("dialogType", ARGINT (ref 4)) =
	      DIALOG_TYPE_VALUE DIALOG_QUESTION
          | repToValue ("dialogType", ARGINT (ref 5)) =
	      DIALOG_TYPE_VALUE DIALOG_WARNING
          | repToValue ("dialogType", ARGINT (ref 6)) =
	      DIALOG_TYPE_VALUE DIALOG_WORKING
          | repToValue ("scrollHorizontal", ARGBOOL (ref b)) =
	      BOOL b
          | repToValue ("scrollVertical", ARGBOOL (ref b)) =
	      BOOL b
          | repToValue ("scrollLeftSide", ARGBOOL (ref b)) =
	      BOOL b
          | repToValue ("scrollTopSide", ARGBOOL (ref b)) =
	      BOOL b
          | repToValue ("scrollingPolicy", ARGINT (ref 0)) =
	      SCROLLING_POLICY_VALUE AUTOMATIC
          | repToValue ("scrollingPolicy", ARGINT (ref 1)) =
	      SCROLLING_POLICY_VALUE APPLICATION_DEFINED
          | repToValue ("sensitive", ARGBOOL (ref b)) =
	      BOOL b
          | repToValue ("set", ARGBOOL (ref b)) =
	      BOOL b
          | repToValue ("workWindow", ARGUNBOXED (ref w)) =
	      WIDGET (cast w)
          | repToValue ("verticalScrollBar", ARGUNBOXED (ref w)) =
	      WIDGET (cast w)
          | repToValue ("horizontalScrollBar", ARGUNBOXED (ref w)) =
	      WIDGET (cast w)
          | repToValue ("value", ARGINT (ref i)) =
	      INT (i)
          | repToValue ("maximum", ARGINT (ref i)) =
	      INT (i)
          | repToValue ("minimum", ARGINT (ref i)) =
	      INT (i)
          | repToValue ("sliderSize", ARGINT (ref i)) =
	      INT (i)
          | repToValue ("marginWidth", ARGINT (ref i)) =
	      INT i
          | repToValue ("marginHeight", ARGINT (ref i)) =
	      INT i
          | repToValue ("columns", ARGINT (ref i)) =
	      INT i
          | repToValue ("rows", ARGINT (ref i)) =
	      INT i
          | repToValue ("title", ARGSTRING (ref s)) =
	      STRING s
          | repToValue ("iconName", ARGSTRING (ref s)) =
	      STRING s
          | repToValue ("allowShellResize", ARGBOOL (ref b)) =
	      BOOL b
	  | repToValue ("topAttachment", ARGINT (ref i)) =
              ATTACHMENT (repToAttach i)
	  | repToValue ("bottomAttachment", ARGINT (ref i)) =
              ATTACHMENT (repToAttach i)
	  | repToValue ("leftAttachment", ARGINT (ref i)) =
              ATTACHMENT (repToAttach i)
	  | repToValue ("rightAttachment", ARGINT (ref i)) =
              ATTACHMENT (repToAttach i)
	  | repToValue ("topWidget", ARGUNBOXED (ref w)) =
              WIDGET (cast w)
	  | repToValue ("bottomWidget", ARGUNBOXED (ref w)) =
              WIDGET (cast w)
	  | repToValue ("leftWidget", ARGUNBOXED (ref w)) =
              WIDGET (cast w)
	  | repToValue ("rightWidget", ARGUNBOXED (ref w)) =
              WIDGET (cast w)
	  | repToValue ("topPosition", ARGINT (ref i)) =
              INT i
	  | repToValue ("bottomPosition", ARGINT (ref i)) =
              INT i
	  | repToValue ("leftPosition", ARGINT (ref i)) =
              INT i
	  | repToValue ("rightPosition", ARGINT (ref i)) =
              INT i
	  | repToValue ("topOffset", ARGINT (ref i)) =
              INT i
	  | repToValue ("bottomOffset", ARGINT (ref i)) =
              INT i
	  | repToValue ("leftOffset", ARGINT (ref i)) =
              INT i
	  | repToValue ("rightOffset", ARGINT (ref i)) =
              INT i
          | repToValue ("deleteResponse", ARGINT (ref 0)) =
	      DELETE_RESPONSE_VALUE DESTROY
          | repToValue ("deleteResponse", ARGINT (ref 1)) =
	      DELETE_RESPONSE_VALUE UNMAP
          | repToValue ("deleteResponse", ARGINT (ref 2)) =
	      DELETE_RESPONSE_VALUE DO_NOTHING
	  | repToValue arg =
	      raise ArgumentRep arg
      end

      val pairToRepList = map pairToRep
      val dummyRepList = map dummyRep
      val repToValueList = map repToValue

      structure Widget =
        struct
          val create_			= env "x widget create"
          val create_popupshell_	= env "x widget create popupshell"
          val create_menubar_	        = env "x widget create menubar"
          val create_pulldownmenu_	= env "x widget create pulldownmenu"
          val create_scrolledtext_	= env "x widget create scrolledtext"
          val destroy_			= env "x widget destroy"
          val realize_			= env "x widget realize"
          val unrealize_		= env "x widget unrealize"
          val is_realized_		= env "x widget is realized"
          val manage_			= env "x widget manage"
          val unmanage_child_		= env "x widget unmanage child"
          val map_			= env "x widget map"
          val unmap_			= env "x widget unmap"
          val popup_                    = env "x widget popup"

          val set_backing_		= env "x widget set backing"
          val set_save_under_ 		= env "x widget set save under"

          val values_set_		= env "x widget values set"
          val values_get_		= env "x widget values get"
          val display_			= env "x widget display"
          val parent_			= env "x widget parent"
          val screen_			= env "x widget screen"
          val window_			= env "x widget window"
          val name_			= env "x widget name"
	  val process_traversal_	= env "x widget process traversal"
          val toFront_ = env "x widget to front"
            

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

          val {  arrowButton: widget_class,
                 arrowButtonGadget: widget_class,
                 bulletinBoard: widget_class,
                 cascadeButton: widget_class,
                 cascadeButtonGadget: widget_class,
	         command: widget_class,
	         dialogShell: widget_class,
	         drawingArea: widget_class,
	         drawnButton: widget_class,
	         fileSelectionBox: widget_class,
		 form: widget_class,
	         frame: widget_class,
	         label: widget_class,
	         labelGadget: widget_class,
	         list: widget_class,
	         mainWindow: widget_class,
	         menuShell: widget_class,
	         messageBox: widget_class,
	         panedWindow: widget_class,
	         pushButton: widget_class,
	         pushButtonGadget: widget_class,
	         rowColumn: widget_class,
	         scale: widget_class,
	         scrollBar: widget_class,
	         scrolledWindow: widget_class,
	         selectionBox: widget_class,
	         separator: widget_class,
	         separatorGadget: widget_class,
	         text: widget_class,
	         textField: widget_class,
	         toggleButton: widget_class,
	         toggleButtonGadget: widget_class,
	         primitive: widget_class,
	         manager: widget_class,
	         shell: widget_class,
	         overrideShell: widget_class,
	         wmShell: widget_class,
	         transientShell: widget_class,
	         topLevelShell: widget_class,
	         applicationShell: widget_class} =
              env "x widget class table"
  
	      (* rep converts a ClassName to the matching widget_class *)

          fun class_rep ARROW_BUTTON = arrowButton
	    |   class_rep ARROW_BUTTON_GADGET = arrowButtonGadget
	    |   class_rep BULLETIN_BOARD = bulletinBoard
	    |   class_rep CASCADE_BUTTON = cascadeButton
	    |   class_rep CASCADE_BUTTON_GADGET = cascadeButtonGadget
	    |   class_rep COMMAND = command
	    |   class_rep DIALOG_SHELL = dialogShell
	    |   class_rep DRAWING_AREA = drawingArea
	    |   class_rep DRAWN_BUTTON = drawnButton
	    |   class_rep FILE_SELECTION_BOX = fileSelectionBox
	    |   class_rep FORM = form
	    |   class_rep FRAME = frame
	    |   class_rep LABEL = label
	    |   class_rep LABEL_GADGET = labelGadget
	    |   class_rep LIST = list
	    |   class_rep MAIN_WINDOW = mainWindow
	    |   class_rep MENU_SHELL = menuShell
	    |   class_rep MESSAGE_BOX = messageBox
	    |   class_rep PANED_WINDOW = panedWindow
	    |   class_rep PUSH_BUTTON = pushButton
	    |   class_rep PUSH_BUTTON_GADGET = pushButtonGadget
	    |   class_rep ROW_COLUMN = rowColumn
	    |   class_rep SCALE = scale
	    |   class_rep SCROLLBAR = scrollBar
	    |   class_rep SCROLLED_WINDOW = scrolledWindow
	    |   class_rep SELECTION_BOX = selectionBox
	    |   class_rep SEPARATOR = separator
	    |   class_rep SEPARATOR_GADGET = separatorGadget
	    |   class_rep TEXT = text
	    |   class_rep TEXT_FIELD = textField
	    |   class_rep TOGGLE_BUTTON = toggleButton
	    |   class_rep TOGGLE_BUTTON_GADGET = toggleButtonGadget
	    |   class_rep PRIMITIVE = primitive
	    |   class_rep MANAGER = manager
	    |   class_rep SHELL = shell
	    |   class_rep OVERRIDE_SHELL = overrideShell
	    |   class_rep WM_SHELL = wmShell
	    |   class_rep TRANSIENT_SHELL = transientShell
	    |   class_rep TOP_LEVEL_SHELL = topLevelShell
	    |   class_rep APPLICATION_SHELL = applicationShell

          datatype grab_mode = GRAB_NONE | GRAB_NONEXCLUSIVE | GRAB_EXCLUSIVE

          datatype process_traversal =
            TRAVERSE_CURRENT | TRAVERSE_DOWN | TRAVERSE_HOME | TRAVERSE_LEFT |
            TRAVERSE_NEXT | TRAVERSE_NEXT_TAB_GROUP | TRAVERSE_PREV |
            TRAVERSE_PREV_TAB_GROUP | TRAVERSE_RIGHT | TRAVERSE_UP

          fun create (name: string, class: class_name, parent: widget,
		      arguments: (argument_name * argument_value) list): widget =
            create_ (name, class_rep class, parent,
		     pairToRepList arguments)

          fun createPopupShell (name: string, class: class_name, parent: widget,
				arguments: (argument_name * argument_value) list) : widget =
            create_popupshell_ (name, class_rep class, parent,
				pairToRepList arguments)

          fun createPulldownMenu (parent: widget, name: string,
				  arguments: (argument_name * argument_value) list): widget =
	    create_pulldownmenu_ (parent, name, pairToRepList arguments)

          fun createMenuBar (parent: widget, name: string,
                             arguments: (argument_name * argument_value) list): widget =
	    create_menubar_ (parent, name, pairToRepList arguments)

          fun createScrolledText (parent: widget, name: string,
				  arguments: (argument_name * argument_value) list
				 ): widget =
	    create_scrolledtext_ (parent, name, pairToRepList arguments)

          val destroy: widget -> unit = destroy_

          val manage: widget -> unit = manage_
          val unmanageChild : widget -> unit = unmanage_child_

          val map: widget -> unit = map_
          val unmap: widget -> unit = unmap_

          val realize: widget -> unit = realize_
          val unrealize: widget -> unit = unrealize_
          val isRealized: widget -> bool = is_realized_

          fun popup (w : widget, mode : grab_mode) : unit =
            let
              val cmode =
                case mode of
                  GRAB_NONE => 0
                | GRAB_NONEXCLUSIVE => 1
                | GRAB_EXCLUSIVE => 2
            in
              popup_ (w,cmode)
            end
            
          fun createManaged (argument: string * class_name * widget * (argument_name * argument_value) list
                             ): widget =
            let
              val widget = create argument
            in
              manage widget;
              widget
            end

	  datatype backing_store = NOT_USEFUL | WHEN_MAPPED | ALWAYS
	  fun convertBackingStore NOT_USEFUL = 0
	    | convertBackingStore WHEN_MAPPED = 1
	    | convertBackingStore ALWAYS = 2

	  fun setBacking (w, bs, w1, w2) : unit = 
	    set_backing_ (w, convertBackingStore bs, w1, w2)
          val setSaveUnder  : widget * bool -> unit = set_save_under_

          fun valuesSet (widget: widget,
			 arguments:(argument_name * argument_value) list
			): unit =
            values_set_ (widget, pairToRepList arguments)

          fun valuesGet (widget: widget,
			 arguments: argument_name list
			): argument_value list =
            let
              val list = dummyRepList arguments
            in
              ignore(values_get_ (widget, list));
              repToValueList list
            end

	  fun processTraversal (widget: widget, arg: process_traversal): bool =
	    let val carg = 
		  case arg of
		    TRAVERSE_CURRENT => 0
		  | TRAVERSE_DOWN => 7
		  | TRAVERSE_HOME => 3
		  | TRAVERSE_LEFT => 8
		  | TRAVERSE_NEXT => 1
		  | TRAVERSE_NEXT_TAB_GROUP => 4
		  | TRAVERSE_PREV => 2
		  | TRAVERSE_PREV_TAB_GROUP => 5
		  | TRAVERSE_RIGHT => 9
		  | TRAVERSE_UP => 6
	    in process_traversal_ (widget, carg)
	    end

          val display: widget -> display = display_
          val window: widget -> drawable = window_
          val screen: widget -> screen = screen_
          val parent: widget -> widget = parent_
          val name: widget -> string = name_
          val toFront : widget -> unit = toFront_

        end

      structure Child =
        struct
          datatype name =
                NONE |
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

          fun convert name =
                case name of
                  NONE => 0
                | APPLY_BUTTON => 1
                | CANCEL_BUTTON => 2
                | DEFAULT_BUTTON => 3
                | OK_BUTTON => 4
                | FILTER_LABEL => 5
                | FILTER_TEXT => 6
                | HELP_BUTTON => 7
                | LIST =>  8
                | HISTORY_LIST => 8
                | LIST_LABEL =>  9
                | MESSAGE_LABEL => 10
                | SELECTION_LABEL =>  11
                | PROMPT_LABEL => 11
                | SYMBOL_LABEL => 12
                | TEXT => 13
                | VALUE_TEXT => 13
                | COMMAND_TEXT => 13
                | SEPARATOR => 14
                | DIR_LIST => 15
                | DIR_LIST_LABEL => 16
                | FILE_LIST => 8
                | FILE_LIST_LABEL => 9
        end

      structure CascadeButton =
        struct
          val highlight : widget * bool -> unit = env "x cascade button highlight"
        end

      structure CascadeButtonGadget =
        struct
          val highlight : widget * bool -> unit = env "x cascade button gadget highlight"
        end

      structure FileSelectionBox =
        struct
          val get_child_ = env "x file selection box get child"
          val do_search_ = env "x file selection do search"
          fun doSearch (widget:widget, dirmask:compound_string) : unit =
            do_search_ (widget, dirmask)

          fun getChild (widget:widget,child : Child.name) : widget =
            get_child_(widget,Child.convert child)
        end
        
      structure MessageBox =
        struct
          val get_child_ = env "x message box get child"
          fun getChild (widget:widget,child : Child.name) : widget =
            get_child_(widget,Child.convert child)
        end

      structure SelectionBox =
        struct
          val get_child_ = env "x selection box get child"
          fun getChild (widget:widget,child : Child.name) : widget =
            get_child_(widget,Child.convert child)
        end

      structure Text =
      struct
        val getString_             = env "x text getstring"
        val setString_             = env "x text setstring"
        val getLastPosition_       = env "x text getlastposition"
        val getInsertionPosition_  = env "x text getinsertionposition"
        val setInsertionPosition_  = env "x text setinsertionposition"
        val insert_                = env "x text insert"
        val replace_               = env "x text replace"
        val setHighlight_: widget * int * int * int -> unit          = env "x text sethighlight"
        val getSelection_          = env "x text getselection"
        val setSelection_          = env "x text setselection"
        val removeSelection_       = env "x text remove"
        val scroll_                = env "x text scroll"
        val setTopCharacter_       = env "x text set top character"
        val showPosition_          = env "x text show position"
        val xyToPos_               = env "x text xy to pos"
        val posToXY_               = env "x text pos to xy"

        val clearSelection : widget -> unit = env "x text clear selection"
        val copy : widget -> unit = env "x text copy selection"
        val cut : widget -> unit = env "x text cut selection"
        val getBaseline : widget -> int = env "x text get baseline"
        val getEditable : widget -> int = env "x text get editable"
        val getInsertionPosition: widget -> int = getInsertionPosition_
        val getLastPosition: widget -> int = getLastPosition_
        val getMaxLength : widget -> int = env "x text get max length"
        val getSelection : widget -> string = getSelection_
        val getSelectionPosition  : widget -> int * int = env "x text get selection position"
        val getString: widget -> string = getString_
        val getTopCharacter       : widget -> int = env "x text get top character"
        val insert: widget * int * string -> unit = insert_
        val paste : widget -> unit = env "x text paste selection"

        fun posToXY (w: widget, pos: int): (int * int) option =
	  case posToXY_ (w, pos) of
	    (~1, ~1) => NONE
	  | x => SOME x

        val remove : widget -> unit = removeSelection_
        val replace: widget * int * int * string -> unit = replace_
        val scroll : widget * int -> unit = scroll_
        val setAddMode            : widget * bool -> unit = env "x text set add mode"
        val setEditable           : widget * bool -> unit = env "x text set editable"
        fun setHighlight (w, s, e, HIGHLIGHT_NORMAL) =
	  setHighlight_ (w, s, e, 0)
        |   setHighlight (w, s, e, HIGHLIGHT_SELECTED) =
	  setHighlight_ (w, s, e, 1)
        |   setHighlight (w, s, e, HIGHLIGHT_SECONDARY_SELECTED) =
	  setHighlight_ (w, s, e, 2)
        val setInsertionPosition: widget * int -> unit = setInsertionPosition_
        val setMaxLength          : widget * int -> unit = env "x text set max length"
        val setSelection : widget * int * int -> unit = setSelection_
        val setString: widget * string -> unit = setString_
        val setTopCharacter : widget * int -> unit = setTopCharacter_
        val showPosition : widget * int -> unit = showPosition_
        val xyToPos : widget * int * int -> int = xyToPos_

      end;

      structure ToggleButton =
        struct
          val getState : widget -> bool = env "x toggle button get state"
          val setState : widget * bool -> unit = env "x toggle button set state"
        end

      structure ToggleButtonGadget =
        struct
          val getState : widget -> bool = env "x toggle button gadget get state"
          val setState : widget * bool -> unit = env "x toggle button gadget set state"
        end


      structure GC =
        struct
          datatype function =
            CLEAR | AND | AND_REVERSE | COPY | 
            AND_INVERTED | NOOP | XOR | OR | 
            NOR | EQUIV | INVERT | OR_REVERSE |
            COPY_INVERTED | OR_INVERTED | NAND | SET

          fun function_to_int f =
            case f of
              CLEAR => 0
            | AND => 1
            | AND_REVERSE => 2
            | COPY  => 3
            | AND_INVERTED => 4
            | NOOP => 5
            | XOR => 6
            | OR => 7
            | NOR => 8
            | EQUIV => 9
            | INVERT => 10
            | OR_REVERSE => 11
            | COPY_INVERTED  => 12
            | OR_INVERTED  => 13
            | NAND => 14
            | SET => 15

          fun int_to_function i =
            case i of
              0 =>  CLEAR
            | 1 =>  AND
            | 2 =>  AND_REVERSE
            | 3 =>  COPY
            | 4 =>  AND_INVERTED
            | 5 =>  NOOP
            | 6 =>  XOR
            | 7 =>  OR
            | 8 =>  NOR
            | 9 =>  EQUIV
            | 10 => INVERT
            | 11 => OR_REVERSE
            | 12 => COPY_INVERTED
            | 13 => OR_INVERTED
            | 14 => NAND
            | 15 => SET
            | _  => SET

          datatype line_style = LINE_SOLID | LINE_ONOFF_DASH | LINE_DOUBLE_DASH	
          fun lineStyle_to_int style =
            case style of
              LINE_SOLID => 0 
            | LINE_ONOFF_DASH => 1
            | LINE_DOUBLE_DASH => 2

          fun int_to_lineStyle i =
            case i of
              0 => LINE_SOLID 
            | 1 => LINE_ONOFF_DASH
            | 2 => LINE_DOUBLE_DASH
            | _ => LINE_DOUBLE_DASH

          datatype cap_style = CAP_NOT_LAST | CAP_BUTT | CAP_ROUND | CAP_PROJECTING

          fun capStyle_to_int style =
            case style of
              CAP_NOT_LAST => 0
            | CAP_BUTT => 1
            | CAP_ROUND => 2
            | CAP_PROJECTING => 3

          fun int_to_capStyle i =
            case i of
              0 => CAP_NOT_LAST
            | 1 => CAP_BUTT
            | 2 => CAP_ROUND
            | 3 => CAP_PROJECTING
            | _ => CAP_PROJECTING

          datatype join_style = JOIN_MITER | JOIN_ROUND | JOIN_BEVEL

          fun joinStyle_to_int style = 
            case style of 
              JOIN_MITER => 0
            | JOIN_ROUND => 1
            | JOIN_BEVEL => 2

          fun int_to_joinStyle i = 
            case i of 
              0 => JOIN_MITER
            | 1 => JOIN_ROUND
            | 2 => JOIN_BEVEL
            | _ => JOIN_BEVEL

          datatype fill_style = FILL_SOLID | FILL_TILED | FILL_STIPPLED | FILL_OPAQUE_STIPPLED

          fun fillStyle_to_int style = 
            case style of
              FILL_SOLID => 0
            | FILL_TILED => 1
            | FILL_STIPPLED => 2
            | FILL_OPAQUE_STIPPLED => 3

          fun int_to_fillStyle i = 
            case i of
              0 => FILL_SOLID
            | 1 => FILL_TILED
            | 2 => FILL_STIPPLED
            | 3 => FILL_OPAQUE_STIPPLED
            | _ => FILL_OPAQUE_STIPPLED

          datatype fill_rule = EVEN_ODD_RULE | WINDING_RULE

          fun fillRule_to_int rule = 
            case rule of
              EVEN_ODD_RULE => 0
            | WINDING_RULE => 1

          fun int_to_fillRule i = 
            case i of
              0 => EVEN_ODD_RULE
            | _ => WINDING_RULE


          datatype arc_mode = ARC_CHORD | ARC_PIE_SLICE

          fun arcMode_to_int mode =
            case mode of
              ARC_CHORD => 0
            | ARC_PIE_SLICE => 1

          fun int_to_arcMode i =
            case i of
              0 => ARC_CHORD
            | 1 => ARC_PIE_SLICE
            | _ => ARC_PIE_SLICE

          
          datatype sub_window_mode = CLIP_BY_CHILDREN | INCLUDE_INFERIORS

          fun subWindowMode_to_int mode =
            case mode of
              CLIP_BY_CHILDREN => 0
            | INCLUDE_INFERIORS => 1

          fun int_to_subWindowMode i =
            case i of
              0 => CLIP_BY_CHILDREN
            | 1 => INCLUDE_INFERIORS
            | _ => INCLUDE_INFERIORS

          fun int_to_bool i =
              case i of
                0 => false
              | 1 => true
              | _ => true

          fun bool_to_int b = if b then 1 else 0

          datatype clip_spec = NO_CLIP_SPEC | PIXMAP of drawable

          val cast = MLWorks.Internal.Value.cast
          val primary = MLWorks.Internal.Value.primary

          fun mlval_to_ClipSpec (v : MLWorks.Internal.Value.T) =
	    if primary v = 0 andalso cast v <> 0 then
	      PIXMAP(cast v)
	    else NO_CLIP_SPEC (* error case *)

        datatype plane_mask = PM of MLWorks.Internal.Value.T

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

          fun gc_value_index value =
            case value of
              FUNCTION _ => 0
            | PLANE_MASK _ => 1
            | FOREGROUND _ => 2
            | BACKGROUND _ => 3
            | LINE_WIDTH _ => 4
            | LINE_STYLE _ => 5
            | CAP_STYLE _ => 6
            | JOIN_STYLE _ => 7
            | FILL_STYLE _ => 8
            | FILL_RULE _ => 9
            | TILE _ => 10
            | STIPPLE _ => 11
            | TS_X_ORIGIN _ => 12
            | TS_Y_ORIGIN _ => 13
            | FONT _ => 14
            | SUBWINDOW_MODE _ => 15
            | GRAPHICS_EXPOSURES _ => 16
            | CLIP_X_ORIGIN _ => 17
            | CLIP_Y_ORIGIN _ => 18
            | CLIP_MASK _ => 19
            | DASH_OFFSET _ => 20
            | DASHES _ => 21
            | ARC_MODE _ => 22

          fun convert_value value : MLWorks.Internal.Value.T =
            case value of
              FUNCTION f => cast (function_to_int f)
            | PLANE_MASK m => cast m
            | FOREGROUND p => cast p
            | BACKGROUND p => cast p
            | LINE_WIDTH i => cast i
            | LINE_STYLE s => cast (lineStyle_to_int s)
            | CAP_STYLE s => cast (capStyle_to_int s)
            | JOIN_STYLE s => cast (joinStyle_to_int s)
            | FILL_STYLE s => cast (fillStyle_to_int s)
            | FILL_RULE r => cast (fillRule_to_int r)
            | TILE pixmap => cast pixmap
            | STIPPLE pixmap => cast pixmap
            | TS_X_ORIGIN x => cast x
            | TS_Y_ORIGIN y => cast y
            | FONT font => cast font
            | SUBWINDOW_MODE mode => cast (subWindowMode_to_int mode)
            | GRAPHICS_EXPOSURES b => cast (bool_to_int b)
            | CLIP_X_ORIGIN x => cast x
            | CLIP_Y_ORIGIN y => cast y
            | CLIP_MASK (PIXMAP pixmap) => cast pixmap
            | CLIP_MASK NO_CLIP_SPEC => cast 0
            | DASH_OFFSET offset => cast offset
            | DASHES n => cast n
            | ARC_MODE m => cast (arcMode_to_int m)

          datatype ordering = UNSORTED | Y_SORTED | YX_SORTED | YX_BANDED
          fun ordering_to_int ordering =
            case ordering of
              UNSORTED => 0
            | Y_SORTED => 1
            | YX_SORTED => 2
            | YX_BANDED => 3

          val num_gc_values = 23 (* The number of items we need to make a GContext *)

          fun convert ([],array) = ()
            | convert (value::rest,array) =
              let
                val mlvalue = convert_value value
                val index = gc_value_index value
              in
                MLWorks.Internal.Array.update (array,index,SOME mlvalue);
                convert (rest, array)
              end

          type MLvalOptArray =
               MLWorks.Internal.Value.T option MLWorks.Internal.Array.array

          type MLvalArray =
               MLWorks.Internal.Value.T MLWorks.Internal.Array.array

          val internal_create : (display * drawable * MLvalOptArray) -> gc = 
              env "x gc create"

          val internal_change : (display * gc * MLvalOptArray) -> unit = 
              env "x gc change"

          val internal_setClipRectangles : 
              (display * gc * int * int * (int * int * int * int) list * int) -> unit =
              env "x gc set clip rectangles"

          fun create (display,drawable,values) =
            let
              val value_array = MLWorks.Internal.Array.array (num_gc_values, NONE)
              (* Reverse the list so earlier values override later values *)
              val _ = convert (rev values,value_array)
            in
              internal_create (display,drawable,value_array)
            end

          fun change (display,gc,values) =
            let
              val value_array = MLWorks.Internal.Array.array (num_gc_values, NONE)
              (* Reverse the list so earlier values override later values *)
              val _ = convert (rev values,value_array)
            in
              internal_change (display,gc,value_array)
            end

          val free : (display * gc) -> unit           = env "x gc free"

          fun setClipRectangles (display,gc,xoffset,yoffset,rects,ordering) =
            internal_setClipRectangles (display,gc,xoffset,yoffset,rects,ordering_to_int ordering)

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

          fun gc_request_code value =
            case value of
              REQUEST_FUNCTION           => 0
            | REQUEST_PLANE_MASK         => 1
            | REQUEST_FOREGROUND         => 2
            | REQUEST_BACKGROUND         => 3
            | REQUEST_LINE_WIDTH         => 4
            | REQUEST_LINE_STYLE         => 5
            | REQUEST_CAP_STYLE          => 6
            | REQUEST_JOIN_STYLE         => 7
            | REQUEST_FILL_STYLE         => 8
            | REQUEST_FILL_RULE          => 9
            | REQUEST_TILE               => 10
            | REQUEST_STIPPLE            => 11
            | REQUEST_TS_X_ORIGIN        => 12
            | REQUEST_TS_Y_ORIGIN        => 13
            | REQUEST_FONT               => 14
            | REQUEST_SUBWINDOW_MODE     => 15
            | REQUEST_GRAPHICS_EXPOSURES => 16
            | REQUEST_CLIP_X_ORIGIN      => 17
            | REQUEST_CLIP_Y_ORIGIN      => 18
            | REQUEST_CLIP_MASK          => 19
            | REQUEST_DASH_OFFSET        => 20
            | REQUEST_DASHES             => 21
            | REQUEST_ARC_MODE           => 22

          fun gc_request_decode (value,(itm : MLWorks.Internal.Value.T)) =
	      case value of
		REQUEST_FUNCTION    => FUNCTION(int_to_function(cast itm))
	      | REQUEST_PLANE_MASK  => PLANE_MASK(cast itm)
	      | REQUEST_FOREGROUND  => FOREGROUND(cast itm)
	      | REQUEST_BACKGROUND  => BACKGROUND(cast itm)
	      | REQUEST_LINE_WIDTH  => LINE_WIDTH(cast itm)
	      | REQUEST_LINE_STYLE  => LINE_STYLE(int_to_lineStyle(cast itm))
	      | REQUEST_CAP_STYLE   => CAP_STYLE(int_to_capStyle(cast itm))
	      | REQUEST_JOIN_STYLE  => JOIN_STYLE(int_to_joinStyle(cast itm))
	      | REQUEST_FILL_STYLE  => FILL_STYLE(int_to_fillStyle(cast itm))
	      | REQUEST_FILL_RULE   => FILL_RULE(int_to_fillRule(cast itm))
	      | REQUEST_TILE        => TILE(cast itm)
	      | REQUEST_STIPPLE     => STIPPLE(cast itm)
	      | REQUEST_TS_X_ORIGIN => TS_X_ORIGIN(cast itm) 
	      | REQUEST_TS_Y_ORIGIN => TS_Y_ORIGIN(cast itm) 
	      | REQUEST_FONT        => FONT(cast itm)
	      | REQUEST_SUBWINDOW_MODE     => SUBWINDOW_MODE(int_to_subWindowMode(cast itm))
	      | REQUEST_GRAPHICS_EXPOSURES => GRAPHICS_EXPOSURES(int_to_bool(cast itm))
	      | REQUEST_CLIP_X_ORIGIN      => CLIP_X_ORIGIN(cast itm)
	      | REQUEST_CLIP_Y_ORIGIN      => CLIP_Y_ORIGIN(cast itm)
	      | REQUEST_CLIP_MASK          => CLIP_MASK(mlval_to_ClipSpec(itm))
	      | REQUEST_DASH_OFFSET        => DASH_OFFSET(cast itm)
	      | REQUEST_DASHES             => DASHES(cast itm)
	      | REQUEST_ARC_MODE           => ARC_MODE(int_to_arcMode(cast itm))

          local

             val sub    = MLWorks.Internal.Array.sub

             val lshift = Bits.lshift
             val andb   = Bits.andb
             val orb    = Bits.orb

             fun bit (n) = lshift(1,n)
                 
             fun make_mask (maskval,gc_req::rest) =
		 let val code = gc_request_code(gc_req)
		     val new_mask = orb(maskval, bit(code))
		 in
		     make_mask(new_mask,rest)
		 end
	       | make_mask(maskval,[]) = maskval

             fun app f = 
	       let fun loop (a::rest) = (ignore(f(a)); loop(rest))
                     | loop []        = ()
               in
                   loop
               end
          in
	     fun gc_result_mask (l) = make_mask(0,l)

             fun make_gc_values_list (mask, res_arr) =
                 let val res = ref([] : gc_value list)

                     fun push_when (b) (itm) =
                         if b then (res := itm :: !res) else ()

                     fun check(gc_req) =
                         let val code = gc_request_code(gc_req)
                         in
			    push_when
                               (andb(mask,bit(code)) <> 0)
			       (gc_request_decode(gc_req,sub(res_arr,code)))
                         end
                 in
                    (
                      app check
			  [ REQUEST_FUNCTION,
			    REQUEST_PLANE_MASK,
			    REQUEST_FOREGROUND,
			    REQUEST_BACKGROUND,
			    REQUEST_LINE_WIDTH,
			    REQUEST_LINE_STYLE,
			    REQUEST_CAP_STYLE,
			    REQUEST_JOIN_STYLE,
			    REQUEST_FILL_STYLE,
			    REQUEST_FILL_RULE,
			    REQUEST_TILE,
			    REQUEST_STIPPLE,
			    REQUEST_TS_X_ORIGIN,
			    REQUEST_TS_Y_ORIGIN,
			    REQUEST_FONT,
			    REQUEST_SUBWINDOW_MODE,
			    REQUEST_GRAPHICS_EXPOSURES,
			    REQUEST_CLIP_X_ORIGIN,
			    REQUEST_CLIP_Y_ORIGIN,
			    REQUEST_CLIP_MASK,
			    REQUEST_DASH_OFFSET,
			    REQUEST_DASHES,
			    REQUEST_ARC_MODE ];
		      rev(!res)
                    )
                 end
          end

	  val internal_copy : (display * gc * int * gc) -> unit =
	    env "x gc copy"

	  fun copy (disp,src,gc_reql,dst) =
	      let val mask = gc_result_mask(gc_reql)
	      in
		internal_copy (disp,src,mask,dst)
	      end

          val internal_get_values_ : (display * gc * int * MLvalArray) -> gc_value list =
              env "x gc get values"

          val null_value : MLWorks.Internal.Value.T = cast 0

          fun getValues (disp,gc,gc_reql) =
              let val mask = gc_result_mask(gc_reql)
                  val res_arr = MLWorks.Internal.Array.array(num_gc_values,null_value)
              in
		ignore(internal_get_values_ (disp,gc,mask,res_arr));
		make_gc_values_list(mask,res_arr)
              end
        end

      structure Draw =
        struct
          datatype coord_mode = ORIGIN | PREVIOUS
          datatype shape = COMPLEX | NONCONVEX | CONVEX
          val point : display * drawable * gc * int * int -> unit = env "x draw point"
          val points : display * drawable * gc * (int * int) list * coord_mode -> unit = env "x draw points"
          val line : display * drawable * gc * int * int * int * int -> unit = env "x draw line"
          val lines : display * drawable * gc * (int * int) list * coord_mode -> unit = env "x draw lines"
          val segments : display * drawable * gc * (int * int * int * int) list -> unit = env "x draw segments"
          val fillPolygon : display * drawable * gc * (int * int) list * shape * coord_mode -> unit = env "x fill polygon"
          val rectangle : display * drawable * gc * int * int * int * int -> unit = env "x draw rectangle"
          val fillRectangle : display * drawable * gc * int * int * int * int -> unit = env "x fill rectangle"
          val rectangles : display * drawable * gc * (int * int * int * int) list -> unit = env "x draw rectangles"
          val fillRectangles : display * drawable * gc * (int * int * int * int) list -> unit = env "x fill rectangles"
          val arc : display * drawable * gc * int * int * int * int * int * int -> unit = env "x draw arc"
          val fillArc : display * drawable * gc * int * int * int * int * int * int -> unit = env "x fill arc"
          val arcs : display * drawable * gc * (int * int * int * int * int * int) list -> unit = env "x draw arcs"
          val fillArcs : display * drawable * gc * (int * int * int * int * int * int) list -> unit = env "x fill arcs"
          val string : display * drawable * gc * int * int * string -> unit = env "x draw string"
          val imageString : display * drawable * gc * int * int * string -> unit = env "x draw image string"
          val clearArea : display * drawable * int * int * int * int * bool -> unit = env "x clear area"
          val copyArea : display * drawable * drawable * gc * int * int * int * int * int * int -> unit = env "x copy area"
          val copyPlane : display * drawable * drawable * gc * int * int * int * int * int * int * int -> unit = env "x copy plane"
        end

      structure Colormap =
        struct
          val default : screen -> colormap = env "x default colormap"
          val allocColor_ : display * colormap * (int * int * int) -> pixel = env "x alloc color"
          val max = (Bits.lshift (1,16))-1
          val rmax = real max
          fun convert r =
            if r < real 0 then 0
            else if r >= real 1 then max
            else floor (r * rmax)
          fun allocColor (display : display,colormap : colormap,(r,g,b)) =
            allocColor_ (display,colormap,(convert r, convert g, convert b))
          val allocNamedColor : display * colormap * string -> pixel = env "x alloc named color"
          val allocColorCells : display * colormap * bool * int * int -> (pixel MLWorks.Internal.Array.array * pixel MLWorks.Internal.Array.array) =
            env "x alloc color cells"
          val internal_storeColor : display * colormap * pixel * (int * int * int) -> unit =
            env "x store color"
          fun storeColor (display, colormap,pixel,(r,g,b)) =
            internal_storeColor (display, colormap, pixel, (convert r, convert g, convert b))
          val storeNamedColor : display * colormap * pixel * string -> unit =
            env "x store named color"
        val freeColors : display * colormap * (pixel MLWorks.Internal.Array.array) * int -> unit = env "x free colors"
        end

      structure List =
        struct
          val addItem : widget * compound_string * int -> unit = env "x list add item"
          val addItemUnselected : widget * compound_string * int -> unit = env "x list add item unselected"
          val addItems : widget * compound_string list * int -> unit = env "x list add items"
          val deleteAllItems : widget -> unit = env "x list delete all items"
          val deleteItem : widget * compound_string -> unit = env "x list delete item"
          val deleteItems : widget * compound_string list -> unit = env "x list delete items"
          val deleteItemsPos : widget * int * int -> unit = env "x list delete items pos"
          val deletePos : widget * int -> unit = env "x list delete pos"

	  val selectPos : widget * int * bool -> unit = env "x list select pos"
          val getSelectedPos : widget -> int MLWorks.Internal.Vector.vector = env "x list get selected pos"
          val setBottomPos : widget * int -> unit = env "x list set bottom pos"
          val setPos : widget * int -> unit = env "x list set pos"
        end

      structure Scale =
        struct
          val getValue : widget -> int = env "x scale get value"
          val setValue : widget * int -> unit = env "x scale set value"
        end

      structure ScrollBar =
        struct
          val getValues : widget -> int * int * int * int = env "x scrollbar get values"
          val setValues : widget * int * int * int * int * bool -> unit = env "x scrollbar set values"
        end

      structure ScrolledWindow =
        struct
          val setAreas : widget * widget * widget * widget -> unit = env "x scrolled window set areas"
        end

      val initialize_			= env "x initialize"
      val main_loop_			= env "x main loop"
      val do_input_ : exn -> bool       = env "x do input"
        
      exception NotInitialized
      exception XSystemError of string

      local 
	val x_exns_initialised = env "x exns initialised"
	val XSystemErrorExn = env "exception X"
      in 
        val _ =
	  if !x_exns_initialised then
 	    MLWorks.Internal.Value.update_exn (XSystemError "", XSystemErrorExn)
	  else
	    (x_exns_initialised := true;
	     XSystemErrorExn := XSystemError "")
      end

      fun initialize (name: string,
                      class: string,
                      arguments: (argument_name * argument_value) list
                      ): widget =
        initialize_ (name, class, pairToRepList arguments)

      val checkMLWorksResources: unit -> bool = env "x mlw check resources"
      (* check that the app-defaults file has been found *)

      fun mainLoop (): unit = main_loop_ (NotInitialized)

      fun doInput () : unit = 
        if do_input_ (NotInitialized)
          then ()
        else raise SubLoopTerminated

      val sync : display * bool -> unit = env "x sync"
      val synchronize : display * bool -> unit = env "x synchronize"

    end

  end
