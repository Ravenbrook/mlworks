(*  ==== TEXT TYPE ====
 *        FUNCTOR
 *
 *  Copyright (C) 1992 Harlequin Ltd
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
