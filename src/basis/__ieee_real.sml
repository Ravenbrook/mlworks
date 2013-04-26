(*  ==== INITIAL BASIS : IEEEReal ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __ieee_real.sml,v $
 *  Revision 1.2  1997/03/03 16:17:23  matthew
 *  Updating for new basis
 *
 *  Revision 1.1  1997/01/14  10:37:31  io
 *  new unit
 *  [Bug #1757]
 *  renamed __ieeereal to __ieee_real
 *
 *  Revision 1.3  1996/05/10  10:12:58  matthew
 *  Removing dummy function
 *
 *  Revision 1.2  1996/05/10  08:59:33  matthew
 *  Updating
 *
 *  Revision 1.1  1996/04/23  10:41:53  matthew
 *  new unit
 *
 *
 *
 *)

require "__pre_ieee_real";
require "ieee_real";
structure IEEEReal : IEEE_REAL = PreIEEEReal
