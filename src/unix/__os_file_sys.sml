(* Copyright Harlequin Ltd. 1994.
 *
 * $Log: __os_file_sys.sml,v $
 * Revision 1.2  1996/05/23 12:02:00  stephenb
 * Functor application now requires a OSPath_ argument for the implementation
 * of realPath.
 *
 *  Revision 1.1  1996/05/17  09:27:04  stephenb
 *  new unit
 *  Renamed from __os_filesys in line with latest file name conventions.
 *
 *  Revision 1.1  1996/05/08  12:27:00  stephenb
 *  new unit
 *  Changed name from filesys inline with lastest filename conventions.
 *
 * Revision 1.2  1996/01/18  09:53:02  stephenb
 * OS reorganisation: parameterise functor with UnixOS since OS
 * specific stuff is no longer in the pervasive library.
 *
# Revision 1.1  1995/01/25  17:17:53  daveb
# new unit
# The OS.FileSys structure from the basis.
#
 *
 *)

require "__unixos";
require "__os_path";
require "_os_file_sys";

structure OSFileSys_ = 
  OSFileSys
    (structure UnixOS = UnixOS_
     structure Path = OSPath_)
