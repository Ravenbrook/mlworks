(*  ==== INITIAL BASIS : CHARACTERS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: char.sml,v $
 *  Revision 1.6  1996/10/03 15:20:04  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.5  1996/10/01  13:13:02  io
 *  [Bug #1626]
 *  remove option type in toCString
 *
 *  Revision 1.4  1996/06/04  15:23:23  io
 *  stringcvt -> string_cvt
 *
 *  Revision 1.3  1996/05/22  09:44:32  io
 *  fix bug in isPrint & isGraph
 *
 *  Revision 1.2  1996/05/17  15:55:44  io
 *  fromCString valid
 *
 *  Revision 1.1  1996/05/14  14:12:01  jont
 *  new unit
 *
 * Revision 1.3  1996/05/14  14:12:01  io
 * remove exception Chr
 *
 * Revision 1.2  1996/05/07  21:05:52  io
 * revising...
 *
 * Revision 1.1  1996/04/18  11:41:00  jont
 * new unit
 *
 *  Revision 1.1  1995/03/08  16:22:37  brianm
 *  new unit
 *  No reason given
 *
 *
 *)
require "__string_cvt";
signature CHAR =
  sig

    eqtype char
    eqtype string

    val maxOrd : int
    val minChar : char
    val maxChar : char

    val chr : int -> char (* raise Chr *)
    val ord : char -> int

    val succ : char -> char (* raise Chr *)
    val pred : char -> char (* raise Chr *)

    val <  : (char * char) -> bool
    val <= : (char * char) -> bool
    val >  : (char * char) -> bool
    val >= : (char * char) -> bool

    val compare : (char * char) -> order
    val contains : string -> char -> bool
    val notContains : string -> char -> bool
    val isLower : char -> bool
    val isUpper : char -> bool
    val isDigit : char -> bool
    val isAlpha : char -> bool
    val isAlphaNum : char -> bool
    val isAscii : char -> bool
    val isSpace : char -> bool
    val toLower : char -> char
    val toUpper : char -> char
    val isCntrl : char -> bool
    val isGraph : char -> bool
    val isHexDigit : char -> bool
    val isPrint: char -> bool

    val isPunct : char -> bool
    val fromString : string -> char option
    val toString : char -> string
    val scan : (char, 'a) StringCvt.reader -> 'a -> (char * 'a) option

    val fromCString : string -> char option
    val toCString : char -> string


  end; (* CHAR *)
