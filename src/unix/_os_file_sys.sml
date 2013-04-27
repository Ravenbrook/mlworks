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
 * Revision 1.7  1999/02/02 16:01:58  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 *  Revision 1.6  1998/08/13  10:23:27  jont
 *  [Bug #30468]
 *  Change types of mkAbsolute and mkRelative to uses records with names fields
 *
 *  Revision 1.5  1997/05/27  13:34:21  jkbrook
 *  [Bug #01749]
 *  Use __sys_word for SysWord structure
 *
 *  Revision 1.4  1996/10/21  15:23:08  jont
 *  Remove references to basis.toplevel
 *
 *  Revision 1.3  1996/07/25  12:00:25  stephenb
 *  [Bug #1495]
 *  Changed isLink to use lstat instead of stat so that the details
 *  of the link are found and not the linked to file.
 *
 *  Revision 1.2  1996/05/23  12:02:37  stephenb
 *  Implement realPath.
 *
 *  Revision 1.1  1996/05/17  09:27:21  stephenb
 *  new unit
 *  Renamed from _os_filesys inline with latest file name conventions.
 *
 * Revision 1.12  1996/05/16  14:10:01  stephenb
 * Add various missing items to bring it closer to the basis definition.
 *
 * Revision 1.11  1996/05/08  12:15:31  stephenb
 * Rename filesys to be os_filesys in line with latest file naming conventions.
 *
 * Revision 1.10  1996/05/03  15:35:19  stephenb
 * Add some more functions to bring it closer to the latest basis definition.
 * Also updated wrt to continuing POSIXification of the UnixOS structure.
 *
 * Revision 1.9  1996/04/18  15:24:22  jont
 * initbasis moves to basis
 *
 * Revision 1.8  1996/04/01  11:01:10  stephenb
 * Update wrt to Unix->SysErr exception name change.
 *
 * Revision 1.7  1996/03/12  14:50:57  matthew
 * Adding chDir and getDir
 *
 * Revision 1.6  1996/01/18  09:50:02  stephenb
 * OS reorganisation: parameterise functor with UnixOS now that
 * OS specific stuff is no longer in the pervasive library.
 *
 * Revision 1.5  1995/12/04  16:28:01  matthew
 * Adding directory functions
 *
 * Revision 1.4  1995/04/21  16:36:25  daveb
 * Removed BadHomeName exception.
 *
 * Revision 1.3  1995/04/20  17:31:33  daveb
 * Renamed functions to match initial basis, and moved expansion of
 * home dirs to getenv.sml.
 *
 * Revision 1.2  1995/04/12  13:29:16  jont
 * Change FILESYS to FILE_SYS
 *
 * Revision 1.1  1995/01/25  17:17:16  daveb
 * new unit
 * The OS.FileSys structure from the basis.
 *
 *)

require "^.basis.os_path";
require "^.basis.os_file_sys";
require "^.basis.__word";
require "^.basis.__sys_word";
require "unixos";

functor OSFileSys 
  (structure UnixOS: UNIXOS
   structure Path : OS_PATH): OS_FILE_SYS =
struct
  val env = MLWorks.Internal.Runtime.environment

  open UnixOS.FileSys

  val openDir = opendir
  val readDir = readdir
  val rewindDir = rewinddir
  val closeDir = closedir
  val chDir = chdir
  val getDir = getcwd

  fun mkDir pathname = mkdir (pathname, S.irwxo)

  val rmDir = rmdir

  val isDir = ST.isDir o stat
  val isLink = ST.isLink o lstat


  val readLink = readlink


  val fullPath : string -> string = env "OS.FileSys.fullPath"


  (* This is just the same implementation as given in the Mar 1996 basis
   * document except for the fact that Path is not caught as per the 
   * change described in the 19th April 1996 email to the basis group.
   *)
  fun realPath p = 
    if Path.isAbsolute p
    then fullPath p
    else Path.mkRelative {path=fullPath p, relativeTo=fullPath (getDir ())}


  val modTime = ST.mtime o stat


  val fileSize = ST.size o stat


  fun setTime (fileName, NONE) =
     utime (fileName, NONE)
  |   setTime (fileName, SOME time) = 
     utime (fileName, SOME {actime= time, modtime= time})
  

  val remove = unlink


  val tmpName : unit -> string = env "OS.FileSys.tmpName"



  datatype file_id = FILE_ID of dev * ino


  fun fileId s =
    let
      val fileInfo = stat s
    in
      FILE_ID (ST.dev fileInfo, ST.ino fileInfo)
    end


  (* XXX: Replace by a better hash function *)
  fun hash (FILE_ID (dev, ino)) = 
    let
      val devW= devToWord dev
      val inoW= inoToWord ino
    in
      Word.fromLargeWord (SysWord.* (devW, inoW))
    end


  fun compare (FILE_ID (devA, inoA), FILE_ID (devB, inoB)) = 
    let
      val devAW = devToWord devA
      val devBW = devToWord devB
    in
      if devAW < devBW then
        LESS
      else if devAW > devBW then
        GREATER
      else
        let
          val inoAW = inoToWord inoA
          val inoBW = inoToWord inoB
         in
           if inoAW < inoBW then
             LESS
          else if inoAW > inoBW then
             GREATER
          else
            EQUAL
         end
    end
end
