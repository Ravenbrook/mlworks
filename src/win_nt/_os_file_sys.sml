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
 * $Log: _os_file_sys.sml,v $
 * Revision 1.14  1999/03/14 12:12:56  daveb
 * [Bug #190521]
 * OS.FileSys.readDir now returns an option type.
 *
 *  Revision 1.13  1999/02/02  16:02:11  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.12  1998/08/13  10:22:54  jont
 *  [Bug #30468]
 *  Change types of mkAbsolute and mkRelative to uses records with names fields
 *
 *  Revision 1.11  1998/06/17  12:47:28  johnh
 *  [Bug #50083]
 *  Change opendir to add '/*' in runtime function.
 *
 *  Revision 1.10  1997/05/21  10:22:10  stephenb
 *  [Bug #30142]
 *  Change the dir_handle from an int to a Word32.word ref.
 *
 *  Revision 1.9  1997/04/02  09:20:31  johnh
 *  [Bug #2006]
 *  Made readDir return a non-canonical path so that it can be tested
 *  against the empty string when the end of a directory has been reached.
 *
 *  Revision 1.8  1997/03/31  13:15:19  johnh
 *  [Bug #1967]
 *  Added calls to Path.mkCanonical.
 *
 *  Revision 1.7  1996/10/30  20:32:19  io
 *  [Bug #1614]
 *  remove toplevel String.
 *
 *  Revision 1.6  1996/10/21  15:24:45  jont
 *  Remove references to basis.toplevel
 *
 *  Revision 1.5  1996/06/13  11:34:12  stephenb
 *  Implement isDir and setTime.
 *
 *  Revision 1.3  1996/06/06  08:40:28  stephenb
 *  OS.FileSys.{open,read,rewind,close}Dir are now pulled through directly
 *  from the runtime rather than via Win32.  This is because they have
 *  been reimplemented in the runtime and there is now no point in pulling
 *  them through Win32 first.
 *
 *  Revision 1.2  1996/06/04  12:44:19  stephenb
 *  Add more functions to support the latest revised basis definition.
 *
 *  Revision 1.1  1996/05/17  09:31:26  stephenb
 *  new unit
 *  Renamed from _win_ntfilesys in line with latest file name conventions.
 *
 * Revision 1.12  1996/05/16  15:52:47  stephenb
 * Add a bunch of stubs so that it at least looks like it implements
 * the OS_FILE_SYS interface.
 *
 * Revision 1.11  1996/05/08  12:31:03  stephenb
 * Rename filesys to be os_filesys in line with latest file naming conventions.
 *
 * Revision 1.10  1996/05/01  09:22:58  stephenb
 * Add some more missing functions.
 * Specifically: fileSize and modTime
 *
 * Revision 1.9  1996/04/18  15:26:07  jont
 * initbasis moves to basis
 *
 * Revision 1.8  1996/03/28  13:58:49  stephenb
 * FILE_SYS -> OS_FILE_SYS
 *
 * Revision 1.7  1996/03/12  15:42:48  matthew
 * Adding chDir and setDir
 *
 * Revision 1.6  1996/01/18  16:23:58  stephenb
 * OS reorganisation: Since the pervasive library no longer
 * contains OS specific stuff, parameterise the functor with
 * the Win32 structure.
 *
 * Revision 1.5  1996/01/15  14:44:55  matthew
 * Adding directory functions
 *
 * Revision 1.4  1995/12/04  16:28:34  matthew
 * Adding directory functions
 *
 * Revision 1.3  1995/04/20  19:43:48  daveb
 * filesys moved from utils to initbasis..
 * Changed names to match intial basis.
 * Moved BadHomeName to getenv.
 *
 * Revision 1.2  1995/04/12  13:30:46  jont
 * Change FILESYS to FILE_SYS
 *
 * Revision 1.1  1995/01/25  17:15:41  daveb
 * new unit
 * The OS.FileSys structure from the basis.
 *
 *)

require "^.basis.os_path";
require "^.basis.os_file_sys";
require "^.basis.__word";
require "^.basis.__word32";
require "^.basis.__string";
require "^.basis.__word";
require "__time";
require "win32";


functor OSFileSys 
  (structure Win32: WIN32
   structure Path : OS_PATH): OS_FILE_SYS =
struct
  val env = MLWorks.Internal.Runtime.environment


  (* If you make any changes to the dirstream types make sure that
   * you also make appropriate changes to rts/src/OS/Win32/win32.c
   *)


  (* This is a Win32 HANDLE. *)
  type dir_handle = Word32.word


  (* There are a number of ways the dirstream could be represented in ML
   * which take into account the two important issues about the type :-
   *
   * a) there is no equivalent of rewinddir in the Win32 interface
   *    and so to achieve it you need to close the handle and reopen it.
   * b) it is inherently imperative i.e. the directory handle and 
   *    filename need to change behind the scenes.
   * 
   * To deal with a) the directory name is stored in the dirstream so that
   * it is available in case a rewind is called.
   *
   * To deal with b) the file name and dir handle are refs.
   *)
  datatype dirstream = DIRSTREAM of string * dir_handle ref * string ref

  val openDir : string -> dirstream = env "OS.FileSys.openDir"

  val readDir : dirstream -> string option = env "OS.FileSys.readDir"

  val rewindDir : dirstream -> unit = env "OS.FileSys.rewindDir"

  val closeDir : dirstream -> unit = env "OS.FileSys.closeDir"

  val chDir : string -> unit = env "OS.FileSys.chDir"

  local
    val getDir' : unit -> string = env "OS.FileSys.getDir"
  in
    fun getDir () = Path.mkCanonical (getDir' ())
  end

  val mkDir : string -> unit = env "OS.FileSys.mkDir"

  val rmDir : string -> unit = env "OS.FileSys.rmDir"

  val isDir : string -> bool = env "OS.FileSys.isDir"

  fun isLink _ = false  (* Win32 doesn't support links *)

  fun readLink _ = raise Win32.SysErr ("Win32 does not support links", NONE)

  local
    val fullPath' : string -> string = env "OS.FileSys.fullPath"
  in
    fun fullPath s = Path.mkCanonical (fullPath' s)
  end

  (* This is just the same implementation as given in the Mar 1996 basis
   * document except for the fact that Path is not caught as per the 
   * change described in the 19th April 1996 email to the basis group.
   *)
  fun realPath p = 
    if Path.isAbsolute p
    then fullPath p
    else Path.mkRelative {path=fullPath p, relativeTo=fullPath (getDir ())}


  val modTime : string -> Time.time = env "OS.FileSys.modTime"

  val fileSize : string -> int = env "OS.FileSys.fileSize"

  val setTime_ : string * Time.time -> unit = env "OS.FileSys.setTime_"

  fun setTime (fileName, NONE) = setTime_ (fileName, Time.now ())
    | setTime (fileName, SOME time) = setTime_ (fileName, time)

  val remove : string -> unit = env "OS.FileSys.remove"

  val rename : { old: string, new: string} -> unit = env "OS.FileSys.rename"


  datatype access_mode = A_READ | A_WRITE | A_EXEC

  val access : (string * access_mode list) -> bool = env "OS.FileSys.access"


  val tmpName : unit -> string = env "OS.FileSys.tmpName"



  (* XXX: Can't find any equivalent of an inode for Win32, so for the
   * moment the pathname is used (eek!).
   *)

  datatype file_id = FILE_ID of string


  fun fileId s = FILE_ID s


  (* A simple hashing function taken from ../main/_encapsulate.sml
   * Unless we are stuck with the file_id being a string, don't bother
   * to optimise this
   *)
  fun hash' (s, i, v) =
    if i = 0
    then v + ord (String.sub (s, i))
    else hash' (s, i-1, v + ord (String.sub (s, i)))


  fun hash (FILE_ID s) = Word.fromInt (hash' (s, size s - 1, size s))


  fun compare (FILE_ID a, FILE_ID b) = String.compare (a, b)

end
