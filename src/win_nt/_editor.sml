(* _editor.sml the functor *)
(*
$Log: _editor.sml,v $
Revision 1.40  1998/03/30 15:17:19  jont
[Bug #70086]
Update type of "dde send execute string" to return unit and simplify

 * Revision 1.39  1998/03/23  16:28:31  jont
 * [Bug #30090]
 * Replace use of MLWorks.IO.Io with syserr
 *
 * Revision 1.38  1997/10/31  09:42:14  johnh
 * [Bug #30233]
 * Change CustomEditor interface to make connectDialogs distinct from custom commands.
 *
 * Revision 1.37  1997/09/19  09:33:50  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.36  1997/08/25  10:47:36  johnh
 * [Bug #30220]
 * Put quotes around %f parameter.
 *
 * Revision 1.35  1997/08/22  09:02:52  johnh
 * [Bug #30220]
 * Putting quotes around full filename for external editor.
 *
 * Revision 1.34  1997/07/30  10:54:29  johnh
 * [Bug #30220]
 * Using Wordpad instead of Textpad.
 *
 * Revision 1.33  1997/05/01  13:21:08  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.32  1997/03/13  19:14:37  brianm
 * Bug fix for Bug ID 1803 - problems with empty dialog types.
 *
 * Revision 1.31  1996/11/06  11:37:18  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.30  1996/10/30  20:33:02  io
 * [Bug #1614]
 * remove toplevel String
 *
 * Revision 1.29  1996/08/26  12:24:55  brianm
 * Added local default editor options ...
 *
 * Revision 1.28  1996/08/11  18:43:36  brianm
 * [Bug #1528]
 * Minor correction to custom_server.
 *
 * Revision 1.27  1996/06/15  15:30:09  brianm
 * Modifications to add custom editor interface ...
 *
 * Revision 1.26  1996/05/30  15:16:47  daveb
 * The Io exception is no longer at top level.
 *
 * Revision 1.25  1996/05/01  12:12:34  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.24  1996/04/30  13:26:36  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.23  1996/04/22  15:22:43  brianm
 * Adding support for TextPad ...
 *
 * Revision 1.22  1996/04/16  09:12:40  brianm
 * Adding PFE support via DDE ...
 *
 * Revision 1.21  1996/03/28  15:25:23  stephenb
 * Remove the Os argument since it is not currently used.
 *
 * Revision 1.20  1996/01/19  15:17:28  stephenb
 * OS reorganisation: Remove all the Unix specific stuff since
 * this never worked and since the Unix structure is no longer
 * part of the pervasive library won't even compile.
 *
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
Need to uncomment call to kill

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

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "$.basis.__int";
require "$.basis.__string";

require "../main/preferences";
require "../basics/location";
require "../editor/editor";
require "../editor/custom";
require "../utils/lists";
require "../utils/crash";

require "win32";


functor Editor
  (structure Preferences: PREFERENCES
   structure Location : LOCATION
   structure Win32    : WIN32
   structure CustomEditor : CUSTOM_EDITOR
   structure Lists : LISTS
   structure Crash : CRASH
  ) : EDITOR =
struct
    structure Location = Location

    type preferences = Preferences.preferences
      

    (* Setting Win32 Default Editor Options *)

    local
        open Preferences
        val EDITOR_OPTIONS {editor, oneWayEditorName, 
			    twoWayEditorName, externalEditorCommand} =
            default_editor_options
    in
        val _ =
          ( editor                 := "External";
            oneWayEditorName       := "Wordpad";
            twoWayEditorName       := "PFE32";
            externalEditorCommand  := 
		"\"C:\\Program Files\\Accessories\\Wordpad.exe\" \"%f\""
          )
    end

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
	let fun trans (#"%" :: #"%" :: l, r) =
                  trans(l, "%" :: r)
	      | trans (#"%" :: #"f" :: l, r) =
                  trans(l, fnm :: r)
	      | trans (#"%" :: #"l" :: l, r) =
                  trans(l, show_int(st_l) :: r)
	      | trans (#"%" :: #"s" :: #"l" :: l, r) =
                  trans(l, show_int(st_l) :: r)
	      | trans (#"%" :: #"c" :: l, r) =
                  trans(l, show_int(st_c) :: r)
	      | trans (#"%" :: #"s" :: #"c" :: l, r) =
                  trans(l, show_int(st_c) :: r)
	      | trans (#"%" :: #"e" :: #"l" :: l, r) =
                  trans(l, show_int(e_l) :: r)
	      | trans (#"%" :: #"e" :: #"c" :: l, r) =
                  trans(l, show_int(e_c) :: r)
	      | trans (c :: l, r) =
                  trans (l, (String.str c)::r)
              | trans (_, r) =
                  concat (rev r) 

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


    (* Dynamic Data Exchange interface -- execute strings only *)

    type dde_data = word;

    local

       val env  = MLWorks.Internal.Runtime.environment

    in
       val start_dde_dialog : (string * string) -> dde_data =
	   env "dde start dialog";

       val send_dde_execute_string : (dde_data * string * int * int) -> unit =
	   env "dde send execute string";

       val stop_dde_dialog : dde_data -> unit =
	   env "dde stop dialog";
    end

    fun dde_dialog ("", "", _) =
            ( SOME ("Unspecified service & topic for DDE server"), null_fun )

      | dde_dialog ("", _, _) =
            ( SOME ("Unspecified service for DDE server"), null_fun )

      | dde_dialog (_, "", _) =
            ( SOME ("Unspecified topic for DDE server"), null_fun )

      |  dde_dialog (service, topic, cmds) =
	let val busy_retries = 20    (* max number of busy retries *)
	    val delay = 200          (* milliseconds *)

	    val dde_info = start_dde_dialog (service,topic)
	      handle MLWorks.Internal.Error.SysErr(msg, err) =>
		raise MLWorks.Internal.Error.SysErr("Unable to contact " ^ service ^ " DDE server", err)
	    fun exec_dde s =
		send_dde_execute_string (dde_info,s,busy_retries,delay)

	    fun doit (s :: lst) = (exec_dde(s) ; doit lst)
	      | doit [] = stop_dde_dialog dde_info
	in
	      doit cmds;
	      (NONE, null_fun)
	end
	handle
	MLWorks.Internal.Error.SysErr(msg, _) => (SOME msg, null_fun)



    (* PFE interface *)

    val standard_pfe_commands =
        let val file_open   = "[FileOpen(\"%f\")]"
            val file_visit  = "[FileVisit(\"%f\")]"

            val goto_line   = "[EditGotoLine(%sl,0)]"
            val fwd_char    = "[CaretRight(%sc,0)]"
            val highlight   = "[EditGotoLine(%el,1)][CaretRight(%ec,1)]"

            val display_cmds = [goto_line, fwd_char, highlight]
            val full_dialog  = file_open :: display_cmds

        in
 
	   CustomEditor.addConnectDialog("PFE32", "DDE", "PFE32" :: "Editor" :: full_dialog);
           (file_open, file_visit, display_cmds)

        end


    fun pfe_server (fname, st_l, st_c, e_l, e_c, edit_file) =
        let val service = "PFE32"

	    val topic =   "Editor"

            val (openf,viewf,display_cmds) = standard_pfe_commands

            val dialog = if edit_file then openf :: display_cmds
                         else viewf :: display_cmds

            val translate = expand_args (fname,st_l,st_c,e_l,e_c)
        in
            dde_dialog (service, topic, map translate dialog)
        end

    (* TextPad and Wordpad interfaces *)


    val _ = let 
	      val wordpad_cmd = "\"C:\\Program Files\\Accessories\\Wordpad.exe\" \"%f\""
	      val textpad_cmd = "\"C:\\TextPad\\DDEOPN32.EXE\" TextPad %f(%sl,%sc)"
	    in
	      CustomEditor.addCommand("TextPad", textpad_cmd);
	      CustomEditor.addCommand("Wordpad", wordpad_cmd)
	    end;

    fun do_command (s) =
        (
	  (* launch Win32 process (HIGH pri.) *)
	  if not(Win32.create_process(s,Win32.HIGH)) then 
	    (SOME "Can't execute editor process\n", null_fun)
	  else 
            (NONE, null_fun)
        )

    (* this function provides an external editor - by launching an editor
       each time it is needed - a `one-shot' editor.
    *)
    fun external_server extCmd (string, s_l, s_c, e_l, e_c) =
	let val translate = expand_args (string, s_l, s_c, e_l, e_c)
	in
	    do_command ( translate extCmd )
	end

    fun one_way_server customName loc_details = 
      let 
	val translate = expand_args loc_details
	val cmd = translate (CustomEditor.getCommandEntry customName)

	val cmd_result = 
	  if (cmd <> "") then do_command cmd
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
	  "DDE"	=> dde_dialog (service, topic, commands)
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
