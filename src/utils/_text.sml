(*  ==== TEXT TYPE ====
 *        FUNCTOR
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
 *  Implementation
 *  --------------
 *  The text type is very simple: it's constructors are the exported
 *  functions for building it, so no real computation is done when
 *  making one out of small strings.  The output function traverses the
 *  data structure in order, sending the strings to the outstream one
 *  after the other.  Simple.
 *
 *  Revision Log
 *  ------------
 *  $Log: _text.sml,v $
 *  Revision 1.4  1997/05/21 17:24:52  jont
 *  [Bug #30090]
 *  Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.3  1996/04/30  14:23:25  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.2  1993/08/13  08:39:49  daveb
 * Removed spurious ".sml" from require declaration.
 *
 *  Revision 1.1  1992/02/11  11:40:11  richard
 *  Initial revision
 *
 *)

require "../basis/__text_io";

require "lists";
require "text";

functor Text (

  structure Lists	: LISTS

) : TEXT =

  struct

    datatype T =
      concatenate of T * T
    | from_list   of string list
    | from_string of string

    local

      fun output' (stream, concatenate (left, right)) =
          (output' (stream, left); output' (stream, right))
        | output' (stream, from_list list) =
          Lists.iterate (fn string => TextIO.output (stream, string)) list
        | output' (stream, from_string string) =
          TextIO.output (stream, string)

    in

      val output = output'

    end

  end
