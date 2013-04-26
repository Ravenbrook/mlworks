(*   ==== MACHINE SPECIFICATION (PERVASIVES) ====
 *              STRUCTURE
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: __machperv.sml,v $
 *  Revision 1.3  1997/01/21 11:27:06  matthew
 *  Adding Options
 *
 * Revision 1.2  1993/08/16  09:39:04  daveb
 * Removed spurious ".sml" from require declaration.
 *
Revision 1.1  1992/11/21  19:23:26  jont
Initial revision

 *)

require "../main/__pervasives";
require "../main/__options";
require "_machperv";

structure MachPerv_ = MachPerv(
  structure Options = Options_
  structure Pervasives = Pervasives_
)
