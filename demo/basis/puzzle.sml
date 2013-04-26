(*  ==== BASIS EXAMPLES : PUZZLE signature ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
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
