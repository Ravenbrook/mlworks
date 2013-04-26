(*  ==== INITIAL BASIS : BYTE ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: byte.sml,v $
 *  Revision 1.5  1997/05/27 14:20:26  matthew
 *  Changing type of pack_string
 *
 *  Revision 1.4  1997/01/15  12:06:32  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.3  1996/10/03  15:19:53  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.2  1996/05/17  14:10:23  io
 *  revise..
 *
 *  Revision 1.1  1996/05/15  12:45:26  jont
 *  new unit
 *
 * Revision 1.1  1996/04/18  11:40:55  jont
 * new unit
 *
 *  Revision 1.1  1995/04/13  13:47:17  jont
 *  new unit
 *  No reason given
 *
 *
 *)

require "__word8";
require "__word8_array";
require "__word8_vector";
require "__substring";
signature BYTE =
  sig
    val byteToChar : Word8.word -> char
    val charToByte : char -> Word8.word
    val bytesToString : Word8Vector.vector -> string
    val stringToBytes : string -> Word8Vector.vector
    val unpackStringVec : (Word8Vector.vector * int * int option) -> string (* raises Subscript *)
    val unpackString : (Word8Array.array * int * int option) -> string (* raises Subscript *)
    val packString : (Word8Array.array * int * Substring.substring) -> unit 
  end