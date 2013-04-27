(*  ==== DIAGNOSTIC OUTPUT ====
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
 *  This module is intended for use in all other modules which could produce
 *  debugging output.  The structure should be exported in the signature of
 *  the module it diagnoses, and the Diagnostic functor should therefore be
 *  applied for each instance so that each module can have a separate
 *  debugging level, settable from outside.  For example a structure Foo can
 *  have its debugging output enabled by, say:
 *
 *     Foo.Diagnostic.set 10
 *
 *  Revision Log
 *  ------------
 *  $Log: diagnostic.sml,v $
 *  Revision 1.5  1997/05/21 17:19:55  jont
 *  [Bug #30090]
 *  Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.4  1996/04/30  14:24:59  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.3  1992/06/16  11:28:58  davida
 * Added output_fn, internal outstream for messages.
 *
 *  Revision 1.2  1992/02/11  12:20:19  richard
 *  There is a new function, `output_text' which outputs
 *  using the Text type, for efficiency.  See utils/text.sml.
 *
 *  Revision 1.1  1991/11/18  16:09:40  richard
 *  Initial revision
 *)

require "../basis/__text_io";
require "text";

signature DIAGNOSTIC =

  sig

    structure Text	: TEXT


    (*  === SET DIAGNOSTIC LEVEL ===
     *
     *  The diagnostic level controls which messages are output, and
     *  possibly how verbose those messages are. See `output' below.
     *)

    val set : int -> unit


    (*  === DIAGNOTIC OUTPUT ===
     *
     *  Takes a message level, and a function.  The function is applied only
     *  if the current message level (set by `set', see above) is not less
     *  than the level supplied.  (Level 0 messages will always be output.)
     *  The function is passed the difference between the current level and
     *  the supplied level, and can use this to decide how verbose to be.
     *  The list of strings it returns are printed as if concatenated on the
     *  standard output, followed by a newline.
     *
     *  A function is passed rather than a string so that the code to build
     *  the string is not executed unless it is going to be printed.  The
     *  function returns a list of strings because it is generally expensive
     *  to build large strings by concatenation, whereas consing long lists
     *  of strings is cheap.
     *
     *  The second function, `output_text', is a variant in which the
     *  function returns a Text.T, which is even more efficient to build
     *  than a list of strings.
     *
     *  output_fn allows use of a user-given print routine, on the
     *  standard stream used by diagnostic.
     *
     *)

    val output		: int -> (int -> string list) -> unit
    val output_text	: int -> (int -> Text.T) -> unit
    val output_fn	: int -> (int * TextIO.outstream -> unit) -> unit


  end
