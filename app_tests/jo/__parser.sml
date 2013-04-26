(*
 *
 * $Log: __parser.sml,v $
 * Revision 1.2  1998/06/08 13:00:09  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*           Jo: A concurrent constraint programming language
 	                (Programming for the 1990s)

			   Andrew Wilson


		     Recursive Descent Parser
			6th November 1990

                          the structure

Version of July 1996, modified to use Harlequin MLWorks separate
compilation system.
*)

require "_parser";
require "__lexer";
require "__code";


structure Parser = Parser(structure Code = Code structure Lexer = Lexer);



