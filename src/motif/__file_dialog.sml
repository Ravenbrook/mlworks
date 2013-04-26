(*
 * Copyright (c) 1994 Harlequin Ltd.
 * $Log: __file_dialog.sml,v $
 * Revision 1.9  1996/10/30 18:27:55  daveb
 * Changed name of Xm_ structure to Xm, because we're giving it to users.
 *
 * Revision 1.8  1996/04/12  08:54:17  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.7  1996/03/27  12:18:58  stephenb
 * Update in accordance with the latest revised basis.
 * FileSys and UnixOS disappear and become Os.
 *
 * Revision 1.6  1996/01/18  10:32:41  stephenb
 * OS reorganisation: parameterise functor with UnixOS since all
 * OS specific stuff has been removed from the pervasive library.
 *
 * Revision 1.5  1995/12/13  11:02:54  daveb
 * Added FileSys parameter.
 *
 * Revision 1.4  1995/07/26  13:58:50  matthew
 * Restructuring gui directories
 *
 * Revision 1.3  1995/01/16  13:30:05  daveb
 * Replaced Option structure with references to MLWorks.Option.
 *
 * Revision 1.2  1994/12/09  10:56:45  jont
 * Move OS specific stuff into a system link directory
 *
 * Revision 1.1  1994/06/30  18:02:20  daveb
 * new file
 *
 *)

require "../main/__info";
require "../motif/__xm";
require "../system/__os";

require "_file_dialog";

structure FileDialog_ =
  FileDialog
    (structure Xm = Xm
     structure Info = Info_
     structure OS = OS)
