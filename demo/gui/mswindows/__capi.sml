(* === CAPI example for Windows ===
 * Copyright (C) 1998.  The Harlequin Group plc.
 * 
 * $Log: __capi.sml,v $
 * Revision 1.2  1998/08/05 16:49:01  johnh
 * [Bug #30463]
 * Add make_form for use by guess demo.
 *
# Revision 1.1  1998/07/21  09:52:52  johnh
# new unit
# [Bug #30441]
# Part of an example of CAPI and projects.
#
 *)

require "capi";
require "__windows_gui";

structure Capi : CAPI = 
struct

  type Widget = WindowsGui.hwnd

  datatype WidgetAttribute = 
      PanedMargin of bool
    | Position of    int * int
    | Size of        int * int
    | ReadOnly of    bool

  val sendMessageNoResult = ignore o WindowsGui.sendMessage;

  fun reveal window =
    (WindowsGui.showWindow (window,WindowsGui.SW_SHOWNORMAL);
     WindowsGui.updateWindow window)

  fun hide window =
    WindowsGui.showWindow (window,WindowsGui.SW_HIDE)

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

  fun set_font (window, font) =
    let
      val WindowsGui.OBJECT text_font = WindowsGui.getStockObject font
    in
      sendMessageNoResult
          (window,
           WindowsGui.WM_SETFONT,
           WindowsGui.WPARAM text_font,
           WindowsGui.LPARAM (WindowsGui.intToWord 1))
    end
    handle WindowsGui.WindowSystemError _ => ()

  fun getStylesFromAttributes [] = []
    | getStylesFromAttributes ((ReadOnly true)::rest) = 
	WindowsGui.ES_READONLY :: getStylesFromAttributes(rest)
    | getStylesFromAttributes (another::rest) =
	getStylesFromAttributes(rest)

  fun getSize ((Size (w,h))::rest) = SOME (w,h)
    | getSize (notsize::rest) = getSize rest
    | getSize [] = NONE

  fun getPosition ((Position (x,y))::rest) = SOME (x,y)
    | getPosition (notpos::rest) = getPosition rest
    | getPosition [] = NONE

  val accelerator_list = 
    [("cut",[WindowsGui.FCONTROL,WindowsGui.FVIRTKEY],ord #"X"),
     ("copy",[WindowsGui.FCONTROL,WindowsGui.FVIRTKEY],ord #"C"),
     ("paste",[WindowsGui.FCONTROL,WindowsGui.FVIRTKEY],ord #"V")]

  val accelerators =
    map 
      (fn (label,flags,key) => (flags,key,WindowsGui.wordToInt (WindowsGui.newControlId())))
      accelerator_list

  fun initialize_application (name, title) = 
    let
      val window = WindowsGui.mainInit ()
    in
      (* Return NONE to allow the default action to be also carried out. *)
      WindowsGui.addMessageHandler (window,WindowsGui.WM_DESTROY,
                                   fn _ => (WindowsGui.postQuitMessage 0;
                                            NONE));

      WindowsGui.setAcceleratorTable 
	(WindowsGui.createAcceleratorTable accelerators);
      window
    end

  fun destroy window = WindowsGui.destroyWindow window

  fun quit_loop _ = WindowsGui.postQuitMessage 0

  fun initialize_toplevel window = reveal window
  fun initialize_application_shell shell = ()

  fun to_front window = WindowsGui.bringWindowToTop window
  fun set_label_string (label,s) = set_text (label,s)
  val parent = WindowsGui.getParent

  val default_width = 600

  fun text_size text =
    WindowsGui.wordToSignedInt 
      (WindowsGui.sendMessage (text,
                               WindowsGui.WM_GETTEXTLENGTH,
                               WindowsGui.WPARAM WindowsGui.nullWord,
                               WindowsGui.LPARAM WindowsGui.nullWord))

  fun get_text_string text = 
    let
      val size = text_size text
      val buffer = WindowsGui.malloc (size+1) (* extra for null termination *)
      val _ = WindowsGui.sendMessage (text,
                                      WindowsGui.WM_GETTEXT,
                                      WindowsGui.WPARAM (WindowsGui.intToWord (size+1)),
                                      WindowsGui.LPARAM buffer)
      val _ = WindowsGui.setByte (buffer,size,0) (* null terminate *)
      val result = WindowsGui.wordToString buffer
    in
      WindowsGui.free buffer;
      result
    end

  fun set_text_string (text,s) = set_text (text,s)

  fun make_text (name, parent, attributes) = 
    let 
      open WindowsGui 
      val (width, height) = 
	getOpt (getSize attributes, (default_width, 26))
      val (x, y) = 
	getOpt (getPosition attributes, (0,0))
      val text = 
        createWindowEx {name = name,
			parent = parent, 
		        class = "EDIT",
		        ex_styles = [],
		        x = x, y = y,
		        width = width,
		        height = height,
		        menu = nullWord,
		        styles = [WS_CHILD, 
				  WS_BORDER, 
				  ES_AUTOHSCROLL] @ 
				 getStylesFromAttributes (attributes)}
    in
      set_font (text, WindowsGui.ANSI_VAR_FONT);
      set_text_string (text, "");
      text
    end

  fun make_button {parent, name, attributes, sensitive, action} = 
    let 
      open WindowsGui
      val id = newControlId()
      val (width, height) = 
	getOpt (getSize attributes, (default_width, 20))
      val (x, y) = 
	getOpt (getPosition attributes, (0,0))
      val button = 
	createWindowEx {name = name,
			parent = parent,
			class = "BUTTON",
			ex_styles = [],
			x=x, y=y,
			width = width, 
			height = height,
			menu = id,
			styles = [BS_PUSHBUTTON, 
				  WS_CHILD,
				  WS_TABSTOP] @ 
				 getStylesFromAttributes (attributes)}
    in
      addCommandHandler(parent, id, fn _ => action());
      (button, 
       fn () => ignore (enableWindow (button, sensitive())))
    end

  fun make_label (name, parent, attributes) = 
    let 
      open WindowsGui
      val (width, height) = 
	getOpt (getSize attributes, (default_width, 20))
      val (x, y) = 
	getOpt (getPosition attributes, (0,0))
      val label = 
	createWindowEx {name = name,
			parent = parent,
			class = "STATIC",
			ex_styles = [],
			x=x, y=y,
			width = width, 
			height = height,
			menu = nullWord,
			styles = [SS_LEFT,
				  WS_CHILD] @  
				getStylesFromAttributes (attributes)}
    in
      set_font (label, ANSI_FIXED_FONT);
      label
    end

  fun make_window (name, parent, attributes) = 
    let 
      open WindowsGui
      val (width, height) = 
	getOpt (getSize attributes, (default_width, 200))
      val (x, y) = 
	getOpt (getPosition attributes, (0,0))
      val window = 
	createWindowEx {name = name,
			parent = parent,
			class = "Frame",
			ex_styles = [],
			x=x, y=y,
			width = width, 
			height = height,
			menu = nullWord,
			styles = [WS_OVERLAPPED_WINDOW] @
				 getStylesFromAttributes (attributes)}
    in
      set_text (window, name);
      (window, window)
    end

  fun make_subwindow (name, parent, attributes) = 
    #1 (make_window (name, parent, attributes))

  fun widget_size window = 
    let
      val WindowsGui.RECT {left,top,right,bottom} = 
	WindowsGui.getWindowRect window
    in
      (right-left,bottom-top)
    end

  fun widget_pos window = 
    let
      val WindowsGui.RECT {left,top, ...} = 
	WindowsGui.getWindowRect window
    in
      (left, top)
    end

  fun move_window (window, x, y) = 
    let
      val (w,h) = widget_size window
    in
      WindowsGui.moveWindow (window,x,y,w,h,true)
    end

  fun size_window (window, w, h) = 
    let
      val WindowsGui.RECT {left,top,right,bottom} = 
	WindowsGui.getWindowRect window
    in
      WindowsGui.moveWindow (window, left, top, w, h, true)
    end

  fun main_loop () = WindowsGui.mainLoop ()

  fun send_message (parent, message) =
    (WindowsGui.messageBeep WindowsGui.MB_ICONQUESTION;
     ignore(WindowsGui.messageBox (parent, message, "MLWorks",
                                  [WindowsGui.MB_OK,WindowsGui.MB_APPLMODAL])))

  datatype Callback =
      Activate (* not used in WindowsGui. *)
    | Destroy
    | Unmap (* not used in WindowsGui. *)
    | Resize (* WM_SIZE corresponds here *)
    | ValueChange

  fun add_callback (window,callback,handler) =
    let 
      open WindowsGui
      fun messageHandler message = 
	addMessageHandler (window, message, 
			   fn _ => (handler(); NONE))

      fun commandHandler () = 
	let 
	  val (p, win_id) = (parent window, intToWord (getDlgCtrlID window))
	in
	  addCommandHandler (p, win_id, fn _ => handler())
	end
    in
      case callback of
          Activate    => ()
        | Destroy     => messageHandler WM_DESTROY
        | Unmap       => ()
        | Resize      => messageHandler WM_SIZE
        | ValueChange => commandHandler()
    end

end