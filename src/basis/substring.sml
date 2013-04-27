(*  ==== INITIAL BASIS : signature SUBSTRING ===
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Description
 * -----------
 *  This is part of the extended Initial Basis. 
 *
 * $Log: substring.sml,v $
 * Revision 1.6  1997/08/11 09:00:07  brucem
 * [Bug #30094]
 * Add span.
 *
 *  Revision 1.5  1997/06/16  10:25:57  jkbrook
 *  [Bug #30127]
 *  Merging changes from 1.0r2c1 into 2.0m0
 *
 *
 *  Revision 1.4  1996/10/03  15:27:11  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.3  1996/07/29  15:57:22  io
 *  [Bug #1508]
 *  add structure String
 *
 *  Revision 1.2  1996/06/04  15:58:12  io
 *  add extract
 *
 *  Revision 1.1  1996/05/08  14:33:49  io
 *  new unit
 *
 *)
require "string";

signature SUBSTRING =
  sig
    type  substring
    structure String : STRING

    val base : substring -> (string * int * int)
    val string : substring -> string
    val substring : (string * int * int) -> substring
    val all : string -> substring
    val isEmpty : substring -> bool
    val getc : substring -> (char * substring) option
    val first : substring -> char option
    val triml : int -> substring -> substring
    val trimr : int -> substring -> substring
    val slice : (substring * int * int option) -> substring
    val sub : (substring * int) -> char
    val size : substring -> int
    val extract : string * int * int option -> substring
    val concat : substring list -> string
    val explode : substring -> char list
    val isPrefix : string -> substring -> bool
    val compare : (substring * substring) -> order
    val collate : ((char * char) -> order) -> (substring * substring) -> order
    val splitl : (char -> bool) -> substring -> (substring * substring)
    val splitr : (char -> bool) -> substring -> (substring * substring)
    val splitAt : (substring * int) -> (substring * substring)
    val dropl : (char -> bool) -> substring -> substring
    val dropr : (char -> bool) -> substring -> substring
    val takel : (char -> bool) -> substring -> substring
    val taker : (char -> bool) -> substring -> substring
    val position : string -> substring -> (substring * substring) 
    val translate : (char -> string) -> substring -> string  
    val tokens : (char -> bool) -> substring -> substring list 
    val fields : (char -> bool) -> substring -> substring list
    val foldl : ((char * 'a) -> 'a) -> 'a -> substring -> 'a
    val foldr : ((char * 'a) -> 'a) -> 'a -> substring -> 'a
    val app : (char -> unit) -> substring -> unit
    exception Span
    val span : substring * substring -> substring

  end
