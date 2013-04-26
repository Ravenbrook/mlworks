(*  ==== INITIAL BASIS : Word structure ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __word.sml,v $
 *  Revision 1.5  1999/02/17 14:41:31  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 * Revision 1.4  1997/01/14  17:43:11  io
 * [Bug #1757]
 * rename __preinteger to __pre_int
 *
 * Revision 1.3  1996/05/02  14:36:30  matthew
 * Updating
 *
 * Revision 1.2  1996/04/30  15:34:54  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.1  1996/04/18  11:35:33  jont
 * new unit
 *
 *
 * Default size words (30-bit).
 *
 *)

require "__pre_word";
require "word";

structure Word : WORD = PreWord
