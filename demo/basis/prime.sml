(*  ==== BASIS EXAMPLES : PRIME signature ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module defines a function to test whether a given integer is a prime
 *  number.  It illustrates the use of the LargeInt structure in the basis
 *  library.
 *
 *  Revision Log
 *  ------------
 *  $Log: prime.sml,v $
 *  Revision 1.1  1996/08/01 13:55:53  davids
 *  new unit
 *
 *
 *)

signature PRIME =
  sig

    (* testPrime (q, k)
     Test whether or not 'q' is a prime number, using 'k' tests.  A result
     of true does not guarantee that 'q' is a prime, but the probability is
     very high, and increases with 'k'. *)

    val testPrime : int * int -> bool

  end
