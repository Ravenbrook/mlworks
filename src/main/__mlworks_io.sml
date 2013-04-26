(* __io.sml the structure *)
(*
$Log: __mlworks_io.sml,v $
Revision 1.4  1998/03/31 11:27:42  jont
[Bug #70077]
Remove use of Path_

*Revision 1.3  1998/02/06  15:42:56  johnh
*Automatic checkin:
*changed attribute _comment to '*'
*
 *  Revision 1.1.1.2  1997/11/25  19:57:43  daveb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 * Revision 1.17.2.1  1997/09/11  20:57:06  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.17  1997/05/12  15:51:38  jont
 * [Bug #20050]
 * Change name to MLWorks_IO to avoid clash with basis.io
 *
 * Revision 1.16  1996/05/21  11:19:30  stephenb
 * Change to pull in Path directly rather than OS.Path since the latter
 * now conforms to the latest basis and it is too much effort to update
 * the code to OS.Path at this point.
 *
 * Revision 1.15  1996/04/11  15:11:53  stephenb
 * Update wrt Os -> OS name change.
 *
 * Revision 1.14  1996/03/27  10:12:04  stephenb
 * Update to use the OS structure from the latest revised basis.
 *
 * Revision 1.13  1995/04/19  12:32:25  jont
 * Add Path to functor paramters
 *
Revision 1.12  1995/01/16  14:06:15  daveb
Replaced FileName argument with FileSys.

Revision 1.11  1994/12/08  16:58:19  jont
Move OS specific stuff into a system link directory

Revision 1.10  1994/02/01  16:19:58  daveb
Removed Option_, added UnixFileName_ and UnixGetenv_.

Revision 1.9  1993/08/25  12:47:28  daveb
Removed default_pervasive_dir, changed default_source_path tobe ["."].

Revision 1.8  1993/08/12  16:20:47  daveb
Added Info and ModuleId parameters.
Removed pervasive_names, changed default_pervasive_library_dir to
default_pervasive_dir, added default_source_path.

Revision 1.7  1993/05/05  17:01:22  jont
Added a new functor parameter lists

Revision 1.6  1993/02/24  14:32:12  jont
Added Option_ structure to functor parameters

Revision 1.5  1992/12/21  19:13:39  daveb
Added vector to the list of pervasive files.

Revision 1.4  1992/09/28  17:13:42  matthew
Added builtin library to pervasive_names.

Revision 1.3  1992/09/02  12:21:50  richard
Moved the special names out of the compiler as a whole.

Revision 1.2  1992/08/10  11:32:37  davidt
String structure is now pervasive.

Revision 1.1  1992/07/22  13:51:48  jont
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)

require "../system/__os";
require "../main/__info";
require "../basics/__module_id";
require "../system/__getenv";
require "^.system.__os";
require "_mlworks_io";

structure MLWorksIo_ = MLWorksIo(
  structure OS = OS
  structure Path = OS.Path;
  structure Info = Info_
  structure ModuleId = ModuleId_
  structure Getenv = Getenv_
  val pervasive_library_name = "__pervasive_library"
  val builtin_library_name   = "__builtin_library"
  val default_source_path    = ["."]
);
