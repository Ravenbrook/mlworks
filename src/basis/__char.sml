(*  ==== INITIAL BASIS : structure Char ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __char.sml,v $
 *  Revision 1.7  1999/02/17 14:31:32  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.6  1996/06/24  10:36:13  io
 *  unconstrain Char so that scanc can be seen by other basis routines
 *
 *  Revision 1.5  1996/06/04  18:54:09  io
 *  stringcvt -> string_cvt
 *
 *  Revision 1.4  1996/05/21  22:51:57  io
 *  ** No reason given. **
 *
 *  Revision 1.3  1996/05/18  00:18:34  io
 *  fromCString
 *
 *  Revision 1.2  1996/05/16  14:21:35  io
 *  fix fromString, scan
 *
 *  Revision 1.1  1996/05/15  12:42:49  jont
 *  new unit
 *
 * Revision 1.6  1996/05/15  10:27:38  io
 * further mods to fromString, scan
 *
 * Revision 1.5  1996/05/13  17:56:33  io
 * update toString
 *
 * Revision 1.4  1996/05/13  15:22:22  io
 * complete toString
 *
 * Revision 1.3  1996/05/07  21:04:48  io
 * revising...
 *
 *)
require "char";
require "__pre_char";
structure Char : CHAR = PreChar
