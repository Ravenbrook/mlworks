(*  ==== INITIAL BASIS : StringCvt ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __string_cvt.sml,v $
 *  Revision 1.3  1999/02/17 14:41:15  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.2  1996/10/03  14:57:20  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.1  1996/06/04  15:24:36  io
 *  new unit
 *
 *  Revision 1.6  1996/05/23  12:14:57  io
 *  fix padRight
 *
 *  Revision 1.5  1996/05/15  09:05:14  io
 *  fix dropl
 *
 *  Revision 1.4  1996/05/10  11:31:01  matthew
 *  Fixing some bugs
 *
 *  Revision 1.3  1996/05/07  11:44:15  io
 *  modify to use __pre_char
 *
 *  Revision 1.2  1996/05/02  17:25:55  io
 *  add scanString.
 *
 *  Revision 1.1  1996/04/23  12:25:03  matthew
 *  new unit
 *
 *
 *)
require "string_cvt";
require "__pre_string_cvt";
structure StringCvt : STRING_CVT = PreStringCvt
