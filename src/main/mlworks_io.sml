(* io.sml the signature *)
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
 * $Log: mlworks_io.sml,v $
 * Revision 1.4  1999/02/03 15:20:27  mitchell
 * [Bug #50108]
 * Change ModuleId from an equality type
 *
*Revision 1.3  1998/02/06  15:39:46  johnh
*Automatic checkin:
*changed attribute _comment to '*'
*
 *  Revision 1.1.1.2  1997/11/25  20:02:08  daveb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 * Revision 1.19.2.1  1997/09/11  20:56:34  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.19  1997/05/27  09:45:28  johnh
 * [Bug #20033]
 * Pass 'silent' param to set_source_path_from_env.
 *
 * Revision 1.18  1997/05/12  15:50:59  jont
 * [Bug #20050]
 * Change name to MLWORKS_IO to avoid clash with basis.io
 *
 * Revision 1.17  1997/02/12  13:22:55  daveb
 * Review edit <URI:spring://ML_Notebook/Review/basics/*module.sml>
 * -- Added comment about NotSet exception.
 *
 * Revision 1.16  1996/04/17  10:14:25  jont
 * Add set_source_path_without_expansion for cases when realpath etc
 * should not be applied
 *
 * Revision 1.15  1995/04/20  19:22:01  daveb
 * Added a location argument to the set functions.
 *
Revision 1.14  1995/04/19  10:50:59  jont
Modifications to add object paths

Revision 1.13  1995/01/16  14:01:45  daveb
Replaced Directory type with string.

Revision 1.12  1994/02/24  10:41:56  daveb
Fixed types of set_pervasive_dir.

Revision 1.11  1994/02/08  11:42:25  daveb
set_source_path now takes a directory list.  The source path can never
be not set.

Revision 1.10  1994/02/01  15:17:19  daveb
Added  pervasive_library_id and builtin_library_id, made ModuleId an
eqtype, moved getenv functionality to a separate module, and moved\ntrans_home_name functionality to filename.

Revision 1.9  1993/08/17  17:55:07  daveb
Removed several functions that are now unused or moved to filename.

Revision 1.8  1993/05/28  14:33:47  nosa
Changed Option.T to Option.opt.

Revision 1.7  1993/05/05  16:40:28  jont
Added a trans_home_name function for translating filenames satarting with ~

Revision 1.6  1993/02/24  14:32:19  jont
Added get_pervasive_dir to get value of PERVASIVE_DIR environment variable

Revision 1.5  1992/09/02  12:21:52  richard
Moved the special names out of the compiler as a whole.

Revision 1.4  1992/08/19  18:56:09  davidt
Made changes to allow mo files to be copied.

Revision 1.3  1992/08/17  10:53:30  davidt
Took out input_line function (there is one in MLWorks.IO now).

Revision 1.2  1992/08/03  11:50:56  jont
Added ignore_line function

Revision 1.1  1992/07/22  15:34:30  jont
Initial revision
*)

signature MLWORKS_IO =
  sig
    type ModuleId
    type Location

    (* Base names for various special files *)

    val pervasive_library_name	: string
    val builtin_library_name	: string

    val pervasive_library_id	: ModuleId
    val builtin_library_id	: ModuleId

    (* The pervasive directory, source path and object path are set by reading
       the environment.  If the environment doesn't contain the information,
       for the source path, a default value is used. *)
    (* All the set* functions except set_source_path_without_expansion expand
       any tilde abbreviations and symbolic links on their arguments. They
       handle any BadHomeName exceptions, report an error, and raise
       Info.Stop instead. *)

    val get_source_path : unit -> string list
    val set_source_path : string list -> unit
    val set_source_path_without_expansion : string list -> unit
    val set_source_path_from_env : Location * bool -> unit
    val set_source_path_from_string : string * Location -> unit

    exception NotSet of string
    (* The NotSet exception is raised by get_pervasive_dir and
       get_object_path if the corresponding values have not been set. *)

    val get_pervasive_dir : unit -> string
    val set_pervasive_dir : string * Location -> unit
    val set_pervasive_dir_from_env : Location -> unit

    val get_object_path : unit -> string
    val set_object_path : string * Location -> unit
    val set_object_path_from_env : Location -> unit
  end
