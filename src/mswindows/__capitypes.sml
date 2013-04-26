(*  ==== CAPITYPES INTERFACE ====
 *
 *  Copyright (C) 1996 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 * $Log: __capitypes.sml,v $
 * Revision 1.3  1998/04/01 12:07:56  jont
 * [Bug #70086]
 * Windows_ has become WindowsGui_
 *
 * Revision 1.2  1996/10/31  17:04:48  daveb
 * Renamed Windows_ to Windows, as users will see it.
 *
 * Revision 1.1  1996/01/31  17:03:52  matthew
 * new unit
 * New stuff
 *
*)

require "__windows_gui";
require "_capitypes";

structure CapiTypes_ = CapiTypes (structure WindowsGui = WindowsGui)
