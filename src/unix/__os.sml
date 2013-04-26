(* Copyright (c) 1996 Harlequin Ltd.
 *
 * Revision Log
 * ------------
 *
 * $Log: __os.sml,v $
 * Revision 1.11  1996/05/21 11:22:12  stephenb
 * Update to use basis conforming Path rather than the out of date
 * one that has been standing in up until now.
 *
 * Revision 1.10  1996/05/17  09:29:36  stephenb
 * Change filesys -> file_sys in accordance with latest file naming conventions.
 *
 * Revision 1.9  1996/05/08  12:27:14  stephenb
 * Rename filesys to be os_filesys in line with latest file naming conventions.
 *
 * Revision 1.8  1996/05/03  15:18:50  stephenb
 * Add OS.IO
 *
 * Revision 1.7  1996/04/18  15:06:14  jont
 * initbasis becomes basis
 *
 * Revision 1.6  1996/04/12  11:41:44  stephenb
 * Add Process/OS_PROCESS.
 *
 * Revision 1.5  1996/04/01  14:43:27  stephenb
 * new unit
 * OS interface as defined in latest basis.
 *
 *
 *)

require "_os";
require "__unixos";
require "__os_file_sys";
require "__os_path";
require "^.basis.__os_process";
require "__os_io";

structure OS = OS
  (structure UnixOS  = UnixOS_
   structure FileSys = OSFileSys_
   structure Path    = OSPath_
   structure Process = OSProcess_
   structure IO      = OSIO_);
