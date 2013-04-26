(*   ==== MACHINE SPECIFICATION (PERVASIVES) ====
 *              STRUCTURE
 *
 *  Copyright (C) 1993 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: __machperv.sml,v $
 *  Revision 1.3  1997/01/21 11:30:41  matthew
 *  Adding Options
 *
 * Revision 1.2  1993/11/16  15:44:23  io
 * Deleted old SPARC comments and fixed type errors
 *
 *)
require "../main/__pervasives.sml";
require "../main/__options.sml";
require "_machperv";

structure MachPerv_ = MachPerv(
  structure Pervasives = Pervasives_
  structure Options = Options_
)
