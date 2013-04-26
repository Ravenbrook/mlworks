(*
 * Copyright (c) 1995 Harlequin Ltd.
 *
 * $Log: __path_tool.sml,v $
 * Revision 1.6  1998/01/30 09:33:52  johnh
 * [Bug #30326]
 * Merge in change from branch MLWorks_workspace_97
 *
 * Revision 1.5.2.2  1997/11/20  16:51:56  daveb
 * [Bug #30326]
 *
 * Revision 1.5.2.1  1997/09/11  20:51:31  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.5  1997/05/12  16:40:38  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.4  1996/04/12  08:57:00  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.3  1996/03/27  15:16:27  stephenb
 * Replace FileSys/FILE_SYS by OS.FileSys/OS_FILE_SYS
 *
 * Revision 1.2  1996/01/19  15:56:30  stephenb
 * OS reorganisation: parameterise functor with UnixOS since all
 * OS specific stuff has been removed from the pervasive library.
 *
 *  Revision 1.1  1995/12/13  12:45:32  daveb
 *  new unit
 *  Extracted relevant source from the old File Tool.
 *
 *
 *)

require "../utils/__lists";
require "../winsys/__capi";
require "../winsys/__menus";
require "../main/__mlworks_io";
require "../main/__info";
require "../main/__options";
require "../system/__os";

require "_path_tool";

structure PathTool_ =
  PathTool
    (structure Lists = Lists_
     structure Capi = Capi_
     structure Menus = Menus_
     structure Io = MLWorksIo_
     structure Info = Info_
     structure Options = Options_
     structure OS = OS)
