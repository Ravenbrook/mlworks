(*  ==== ENVIROMENT PREFERENCES ====
 *
 *  Copyright (C) 1994 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: __preferences.sml,v $
 *  Revision 1.2  1995/05/25 09:38:49  daveb
 *  Added Info parameter.
 *
 *  Revision 1.1  1994/08/01  15:17:14  daveb
 *  new file
 *
 *  Revision 1.1  1993/03/08  16:20:06  matthew
 *  Initial revision
 *
 *)

require "_preferences";
require "__info";

structure Preferences_ =
  Preferences(structure Info = Info_)
