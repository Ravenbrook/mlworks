(*  ==== INITIAL BASIS : STRING_CVT ====
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

