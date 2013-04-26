(*
 *
 * $Log: lexer.sml,v $
 * Revision 1.2  1998/06/08 13:14:27  jont
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


                           the signature

Version of July 1996, modified to use Harlequin MLWorks separate
compilation system.

*****************************************************************************)

signature LEXER =
sig
  exception StreamUnopen

  val lineNumber: int ref

  datatype token   = ATOM of string | VAR of string | UNDERSCORE |
 		     BAR | LPAREN | RPAREN | LT | LTE | GT | GTE | EQ | 
		     CONSISTENT | NOT | IS | TRUE | FALSE | SEMICOLON |
		     STOP | ARROW | AMPERSAND | COMMA | BACKSLASH | QUERY |
		     FIXED | KNOWN | NIL | EOF | COMMAND of string |
		     NUMERIC of string * string |
		     PLUSOP | TIMESOP | MINUSOP | DIVOP

  val flushStdIn: unit -> unit
  val openFile: string * int * string * string * bool -> unit
  val nextToken: unit -> token
  val putToken: token -> unit
end;
