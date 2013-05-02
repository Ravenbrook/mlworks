(*  ==== BASIS EXAMPLES : SEARCH signature ====
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
 *  $Log: search.sml,v $
 *  Revision 1.2  1996/09/04 11:57:03  jont
 *  Make require statements absolute
 *
 *  Revision 1.1  1996/08/09  17:46:09  davids
 *  new unit
 *
 *
 *)


require "$.basis.__text_io";

signature SEARCH =
  sig

    (* searchStream (strm, searchString)
     Consume all characters in 'inputStream' up to the first occurrence of
     'searchString', if it exists. *)
    
    val searchStream : TextIO.instream * string -> unit


    (* searchFile (filename, searchString)
     Determine whether 'searchString' is contained somewhere within the file
     'filename'. *)

    val searchFile : string * string -> bool


    (* Input strings to search for from the user, and output the results of
     the search. *)

    val searchInput : unit -> unit

  end
