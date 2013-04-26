(*
 * Copyright (c) 1995 Harlequin Ltd.
 * 
 *  $Log: console.sml,v $
 *  Revision 1.6  1998/03/24 16:37:51  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 * Revision 1.5  1996/12/03  20:27:32  johnh
 * Putting clear_console in _console to set the write_pos.
 *
 * Revision 1.4  1996/07/02  10:42:30  andreww
 * Adding GuiStandardIO redirection function to the create console function.
 *
 * Revision 1.3  1996/05/15  16:00:19  daveb
 * Changed create to return the scrolledtext widgets, instead of a popup shell.
 *
 * Revision 1.2  1996/05/01  11:17:44  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.1  1995/07/04  13:17:21  matthew
 * new unit
 * New unit
 *
 *  Revision 1.1  1995/07/04  13:17:21  daveb
 *  new unit
 *  Std_in and std_out.
 *
 * 
 *)

require "^.basis.__text_io";

signature CONSOLE =
sig
  type Widget
  type user_preferences

  val create:
    Widget * string * user_preferences
    -> {instream: TextIO.instream,
	outstream: TextIO.outstream,
	console_widget: Widget,
	console_text: Widget,
	clear_input: unit -> unit,
	clear_console: unit -> unit,
        set_window: unit -> unit}
end;
