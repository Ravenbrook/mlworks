(*  ==== BASIS EXAMPLES : Search structure ====
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
 *  This module searches a stream for a string by using a simple brute force
 *  algorithm.  It demonstrates the use of the TextIO structure, in particular
 *  the underlying functional streams used in the TextIO.StreamIO structure.
 *
 *  Revision Log
 *  ------------
 *  $Log: __search.sml,v $
 *  Revision 1.2  1996/09/04 11:56:24  jont
 *  Make require statements absolute
 *
 *  Revision 1.1  1996/08/09  18:00:06  davids
 *  new unit
 *
 *
 *)


require "search.sml";
require "$.basis.__text_io";
require "$.basis.__string";

structure Search : SEARCH =
  struct


    (* Search along the stream and string to see if 'searchString' is found
     at this point in 'strm'. *)

    fun search' (strm, searchString, pos) =
      case TextIO.StreamIO.input1 strm of
	NONE => false
      | SOME (chr, nextStrm) =>
	  pos >= size searchString orelse
	  
	  if chr = String.sub (searchString, pos) then
	    search' (nextStrm, searchString, pos + 1)
	  else
	    false
	  

    (* Search through 'strm' until 'searchString' is found within it.  Return
     the remaining stream, or NONE if no match is found. *)

    fun search (strm, searchString) =
      case TextIO.StreamIO.input1 strm of
	NONE => NONE
      | SOME (chr, nextStrm) => 
	  if search' (strm, searchString, 0) then
	    SOME strm
	  else
	    search (nextStrm, searchString)
	

    (* Consume all characters in 'inputStream' up to the first occurrence of
     'searchString', if it exists.  This is done here by converting the
     imperative 'inputStream' into a functional stream, searching this, and
     assigning the result back to the imperative stream. *)

    fun searchStream (inputStream, searchString) =
      let
	val funcStream = TextIO.getInstream inputStream
      in
	case search (funcStream, searchString) of
	  NONE => ignore (TextIO.inputAll inputStream)
	| SOME resultStream => TextIO.setInstream (inputStream, resultStream)
      end


    (* Determine whether 'searchString' is contained somewhere within the file
     'filename'. *)

    fun searchFile (filename, searchString) =
      let
	val strm = TextIO.openIn filename      
	val _ = searchStream (strm, searchString)
	val matchFound = not (TextIO.endOfStream strm)
	val _ = TextIO.closeIn strm
      in
	matchFound
      end


    (* Use the standard input stream to ask the user for the strings to
     search with.  Return the answer on the standard output stream by
     using TextIO.print *)

    fun searchInput () =
      let
	fun removeNewline s = String.extract (s, 0, SOME (size s - 1))
	val _ = TextIO.print "Enter string to search through:\n"
        val inputString = removeNewline (TextIO.inputLine TextIO.stdIn)
	val _ = TextIO.print "Enter string to search for:\n"
	val searchString = removeNewline (TextIO.inputLine TextIO.stdIn)
	val strm = TextIO.openString inputString
	val _ = searchStream (strm, searchString)
	val resultString = TextIO.inputAll strm
	val _ = TextIO.closeIn strm
      in
	case resultString of
	  "" => TextIO.print "String not found.\n"
	| s => TextIO.print ("String found at:\n" ^ s ^ "\n")
      end
      
  end
