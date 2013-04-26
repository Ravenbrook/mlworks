(*  ==== INITIAL BASIS : LargeInt structure ====
 *
 *  Copyright (C) 1997 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: __large_int.sml,v $
 *  Revision 1.2  1999/02/17 14:32:24  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.1  1997/05/23  09:24:46  jkbrook
 *  new unit
 *  Separate synonym file for LargeInt structure
 *
*)

require "integer";
require "__pre_int32";

structure LargeInt : INTEGER = PreLargeInt
