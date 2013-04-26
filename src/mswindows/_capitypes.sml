(*  ==== CAPITYPES INTERFACE ====
 *
 *  Copyright (C) 1996 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 * $Log: _capitypes.sml,v $
 * Revision 1.3  1998/04/01 12:15:07  jont
 * [Bug #70086]
 * WINDOWS becomes WINDOWS_GUI, Windows becomesd WindowsGui
 *
 * Revision 1.2  1996/02/27  15:51:48  matthew
 * Changes to windows
 *
 * Revision 1.1  1996/01/31  17:04:17  matthew
 * new unit
 * New stuff
 *
*)

require "capitypes";
require "windows_gui";

functor CapiTypes (structure WindowsGui : WINDOWS_GUI) : CAPITYPES =
  struct
    type Hwnd = WindowsGui.hwnd
    datatype Widget =
      NONE 
    | REAL of Hwnd * Widget
    | FAKE of Widget * Widget list

    fun get_real NONE = WindowsGui.nullWindow
      | get_real (REAL (hwnd,_)) = hwnd
      | get_real (FAKE (parent,_)) = get_real parent
  end
