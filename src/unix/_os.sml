(* Copyright (c) 1996 Harlequin Ltd.
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
