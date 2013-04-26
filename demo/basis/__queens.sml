(*  ==== BASIS EXAMPLES : Queens structure ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module demonstrates the use of the Word structure in the basis
 *  library.  It solves the eight queens problem - the problem of determining
 *  how eight queens may be placed on a chessboard such that no queen attacks
 *  another queen.  The solution given here works down the board row by row,
 *  using words to represent the state of the current row.
 *
 *  Revision Log
 *  ------------
 *  $Log: __queens.sml,v $
 *  Revision 1.3  1996/11/06 11:55:27  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.2  1996/09/04  11:55:34  jont
 *  Make require statements absolute
 *
 *  Revision 1.1  1996/07/26  15:02:04  davids
 *  new unit
 *  No reason given.
 *
 *
 *)


require "queens";

(* This example uses the default Word structure.  The length of word defined
 by this may vary between implementations. *)

require "$.basis.__word";

require "$.basis.__int";

structure Queens : QUEENS =
  struct
    
    (* Extract the nth bit from word w *)

    fun getBit (w, n) = 
      let
        val place = Word.fromInt n
	val mask = Word.<< (0w1, place)
	val b = Word.andb (w, mask)
      in
	Word.>> (b, place)
      end


    (* Set the nth bit in word w *)

    fun setBit (w, n) =
      let
	val mask = Word.<< (0w1, Word.fromInt n)
      in
	Word.orb (w, mask)
      end


    (* Create a string representing a row of the board, placing a queen at the
     position specified by parameter queenPos.  Parameter size specifies the
     length of the row. *)

    fun makeRow (column, queenPos, size) =
      let 
        val letter = if column = queenPos then "Q " else "o "
      in
	if column < size then letter ^ makeRow (column + 1, queenPos, size)
	else "\n"
      end


    (* Create a string representing the board, of dimensions (size x size).
     The positions of the queens are specified in a list of length size. *)

    fun makeBoard (size, []) = "\n"
      | makeBoard (size, h::t) = makeRow (0, h, size) ^ makeBoard (size, t)


    (* For the given row, try placing a queen on all squares of that row which
     are not attacked by queens in any previous rows.  Then recursively call
     placeQueen for the next row.  The function returns the number of 
     solutions found.

     Parameter queens holds the list of positions of queens that have been
     placed.  Parameters vert, ldiag and rdiag are all words representing the
     state of the current row.  If a bit is set then that square is attacked
     by a queen on a previous row.  Each of these parameters represents an
     attack in a different direction. *)

    fun placeQueen (size, row, vert, ldiag, rdiag, queens) =
      let

        fun trySquare column =
	  if column < size then

	    (* If square is not attacked in any direction *)
	    if getBit (vert, column) = 0w0 andalso
	       getBit (ldiag, column) = 0w0 andalso
	       getBit (rdiag, column) = 0w0
	    
	    (* then set bits in vert, ldiag and rdiag representing new queen *)
	    then placeQueen (size, row - 1, setBit (vert, column),
			     Word.<< (setBit (ldiag, column), 0w1),
			     Word.>> (setBit (rdiag, column), 0w1),
			     column::queens) 
	       + trySquare (column + 1)

	    else trySquare (column + 1)
	  else 0
      in
	if row = 0 then (print (makeBoard (size, queens)); 1)	    
	else trySquare 0      
      end


    (* Display all solutions to the n queens problem.  This is a
     generalisation of the eight queens problem, placing n queens on a
     board of size (n x n). *)

    fun nQueens n =
      if n > Word.wordSize then
	print "Board size too large.\n"
      else 
	(print ("Number of solutions: " ^ 
		Int.toString (placeQueen (n, n, 0w0, 0w0, 0w0, [])) ^ "\n"))
	handle Overflow => print ("Too many solutions!")


    (* Display all solutions to the eight queens problem. *)

    fun eightQueens () = nQueens 8
  
  end




