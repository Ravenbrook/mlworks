(* Module identifiers - for OS-independent recompilation.
 
$Log: __module_id.sml,v $
Revision 1.8  1998/03/31 11:27:13  jont
[Bug #70077]
Remove use of Path_

 * Revision 1.7  1996/05/21  11:09:51  stephenb
 * Change to pull in Path directly rather than OS.Path since the latter
 * now conforms to the latest basis and it is too much effort to update
 * the code to OS.Path at this point.
 *
 * Revision 1.6  1996/04/11  15:08:09  stephenb
 * Update wrt Os -> OS name change.
 *
 * Revision 1.5  1996/03/26  15:09:43  stephenb
 * Replace the use of Path by Os.Path.
 *
 * Revision 1.4  1995/01/19  11:57:35  daveb
 * Replaced FileName parameter with Path.  Removed redundant List parameter.
 *
Revision 1.3  1995/01/13  15:24:29  jont
Parameterise on pathname separator

Revision 1.2  1993/08/24  14:51:11  daveb
Added Lists parameter.

Revision 1.1  1993/08/17  17:25:00  daveb
Initial revision


Copyright (c) 1993 Harlequin Ltd

*)

require "__symbol";
require "../main/__info";
require "../system/__os";
require "^.system.__os";
require "_module_id";

structure ModuleId_ =
  ModuleId
    (structure Symbol = Symbol_
     structure Path = OS.Path;
     structure Info = Info_);
