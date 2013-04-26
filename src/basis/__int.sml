(*  ==== INITIAL BASIS : Integer structure ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __int.sml,v $
 *  Revision 1.3  1999/02/17 14:31:53  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.2  1997/01/14  17:48:47  io
 *  [Bug #1757]
 *  rename __preinteger to __pre_int
 *
 *  Revision 1.1  1996/04/23  10:53:30  matthew
 *  new unit
 *  Renamed from __integer
 *
 * Revision 1.2  1996/04/23  10:53:30  matthew
 * Renaming Integer to Int
 *
 * Revision 1.1  1996/04/18  11:29:58  jont
 * new unit
 *
 *
 *)

require "integer";
require "__pre_int";

structure Int : INTEGER = PreInt
