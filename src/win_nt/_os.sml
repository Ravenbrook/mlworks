(* Copyright (c) 1996 Harlequin Ltd.
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
