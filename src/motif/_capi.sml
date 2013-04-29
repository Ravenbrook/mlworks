(*  ==== CAPI IMPLEMENTATION : X/MOTIF  ====
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
 * $Log: _capi.sml,v $
 * Revision 1.108  1999/05/13 13:59:01  daveb
 * [Bug #190553]
 * Replaced use of basis/exit with utils/mlworks_exit.
 *
 * Revision 1.107  1999/03/19  10:27:56  mitchell
 * [Bug #190512]
 * Suppress countdown on splash screen advert
 *
 * Revision 1.106  1999/03/09  16:01:04  mitchell
 * [Bug #190509]
 * Update version strings to 2.1
 *
 * Revision 1.105  1999/03/09  12:36:41  mitchell
 * [Bug #190512]
 * Display Professional advert when starting Personal Edition
 *
 * Revision 1.104  1998/07/30  16:30:00  jkbrook
 * [Bug #30456]
 * Update version to 2.0c0
 *
 * Revision 1.103  1998/07/17  14:59:23  jkbrook
 * [Bug #30436]
 * PERSONAL replaces FREE and STUDENT editions
 *
 * Revision 1.102  1998/07/15  11:10:09  jkbrook
 * [Bug #30435]
 * Remove license-prompting code
 *
 * Revision 1.101  1998/07/02  14:34:47  johnh
 * [Bug #30431]
 * Extend Capi by adding more window attributes to change.
 *
 * Revision 1.100  1998/06/24  14:52:36  johnh
 * [Bug #30433]
 * Use new splash screen.
 *
 * Revision 1.99  1998/06/24  13:21:12  johnh
 * [Bug #30411]
 * Fix problems checking edition and setting time out of spalsh screen.
 *
 * Revision 1.98  1998/06/15  15:24:14  johnh
 * [Bug #30411]
 * Fix path problem in finding splash screen.
 *
 * Revision 1.97  1998/06/12  11:19:37  jkbrook
 * [Bug #30415]
 * Update version info for 2.0b2
 *
 * Revision 1.96  1998/06/11  18:21:30  jkbrook
 * [Bug #30411]
 * Include Free edition
 *
 * Revision 1.95  1998/06/11  15:20:34  johnh
 * [Bug #30411]
 * Add support for free edition splash screen.
 *
 * Revision 1.94  1998/05/15  10:48:44  johnh
 * [Bug #30384]
 * Make sure cancel button is visible on yesno dialog.
 *
 * Revision 1.93  1998/05/14  11:30:09  johnh
 * [Bug #50072]
 * Disable positioning of windows.
 *
 * Revision 1.92  1998/04/01  12:16:42  johnh
 * [Bug #30346]
 * Add Capi.getNextWindowPos().
 *
 * Revision 1.91  1998/03/26  11:38:48  johnh
 * [Bug #50035]
 * Keyboard accelerators now platform specific.
 *
 * Revision 1.90  1998/02/19  11:01:55  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.89  1998/02/17  17:36:24  johnh
 * [Bug #30344]
 * Allow windows to retain size and position.
 *
 * Revision 1.88  1998/01/27  16:47:26  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.87  1997/11/06  13:00:20  johnh
 * [Bug #30125]
 * Move implementation of send_message to Menus.
 *
 * Revision 1.86  1997/10/06  10:40:17  johnh
 * [Bug #30137]
 * Add make_messages_popup.
 *
 * Revision 1.85.2.4  1998/01/09  11:11:10  johnh
 * [Bug #30071]
 * Add Callback.VALUE_CHANGED.
 *
 * Revision 1.85.2.3  1997/11/19  13:28:58  johnh
 * [Bug #30071]
 * Set popup shell attribute DELETE_RESPONSE to DESTROY.
 *
 * Revision 1.85.2.2  1997/09/12  14:44:13  johnh
 * [Bug #30071]
 * Implement new Project Workspace tool.
 *
 * Revision 1.85  1997/09/05  11:12:44  johnh
 * [Bug #30241]
 * Implementing proper Find Dialog.
 *
 * Revision 1.84  1997/08/06  14:52:25  brucem
 * [Bug #30202]
 * Change utils.lists to basis.list.  Fix bug in GraphicsPort.setAttributes.
 * Added function makeYesNo.  Changed implementation of GraphicsPort.clear_rectangle.
 *
 * Revision 1.83  1997/07/23  14:25:44  johnh
 * [Bug #30182]
 * Add dummy add_del_handler function - used only on Win32.
 *
 * Revision 1.82  1997/07/18  09:46:24  johnh
 * [Bug #20074]
 * Improve license dialog.
 *
 * Revision 1.81  1997/06/18  08:27:35  johnh
 * [Bug #30181]
 * Tidy interrupt button code.
 *
 * Revision 1.80  1997/06/16  14:04:38  johnh
 * [Bug #30174]
 * Set application title from resource file - not here.
 *
 * Revision 1.79  1997/06/13  09:50:50  johnh
 * [Bug #30175]
 * Add all windows to dynamic menu, except top level tools.
 *
 * Revision 1.78  1997/05/20  15:57:11  johnh
 * Adding make_interrupt_button.
 *
 * Revision 1.77  1997/05/19  11:29:29  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.76  1997/05/13  16:28:11  johnh
 * Re-organising menus for Motif.
 *
 * Revision 1.75  1997/05/09  11:22:21  daveb
 * [Bug #30020]
 * Added call to Xm.checkMLWorksResources.
 *
 * Revision 1.74  1997/05/02  17:22:18  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.73  1997/03/17  14:41:34  johnh
 * [Bug #1954]
 * Added dummy function set_min_window_size.
 *
 * Revision 1.72  1997/03/06  17:50:06  daveb
 * [Bug #1083]
 * Changed make_main_popup to use Xm.createPopupShell.
 *
 * Revision 1.71  1996/12/11  16:40:34  daveb
 * Fixed license dialog to work correctly on Irix 5.3.
 *
 * Revision 1.70  1996/11/21  12:25:17  jont
 * [Bug #1799]
 * Modify check_insertion to return its string argument
 * This is for compatibility with windows
 *
 * Revision 1.69  1996/11/15  15:28:42  daveb
 * Added dummy function for splash sreen which is implemented on Windows.
 *
 * Revision 1.68  1996/11/12  11:44:52  daveb
 * Added license_prompt and license_complain.
 *
 * Revision 1.66  1996/11/06  11:17:18  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.65  1996/11/04  12:55:22  daveb
 * [Bug #1699]
 * Type of Xm.GC.copy has changed.
 *
 * Revision 1.64  1996/11/01  17:42:55  daveb
 * [Bug #1694]
 * Removed Xm.widget_eq and converted Xm.CompoundString.string_convert_text
 * to standard identifier convention.
 *
 * Revision 1.63  1996/11/01  13:50:07  johnh
 * Enabling close from control box on top left of window.
 *
 * Revision 1.62  1996/10/31  10:21:15  johnh
 * Add interrupt button to Windows.
 *
 * Revision 1.61  1996/10/09  15:43:31  io
 * moving String from toplevel
 *
 * Revision 1.60  1996/09/23  14:03:37  matthew
 * Attempting to add a interrupt button handler thing
 *
 * Revision 1.59  1996/09/19  13:06:04  johnh
 * [Bug #1583]
 * passing has_controlling_tty to exit_mlworks instead of passing false.
 *
 * Revision 1.58  1996/08/14  11:46:34  daveb
 * [Bug #1539]
 * Restored the destroy callback for make_main_window.  This removes a destroyed
 * window from the list of windows.
 *
 * Revision 1.57  1996/08/06  16:41:43  daveb
 * [Bug #1517]
 * Changed definition of Text.end_line to return the current position if it
 * is already at the end of a line.
 *
 * Revision 1.56  1996/07/30  14:37:56  jont
 * Provide a system dependent line terminator
 *
 * Revision 1.55  1996/07/29  09:24:48  daveb
 * [Bug #1478]
 * Set DELETE_RESPONSE of top level tools to do_nothing, and those of popups
 * to unmap.  This prevents users from deleting stack browsers or their parent
 * windows in the middle of an evaluation.
 *
 * Revision 1.54  1996/07/05  14:41:36  daveb
 * [Bug #1260]
 * Changed the Capi layout datatype so that the PANED constructor takes the
 * layout info for its sub-panes.  This enables the Windows layout code to
 * calculate the minimum size of each window.
 *
 * Revision 1.53  1996/07/04  09:28:11  daveb
 * Bug 1378: The Windows menu needs to be cleared when entering or leaving the
 * GUI.  I've changed initialize_application to clear the list of main windows.
 *
 * Revision 1.52  1996/05/31  16:16:04  daveb
 * Bug 1074: Capi.list_select now takes a function to be called on any key
 * press handled by the list widget itself.  In the listener, this pops the
 * completions widget down as if the key had been typed at the listener.
 *
 * Revision 1.51  1996/05/28  13:04:20  matthew
 * Adding reset function
 *
 * Revision 1.50  1996/05/28  09:39:47  daveb
 * Removed unused debugging code (that referenced MLWorks.RawIO).
 *
 * Revision 1.49  1996/05/24  10:30:24  daveb
 * Changed highlight mode used in text widgets to reverse video.
 *
 * Revision 1.48  1996/05/16  11:00:01  matthew
 * Adding Text.convert_text
 *
 * Revision 1.47  1996/05/09  14:27:34  daveb
 * Made read_only_before_prompt true.
 *
 * Revision 1.46  1996/05/01  10:38:59  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.45  1996/04/30  09:58:03  matthew
 * Use basis integer stuff
 *
 * Revision 1.44  1996/04/18  15:00:51  daveb
 * Improved the scrolling behaviour of set_highlight.
 *
 * Revision 1.43  1996/04/18  10:26:39  matthew
 * Adding initialize_graphics and finalize_graphics functions
 *
 * Revision 1.42  1996/03/15  10:25:51  daveb
 * add_items wasn't handling empty lists correctly.
 *
 * Revision 1.41  1996/03/12  10:54:31  matthew
 * Position completion windows not to be under pointer
 *
 * Revision 1.40  1996/02/26  15:25:56  matthew
 * Revisions to Xm library
 *
 * Revision 1.39  1996/02/09  11:28:33  daveb
 * Changed return type of make_scrolllist to a record, with an extra element
 * add_items.  Replaced set_bottom_pos with set_pos (which can be implemented
 * on windows).  Added add_items to the List structure.
 *
 * Revision 1.38  1996/01/31  17:23:49  matthew
 * Adding clear_rectangle again
 *
 * Revision 1.37  1996/01/25  17:10:54  matthew
 * Adding set_selection for text widgets
 *
 * Revision 1.36  1996/01/15  09:40:18  matthew
 * Fixing bungle in last change
 *
 * Revision 1.35  1996/01/12  16:13:16  matthew
 * Adding check_insertion to Text structure
 *
 * Revision 1.34  1996/01/12  12:16:48  daveb
 * Moved file_dialog from gui to motif.
 *
 * Revision 1.33  1996/01/10  14:00:21  daveb
 * Moved definitions of open_file_dialog and save_as_dialog to FileDialog.
 *
 * Revision 1.32  1996/01/10  12:33:51  daveb
 * Replaced find_file with save_as_dialog and open_file_dialog, for Windows.
 *
 * Revision 1.31  1996/01/09  13:55:28  matthew
 * Moving list_select to capi
 *
 * Revision 1.30  1996/01/05  14:57:46  matthew
 * Extra stuff for finding fonts
 *
 * Revision 1.29  1995/12/13  10:15:59  daveb
 * FileDialog now includes a datatype that also needs to be included here.
 *
 * Revision 1.28  1995/12/07  14:06:32  matthew
 * Changing interface to clipboard functions
 *
 * Revision 1.27  1995/11/29  14:52:31  matthew
 * Setting right volume for bell.
 *
 * Revision 1.26  1995/11/21  14:44:26  matthew
 * Adding dummy transfer focus function
 *
 * Revision 1.25  1995/11/17  11:16:58  matthew
 * Adding some stuff for listeners
 *
 * Revision 1.24  1995/11/15  15:18:12  matthew
 * Windows menu
 *
 * Revision 1.23  1995/11/14  14:52:20  matthew
 * Adding add_input_handler
 *
 * Revision 1.22  1995/10/26  16:12:22  daveb
 * Added width resource in make_subwindow.
 *
 * Revision 1.21  1995/10/17  10:27:48  nickb
 * Fix brain-dead X behaviour on filled rectangles.
 *
 * Revision 1.20  1995/10/10  12:18:25  nickb
 * Add Resize callback.
 *
 * Revision 1.19  1995/10/08  23:31:30  brianm
 * Modifying protocol for make_graphics set_position function - negative
 * coordinates signify no change.
 *
 * Revision 1.18  1995/10/05  15:49:22  brianm
 * Providing user-controlled graphics positioning.
 *
 * Revision 1.17  1995/10/05  10:17:26  brianm
 * Minor modification ...
 *
 * Revision 1.16  1995/10/04  12:09:03  brianm
 * Removing fix for scrolling increment in graphics - this has been fixed in
 * the app-defaults files (i.e. the proper place).
 *
 * Revision 1.15  1995/10/04  10:56:13  brianm
 * Improved scrolling in graphics objects (e.g. graph widget)
 *
 * Revision 1.14  1995/09/27  15:40:43  brianm
 * Adding `with_graphics_port' and related facilities.
 *
 * Revision 1.13  1995/09/22  11:11:51  daveb
 * Added Capi.Text.set_highlight.
 *
 * Revision 1.12  1995/09/21  15:55:40  nickb
 * Make scroll bars on graphics ports optional.
 *
 * Revision 1.11  1995/09/18  13:22:19  brianm
 * Updating by adding Capi Point/Region datatypes.
 *
 * Revision 1.10  1995/09/11  13:23:24  matthew
 * Changing top level window initialization
 *
 * Revision 1.9  1995/09/04  15:13:33  matthew
 * Adding make_message_text
 *
 * Revision 1.8  1995/08/30  13:19:45  matthew
 * Updating for windows stuff
 *
 * Revision 1.7  1995/08/25  11:21:33  matthew
 * Updating for Windows changes
 *
 * Revision 1.6  1995/08/15  15:07:20  matthew
 * Removing PushButton class
 *
 * Revision 1.5  1995/08/14  10:44:12  matthew
 * make_main_subwindows shouldn't manage the form.
 *
 * Revision 1.4  1995/08/10  12:26:01  matthew
 * Modifications for PC port
 *
 * Revision 1.3  1995/08/02  15:56:48  matthew
 * Adding event handler stuff
 *
 * Revision 1.2  1995/07/27  11:05:35  matthew
 * Moved capi to gui
 *
 * Revision 1.1  1995/07/26  14:01:03  matthew
 * new unit
 * New unit
 *
 *  Revision 1.6  1995/07/26  13:19:17  matthew
 *  Adding support for font dimensions etc.
 *
 *  Revision 1.5  1995/07/18  09:13:46  matthew
 *  Removing real constant for pi so we can compile in a lambda
 *
 *  Revision 1.4  1995/07/14  14:41:01  matthew
 *  Adding new stuff, including preliminary graphics ports
 *
 *  Revision 1.3  1995/07/07  15:21:55  daveb
 *  Minor changes to paned windows.
 *
 *  Revision 1.2  1995/07/04  14:50:57  matthew
 *  More stuff
 *
 *  Revision 1.1  1995/06/29  15:57:06  matthew
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


require "../basis/__int";
require "../basis/__os";
require "../basis/__command_line";

require "xm";
require "file_dialog";
require "^.gui.menus";
require "^.utils.crash";
require "^.utils.lists";
require "^.basis.__list";
require "^.utils.lisp";
require "^.utils.getenv";
require "^.main.version";

require "^.gui.capi";

functor Capi (structure Xm: XM 
              structure FileDialog : FILE_DIALOG
              structure Menus : MENUS
              structure Crash : CRASH
              structure Lists : LISTS
              structure LispUtils : LISP_UTILS
	      structure Getenv : GETENV
	      structure Version : VERSION
              sharing type Xm.widget = FileDialog.Widget = Menus.Widget
                ): CAPI =
struct

  structure BasisList = List (* having a List structure in this 
                                would otherwise prevent us from
                                using the basis. *)

  (* Some things are now pulled directly out from the runtime *)
  val cast = MLWorks.Internal.Value.cast
  fun env s = cast (MLWorks.Internal.Runtime.environment s)

  val N = Int.toString

  datatype Point = POINT of { x : int, y : int }

  val origin = POINT{x=0,y=0}

  datatype Region = REGION of { x : int, y :int, width : int, height :int }

  type Widget = Xm.widget
  type Font = Xm.font

  (* This exn can be raised when an inner event loop is terminated *)
  exception SubLoopTerminated = Xm.SubLoopTerminated
  exception WindowSystemError = Xm.XSystemError

  val sep_size = 10

  val main_windows : (Widget * string) list ref = ref []

  fun push (a,r) = r := a :: !r

  fun delete (a:Widget,[]) = []
    | delete (a,((item as (a',_))::rest)) =
    if a = a' then delete (a,rest) else item::delete (a,rest)

  fun add_main_window (w, title) = push ((w, title), main_windows)
  fun remove_main_window w = main_windows := delete (w,!main_windows)

  fun get_main_windows _ = !main_windows

  fun restart () =
    main_windows := []

  val next_window = ref (100,100)

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

  fun initialize_application (name, title, has_controlling_tty) =
    let
      val applicationShell =
        Xm.initialize (name, title, [(Xm.ICON_NAME, Xm.STRING title)])
    in
      push ((applicationShell, title), main_windows);
      ignore(Xm.checkMLWorksResources ());
      restart ();
      applicationShell
    end

  datatype WidgetAttribute = 
      PanedMargin of bool
    | Position of    int * int
    | Size of        int * int
    | ReadOnly of    bool

  datatype WidgetClass = Frame | Graphics | Label | Button | Text | RowColumn | Paned | Form
    
  fun convert_widget_class class =
    case class of
      Frame => (Xm.Widget.FRAME,[])
    | Graphics => (Xm.Widget.DRAWING_AREA,[])
    | Label => (Xm.Widget.LABEL_GADGET,[])
    | Button => (Xm.Widget.PUSH_BUTTON,[])
    | Text => (Xm.Widget.TEXT,[])
    | RowColumn => (Xm.Widget.ROW_COLUMN,[])
    | Paned => (Xm.Widget.PANED_WINDOW, [(Xm.SPACING, Xm.INT 20)])
    | Form => (Xm.Widget.FORM,[])

  fun convert_widget_attributes (PanedMargin true) =
      [(Xm.MARGIN_WIDTH, Xm.INT sep_size)]
    | convert_widget_attributes (PanedMargin false) =
      [(Xm.MARGIN_WIDTH, Xm.INT 0)]
    | convert_widget_attributes (Position (x,y)) = 
      [(Xm.X, Xm.INT x), (Xm.Y, Xm.INT y)]
    | convert_widget_attributes (Size (w,h)) = 
      [(Xm.WIDTH, Xm.INT w), (Xm.HEIGHT, Xm.INT h)]
    | convert_widget_attributes (ReadOnly tf) = 
      [(Xm.EDITABLE, Xm.BOOL (not tf))]

  fun setAttribute (widg, attrib) = 
    Xm.Widget.valuesSet (widg, convert_widget_attributes attrib)

  fun make_widget (name,class,parent,attributes) =
    let
      val (xm_class, fixed_attributes) = convert_widget_class class 
      val parameter_attributes = 
	foldl (op @) [] (map convert_widget_attributes attributes)
    in
      Xm.Widget.create
	(name, xm_class, parent,
	 fixed_attributes @ parameter_attributes)
    end

  fun make_managed_widget (name,class,parent,attributes) =
    let
      val (xm_class, fixed_attributes) = convert_widget_class class 
      val parameter_attributes = 
	foldl (op @) [] (map convert_widget_attributes attributes)
    in
      Xm.Widget.createManaged
	(name, xm_class, parent,
	 fixed_attributes @ parameter_attributes)
    end

  (* Utility functions for creating the main window of a tool *)

  fun make_main_subwindows (parent,has_context_label) =
    let
      val mainWindow =
        Xm.Widget.create ("main",
                          Xm.Widget.FORM,
                          parent, [])
      val menuBar =
        Xm.Widget.createManaged
        ("menuBar", Xm.Widget.ROW_COLUMN, mainWindow, [])

      val contextLabel =
        if has_context_label then
          SOME
          (Xm.Widget.createManaged
           ("contextLabel", Xm.Widget.LABEL,mainWindow,
            []))
        else
          NONE
    in
      (mainWindow,menuBar,contextLabel)
    end

  fun make_subwindow parent =
    Xm.Widget.create ("main",
                      Xm.Widget.FORM,
                      parent, [(Xm.WIDTH, Xm.INT 300)])

  (* N.B. pos argument ignored as this would interfere with some window managers *)
  fun make_main_window {name, title, parent, contextLabel, winMenu, pos: int * int} =
    let
      val shell =
        Xm.Widget.create
	  (name ^ "Shell",
           Xm.Widget.TOP_LEVEL_SHELL,
           parent,
           [(Xm.TITLE, Xm.STRING title),
            (Xm.ICON_NAME, Xm.STRING title),
	    (Xm.DELETE_RESPONSE, Xm.DELETE_RESPONSE_VALUE Xm.DO_NOTHING)])
      (* Set the deleteResponse attribute to do_nothing.  This prevents
	 users from killing the tool.  If they did this in the middle of
	 an evaluation, it could cause problems. *)

      val (main,menu,label) = make_main_subwindows (shell, contextLabel)
    in
      (* The windows contained in the tools menu do not need to be added to the 
       * dynamic list of windows, but other windows are created by this function,
       * so a distinction is needed.
       *)
      if winMenu then 
	push((shell, title), main_windows) 
      else ();
      Xm.Callback.add
	(shell, Xm.Callback.DESTROY, fn _ => remove_main_window shell);
      Xm.Widget.manage main;
      (shell,main,menu,label)
    end

  (* pos argument ignored as this interferes with some window managers. *)
  fun make_main_popup {name, title, parent, contextLabel, visibleRef, pos: int * int} =
    let
      val shell =
	Xm.Widget.createPopupShell
	  (name ^ "Shell",
           Xm.Widget.DIALOG_SHELL,
           parent,
           [(Xm.TITLE, Xm.STRING title),
            (Xm.ICON_NAME, Xm.STRING title),
	    (Xm.DELETE_RESPONSE, Xm.DELETE_RESPONSE_VALUE Xm.UNMAP)])
      (* Set the deleteResponse attribute to unmap, so that users cannot
	 destroy the window. *)

      val (main,menu,label) = make_main_subwindows (shell,contextLabel)
    in
      (* If the window is initially hidden (eg. stack browser) then don't 
       * add the window name to the windows menu - this will be done when 
       * is brought up.
       *)
      if (!visibleRef) then 
	push ((shell, title), main_windows) 
      else ();
      (shell,main,menu,label)
    end

  fun make_messages_popup (parent, visible) = 
    make_main_popup {name = "messages", 
		     title = "System Messages", 
		     parent = parent, 
		     contextLabel = false, 
		     visibleRef = visible,
		     pos = getNextWindowPos()}

  fun make_popup_shell (name,parent,attributes,visible) =
    let 
      val parameter_attributes = 
	foldl (op @) [] (map convert_widget_attributes attributes)
    in
      Xm.Widget.createPopupShell 
	(name,
         Xm.Widget.DIALOG_SHELL,
         parent, 
	 [(Xm.DELETE_RESPONSE, Xm.DELETE_RESPONSE_VALUE Xm.DESTROY)] @ 
	   parameter_attributes)
    end

  fun make_toplevel_shell (name,title,parent,attributes) =
    let 
      val parameter_attributes = 
	foldl (op @) [] (map convert_widget_attributes attributes)
    in
      Xm.Widget.create (name,
                        Xm.Widget.TOP_LEVEL_SHELL,
                        parent,
                        [(Xm.TITLE, Xm.STRING title),
                         (Xm.ICON_NAME, Xm.STRING title)] @ 
			parameter_attributes)
    end

  fun make_scrolled_text (name,parent,attributes) =
    let
      val parameter_attributes = 
	foldl (op @) [] (map convert_widget_attributes attributes)
      val text =
        Xm.Widget.createScrolledText (parent, name, parameter_attributes)
    in
      Xm.Widget.manage text;
      (Xm.Widget.parent text,text)
    end

(* Dummy function used in Win32 only.  To set minimum window sizes in Moitf, 
 * use the resources in app-defaults. *)
  fun set_min_window_size _ = ()

  fun make_scrolllist {parent, name, select_fn, action_fn, print_fn} =
    let
      val listScroll = Xm.Widget.createManaged("scroll",
                                               Xm.Widget.SCROLLED_WINDOW,
                                               parent,[])
      val listList =
        Xm.Widget.createManaged ("list",
                                 Xm.Widget.LIST,
                                 listScroll,
                                 [])

      val itemlistref = ref []

      fun get_selected_pos callback_data =
        let
          val (_,_,_,_,n,_,_,_,_) = Xm.Callback.convertList callback_data
        in
          n
        end

      fun set_items print_options [] =
        (itemlistref := [];
         Xm.List.deleteAllItems listList;
         Xm.List.addItems
	   (listList, [Xm.CompoundString.createSimple "<empty>"], 0))
      |   set_items print_options items =
        (itemlistref := items;
         Xm.List.deleteAllItems listList;
         Xm.List.addItems
	   (listList,
            map (Xm.CompoundString.createSimple o
		   (print_fn print_options))
		 items,
            0))

      fun add_items print_options items =
	(case !itemlistref
	 of [] =>
	   (* The list widget displays "<empty>"; we must delete this. *)
           Xm.List.deleteAllItems listList
	 |  _ => ();
         itemlistref := !itemlistref @ items;
         Xm.List.addItems
	   (listList,
            map (Xm.CompoundString.createSimple o
		   (print_fn print_options))
		items,
            0))

      val select_fn' = select_fn (listScroll, listList, set_items, add_items)
      val action_fn' = action_fn (listScroll, listList, set_items, add_items)

      fun select_callback_fn callback_data =
        let
          val pos = get_selected_pos callback_data
        in
          select_fn' (Lists.nth (pos-1,!itemlistref))
          handle Lists.Nth => ()
        end

      fun action_callback_fn callback_data =
        let
          val pos = get_selected_pos callback_data
        in
          action_fn' (Lists.nth (pos-1,!itemlistref))
          handle Lists.Nth => ()
        end
    in
      Xm.Callback.add (listList,
                             Xm.Callback.SINGLE_SELECTION,
                             select_callback_fn);
      Xm.Callback.add (listList,
                             Xm.Callback.DEFAULT_ACTION,
                             action_callback_fn);
      {scroll=listScroll, list=listList,
       set_items=set_items, add_items=add_items}
    end

  fun make_file_selection_box (name,parent,attributes) =
    let
      val box = Xm.Widget.createManaged
        (name,
         Xm.Widget.FILE_SELECTION_BOX,
         parent, [])
      val filter_text =
        Xm.FileSelectionBox.getChild(box, Xm.Child.FILTER_TEXT)

      (* This pulls the selected filename out of the file selection box *)
      fun get_file () =
        (case Xm.Widget.valuesGet(box,[Xm.DIR_SPEC]) of
           [Xm.COMPOUND_STRING filename] =>
             Xm.CompoundString.convertStringText filename
         | _ => Crash.impossible "Bad values for valuesGet (get_file)")

      fun get_directory () = Xm.Text.getString filter_text
      fun set_directory s = 
        Xm.Widget.valuesSet (box, [(Xm.DIRECTORY, Xm.COMPOUND_STRING (Xm.CompoundString.createSimple s))])
      fun set_mask s =
        (Xm.Widget.valuesSet
         (box, [(Xm.DIR_MASK, Xm.COMPOUND_STRING (Xm.CompoundString.createSimple s))]))
      fun get_mask () =
        (case Xm.Widget.valuesGet(box,[Xm.DIR_MASK]) of
           [Xm.COMPOUND_STRING mask] => mask
         | _ => Crash.impossible "Bad values for valuesGet (get_dir_mask)")
      val dir_list = Xm.FileSelectionBox.getChild(box, Xm.Child.DIR_LIST)
    in
      (* Remove the buttons *)
      app 
      (fn c =>
       Xm.Widget.unmanageChild (Xm.FileSelectionBox.getChild(box,c)))
      [Xm.Child.CANCEL_BUTTON,
       Xm.Child.OK_BUTTON,
       Xm.Child.APPLY_BUTTON,
       Xm.Child.SEPARATOR,
       Xm.Child.HELP_BUTTON];
	(* Removing the OK and APPLY buttons does interesting things to
	   the behaviour of the file selection box.  Some thing stop
	   working, so here we recreate them by hand.  *)
      Xm.Callback.add
      (dir_list,
       Xm.Callback.DEFAULT_ACTION,
       fn x => 
       let val item = #3 (Xm.Callback.convertList x)
       in
         Xm.Widget.valuesSet
         (box, [(Xm.DIRECTORY, Xm.COMPOUND_STRING item)])
       end);
      Xm.Callback.add
      (filter_text,
       Xm.Callback.ACTIVATE,
       fn _ => Xm.FileSelectionBox.doSearch (box, get_mask ()));
      (box,
       {get_file = get_file,
        set_directory = set_directory,
        get_directory = get_directory,
        set_mask = set_mask})
    end

  (* Widget functions *)
  val destroy = Xm.Widget.destroy

  val remove_menu = destroy

  fun initialize_toplevel shell= 
    (Xm.Widget.realize shell;
     Xm.Widget.map shell)

  fun initialize_application_shell shell =
    Xm.Widget.realize shell

  val reveal = Xm.Widget.manage
  val hide = Xm.Widget.unmanageChild
  val to_front = Xm.Widget.toFront

  (* This doesn't seem necessary for Motif *)
  (* perhaps it should do something though *)
  fun transfer_focus _ = ()

  fun set_sensitivity (widget,sensitivity) =
    Xm.Widget.valuesSet (widget,[(Xm.SENSITIVE, Xm.BOOL sensitivity)])

  (* set the label string of a label widget *)  
  fun set_label_string (label,s) =
    let
      val cstring = Xm.CompoundString.createSimple s
    in
      Xm.Widget.valuesSet (label, 
                           [(Xm.LABEL_STRING, Xm.COMPOUND_STRING cstring)])
    end
  
  fun set_focus w = 
    (ignore(Xm.Widget.processTraversal (w, Xm.Widget.TRAVERSE_CURRENT));
     ())

  val parent = Xm.Widget.parent

  fun widget_size widget =
    case Xm.Widget.valuesGet (widget,[Xm.WIDTH,Xm.HEIGHT]) of
      [Xm.INT width,Xm.INT height] => (width,height) 
    | _ => Crash.impossible "Capi:widget_size:bad result from valuesGet"

  fun widget_pos widget =
    case Xm.Widget.valuesGet (widget,[Xm.X,Xm.Y]) of
      [Xm.INT horz,Xm.INT vert] => (horz,vert) 
    | _ => Crash.impossible "Capi:widget_pos:bad result from valuesGet"

  val set_message_widget : Widget -> unit = env "x text set message widget"
  val no_message_widget : unit -> unit = env "x text no message widget"
  val set_busy : Widget -> unit = env "x widget set busy"
  val unset_busy : Widget -> unit = env "x widget unset busy"

  fun event_loop continue = while (!continue) do Xm.doInput ();
  fun main_loop () = Xm.mainLoop ()

  open FileDialog
  (* This defines the FileType datatype and the find_file, open_file_dialog
     and save_as_dialog functions. *)

  val send_message = Menus.send_message

  fun with_message (parent,message) f =
    let
      val _ = set_busy parent
      val result = f () 
        handle exn as Xm.SubLoopTerminated => raise exn
             | exn => (unset_busy parent; raise exn)
    in
      unset_busy parent;
      result
    end

  fun beep widget = Xm.Display.bell (Xm.Widget.display widget,0)

  structure Event = 
    struct
      type Modifier = Xm.Event.modifier
      val meta_modifier = Xm.Event.MOD1
      datatype Button = LEFT | RIGHT | OTHER
      fun get_key_data event =
        case event of
          Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key,state,...}) =>
            SOME (key, Xm.Event.convertState state)
        | _ => NONE
      fun convert_button buttondata =
        case Xm.Event.convertButton buttondata of
          Xm.Event.BUTTON1 => LEFT
        | Xm.Event.BUTTON3 => RIGHT
        | _ => OTHER
      fun get_button_data event =
        case event of
          Xm.Event.BUTTON_PRESS (Xm.Event.BUTTON_EVENT {x,y,button,...}) =>
            SOME (POINT {x=x,y=y}, convert_button button)
        | _ => NONE
      datatype EventType = KeyPress | ButtonPress | Other
      fun get_event_type event =
        case event of
          Xm.Event.KEY_PRESS _ => KeyPress
        | Xm.Event.BUTTON_PRESS _ => ButtonPress
        | _ => Other
    end

  structure Callback =
    struct
      datatype Type =
	Activate
      | Destroy
      | Unmap
      | Resize
      | ValueChange

      fun add (w,t,f) =
        let
          val xt =
            case t of
              Activate => Xm.Callback.ACTIVATE
            | Destroy => Xm.Callback.DESTROY
            | Unmap => Xm.Callback.UNMAP
	    | Resize => Xm.Callback.RESIZE
	    | ValueChange => Xm.Callback.VALUE_CHANGED
        in
          Xm.Callback.add (w,xt,fn _ => f ())
        end
      fun get_event data =
        #2 (Xm.Callback.convertAny data)
      end

(* set_close_callback not used in Motif *)
  fun set_close_callback _ = ()

  structure List =
    struct
      val get_selected_pos = Xm.List.getSelectedPos
      val select_pos = Xm.List.selectPos
      val set_pos = Xm.List.setPos
      fun add_items (w, l) = 
	Xm.List.addItems (w, map Xm.CompoundString.createSimple l, 0)
    end

  fun move_window (widget, x, y) = ()
  fun size_window (widget, w, h) = 
    Xm.Widget.valuesSet (widget, [(Xm.WIDTH, Xm.INT w),
				  (Xm.HEIGHT, Xm.INT h)])

  structure Text =
    struct
      (* add_del_handler only used on Win32 *)
      fun add_del_handler _ = ()

      (* Interface to various Xm functions *)
      (* insert str at pos in text *)
      fun insert (text,pos,str) =
        Xm.Text.insert (text,pos,str)
        
      fun replace (text,from,to,str) =
        Xm.Text.replace (text,from,to,str)
        
      (* set and get the "insertion position" *)
      fun set_insertion_position (text,pos) =
        Xm.Text.setInsertionPosition (text, pos)
        
      fun get_insertion_position text =
        Xm.Text.getInsertionPosition text
        
      (* get the "last" position *)
      fun get_last_position text =
        Xm.Text.getLastPosition text
        
      (* substring of the text contents *)
      fun substring (text,from,size) =
        let
          val str = Xm.Text.getString text
        in
          MLWorks.String.substring (str,from,size)
        end

      val get_string = Xm.Text.getString
      val set_string = Xm.Text.setString

      local
	fun showPosition (w, s) =
	  case Xm.Text.posToXY (w, s)
	  of SOME _ => ()
	  |  NONE =>
	    Xm.Text.setTopCharacter (w, s)
      in
        fun set_highlight (w, s, e, true) =
	  (Xm.Text.setHighlight (w, s, e, Xm.HIGHLIGHT_SELECTED);
	   showPosition (w, s))
        |   set_highlight (w, s, e, false) =
	  (Xm.Text.setHighlight (w, s, e, Xm.HIGHLIGHT_NORMAL);
	   showPosition (w, s))
      end

      val get_selection = Xm.Text.getSelection
      val set_selection = Xm.Text.setSelection
      val remove_selection = Xm.Text.remove

      (* some more complex utility functions *)
    
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
            val str = Xm.Text.getString text
            val length = size str
              
            fun nextline n =
              if n = length orelse MLWorks.String.ordof (str, n) = ord #"\n" then
                n
              else
                nextline (n+1)
            val start = lastline (str,pos-1)
            val finish = nextline pos
            val result = MLWorks.String.substring (str, start, finish - start)
          in
            (result,pos - start)
          end
        
        (* Returns the index of the line containing pos *)
        fun current_line (text,pos) =
          lastline (Xm.Text.getString text,pos-1)
          
        (* Returns the index of the line after the line containing pos *)
        fun end_line (text,pos) =
          let
            val str = Xm.Text.getString text
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

        fun convert_verify_data data =
          let
            val (_,_,doit,_,_,start_pos,end_pos,str) =
              Xm.Callback.convertTextVerify data
          in
            (start_pos,end_pos,str,fn b => Xm.Boolean.set (doit,b))
          end

        fun add_modify_verify (widget,f) =
          Xm.Callback.add (widget,Xm.Callback.MODIFY_VERIFY,
                                 fn data => f (convert_verify_data data))

        val cut_selection : Widget -> unit = Xm.Text.cut
        val paste_selection : Widget -> unit = Xm.Text.paste
        val delete_selection : Widget -> unit = Xm.Text.remove
        val copy_selection : Widget -> unit = Xm.Text.copy

      end

      (* nasty hack *)
      val read_only_before_prompt = true

      (* Just here for Windows *)
      fun check_insertion (text, str, current, marks) = str

          fun activate (text, handler) callback_data =
            let 
              val event = Callback.get_event callback_data
            in
              case Event.get_key_data event of
                SOME (key,modifiers) =>
                  if handler (key,modifiers)
                    then ()
                  else beep text
              | _ => beep text
            end

      fun add_handler (text,handler) =
        Xm.Callback.add (text,Xm.Callback.ACTIVATE,activate (text, handler))

      fun get_key_bindings {startOfLine, endOfLine, backwardChar, forwardChar, 
			    previousLine, nextLine, eofOrDelete, abandon,
			    deleteToEnd, newLine, delCurrentLine, checkCutSel,
			    checkPasteSel} = 
	 [("\^A", startOfLine), 
	  ("\^B", backwardChar),
	  ("\^D", eofOrDelete),
	  ("\^E", endOfLine),
	  ("\^F", forwardChar),
	  ("\^G", abandon),
	  ("\^K", deleteToEnd),
	  ("\^N", nextLine),
	  ("\^O", newLine),
	  ("\^P", previousLine),
	  ("\^U", delCurrentLine),
	  ("\^W", checkCutSel),
	  ("\^Y", checkPasteSel)]

      fun text_size s = size s
      fun convert_text s = s
    end

  structure Layout =
    struct
      datatype Class =
        MENUBAR of Widget
      | FLEX of Widget
      | FIXED of Widget
      | FILEBOX of Widget
      | PANED of Widget * (Widget * Class list) list
      | SPACE

      (* Some abbreviations. *)

      val top_none = [(Xm.TOP_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_NONE)]
      val bottom_none = [(Xm.BOTTOM_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_NONE)]
      val top_form = [(Xm.TOP_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_FORM)]
      val bottom_form = [(Xm.BOTTOM_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_FORM)]
      val lr_form = [(Xm.LEFT_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_FORM),
                     (Xm.RIGHT_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_FORM)]

      val top_offset = (Xm.TOP_OFFSET, Xm.INT sep_size)
      val bottom_offset = (Xm.BOTTOM_OFFSET, Xm.INT sep_size)
      val lr_offsets = [(Xm.LEFT_OFFSET, Xm.INT sep_size),
                        (Xm.RIGHT_OFFSET, Xm.INT sep_size)]

      (* top_widget/bottom_widget return a top/bottom attachment to the widget *)
      (* in the specified class. *)
      fun top_widget c =
        let
          fun aux w =
            [(Xm.TOP_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_WIDGET),
             (Xm.TOP_WIDGET, Xm.WIDGET w)]
        in
          case c
            of MENUBAR w => aux w
             |  FLEX w => aux w
             |  FILEBOX w => aux w
             |  FIXED w => aux w
             |  PANED (w, _) => aux w
             |  SPACE => Crash.impossible "SPACE argument to top_widget"
        end
    
      fun bottom_widget c =
        let
          fun aux w =
            [(Xm.BOTTOM_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_WIDGET),
             (Xm.BOTTOM_WIDGET, Xm.WIDGET w)]
        in
          case c
            of MENUBAR w => aux w
             |  FLEX w => aux w
             |  FILEBOX w => aux w
             |  FIXED w => aux w
             |  PANED (w, _) => aux w
             |  SPACE => Crash.impossible "SPACE argument to bottom_widget"
        end
      
  (* find_flex splits a list into those elements before the first flex 
   widget and the rest. *)
  local 
    fun find_flex' (acc, []) = (rev acc, [])
      |   find_flex' (acc, l as FLEX flex :: _) = (rev acc, l)
      |   find_flex' (acc, c :: rest) = find_flex' (c::acc, rest)
  in
    fun find_flex l = find_flex' ([], l)
  end

  (* The trim_spaces function removes duplicate and trailing SPACE specifiers.
     It returns the modified list and a boolean which is true iff there were
     trailing SPACE specifiers.
   *)
  fun trim_spaces [] = ([], false)
    |   trim_spaces [SPACE] = ([], true)
    |   trim_spaces (SPACE :: (rest as SPACE :: _)) = trim_spaces rest
    |   trim_spaces (spec :: rest) =
        let
          val (rest', b) = trim_spaces rest
        in
          (spec :: rest', b)
        end
      
  (* lay_out_one sets the constraints for an individual widget.  The left
     and right constraints depend only on the type of the widget.  The top
     and/or bottom constraints are passed as an argument.
     This now includes a recursive call to the topmost lay_out function,
     which makes all the following functions mutually recursive.
   *)
  fun lay_out_one (MENUBAR w, attach) =
    Xm.Widget.valuesSet (w, attach @ lr_form)
  |   lay_out_one (SPACE, _) =
    Crash.impossible "SPACE argument to lay_out_one"
  |   lay_out_one (PANED (w, sub_classes), attach) =
    (app lay_out (map (fn (a,b) => (a,NONE,b)) sub_classes);
     Xm.Widget.valuesSet
     (* The offset 2 is to allow room for the 3D border in the parent *)
       (w, attach @ lr_form @
           [(Xm.LEFT_OFFSET, Xm.INT 2), (Xm.RIGHT_OFFSET, Xm.INT 2)]))
  |   lay_out_one (FILEBOX w, attach) =
    (* No offsets *)
    Xm.Widget.valuesSet (w, attach @ lr_form)
  |   lay_out_one (FLEX w, attach) =
    Xm.Widget.valuesSet (w, attach @ lr_form @ lr_offsets)
  |   lay_out_one (FIXED w, attach) =
    Xm.Widget.valuesSet (w, attach @ lr_form @ lr_offsets)
        
  (* lay_out_from_top is the basic lay_out function.  It traverses a 
     (pre-processed) list of classes, calling lay_out_one with appropriate
     top/bottom attachments for each class.  It returns a top_attachment
     that can be used to tie a further widget to the last in the list. *)
  and lay_out_from_top ([], top_attach, _) =
    top_attach
    |   lay_out_from_top ([SPACE], top_attach, _) =
        Crash.impossible "final SPACE argument to lay_out_from_top"
    |   lay_out_from_top ([w], top_attach, bottom_attach) =
        (lay_out_one (w, top_attach @ bottom_attach);
         top_widget w)
    |   lay_out_from_top (SPACE :: rest, top_attach, bottom_attach) =
        lay_out_from_top (rest, top_offset :: top_attach, bottom_attach)
    |   lay_out_from_top (w :: rest, top_attach, bottom_attach) =
        (lay_out_one (w, top_attach);
         lay_out_from_top (rest, top_widget w, bottom_attach))
        
  (* lay_out_from_bottom is equivalent to lay_out_from_top, but starts at
     the bottom of the form instead of the top.  It expects its list argument
     to be already reversed. *)
  and lay_out_from_bottom ([], bottom_attach, _) =
    bottom_attach
    |   lay_out_from_bottom ([SPACE], bottom_attach, _) =
        Crash.impossible "SPACE argument to lay_out_from_bottom"
    |   lay_out_from_bottom ([w], bottom_attach, top_attach) =
        (lay_out_one (w, bottom_attach @ top_attach);
         bottom_widget w)
    |   lay_out_from_bottom (SPACE :: rest, bottom_attach, top_attach) =
        lay_out_from_bottom (rest, bottom_offset :: bottom_attach, top_attach)
    |   lay_out_from_bottom (w :: rest, bottom_attach, top_attach) =
        (lay_out_one (w, bottom_attach);
         lay_out_from_bottom (rest, bottom_widget w, top_attach))
        
  (* lay_out_simple is used for any list that doesn't contain a flex widget.
     It calls lay_out_from_top to do most of the work. *)
  and lay_out_simple [] = ()
    |   lay_out_simple l =
        let
          val (l', b) = trim_spaces l
          val bottom_attach =
            if b then bottom_offset :: bottom_form else bottom_form
        in
          ignore(lay_out_from_top (l', top_form, bottom_attach));
          ()
        end
      
  (* lay_out_flex is used for any list that includes a flex widget.  It
     divides the list into those widgets above the flex widget and those
     below, and processes these parts with lay_out_from_top and
     lay_out_from_bottom respectively.  The flex widget is then linked to
     its immediately adjoining widgets.  This ensures correct resizing of
     the flex widget.  Unfortunately this process cannot be extended to
     multiple flex widgets in Motif. *)
  and lay_out_flex (above, flex, below) =
    let
      val (above', space_above) = trim_spaces above
      val top_attach =
	lay_out_from_top (above', top_form, bottom_none)
      val top_attach' =
	if space_above then top_offset :: top_attach else top_attach
          
      val (below', space_below) = trim_spaces (rev below)
      val bottom_attach =
	lay_out_from_bottom (below', bottom_form, top_none)
      val bottom_attach' =
	if space_below then bottom_offset :: bottom_attach else bottom_attach
    in
      Xm.Widget.valuesSet
      (flex,
       top_attach' @ bottom_attach' @
       [(Xm.LEFT_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_FORM),
        (Xm.RIGHT_ATTACHMENT, Xm.ATTACHMENT Xm.ATTACH_FORM),
        (Xm.LEFT_OFFSET, Xm.INT sep_size),
        (Xm.RIGHT_OFFSET, Xm.INT sep_size)])
    end
  
  (* lay_out is the user_visible layout function.  It tests for the
     existence of a flex widget and calls the appropriate function to
     process the list. *)
  and lay_out (_,posOpt,[]) = ()
    | lay_out (_,posOpt,l) =
      let
        val (above, rest) = find_flex l
      in
        case rest 
          of [] => lay_out_simple above
           |  (FLEX flex::below) => (lay_out_flex (above, flex, below); ())
           |  _ => Crash.impossible "non-flex class returned from find_flex"
      end
    end

  fun list_select (parent, name, key_action) =
    let
      val shell = make_popup_shell (name,parent, [], ref true)
      val form = make_subwindow shell
      exception ListSelect
      val select_fn_ref = ref (fn _ => raise ListSelect)
      val print_fn_ref = ref (fn _ => raise ListSelect)

      val exited = ref false;
      fun exit _ = if !exited then () else (destroy shell; exited := true)

      val {scroll, set_items, add_items, list} =
        make_scrolllist
        {parent = form,
         name = "listSelect",
         select_fn = fn _ => fn x => (exit();(!select_fn_ref) x),
         action_fn = fn _ => fn _ => (),
         print_fn = fn _ => (!print_fn_ref)}

      val dialogButtons =
	make_managed_widget ("dialogButtons", RowColumn,form,[])

      val {update = buttons_updatefn, ...} = 
        Menus.make_buttons
        (dialogButtons,
         [Menus.PUSH ("cancel",
                      exit,
                      fn _ => true)])

      fun key_handler event_data =
        case Xm.Event.convertEvent event_data
        of Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key, ...}) =>
          if ("A" <= key andalso key <= "Z") orelse
             ("a" <= key andalso key <= "z") then
            key_action key
          else
  	    ()
        |  _ =>
  	  ()

      fun popup (items,select_fn,print_fn) =
        (select_fn_ref := select_fn;
         print_fn_ref := print_fn;
         set_items () items;
         (* This next call doesn't have any effect *)
(*
         moveit ();
*)
         reveal form;
         exit)
    in
      Layout.lay_out
        (form, NONE,
         [Layout.FLEX scroll,
          Layout.SPACE,
          Layout.FIXED dialogButtons,
          Layout.SPACE]);
      Xm.Event.addHandler
        (list, [Xm.Event.KEY_PRESS_MASK], false (* maskable events only *),
         key_handler);
      popup
    end

  local
    val ref_show_splash = ref true

    val addTimer: Widget * int * (unit -> unit) -> int = env "x add timer"
    val removeTimer: int -> unit = env "x remove timer"

    fun show_splash (applicationShell, pix_file, time, isFree) = 
      let 
	val countdown = ref time

        val splash =
	  Xm.Widget.createPopupShell
	    ("splash",
             Xm.Widget.DIALOG_SHELL,
             applicationShell,
             [(Xm.TITLE, Xm.STRING "MLWorks Splash Screen"),
	      (Xm.DELETE_RESPONSE, Xm.DELETE_RESPONSE_VALUE Xm.DO_NOTHING),
	      (Xm.ALLOW_SHELL_RESIZE, Xm.BOOL false)])

        val mainWindow =
          Xm.Widget.create ("mainform",
                            Xm.Widget.FORM,
                            splash, [])

	val cast = MLWorks.Internal.Value.cast
	val read_pixmap : Widget * string -> Xm.drawable = env "x read pixmap file"

	val runtime = 
	  let val typed_name = CommandLine.name()
	  in
	    if OS.Path.isRelative(typed_name) then
	      OS.Path.concat [OS.FileSys.getDir(), typed_name]
	    else
	      typed_name
	  end
	val start_dir = OS.Path.dir (OS.Path.mkCanonical runtime)

	val file = OS.Path.concat [start_dir, pix_file]
	val p = read_pixmap (mainWindow, file)

	val pixmap_ok = (p <> (cast 0))

	val bitmap_label = 
	  make_managed_widget ("splashLabel", Label, mainWindow, [])

        val draw_labels =
          if pix_file = "splash_advert.xpm"
          then fn () => ()
          else
            let val time_label = 
 	          make_managed_widget ("timeLabel", Label, mainWindow, [])
                val version_label =
                  make_managed_widget ("versionLabel", Label, mainWindow, [])
             in fn () => 
                  (set_label_string (time_label, 
                               "Time left: " ^ Int.toString(!countdown));
                   set_label_string (version_label, "Version 2.1"))
            end

	fun close_cb _ = 
	  (Xm.Widget.destroy splash;
	   ref_show_splash := false)

	fun timer_cb _ = 
	  if ((!countdown) = 1) then 
	    close_cb()
	  else
	    (countdown := (!countdown) - 1;
	     ignore(addTimer(mainWindow, 1000, timer_cb));
	     draw_labels())
      in
	if (pixmap_ok) then
	  (Xm.Widget.valuesSet (bitmap_label, 
				[(Xm.LABEL_TYPE, Xm.LABEL_TYPE_VALUE Xm.PIXMAP_LABEL),
				 (Xm.LABEL_PIXMAP, Xm.PIXMAP p)]);
	   draw_labels();
	   ignore(addTimer(mainWindow, 1000, timer_cb));
	   reveal mainWindow;
	   to_front splash;
	   event_loop ref_show_splash)
	else 
	   if isFree then 
	     (send_message (applicationShell, "Splash screen pixmap not found.");
	      OS.Process.terminate OS.Process.failure)
	   else
	     ()
      end (* fun show_splash *)

  in
    fun show_splash_screen applicationShell = 
          show_splash(applicationShell, "splash.xpm", 3, false) 
  end (* local *)

  structure GraphicsPorts =
    struct
      (* Graphics ports *)

      val unwind_protect = LispUtils.unwind_protect'
      fun max (x:int,y) = if x > y then x else y
      fun min (x:int,y) = if x < y then x else y

      datatype GraphicsPort = 
        GP of {widget: Xm.widget,
               name : string,
               title : string,
               display: Xm.display,
               info: {window: Xm.drawable,
                      gc: Xm.gc ref,
                      fontstruct:Xm.font_struct ref} option ref,
               x_offset: int ref,
               y_offset: int ref}
        
      fun gp_widget (GP {widget,...}) = widget

      val get_widget_resource : string * string -> Xm.font =
          env "x get application resource"

      fun initialize_gp (GP {widget,display,info,name,title,...}) =
        case !info of
          NONE =>
            let
              val window = Xm.Widget.window widget
              val display = Xm.Widget.display widget
              val (background,foreground) =
                case Xm.Widget.valuesGet (widget,[Xm.BACKGROUND,Xm.FOREGROUND]) of
                  [Xm.PIXEL background,Xm.PIXEL foreground] => 
                    (background,foreground)
                | _ => Crash.impossible "bad colour values"
              val (font,fontstruct) = 
                let
                  val font = get_widget_resource (name ^ "Font",title ^ "GPFont")                  
                in
                  (font,Xm.Font.query (display,font))
                end
              handle _ =>
                let
                  val _ = print"Using default font\n"
                  val font = Xm.Font.load (display,"fixed")
                in
                  (font,Xm.Font.query (display,font))
                end
              val gc = Xm.GC.create (display,window,
				     [Xm.GC.FONT font,
				      Xm.GC.FOREGROUND foreground,
				      Xm.GC.BACKGROUND background
				     ]
                                    )
            in
              info := SOME {window=window,gc=ref gc,fontstruct=ref fontstruct}
            end
        | _ => ()

      fun start_graphics gp = ()
      fun stop_graphics gp = ()
      fun with_graphics gp f x = f x

      fun with_highlighting (GP {display,info = ref (SOME {gc,...}),...}, f, a) =
        let
          val req_fg_bg  = [Xm.GC.REQUEST_FOREGROUND,Xm.GC.REQUEST_BACKGROUND]
          val cur_fg_bg  = Xm.GC.getValues(display,!gc,req_fg_bg)
        in
           case cur_fg_bg of
             [Xm.GC.FOREGROUND(fg),Xm.GC.BACKGROUND(bg)] =>
               let fun reset (_) = Xm.GC.change(display,!gc,cur_fg_bg)
                   val new_fg_bg = [Xm.GC.FOREGROUND(bg),Xm.GC.BACKGROUND(fg)]
	       in
		  Xm.GC.change(display,!gc,new_fg_bg);
		  unwind_protect (f) (reset) (a)
	       end
           |  _ => f a
        end
      | with_highlighting (gp,f,a) = f a

      fun is_initialized (GP {info = ref (SOME _),...}) = true
        | is_initialized _ = false

      exception UnInitialized

      fun get_offset (GP {x_offset,y_offset,...}) = POINT{x= !x_offset,y= !y_offset}
      fun set_offset (GP {x_offset,y_offset,...},POINT{x,y}) =
          (x_offset := max (x,0); y_offset:= max (y,0))
        
      fun clear_clip_region (GP{display,info,...}) =
        case !info of
          SOME {gc,...} =>
            Xm.GC.change (display,!gc,[(Xm.GC.CLIP_MASK Xm.GC.NO_CLIP_SPEC)])
        | _ => raise UnInitialized
            
      fun set_clip_region (GP{display,info,...},REGION{x,y,width,height}) =
        case !info of
          SOME {gc,...} =>
            Xm.GC.setClipRectangles (display,!gc,0,0,[(x,y,width,height)],Xm.GC.UNSORTED)
        | _ => raise UnInitialized
            
      fun redisplay (GP {display,info,...}) =
        case !info of
          SOME {window,...} =>
            Xm.Draw.clearArea (display,window,0,0,0,0,true)
        | _ => ()

      (* Something of a hack!! *)
      fun reexpose (GP {display,info,...}) =
        case !info of
          SOME {window,...} =>
            Xm.Draw.clearArea (display,window,0,0,1,1,true)
        | _ => ()
            
      fun copy_gp_region
            ( GP{display,info=info1,...}, GP{info=info2,...},
              REGION{x=x1,y=y1,width,height},
              POINT{x=x2,y=y2}
            ) =
        case (!info1,!info2) of
          (SOME {window=window1,gc=gc1,...},SOME {window=window2,...}) =>
            Xm.Draw.copyArea (display,window1,window2,!gc1,x1,y1,width,height,x2,y2)
        | _ => raise UnInitialized
            
      fun make_gp (name,title,widget) = 
        GP {widget=widget,
            name=name,
            title=title,
            display=Xm.Widget.display widget,
            info=ref NONE,
            x_offset= ref 0,
            y_offset = ref 0}

      fun text_extent (gp,string) =
        case gp of
          GP {display,info = ref (SOME {fontstruct,...}),...} =>
            Xm.Font.textExtents (!fontstruct,string)
        | _ => raise UnInitialized

      fun draw_point (gp,POINT{x,y}) =
        case gp of
          GP {display,info as ref (SOME {window,gc,...}), x_offset,y_offset,...} =>
            Xm.Draw.point (display,window,!gc,x - !x_offset,y - !y_offset)
        | _ => raise UnInitialized

      fun draw_line (gp,POINT{x,y},POINT{x=x',y=y'}) =
        case gp of
          GP {display,info as ref (SOME {window,gc,...}), x_offset,y_offset,...} =>
            Xm.Draw.line (display,window,!gc,x - !x_offset,y - !y_offset,x' - !x_offset,y' - !y_offset)
        | _ => raise UnInitialized
            
      fun draw_rectangle (gp, REGION{x, y, width, height}) =
        case gp of
          GP {display, info as ref (SOME {window, gc, ... }),
              x_offset, y_offset, ... } =>
            Xm.Draw.rectangle (display, window, !gc,
                               x - !x_offset, y - !y_offset, width, height)
	    (* X draws rectangles 1 pixel deeper and wider than asked *)
        | _ => raise UnInitialized
            
      fun fill_rectangle (gp,REGION{x, y, width, height}) =
        case gp of
          GP {display, info as ref (SOME {window,gc, ... }),
              x_offset, y_offset,...} =>
            Xm.Draw.fillRectangle (display, window, !gc, 
                                   x - !x_offset, y - !y_offset, width, height)
        | _ => raise UnInitialized

      (* This should fill in the rectangle with the background *)
      fun clear_rectangle (gp, reg) =
        with_highlighting(gp, fill_rectangle, (gp, reg))

      (* This version does not work when scrolling the gp, 
         included here as it uses a more obvious function
         (clearArea) and someone may wish to use it at a
         later date. *)
     (* 
      fun clear_rectangle (gp,REGION{x, y, width, height}) =
        case gp of
          GP {display, info as ref (SOME {window, gc, ... }),
              x_offset, y_offset,...} =>
            Xm.Draw.clearArea (display, window,
                               x - !x_offset, y - !y_offset, width, height,
                               false)
        | _ => raise UnInitialized
      *)

      fun draw_image_string (gp, string, POINT{x, y}) =
        case gp of 
          GP {display, info as ref (SOME {window, gc, ... }),
              x_offset, y_offset, ... } => 
            Xm.Draw.imageString (display, window, !gc,
                                 x - !x_offset, y - !y_offset, string)
        | _ => raise UnInitialized

      val pi = (real 314159) / (real 100000)
      val two_pi = pi + pi
      fun draw_arc (gp,REGION{x,y,width,height},theta1,theta2) =
        case gp of 
          GP {display,info as ref (SOME {window,gc,...}),x_offset,y_offset,...} =>
            let
              fun convert_theta theta = floor (theta * (real 360) * (real 64) /two_pi)
            in
              Xm.Draw.arc (display, window, !gc,
                           x, y, width, height,
                           convert_theta theta1, convert_theta theta2
                          )
            end
        | _ => raise UnInitialized

      local
        val sync_graphics_exposures : unit -> unit = env "x sync graphics exposures"
      in
        fun make_graphics (name,title,draw,get_extents,
			   (want_hscroll,want_vscroll),parent) =
          let
            (* Make the windows *)
            (* perchance this shouldn't be managed, but then we get a nice effect if it is *)
            val scroll = Xm.Widget.createManaged ("drawScroll",Xm.Widget.SCROLLED_WINDOW,parent,[])
            val frame = make_managed_widget ("drawFrame",Frame,scroll,[])
            val main = make_managed_widget ("drawPane", Graphics, frame,[])
	    val (hscroll_values, hscroll_add_callbacks, hscroll_set) =
	      if want_hscroll then
		let
		  val hscroll = 
		    Xm.Widget.createManaged 
		    ("drawHScroll",
		     Xm.Widget.SCROLLBAR,scroll,
		     [(Xm.ORIENTATION, Xm.ORIENTATION_VALUE Xm.HORIZONTAL)])
		  fun horizontal_scroll_callback gp data =
		    let
		      val new_xi = 
			case Xm.Widget.valuesGet (hscroll,[Xm.VALUE]) of
			  [Xm.INT new_xi] => new_xi
			| _ => raise Div
		      val (w,h) = widget_size main
		      val POINT{x=old_xi,y=old_yi} = get_offset gp
		      val delta = new_xi-old_xi
		    in
		      set_offset (gp,POINT{x=new_xi,y=old_yi});
		      copy_gp_region (gp,gp,REGION{x=delta,y=0,width=w,height=h},
			              origin);
                      sync_graphics_exposures()
		    end
		in
		  ([(Xm.HORIZONTAL_SCROLLBAR,Xm.WIDGET hscroll)],
		   fn gp =>
		   let val callback = horizontal_scroll_callback gp
		   in (Xm.Callback.add (hscroll, Xm.Callback.DRAG,
					      callback);
		       Xm.Callback.add (hscroll,Xm.Callback.VALUE_CHANGED,
					      callback))
		   end,
		   fn (new_xi, xextent, ww) =>
		   Xm.Widget.valuesSet (hscroll,
					[(Xm.VALUE, Xm.INT new_xi),
					 (Xm.MAXIMUM, Xm.INT xextent),
					 (Xm.SLIDER_SIZE,
					  Xm.INT (min (ww,xextent)))]))
		end
	      else ([],fn _ => (), fn _ => ())
	    val (vscroll_values, vscroll_add_callbacks, vscroll_set) = 
	      if want_vscroll then
		let
		  val vscroll = 	      
		    Xm.Widget.createManaged 
		    ("drawVScroll", 
		     Xm.Widget.SCROLLBAR,scroll,
		     [(Xm.ORIENTATION, Xm.ORIENTATION_VALUE Xm.VERTICAL)])
		  fun vertical_scroll_callback gp data =
		    let
		      val new_yi = 
			case Xm.Widget.valuesGet (vscroll,[Xm.VALUE]) of
			  [Xm.INT new_yi] => new_yi
			| _ => raise Div
		      val (w,h) = widget_size main
		      val POINT{x=old_xi,y=old_yi} = get_offset gp
		      val delta = new_yi-old_yi
		    in
		      set_offset (gp,POINT{x=old_xi,y=new_yi});
		      copy_gp_region (gp,gp,REGION{x=0,y=delta,width=w,height=h},
			              origin);
                      sync_graphics_exposures()
		    end
		in
		  ([(Xm.VERTICAL_SCROLLBAR,Xm.WIDGET vscroll)],
		   fn gp => 
		   let val callback = vertical_scroll_callback gp
		   in (Xm.Callback.add (vscroll,Xm.Callback.VALUE_CHANGED,
					      callback);
		       Xm.Callback.add (vscroll,Xm.Callback.DRAG,
					      callback))
		   end,
		   fn (new_yi, yextent, wh) =>
		   Xm.Widget.valuesSet (vscroll,
					[(Xm.VALUE, Xm.INT new_yi),
					 (Xm.MAXIMUM, Xm.INT yextent),
					 (Xm.SLIDER_SIZE,
					  Xm.INT (min (wh,yextent)))]))
		 end
	      else ([], fn _ => (), fn _ => ())

	    val _ = Xm.Widget.valuesSet (scroll,
					 vscroll_values @ hscroll_values @
					 [(Xm.WORK_WINDOW,Xm.WIDGET frame)])
              
            val gp = make_gp (name,title,main)
              
            (* These need to be a little careful about the way the copy area is done *)

            fun set_position (POINT{x=xi',y=yi'}) = 
              let
                val POINT{x=cur_xi,y=cur_yi}  = get_offset gp

                val xi = if (xi' < 0) then cur_xi else xi'
                val yi = if (yi' < 0) then cur_yi else yi'

                val (ww,wh) = widget_size main
                val (xextent,yextent) = get_extents()
                val new_xi = max (min (xi,xextent-ww),0)
                val new_yi = max (min (yi,yextent-wh),0)
              in
		hscroll_set (new_xi, xextent, ww);
		vscroll_set (new_yi, yextent, wh);
                set_offset (gp,POINT{x=new_xi,y=new_yi});
                redisplay gp
              end
            
            fun resize_callback data = 
              let
                val (ww,wh) = widget_size main
                val (xextent,yextent) = get_extents()
                val POINT{x=xi,y=yi}  = get_offset gp
                val new_xi = max (min (xi,xextent-ww),0)
                val new_yi = max (min (yi,yextent-wh),0)
              in
		hscroll_set (new_xi, xextent, ww);
		vscroll_set (new_yi, yextent, wh);
                set_offset (gp,POINT{x=new_xi,y=new_yi});
                redisplay gp
              end
            
            fun do_expose (Xm.Event.EXPOSE_EVENT {common,x,y,width=w,height=h,count}) =
              draw (gp,REGION {x=x,y=y,width=w,height=h})
              
            fun expose_handler data =
              let
                val event = Xm.Event.convertEvent data
              in
                case event of
                  Xm.Event.EXPOSE expose_event => do_expose expose_event
                | Xm.Event.GRAPHICS_EXPOSE expose_event => do_expose expose_event
                (* Could be a NoExpose event *)
                | _ => ()
              end
          in
            Xm.Event.addHandler (main,[Xm.Event.EXPOSURE_MASK],true,expose_handler);
            Xm.Callback.add (main,Xm.Callback.RESIZE,resize_callback);
	    hscroll_add_callbacks gp;
	    vscroll_add_callbacks gp;
            (scroll,gp,resize_callback,set_position)
          end
      end

      fun add_input_handler (gp,handler) =
        let
          fun input_callback data =
            let
              val event = Callback.get_event data
              val event_type = Event.get_event_type event
            in
              if event_type = Event.ButtonPress
                then
                  case Event.get_button_data event of
                    SOME (POINT{x,y},button) =>
                      let
                        val POINT{x=xi,y=yi} = get_offset gp
                        val new_x = x + xi
                        val new_y = y + yi
                      in
                        handler (button,POINT {x=new_x,y=new_y})
                      end
                  | _ => ()
              else ()
            end
        in
          Xm.Callback.add
          (gp_widget gp,
           Xm.Callback.INPUT,
           input_callback)
        end

      type PixMap = Xm.pixel

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

      local

        fun translate_request (REQUEST_FONT)       = Xm.GC.REQUEST_FONT
          | translate_request (REQUEST_LINE_STYLE) = Xm.GC.REQUEST_LINE_STYLE
          | translate_request (REQUEST_LINE_WIDTH) = Xm.GC.REQUEST_LINE_WIDTH
          | translate_request (REQUEST_FOREGROUND) = Xm.GC.REQUEST_FOREGROUND
          | translate_request (REQUEST_BACKGROUND) = Xm.GC.REQUEST_BACKGROUND

        val translate_gc_font : Xm.font -> Font = cast
        val translate_gc_line_style : Xm.GC.line_style -> LineStyle = cast

        val translate_font : Font -> Xm.font = cast
        val translate_line_style : LineStyle -> Xm.GC.line_style = cast

        fun translate_gc_value (Xm.GC.FONT f)        = FONT(translate_gc_font f)
          | translate_gc_value (Xm.GC.LINE_STYLE ls) =
               LINE_STYLE(translate_gc_line_style ls)
          | translate_gc_value (Xm.GC.LINE_WIDTH(i)) = LINE_WIDTH(i)
          | translate_gc_value (Xm.GC.FOREGROUND(p))  = FOREGROUND(p)
          | translate_gc_value (Xm.GC.BACKGROUND(p)) = BACKGROUND(p)
          | translate_gc_value (_) = Crash.impossible "translate_gc_value"


        fun translate_attribute (FONT f) =
            Xm.GC.FONT(translate_font f)
          | translate_attribute (LINE_STYLE ls) =
            Xm.GC.LINE_STYLE(translate_line_style ls)
          | translate_attribute (LINE_WIDTH(i)) = Xm.GC.LINE_WIDTH(i)
          | translate_attribute (FOREGROUND(p))  = Xm.GC.FOREGROUND(p)
          | translate_attribute (BACKGROUND(p)) = Xm.GC.BACKGROUND(p)

         fun is_font_attr (FONT(_)) = true
           | is_font_attr (_)       = false
      in

         fun getAttributes (GP{display,info as ref(SOME{gc,...}), ...},req_l) =
             let val gc_req_l = map translate_request req_l
                 val gc_val_l = Xm.GC.getValues(display,!gc,gc_req_l)
             in
                 map translate_gc_value gc_val_l
             end
           | getAttributes(_,_) = raise UnInitialized

         fun setAttributes (GP{display,info as ref(SOME{gc,fontstruct,...}),...},attr_l) =
             let val gc_val_l = map translate_attribute attr_l
             in
	         Xm.GC.change(display,!gc,gc_val_l);
                 case  BasisList.find is_font_attr attr_l of
                   SOME(FONT(font)) =>
                     ( fontstruct := (Xm.Font.query (display,font) ))
                 | _ => ()
             end
           | setAttributes(_,_) = raise UnInitialized

         fun with_graphics_port (GP{display,info as ref(SOME{window,gc,fontstruct,...}),...}, body_fn, arg) =
	     let val cur_gc = !gc
		 val cur_fontstruct = !fontstruct

		 fun reset_fn(_) =
		   ( gc := cur_gc;
		     fontstruct := cur_fontstruct
		   )

                 val gc_values =
                   Xm.GC.getValues (display,!gc,
                                    [Xm.GC.REQUEST_FONT,
                                     Xm.GC.REQUEST_FOREGROUND,
                                     Xm.GC.REQUEST_BACKGROUND])

                 val new_gc_obj = Xm.GC.create(display,window,gc_values)
	     in
		gc := new_gc_obj; 
		unwind_protect (body_fn)(reset_fn)(arg)
	     end
           | with_graphics_port(_,_,_) = raise UnInitialized
      end
    end

  (* CLIPBOARD INTERFACE *)
  (* this just deals with text right now *)
  (* temporary hack *)

  local
    fun env s = MLWorks.Internal.Runtime.environment s
  in
    val set_selection : Widget * string -> unit = env "x set selection"
    val get_selection : Widget * (string -> unit) -> unit = env "x get selection"
  end

  fun clipboard_set (widget,s) = set_selection (widget,s)
  fun clipboard_get (widget,handler) = get_selection (widget,handler)
  (* I don't see how to implement this *)
  fun clipboard_empty widget = false

  val terminator = "\n"

  val register_interrupt_widget : Widget -> unit = 
    MLWorks.Internal.Runtime.environment "x set interrupt window" 

(* Dummy function - nothing needs to be done on Motif. 
 * This function is not used. *)
  fun with_window_updates f = f ()

  val evaluating = ref false;

  (* makeYesNo(parent, question) creates a question of type unit->bool *)
  (* The question asks the user a simple question requiring either
     Yes or No as answer, or optionally (if enabled) the user can click Cancel.
     Waits for user response and returns:
	SOME true indicating that the user clicked YES,
	SOME false indicating that the user clicked NO,
	NONE indicating that the user clicked CANCEL.
   *)
  fun makeYesNoCancel (parent, question, cancelButton) =
    let 
      val waitRef = ref true  
      val answerRef = ref NONE
      val dialog = Xm.Widget.createPopupShell
                     ("Question",
                      Xm.Widget.DIALOG_SHELL,
                      parent,
                      [(Xm.DELETE_RESPONSE ,
                        Xm.DELETE_RESPONSE_VALUE Xm.DO_NOTHING )])
      val form = make_subwindow dialog

      val buttonRow = Xm.Widget.createManaged
                      ("buttonRow", Xm.Widget.ROW_COLUMN, form,
                       [(Xm.ORIENTATION, Xm.ORIENTATION_VALUE Xm.HORIZONTAL)])

      val questionBox = make_managed_widget ("msgLabel", Label, form, [])

      fun callback a _ =
            (answerRef := a;
             waitRef := false;
             hide dialog)

      val yesButton = Xm.Widget.createManaged
                       ("       Yes      ", 
                        Xm.Widget.PUSH_BUTTON, buttonRow, [])
      val noButton = Xm.Widget.createManaged
                       ("       No       ",
                        Xm.Widget.PUSH_BUTTON, buttonRow, [])

    in
      Xm.Callback.add (yesButton, Xm.Callback.ACTIVATE, callback (SOME true));
      Xm.Callback.add (noButton, Xm.Callback.ACTIVATE, callback (SOME false));

      if cancelButton then 
	let val cancel = Xm.Widget.createManaged
                       ("     Cancel     ", 
                        Xm.Widget.PUSH_BUTTON, buttonRow, [])
	in
	  Xm.Callback.add (cancel, Xm.Callback.ACTIVATE, callback NONE)
	end
      else ();

      set_label_string (questionBox, question);
      Layout.lay_out (form, NONE, [Layout.FIXED questionBox,
                                     Layout.SPACE,
                                     Layout.FIXED buttonRow]);

      fn () =>
        (reveal form;
         reveal dialog;
         waitRef := true;
         event_loop waitRef;
         !answerRef )
    end (* of fun makeYesNoCancel *)

  fun find_dialog (parent, searchFn, spec) = 
    let
      val dialog = 
	Xm.Widget.createPopupShell ("Find",
				    Xm.Widget.DIALOG_SHELL,
				    parent,
	                      	    [(Xm.DELETE_RESPONSE ,
	                              Xm.DELETE_RESPONSE_VALUE Xm.DO_NOTHING )])
      val form = make_subwindow dialog

      val searchRow = Xm.Widget.createManaged
                      ("searchRow", Xm.Widget.ROW_COLUMN, form,
                       [(Xm.ORIENTATION, Xm.ORIENTATION_VALUE Xm.HORIZONTAL)])

      val label = make_managed_widget("findLabel", Label, searchRow, [])
      val findText = make_managed_widget("findText", Text, searchRow, [])

      val {downOpt, caseOpt, findStr, wordOpt} = spec

      val wholeWord = ref (getOpt(wordOpt, false))
      val matchCase = ref (getOpt(caseOpt, false))
      val searchDown = ref (getOpt(downOpt, false))

      fun create_opt s storeRef =
	let 
	  val buttonRC = make_managed_widget("buttonRC", RowColumn, form, [])
	  val {update, ...} = 
	    Menus.make_buttons (buttonRC, 
	      [Menus.TOGGLE (s, fn () => (!storeRef), fn tf => (storeRef := tf), fn _ => true)])
	in
	  (buttonRC, update)
	end

      val testWord = isSome(wordOpt)
      val testCase = isSome(caseOpt)
      val testDown = isSome(caseOpt)

      val (matchCaseRC, updateCase) = 
	if testCase then (create_opt "matchCase" matchCase) else (form, fn () => ())
      val (wholeWordRC, updateWord) = 
	if testWord then (create_opt "wholeWord" wholeWord) else (form, fn () => ())

      val (downRC, updateDownButtons) = 
	if testDown then 
	  let 
	    val downRC = make_managed_widget("downRC", RowColumn, form, [])
	    val searchDir = make_managed_widget("searchDir", Label, downRC, [])
	    val {update, ...} = 
		Menus.make_buttons(downRC,
		  [Menus.RADIO ("up", fn () => not (!searchDown),
				      fn tf => searchDown := not tf, 
				      fn () => true),
		   Menus.RADIO ("down", fn () => (!searchDown),
				      fn tf => searchDown := tf, 
				      fn () => true)])
	  in
	    (downRC, update)
	  end
	else
	  (form, fn () => ())

      fun findnext () = 
	searchFn {searchStr = Text.get_string findText,
		  matchCase = (!matchCase),
		  wholeWord = (!wholeWord),
		  searchDown = (!searchDown)}

      val buttonsRC = make_managed_widget("buttonsRC", RowColumn, form, [])
      val {update, ...} = 
	Menus.make_buttons(buttonsRC,
	  [Menus.PUSH ("findNext", findnext, fn _ => true),
	   Menus.PUSH ("cancel", fn () => hide dialog, fn _ => true)])

    in
      Layout.lay_out (form, NONE,
	[Layout.FIXED searchRow] @ 
	(if testCase then [Layout.FIXED matchCaseRC] else []) @ 
	(if testWord then [Layout.FIXED wholeWordRC] else []) @
	(if testDown then [Layout.FIXED downRC] else []) @
	[Layout.SPACE,
	 Layout.FIXED buttonsRC]);
      fn () => (reveal form;
	  	reveal dialog; 
		Text.set_string(findText, findStr);
		updateCase();
		updateWord();
		updateDownButtons();
		dialog)

    end  (* find_dialog *)

end

