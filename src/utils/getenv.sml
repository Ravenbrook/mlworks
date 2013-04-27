(*  GETENV FUNCTION
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
 *  $Log: getenv.sml,v $
 *  Revision 1.10  1997/11/06 12:52:11  johnh
 *  [Bug #30125]
 *  Add get_doc_dir.
 *
 * Revision 1.9  1997/03/27  14:16:16  daveb
 * [Bug #1990]
 * [Bug #1990]
 * Added get_version_setting.
 *
 * Revision 1.8  1996/11/14  15:09:22  jont
 * [Bug #1763]
 * Remove get_user_name from GETENV
 *
 * Revision 1.7  1996/10/24  11:30:20  johnh
 * [Bug #1426]
 * Added get_startup_dir to function list in signature.
 *
 * Revision 1.6  1996/06/24  11:51:02  daveb
 * Replaced Getenv.get_home_dir with Getenv.get_startup_filename and
 * Getenv.get_preferences_filename.
 *
 * Revision 1.5  1995/04/20  19:05:03  daveb
 * Added expand_home_dir.
 *
 * Revision 1.4  1995/04/19  10:58:17  jont
 * Add get_object_path
 *
 * Revision 1.3  1995/01/19  12:02:05  daveb
 * Moved functionality for parsing environment paths into getenv.sml.
 * Replaced Option structure with references to MLWorks.Option.
 *
 * Revision 1.2  1995/01/18  14:11:14  jont
 * Add separator value to interface
 *
 * Revision 1.1  1994/12/09  13:39:53  jont
 * new file
 *
 * Revision 1.2  1994/08/10  11:48:03  daveb
 * Added get_home_dir.
 *
 * Revision 1.1  1994/02/02  13:41:23  johnk
 * new file
 *
 *)

signature GETENV =
  sig
    val env_path_to_list: string -> string list

    val get_source_path: unit -> string option

    val get_startup_dir: unit -> string option

    val get_pervasive_dir: unit -> string option

    (* Gets the directory containing the help documentation.
     * Only used on Unix.
     *)
    val get_doc_dir: unit -> string option

    val get_version_setting: unit -> string option
    (* This returns the value bound to MLWORKS_VERSION.  This is used
       in <URI://MLWmain/__version.sml> to control the printing of 
       the version number. *)

    val get_startup_filename: unit -> string option
    (* This returns the name of the user's startup file. *)

    val get_preferences_filename: unit -> string option
    (* This returns the name of the file where saved preferences are kept. *)

    exception BadHomeName of string

    val expand_home_dir: string -> string

    val get_object_path: unit -> string option

  end;
