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
 * Revision Log
 * ------------
 *
 * $Log: _os.sml,v $
 * Revision 1.10  1997/03/18 14:51:25  andreww
 * [Bug #1431]
 * moving definitions of Error.errorMsg, errorName and syserror to
 * pervasive library.
 *
 *  Revision 1.9  1996/10/21  15:24:38  jont
 *  Remove references to basis.toplevel
 *
 *  Revision 1.8  1996/05/28  12:17:52  stephenb
 *  Implement OS.errorMsg, OS.errorName and OS.syserror.
 *
 *  Revision 1.7  1996/05/21  11:29:11  stephenb
 *  Update to use basis conforming Path rather than the out of date
 *  one that has been standing in up until now.
 *
 *  Revision 1.6  1996/05/17  09:33:35  stephenb
 *  Change filesys -> file_sys in accordance with latest file naming conventions.
 *
 *  Revision 1.5  1996/05/08  12:15:53  stephenb
 *  Rename filesys to be os_filesys in line with latest file naming conventions.
 *
 *  Revision 1.3  1996/04/18  15:25:57  jont
 *  initbasis moves to basis
 *
 *  Revision 1.2  1996/04/12  12:08:41  stephenb
 *  Add Process
 *
 *  Revision 1.1  1996/03/28  14:00:45  stephenb
 *  new unit
 *  basis Os implementation
 *
 *)

require "win32";
require "^.basis.os";
require "^.basis.os_path";
require "^.basis.os_file_sys";
require "^.basis.os_process";
require "^.basis.os_io";


functor OS
  (structure Win32:   WIN32
   structure FileSys: OS_FILE_SYS
   structure Path:    OS_PATH
   structure Process: OS_PROCESS
   structure IO:      OS_IO) : OS =
struct
  val env = MLWorks.Internal.Runtime.environment

  type syserror = MLWorks.Internal.Error.syserror

  exception SysErr = MLWorks.Internal.Error.SysErr

  val errorMsg = MLWorks.Internal.Error.errorMsg
  val errorName = MLWorks.Internal.Error.errorName
  val syserror = MLWorks.Internal.Error.syserror

  structure FileSys = FileSys
  structure Path =    Path
  structure Process = Process
  structure IO =      IO

end
