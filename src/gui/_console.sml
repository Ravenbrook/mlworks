(* IO Console - imitates user's TTY *)
(*
 *  $Log: _console.sml,v $
 *  Revision 1.27  1999/02/02 15:59:11  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 * Revision 1.26  1998/03/24  17:20:27  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.25  1998/02/19  20:16:58  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.24  1998/02/18  16:57:10  jont
 * [Bug #70070]
 * Remove MLWorks.IO.terminal_out in favour of Terminal.output
 *
 * Revision 1.23  1997/09/18  15:09:12  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.22  1997/03/17  11:39:06  andreww
 * [Bug #1677]
 * adding new access field to currentIO record.
 *
 * Revision 1.21  1996/12/03  20:32:21  johnh
 * Putting clear_console in _console to set the write_pos.
 *
 * Revision 1.20  1996/11/21  12:20:45  jont
 * [Bug #1799]
 * Modify call to check_insertion to allow for string being truncated
 * in order to fit
 *
 * Revision 1.19  1996/11/06  11:15:48  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.18  1996/10/09  11:53:15  io
 * moving String from toplevel
 *
 * Revision 1.17  1996/07/15  13:33:45  andreww
 * propagating changes made to the GUI standard IO redirection mechanism
 * (see __pervasive_library.sml for the StandardIO structure)
 *
 * Revision 1.16  1996/07/03  12:55:52  andreww
 * Adding GuiStandardIO-specific functions to the console create function.
 *
 * Revision 1.15  1996/07/02  14:35:24  daveb
 * Added call to Capi.Text.check_insertion.
 *
 * Revision 1.14  1996/06/13  17:50:25  daveb
 * The changes in Version 1.12 were lost - presumably a conflict over checking
 * stuff in.  I've merged them back in.
 *
 * Revision 1.13  1996/05/15  16:00:22  daveb
 * Changed create to return the scrolledtext widgets, instead of a popup shell.
 *
 * Revision 1.11  1996/05/01  11:18:57  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.10  1996/04/30  10:05:04  matthew
 * Replacing MLWorks.Integer with basis file
 *
 * Revision 1.9  1996/03/06  14:55:41  daveb
 * Added a "delete all" menu entry.
 *
 * Revision 1.8  1996/01/22  11:52:50  daveb
 * Removed binding of linefeed character - the translation table now makes this
 * insert a new line character without performing any action (to match Windows).
 *
 * Revision 1.7  1996/01/22  11:03:35  daveb
 * Changed to use the new history mechanism in gui_utils.
 *
 * Revision 1.6  1995/12/07  14:37:07  matthew
 * Change to clipboard interface
 *
 * Revision 1.5  1995/11/13  17:26:38  matthew
 * Simplifying capi interface.
 *
 * Revision 1.4  1995/08/30  13:23:34  matthew
 * Changes to Capi text widget
 *
 * Revision 1.3  1995/08/11  10:25:20  matthew
 * Adding make_buttons function to capi
 *
 * Revision 1.2  1995/07/27  10:55:46  matthew
 * Moved capi etc. to gui
 *
 * Revision 1.1  1995/07/26  14:42:37  matthew
 * new unit
 * New unit
 *
 *  Revision 1.3  1995/07/04  17:18:31  daveb
 *  Replaced ad-hoc handling of CTRL-D (which has stopped working)
 *  with an explicit function.
 *
 *  Revision 1.2  1995/07/04  15:09:39  matthew
 *  Further capification
 *
 *  Revision 1.1  1995/07/04  13:12:34  daveb
 *  new unit
 *  Std_in and std_out.
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
require "../basis/__text_io";
require "../basis/__text_prim_io";
require "^.utils.__terminal";

require "../utils/lists";
require "../interpreter/shell_utils";
require "capi";
require "menus";
require "gui_utils";

require "console";

(* WARNING: Don't use std_out for error tracing when debugging this file.
   Usually you should use MLWorks.IO.terminal_out instead. *)

functor Console (
  structure Capi: CAPI
  structure Lists: LISTS
  structure ShellUtils : SHELL_UTILS
  structure GuiUtils : GUI_UTILS
  structure Menus : MENUS

  sharing type GuiUtils.user_tool_options = ShellUtils.UserOptions 

  sharing type Menus.Widget = GuiUtils.Widget = Capi.Widget

  sharing type Menus.ButtonSpec = GuiUtils.ButtonSpec

  sharing type ShellUtils.user_preferences = GuiUtils.user_preferences
): CONSOLE =
struct
  type Widget = Capi.Widget
  type user_preferences = GuiUtils.user_preferences

  val do_debug = false
  fun debug s = if do_debug then Terminal.output(s ^ "\n") else ()
  fun fdebug f = if do_debug then Terminal.output(f() ^ "\n") else ()
  fun ddebug s = Terminal.output(s ^ "\n")

  fun create (parent, title, user_preferences) =
    let
      val (textscroll, text) =
	Capi.make_scrolled_text ("textIO", parent, [])

      (*** IO functions ***)

      (* write_pos is the position new input should go in the buffer, usually
	 the end.  Also used as the position from which input is read. 
         Output from the program should go before this position.  Input is read
         from after it. *)
      val write_pos = ref 0

      fun clear_console _ = (Capi.Text.set_string (text, "");
			     write_pos := 0)

      (* Note use of text_size -- important for Windows CR/LF!!!
	 Also check_insertion to get around size limitations of Windows. *)

      fun insert_text str =
	let
	  val str = Capi.Text.check_insertion (text, str, !write_pos, [write_pos])
	in
	  Capi.Text.insert(text, !write_pos, str);
          write_pos := Capi.Text.text_size str + !write_pos;
	  Capi.Text.set_insertion_position (text, !write_pos)
	end

      val outstream = GuiUtils.make_outstream insert_text

      val (input_string, input_flag) = (ref "", ref false)

      fun input_fun () =
        (input_flag := true;
	 Capi.event_loop (input_flag);
         fdebug(fn _ => "Input line is:" ^ (!input_string)^":");
         !input_string)

      local 
        val inbuff as (posref, strref) = (ref 0, ref "")
            
        fun refill_buff () =
          let
            val new_string = input_fun ()
          in
            posref := 0;
            strref := new_string
          end

	val eof_flag = ref false
        val close_in = fn () => eof_flag:=true

        val thisWindow = {output={descriptor=NONE,
                                  put= fn {buf,i,sz} =>
                                       let val els = case sz of
                                                    NONE=>size buf-i
                                                  | (SOME s)=> s
                                       in insert_text (substring (buf,i,els));
                                          els
                                       end,
                                  get_pos=NONE,
                                  set_pos=NONE,
                                  can_output=NONE,
                                  close = fn()=>()},
                          error ={descriptor=NONE,
                                  put= fn {buf,i,sz} =>
                                       let val els = case sz of
                                                    NONE=>size buf-i
                                                  | (SOME s)=> s
                                       in insert_text (substring (buf,i,els));
                                          els
                                       end,
                                  get_pos=NONE,
                                  set_pos=NONE,
                                  can_output=NONE,
                                  close=fn()=>()},
                          input ={descriptor=NONE,
                                  get=fn _ =>input_fun(),
                                  get_pos=SOME(fn()=> !posref),
                                  set_pos=SOME(fn i=>posref:=i),
                                  can_input=SOME(fn()=>
                                                 (!posref<size (!strref))),
                                  close=close_in},
                          access = fn f => f ()}
          (* see: <URI:spring:/ML_Notebook/Design/GUI/Mutexes> for
           * description of access. *)
      in

        fun inThisWindow () =
             MLWorks.Internal.StandardIO.redirectIO thisWindow

        fun get_input n =
          let
            val string = !strref
            val pointer = !posref
            val len = size string
          in
            if !eof_flag then
              ""
            else if pointer + n > len then
              (refill_buff ();
               substring (* could raise Substring *) (string,pointer,len-pointer) ^
               get_input (n - len + pointer))
                 else
                   let val result = substring (* could raise Substring *) (string,pointer,n)
                   in
                     posref := (!posref + n);
                     result
                   end
          end

        fun clear_input () =
	  (debug "Clearing input";
           posref := 0;
	   strref := "";
	   eof_flag := false)
	  
        fun do_lookahead () =
          (if !eof_flag then
             ""
          else if !posref >= size (!strref) then
             (refill_buff ();
              do_lookahead ())
               else 
                 substring (* could raise Substring *) (!strref, !posref, 1))
	       
	val close_in  = close_in
      end;

      fun mkInstream(input, lookahead, close_in) =
	let
	  fun can_input() = do_lookahead() <> ""
	  val prim_reader =
	    TextPrimIO.RD{name = "console reader",
			  chunkSize = 1,
			  readVec = SOME get_input,
			  readArr = NONE,
			  readVecNB = NONE,
			  readArrNB = NONE,
			  block = NONE,
			  canInput = SOME can_input,
			  avail = fn () => SOME(size(do_lookahead())),
			  getPos = NONE,
			  setPos = NONE,
			  endPos = NONE,
			  verifyPos = NONE,
			  close = close_in, 
			  ioDesc = NONE}

	in
	  TextIO.mkInstream(TextIO.StreamIO.mkInstream(TextPrimIO.augmentReader prim_reader, ""))
	end

      val instream = mkInstream(get_input, do_lookahead, close_in)

      fun replace_current_input line =
	let
          val last_pos = Capi.Text.get_last_position text
	in 
	  (* Motif Text.replace doesn't always work properly.  But setting the
	     whole string causes ridiculous amounts of flicker. *)
          Capi.Text.replace (text, !write_pos, last_pos, line);
	  Capi.Text.set_insertion_position (text, !write_pos + size line)
	end

      fun delete_current_line () =
        replace_current_input ""

      val {update_history, prev_history, next_history, history_menu, ...} =
        GuiUtils.make_history
          (user_preferences, fn line => replace_current_input line)

      fun start_of_line () =
        let
          val ppos = !write_pos
          val pos = Capi.Text.get_insertion_position text
	  val new_pos =
            if pos < ppos
              then Capi.Text.current_line (text,pos)
            else ppos
        in
          Capi.Text.set_insertion_position (text,new_pos)
        end
          
      fun end_of_line () =
        let
          val ppos = !write_pos
          val pos = Capi.Text.get_insertion_position text
          val new_pos =
            if pos < ppos
              then Capi.Text.end_line (text,pos)
            else Capi.Text.get_last_position text
        in
          Capi.Text.set_insertion_position (text,new_pos)
        end
          
      fun eof_or_delete () =
        let
          val pos = Capi.Text.get_insertion_position text
          val last_pos = Capi.Text.get_last_position text
        in
          if pos = last_pos andalso pos = !write_pos then
            (debug "eof";
             close_in ();
             input_flag := false)
          else
            (debug "delete";
             Capi.Text.replace (text, pos, pos + 1, ""))
        end

      fun do_return () =
	let
          val pos = Capi.Text.get_insertion_position text
          val lines =
            if pos < !write_pos then
              let
                val line = Capi.Text.get_line (text, pos) ^ "\n"
                val last_pos = Capi.Text.get_last_position text
              in
                Capi.Text.insert(text, last_pos, line);
                write_pos := last_pos + size line;
                Capi.Text.set_insertion_position (text, last_pos + size line);
                [line]
              end
            else
              let
                val str = Capi.Text.get_string text
                val length = size str

                fun get_lines ([], current, acc, _) =
		  map (implode o rev) (current :: acc)
                |   get_lines (#"\n"::rest, current, acc, column) =
		  get_lines (rest, [], (#"\n"::current)::acc, 1)
                |   get_lines (c::rest, current, acc, column) =
		  get_lines (rest, c::current, acc, column+1)

                val line = substring (* could raise Substring *) (str, !write_pos,
                                             length - !write_pos)
                val lines = get_lines (explode line,[],[],0)
              in
                case lines of
                  last :: rest =>
                    (Capi.Text.insert(text, length, "\n");
                     write_pos := length + 1;
                     Capi.Text.set_insertion_position
		     (text, length+1); last ^ "\n" :: rest)
                | _ => lines
              end
        in
	  input_flag := false;
          input_string := concat (rev lines);
	  update_history [!input_string]
        end

      (* A flag to indicate whether escape has just been pressed *)
      val escape_pressed = ref false

      fun do_escape () = escape_pressed := true

      val meta_bindings =
        [("p", prev_history),
         ("n", next_history),
         ("w", fn _ => Capi.Text.copy_selection text)]

      val normal_bindings =
        [("\^A", start_of_line),
         ("\^D", eof_or_delete),
         ("\^E", end_of_line),
         ("\^W", fn _ => Capi.Text.cut_selection text),
         ("\^Y", fn _ => Capi.Text.paste_selection text),
         ("\^U", delete_current_line),
         ("\013",do_return),
         ("\027",do_escape)]

      fun despatch_key bindings key =
        let
          fun loop [] = false
            | loop ((key',action)::rest) =
              if key = key' then (ignore(action ()); true)
              else loop rest
        in
          loop bindings
        end

      val despatch_meta = despatch_key meta_bindings
      val despatch_normal = despatch_key normal_bindings

      fun text_handler (key, modifiers) =
        if modifiers = [Capi.Event.meta_modifier] then
          despatch_meta key
        else
          despatch_normal key

      fun modifyVerify (start_pos, end_pos, str, doit) =
        if !escape_pressed andalso size str = 1 
          then 
            (escape_pressed := false;
             doit false;
             ignore(despatch_meta str);
             ())
        else
          (fdebug (fn _ =>
                   "Verify: start_pos is " ^ Int.toString start_pos ^
                   ", end_pos is " ^ Int.toString end_pos ^
                   ", write_pos is " ^ Int.toString (!write_pos) ^
                   ", string is '" ^ str ^ "'");
          if end_pos < !write_pos then
            write_pos := (!write_pos) - end_pos + start_pos + size str
          else if start_pos < !write_pos then
            write_pos := start_pos + size str
          else ();
          if end_pos < !write_pos 
            then write_pos := (!write_pos) - end_pos + start_pos + size str
          else if start_pos < !write_pos 
            then write_pos := start_pos + size str
          else ();
          doit true)
    in
      Capi.Text.add_handler (text, text_handler);
      Capi.Text.add_modify_verify (text,modifyVerify);
      {instream = instream,
       outstream = outstream,
       console_widget = textscroll,
       console_text = text,
       clear_input = clear_input,
       clear_console = clear_console,
       set_window=inThisWindow}
    end
end;

