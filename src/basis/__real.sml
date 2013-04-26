(*  ==== INITIAL BASIS : Real structure ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __real.sml,v $
 *  Revision 1.4  1999/02/17 14:39:38  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 * Revision 1.3  1997/01/14  17:43:03  io
 * [Bug #1757]
 * rename __prereal to __pre_real
 *
 * Revision 1.2  1996/11/06  14:27:09  matthew
 * Adding LargeReal definition
 *
 * Revision 1.1  1996/04/18  11:34:00  jont
 * new unit
 *
 *
 *)

require "__pre_real";
require "real";

structure Real : REAL = PreReal
