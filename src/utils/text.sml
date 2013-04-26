(*  ==== TEXT TYPE ====
 *       SIGNATURE
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  The text type is analagous to string, but is designed to be cheap to
 *  build up from small components, unlike string which generally duplicates
 *  both halves of a concatenation.  There are no `observer' functions:
 *  texts can only be constructed and output.
 *
 *  Revision Log
 *  ------------
 *  $Log: text.sml,v $
 *  Revision 1.3  1997/05/21 17:24:20  jont
 *  [Bug #30090]
 *  Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.2  1996/04/30  14:22:12  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.1  1992/02/11  11:39:14  richard
 * Initial revision
 *
 *)

require "../basis/__text_io";

signature TEXT =

  sig

    type T

    val from_string	: string -> T
    val from_list	: string list -> T
    val concatenate	: T * T -> T

    val output		: TextIO.outstream * T -> unit

  end
