(*
 * $Log: __capi.sml,v $
 * Revision 1.9  1998/06/11 09:38:37  johnh
 * [Bug #30411]
 * Add support for free edition splash screen - need version information.
 *
 * Revision 1.8  1998/04/01  12:07:52  jont
 * [Bug #70086]
 * Windows_ has become WindowsGui_
 *
 * Revision 1.7  1997/10/29  11:43:46  johnh
 * [Bug #30187]
 * Adding word32 structure.
 *
 * Revision 1.6  1996/10/31  17:04:44  daveb
 * Renamed Windows_ to Windows, as users will see it.
 *
 * Revision 1.5  1996/01/31  12:06:56  matthew
 * Adding CapiTypes
 *
 * Revision 1.4  1996/01/12  11:03:27  daveb
 * Removed FileDialog parameter.
 *
 * Revision 1.3  1996/01/04  14:21:54  matthew
 * Stuff
 *
 * Revision 1.2  1995/08/10  09:23:43  matthew
 * Making it all work
 *
 * Revision 1.1  1995/08/03  12:50:01  matthew
 * new unit
 * MS Windows GUI
 *
 * Copyright (c) 1995 Harlequin Ltd.
 *
 *)

require "../utils/__lists";
require "../basis/__word32";
require "../main/__version";
require "__menus";
require "__windows_gui";
require "__labelstrings";
require "__capitypes";

require "_capi";

structure Capi_ = 
  Capi (structure Lists = Lists_
        structure Menus = Menus_
        structure WindowsGui = WindowsGui
        structure LabelStrings = LabelStrings_
        structure CapiTypes = CapiTypes_
	structure Version = Version_
	structure Word32 = Word32
        )
