(*
 *
 * $Log: __lexer.sml,v $
 * Revision 1.2  1998/06/08 12:59:06  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*	    Jo: A concurrent constraint programming language
		   (programming for the 1990s)

			  Andrew Wilson

		      Lexical Analyser for Jo

		designed 5th November 1990
		 entered 6th November 1990
		   lost  6th November 1990  (disc crash)
		 retyped 7th November 1990

		 "Remember, Remember the 5th of November,
		  Gunpowder Treason and Plot.
		  There is no reason that Gunpowder Treason
		  Should ever be forgot."


                           the structure

Version of July 1996, modified to use Harlequin MLWorks separate
compilation system.

*****************************************************************************)


require "_lexer";
require "__stream";


structure Lexer = Lexer(structure Stream = Stream);

