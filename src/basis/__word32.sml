(*  ==== INITIAL BASIS : WORDS  ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: __word32.sml,v $
 *  Revision 1.6  1999/02/17 14:41:50  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 * Revision 1.5  1997/05/27  12:49:52  jkbrook
 * [Bug #01749]
 * Constraining structure synonyms with signature
 *
 * Revision 1.4  1997/01/14  17:46:54  io
 * [Bug #1757]
 * rename __preword32 to __pre_word32
 *
 * Revision 1.3  1996/05/16  11:22:06  stephenb
 * Add SysWord since it is needed by some POSIX stuff.
 *
 * Revision 1.2  1996/05/02  13:55:01  matthew
 * Updating
 *
 * Revision 1.1  1996/04/18  11:36:20  jont
 * new unit
 *
 *  Revision 1.5  1996/03/19  16:51:30  matthew
 *  Change for value polymorphism
 *
 *  Revision 1.4  1995/09/12  14:43:09  daveb
 *  Updated to use overloaded built-in type.
 *
 *  Revision 1.3  1995/08/08  10:57:09  matthew
 *  Changing representation from bytearrays to strings.
 *
 *  Revision 1.2  1995/04/04  10:19:07  brianm
 *  Changing repn. type back to bytearrays ...
 *
 * Revision 1.1  1995/03/22  20:20:26  brianm
 * new unit
 * New file.
 *
 *
 *)

require "__pre_word32";
require "word";

structure Word32: WORD = PreWord32;

