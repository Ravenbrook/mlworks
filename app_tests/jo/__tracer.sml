(*
 *
 * $Log: __tracer.sml,v $
 * Revision 1.2  1998/06/08 13:02:06  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*	Jo 90: A Concurrent Constraint Programming Language
		 (Programming for the 1990s)

			Andrew Wilson
			
	  Pretty Printing code and Tracer front panel

		       12th February 1991

			the structure

Version of July 1996 modified to use Harlequin MLWorks separate compilation
system.

=========================================================================*)


require "_tracer";
require "__code";
require "__stream";


structure Tracer = Tracer(structure Code = Code
			  structure Stream = Stream);
