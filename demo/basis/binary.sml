(*  ==== BASIS EXAMPLES : BINARY signature ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
