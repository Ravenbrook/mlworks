(*
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
