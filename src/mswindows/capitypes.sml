(*  ==== CAPITYPES INTERFACE ====
 *
 *  Copyright (C) 1996 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 * $Log: capitypes.sml,v $
 * Revision 1.2  1996/11/06 12:42:14  jont
 * Need to make Hwnd an equality type
 *
 * Revision 1.1  1996/01/31  17:04:53  matthew
 * new unit
 *
 *
 * New stuff
 *
*)

signature CAPITYPES =
  sig
    eqtype Hwnd
    datatype Widget =
      NONE 
    | REAL of Hwnd * Widget
    | FAKE of Widget * Widget list
    val get_real : Widget -> Hwnd
  end


