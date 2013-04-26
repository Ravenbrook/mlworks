(*  ==== INITIAL BASIS : STRING_CVT ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: string_cvt.sml,v $
 *  Revision 1.3  1997/02/20 14:07:21  matthew
 *  Adding EXACT to realfmt
 *
 *  Revision 1.2  1996/10/03  15:27:04  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.1  1996/06/04  15:26:01  io
 *  new unit
 *  stringcvt->string_cvt
 *
 *  Revision 1.3  1996/05/07  11:48:54  io
 *  visiblize stuff in signature
 *
 *  Revision 1.2  1996/05/02  17:22:22  io
 *  finis stringcvt
 *
 *  Revision 1.1  1996/04/23  12:24:18  matthew
 *  new unit
 *
 *
 *)

signature STRING_CVT =
  sig
    datatype radix = BIN | OCT | DEC | HEX
    datatype realfmt = 
      EXACT
    | SCI of int option
    | FIX of int option
    | GEN of int option

    type cs
    type ('a,'b) reader

    val scanString : ((char, cs) reader -> ('a, cs) reader) -> string -> 'a option
    val skipWS : (char,'a) reader -> 'a -> 'a
    val padLeft : char -> int -> string -> string
    val padRight : char -> int -> string -> string
    val scanList : ((char list -> (char * char list) option) -> char list -> ('a * 'b) option) -> char list -> 'a option

    val splitl : (char -> bool) -> (char,'a) reader -> 'a -> (string * 'a)
    val takel : (char -> bool) ->  (char,'a) reader -> 'a -> string
    val dropl : (char -> bool) ->  (char,'a) reader -> 'a -> 'a

  end

