(* _editor.sml the functor *)
(*
$Log: _editor.sml,v $
Revision 1.40  1999/03/04 09:56:21  johnh
[Bug #30286]
Second arg to exec commands no longer need to include command name.

 * Revision 1.39  1998/03/23  14:36:50  jont
 * [Bug #30090]
 * Remove use of MLWorks.IO
 *
 * Revision 1.38  1997/10/31  10:13:21  johnh
 * [Bug #302333]
 * Change editor interface.
 *
 * Revision 1.37  1997/09/18  16:20:13  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.36  1997/05/02  16:59:11  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.35  1997/03/13  19:14:30  brianm
 * Bug fix for Bug ID 1803 - problems with empty dialog types.
 *
 * Revision 1.34  1996/11/06  12:50:03  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.33  1996/11/06  10:25:34  stephenb
 * [Bug #1719]
 * emacs_dialog: change the location of the socket from $HOME/.mlworks-server
 * to read MLWORKS_SERVER_FILE which defaults to /tmp/.$USER-mlworks-server
 * to avoid problems with creating sockets on an Andrew file system.
 *
 * Revision 1.32  1996/10/09  14:52:13  io
 * moving String from toplevel
 *
 * Revision 1.31  1996/08/11  18:41:50  brianm
 * [Bug #1528]
 * Minor correction to custom_server (& emacs_server in Unix).
 *
 * Revision 1.30  1996/08/09  12:55:31  daveb
 * [Bug #1536]
 * Word8Vector.vector no longer shares with string.
 *
 * Revision 1.29  1996/08/05  15:41:59  stephenb
 * Replace any functions in OldOs with ones from the new basis
 * and subsequently remove any reference to OldOs.
 *
 * Revision 1.28  1996/06/15  16:33:29  brianm
 * Modifications to add custom editor interface ...
 *
 * Revision 1.27  1996/05/15  10:59:08  stephenb
 * Update wrt UnixOS.SysErr -> UnixOS.Error.SysError change.
 *
 * Revision 1.26  1996/05/03  15:44:25  stephenb
 * UnixOS.close has moved to UnixOS.IO.close in line with POSIXification.
 *
 * Revision 1.25  1996/05/01  09:52:55  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.24  1996/04/29  15:32:46  matthew
 * removing MLWorks.Integer
 *
 * Revision 1.23  1996/03/26  13:23:45  stephenb
 * Update wrt to Unix->SysErr exception name change.
 *
 * Revision 1.22  1996/01/29  16:59:28  stephenb
 * unix.c reorganisation: change vfork_XXX to fork_XXX since vfork
 * isn't important as far as the user is concerned, all they are
 * after is a cheap fork and exec.
 *
Revision 1.21  1996/01/26  12:00:37  stephenb
Fix emacs server.

Revision 1.20  1996/01/19  16:54:55  stephenb
OS reorganisation: Since OS specific stuff is no longer
in the pervasive library, the editor functor needs the
new UnixOS structure as a parameter.

Revision 1.19  1995/10/23  12:51:08  daveb
Changed name of e-lisp highlight function to mlworks-highlight.

Revision 1.18  1995/10/20  16:43:48  daveb
Sent the emacs commands as separate S-expressions, to avoid buffer
overflow problems.

Revision 1.17  1995/10/02  13:23:44  daveb
Made emacs highlight errors.
Removed next_error and no_more_errors.

Revision 1.16  1995/01/13  17:14:02  daveb
Replaced Option structure with references to MLWorks.Option.

Revision 1.15  1994/12/08  18:04:03  jont
Move OS specific stuff into a system link directory

Revision 1.14  1994/08/03  09:24:12  matthew
Reinstate call to makestring

Revision 1.13  1994/08/02  16:26:01  daveb
Added support for user-defined editors.

Revision 1.12  1994/07/29  16:19:00  daveb
Moved preferences into separate structure.

Revision 1.11  1993/08/31  11:29:18  matthew
reversed arguments to kill
added handler for Unix exception

Revision 1.10  1993/08/27  17:20:41  matthew
Added call to Unix.kill

Revision 1.9  1993/08/25  15:06:30  matthew
Return quit function from ShellUtils.edit_string
Need to uncomment call to kill]

Revision 1.8  1993/06/04  14:12:35  daveb
Removed filename component of error result for edit functions.

Revision 1.7  1993/05/18  16:33:29  daveb
Changed Integer.makestring to MLWorks.Integer.makestring and removed
the Integer structure.

Revision 1.6  1993/04/22  13:00:22  richard
The editor interface is now implemented directly through
Unix system calls, and is not part of the pervasive library
or the runtime system.

Revision 1.5  1993/04/14  15:23:51  jont
Added editing from location. Added a function to do next error from a list

Revision 1.4  1993/04/08  17:42:49  jont
Modify edit and edit_from_location to use the relevant editor

Revision 1.3  1993/04/08  15:00:45  jont
Added options parameter

Revision 1.2  1993/03/23  18:35:09  jont
Changed editor implementastion slightly.

Revision 1.1  1993/03/10  17:24:30  jont
Initial revision

Copyright (C) 1993 Harlequin Ltd
*)

require "^.basis.__int";
require "^.basis.__byte";
require "^.basis.__string";
require "^.basis.os";
require "^.main.preferences";
require "^.basics.location";
require "^.utils.crash";
require "^.editor.editor";
require "^.editor.custom";
require "^.utils.lists";
require "unixos";

functor Editor
  (structure Preferences: PREFERENCES
   structure Crash : CRASH
   structure Location : LOCATION
   structure OS : OS
   structure UnixOS : UNIXOS
   structure CustomEditor : CUSTOM_EDITOR
   structure Lists : LISTS
  ) : EDITOR =
struct
    structure Location = Location

    type preferences = Preferences.preferences

    fun null_fun () = ()

    fun show_int (i) =
        if i < 0 then "-" ^ Int.toString(~i) else Int.toString(i)

    val member   = Lists.member

    (* Locations etc. *)

    fun line_from_location(Location.UNKNOWN) = 0
      | line_from_location(Location.FILE _) = 0
      | line_from_location(Location.LINE(_, i)) = i
      | line_from_location(Location.POSITION(_, i, _)) = i
      | line_from_location(Location.EXTENT{s_line=i, ...}) = i


    fun get_position_info (Location.EXTENT{s_line, s_col, e_line, e_col, ...}) =
        (s_line,s_col, e_line, e_col)

      | get_position_info (loc) = (line_from_location loc,0,~1,~1)


    (* Socket stuff *)


    (* Convert an integer into a two character string so that it can
     * be sent down a socket.  Probably should check that the 
     * pre-condition is satisified ...
     *
     * pre: i >= 0 /\ i <= 2^16
     *)
    fun marshal_int i = MLWorks.String.implode_char [i div 256, i mod 256]



    (* Write a string to the file descriptor which is attached to a socket.
     * As explained on page 279 of Unix Network Programming by Stevens,
     * just calling UnixOS.write(fd, msg, 0, len) would not guarantee
     * delivery of the whole message, generally due to kernel buffering.
     * Instead, you have to keep calling write until the whole string
     * has been sent.
     *)
    fun socket_write (fd, msg) =
      let
        val msg_len = size msg
	val vec = Byte.stringToBytes msg

        fun write (offset, len) =
          let val nwritten = UnixOS.write (fd , vec, offset, len)
	  in
            if nwritten < len then
              write (offset+nwritten, len-nwritten)
            else
              nwritten
          end
      in
        if write (0, msg_len) <> msg_len then
          raise UnixOS.Error.SysErr ("", NONE)
        else
          ()
      end


    (* Send a message down the file descriptor.  A message consists of a
     * two byte length followed by the string.
     *)
    fun socket_write_msg (fd, msg) =
      let val msg_len = size msg 
      in 
        socket_write (fd, marshal_int msg_len);
        socket_write (fd, msg)
      end



    (* Editor interfaces *)


    (* Argument Specifier Notation:
     * ============================
     *   %f =   filename
     *   %l =   %sl   = start line no.
     *   %c =   %sc   = start char no.
     *   %el =  end line no.
     *   %ec =  end char no.
     *   %%  =  % (percent)
     *)

    fun expand_args (fnm, st_l, st_c, e_l, e_c) =
        let fun trans(#"%" :: #"%" :: l, r) =
                  trans(l, "%" :: r)
              | trans(#"%" :: #"f" :: l, r) =
                  trans(l, fnm :: r)
              | trans(#"%" :: #"l" :: l, r) =
                  trans(l,show_int(st_l) :: r)
              | trans(#"%" :: #"s" :: #"l" :: l, r) =
                  trans(l,show_int(st_l) :: r)
              | trans(#"%" :: #"c" :: l, r) = trans(l,show_int(st_c) :: r)
              | trans(#"%" :: #"s" :: #"c" :: l, r) =
                  trans(l,show_int(st_c) :: r)
              | trans(#"%" :: #"e" :: #"l" :: l, r) =
                  trans(l,show_int(e_l) :: r)
              | trans(#"%" :: #"e" :: #"c" :: l, r) =
                  trans(l,show_int(e_c) :: r)
              | trans(c :: l, r) =
                  trans (l, (String.str c) :: r )
              | trans(_, r) =
                  String.concat (rev r) 

            fun doit str = trans(explode str,[])
        in
            doit
        end

    fun transEntry loc_details (server,commands) =
      let 
	val translate = expand_args loc_details
      in
        (server, map translate commands)
      end

    (* Emacs server & commands *)

    val standard_emacs_commands =
        let val find_file = "(find-file \"%f\")"
            val goto_line = "(goto-line %sl)"
            val fwd_char  = "(forward-char %sc)"
            val highlight = "(mlworks-highlight %sl %sc %el %ec)"
            val raise_win = "(raise-this-window)"

            val startup_cmds = [find_file, goto_line, fwd_char]

            val full_dialog  = [find_file, goto_line, fwd_char, highlight, raise_win]
        in
            CustomEditor.addConnectDialog ("Emacs", "Emacs", full_dialog);
            (startup_cmds,[highlight],[raise_win])
        end;


    (* Adding Vi command as a custom editor *)

    val _ = CustomEditor.addCommand ("Vi","xterm -name visual -e %f");


    (* Emacs Dialog support *)

    (* Keep this consistent with, the mechanism in the mlworks-server
     * <URI:hope://MLWsrc/emacs/etc/mlworks-server.c#init_socket_path>
     *)
    fun getSocketName ():string option =
      case OS.Process.getEnv "MLWORKS_SERVER_FILE" of
        SOME fileName => SOME fileName
      | NONE => 
          (case OS.Process.getEnv "USER" of
             SOME userName => SOME (concat ["/tmp/.", userName, "-mlworks-server"])
           | NONE => NONE)


    fun emacs_dialog (commands) =
        let val s   = UnixOS.socket (UnixOS.af_unix, UnixOS.sock_stream, 0)
            val cmd = concat ("(progn " :: (commands @ [")"]))
        in
          case getSocketName () of
            SOME socketName => 
              ((UnixOS.connect (s, UnixOS.SOCKADDR_UNIX socketName);
                (*
                 * should check that the length of the message is less
                 * than the allowed maximum.
                 *)
                socket_write_msg (s, cmd);
                UnixOS.IO.close s;
                (NONE, null_fun)
              )
              handle
                UnixOS.Error.SysErr _ =>
                  (UnixOS.IO.close s;
                   (SOME "Unable to contact MLWorks Emacs server", null_fun)
                  ))
          | NONE =>
             (SOME "Unable to determine socket name, check MLWORKS_SERVER_FILE setting", null_fun)
        end
        handle
           UnixOS.Error.SysErr _ =>
              (SOME "Unable to contact MLWorks Emacs server", null_fun)

    fun xterm parsed_command =
      let
        val pid = 
          (UnixOS.fork_execvp
             ("xterm", ["-name", "visual", "-e"] @ parsed_command))
      in
        (NONE,fn () =>
         UnixOS.kill (pid,9)
         handle UnixOS.Error.SysErr _ => ())
      end
      handle UnixOS.Error.SysErr _ =>
        (SOME ("Unable to launch xterm editor processes"),null_fun)


    fun do_command (command :: args) =
      (let val pid = UnixOS.fork_execvp (command, args)
       in
         (NONE,
          fn () =>
             (UnixOS.kill (pid,9)
                handle UnixOS.Error.SysErr _ => ()
             )
         )
       end
          handle UnixOS.Error.SysErr _ =>
             (SOME ("Unable to launch editor process"),null_fun)
      )

    |  do_command nil = (SOME "No editor command specified", null_fun)

    local
       val wsp = [ #" ", #"\t", #"\n" ]

       fun scan (c :: s, [], lst) =
           if member (c,wsp) then scan (s,[],lst)
           else scan (s,[String.str c],lst)

         | scan (c :: s, tok, lst) =
           if member (c,wsp) then scan (s,[],concat(rev tok)::lst)
           else scan (s,(String.str c)::tok,lst)

         | scan ([],[],lst)  = rev lst
         | scan ([],tok,lst) = rev (concat(rev tok) :: lst)
    in

       fun parse_command (string) = scan (explode string, [], [])

    end


    (* this function provides an external editor - by launching an editor
       each time it is needed - a `one-shot' editor.
    *)
    fun external_server extCmd (string, s_l, s_c, e_l, e_c) =
        let val translate = expand_args (string, s_l, s_c, e_l, e_c)
            val cmds      = parse_command (translate extCmd)
        in
            do_command ( cmds )
        end

    fun one_way_server customName loc_details = 
      let 
	val translate = expand_args loc_details
	val cmd = translate (CustomEditor.getCommandEntry customName)

	val cmd_result = 
	  if (cmd <> "") then do_command (parse_command cmd)
	  else (SOME "invalid choice for editor", null_fun)
      in
	cmd_result
      end

    fun two_way_server customName loc_details =
      let
	val (dialog_type, commands) = 
	  transEntry loc_details (CustomEditor.getDialogEntry customName)

	val (service, topic, commands) = 
	  case commands of 
	    s::t::cmds => (s,t,cmds)
	  | _ => ("","",commands)
      in
	case dialog_type of 
	  "Emacs" => emacs_dialog commands
	| _ => (SOME ("Unknown custom dialog type : " ^ dialog_type), null_fun)
      end

    fun edit
          (Preferences.PREFERENCES
             {editor_options=Preferences.EDITOR_OPTIONS
                {editor, externalEditorCommand, oneWayEditorName, twoWayEditorName, ...},
              ...})
          (string, i) =
        case !editor of
          "External" =>
             external_server (!externalEditorCommand) (string, i, 0, ~1, ~1)

        | "OneWay" =>
             one_way_server (!oneWayEditorName) (string, i, 0, ~1, ~1)

        | "TwoWay" =>
             two_way_server (!twoWayEditorName) (string, i, 0, ~1, ~1)

        | opt => Crash.impossible ("Unknown option `" ^ opt ^ "'")


    fun edit_from_location
          (Preferences.PREFERENCES
             {editor_options=Preferences.EDITOR_OPTIONS
                {editor, externalEditorCommand, oneWayEditorName, twoWayEditorName, ...},
              ...})
          (string, location) =
        let val (s_l, s_c, e_l, e_c) = get_position_info location
        in
           case !editor of
             "External" =>
                 external_server (!externalEditorCommand) (string, s_l, s_c, e_l, e_c)

           | "OneWay" =>
                 one_way_server (!oneWayEditorName) (string, s_l, s_c, e_l, e_c)

           | "TwoWay" =>
                 two_way_server (!twoWayEditorName) (string, s_l, s_c, e_l, e_c)

           | opt => Crash.impossible ("Unknown option `" ^ opt ^ "'")
        end


    fun show_location
          (Preferences.PREFERENCES
             {editor_options=Preferences.EDITOR_OPTIONS
                {editor, externalEditorCommand, oneWayEditorName, twoWayEditorName, ...},
              ...})
          (string, location) =
        let val (s_l, s_c, e_l, e_c) = get_position_info location
        in
           case !editor of
             "External" =>
                 (SOME("show location requires emacs"), null_fun)

           | "OneWay" =>
                 one_way_server (!oneWayEditorName) (string, s_l, s_c, e_l, e_c)

           | "TwoWay" =>
                 two_way_server (!twoWayEditorName) (string, s_l, s_c, e_l, e_c)

           | opt => Crash.impossible ("Unknown option `" ^ opt ^ "'")
        end
end
