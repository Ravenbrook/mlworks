(* _editor.sml the structure *)
(*
$Log: __editor.sml,v $
Revision 1.12  1996/06/15 15:11:24  brianm
Modifications to add custom editor interface ...

 * Revision 1.11  1996/04/22  13:46:47  brianm
 * Adding WIN32 dependency ...
 *
 * Revision 1.10  1996/04/07  22:27:40  brianm
 * Adding PFE support via DDE ...
 *
 * Revision 1.9  1996/03/28  15:25:08  stephenb
 * Change Os_ to Os since that is what the basis Os structure is called.
 *
 * Revision 1.8  1995/01/13  14:31:42  daveb
 * Replaced Option structure with references to MLWorks.Option.
 *
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

require "../editor/__custom";
require "../utils/__lists";
require "../utils/__crash";
require "../main/__preferences";
require "../basics/__location";
require "__win32";

require "_editor";

structure Editor_ = Editor(
  structure Preferences = Preferences_
  structure Location = Location_
  structure CustomEditor = CustomEditor_
  structure Lists = Lists_
  structure Win32 = Win32_
  structure Crash = Crash_
)
