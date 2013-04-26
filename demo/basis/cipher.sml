(*  ==== BASIS EXAMPLES : CIPHER signature ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module provides functions for enciphering and deciphering using the
 *  Vigenere cipher.  The combined use of the Char and String structures
 *  in the basis library is demonstrated.  The ListPair structure is also used.
 *
 *  Revision Log
 *  ------------
 *  $Log: cipher.sml,v $
 *  Revision 1.2  1996/08/09 18:27:27  davids
 *  ** No reason given. **
 *
 *  Revision 1.1  1996/07/26  15:34:42  davids
 *  new unit
 *
 *
 *)


signature CIPHER =
  sig

    (* encipher (message, key)
     will encode 'message' using 'key' to determine the result. *)

    val encipher : string * string -> string


    (* decipher (message, key)
     will decode 'message' using 'key' to determine the result. *)

    val decipher : string * string -> string

  end
