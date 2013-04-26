(*  ==== INITIAL BASIS : LargeReal structure ====
 *
 *  Copyright (C) 1997 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __large_real.sml,v $
 *  Revision 1.2  1999/02/17 14:32:27  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.1  1997/05/23  09:24:55  jkbrook
 *  new unit
 *  Separate file for synonym structure LargeReal
 *
 *
 *)

require "__pre_real";
require "real";

structure LargeReal : REAL = PreReal
