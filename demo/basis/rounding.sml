(*  ==== BASIS EXAMPLES : ROUNDING signature ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module demonstrates the four IEEE rounding modes that can be used.
 *  It illustrates the use of both the IEEEReal and the StringCvt structures
 *  in the basis library.
 *
 *  Revision Log
 *  ------------
 *  $Log: rounding.sml,v $
 *  Revision 1.1  1996/07/31 16:18:36  davids
 *  new unit
 *
 *
 *)


signature ROUNDING =
  sig
    
    (* For each of the four rounding modes, read in a list of real numbers
     from 'file', and use that rounding mode to truncate to 'decimals'
     places.  If 'decimals' is NONE then the default number of places will
     be used.  The results are printed in a table. *)

    val roundingDemo : string * int option -> unit

  end
