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
 * See ./win32.sml
 *
 * Revision Log
 * ------------
 *
 * $Log: _win32.sml,v $
 * Revision 1.17  1998/07/03 12:32:17  mitchell
 * [Bug #30434]
 * Use Windows structure for registry access rather than Win32
 *
 * Revision 1.16  1998/04/20  17:10:55  jont
 * [Bug #70107]
 * Add closeIOD function
 *
 * Revision 1.15  1997/10/30  10:11:48  johnh
 * [Bug #30233]
 * Fix return result of create process.
 *
 * Revision 1.14  1996/11/08  14:23:12  matthew
 * [Bug #1661]
 * Changing io_desc to iodesc
 *
 * Revision 1.13  1996/10/29  12:42:15  jont
 * Sorting out lost version problems
 *
 * Revision 1.12  1996/10/25  10:36:53  johnh
 * [Bug #1426]
 * Removing Win32 environment and using registry instead.
 *
 * Revision 1.11  1996/08/21  12:02:34  stephenb
 * [Bug #1554]
 * Move iodesc from os_io.sml to here and also add conversion
 * function fdToIOD to convert between file descriptors and io
 * descriptors.
 *
 * Revision 1.10  1996/06/14  08:55:09  stephenb
 * Move the definition of a iodesc from OS.IO to here and called it file_desc
 * so that it is possible to construct a file_desc for testing purposes by dealing
 * directly with the representation.
 *
 * Revision 1.9  1996/06/05  14:36:08  stephenb
 * Remove the find_{first_file,next_file,close} functions since
 * they were only here to support OS.FileSys.{open,read,close}Dir and
 * these now pull the relevant routines through directly from the runtime.
 *
 * Revision 1.8  1996/05/31  15:46:13  stephenb
 * Remove various functions that are now pulled through directly
 * in _os_file_sys.sml.
 *
 * Revision 1.7  1996/05/29  12:36:16  matthew
 * Fixing problem with SysErr
 *
 * Revision 1.6  1996/04/22  11:58:40  brianm
 * Adding Win32 call for creating a process with priorities ...
 *
 * Revision 1.5  1996/03/29  10:05:33  stephenb
 * Replace the Win32 exception with an OS.SysErr compatible exception
 * so that this functor can be used to create an Os structure.
 *
 * Revision 1.4  1996/03/12  15:45:55  matthew
 * Adding set_current_directory
 *
 * Revision 1.3  1996/01/23  08:35:26  stephenb
 * Add missing integer to Win32 exception constructor.
 *
 *  Revision 1.2  1996/01/22  14:57:00  stephenb
 *  Bind the exception handler -- should have been done in OS reorg.
 *
 *  Revision 1.1  1996/01/22  09:35:44  stephenb
 *  new unit
 *  OS reorganisation: the pervasive library no longer contains
 *  OS specific stuff such as the NT structure, instead it has
 *  been factored out as a separate structure and renamed Win32.
 *
 *
 *)

require "win32";

functor Win32(): WIN32 =
struct
  val env = MLWorks.Internal.Runtime.environment

  type syserror = MLWorks.Internal.Error.syserror
  exception SysErr = MLWorks.Internal.Error.SysErr

  type file_desc = MLWorks.Internal.IO.file_desc (* Win32 HANDLE *)

  datatype iodesc = IODESC of int      (* Unix style file descriptor *)

  (*
   * Convert a file_desc to an iodesc.
   * Raises OS.SysErr if the conversion cannot be done.
   *)
  val fdToIOD : file_desc -> iodesc = env "Win32.fdToIOD"

  val closeIOD : iodesc -> unit = env"Win32.closeIOD"

  datatype priority = REAL_TIME | HIGH | NORMAL | BACKGROUND

  val create_process : string * priority -> bool =
    env "system os win32 create_process"
  
end
