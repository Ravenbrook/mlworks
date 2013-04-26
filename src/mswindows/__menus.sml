(* Windows menu bar utilites *)
(*

$Log: __menus.sml,v $
Revision 1.12  1999/03/23 14:44:45  johnh
[Bug #190536]
Add version.

 * Revision 1.11  1998/04/01  12:18:19  jont
 * [Bug #70086]
 * Windows_ has become WindowsGui_
 *
 * Revision 1.10  1997/10/29  09:34:14  johnh
 * [Bug #30059]
 * __control_names.sml now kept in rts\gen.
 *
 * Revision 1.9  1997/10/13  12:30:58  johnh
 * [Bug #30059]
 * Implement interface to Win32 resource dialogs.
 *
 * Revision 1.8  1997/07/14  12:05:28  johnh
 * [Bug #30124]
 * Using Getenv.get_source_path to find help documentation.
 *
 * Revision 1.7  1996/10/31  17:05:02  daveb
 * Renamed Windows_ to Windows, as users will see it.
 *
 * Revision 1.6  1996/05/01  12:08:52  matthew
 * Removing Integer structure
 *
 * Revision 1.5  1996/01/31  12:09:38  matthew
 * Adding CapiTypes
 *
 * Revision 1.4  1995/08/29  12:30:18  matthew
 * Including Integer structure
 *
 * Revision 1.3  1995/08/15  13:43:00  matthew
 * Adding Lists and Crash structures
 *
 * Revision 1.2  1995/08/10  09:24:01  matthew
 * Making it all work
 *
 * Revision 1.1  1995/08/03  12:50:47  matthew
 * new unit
 * MS Windows GUI
 *
 * Copyright (c) 1993 Harlequin Ltd.
 *
 *)

require "../utils/__lists";
require "../utils/__crash";
require "../system/__getenv";
require "__windows_gui";
require "__capitypes";
require "__labelstrings";
require "../rts/gen/__control_names";
require "../main/__version";


require "_menus";

structure Menus_ = Menus(structure Lists = Lists_
                         structure Crash = Crash_
                         structure WindowsGui = WindowsGui
                         structure LabelStrings = LabelStrings_
                         structure CapiTypes = CapiTypes_
			 structure ControlName = ControlName
			 structure Getenv = Getenv_
 			 structure Version = Version_
                           );
