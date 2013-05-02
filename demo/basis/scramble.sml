(*  ==== BASIS EXAMPLES : SCRAMBLE signature ====
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
