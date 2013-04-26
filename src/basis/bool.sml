(*  ==== INITIAL BASIS : Bool structure ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: bool.sml,v $
 *  Revision 1.4  1997/05/27 14:24:29  matthew
 *  Adding datatypes
 *
 *  Revision 1.3  1996/10/03  15:19:27  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.2  1996/06/04  18:20:08  io
 *  stringcvt -> string_cvt
 *
 *  Revision 1.1  1996/05/02  16:33:10  io
 *  new unit
 *
 *)
require "__string_cvt";
signature BOOL =
  sig
    datatype bool = datatype bool
    val not : bool -> bool
    val fromString : string -> bool option
    val scan : (char, 'a) StringCvt.reader -> 'a -> (bool * 'a) option
    val toString : bool -> string
  end
