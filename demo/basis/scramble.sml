(*  ==== BASIS EXAMPLES : SCRAMBLE signature ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module illustrates some of the lower level binary IO features provided
 *  by the basis library.  It defines functions to scramble and unscramble
 *  files into a different order.  It demonstrates the BinIO structure,
 *  in particular the underlying functional streams used in the BinIO.StreamIO
 *  structure.  It also demonstrates the use of the BinPrimIO, Position and
 *  Word8Array structures.
 *
 *  Revision Log
 *  ------------
 *  $Log: scramble.sml,v $
 *  Revision 1.1  1996/08/09 18:17:24  davids
 *  new unit
 *
 *
 *)


signature SCRAMBLE =
  sig

    (* scramble f (inFile, outFile)
     Scrambles the file 'inFile' using the permutation function 'f', to give
     a new file 'outFile'. *)

    val scramble : (int -> int -> int) -> (string * string) -> unit 


    (* unscramble f (inFile, outFile)
     Unscrambles the file 'inFile' using the permutation function 'f', to give
     a new file 'outFile'.  This is the inverse of 'scramble'. *)

    val unscramble : (int -> int -> int) -> (string * string) -> unit 


    (* The following functions are all permutation functions that can be used
     as arguments for 'scramble' and 'unscramble'. *)

    val reverse : int -> int -> int 

    val shuffle : int -> int -> int

    val rotate : int -> int -> int -> int

    val mix : int -> int -> int -> int

    (* reverse   reverses elements.
       shuffle   performs a perfect shuffle on the elements.
       rotate k  rotates by k elements to the right.
       mix k     mixes up elements in a different way for each key 'k'. *)

  end
