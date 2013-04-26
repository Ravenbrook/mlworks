(*  ==== BASIS EXAMPLES : PUZZLE signature ====
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
 *  This module solves "criss-cross" puzzles - puzzles in which a list of
 *  words must be fitted into a crossword grid.  It demonstrates the use of
 *  the CharVector and CharArray structures in the basis library.
 *
 *  Revision Log
 *  ------------
 *  $Log: puzzle.sml,v $
 *  Revision 1.1  1996/08/09 15:53:53  davids
 *  new unit
 *
 *
 *)


signature PUZZLE =
  sig

    (* solve (lineList, wordList)
     Solve the given puzzle.  'lineList' represents the original grid, and
     'wordList' represents the words to be placed into the grid. *)

    val solve : (string list * string list) -> unit


    (* The following are all example criss-cross puzzles. *)

    val smallPuzzle : (string list * string list)

    val mediumPuzzle : (string list * string list)    

    val largePuzzle : (string list * string list)
	  
  end
