(* FILE SYSTEM INTERFACE *)
(*
 * Copyright Harlequin Ltd. 1994.
 *
 * $Log: __os_file_sys.sml,v $
 * Revision 1.2  1996/05/31 15:48:37  stephenb
 * Functor now needs OSPath_ as an argument since realPath is implemented
 * using OS.Path routines.
 *
 *  Revision 1.1  1996/05/17  09:30:39  stephenb
 *  new unit
 *  Renamed from __os_filesys in line with latest file name conventions.
 *
 *  Revision 1.1  1996/05/08  12:29:52  stephenb
 *  new unit
 *  Changed name from filesys inline with lastest filename conventions.
 *
 * Revision 1.2  1996/01/18  16:23:46  stephenb
 * OS reorganisation: Since the pervasive library no longer
 * contains OS specific stuff, parameterise the functor with
 * the Win32 structure.
 *
# Revision 1.1  1995/01/25  17:16:32  daveb
# new unit
# The OS.FileSys structure from the basis.
#
 *
 *)

require "__win32";
require "__os_path";
require "_os_file_sys";

structure OSFileSys_ = 
  OSFileSys
    (structure Win32 = Win32_
     structure Path = OSPath_)
