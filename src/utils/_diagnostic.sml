(*  ==== DIAGNOSTIC OUTPUT ====
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  See signature for documentation of the intended use of this module.
 *
 *  The module is implemented using an internal int ref to store the current
 *  level, which is why it must be instanced on the module it produces
 *  diagnostics for.
 *
 *  Revision Log
 *  ------------
 *  $Log: _diagnostic.sml,v $
 *  Revision 1.7  1998/02/19 16:24:34  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 * Revision 1.6  1997/05/21  17:20:52  jont
 * [Bug #30090]
 * Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.5  1996/04/30  14:27:15  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.4  1992/06/16  11:28:19  davida
 * Added output_fn, internal outstream for messages.
 *
 *  Revision 1.3  1992/02/11  16:48:39  richard
 *  There is a new function, `output_text' which outputs
 *  using the Text type, for efficiency.  See utils/text.sml.
 *
 *  Revision 1.2  1991/11/21  15:16:37  richard
 *  Changed the application of map to an iterate function to prevent
 *  the generation of a useless list of units.
 *
 *  Revision 1.1  91/11/18  16:07:53  richard
 *  Initial revision
 *)

require "../basis/__text_io";
require "text";
require "diagnostic";


functor Diagnostic ( structure Text : TEXT ) : DIAGNOSTIC =

  struct

    structure Text = Text

    val output_stream = TextIO.stdOut

    val level = ref 0

    fun set new_level =
      level := new_level


    (* This function is duplicated in Lists, but it is a pain to *)
    (* parameterize the Diagnostic functor overmuch. *)

    fun iterate f [] = ()
      | iterate f list =
        let
          fun iterate' [] = ()
            | iterate' (x::xs) = (ignore(f x); iterate' xs)
        in
          iterate' list
        end

    fun output_text message_level message_function =
      if !level >= message_level then
        (Text.output (output_stream, 
		      message_function (!level - message_level));
         print"\n")
      else
        ()

    fun output' message_level message_function =
      let
      in
	if !level >= message_level then
	  (iterate 
           (fn string => TextIO.output (output_stream, string))
           (message_function (!level - message_level));
	   TextIO.output (output_stream, "\n"))
	else
	  ()
      end

    val output = output'

      

    fun output_fn message_level message_function =
      let
      in 
	if !level >= message_level then
	  message_function (!level - message_level,
			    output_stream)
	else
	  ()
      end

  end
