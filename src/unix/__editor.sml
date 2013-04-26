(* _editor.sml the structure *)
(*
$Log: __editor.sml,v $
Revision 1.13  1996/11/06 10:27:56  stephenb
[Bug #1719]
Remove the mlworks-socket-name argument since the socket name
is now constructed using a more complicated mechanism.

 * Revision 1.12  1996/08/05  15:33:54  stephenb
 * Replace OldOs by OS now that _editor has been updated to use
 * the new rather than old stuff.
 *
 * Revision 1.11  1996/06/13  11:30:11  brianm
 * Modifications to add custom editor interface ...
 *
 * Revision 1.10  1996/03/26  13:23:14  stephenb
 * Change any use of Os/OS to OldOs/OLD_OS to emphasise that it is using
 * the deprecated OS interface.
 *
 * Revision 1.9  1996/01/19  16:52:39  stephenb
 * OS reorganisation: Since OS specific stuff is no longer
 * in the pervasive library, the editor functor needs the
 * new UnixOS structure as a parameter.
 *
Revision 1.8  1995/01/13  14:31:42  daveb
Replaced Option structure with references to MLWorks.Option.

Revision 1.7  1994/12/08  18:04:30  jont
Move OS specific stuff into a system link directory

Revision 1.6  1994/08/01  09:06:28  daveb
Moved preferences out of Options structure.

Revision 1.5  1993/05/18  16:34:57  daveb
Removed the Integer structure.

Revision 1.4  1993/04/21  16:07:51  richard
The editor interface is now implemented directly through
Unix system calls, and is not part of the pervasive library
or the runtime system.

Revision 1.3  1993/04/14  15:22:07  jont
Added two structure parameters

Revision 1.2  1993/04/08  12:32:24  jont
Added options parameter

Revision 1.1  1993/03/10  17:22:49  jont
Initial revision

Copyright (C) 1993 Harlequin Ltd
*)

require "__os";
require "../main/__preferences";
require "../basics/__location";
require "../utils/__crash";
require "../utils/__lists";
require "../editor/__custom";
require "__unixos";
require "_editor";

structure Editor_ = Editor(
  structure Preferences = Preferences_
  structure Crash = Crash_
  structure Location = Location_
  structure OS = OS
  structure Lists = Lists_
  structure CustomEditor = CustomEditor_
  structure UnixOS = UnixOS_)
