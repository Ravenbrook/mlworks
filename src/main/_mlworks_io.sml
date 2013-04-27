(* _io.sml the functor *)
(*
$Log: _mlworks_io.sml,v $
Revision 1.5  1998/03/31 11:44:36  jont
[Bug #70077]
Remove use of Path, and replace with OS.Path

*Revision 1.4  1998/02/19  17:01:01  mitchell
*[Bug #30349]
*Fix to avoid non-unit sequence warnings
*
*Revision 1.3  1998/02/06  15:42:02  johnh
*Automatic checkin:
*changed attribute _comment to '*'
*
 *  Revision 1.1.1.2  1997/11/25  19:59:35  daveb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 * Revision 1.50.2.1  1997/09/11  20:57:08  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.50  1997/05/27  09:01:29  johnh
 * [Bug #20033]
 * Pass 'silent' param to set_source_path_from_env.
 *
 * Revision 1.49  1997/05/19  11:09:11  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.48  1997/05/12  15:55:06  jont
 * [Bug #20050]
 * Change name to MLWorksIO to avoid clash with basis.io
 *
 * Revision 1.47  1997/05/01  13:14:53  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.46  1997/03/06  14:14:32  jont
 * [Bug #1940]
 * Modify set_pervasive_dir such that bad pervasive dirs merely warn.
 * Do similar modifications for setting source and object paths
 *
 * Revision 1.45  1996/10/29  17:04:43  io
 * moving String from toplevel
 *
 * Revision 1.44  1996/07/11  17:03:41  jont
 * Handle OS.SysErr in set_source_path
 *
 * Revision 1.43  1996/05/23  12:16:41  stephenb
 * Replace OS.FileSys.realPath with OS.FileSys.fullPath since the latter
 * now does what the former used to do.
 *
 * Revision 1.42  1996/05/21  11:33:24  stephenb
 * Change to pull in Path directly rather than OS.Path since the latter
 * now conforms to the latest basis and it is too much effort to update
 * the code to OS.Path at this point.
 *
 * Revision 1.41  1996/04/30  14:37:16  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.40  1996/04/18  15:18:55  jont
 * initbasis moves to basis
 *
 * Revision 1.39  1996/04/17  14:36:27  stephenb
 * Update wrt Os -> OS name change.
 *
 * Revision 1.38  1996/04/17  10:20:54  jont
 * Ensure set_source_path does realpath expansion
 *
 * Revision 1.37  1996/03/27  10:11:22  stephenb
 * Update to use the OS structure from the latest revised basis.
 *
 * Revision 1.36  1996/03/25  17:35:42  jont
 * Print message when setting object path from environment
 *
 * Revision 1.35  1996/03/15  14:35:38  daveb
 * Fixed use of Info.default_options.
 *
 * Revision 1.34  1995/12/05  11:04:14  daveb
 * Added space to beginning of pervasive module names.
 * Changed ModuleId.from_string to ModuleId.from_mo_string.
 *
Revision 1.33  1995/04/21  16:53:43  jont
Remove FileSys.realPath call from set_object_path (delayed application required)

Revision 1.32  1995/04/21  14:33:20  daveb
The path setting functions now handle the BadHomeName exception
themselves, and take a location argument.
Expansion of home dirs has moved from filesys to getenv.
filesys and path have moved from utils to initbasis.

Revision 1.31  1995/04/19  12:35:15  jont
Modifications to add object paths

Revision 1.30  1995/04/12  13:28:41  jont
Change FILESYS to FILE_SYS

Revision 1.29  1995/01/25  17:27:50  daveb
Moved functionality for parsing environment paths into getenv.sml.
Replaced Option structure with references to MLWorks.Option.

Revision 1.28  1995/01/23  17:50:38  jont
Ensure preceding spaces are removed from pervasive_dir environment values

Revision 1.27  1995/01/18  14:06:38  jont
Parameterise environment value separator on getenv

Revision 1.26  1994/12/08  16:56:01  jont
Move OS specific stuff into a system link directory

Revision 1.25  1994/02/24  11:04:20  daveb
Fixed types of set_pervasive_dir.

Revision 1.24  1994/02/09  09:41:34  matthew
Fixed NJ type bug

Revision 1.23  1994/02/08  15:16:30  daveb
source_path is no longer a list option ref, just a list ref.
set_source_path takes a directory list argument.  Other set_source_path
functions call FileName.parse_directory, thus ensuring expansion.

Revision 1.22  1994/02/01  15:16:55  daveb
Added  pervasive_library_id and builtin_library_id, made ModuleId an
eqtype, moved getenv functionality to a separate module, and moved\ntrans_home_name functionality to filename.

Revision 1.21  1993/11/19  18:22:38  daveb
Ensured that pervasive dir always undergoes ~ translation and ends in /.

Revision 1.20  1993/11/18  14:43:03  nickh
Change when "Setting pervasive dir..." message is printed, to make
MLWorks startup less intimidating.

Revision 1.19  1993/11/16  16:02:30  jont
Made set_pervasive_dir call trans_home_name on its argument

Revision 1.18  1993/10/27  14:03:56  daveb
Ensured entries in source path have a trailing /, for Unix.

Revision 1.17  1993/08/29  18:30:30  daveb
Expand "." in environment variables.
Capitalised messages.

Revision 1.16  1993/08/25  12:58:26  daveb
Changed pervasive_dir to be optional.  Raises NotSet if it's not set.

Revision 1.15  1993/08/25  11:21:52  daveb
Check for empty UNIX environment variables.
Change variable names to be less than 19 characters, or else csh complains.
Print message when setting variables from the environment.

Revision 1.14  1993/08/19  14:39:26  daveb
Added MLWORKS_ to the start of UNIX environment variables.

Revision 1.13  1993/08/18  12:58:22  daveb
Fix to work around bug in SML/NJ.  Also removed two debugging statements.

Revision 1.12  1993/08/12  16:51:49  daveb
Removed several functions that are now unused or moved to filename.

Revision 1.11  1993/06/17  14:33:58  richard
Tilde expansion now uses MLWorks.OS.Unix.getpwnam system call.

Revision 1.10  1993/05/05  17:16:46  jont
Added a trans_home_name function for translating filenames satarting with ~

Revision 1.9  1993/02/24  14:32:14  jont
Added get_pervasive_dir to get value of PERVASIVE_DIR environment variable

Revision 1.8  1992/09/02  14:22:01  richard
Moved the special names out of the compiler as a whole.

Revision 1.7  1992/08/21  14:23:10  richard
Corrected relative_name to accept paths not ending in `/'.

Revision 1.6  1992/08/20  15:02:19  davidt
Made changes to allow mo files to be copied.

Revision 1.5  1992/08/20  12:44:37  richard
Changed default pervasive library path to use pervasives
directory.

Revision 1.4  1992/08/17  14:02:31  davidt
Took out input_line function (there is one in MLWorks.IO now).

Revision 1.3  1992/08/10  11:33:10  davidt
String structure is now pervasive.

Revision 1.2  1992/08/03  11:53:05  jont
Added ignore_line function

Revision 1.1  1992/07/22  15:35:35  jont
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

require "../basis/os";
require "../basis/os_path";
require "../main/info";
require "../basics/module_id";
require "../utils/getenv";
require "mlworks_io";

functor MLWorksIo(
  structure OS : OS
  structure Path : OS_PATH
  structure Info: INFO
  structure ModuleId: MODULE_ID
  structure Getenv : GETENV

  sharing type Info.Location.T = ModuleId.Location

  val pervasive_library_name : string
  val builtin_library_name : string
  val default_source_path : string list
) : MLWORKS_IO =
  struct
    type ModuleId = ModuleId.ModuleId
    type Location = Info.Location.T

    val pervasive_library_name = " " ^ pervasive_library_name
    val builtin_library_name = " " ^ builtin_library_name

    (* The module_id's are converted with from_mo_string, because they
       contain leading spaces. *)
    val pervasive_library_id =
      ModuleId.from_mo_string
	(pervasive_library_name, Info.Location.FILE "<Initialisation>")

    val builtin_library_id =
      ModuleId.from_mo_string
	(builtin_library_name, Info.Location.FILE "<Initialisation>")
      
    exception NotSet of string

    fun remove_spaces ("",_) = ""
      | remove_spaces(arg as (str, n)) =
	if MLWorks.String.ordof arg = ord #" " then
	  remove_spaces(str, n+1)
	else if n = 0 then 
	  str
	else 
	  substring (* could raise Substring *)(str, n, size str - n)
	    
    local
      val source_path = ref ([] : string list)
    in
      fun set_source_path_without_expansion l =
	source_path := l

      fun set_source_path(l, location) =
	let
	  val expand_path = OS.FileSys.fullPath o Getenv.expand_home_dir
	  fun map_sub(acc, []) = rev acc
	    | map_sub(acc, x::xs) =
	      let
		val s = expand_path x
	      in
		map_sub(s::acc, xs)
	      end
	    handle
	    OS.SysErr _ =>
	      (Info.error (Info.make_default_options())
	       (Info.WARNING, location,
		"Bad path '" ^ x ^ "', ignoring");
	       map_sub(acc, xs))
	    | Getenv.BadHomeName s =>
	      (Info.error (Info.make_default_options())
	       (Info.WARNING, location,
		"Problem expanding source path - "
		^ "can't find home directory for " ^ s);
	       map_sub(acc, xs))
	  val expanded = map_sub([], l)
	in
	  case expanded of
	    [] => false
	  | _ => (set_source_path_without_expansion expanded; true)
	end

      fun set_source_path_from_string(s, location) =
	let
	  val old_source_path = !source_path
	in
	  set_source_path(Getenv.env_path_to_list s, location)
	  handle
          Getenv.BadHomeName s =>
            (Info.error (Info.make_default_options())
	     (Info.WARNING, location,
	      "Problem expanding source path - "
	      ^ "can't find home directory for " ^ s);
	     set_source_path_without_expansion old_source_path;
	     false)
	end

      fun set_source_path_from_env (location, silent) =
	(* Note, no handlers needed here, as set_source_path *)
	(* and set_source_path_from_string handle it all *)
	case Getenv.get_source_path() of
	  NONE =>
	    (ignore(set_source_path
	     (map
	      (fn s => (remove_spaces(s,0)))
	      default_source_path, location));
	     ())
	| SOME str =>
	    (if set_source_path_from_string(str, location) andalso (not silent) then
	       print("Setting source path to: " ^ str ^ "\n")
	     else
	       ())

      val set_source_path_from_string =
	fn arg => (ignore(set_source_path_from_string arg); ())
      val set_source_path = fn s => (ignore(set_source_path(s, Info.Location.UNKNOWN)); ())
      fun get_source_path () = (!source_path)
    end

    local
      (* We need the type constraints since NJ 0.75 doesn't handle locals
	 properly *)

      val pervasive_dir =
	ref NONE : string option ref
      
      val object_path =
	ref (SOME(Path.concat["%S", "%C"])) :
	  string option ref

    in
      fun get_pervasive_dir () =
	case !pervasive_dir
	of SOME str => str
	|  NONE => raise NotSet "pervasive_dir"

      fun set_pervasive_dir (s, location) =
        pervasive_dir := SOME
	  (OS.FileSys.fullPath (Getenv.expand_home_dir s))
        handle
          Getenv.BadHomeName s =>
            Info.error (Info.make_default_options())
	      (Info.WARNING, location,
	       "Problem expanding pervasive directory - "
	       ^ "can't find home directory for " ^ s)
	     | OS.SysErr _ =>
		 Info.error (Info.make_default_options())
		 (Info.WARNING, location,
	       "Problem setting pervasive directory - "
	       ^ s ^ " is not a valid path")

      fun set_pervasive_dir_from_env location =
        case Getenv.get_pervasive_dir () of
	  SOME s =>
	    set_pervasive_dir (remove_spaces (s,0), location)
        | NONE => ()

      fun print_pervasive_dir () = 
	case !pervasive_dir of
	  SOME str => 
	    print("Pervasive directory set to: " ^ str ^ "\n")
	| NONE =>
	    print("Pervasive directory not set.\n")

      fun get_object_path () =
	case !object_path
	of SOME str => str
	|  NONE => raise NotSet "object_path"

      fun set_object_path(s, location) =
        (object_path := SOME
	 (Getenv.expand_home_dir s); true)
        handle
          Getenv.BadHomeName s =>
            (Info.error (Info.make_default_options())
	     (Info.WARNING, location,
	      "Problem expanding object path - "
	      ^ "can't find home directory for " ^ s);
	     false)

      fun set_object_path_from_env location =
        case Getenv.get_object_path() of
	  SOME s =>
	    if set_object_path(remove_spaces(s,0), location) then
	      print("Setting object path to: " ^ s ^ "\n")
	    else
	      ()
        |  NONE => ()

      val set_object_path = fn arg => (ignore(set_object_path arg); ())
    end

    val _ = (set_pervasive_dir_from_env (Info.Location.FILE "main/_io.sml");
	     print_pervasive_dir ())
  end
