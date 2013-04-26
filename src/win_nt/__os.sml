(* Copyright (c) 1996 Harlequin Ltd.
 *
 * Revision Log
 * ------------
 *
 * $Log: __os.sml,v $
 * Revision 1.9  1996/05/21 11:22:34  stephenb
 * Update to use basis conforming Path rather than the out of date
 * one that has been standing in up until now.
 *
 *  Revision 1.8  1996/05/17  09:29:57  stephenb
 *  Change filesys -> file_sys in accordance with latest file naming conventions.
 *
 *  Revision 1.7  1996/05/08  12:30:30  stephenb
 *  Rename filesys to be os_filesys in line with latest file naming conventions.
 *
 *  Revision 1.5  1996/04/18  15:07:10  jont
 *  initbasis becomes basis
 *
 *  Revision 1.4  1996/04/12  12:06:00  stephenb
 *  Add Process
 *
 *  Revision 1.3  1996/04/01  14:46:26  stephenb
 *  new unit
 *  OS interface as defined in latest basis.
 *
 *
 *)

require "_os";
require "__win32";
require "__os_file_sys";
require "__os_path";
require "__os_io";
require "^.basis.__os_process";

structure OS = OS
  (structure Win32 =   Win32_
   structure FileSys = OSFileSys_
   structure Path =    OSPath_
   structure Process = OSProcess_
   structure IO =      OSIO_);
