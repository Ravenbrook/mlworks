(*  ==== BASIS EXAMPLES : ROMAN signature ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This example program provides functions that can convert Roman numerals
 *  to and from integers.
 *
 *  Revision Log
 *  ------------
 *  $Log: roman.sml,v $
 *  Revision 1.1  1996/07/26 15:30:32  davids
 *  new unit
 *
 *
 *)

signature ROMAN =
  sig
    
    (* Parse a Roman numeral string, to give an integer.  An illegal Roman
     numeral (ie. one that contains illegal characters) will give the result
     NONE.  Attempts to parse any Roman numeral string, but incorrect
     representations may give unpredictable results. *)
    
    val romanToInt : string -> int option


    (* intToRoman n
     Return the Roman numeral string corresponding to 'n'. *)

    val intToRoman : int -> string

  end
