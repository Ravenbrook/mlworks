(* __machperv.sml the structure *)
(*   ==== MACHINE SPECIFICATION (PERVASIVES) ====
 *              STRUCTURE
 *
 *  Copyright (C) 1994 Harlequin Ltd.
 *  $Log: __machperv.sml,v $
 *  Revision 1.2  1997/01/21 11:30:16  matthew
 *  Adding Options
 *
 * Revision 1.1  1994/09/01  10:54:09  jont
 * new file
 *
 *)

require "../main/__pervasives";
require "../main/__options";
require "_i386perv";

structure MachPerv_ = I386Perv(
  structure Pervasives = Pervasives_
  structure Options = Options_
)
