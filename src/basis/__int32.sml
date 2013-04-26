(*  ==== INITIAL BASIS : 32-bit Integer structure ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __int32.sml,v $
 *  Revision 1.4  1999/02/17 14:31:57  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 * Revision 1.3  1997/01/14  17:59:24  io
 * [Bug #1757]
 * rename __preint32 to __pre_int32
 *
 * Revision 1.2  1996/04/30  12:20:49  matthew
 * Updated signature
 *
 * Revision 1.1  1996/04/18  11:27:39  jont
 * new unit
 *
 * Revision 1.2  1996/03/19  16:53:14  matthew
 * Changes for value polymorphism
 *
 * Revision 1.1  1995/09/15  16:56:50  daveb
 * new unit
 * 32-bit integers.
 *
 *)

require "integer";
require "__pre_int32";


structure Int32 : INTEGER = PreInt32
