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
 * Revision 1.9  1996/05/28 11:08:03  stephenb
 * Implement OS.errorName and OS.syserror
 *
 *  Revision 1.8  1996/05/21  11:28:28  stephenb
 *  Update to use basis conforming Path rather than the out of date
 *  one that has been standing in up until now.
 *
 *  Revision 1.7  1996/05/17  09:33:16  stephenb
 *  Change filesys -> file_sys in accordance with latest file naming conventions.
 *
 *  Revision 1.5  1996/05/08  12:15:17  stephenb
 *  Rename filesys to be os_filesys in line with latest file naming conventions.
 *
 *  Revision 1.3  1996/04/18  15:24:00  jont
 *  initbasis moves to basis
 *
 *  Revision 1.2  1996/04/12  11:41:40  stephenb
 *  Add the newly revised Process/OS_PROCESS structure.
 *
 *  Revision 1.1  1996/03/28  13:59:41  stephenb
 *  new unit
 *  basis Os implementation
 *
 *)

require "^.basis.os";
require "unixos";
require "^.basis.os_path";
require "^.basis.os_file_sys";
require "^.basis.os_process";
require "^.basis.os_io";

functor OS
  (structure UnixOS:  UNIXOS
   structure FileSys: OS_FILE_SYS
   structure Path:    OS_PATH
   structure Process: OS_PROCESS
   structure IO:      OS_IO) : OS =
struct
  type syserror = UnixOS.Error.syserror

  exception SysErr = UnixOS.Error.SysErr

  val errorMsg = UnixOS.Error.errorMsg

  val errorName = UnixOS.Error.errorName

  val syserror = UnixOS.Error.syserror

  structure FileSys = FileSys
  structure Path =    Path
  structure Process = Process
  structure IO = IO

end
