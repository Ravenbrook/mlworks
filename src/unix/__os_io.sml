(* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Revision Log
 * ------------
 *
 * $Log: __os_io.sml,v $
 * Revision 1.1  1996/05/03 15:11:43  stephenb
 * new unit
 *
 *)

require "__unixos";
require "_os_io";

structure OSIO_ = OSIO(structure UnixOS = UnixOS_)
