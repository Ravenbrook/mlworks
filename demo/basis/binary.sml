(*  ==== BASIS EXAMPLES : BINARY signature ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module defines a type 'binary' that is a vector of bits.  It provides
 *  functions to convert strings and bytes (ie. Word8.word) to and from the
 *  binary type.  Functions are also provided to convert a string to and from
 *  the vector of binaries representing the ASCII code of each character.
 *
 *  Revision Log
 *  ------------
 *  $Log: binary.sml,v $
 *  Revision 1.2  1996/09/04 11:56:50  jont
 *  Make require statements absolute
 *
 *  Revision 1.1  1996/07/26  15:45:21  davids
 *  new unit
 *
 *
 *)

require "$.basis.__word8";
require "$.basis.__vector";

signature BINARY =
  sig

    eqtype binary


    (* Convert a string of 0s and 1s into a binary.  Return NONE if string
     contains invalid characters. *)

    val fromString : string -> binary option


    (* Convert 'bin' into a string of 0s and 1s. *)

    val toString : binary -> string


    (* Convert a Word8.word to a binary. *)

    val fromByte : Word8.word -> binary


    (* Convert a binary to a Word8.word. *)

    val toByte : binary -> Word8.word


    (* Convert a string to the vector of binaries representing
     the ASCII code of each character. *)

    val toAscii : string -> binary Vector.vector


    (* Convert vector of binaries to the string made up of the characters given
     by their ASCII values. *)

    val fromAscii : binary Vector.vector -> string


    (* Print out each ASCII binary making up the string 's'. *)

    val printAscii : string -> unit

  end
