(* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 *
 * Revision Log
 * ------------
 *
 * $Log: os_file_sys.sml,v $
 * Revision 1.3  1999/03/14 11:50:15  daveb
 * [Bug #190521]
 * Type of readDir has changed.
 *
 *  Revision 1.2  1996/10/03  15:22:57  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.1  1996/05/17  09:24:45  stephenb
 *  new unit
 *  Renamed from os_filesys inline with latest file name conventions.
 *
 *  Revision 1.2  1996/05/16  14:06:31  stephenb
 *  Update it to the full revised basis signature.
 *
 *  Revision 1.1  1996/05/08  11:59:36  stephenb
 *  new unit
 *  Changed name from filesys inline with lastest filename conventions.
 *
 * Revision 1.2  1996/04/30  14:06:49  stephenb
 * Add some missing functions.
 * In particular fileSize and modTime
 *
 * Revision 1.1  1996/04/18  11:42:00  jont
 * new unit
 *
 *  Revision 1.5  1996/04/01  11:28:27  stephenb
 *  Name change: FILE_SYS -> OS_FILE_SYS
 *
 *  Revision 1.4  1996/03/13  11:31:25  jont
 *  Remove duplicate sepcification of getDir as this upsets NJ
 *
 *  Revision 1.3  1996/03/12  14:50:11  matthew
 *  Adding chDir and getDir
 *
 *  Revision 1.2  1995/12/04  16:20:13  matthew
 *  Adding directory functions
 *
 *  Revision 1.1  1995/04/21  15:00:31  daveb
 *  new unit
 *  Moved here from utils.
 *
 * Revision 1.2  1995/04/12  13:21:41  jont
 * Change to FILE_SYS
 *
 * Revision 1.1  1995/01/25  17:02:32  daveb
 * new unit
 * The OS.FileSys structure from the basis.
 *
 *)

require "__position";
require "^.system.__time";

signature OS_FILE_SYS =
sig
  type dirstream

  val openDir : string -> dirstream
  val readDir : dirstream -> string option
  val rewindDir : dirstream -> unit
  val closeDir : dirstream -> unit

  val chDir : string -> unit
  val getDir : unit -> string

  val mkDir : string -> unit

  val rmDir : string -> unit

  val isDir : string -> bool

  val isLink : string -> bool

  val readLink : string -> string

  val fullPath : string -> string

  val realPath: string -> string

  val modTime  : string -> Time.time

  val fileSize : string -> Position.int

  val setTime : (string * Time.time option) -> unit

  val remove : string -> unit

  val rename : { old: string, new: string} -> unit

  datatype access_mode = A_READ | A_WRITE | A_EXEC

  val access : (string * access_mode list) -> bool

  val tmpName : unit -> string

  eqtype file_id

  val fileId : string -> file_id

  val hash : file_id -> word

  val compare : (file_id * file_id) -> order

end
