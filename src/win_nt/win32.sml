(* Copyright (C) 1996 Harlequin Ltd.
 *
 * An interface to a misc. collection of features made available
 * under Windows 95 / Windows NT.
 *
 * Revision Log
 * ------------
 *
 * $Log: win32.sml,v $
 * Revision 1.16  1998/07/03 12:32:17  mitchell
 * [Bug #30434]
 * Use Windows structure for registry access rather than Win32
 *
 * Revision 1.15  1998/04/20  17:09:49  jont
 * [Bug #70107]
 * Add closeIOD function
 *
 * Revision 1.14  1997/10/30  10:11:36  johnh
 * [Bug #30233]
 * Fix return result of create process.
 *
 * Revision 1.13  1996/11/08  14:24:05  matthew
 * [Bug #1661]
 * Changing io_desc to iodesc
 *
 * Revision 1.12  1996/10/29  12:41:49  jont
 * Sorting out lost version problems
 *
 * Revision 1.11  1996/10/25  09:45:12  johnh
 * [Bug #1426]
 * [Bug #1426]
 * Replaced Win32 environment with Windows registry.
 *
 * Revision 1.10  1996/10/22  14:49:12  johnh
 * Undoing changes to registry to allow further work to be done.
 *
 * Revision 1.9  1996/10/22  14:14:38  johnh
 * [Bug #1426]
 * [Bug #1426]
 * Removing Win32 environment and using registry instead.
 *
 * Revision 1.8  1996/08/21  12:05:03  stephenb
 * [Bug #1554]
 * Move iodesc from os_io.sml to here and also add conversion
 * function fdToIOD to convert between file descriptors and io
 * descriptors.
 *
 * Revision 1.7  1996/06/14  10:37:33  stephenb
 * Move the definition of a iodesc from OS.IO to here and called it file_desc
 * so that it is possible to construct a file_desc for testing purposes by dealing
 * directly with the representation.
 *
 * Revision 1.6  1996/06/05  14:36:17  stephenb
 * Remove the find_{first_file,next_file,close} functions since
 * they were only here to support OS.FileSys.{open,read,close}Dir and
 * these now pull the relevant routines through directly from the runtime.
 *
 * Revision 1.4  1996/04/22  12:00:44  brianm
 * Adding Win32 call for creating a process with priorities ...
 *
 * Revision 1.3  1996/03/28  14:05:20  stephenb
 * Change the exception to be compatible with the OS.SysError exception
 * in the latest basis definition.
 *
 * Revision 1.2  1996/03/12  15:44:33  matthew
 * Adding set_current_directory
 *
 * Revision 1.1  1996/01/22  09:36:47  stephenb
 * new unit
 * OS reorganisation: the pervasive library no longer contains
 * OS specific stuff, instead the NT structure has been factored
 * out as a separate structure and renamed Win32.
 *
 *
 *)

signature WIN32 =
  sig
    type syserror
    exception SysErr of (string * syserror option)

    type file_desc

    datatype iodesc = IODESC of int      (* Unix style file descriptor *)

    (* Convert an file_desc to an iodesc.
     * Raises: SysErr if the conversion cannot be performed
     *)
    val fdToIOD : file_desc -> iodesc
    val closeIOD : iodesc -> unit

    datatype priority = REAL_TIME | HIGH | NORMAL | BACKGROUND

    val create_process : string * priority -> bool

  end
