(*  ==== BASIS EXAMPLES : Cipher structure ====
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
 *  This module provides functions for enciphering and deciphering using the
 *  Vigenere cipher.  This technique uses a key (repeated many times if
 *  necessary).  Each letter in the original message is displaced by the
 *  corresponding letter in the key.  The combined use of the Char and String
 *  structures in the basis library is demonstrated.  The ListPair structure
 *  is also used.
 *
 *  Revision Log
 *  ------------
 *  $Log: __cipher.sml,v $
 *  Revision 1.3  1996/09/04 11:52:43  jont
 *  Make require statements absolute
 *
 *  Revision 1.2  1996/08/09  18:27:53  davids
 *  ** No reason given. **
 *
 *  Revision 1.1  1996/07/26  15:38:28  davids
 *  new unit
 *
 *
 *)


require "cipher";
require "$.basis.__list_pair";
require "$.basis.__char";
require "$.basis.__string";

structure Cipher : CIPHER =
  struct


    (* Convert string 's' to a list of upper case letters with all words
     strung together. *)

    fun textList s = 
      let
	(* Find all words, by using all non-letter characters as delimiters. *)
	fun notAlpha c = not (Char.isAlpha c)
        val wordList = String.tokens notAlpha s

	(* Join all words together. *)
	val joinedStr = String.concat wordList
      in 
	(* Explode to a list and convert all letters to upper case. *)
	map Char.toUpper (String.explode joinedStr)
      end


    (* Appends 'key' to itself repeatedly until it is at least as long
     as 'message'. *)

    fun extendKey (message, key) = 
      key @ extendKey (String.extract (message, length key, NONE), key)
      handle Subscript => key


    (* Displace a single character 'msgChar' by the amount corresponding to
     'keyChar'.  This amount is the letter of the alphabet, with #"A" giving
     a displacement of 0, and #"Z" a displacement of 25. *)

    fun encipherChar (msgChar, keyChar) =
      let
	val ordA = Char.ord #"A"
	val msg = Char.ord msgChar - ordA
	val key = Char.ord keyChar - ordA
      in
	Char.chr ((msg + key) mod 26 + ordA)
      end


    (* The inverse of encipherChar. *)

    fun decipherChar (msgChar, keyChar) =
      let
	val ordA = Char.ord #"A"
	val msg = Char.ord msgChar - ordA
	val key = Char.ord keyChar - ordA
      in
	Char.chr ((msg - key) mod 26 + ordA)
      end


    (* Encode 'message' by applying encipherChar to each corresponding 
     character in 'message' and 'key' (extended using extendKey).  This is 
     done concisely by using ListPair.map.  The result of this is then
     imploded so as to return the result as a string. *)
     
    fun encipher (message, key) =
      String.implode (ListPair.map encipherChar
		      (textList message,
                       extendKey (message, textList (key))))


    (* Decodes 'message' using 'key'. *)

    fun decipher (message, key) =
      String.implode (ListPair.map decipherChar 
		      (String.explode message,
                       extendKey (message, textList (key))))


  end






