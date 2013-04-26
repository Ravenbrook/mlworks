(*
 *
 * $Log: __dynamics.sml,v $
 * Revision 1.2  1998/06/08 12:58:08  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*	     Jo 90: A Concurrent Constraint Programming Language
		      (Programming for the 1990s)

			    Andrew Wilson
		           9th January 1991

		    Run-time Support for variables
                             the structure

Version of July 1996, modified to use the Harlequin MLWorks separate
compilation system.
*)

require "_dynamics";
require "__code";
require "__tracer";

structure Dynamics = Dynamics(structure Code = Code
			      structure Tracer = Tracer);





