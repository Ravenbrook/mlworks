(*  ==== BASIS EXAMPLES : SEARCH signature ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
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
