(*  ==== INITIAL BASIS : OS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: os.sml,v $
 *  Revision 1.6  1996/10/03 15:22:39  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 * Revision 1.5  1996/05/21  11:25:12  stephenb
 * Update to use basis conforming Path rather than the out of date
 * one that has been standing in up until now.
 *
 * Revision 1.4  1996/05/17  09:38:47  stephenb
 * Change filesys -> file_sys in accordance with latest file naming conventions.
 *
 * Revision 1.3  1996/05/08  12:23:48  stephenb
 * Rename filesys to be os_filesys in line with latest file naming conventions.
 *
 * Revision 1.2  1996/05/07  14:03:22  stephenb
 * Add OS.IO
 *
 * Revision 1.1  1996/04/18  13:40:21  jont
 * new unit
 *
 *  Revision 1.5  1996/04/12  11:45:24  stephenb
 *  Reinstate Process/OS_PROCESS now that it has been updated
 *  according to the latest basis definition.
 *
 *  Revision 1.4  1996/04/02  09:05:29  stephenb
 *  Remove dependence on toplevel as this causes build problems because
 *  it requires the inclusion of files that cannot be compiled by SML/NJ.
 *
 *  Revision 1.3  1996/03/27  10:07:03  stephenb
 *  Bring into line with the latest draft of the basis.
 *
 *  Revision 1.2  1995/04/20  15:51:17  daveb
 *  filesys and path moved from utils to initbasis.
 *
 *  Revision 1.1  1995/04/13  14:02:35  jont
 *  new unit
 *  No reason given
 *
 *
 *)

require "os_file_sys";
require "os_path";
require "os_process";
require "os_io";

signature OS =
  sig
    type syserror

    exception SysErr of (string * syserror option)

    val errorMsg : syserror -> string

    val errorName : syserror -> string
    val syserror : string -> syserror option

    structure FileSys : OS_FILE_SYS

    structure Path : OS_PATH

    structure Process : OS_PROCESS

    structure IO : OS_IO

  end
