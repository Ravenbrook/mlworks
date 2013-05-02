(*  ==== BASIS EXAMPLES : Puzzle structure ====
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
 *  $Log: __puzzle.sml,v $
 *  Revision 1.5  1996/11/16 11:30:55  io
 *  [Bug #1757]
 *  renamed __char{array,vector}
 *
 *  Revision 1.4  1996/09/04  11:54:50  jont
 *  Make require statements absolute
 *
 *  Revision 1.3  1996/08/13  09:48:23  davids
 *  ** No reason given. **
 *
 *  Revision 1.2  1996/08/12  14:02:38  davids
 *  Added heuristic to sort words into an order that will be faster.
 *
 *  Revision 1.1  1996/08/09  15:52:59  davids
 *  new unit
 *
 *
 *)


(* NB. The use of 'word' in this module corresponds to the usual English
 meaning of "word" and not to the SML word type. *)

require "puzzle";
require "$.basis.__char_vector";
require "$.basis.__char_array";

structure Puzzle : PUZZLE =
  struct

    (* This type represents the direction in which a word reads in the grid. *)

    datatype direction = HORIZ | VERT


    (* This type represents a gap in the grid which a word may fit into. *)

    datatype gap = GAP of {dir: direction,
			   x: int,
			   y: int,
			   length: int}


    (* This type represents a given criss-cross puzzle.  The grid is a
     character array holding the current state of the puzzle, where spaces
     are represented as #"#" and the puzzle walls as #" ". *)

    datatype puzzle = PUZZLE of {grid : CharArray.array,
				 width : int,
				 height : int,
				 words : string list,
				 gaps : gap list}


    (* This type holds the list of the minimum characters that would need to
     be updated should a given word be placed onto the grid.  It also
     specifies which gap in the gap list would be used. *)  

    datatype placement = PLACE of {updates : (char * int) list,
				   gap : int}

 
    (* Remove the 'n'th element of a list. *)

    fun removeNth ([], _) = raise Empty
      | removeNth (h::t, 1) = t
      | removeNth (h::t, n) = h :: removeNth (t, n - 1)
   

    (* Find the array index to which the co-ordinates (x, y) refer. *)

    fun getPos (PUZZLE {width = width, ...}, x, y) = y * width + x


    (* Find a cell in the puzzle grid with co-ordinates (x, y) *)

    fun getCell (PUZZLE {grid = grid, width = width, ...}, x, y) =
      CharArray.sub (grid, y * width + x)

    
    (* Update the puzzle grid with the characters specified. *)

    fun place (PUZZLE {grid = grid, ...},
	       PLACE {updates = updates, ...}) =
      let
	fun placeChars [] = ()
	  | placeChars ((chr, pos)::t) =
	    (CharArray.update (grid, pos, chr);
	     placeChars t)
      in
	placeChars updates
      end


    (* Remove all characters specified from the puzzle grid. *)

    fun unplace (PUZZLE {grid = grid, ...},
		 PLACE {updates = updates, ...}) =
      let
	fun unplaceChars [] = ()
	  | unplaceChars ((chr, pos)::t) =
	    (CharArray.update (grid, pos, #"#");
	     unplaceChars t)
      in
	unplaceChars updates
      end


    (* Determine whether 'word' will fit correctly into the given gap in
     'puzzle'.  Return the PLACE values in this case, ie. the list of 
     positions that would be written in with characters if this word
     was placed in the grid. *)

    fun matchGap' (puzzle as PUZZLE {grid = grid, ...},
		   GAP {dir = dir, x = xStart, y = yStart, length = length},
		   word) =
      let
	(* Check if the 'i'th character of 'word' matches the character in the
	 grid.  If the character is #"#" then it matches automatically. *)
	fun matchChar (i, places) =
	  if i >= length then
	    SOME places
	  else
	    let
	      (* Find the index into grid for the current character. *)
	      val gridPos = case dir of
		HORIZ => getPos (puzzle, xStart + i, yStart)
	      | VERT => getPos (puzzle, xStart, yStart + i)

	      (* Find the character held in this position in the grid. *)
	      val gridChar = case dir of 
		HORIZ => getCell (puzzle, xStart + i, yStart)
	      | VERT => getCell (puzzle, xStart, yStart + i)

	      val wordChar = CharVector.sub (word, i)
	    in
	      case gridChar of
		#" " => NONE
	      | #"#" => matchChar (i + 1, (wordChar, gridPos) :: places)
	      | c => 
		  if wordChar = c then 
		    matchChar (i + 1, places)
		  else
		    NONE
	    end
      in
	matchChar (0, [])
      end
	
    
    (* If 'word' is a different length to the gap, then return NONE
     immediately.  Otherwise check the individual characters. *)

    fun matchGap (puzzle, gap as GAP {length = length, ...}, word) =
      if length <> (CharVector.length word) then
	NONE
      else
	matchGap' (puzzle, gap, word)


    (* Find all gaps in 'puzzle' that 'word' will fit in correctly, and return
     the PLACE values for each of these. *)

    fun fitWord (puzzle as PUZZLE {gaps = gaps, ...}, word) =
      let
	fun fitGap ([], _) = []
	  | fitGap (h::t, gapNum) =
	      case matchGap (puzzle, h, word) of
		NONE => fitGap (t, gapNum + 1)
	      | SOME places => PLACE {updates = places,
				      gap = gapNum} :: fitGap (t, gapNum + 1)
      in
	fitGap (gaps, 1)
      end
    

    (* Print out the grid for the given puzzle. *)

    fun printGrid (PUZZLE {grid = grid,
			   width = width,
			   height = height,
			   ...}) = 
      let
	fun printLine h =
	  if h >= height then
	    ()
	  else
	    (print (CharArray.extract (grid, h * width, SOME width) ^ "\n");
	     printLine (h + 1))
      in
	(print "\nSolution:\n\n";
	 printLine 0)
      end


    (* Solve 'puzzle'.  This is done by a purely brute force technique of
     trying to fit each word into every possible gap.  If it fits, then
     the grid is updated and 'solve' is called recursively.  The updates on
     'grid' are then undone, so that backtracking can occur.  Once all the
     words have been placed the puzzle is solved, so print out the grid. *)

    fun solvePuzzle (puzzle as PUZZLE {words = words, ...}) =
      case words of
	[] => printGrid puzzle
      | (word :: rest) => placeWord (puzzle, fitWord (puzzle, word), rest)

    (* For each possible placing of the word, update the grid, call 'solve'
     recursively, and then undo the updates. *)

    and placeWord (puzzle as PUZZLE {grid = grid,
				     width = width,
				     height = height,
				     words = words,
				     gaps = gaps},
		   places, 
		   otherWords) =
      case places of
	[] => ()
      | ((headPlace as PLACE {gap = gap, ...}) :: tailPlace) => 
	  (place (puzzle, headPlace);
	   solvePuzzle (PUZZLE {grid = grid,
			  width = width,
			  height = height,
			  words = otherWords,
			  gaps = removeNth (gaps, gap)});
	   unplace (puzzle, headPlace);
	   placeWord (puzzle, tailPlace, otherWords))


    (* Find all the gaps in 'puzzle', returning a new puzzle with this field
     filled in appropriately. *)

    fun findGaps (puzzle as PUZZLE {grid = grid,
				    width = width,
				    height = height,
				    words = words,
				    gaps = gaps}) =
      let
	(* Only cons a value onto the list 'l' if it is SOME v. *)

	fun consOption (NONE, l) = l
	  | consOption (SOME v, l) = v :: l

	(* Work through the grid left to right, top to bottom, finding the
	 list of all horizontal sequences of spaces that have a length > 1. *)

	fun findHorizGaps (x, y, blanks) =
	  let
	    fun horizGap () =
	      if blanks > 1 then
		SOME (GAP {dir = HORIZ,
			   x = x - blanks,
			   y = y,
			   length = blanks}) 
	      else
		NONE
	  in
	    if y >= height then
	      []
	    else
	      if x >= width then
		consOption (horizGap (), findHorizGaps (0, y + 1, 0))
	      else
		if getCell (puzzle, x, y) <> #" " then
		  findHorizGaps (x + 1, y, blanks + 1)
		else
		  consOption (horizGap (), findHorizGaps (x + 1, y, 0))
	  end

	(* Work through the grid top to bottom, left to right, finding the
	 list of all vertical sequences of spaces that have length > 1. *)

	fun findVertGaps (x, y, blanks) =
	  let
	    fun vertGap () =
	      if blanks > 1 then
		SOME (GAP {dir = VERT,
			   x = x,
			   y = y - blanks,
			   length = blanks})
	      else
		NONE
	  in
	    if x >= width then
	      []
	    else
	      if y >= height then
		consOption (vertGap (), findVertGaps (x + 1, 0, 0))
	      else
		if getCell (puzzle, x, y) <> #" " then
		  findVertGaps (x, y + 1, blanks + 1)
		else
		  consOption (vertGap (), findVertGaps (x, y + 1, 0))
	  end
      in
	PUZZLE {grid = grid,
		width = width,
		height = height, 
		words = words,
		gaps = findHorizGaps (0, 0, 0) @ findVertGaps (0, 0, 0)}
      end
      

    local

      (* Sort a list using insertion sort.  Sort on the function 'compare'. *)

      fun sort (l, compare) =
	let
	  fun ins (x, []) = [x]
	    | ins (x, y::ys) = 
	      if compare (x, y) = GREATER then
		y::ins (x, ys)
	      else
		x::y::ys

	  fun insort [] = []
	    | insort (x::xs) = ins (x, insort xs)
	in
	  insort l
	end

      (* Compare function for comparing lengths of strings. *)

      fun compareStrings (s1, s2) =
	if size s1 > size s2 then GREATER
	  else if size s1 = size s2 then EQUAL
	    else LESS

      (* Compare function for comparing lengths of lists. *)

       fun compareLists (l1, l2) =
	 if length l1 > length l2 then GREATER
	   else if length l1 = length l2 then EQUAL
	     else LESS

      (* Separate out a list into lists for each different length string. *)

      fun separate ([], _, acc) = acc
	| separate (_, _, []) = raise Empty
	| separate (h::t, length, ah::at) =
	  if size h = length then
	    separate (t, length, (h::ah)::at)
	  else
	    separate (t, size h, [h]::ah::at)

      (* Join a list of lists into a single list. *)
      
      fun join [] = []
	| join (h::t) = h @ join t

    in
      (* Sort the words into an order that allows the puzzle to be solved
       faster - with words of a unique length at the front of the list and
       those with many words of the same length at the back. *)
      
      fun orderWords words = 
	let
	  val sortWords = sort (words, compareStrings)
	  val separateWords = separate (sortWords, ~1, [[]])
	  val orderedWords = sort (separateWords, compareLists)
	in
	  join orderedWords
	end
    end


    (* Find the width of the lines in 'lineList'.  If they are not all the
     same width then raise Size. *)

    fun getWidth lineList =
      let
	val width = CharVector.length (hd lineList)
	fun getWidth' ([], size) = size
	  | getWidth' (h::t, size) =
	    if CharVector.length h = size then
	      getWidth' (t, size)
	    else
	      raise Size
      in
	getWidth' (lineList, width)
      end


    (* Create a puzzle from a list of strings ('lineList') representing the
     original grid, and from a list of strings ('wordList') giving the words
     to be placed in that grid. *)

    fun makePuzzle (lineList, wordList) =
      let
	val width = getWidth lineList
	val height = length lineList
	val words = orderWords wordList
	val gridVec = CharVector.concat lineList
	val grid = CharArray.array (CharVector.length gridVec, #" ")
	val _ = CharArray.copyVec {src = gridVec,
				   si = 0,
				   len = NONE,
				   dst = grid,
				   di = 0}
      in
	findGaps (PUZZLE {grid = grid, 
			  width = width,
			  height = height,
			  words = words,
			  gaps = []})
      end


    (* Solve the given puzzle.  'lineList' represents the original grid, and
     'wordList' represents the words to be placed into the grid. *)

    fun solve (lineList, wordList) =
      solvePuzzle (makePuzzle (lineList, wordList))


    (* A small example puzzle. *)

    val smallPuzzle =
      (["##### #",
	"# # # #",
	"# # ###",
	"##### #",
	"### ###",
	"###   #"],

       ["APPLE", "AWE", "BUBBLE", "EAT", "LABEL", "OWL",
	"PIT", "ROTATE", "TEE", "ZEALOT", "ZEBRA"])


    (* This puzzle is taken from "Kriss Kross" magazine. *)

    val mediumPuzzle =
      (["      #  # #### #  ",
	"      #  #    # # #",
	"#   # #  #    # # #",
	"#   ###############",
	"##### #  # #  # # #",
	"#   #    # #  # # #",
	"    #      #    # #",
	"    #  #######  # #",
	"  #####    #    # #",
	"    #    ###### # #",
	"    #  #   #    # #",
	" ######### #      #",
	"  # #  #  ######   ",
	"  # #    #         ",
	" ########### ####  ",
	"  #      # #  #    ",
	"  #      # ######  ",
	"########   #  #    ",
	"  #        #  #####",
	"########## #       "],

       ["BAR", "BILL", "CHEF", "LIFT", "MAID", "FOYER", "GUARD", "GUEST",
	"HOTEL", "LUNCH", "BARMAN", "DINNER", "PORTER", "STAIRS",
	"TOWELS", "WAITER", "CARPARK", "WAITRESS", "BREAKFAST", "RECEPTION", 
	"SINGLEROOM", "RESTAURANT", "CHAMBERMAID", "SITTINGROOM", 
	"TELEPHONIST", "SERVICECHARGE", "EARLYMORNINGTEA"])

	
    (* This puzzle is taken from "Kriss Kross" magazine. *)

    val largePuzzle =
      (["  #########  ######## #  #",
	"     #    #  #        #  #",
	"   ####   #  #        #  #",
	" #   #    ############## #",
	" #   #    #  # #      #  #",
	"###########  # ###### #  #",
	" #   #    #  # #      #  #",
	" #   #    #  # #   #  ####",
	" # # # ####    ###### #   ",
	" # # #         #   #  # # ",
	" # # # #     ##### #  # # ",
	" # ########    #  ########",
	"   # # #    #  #   #    # ",
	"   #   #    #   ######  # ",
	"   #        #      #    # ",
	"#################  #    # ",
	"   #        #           # ",
	"#########   #     ########",
	"#         # #         # # ",
	"#    #  ######        # # ",
	"#    #    # #         # # ",
	"#    #    # #   ####### # ",
	"#    #      #         # # ",
	"   ##########         # # ",
	"     #         ######## # "],

       ["ANTS", "MICE", "RATS", "RUST", "SCAB", "SLUGS", "APHIDS", "CAPSID",
	"EARWIG", "MILDEW", "SNAILS", "WEEVIL", "TERMITE", "BLACKFLY",
	"CLUBROOT", "CUTWORMS", "GREENFLY", "LEAFSPOT", "WHITEFLY",
	"WIREWORM", "WOODLICE", "APPLESCAB", "BLACKSPOT", "CARROTFLY", 
	"PEAWEEVIL", "TULIPFIRE", "FROGHOPPER", "GREENMOULD", "REDSPIDERS",
	"FLEABEETLES", "CATERPILLARS", "CODLINGMOTHS", "LEATHERJACKET",
	"CABBAGEROOTFLY", "GOOSEBERRYSAWFLY", "RASPBERRYCANESPOT"])

  end
