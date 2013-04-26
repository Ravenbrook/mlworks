(*  ==== COMPILER INFORMATION OUTPUT ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: __info.sml,v $
 *  Revision 1.3  1996/10/29 16:08:09  io
 *  [Bug #1614]
 *  basifying String
 *
 * Revision 1.2  1992/11/30  18:37:02  matthew
 * Used pervasive streams
 *
Revision 1.1  1992/11/18  17:04:48  matthew
Initial revision


 *)

require "^.basics.__location";
require "_info";

structure Info_ =
  Info(structure Location = Location_)
