(*
 * $Log: _capi.sml,v $
 * Revision 1.129  1999/03/15 23:25:28  mitchell
 * [Bug #190512]
 * Modify handling of splash advert so that it has to be explicitly dismissed
 *
 * Revision 1.128  1999/03/09  10:39:07  mitchell
 * [Bug #190512]
 * Add advert splash screen
 *
 * Revision 1.127  1998/08/20  16:08:43  jont
 * [Bug #70157]
 * Fix compiler warning
 *
 * Revision 1.126  1998/08/14  16:13:35  mitchell
 * [Bug #30479]
 * Fix up debugging information in set_insertion_position
 *
 * Revision 1.125  1998/07/30  13:07:12  johnh
 * [Bug #30455]
 * Add activateapp message handler for podium window.
 *
 * Revision 1.124  1998/07/23  14:41:35  johnh
 * [Bug #30451]
 * Implement SetBkMode and GetBkMode and fix timer text on splash screen.
 *
 * Revision 1.123  1998/07/17  15:00:10  jkbrook
 * [Bug #30436]
 * PERSONAL replaces FREE and STUDENT editions
 *
 * Revision 1.122  1998/07/15  11:26:02  jkbrook
 * [Bug #30435]
 * Remove license-prompting code
 *
 * Revision 1.121  1998/07/14  09:33:23  johnh
 * [Bug #50056]
 * Remove dummy window and live with windows obscuring toolbar.
 *
 * Revision 1.120  1998/07/09  12:35:00  johnh
 * [Bug #30400]
 * Fix returning to and from tty mode.
 *
 * Revision 1.119  1998/07/02  14:56:48  johnh
 * [Bug #30431]
 * Extend Capi to allow setting of window attributes.
 *
 * Revision 1.118  1998/06/24  14:29:09  johnh
 * [Bug #30433]
 * Use new splash screen - need to reposition time out label.
 *
 * Revision 1.117  1998/06/24  13:24:25  johnh
 * [Bug #30411]
 * Fix problems checking edition and setting time out of spalsh screen.
 *
 * Revision 1.116  1998/06/11  18:23:31  jkbrook
 * [Bug #30411]
 * Include Free edition
 *
 * Revision 1.115  1998/06/11  15:06:32  johnh
 * [Bug #30411]
 * Free edition splash screen changes.
 *
 * Revision 1.114  1998/06/01  10:34:52  johnh
 * [Bug #30369]
 * Make file selection dialog allow multiple selection.
 *
 * Revision 1.113  1998/04/01  15:05:16  jont
 * [Bug #70086]
 * WINDOWS becomes WINDOWS_GUI, Windows becomesd WindowsGui
 *
 * Revision 1.112  1998/03/31  17:52:30  johnh
 * [Bug #30346]
 * Add Capi.getNextWindowPos().
 *
 * Revision 1.111  1998/03/26  13:14:34  johnh
 * [Bug #50035]
 * Keyboard accelerators now platform specific.
 *
 * Revision 1.110  1998/02/20  11:38:07  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.109  1998/02/18  17:09:18  jont
 * [Bug #70070]
 * Remove MLWorks.IO.terminal_out in favour of Terminal.output
 *
 * Revision 1.108  1998/02/17  16:43:56  johnh
 * [Bug #30344]
 * Allow windows to retain size and position.
 *
 * Revision 1.107  1998/01/27  15:28:54  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.106  1997/11/06  13:00:00  johnh
 * [Bug #30125]
 * Move implementation of send_message to Menus.
 *
 * Revision 1.105  1997/10/30  09:40:34  johnh
 * [Bug #30187]
 * Fix horizontal scrolling on Win95.
 *
 * Revision 1.104  1997/10/16  14:13:40  johnh
 * [Bug #30193]
 * Fix size of maximised podium for display on NT 3.51.
 *
 * Revision 1.103  1997/10/09  15:35:56  johnh
 * [Bug #30193]
 * Resize the maximised podium.
 *
 * Revision 1.102  1997/10/06  10:36:44  johnh
 * [Bug #30137]
 * Add make_messages_popup.
 *
 * Revision 1.101  1997/09/19  14:29:29  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.100.2.6  1998/01/09  11:10:06  johnh
 * [Bug #30071]
 * Add Capi.Callback.ValueChange
 *
 * Revision 1.100.2.5  1998/01/06  15:55:58  johnh
 * [Bug #30071]
 * Add command handler for an activate callback (for use in project properties about info).
 *
 * Revision 1.100.2.4  1997/12/11  14:49:30  johnh
 * [Bug #30071]
 * Change height of text boxes to cope with large fonts on NT 3.51.
 *
 * Revision 1.100.2.3  1997/11/24  15:24:48  johnh
 * [Bug #30071]
 * Generalise Windows.openFileDialog to take a description of Filter.
 *
 * Revision 1.100.2.2  1997/09/12  14:48:42  johnh
 * [Bug #30071]
 * Redesign Compilation Manager -> Project Workspace.
 *
 * Revision 1.100  1997/09/05  15:00:35  johnh
 * [Bug #30241]
 * Implementing proper Find Dialog.
 *
 * Revision 1.99  1997/08/06  12:46:57  brucem
 * [Bug #30224]
 * Add function makeYesNo.
 *
 * Revision 1.98  1997/07/23  14:09:51  johnh
 * [Bug #30182]
 * Add delete handler.
 *
 * Revision 1.97  1997/07/18  13:45:47  johnh
 * [Bug #20074]
 * Improve license dialog.
 *
 * Revision 1.96  1997/06/18  08:28:05  johnh
 * [Bug #30181]
 * Tidy interrupt button code.
 *
 * Revision 1.95  1997/06/17  16:20:04  johnh
 * [Bug #30179]
 * Adding dummy function used in Motif.
 *
 * Revision 1.94  1997/06/13  10:50:23  johnh
 * [Bug #30175]
 * Add all windows to dynamic menu, except top level tools.
 *
 * Revision 1.93  1997/05/20  15:57:33  johnh
 * Removing interrupt button and putting it on the toolbar.
 *
 * Revision 1.92  1997/05/16  15:36:29  johnh
 * Implementing single menu bar on Windows.
 *
 * Revision 1.91  1997/03/26  09:32:51  johnh
 * [Bug #1992]
 * Removed the window (or context) menu to prevent user from using
 * the cut and paste operations from this menu in wrong situations.
 *
 * Revision 1.90  1997/03/19  11:18:12  johnh
 * [Bug #1981]
 * Moved list_select window to be always inside the desktop window.
 *
 * Revision 1.89  1997/03/17  14:26:20  johnh
 * [Bug #1954]
 * Added set_min_window_size.
 *
 * Revision 1.88  1996/12/03  20:28:54  daveb
 * Replaced the hacky mswindows simulation of unmap callbacks, which was
 * causing erroneous behaviour (Dialog boxes use the WM_USER0 and WM_USER1
 * message values!).  The debugger_window and error_browser now call
 * set_close_callback instead.
 *
 * Revision 1.87  1996/12/03  19:02:41  daveb
 * Increased toplevel_width again; the previous increase wasn't enough for
 * the Compilation Manager.
 *
 * Revision 1.86  1996/12/03  17:41:14  daveb
 * Changed the labels of the license dialog to match those on Unix/in the
 * documentation.
 *
 * Revision 1.85  1996/11/22  12:12:42  daveb
 * Made the C getBitmap function reveal the window itself, and return a boolean
 * to indicate success or failure.
 *
 * Revision 1.84  1996/11/22  11:38:27  stephenb
 * [Bug #1461]
 * return_max: change to be tail recursive.  This is important
 * because this code is run during a stack overflow handler
 * to display the frames.
 *
 * Revision 1.83  1996/11/21  13:00:13  jont
 * [Bug #1799]
 * Modify check_insertion to truncate string if it would not fit at all
 * Reduce limits on edit control sizes
 *
 * Revision 1.82  1996/11/20  17:24:10  johnh
 * Removed the title bar from the splash screen.
 *
 * Revision 1.81  1996/11/20  11:37:32  daveb
 * Extended default width to allow for Help menu.
 *
 * Revision 1.80  1996/11/20  10:29:47  johnh
 * Rewrote license dialog so that tabbing was allowed within it.
 *
 * Revision 1.79  1996/11/18  13:19:40  daveb
 * Added splash screen.
 *
 * Revision 1.78  1996/11/12  11:45:13  daveb
 * Added license_prompt and license_complain.
 *
 * Revision 1.77  1996/11/06  11:18:09  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.76  1996/11/01  14:55:31  johnh
 * Enabling close from control box on top left of window.
 *
 * Revision 1.75  1996/10/31  10:55:48  johnh
 * Add interrupt button to Windows.
 *
 * Revision 1.74  1996/10/30  20:13:39  io
 * [Bug #1614]
 * sorting out a typo
 *
 * Revision 1.73  1996/10/30  20:02:35  io
 * moving String from toplevel
 *
 * Revision 1.72  1996/10/02  11:00:35  johnh
 * [Bug #1560]
 * Enable scrolling on edit controls.
 *
 * Revision 1.70  1996/09/23  14:43:05  matthew
 * Adding interrupt button feature
 *
 * Revision 1.69  1996/09/19  13:03:48  johnh
 * [Bug #1583]
 * passing has_controlling_tty to exit_mlworks instead of passing false.
 *
 * Revision 1.66  1996/08/07  12:24:29  daveb
 * [Bug #1517]
 * Added handler for WM_SYSCHAR to handle Alt-<key> combinations.
 *
 * Revision 1.65  1996/08/06  15:54:52  daveb
 * [Bug #1517]
 * Changed definition of Text.end_line to return the current position if it
 * is already at the end of a line.
 *
 * Revision 1.64  1996/08/01  15:12:47  daveb
 * Corrected definition of terminator.
 *
 * Revision 1.63  1996/07/30  14:38:31  jont
 * Provide a system dependent line terminator
 *
 * Revision 1.62  1996/07/29  09:29:18  daveb
 * [Bug #1478]
 * Made WM_CLOSE of top level tools and popups mimic the Motif behaviour.
 * Top level tools ignore it, and popups unmap themselves, sending a WM_USER0
 * message to simulate an Unmap callback.  This prevents users from  deleting
 * stack browsers or their parent windows in the middle of an evaluation.
 *
 * Revision 1.61  1996/07/09  15:48:08  daveb
 * [Bug #1260]
 * Changed the Capi layout datatype so that the PANED constructor takes the
 * layout info for its sub-panes.  This enables the Windows layout code to
 * calculate the minimum size of each window.
 *
 * Revision 1.60  1996/07/04  09:14:24  daveb
 * Bug 1378: The Windows menu needs to be cleared when entering or leaving the
 * GUI.  I've changed initialize_application to clear the list of main windows.
 *
 * Revision 1.59  1996/06/25  15:32:11  daveb
 * Added handlers around all calls to Capi.getStockObject.
 *
 * Revision 1.58  1996/06/18  14:12:34  daveb
 * Moved exception WindowSystemError to windows.sml.
 * Set font of text widgets to be ANSI_FIXED_FONT.
 * Set font of labels, etc. to be DEFAULT_GUI_FONT when defined, and ANSI_VAR_FONT
 * otherwise.
 *
 * Revision 1.57  1996/06/13  14:05:25  daveb
 * Made make_main_window ignore the parent argument, so that all top level
 * windows are independent.  This means that the podium may be brought to the
 * front by the user.  Added code to intercept minimize and restore actions,
 * so that minimizing the podium minimizes all other top-level windows.
 *
 * Revision 1.56  1996/05/31  16:16:40  daveb
 * Bug 1074: Capi.list_select now takes a function to be called on any key
 * press handled by the list widget itself.  In the listener, this pops the
 * completions widget down as if the key had been typed at the listener.
 *
 * Revision 1.55  1996/05/28  16:12:09  jont
 * Distinguish image saving from file saving and call appropriate rts function
 *
 * Revision 1.54  1996/05/28  15:53:36  matthew
 * Adding reset function
 *
 * Revision 1.53  1996/05/16  17:00:25  jont
 * Ensure WindowSystemError is defined before use
 *
 * Revision 1.52  1996/05/16  13:07:43  matthew
 * Set runtime exception
 *
 * Revision 1.51  1996/05/16  09:29:31  matthew
 * Adding something for set_highlight
 *
 * Revision 1.50  1996/05/15  12:35:54  matthew
 * set_pos sends a LBN_SELCHANGE message
 *
 * Revision 1.49  1996/05/07  17:05:20  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.48  1996/05/01  12:23:46  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.47  1996/04/30  13:24:40  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.46  1996/04/18  10:11:38  matthew
 * Adding start/stop graphics functions
 *
 * Revision 1.45  1996/04/16  16:19:14  matthew
 * Fixing problem with resizing
 *
 * Revision 1.44  1996/04/16  13:03:51  matthew
 * Adding more scrollbar functionality to graphics ports
 *
 * Revision 1.43  1996/04/16  12:17:34  matthew
 * Fixing set_message_widget function
 *
 * Revision 1.42  1996/04/03  15:58:00  matthew
 * Fixing some problems
 *
 * Revision 1.41  1996/03/14  11:41:09  matthew
 * Fixing a newline in a message.
 *
 * Revision 1.40  1996/03/07  16:20:19  matthew
 * Changes to Windows structure
 *
 * Revision 1.39  1996/03/01  11:21:02  matthew
 * Changes to Windows structure
 *
 * Revision 1.38  1996/02/28  17:17:33  matthew
 * Changes to Windows signature
 *
 * Revision 1.37  1996/02/09  11:39:05  daveb
 * Changed return type of make_scrolllist to a record, with an extra element
 * add_items.  Replaced set_bottom_pos with set_pos (which can be implemented
 * on windows).  Added add_items to the List structure.
 *
 * Revision 1.36  1996/02/01  14:18:24  matthew
 * Changing type of [set/get]_window_long
 *
 * Revision 1.35  1996/01/31  14:15:22  matthew
 * Changing representation of Widgets
 *
 * Revision 1.34  1996/01/25  16:05:31  matthew
 * Changing default height of graph panes
 *
 * Revision 1.33  1996/01/25  12:29:26  matthew
 * Trying to fix with_highlighting
 *
 * Revision 1.32  1996/01/17  10:23:44  matthew
 * Send WM_LIMITTEXT to edit windows.
 *
 * Revision 1.31  1996/01/12  16:45:16  matthew
 * Adding insertion checks for the benefit of Windows
 *
 * Revision 1.30  1996/01/12  10:29:43  daveb
 * Removed use of FileDialog structure, incorporating the definitions directly
 * in this file instead.
 *
 * Revision 1.29  1996/01/09  14:19:45  matthew
 * Moved list_select in from _gui_utils
 *
 * Revision 1.28  1996/01/08  15:37:28  matthew
 * Adding "exit" command for all windows -- used for accelerators.
 *
 * Revision 1.27  1996/01/04  15:32:52  matthew
 * Fixing bungle with previous fix
 *
 * Revision 1.26  1996/01/04  14:22:40  matthew
 * Fixing some bugs
 *
 * Revision 1.25  1995/12/20  15:13:11  matthew
 * Adding color functions
 *
 * Revision 1.24  1995/12/14  15:33:47  matthew
 * Changing message handling
 *
 * Revision 1.23  1995/12/13  15:08:33  daveb
 * FileDialog now includes a datatype that also needs to be included here.
 *
 * Revision 1.22  1995/12/07  16:41:21  matthew
 * Adding extra text functions
 *
 * Revision 1.21  1995/12/06  16:57:03  matthew
 * Adding clipboard functionality
 *
 * Revision 1.20  1995/11/23  12:37:36  matthew
 * Fixing slight bungle in make_scrolllist
 *
 * Revision 1.19  1995/11/21  14:44:04  matthew
 * More stuff
 *
 * Revision 1.18  1995/11/17  11:17:27  matthew
 * More stuff on command handlers
 *
 * Revision 1.16  1995/11/15  15:18:27  matthew
 * Adding (dummy) get_main_windows
 *
 * Revision 1.15  1995/11/14  13:58:22  matthew
 * Extending for graphics
 *
 * Revision 1.14  1995/10/10  12:20:30  nickb
 * Add Resize callback.
 *
 * Revision 1.13  1995/10/08  22:40:43  brianm
 * Adding mod. to make_graphics.
 *
 * Revision 1.12  1995/10/02  10:14:54  brianm
 * Adding dummy `with_graphics_port' functions and associated functions.
 *
 * Revision 1.11  1995/09/22  13:56:10  daveb
 * Added dummy Capi.Text.set_highlight function.
 *
 * Revision 1.10  1995/09/21  15:36:07  nickb
 * Make scroll bars on graphics ports optional.
 *
 * Revision 1.9  1995/09/19  10:39:58  brianm
 * Updating by adding Capi Point/Region datatypes.
 *
 * Revision 1.8  1995/09/11  13:30:07  matthew
 * Changing top level window initialization
 *
 * Revision 1.7  1995/09/05  10:49:48  matthew
 * Changing use of word_to_int
 *
 * Revision 1.6  1995/08/31  10:42:40  matthew
 * Improving event handling
 *
 * Revision 1.5  1995/08/25  10:27:36  matthew
 * More stuff
 *
 * Revision 1.4  1995/08/15  16:24:23  matthew
 * More work
 *
 * Revision 1.3  1995/08/15  14:40:19  matthew
 * More stuff
 *
 * Revision 1.2  1995/08/11  13:58:23  matthew
 * Making it all work
 *
 * Revision 1.1  1995/08/03  12:51:30  matthew
 * new unit
 * MS Windows GUI
 *
 *)

require "^.utils.__terminal";
require "^.basis.__list";
require "^.basis.__string";
require "../basis/__int";

require "../basis/word";
require "../utils/lists";
require "../main/version";
require "../gui/menus";
require "windows_gui";
require "capitypes";
require "labelstrings";

require "../gui/capi";

functor Capi (structure Lists : LISTS
              structure WindowsGui : WINDOWS_GUI
              structure LabelStrings : LABELSTRINGS
              structure CapiTypes : CAPITYPES
              structure Menus : MENUS
	      structure Word32 : WORD
	      structure Version : VERSION

              sharing type LabelStrings.AcceleratorFlag = WindowsGui.accelerator_flag
	      sharing type Menus.Widget = CapiTypes.Widget
              sharing type CapiTypes.Hwnd = WindowsGui.hwnd
              sharing type WindowsGui.word = LabelStrings.word = Word32.word
                ): CAPI =
struct
  val do_debug = false
  fun debug s = if do_debug then Terminal.output (s() ^ "\n") else ()
  fun ddebug s = Terminal.output(s() ^ "\n")

  datatype Point = POINT of { x : int, y : int }

  datatype Region = REGION of { x : int, y :int, width : int, height :int }

  type Widget = CapiTypes.Widget
  type Font = unit

  fun env s = MLWorks.Internal.Value.cast (MLWorks.Internal.Runtime.environment s)

  (* This exn can be raised when an inner event loop is terminated *)
  exception SubLoopTerminated
  exception WindowSystemError = WindowsGui.WindowSystemError

  exception Unimplemented of string
  fun N n = Int.toString n
  fun W w = "<word>"
  fun dummy s = debug (fn _ => s ^ " unimplemented")
  fun unimplemented s = (dummy s; raise Unimplemented s)

  fun max (x:int,y:int) = if x > y then x else y

(* evaluating: boolean reference set by listener and compilation manager 
 * and read by podium so that user cannot exit during compilation or 
 * computation - must interrupt it first. 
 *)
  val evaluating = ref false;

  (* This could be rather more efficient -- in particular, only do this if
   the line does contain newlines *)
    fun munge_string s =
      let
        fun munge ([],acc) = implode (rev acc)
          | munge (#"\013" :: #"\010" :: rest,acc) = munge (rest, #"\010" :: #"\013" :: acc)
          | munge (#"\n" ::rest,acc) = munge (rest, #"\010" :: #"\013" :: acc)
          | munge (c::rest,acc) = munge (rest,c::acc)
      in
        munge (explode s,[])
      end

(*
 Someone should do this efficiently! 
  fun strip_string_controls s =
    let
      fun aux c =
          if c < #" " then ""
          else c
    in
      implode (map aux (explode s))
    end
*)

  fun strip_string_controls (s:string):string =
    implode (List.filter (fn c=>not(c < #" ")) (explode s))


  (* The list of main windows provides the information for 
   * the Tools menu.  
   *)
  val main_windows : (CapiTypes.Widget * string) list ref = ref []

  fun push (a,r) = r := a :: !r
  
  fun delete (a,[]) = []
    | delete (a,((item as (a', _)) :: rest)) = 
      if a = a' then delete (a,rest) else item::delete (a,rest)

  fun add_main_window (w,title) = push ((w, title), main_windows)
  fun remove_main_window w = main_windows := delete (w,!main_windows)

  fun get_main_windows () = (!main_windows)

  (* List of text handlers *)
  val text_handlers = ref []

  fun restart () =
    (main_windows := [];
     text_handlers := [])

  datatype WidgetAttribute = 
      PanedMargin of bool
    | Position of    int * int
    | Size of        int * int
    | ReadOnly of    bool


  datatype WidgetClass = Frame | Graphics | Label | Button | Text | RowColumn | Paned | Form

  fun convert_class class =
    case class of
      Label => ("STATIC",[WindowsGui.SS_LEFT])
    | Button => ("BUTTON",[WindowsGui.BS_PUSHBUTTON])
    | Text => ("EDIT",[WindowsGui.WS_BORDER])
    | _ => ("Frame",[]) (* A class of my own devising *)

  val sendMessageNoResult = ignore o WindowsGui.sendMessage;

  fun set_text (window,s) =
    let
      val string_word = WindowsGui.makeCString (munge_string s)
    in
      sendMessageNoResult (CapiTypes.get_real window,WindowsGui.WM_SETTEXT,
                           WindowsGui.WPARAM (WindowsGui.nullWord),
                           WindowsGui.LPARAM string_word);
      WindowsGui.free string_word
    end

  (* Needed on Motif so that menus on main_popups automatically created can be removed *)
  fun remove_menu widget = ()

  fun reveal window =
    (WindowsGui.showWindow (window,WindowsGui.SW_SHOWNORMAL);
     WindowsGui.updateWindow window)

  fun hide window =
    WindowsGui.showWindow (CapiTypes.get_real window,WindowsGui.SW_HIDE)

  datatype window_ex_style = 
    WS_EX_DLGMODALFRAME |
    WS_EX_STATICEDGE |
    WS_EX_WINDOWEDGE

  fun createWindowEx (details : 
    {ex_styles: window_ex_style list,
     class: string,
     name: string,
     x: int,
     y: int,
     width : int,
     height : int,
     parent: WindowsGui.hwnd,
     menu : WindowsGui.word,
     styles : WindowsGui.window_style list}) : WindowsGui.hwnd = 
       (MLWorks.Internal.Runtime.environment "win32 create window ex") details

  fun create_revealed args =
    let
      val window = WindowsGui.createWindow args
    in
      reveal window;
      window
    end

  fun convert_name (Label,name) = LabelStrings.get_label name
    | convert_name (Button,name) = LabelStrings.get_label name
    | convert_name (_,name) = LabelStrings.get_title name
  val default_width = 720
  val toplevel_width = default_width
  val toplevel_height = 100
  val graphics_height = 200

  val next_window = ref (0,0)

  fun class_height class =
    case class of
      Frame => 120
    | Graphics => 120
    | Label => 20
    | Button => 20
    | Text => 26
    | RowColumn => 30
    | Paned => 120
    | Form => 120

  structure Event = 
    struct
      type Modifier = int
      val meta_modifier = 0
      datatype Button = LEFT | RIGHT | OTHER
    end

  (* WINDOW PROCEDURES *)

  (* currently alt chars just make a beep *)
  fun despatch_text (window, char, alt_on) =
    let
      fun scan [] = false
        | scan ((window',handler)::rest) =
          if window = CapiTypes.get_real window'
            then handler (char,if alt_on then [Event.meta_modifier] else [])
          else scan rest
    in
      scan (!text_handlers)
    end

  fun set_text_font window =
    let
      val WindowsGui.OBJECT text_font =
	WindowsGui.getStockObject (WindowsGui.ANSI_VAR_FONT)   (* WindowsGui.ANSI_FIXED_FONT) *)
    in
      sendMessageNoResult
          (CapiTypes.get_real window,
           WindowsGui.WM_SETFONT,
           WindowsGui.WPARAM text_font,
           WindowsGui.LPARAM (WindowsGui.intToWord 1))
    end
    handle WindowsGui.WindowSystemError _ => ()

  fun set_gui_font window =
    let
      val WindowsGui.OBJECT gui_font =
	WindowsGui.getStockObject (WindowsGui.DEFAULT_GUI_FONT)
	handle
	  WindowsGui.WindowSystemError _ => 
	    WindowsGui.getStockObject (WindowsGui.ANSI_VAR_FONT)
    in
      sendMessageNoResult
          (CapiTypes.get_real window,
           WindowsGui.WM_SETFONT,
           WindowsGui.WPARAM gui_font,
           WindowsGui.LPARAM (WindowsGui.intToWord 1))
    end
    handle WindowsGui.WindowSystemError _ => ()

  fun class_postaction (window,class) =
    case class of
      Text =>
	(set_text_font window;
         set_text (window, ""))
    | Label => set_gui_font window
    | Button => set_gui_font window
    | _ => ()

  fun getStylesFromAttributes [] = []
    | getStylesFromAttributes ((ReadOnly true)::rest) = 
	WindowsGui.ES_READONLY :: getStylesFromAttributes(rest)
    | getStylesFromAttributes (another::rest) =
	getStylesFromAttributes(rest)

  fun getSize ((Size (w,h))::rest) = SOME (w,h)
    | getSize (notsize::rest) = getSize rest
    | getSize [] = NONE

  fun make_widget (name,class,parent,attributes) = 
    let
      val (class_name,styles) = convert_class class
      val class_styles = case class of
	     Text => [WindowsGui.WS_BORDER,
		      WindowsGui.ES_MULTILINE,
		      WindowsGui.ES_AUTOHSCROLL]
	   | _ => []
      val (width, height) = 
	getOpt (getSize attributes, (default_width, class_height class))
      val window =
        WindowsGui.createWindow {class = class_name,
                              name = convert_name (class,name),
                              width = width,
                              height = height,
                              parent = CapiTypes.get_real parent,
                              menu = WindowsGui.nullWord,
                              styles = [WindowsGui.WS_CHILD] @ 
				       class_styles @
				       styles @
				       getStylesFromAttributes (attributes)}
      val widget = CapiTypes.REAL (window,parent)
    in
      class_postaction (widget,class);
      widget
    end

  fun make_managed_widget (name,class,parent,attributes) = 
    let
      val widget = make_widget (name, class, parent, attributes)
    in
      reveal (CapiTypes.get_real widget);
      widget
    end

  (* Utility functions for creating the main window of a tool *)

  (* Shouldn't be necessary as this should be done in initialize_application? *)
  (* But this is also used for (some) popups *)

  fun make_context_label parent =
    let
      val window = 
        WindowsGui.createWindow
        {class = "STATIC",
         name = "contextLabel",
         height = 20,
         width = default_width,
         parent = CapiTypes.get_real parent,
         menu = WindowsGui.nullWord,
         styles = [WindowsGui.WS_CHILD,WindowsGui.SS_CENTER]}
    in
      reveal window;
      CapiTypes.REAL (window,parent)
    end

  fun make_main_subwindows (parent,has_context_label) = 
    let
      val label_window =
        if has_context_label
          then SOME (make_context_label parent)
        else NONE
    in
      (parent,parent,label_window)
    end

  fun make_subwindow parent = parent

(* The 'visible' argument here is used to distinguish between times when the 
 * window is created but hidden and times when it is shown after being hidden.
 * An example is the debugger window which is created at the same time as the 
 * podium and without the 'visible' argument would become visible with the podium
 * instead of later when needed. *)
  fun min_child (owner, window, visible) = 
    WindowsGui.addMessageHandler(owner, WindowsGui.WM_SHOWWINDOW, 
      fn (WindowsGui.WPARAM w, WindowsGui.LPARAM l) => 
	(if (!visible) then 
	   if (w = WindowsGui.nullWord) then 
	     WindowsGui.showWindow(window, WindowsGui.SW_HIDE)
           else 
	     WindowsGui.showWindow(window, WindowsGui.SW_SHOW) 
	 else ();
	 NONE))

  fun getNextWindowPos () = 
    let 
      val (curX, curY) = !next_window
      val inc = 30
    in
      if (curX < (100 + inc * 6)) then
	next_window := (curX + inc, curY + inc)
      else
	next_window := (100, curY - inc * 6);
      (curX, curY)
    end

  (* This should eventually return a MainWindow *)
  fun initialize_application (name, title, has_controlling_tty) = 
    let
      val window = WindowsGui.mainInit ()
      val widget = CapiTypes.REAL (window,CapiTypes.NONE)

      val height = ref 0
      (* This function gets the desired height of a maximised podium so that the 
       * toolbar is only just visible on both NT3.51 and NT4.0 
       *)
      fun get_height window = 
	let
	  val _ = WindowsGui.setWindowPos (window, {x=0, y=0, height=200, width = 1000})
	  val (WindowsGui.RECT {bottom=c_height, ...}) = WindowsGui.getClientRect window
	in
	  height := 200 - (c_height - 28)
	end

      (* Motivation for needing this sizing reference:  The function get_height which 
       * is called by getminmax below, calls WindowsGui.setWindowPos which, as a side 
       * effect causes getminmax to be called.  There is a circular loop here in the 
       * function calls, and to ensure that (a) the new height can be calculated and 
       * set, and (b) that no infinite loop occurs, the sizing reference is used as 
       * below, so that, in effect, getminmax is not called from within itself.
       *)
      val sizing = ref false
      (* Sets the size when the podium is maximized *)
      fun getminmax window (_, WindowsGui.LPARAM addr) = 
	let
	  val (_, _, _, maxtrack) = WindowsGui.getMinMaxInfo addr
	  val desk = WindowsGui.getDesktopWindow()
	  val (WindowsGui.RECT {right=r, left=l, ...}) = WindowsGui.getWindowRect desk
	  fun p (xc, yc) = WindowsGui.POINT {x=xc, y=yc}
	in 
	  (* p(r+6, !height) sets the window size when it is maximised.
	   * The p(~4,~4) is the position of the window so that the 
	   * border is not visible when the window is maximised and the remaining
	   * arguments set the minimum and maximum tracking size of the window. *)
	  if (!height) = 0 then
	    if (!sizing) then () else 
	      (sizing := true;
	       get_height window;
	       ignore(WindowsGui.setMinMaxInfo (addr, p(r+6, !height), p(~4,~4), p(0,0), maxtrack));
	       sizing := false)
	  else 
	    (ignore(WindowsGui.setMinMaxInfo (addr, p(r+6, !height), p(~4,~4), p(0,0), maxtrack));
	     ());
	  
	  NONE
	end

    in
      next_window := (50, (!height) + 50);

      restart ();
      WindowsGui.addMessageHandler (window,WindowsGui.WM_DESTROY,
                                   fn _ => (WindowsGui.postQuitMessage 0;
                                            NONE));
      (* Ensure that close has the same effect as selecting the ML menu item
         Return SOME ... to indicate the message has been handled -- otherwise
         we also get the default action, which destroys the window
       *)
      WindowsGui.addMessageHandler (window,WindowsGui.WM_CLOSE,
              fn _ => (if not (!evaluating) then
			  Menus.exit_dialog (widget,widget,has_controlling_tty)
			else ();
                        SOME (WindowsGui.nullWord)));

      WindowsGui.addMessageHandler (window, WindowsGui.WM_GETMINMAXINFO, getminmax window);
      WindowsGui.addMessageHandler (window, WindowsGui.WM_ACTIVATEAPP, 
				    fn _ => (ignore(WindowsGui.setFocus window); NONE));

      (* Add an all-window command handler for "exit" action *)
      WindowsGui.addCommandHandler (WindowsGui.nullWindow,
                                   LabelStrings.get_action "exit",
              fn _ => (if not (!evaluating) then
			Menus.exit_dialog (widget,widget,has_controlling_tty)
		       else ()  ));
      WindowsGui.setAcceleratorTable (WindowsGui.createAcceleratorTable (LabelStrings.accelerators));

      widget
    end

  (* For the moment, the shell is the same as the menubar window *)
  fun make_main_window {name, title, parent, contextLabel, winMenu, pos:int * int} = 
    let
      val window = 
        createWindowEx
        {ex_styles = [],
	 class = "Toplevel",
         name = LabelStrings.get_title name,
	 x = #1(pos),
	 y = #2(pos),
         height = toplevel_height,
         width = toplevel_width,
         parent = CapiTypes.get_real parent,
         menu = WindowsGui.nullWord,
         styles = [WindowsGui.WS_OVERLAPPED_WINDOW]}
      val widget = CapiTypes.REAL (window,parent)
      val label_window =
        if contextLabel
          then SOME (make_context_label widget)
        else NONE
    in
      set_text (widget,title);

      (* The windows contained in the tools menu do not need to be added to the 
       * dynamic list of windows, but other windows are created by this function,
       * so a distinction is needed.
       *)
      if winMenu then
	push ((widget, title), main_windows)
      else ();

      WindowsGui.addMessageHandler (window,WindowsGui.WM_DESTROY,
                                   fn _ => (remove_main_window widget;
					    NONE));
      (widget,widget,widget,label_window)
    end

  (* The same as above, but the shell isn't made visible *)
  fun make_main_popup {name, title, parent, contextLabel, visibleRef, pos: int * int} = 
    let
      val window = 
        createWindowEx
        {ex_styles = [],
	 class = "Toplevel",
         name = LabelStrings.get_title name,
	 x = #1(pos),
	 y = #2(pos),
         height = toplevel_height,
         width = toplevel_width,
         parent = CapiTypes.get_real parent, (* This will be the windows owner *)
         menu = WindowsGui.nullWord,
         styles = [WindowsGui.WS_OVERLAPPED_WINDOW]}
      val widget =CapiTypes.REAL (window,parent)
      val label_window =
        if contextLabel
          then SOME (make_context_label widget)
        else NONE
      val _ = WindowsGui.registerPopupWindow (window)
      fun destroy_handler _ =
        (WindowsGui.unregisterPopupWindow window;
         NONE)
    in
      min_child (CapiTypes.get_real parent, window, visibleRef);

      (* If the window is initially hidden (eg. stack browser) then don't 
       * add the window name to the windows menu - this will be done when 
       * is brought up.
       *)
      if (!visibleRef) then   
    	push ((widget, title), main_windows)
      else ();

      WindowsGui.addMessageHandler (window,WindowsGui.WM_DESTROY,destroy_handler);
      set_text (widget,title);
      (widget,widget,widget,label_window)
    end

  fun make_messages_popup (parent, visible) = 
    make_main_popup {name = "messages", 
		     title = "System Messages", 
		     parent = parent, 
		     contextLabel = false, 
		     visibleRef = visible,
		     pos = getNextWindowPos()}

  (* Register this to allow tabbing etc. *)
  fun make_popup_shell (name,parent,attributes,visible) =
    let
      val (width, height) = 
	getOpt(getSize attributes, (toplevel_width, toplevel_height))
      val window =
        WindowsGui.createWindow
        {class = "Toplevel",
         name = LabelStrings.get_title name,
         width = width,
         height = height,
         parent = CapiTypes.get_real parent, (* This will be the windows owner, it should be a top level window *)
         menu = WindowsGui.nullWord,
         styles = [WindowsGui.WS_OVERLAPPED_WINDOW(*,
                   WindowsGui.WS_POPUP,
                   WindowsGui.WS_CAPTION,
                   WindowsGui.WS_BORDER,
                   WindowsGui.WS_SYSMENU*)] @
		  getStylesFromAttributes (attributes)}
      val _ = WindowsGui.registerPopupWindow (window)
      fun destroy_handler _ =
        (WindowsGui.unregisterPopupWindow window;
         NONE)
    in
      min_child (CapiTypes.get_real parent, window, visible);
      WindowsGui.addMessageHandler (window,WindowsGui.WM_DESTROY,destroy_handler);
      CapiTypes.REAL (window,parent)
    end

  fun make_toplevel_shell (name,title,parent,attributes) =
    let
      val (width, height) = 
	getOpt (getSize attributes, (toplevel_width, toplevel_height))
      val window =
        WindowsGui.createWindow
        {class = "Toplevel",
         name = LabelStrings.get_title name,
         width = width,
         height = height,
         parent = WindowsGui.nullWindow,
         menu = WindowsGui.nullWord,
         styles = [WindowsGui.WS_OVERLAPPED_WINDOW] @
		  getStylesFromAttributes (attributes)}
      val widget =CapiTypes.REAL (window,CapiTypes.NONE)
    in
      set_text (widget,title);
      WindowsGui.showWindow (window,WindowsGui.SW_SHOW);
      WindowsGui.updateWindow window;
      widget
    end

  fun text_subclass window =
    let
      val ml_window_proc = WindowsGui.getMlWindowProc()
      val original_window_proc =
        WindowsGui.setWindowLong (window,
                               WindowsGui.GWL_WNDPROC,
                               ml_window_proc)

      fun char_handler (WindowsGui.WPARAM wparam,WindowsGui.LPARAM lparam) =
        if despatch_text
	     (window, String.str(chr (WindowsGui.wordToInt wparam)), false) then
	  SOME (WindowsGui.nullWord)
        else
          NONE

      fun syschar_handler (WindowsGui.WPARAM wparam,WindowsGui.LPARAM lparam) =
        if despatch_text
	     (window, String.str(chr (WindowsGui.wordToInt wparam)), true) then
	  SOME (WindowsGui.nullWord)
        else
          NONE
    in
      WindowsGui.addNewWindow (window,original_window_proc);
      (* Essential for the current mechanism to do this here *)
      (* Yet another thing to improve *)
      WindowsGui.addMessageHandler (window, WindowsGui.WM_CHAR, char_handler);
      WindowsGui.addMessageHandler (window, WindowsGui.WM_SYSCHAR, syschar_handler)
    end

  val scrolled_text_id = WindowsGui.newControlId ()
  fun make_scrolled_text (name,parent,attributes) =
    let
      val (width, height) =
	getOpt (getSize attributes, (default_width, 200))
      val window =
        create_revealed
        {class = "EDIT",
         name = LabelStrings.get_title name,
         width = width,
         height = height,
         parent = CapiTypes.get_real parent,
         menu = scrolled_text_id,
         styles = [WindowsGui.WS_CHILD,
                   WindowsGui.WS_BORDER,
                   WindowsGui.WS_HSCROLL,WindowsGui.WS_VSCROLL,
                   WindowsGui.ES_MULTILINE,
                   WindowsGui.ES_AUTOHSCROLL,WindowsGui.ES_AUTOVSCROLL] @
		  getStylesFromAttributes (attributes)}
      (* What should we do here? *)
      (* The MAXTEXT event is only generated when the output has already failed *)
      (* perhaps we should check for running out of room before we do the output *)
      fun command_handler (hwnd,event) =
        if event = WindowsGui.wordToInt (WindowsGui.messageToWord (WindowsGui.EN_MAXTEXT))
          then Terminal.output("MAXTEXT received\n")
        else ()
      val widget = CapiTypes.REAL (window,parent)

      (* This function implements a fix for a bug on Windows 95 (request #30187).
       * WM_HSCROLL messages with SB_PAGELEFT or SB_PAGERIGHT set do not work
       * on Windows 95, so this function replaces them with WM_HSCROLL messages
       * with SB_THUMBPOSITION set including the calculated required position that
       * the scrollbar should be in.
       *)
      fun scrolling (WindowsGui.WPARAM w, WindowsGui.LPARAM l) = 
	let 
	  val scroll_value = WindowsGui.loword w
	  val sb_left = WindowsGui.convertSbValue (WindowsGui.SB_PAGELEFT)
	  val sb_right = WindowsGui.convertSbValue (WindowsGui.SB_PAGERIGHT)
	  val (ireturned, wsize, wmask, imin, imax, wpage, ipos, itrackpos) = 
	    WindowsGui.getScrollInfo (window, WindowsGui.SB_HORZ)
	  val w2i = WindowsGui.wordToInt
	  val (isize, imask, ipage) = (w2i wsize, w2i wmask, w2i wpage)
	  val pager = Int.min (imax, ipos + ipage - 1)
	  val pagel = Int.max (imin, ipos - ipage + 1)
	  val hi_word = Word32.fromInt (WindowsGui.convertSbValue WindowsGui.SB_THUMBPOSITION)
	  val lo_word_r = Word32.<< (Word32.fromInt pager, 0w16)
	  val lo_word_l = Word32.<< (Word32.fromInt pagel, 0w16)
	in
	  if scroll_value = sb_right then 
	    SOME (WindowsGui.sendMessage(window, WindowsGui.WM_HSCROLL, 
				 WindowsGui.WPARAM (Word32.+ (lo_word_r, hi_word)),
				 WindowsGui.LPARAM WindowsGui.nullWord))
	  else if scroll_value = sb_left then 
	      SOME (WindowsGui.sendMessage(window, WindowsGui.WM_HSCROLL, 
				       WindowsGui.WPARAM (Word32.+ (lo_word_l, hi_word)),
				       WindowsGui.LPARAM WindowsGui.nullWord))
	  else NONE
	end

    in
      set_text_font widget;
      set_text (widget,"");
      text_subclass window;
      WindowsGui.addCommandHandler (CapiTypes.get_real parent,scrolled_text_id,command_handler);

      (* This message handler prevents the window menu from being displayed and hence acts
       * as a workaround for bug #1992.  Ideally though the menu should be enabled and 
       * the illegal operations grayed out - use calls to TrackPopupMenu, GetSystemMenu,
       * and SetMenuItemInfo to achieve this. *)
      WindowsGui.addMessageHandler (window, WindowsGui.WM_CONTEXTMENU, 
	fn _ => SOME WindowsGui.nullWord);

      WindowsGui.addMessageHandler (window, WindowsGui.WM_HSCROLL, scrolling);   
      sendMessageNoResult (window,
                           WindowsGui.EM_LIMITTEXT,
                           WindowsGui.WPARAM WindowsGui.nullWord,
                           WindowsGui.LPARAM WindowsGui.nullWord);
      (widget,widget)
    end

(* This should be superseeded by WindowsGui.setMinMaxInfo *)
  fun set_min_window_size (widget, min_x, min_y) = 
    let 
      val min_window_size : WindowsGui.wparam * WindowsGui.lparam * int * int -> unit = 
	env "win32 min window size"
    in
      WindowsGui.addMessageHandler(CapiTypes.get_real widget, WindowsGui.WM_SIZING, 
	fn (wp, lp) => 
	  (min_window_size (wp, lp, min_x, min_y);
	   NONE))
    end

  fun make_scrolllist {parent, name, select_fn, action_fn, print_fn} =
    let
      val scrolllist_id = WindowsGui.newControlId ()
      val items_ref = ref []
      val window = 
        create_revealed
        {class = "LISTBOX",
         name = LabelStrings.get_title name,
         width = default_width,
         height = 150,
         parent = CapiTypes.get_real parent,
         menu = scrolllist_id,
         styles = [WindowsGui.WS_CHILD,WindowsGui.WS_BORDER,
                   WindowsGui.WS_VSCROLL,WindowsGui.WS_HSCROLL,
		   WindowsGui.LBS_NOTIFY, WindowsGui.LBS_NOINTEGRALHEIGHT]}
      val widget =CapiTypes.REAL (window,parent)



      local
        fun itemTextWidth (_, (itemIndex, maxWidth)) =
          let
            val w = WindowsGui.WPARAM (WindowsGui.intToWord itemIndex)
            val l = WindowsGui.LPARAM WindowsGui.nullWord
            val r = WindowsGui.sendMessage (window, WindowsGui.LB_GETTEXTLEN, w, l)
            val maxWidth' = max (WindowsGui.wordToInt r, maxWidth)
          in
            (itemIndex+1, maxWidth')
          end
      in

        fun itemsMaxTextWidth items = 
         let
           val (_, maxWidth) = List.foldl itemTextWidth (0, 0) items
         in
           maxWidth
         end
      end



      fun add_items opts items =
        ((Lists.iterate
         (fn item =>
          let
            val string = strip_string_controls (print_fn opts item)
            val string_word = WindowsGui.makeCString string
          in
            sendMessageNoResult (window,WindowsGui.LB_ADDSTRING,
                                 WindowsGui.WPARAM WindowsGui.nullWord,
                                 WindowsGui.LPARAM string_word);
            WindowsGui.free string_word
          end)
         items;
         items_ref := !items_ref @ items);

	(* This let statement sets the horizontal extent to the value of
         * the maximum text length in the list box to enable horizontal
         * scrolling.
         *)
	let 
	   val i2w = WindowsGui.intToWord
	   (* Need this because LB_SETHORIZONTALEXTENT takes pixel values  *)
	   val charWidthInPixels = WindowsGui.loword(WindowsGui.getDialogBaseUnits())
           val maxTextWidth = itemsMaxTextWidth (!items_ref)
	in 
          if maxTextWidth > 0 then 
	    sendMessageNoResult
              (window,WindowsGui.LB_SETHORIZONTALEXTENT, 
               WindowsGui.WPARAM (i2w (maxTextWidth * charWidthInPixels)),
               WindowsGui.LPARAM WindowsGui.nullWord)
          else ()
	end)


      fun set_items opts items =
        (* Clear the list widget, and then reset *)
        (sendMessageNoResult (window,WindowsGui.LB_RESETCONTENT,
                              WindowsGui.WPARAM WindowsGui.nullWord,
                              WindowsGui.LPARAM WindowsGui.nullWord);
	 items_ref := [];
	 add_items opts items)

      val select_fn' = select_fn (widget,widget,set_items,add_items)
      val action_fn' = action_fn (widget,widget,set_items,add_items)

      fun select_handler (_,event) =
        if event = 1 (* MAGIC NUMBER = LBN_SELCHANGE *) then
          let
            val item =
              WindowsGui.wordToSignedInt
		(WindowsGui.sendMessage
		   (window,
		    WindowsGui.LB_GETCURSEL,
		    WindowsGui.WPARAM WindowsGui.nullWord,
                    WindowsGui.LPARAM WindowsGui.nullWord))
          in
            debug (fn _ => "Selection of " ^ N item ^ "\n");
            if item >= 0 then select_fn' (Lists.nth (item,!items_ref)) else ()
          end
        else if event = 2 (* MAGIC NUMBER = LBN_DBLCLK *) then
          let
            val item =
              WindowsGui.wordToSignedInt
		(WindowsGui.sendMessage
		   (window,
                    WindowsGui.LB_GETCURSEL,
                    WindowsGui.WPARAM WindowsGui.nullWord,
                    WindowsGui.LPARAM WindowsGui.nullWord))
          in
            debug (fn _ => "Double click of " ^ N item ^ "\n");
            if item >= 0 then action_fn' (Lists.nth (item,!items_ref)) else ()
          end
        else
          debug (fn _ => "Event " ^ N event ^ " received for list\n")
    in
      set_text_font widget;
      WindowsGui.addCommandHandler
	(CapiTypes.get_real parent,scrolllist_id,select_handler);
      {scroll=widget, list=widget, set_items=set_items, add_items=add_items}
    end

  fun make_file_selection_box (name,parent,attributes) =
    unimplemented "make_file_selection_box"

  (* Widget functions *)
  fun destroy window = WindowsGui.destroyWindow (CapiTypes.get_real window)

  fun initialize_toplevel window = reveal (CapiTypes.get_real window)
  fun initialize_application_shell shell = 
	WindowsGui.showWindow(CapiTypes.get_real shell, WindowsGui.SW_SHOWMAXIMIZED)

  (* When bringing a window to the front (eg. by selecting an item in the windows
   * menu), we want the window to be restored if it is minimized, so that it 
   * becomes visible *)
  fun to_front window = 
    let val (state, _, _, _) = WindowsGui.getWindowPlacement (CapiTypes.get_real window)
    in
      if state = 0 (* restored *) then 
	WindowsGui.showWindow (CapiTypes.get_real window, WindowsGui.SW_RESTORE)
      else if state = 1 (* minimized *) then 
	WindowsGui.showWindow (CapiTypes.get_real window, WindowsGui.SW_MINIMIZE)
      else (* = 2 which is maximized *)
	WindowsGui.showWindow (CapiTypes.get_real window, WindowsGui.SW_MAXIMIZE);
      WindowsGui.bringWindowToTop (CapiTypes.get_real window)
    end

  fun transfer_focus (from,to) =
    WindowsGui.addMessageHandler (CapiTypes.get_real from,WindowsGui.WM_SETFOCUS,
                                 fn _ => 
                                 (ignore(WindowsGui.setFocus (CapiTypes.get_real to));
                                  SOME WindowsGui.nullWord))

  fun set_sensitivity (widget,sensitivity) = ()

  (* set the label string of a label widget *)  
  fun set_label_string (label,s) =
    set_text (label,s)

  fun set_focus w = (ignore(WindowsGui.setFocus (CapiTypes.get_real w)); ())

  fun set_busy w = (ignore(WindowsGui.setCursor (WindowsGui.loadCursor WindowsGui.IDC_WAIT)); ())

  fun unset_busy w = (ignore(WindowsGui.setCursor (WindowsGui.loadCursor WindowsGui.IDC_ARROW)); ())

  fun widget_size widget = 
    let
      val WindowsGui.RECT {left,top,right,bottom} = WindowsGui.getWindowRect (CapiTypes.get_real widget)
    in
      (right-left,bottom-top)
    end

  fun widget_pos widget = 
    let
      val WindowsGui.RECT {left,top, ...} = WindowsGui.getWindowRect (CapiTypes.get_real widget)
    in
      (left, top)
    end

  val set_message_window : CapiTypes.Hwnd -> unit = env "nt set message widget"

  fun set_message_widget widget =
    set_message_window (CapiTypes.get_real widget)

  val no_message_widget : unit -> unit = env "nt no message widget"

  fun move_window (widget,x,y) = 
    let
      val (w,h) = widget_size widget
    in
      WindowsGui.moveWindow (CapiTypes.get_real widget,x,y,w,h,true)
    end

  fun size_window (widget, w, h) = 
   let
     val WindowsGui.RECT {left,top,right,bottom} = WindowsGui.getWindowRect (CapiTypes.get_real widget)
   in
     WindowsGui.moveWindow (CapiTypes.get_real widget, left, top, w, h, true)
   end

  fun init_size (window, sizeOpt) = 
    if isSome (sizeOpt) then 
      let val (w, h) = valOf(sizeOpt) 
      in 
	size_window (window, w, h)
      end
    else ()

  fun get_pointer_pos () =
    let
      val WindowsGui.POINT {x,y} = WindowsGui.getCursorPos ()
    in
      (x,y)
    end

  fun set_close_callback (shell, close_fun) = 
    WindowsGui.addMessageHandler(CapiTypes.get_real shell, WindowsGui.WM_CLOSE, 
	fn _ => (ignore(close_fun()); SOME (WindowsGui.nullWord)))

  fun event_loop continue = 
    (while (!continue) do 
       if WindowsGui.doInput ()
         then raise SubLoopTerminated
       else ();
     debug (fn _ => "sub loop exited\n"))

  fun main_loop () = WindowsGui.mainLoop ()


  datatype FileType = DIRECTORY | FILE

  (* The following windows functions return the empty string when they
     can't find a file.  We convert this to an option type.  *)

  fun open_file_dialog (parent, mask, multi) =
    let 
      val (ext, desc) = 
	case mask of 
	  ".sml" => ("sml", "SML files")
	| ".mo"  => ("mo", "MLWorks objects files")
	| ".mlp" => ("mlp", "MLWorks projects files")
	| "" 	 => ("*", "All files")
	| s	 => (s, "")

    in
      (case WindowsGui.openFileDialog (CapiTypes.get_real parent, desc, ext, multi) of
         [] => NONE
       | s => SOME s)
    end
  
  fun open_dir_dialog parent =
    (case WindowsGui.openDirDialog (CapiTypes.get_real parent)
     of "" => NONE
     |  s => SOME s)

  (* Can create a directory on Unix, but Win32 does not allow
   * a directory to be created.
   *)
  val set_dir_dialog = open_dir_dialog

  fun save_as_dialog (parent, mask) =
    case mask of
      ".sml" =>
	(case WindowsGui.saveDialog (CapiTypes.get_real parent, "SML files", "sml") of
	   "" => NONE
	 | s => SOME s)
    | ".img" =>
	(case WindowsGui.saveDialog (CapiTypes.get_real parent, "Image files", "img") of
	   "" => NONE
	 | s => SOME s)
    | ".mlp" =>
	(case WindowsGui.saveDialog (CapiTypes.get_real parent, "MLW project files", "mlp") of
	   "" => NONE
	 | s => SOME s)
    | _ =>
	(case WindowsGui.saveDialog (CapiTypes.get_real parent, "All files", "*") of
	   "" => NONE
	 | s => SOME s)

  val send_message = Menus.send_message

  fun makeYesNoCancel (parent, question, cancelButton) () =
    let 
      val yes = env "win32 yes id"
      val no = env "win32 no id"
      val cancel = env "win32 cancel id"
      val yesNoStyle = if cancelButton then WindowsGui.MB_YESNOCANCEL else WindowsGui.MB_YESNO
      val answer = WindowsGui.messageBox (CapiTypes.get_real parent, question, 
				       "MLWorks", yesNoStyle :: [WindowsGui.MB_APPLMODAL])
    in
      if answer = (env "win32 yes id") then SOME true
      else
	if answer = (env "win32 no id") then SOME false
	else NONE
    end

  fun find_dialog (parent, searchFn, spec) = 
    let 
      val real_parent = CapiTypes.get_real parent
      val {findStr, caseOpt, downOpt, wordOpt} = spec

      val dialogRef = ref WindowsGui.nullWindow
      val id_cancel : int = env "win32 cancel id"

      (* function searching is called when the user clicks
       * the Find Next button on the find dialog *)
      fun searching (_, WindowsGui.LPARAM addr) = 
	let 
	  val {searchStr, matchCase, searchDown, wholeWord, findNext, closing} = 
	    WindowsGui.getFindFlags addr
	in
	  if findNext then 
	    searchFn {searchStr=searchStr, 
		      matchCase=matchCase,
		      searchDown=searchDown,
		      wholeWord=wholeWord}
	  else ();
	  NONE
	end

    in
      WindowsGui.addMessageHandler(real_parent, WindowsGui.FINDMSGSTRING, searching);

      fn () => 
	(if ((!dialogRef) = WindowsGui.nullWindow) then 
	   (dialogRef := WindowsGui.findDialog (real_parent,
					   findStr, caseOpt, downOpt, wordOpt);
	    WindowsGui.registerPopupWindow (!dialogRef);
	    WindowsGui.addCommandHandler(!dialogRef, WindowsGui.intToWord id_cancel, 
		fn _ => hide (CapiTypes.REAL(!dialogRef, parent)));
	    WindowsGui.addMessageHandler(!dialogRef, WindowsGui.WM_DESTROY,
		fn _ => (WindowsGui.unregisterPopupWindow(!dialogRef);
			dialogRef := WindowsGui.nullWindow;
			SOME (WindowsGui.nullWord))))
	 else ();
	 reveal (!dialogRef);
	 CapiTypes.REAL (!dialogRef, parent))
    end

  fun with_message (parent,message) f = 
    let
      val _ = set_busy parent
      fun reset () = unset_busy parent
      val result = f () 
        handle exn as SubLoopTerminated => raise exn
             | exn => (reset(); raise exn)
    in
      reset();
      result
    end

  fun beep widget = WindowsGui.messageBeep WindowsGui.MB_OK

  structure Callback =
    struct
      datatype Type =
	Activate (* just used for processing return in text widgets *)
      | Destroy (* used a lot *)
      | Unmap (* not used in WindowsGui. *)
      | Resize (* WM_SIZE corresponds here *)
      | ValueChange

      fun print_callback c =
        case c of
          Activate => "Activate"
        | Destroy => "Destroy"
        | Unmap => "Unmap"
        | Resize => "Resize"
        | ValueChange => "ValueChange"

      fun convert_callback c =
        case c of
          Activate => NONE
        | Destroy => SOME WindowsGui.WM_DESTROY
        | Unmap => NONE
        | Resize => SOME WindowsGui.WM_SIZE
	| ValueChange => SOME WindowsGui.WM_CLOSE

      fun getParentIdPair CapiTypes.NONE = (WindowsGui.nullWindow, WindowsGui.nullWord)
	| getParentIdPair (CapiTypes.REAL (w, p)) = 
	    (CapiTypes.get_real p, WindowsGui.intToWord (WindowsGui.getDlgCtrlID w))
	| getParentIdPair (CapiTypes.FAKE _) = (WindowsGui.nullWindow, WindowsGui.nullWord)

      fun add (window,callback,handler) =
        case convert_callback callback of
          NONE => ()
	| SOME WindowsGui.WM_CLOSE => 
	    let val (p, win_id) = getParentIdPair window
	    in WindowsGui.addCommandHandler (p, win_id, fn _ => handler())
	    end
        | SOME message =>
            WindowsGui.addMessageHandler (CapiTypes.get_real window,message,
                                       fn _ => (handler (); NONE))
    end

  structure List =
    struct
      (* The capi, for historical reasons, numbers list items from 1 (yuk!) *)
      (* but windows numbers things from 0 *)
      fun get_selected_pos list = 
        let
          val result = 
            WindowsGui.wordToSignedInt (WindowsGui.sendMessage (CapiTypes.get_real list,
                                                          WindowsGui.LB_GETCURSEL,
                                                          WindowsGui.WPARAM WindowsGui.nullWord,
                                                          WindowsGui.LPARAM WindowsGui.nullWord))
        in
          if result >= 0
            then MLWorks.Internal.Vector.vector [result+1]
          else MLWorks.Internal.Vector.vector []
        end

      (* perhaps we should notice the notify parameter *)
      (* or it should be removed from the capi *)
      fun select_pos (list,pos,notify) = 
        let
          val hwnd = CapiTypes.get_real list
	  val id = WindowsGui.getDlgCtrlID hwnd
        in
          sendMessageNoResult (CapiTypes.get_real list,
                               WindowsGui.LB_SETCURSEL,
                               WindowsGui.WPARAM (WindowsGui.intToWord (pos-1)),
                               WindowsGui.LPARAM WindowsGui.nullWord);
          if not notify then ()
          else
            (debug (fn _ => "Notifying\n");
             sendMessageNoResult (WindowsGui.getParent (CapiTypes.get_real list),
                                  WindowsGui.WM_COMMAND,
                                  WindowsGui.WPARAM (WindowsGui.intToWord (256 * 256 * 1 + id)),
                                  WindowsGui.LPARAM (WindowsGui.windowToWord hwnd)))
        end

      (* "sets the item to be the first visible in the list widget" *)
      fun set_pos (list, pos) =
        sendMessageNoResult (CapiTypes.get_real list,
                             WindowsGui.LB_SETTOPINDEX,
                             WindowsGui.WPARAM (WindowsGui.intToWord (pos-1)),
                             WindowsGui.LPARAM WindowsGui.nullWord)
       
      fun add_items (list, items) =
        (Lists.iterate
           (fn item =>
              let
                val string = strip_string_controls item
                val string_word = WindowsGui.makeCString string
              in
                sendMessageNoResult   
	          (CapiTypes.get_real list,
	           WindowsGui.LB_ADDSTRING,
                   WindowsGui.WPARAM WindowsGui.nullWord,
                   WindowsGui.LPARAM string_word);
                WindowsGui.free string_word
              end)
            items;
	 ())
    end

  structure Text =
    struct

      fun add_del_handler (window, handler) = 
        let 
          val window' = CapiTypes.get_real window
          fun del_handler (WindowsGui.WPARAM w, WindowsGui.LPARAM l) = 
	    if ((WindowsGui.wordToInt w) = LabelStrings.VK_DELETE) then 
	      (ignore(handler()); SOME (WindowsGui.nullWord))
	    else
	      NONE
        in
          WindowsGui.addMessageHandler (window', WindowsGui.WM_KEYDOWN, del_handler)
        end

      fun text_size text =
        WindowsGui.wordToSignedInt (WindowsGui.sendMessage (CapiTypes.get_real text,
                                                      WindowsGui.WM_GETTEXTLENGTH,
                                                      WindowsGui.WPARAM WindowsGui.nullWord,
                                                      WindowsGui.LPARAM WindowsGui.nullWord))
      fun get_insertion_position text =
        let
          val res = WindowsGui.sendMessage (CapiTypes.get_real text,
                                         WindowsGui.EM_GETSEL,
                                         WindowsGui.WPARAM WindowsGui.nullWord,
                                         WindowsGui.LPARAM WindowsGui.nullWord)
        in
          WindowsGui.hiword res
        end

      fun set_selection (text,pos1,pos2) =
        (debug (fn _ => "set_selection " ^ N pos1 ^ ", " ^ N pos2);
         sendMessageNoResult (CapiTypes.get_real text,
                              WindowsGui.EM_SETSEL,
                              WindowsGui.WPARAM (WindowsGui.intToWord pos1),
                              WindowsGui.LPARAM (WindowsGui.intToWord pos2)))

      fun set_insertion_position (text,pos) =
        (set_selection (text,pos,pos);
         let
           val p = get_insertion_position text
         in
           if p = pos then () 
           else debug (fn _ => "Set insertion position has failed: " ^ N pos ^ " " ^ N p)
         end)

      fun insert (text,pos,str) =
        let
          val string_word = WindowsGui.makeCString (munge_string str)
        in
          set_insertion_position (text,pos);
          sendMessageNoResult (CapiTypes.get_real text,
                               WindowsGui.EM_REPLACESEL,
                               WindowsGui.WPARAM WindowsGui.nullWord,
                               WindowsGui.LPARAM string_word);
          WindowsGui.free string_word
        end

      fun replace (text,from,to,str) =
        let
          val string_word = WindowsGui.makeCString (munge_string str)
        in
          set_selection (text,from,to);
          sendMessageNoResult (CapiTypes.get_real text,
                               WindowsGui.EM_REPLACESEL,
                               WindowsGui.WPARAM WindowsGui.nullWord,
                               WindowsGui.LPARAM string_word);
          WindowsGui.free string_word
        end

      val get_last_position = text_size
      fun get_string text = 
        let
          val size = text_size text
          (* What happens if the text changes at this point? *)
          val buffer = WindowsGui.malloc (size+1) (* extra for null termination *)
          (* should check for malloc failure here *)
          val _ = WindowsGui.sendMessage (CapiTypes.get_real text,
                                       WindowsGui.WM_GETTEXT,
                                       WindowsGui.WPARAM (WindowsGui.intToWord (size+1)), (* add 1 for the last null character *)
                                        WindowsGui.LPARAM buffer)
          val _ = WindowsGui.setByte (buffer,size,0) (* null terminate *) (* probably not necessary *)
          val result = WindowsGui.wordToString buffer
        in
          WindowsGui.free buffer;
          result
        end

      fun substring (text,from,size) =
        MLWorks.String.substring (* could raise Substring *) (get_string text,from,size)

      fun set_string (text,s) = set_text (text,s)

      fun set_highlight (text, startpos, endpos, b) =
        if not b then ()
        else 
          let
            val hwnd = CapiTypes.get_real text
            val w = WindowsGui.intToWord startpos
          in
            sendMessageNoResult (hwnd,
                                 WindowsGui.EM_SETSEL,
                                 WindowsGui.WPARAM w,
                                 WindowsGui.LPARAM w);
            sendMessageNoResult (hwnd,
                                 WindowsGui.EM_SCROLLCARET,
                                 WindowsGui.WPARAM WindowsGui.nullWord,
                                 WindowsGui.LPARAM WindowsGui.nullWord)
          end

      fun get_selection text = 
        let
          val res = WindowsGui.sendMessage (CapiTypes.get_real text,
                                         WindowsGui.EM_GETSEL,
                                         WindowsGui.WPARAM WindowsGui.nullWord,
                                         WindowsGui.LPARAM WindowsGui.nullWord)
          val start = WindowsGui.loword res
          val finish = WindowsGui.hiword res
        in
          substring (text,start,finish-start)
        end

      fun remove_selection text = 
        let
          val string_word = WindowsGui.makeCString ""
        in
          sendMessageNoResult (CapiTypes.get_real text,
                               WindowsGui.EM_REPLACESEL,
                               WindowsGui.WPARAM WindowsGui.nullWord,
                               WindowsGui.LPARAM string_word);
          WindowsGui.free string_word
        end

      local
        fun lastline (str, ~1) = 0
          | lastline (str,n) =
            if MLWorks.String.ordof (str, n) = ord #"\n"
              then n+1
            else lastline (str,n-1)
      in
        (* Return the line containing pos, and the index of its first character *)
        fun get_line_and_index (text,pos) =
          let
            val str = get_string text
            val length = size str
              
            fun nextline n =
              if n = length orelse MLWorks.String.ordof (str, n) = ord #"\n" then
                n
              else
                nextline (n+1)
            val start = lastline (str,pos-1)
            val finish = nextline pos
            val result = MLWorks.String.substring (* could raise Substring *) (str, start, finish - start)
          in
            (result,pos - start)
          end
        
        (* Returns the index of the line containing pos *)
        fun current_line (text,pos) =
          lastline (get_string text,pos-1)
          
        (* Returns the index of the line after the line containing pos *)
        fun end_line (text,pos) =
          let
            val str = get_string text
            val length = size str
            fun aux n = 
              if n = length orelse MLWorks.String.ordof (str, n) = ord #"\n" then
                n
              else
                aux (n+1)
          in
	    if pos > length then pos else aux pos
          end
        
        val get_line = #1 o get_line_and_index
      end

      val convert_text = munge_string
      fun text_size s = size (munge_string s)

      (* Handlers *)
      fun add_handler (window,handler: string * Event.Modifier list -> bool) =
        text_handlers := (window,handler) :: !text_handlers

      (* The HOME, END, and cursor key actions are sufficient on Windows, and 
       * the functions defined in the Listener are not needed.  Using the Listener
       * also do not allow selections to be made by holding down the shift and
       * control keys.  If in the future, the Listener functions are needed, then 
       * they can be attached to the HOME, END, etc keys using the same method 
       * as in add_del_handler.
       *)
      fun get_key_bindings _ = []

      fun add_modify_verify _ = () (* dummy "add_modify_verify" *)
      (* nasty hack *)
      val read_only_before_prompt = true

      fun cut_selection text =
        (sendMessageNoResult (CapiTypes.get_real text,
                              WindowsGui.WM_CUT,
                              WindowsGui.WPARAM WindowsGui.nullWord,
                              WindowsGui.LPARAM WindowsGui.nullWord))

      fun paste_selection text =
        (sendMessageNoResult (CapiTypes.get_real text,
                              WindowsGui.WM_PASTE,
                              WindowsGui.WPARAM WindowsGui.nullWord,
                              WindowsGui.LPARAM WindowsGui.nullWord))

      fun copy_selection text =
        (sendMessageNoResult (CapiTypes.get_real text,
                              WindowsGui.WM_COPY,
                              WindowsGui.WPARAM WindowsGui.nullWord,
                              WindowsGui.LPARAM WindowsGui.nullWord))

      val delete_selection = remove_selection

      (* Can't handle text of more than 64K because set_insertion_position is limited to 16 bit positions *)
      val text_limit = 50000
      val text_chunk = 8000

      fun check_insertion(text, str, current, marks) =
        let
          val length = get_last_position text
	  val size = size str
	  val max = text_limit-text_chunk
        in
          if length + size < text_limit then
	    str
          else
	    if size >= max then
	      check_insertion(text, String.substring(str, size-max, max), current, marks)
	    else
	      let
		val reduction = if size > text_chunk then size else text_chunk
		val reduction = if reduction >= current then current else reduction
	      in
		sendMessageNoResult (CapiTypes.get_real text,
				     WindowsGui.WM_SETREDRAW,
				     WindowsGui.WPARAM (WindowsGui.intToWord 0),
				     WindowsGui.LPARAM WindowsGui.nullWord);
		replace (text,0,text_chunk,"");
		set_insertion_position (text,current-reduction);
		sendMessageNoResult (CapiTypes.get_real text,
				     WindowsGui.WM_SETREDRAW,
				     WindowsGui.WPARAM (WindowsGui.intToWord 1),
				     WindowsGui.LPARAM WindowsGui.nullWord);
		Lists.iterate (fn pos => pos := !pos - reduction) marks;
		str
	      end
        end
    end

  fun setAttribute (widget, attrib) =
    let
      val hwnd = CapiTypes.get_real widget

      fun changeStyle (window_style, toAdd) = 
	let 
	  val style_word = WindowsGui.convertStyle window_style
	  val cur_value = WindowsGui.getWindowLong (hwnd, WindowsGui.GWL_STYLE)
	  val new_value = 
	    if (toAdd) then 
	      Word32.orb (cur_value, style_word)
	    else
	      Word32.andb (cur_value, Word32.notb (style_word))
	in
	  WindowsGui.setWindowLong (hwnd, WindowsGui.GWL_STYLE, new_value)
	end
    in
      (* Setting the size and position of a control after it has been created 
       * does not work properly at present, probably due to the message handler
       * for WM_SIZE, which is set up in a call to Capi.Layout.laay_out.
       *)
      ignore(
	case attrib of
          Position (x,y) => move_window (widget, x, y)
        | Size (w,h)     => size_window (widget, w, h)
        | ReadOnly tf    => ignore(changeStyle (WindowsGui.ES_READONLY, tf))
	| PanedMargin m  => ())
    end

  structure Layout =
    struct
      datatype Class =
        MENUBAR of CapiTypes.Widget
      | FLEX of CapiTypes.Widget
      | FIXED of CapiTypes.Widget
      | FILEBOX of CapiTypes.Widget
      | PANED of CapiTypes.Widget * (CapiTypes.Widget * Class list) list
      | SPACE

      (* get the parent-relative position of a window *)
      fun widget_position window =
        let
          val window = CapiTypes.get_real window
          val WindowsGui.RECT {left,top,...} = WindowsGui.getWindowRect window
          val parent = WindowsGui.getParent window
        in
          if WindowsGui.isNullWindow parent
            then (left,top)
          else
            let
              val WindowsGui.POINT{x,y,...} = WindowsGui.screenToClient (parent,WindowsGui.POINT {x=left,y=top})
            in
              (x,y)
            end
        end

      fun enum_direct_children (w,f) =
        let
          val realw = CapiTypes.get_real w
          fun g subwindow =
            if not (WindowsGui.isNullWindow subwindow) andalso
              WindowsGui.getParent subwindow = realw (* only do this for direct subwindows *)
              then f (CapiTypes.REAL (subwindow,w))
            else ()
        in
          WindowsGui.enumChildWindows (realw,g)
        end
      
      fun count_direct_children w =
        let
          val count = ref 0
        in
          enum_direct_children (w, fn _ => count := 1 + !count);
          !count
        end

      (* This basically should arrange the given widgets in a column within *)
      (* their frame *)
      fun lay_out (parent, sizeOpt, children) =
        let
          fun do_one
	       (child, (maxwidth, y, min_height), (width, height)) =
            let
              val child = CapiTypes.get_real child
            in
              if not (WindowsGui.isNullWindow child) then
                (debug (fn _ => "do_one: " ^ N width ^ " " ^ N height ^ " " ^ N y);
                 WindowsGui.moveWindow (child, 0, y, width, height, true);
                 (max (width, maxwidth), y + height, min_height + height))
              else
		(maxwidth, y, min_height)
            end

	  fun do_all (w_list, (max_width, y, min_height)) =
            Lists.reducel
            (fn (a,MENUBAR w) => a (* Window deals with menubars itself *)
              | (a as (_, _, min_height), FLEX w) =>
		  let
		    val (maxwidth, y, _) = do_one (w,a,widget_size w)
		  in
		    (maxwidth, y, min_height + 10)
		  end
              | (a,FILEBOX w) => do_one (w,a,widget_size w)
              | (a,FIXED w) => do_one (w,a,widget_size w)
              | (a as (_, _, min_height), PANED (w, panes)) => 
		  let
		    (* First lay out each subwindow.  This includes setting
		       up a resize handler. *)
		    val _ = map lay_out (map (fn (w,p) => (w, NONE, p)) panes)

		    (* Now find the height, max_width, and min_height of w
		       by traversing the sub-specification (again). *)
		    val (max_width', y', min_height') =
		      Lists.reducel
		        (fn (a, (_, children)) =>
		           do_all (children, a))
		        ((0,0,0), panes)

		    val (maxwidth'', y'', _) =
		      do_one (w, a, (max_width', y'))
		  in
		    (maxwidth'', y'', min_height + min_height')
		  end
              | ((width,y,min_height),SPACE) =>
		(width, y, min_height))
            ((max_width, y, min_height), w_list)

          val (total_width, total_height, min_height) =
	    do_all (children, (0, 0, 0))

          val height_ref = ref total_height
          val (x,y) = widget_position parent
          val (w,h) = widget_size parent
          val WindowsGui.RECT {right=cright,bottom=cbottom,left=cleft,top=ctop} =
	    WindowsGui.getClientRect (CapiTypes.get_real parent)

          fun relayout (width,height) =
            let
              val delta = height - !height_ref (* amount to add on *)
              val _ = height_ref := height
              val yref = ref 0

              fun move_one (window,delta) =
                if WindowsGui.isNullWindow (CapiTypes.get_real window)
                  then ()
                else
                  let
                    val (_,h) = widget_size window
                    val newh = h + delta
                  in
                    WindowsGui.moveWindow(CapiTypes.get_real window,0,!yref,width,newh,true);
                    yref := !yref + newh
                  end

              fun do_one (MENUBAR window) = ()
                | do_one (FLEX window) =
                    move_one (window,delta)
                | do_one (FILEBOX window) = move_one (window,0)
                | do_one (FIXED window) = move_one (window,0)
                | do_one (PANED (window, _)) = 
                  let
                    val num_children = count_direct_children window
                  in
                    if num_children = 0
                      then ()
                    else
                      let
                        val yref = ref 0
                        val (_,h) = widget_size window
                        val subheight = (h + delta) div num_children
                        val first_height = h + delta - ((num_children - 1) * subheight)
                        val height_ref = ref first_height
                      in
                        enum_direct_children
                        (window,
                         fn subwindow =>
                         (WindowsGui.moveWindow (CapiTypes.get_real subwindow,0,!yref,width,!height_ref,true);
                          yref := !yref + !height_ref;
                          height_ref := subheight))
                      end;
                    move_one (window,delta)
                  end
                | do_one (SPACE) = ()
            in
              Lists.iterate do_one (children)
            end
        in
	  if isSome(sizeOpt) then
	    init_size(parent, sizeOpt)
	  else
            WindowsGui.moveWindow
	      (CapiTypes.get_real parent, x, y,
	       total_width + w - cright,
	       total_height + h - cbottom,
	       true);

	  (* This relayout needs to be done otherwise the Error Browser will not 
	   * appear properly until resized.  The reason is unknown but this bug
	   * only raised its ugly head due to the menubar being removed and hence
	   * no longer invokes a WM_SIZE being sent, and hence relayout is no
	   * longer called automatically and needs to be done explicitly here. *)
          relayout (total_width, total_height);

          (* only add the resize handler after the initial layout *)
          WindowsGui.addMessageHandler
	    (CapiTypes.get_real parent,
	     WindowsGui.WM_SIZE,
             fn (WindowsGui.WPARAM wparam, WindowsGui.LPARAM lparam) => 
               (if  WindowsGui.wordToInt wparam = 1 (* SIZE_MINIMIZED *) then
		  ()
                else
                  let
                    val width = WindowsGui.loword lparam
                    val height = WindowsGui.hiword lparam
                  in
		    if height < min_height then
		      ()
		    else
                      relayout (width, height)
                  end;
                SOME WindowsGui.nullWord))
        end
    end

  fun list_select (parent, name, _) =
    let
      val shell = make_popup_shell (name,parent, [], ref true)
      val form = make_subwindow shell
      exception ListSelect
      val select_fn_ref = ref (fn _ => raise ListSelect)
      val print_fn_ref = ref (fn _ => raise ListSelect)

      val exited = ref false;
      fun exit _ = if !exited then () else (destroy shell; exited := true)

      val {scroll, set_items, ...} =
        make_scrolllist
        {parent = form,
         name = "listSelect",
         select_fn = fn _ => fn x => (exit();(!select_fn_ref) x),
         action_fn = fn _ => fn _ => (),
         print_fn = fn _ => (!print_fn_ref)}

      val dialogButtons = make_managed_widget ("dialogButtons", RowColumn,form,[])
      val {update = buttons_updatefn, ...} = 
        Menus.make_buttons
        (dialogButtons,
         [Menus.PUSH ("cancel",
                      exit,
                      fn _ => true)])
      fun moveit () =
        let
          val width = 200
          val height = 221
          val (x,y) = get_pointer_pos ()
	  val desktopRect = WindowsGui.getWindowRect (WindowsGui.getDesktopWindow() )
	  fun get_list_rect () = WindowsGui.getWindowRect (CapiTypes.get_real shell)

	  (* shiftWindow moves the window to the new position and calls unobscureWindow
	   * so that all relevant sides of the window are checked against the desktop
	   * window.  *)
	  fun shiftWindow (hwnd, rect, desktop, new_x, new_y) = 
	    (WindowsGui.moveWindow (hwnd, new_x, new_y, width, height, true);
	     unobscureWindow (hwnd, get_list_rect(), desktop))

	  (* unobscureWindow checks three edges of the window against the desktop 
	   * window to ensure that the window is not outside the desktop window.
	   * The top edge is not checked against as the initial window position
	   * is below the cursor, and therefore the window will never be off the top
	   * of the screen *)
	  and unobscureWindow (hwnd,
		(rect as (WindowsGui.RECT {top=t, left=l, right=r, bottom=b})),
		(desktop as (WindowsGui.RECT {top=dt, left=dl, right=dr, bottom=db}))) =
	     if (l < dl) then 
	       shiftWindow (hwnd, rect, desktop, 0, t)
	     else if (r > dr) then 
	       shiftWindow (hwnd, rect, desktop, dr - width, t)
	     else if (b > db) then
	       shiftWindow (hwnd, rect, desktop, l, db - height)
	     else ()

        in
          (WindowsGui.moveWindow (CapiTypes.get_real shell,x-100,y+10,width,height,true);
	   unobscureWindow (CapiTypes.get_real shell, get_list_rect(), desktopRect))
        end

      fun popup (items,select_fn,print_fn) =
        (moveit ();
         select_fn_ref := select_fn;
         print_fn_ref := print_fn;
         set_items () items;
         reveal (CapiTypes.get_real form);
         exit)
        
    in
      Layout.lay_out
      (form, NONE,
       [Layout.FLEX scroll,
        Layout.SPACE,
        Layout.FIXED dialogButtons,
        Layout.SPACE]);
      popup
    end

  (* CLIPBOARD INTERFACE *)
  (* this just deals with text right now *)
  (* temporary hack *)

  fun clipboard_set (widget,s) = 
    let
      val window = CapiTypes.get_real widget
    in
      if WindowsGui.openClipboard (window)
        then
          (WindowsGui.emptyClipboard ();
           WindowsGui.setClipboardData s;
           WindowsGui.closeClipboard ())
      else Terminal.output("Can't open Clipboard\n")
    end

  fun clipboard_get (w,handler) =
    if WindowsGui.openClipboard (WindowsGui.nullWindow)
      then 
        let
          val result = WindowsGui.getClipboardData ()
          val _ = WindowsGui.closeClipboard ()
        in
          handler result
        end
      else 
        (Terminal.output("Can't open Clipboard\n");
         ())

  fun clipboard_empty widget =
    if WindowsGui.openClipboard (CapiTypes.get_real widget)
      then 
        let
          val result = WindowsGui.getClipboardData ()
          val _ = WindowsGui.closeClipboard ()
        in
          result = ""
        end
      else true

  local
    fun getBitmap args = 
        (MLWorks.Internal.Runtime.environment "win32 get splash bitmap") args
    fun paintBitmap dc = 
	(MLWorks.Internal.Runtime.environment "win32 paint splash bitmap") dc  

    val ref_show_splash = ref true;

    fun set_timer_text_font window =
      let
        val WindowsGui.OBJECT text_font =
	  WindowsGui.getStockObject (WindowsGui.ANSI_VAR_FONT)
      in
        sendMessageNoResult
          (window,
           WindowsGui.WM_SETFONT,
           WindowsGui.WPARAM text_font,
           WindowsGui.LPARAM (WindowsGui.intToWord 1))
      end
      handle WindowsGui.WindowSystemError _ => ()

    fun show_screen (parent, kind, duration) = 
      let 
	val desktop = WindowsGui.getDesktopWindow()
	val isFree = kind <> 0
	val countdown = ref duration

        val splash_window =
          createWindowEx
          {ex_styles = [WS_EX_DLGMODALFRAME],
	   class = "TopLevel",
           name = "",
	   x = 100,
	   y = 100,
           width = 506,
           height = 381,
           parent = WindowsGui.nullWindow,
           menu = WindowsGui.nullWord,
	   (* WS_POPUP style is needed to remove the title bar. *)
           styles = [WindowsGui.WS_POPUP,
                     WindowsGui.WS_BORDER,
		     WindowsGui.DS_MODALFRAME]}

	val _ = WindowsGui.centerWindow (splash_window, desktop)

        fun closedown () = (ref_show_splash := false; 
			  WindowsGui.destroyWindow splash_window);

	val s_dialog = CapiTypes.REAL (splash_window, parent)

	fun decrement_text () =
	  let 
	    val dc = WindowsGui.getDC splash_window
	    val _ = paintBitmap dc
	    val old_mode = WindowsGui.setBkMode(dc, WindowsGui.TRANSPARENT)
	  in
	    set_timer_text_font splash_window;
	    if (kind <> 2)
            then WindowsGui.textOut(dc, 350, 50, 
  		   "Time Left:  " ^ Int.toString (!countdown))
            else (* Skip timer for advert *) ();
	    ignore(WindowsGui.setBkMode(dc, old_mode))
	  end

        fun timercb () = 
	  if ((!countdown) = 1) then
	    closedown()
	  else
	    (countdown := (!countdown) - 1;
	     decrement_text())

	val splash_timer = WindowsGui.setTimer(splash_window, 1000, timercb);

	fun close_cb _ = (WindowsGui.killTimer(splash_window, splash_timer);
			  WindowsGui.destroyWindow splash_window;
			  ref_show_splash := false;
			  SOME (WindowsGui.nullWord))
	fun paint_cb _ = let val dc = WindowsGui.getDC splash_window
			in (ignore(paintBitmap dc); NONE)
			end
      in
	if getBitmap (splash_window, kind) then
	  (if kind = 1 then 
	     ()
	   else
	     (WindowsGui.addMessageHandler
		(splash_window, WindowsGui.WM_CLOSE, close_cb);
	      WindowsGui.addMessageHandler
		(splash_window, WindowsGui.WM_LBUTTONDOWN, close_cb));
	   decrement_text();
	   WindowsGui.addMessageHandler(splash_window, WindowsGui.WM_PAINT, paint_cb);
	   to_front s_dialog;
           event_loop ref_show_splash)
	else
	   if isFree then
	     (send_message (parent, "Splash screen bitmap not found.");
	      destroy parent)
	   else ()
      end
  in
    fun show_splash_screen parent = show_screen (parent, 0, 5)
  end

  structure GraphicsPorts =
    struct
      fun max (x:int,y) = if x > y then x else y
      fun min (x:int,y) = if x < y then x else y

      (* we should perhaps do something cleverer with the dc *)
      datatype GraphicsPort = 
        GP of {window: CapiTypes.Widget,
               dcref : WindowsGui.hdc option ref,
               name : string,
               title : string,
               x_offset: int ref,
               y_offset: int ref}

      exception BadDC

      fun gp_widget (GP {window,...}) = window
      fun gp_dc (GP {dcref = ref (SOME hdc),...}) = hdc
        | gp_dc (GP {dcref = ref (NONE),...}) = raise BadDC

      fun start_graphics (GP {window,dcref,...}) =
        case !dcref of
          SOME _ => ()
        | NONE =>
            let
              val dc = WindowsGui.getDC (CapiTypes.get_real window)
              (* Need to set the dc background to be the same as the windows *)
              val background = WindowsGui.getSysColor (WindowsGui.COLOR_WINDOW)
              val gui_font =
		WindowsGui.getStockObject (WindowsGui.DEFAULT_GUI_FONT)
	        handle
	          WindowsGui.WindowSystemError _ => 
	            WindowsGui.getStockObject (WindowsGui.ANSI_VAR_FONT)
            in
              ignore(WindowsGui.setBkColor (dc,background));
              ignore(WindowsGui.selectObject (dc,gui_font));
              dcref := SOME dc
            end
	    handle WindowsGui.WindowSystemError _ => ()

      fun stop_graphics (GP {window,dcref,...}) =
        case !dcref of
          NONE => ()
        | SOME dc =>
            (WindowsGui.releaseDC (CapiTypes.get_real window,dc);
             dcref := NONE)

      fun with_graphics gp f x =
         let
           val _ = start_graphics gp
           val result = f x handle exn => (stop_graphics gp; raise exn)
         in
           stop_graphics gp;
           result
         end

      (* currently no initialiazation *)
      fun initialize_gp _ = ()
      fun is_initialized _ = true
      exception UnInitialized

      fun get_offset (GP {x_offset,y_offset,...}) =
          POINT{x = !x_offset,y = !y_offset}
      fun set_offset (GP {x_offset,y_offset,...},POINT{x,y}) =
          (x_offset := max (x,0); y_offset:= max (y,0))

      (* We will try this by temporarily setting the text foreground and background colors *)
          
      fun with_highlighting (gp,f,a) = 
       let
          val dc = gp_dc gp
          val old_fg = WindowsGui.setTextColor (dc,WindowsGui.getBkColor dc);
          val old_bg = WindowsGui.setBkColor (dc,old_fg);
          fun undo _ = (ignore(WindowsGui.setTextColor (dc,old_fg));
                        WindowsGui.setBkColor (dc,old_bg))
          val result = f a handle exn => (ignore(undo ()); raise exn)
        in
          ignore(undo ());
          result
        end

      (* clip regions are unimplemented currently *)
      fun clear_clip_region (GP{...}) = () (* Unimplemented so far *)
      fun set_clip_region (GP {...},REGION{x,y,width,height}) = (* Unimplemented so far *)
        ()

      (* Erase the background, and redraw *)
      fun redisplay (gp as GP {window,...}) =
        with_graphics
        gp
        (fn () =>
         let
           val WindowsGui.HDC dcw = gp_dc gp
         in
           sendMessageNoResult (CapiTypes.get_real window,WindowsGui.WM_ERASEBKGND,
                                WindowsGui.WPARAM dcw,
                                WindowsGui.LPARAM WindowsGui.nullWord);
           sendMessageNoResult (CapiTypes.get_real window,WindowsGui.WM_PAINT,
                                WindowsGui.WPARAM WindowsGui.nullWord,
                                WindowsGui.LPARAM WindowsGui.nullWord)
         end)
        ()

      (* just redraw *)
      fun reexpose (GP {window,...}) =
        (WindowsGui.postMessage (CapiTypes.get_real window,WindowsGui.WM_PAINT,
                              WindowsGui.WPARAM WindowsGui.nullWord,
                              WindowsGui.LPARAM WindowsGui.nullWord);
         ())

      (* Useful for scrolling? *)
      (* This isn't currently used externally *)
      fun copy_gp_region (GP{...},GP{...},
                          REGION{x=x1,y=y1,width,height},POINT{x=x2,y=y2}) = 
        ()

      (* we store a dc for the each port -- could this be too expensive? *)
      (* We might run out of cached dcs also *)
       
      fun make_gp (name,title,widget) = 
          GP {window = widget,
              dcref = ref NONE,
              name = LabelStrings.get_title name,
              title = title,
              x_offset = ref 0,
              y_offset = ref 0}

      (* Windoze doesn't return quite the information X does *)
      (* Maybe we can do better *)
      fun text_extent (gp,string) =
        let
          val dc = gp_dc gp
          val (width,height) = WindowsGui.getTextExtentPoint (dc,string)
        in
          {ascent=0,
           descent=height,
           font_ascent=0,
           font_descent=height,
           lbearing=0,
           rbearing=0,
           width=width}
        end

      fun draw_line (gp,POINT{x,y},POINT{x=x',y=y'}) =
        let
          val GP {x_offset,y_offset,...} = gp
          val xo = !x_offset
          val yo = !y_offset
          val dc = gp_dc gp
        in
          WindowsGui.moveTo (dc,x-xo,y-yo,WindowsGui.nullWord);
          WindowsGui.lineTo (dc,x'-xo,y'-yo)
        end

      fun draw_point (gp,point) =
        draw_line (gp,point,point)

      fun draw_rectangle (gp,REGION{x,y,width,height}) =
        let
          val GP {x_offset,y_offset,...} = gp
          val xo = !x_offset
          val yo = !y_offset
          val dc = gp_dc gp
        in
          WindowsGui.moveTo (dc,x-xo,y-yo,WindowsGui.nullWord);
          WindowsGui.lineTo (dc,x+width-xo,y-yo);
          WindowsGui.lineTo (dc,x+width-xo,y+height-yo);
          WindowsGui.lineTo (dc,x-xo,y+height-yo);
          WindowsGui.lineTo (dc,x-xo,y-yo)
        end

      fun object_from_brush (WindowsGui.HBRUSH brush) =
        WindowsGui.OBJECT brush

      fun fill_rectangle (gp,region as REGION{x,y,width,height}) =
        let
          val dc = gp_dc gp
          val GP {x_offset,y_offset,...} = gp
          val xo = !x_offset
          val yo = !y_offset
          val brush = WindowsGui.createSolidBrush (WindowsGui.getSysColor (WindowsGui.COLOR_WINDOWTEXT))
        in
          WindowsGui.fillRect (dc,
                            WindowsGui.RECT {left = x-xo,
                                          top = y-yo,
                                          right = x+width-xo,
                                          bottom = y+height-yo},
                            brush);
          WindowsGui.deleteObject (object_from_brush brush)
        end

      fun clear_rectangle (gp,region as REGION{x,y,width,height}) =
        let
          val dc = gp_dc gp
          val GP {x_offset,y_offset,...} = gp
          val xo = !x_offset
          val yo = !y_offset
          val brush = WindowsGui.createSolidBrush (WindowsGui.getSysColor (WindowsGui.COLOR_WINDOW))
        in
          WindowsGui.fillRect (dc,
                            WindowsGui.RECT {left = x-xo,
                                          top = y-yo,
                                          right = x+width-xo,
                                          bottom = y+height-yo},
                            brush);
          WindowsGui.deleteObject (object_from_brush brush)
        end

      (* This should probably draw a filled rectangle in the appropriate place also *)
      fun draw_image_string (gp,string,POINT{x,y}) =
        let
          val dc = gp_dc gp
          val GP {x_offset,y_offset,...} = gp
          val xo = !x_offset
          val yo = !y_offset
        in
          WindowsGui.textOut (dc,x-xo,y-yo,string)
        end
        
      fun draw_arc (gp,REGION{x,y,width,height},theta1,theta2) = 
        () (* Currently unimplemented *)

      fun make_graphics (name,title,draw,get_extents,
                         (want_hscroll, want_vscroll), parent) =
        let  
          val styles =
            [WindowsGui.WS_CHILD,WindowsGui.WS_BORDER] @
            (if want_hscroll then [WindowsGui.WS_HSCROLL] else []) @
            (if want_vscroll then [WindowsGui.WS_VSCROLL] else [])
          val window =
            create_revealed {class = "Frame",
                             name = LabelStrings.get_title name,
                             width = default_width,
                             height = graphics_height,
                             parent = CapiTypes.get_real parent,
                             menu = WindowsGui.nullWord,
                             styles = styles}
          val widget = CapiTypes.REAL (window,parent)
          val gp = make_gp (name,title,widget)

          (* This (sort of) sets the scrollbar extents of the widget *)
          fun set_scrollbars () =
            let
              val (x,y) = get_extents ()
              val (w,h) = widget_size widget
            in
              (* This should change the position to be in the range, if necessary *)
              if want_hscroll
                then WindowsGui.setScrollRange (window,WindowsGui.SB_HORZ,0,max (0,x-w),true)
              else ();
              if want_vscroll
                then WindowsGui.setScrollRange (window,WindowsGui.SB_VERT,0,max (0,y-h),true)
              else ()
            end

          (* The handler for a WM_PAINT event *)
          fun draw_handler _ =
            (WindowsGui.validateRect (window,NONE);
             ignore(with_graphics gp draw (gp,REGION {x=0,y=0,width=1000,height=1000}));
             SOME WindowsGui.nullWord)

          (* increments for line up/down and line left/right *)
          val hinc = 20
          val vinc = 20

          (* page increments are the current width/height of the window *)

          fun getx () = #1 (widget_size widget)
          fun gety () = #2 (widget_size widget)

          (* two scroll handlers *)
          (* we ought to be able to use get_scroll_pos to find the position *)
          (* but this didn't seem to work *)
          fun vscroll_handler (WindowsGui.WPARAM wparam, WindowsGui.LPARAM lparam) =
            let
              val code = WindowsGui.loword wparam
              val GP {y_offset,...} = gp
              fun dochange pos =
                let
                  val pos = max (0, min (#2 (get_extents ()) - gety(), pos))
                in
                  WindowsGui.setScrollPos (window,WindowsGui.SB_VERT,pos,true);
                  y_offset := pos;
                  (* redraw the whole lot on scrolling *)
                  redisplay gp
                end
              (* line down shouldn't go past the scroll limit *)
              val _ = 
                if code = WindowsGui.convertSbValue WindowsGui.SB_THUMBPOSITION
                  then dochange (WindowsGui.hiword wparam)
                else if code = WindowsGui.convertSbValue WindowsGui.SB_LINEUP
                  then dochange (!y_offset - vinc)
                else if code = WindowsGui.convertSbValue WindowsGui.SB_LINEDOWN
                  then dochange (!y_offset + vinc)
                else if code = WindowsGui.convertSbValue WindowsGui.SB_PAGEUP
                  then dochange (!y_offset - gety ())
                else if code = WindowsGui.convertSbValue WindowsGui.SB_PAGEDOWN
                  then dochange (!y_offset + gety ())
                else ()
            in
              SOME WindowsGui.nullWord
            end

          fun hscroll_handler (WindowsGui.WPARAM wparam, WindowsGui.LPARAM lparam) =
            let
              val code = WindowsGui.loword wparam
              val GP {x_offset,...} = gp
              fun dochange pos =
                let
                  val pos = max (0, min (#1 (get_extents ()) - getx(), pos))
                in
                  WindowsGui.setScrollPos (window,WindowsGui.SB_HORZ,pos,true);
                  x_offset := pos;
                  (* redraw the whole lot on scrolling *)
                  redisplay gp
                end
              val _ = 
                if code = WindowsGui.convertSbValue WindowsGui.SB_THUMBPOSITION
                  then dochange (WindowsGui.hiword wparam)
                else if code = WindowsGui.convertSbValue WindowsGui.SB_LINELEFT 
                  then dochange (!x_offset - hinc)
                else if code = WindowsGui.convertSbValue WindowsGui.SB_LINERIGHT
                  then dochange (!x_offset + hinc)
                else if code = WindowsGui.convertSbValue WindowsGui.SB_PAGELEFT 
                  then dochange (!x_offset - getx())
                else if code = WindowsGui.convertSbValue WindowsGui.SB_PAGERIGHT
                  then dochange (!x_offset + getx())
                else ()
            in
              SOME WindowsGui.nullWord
            end

          (* But not do a redisplay *)
          fun set_position (POINT{x=xi',y=yi'}) = 
            let
              val POINT{x=cur_xi,y=cur_yi}  = get_offset gp

              val xi = if (xi' < 0) then cur_xi else xi'
              val yi = if (yi' < 0) then cur_yi else yi'

              val (ww,wh) = widget_size widget
              val (xextent,yextent) = get_extents()
              val new_xi = max (min (xi,xextent-ww),0)
              val new_yi = max (min (yi,yextent-wh),0)
            in
              if want_hscroll 
                then WindowsGui.setScrollPos (window,WindowsGui.SB_HORZ,new_xi,true) 
              else ();
              if want_vscroll 
                then WindowsGui.setScrollPos (window,WindowsGui.SB_VERT,new_yi,true) 
              else ();
              set_offset (gp,POINT{x=new_xi,y=new_yi});
              redisplay gp
            end

          fun resize_function data = 
            let
              val (ww,wh) = widget_size widget
              val (xextent,yextent) = get_extents()
              val POINT{x=xi,y=yi}  = get_offset gp
              val new_xi = max (min (xi,xextent-ww),0)
              val new_yi = max (min (yi,yextent-wh),0)
            in
              set_offset (gp,POINT{x=new_xi,y=new_yi});
              set_scrollbars ()
            end
        in
          WindowsGui.addMessageHandler (window,WindowsGui.WM_PAINT,draw_handler);
          if want_vscroll 
            then WindowsGui.addMessageHandler (window,WindowsGui.WM_VSCROLL,vscroll_handler) 
          else ();
          if want_hscroll 
            then WindowsGui.addMessageHandler (window,WindowsGui.WM_HSCROLL,hscroll_handler) 
          else ();
          WindowsGui.addMessageHandler (window,WindowsGui.WM_SIZE,
                                     fn _ => 
                                     (resize_function ();
                                      SOME WindowsGui.nullWord));
          set_scrollbars();
          (widget,
           gp,
           fn _ => (resize_function () ;redisplay gp),
           set_position)
        end

      (* the Point value is in gp coordinates *)
      fun add_input_handler (gp,handler) =
        let
          val GP {window,x_offset,y_offset,...} = gp
          val window = CapiTypes.get_real window
          fun mouse_handler button (WindowsGui.WPARAM wparam,WindowsGui.LPARAM lparam) =
            let
              val x = WindowsGui.loword lparam
              val y = WindowsGui.hiword lparam
            in
              ignore(handler (button,POINT {x=x + !x_offset,y=y + !y_offset}));
              SOME WindowsGui.nullWord
            end
        in
          WindowsGui.addMessageHandler (window,WindowsGui.WM_LBUTTONDOWN,mouse_handler (Event.LEFT));
          WindowsGui.addMessageHandler (window,WindowsGui.WM_RBUTTONDOWN,mouse_handler (Event.RIGHT))
        end          
          
      type PixMap = unit

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

      val getAttributes : GraphicsPort * Request list -> Attribute list =
	  fn(_,_) => (dummy "getAttributes"; [])

      val setAttributes : GraphicsPort * Attribute list -> unit =
          fn(_,_) => (dummy "setAttributes"; ())
 
      val with_graphics_port :(GraphicsPort * ('a -> 'b) * 'a) -> 'b =
          fn(_,f,a) => (dummy "with_graphics_port"; f(a))

    end

  fun parent CapiTypes.NONE = CapiTypes.NONE
    | parent (CapiTypes.REAL (_,p)) = p
    | parent (CapiTypes.FAKE (p,_)) = p

  val reveal = reveal o CapiTypes.get_real

  val terminator = "\r\n"

  (* dummy function - used only on Unix *)
  fun register_interrupt_widget w = ()

  fun with_window_updates f =
    let 
	fun toggle_updates tf = (MLWorks.Internal.Runtime.environment 
		"nt ml window updates toggle") tf
	val start_it = 	toggle_updates true
	val result = f () handle exn => (ignore(toggle_updates false); raise exn)
    in
       (ignore(toggle_updates false);
	result)
    end

end
