(*
 *
 * $Log: __arithmetic.sml,v $
 * Revision 1.2  1998/06/08 12:56:30  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*		Jo 90: A Concurrent Constraint Programming Language
			(Programming for the 1990s)

			     Andrew Wilson

			   14th January 1991

		       Arithmetic Constraint System
                             the structure

version of July 1996 modified to use the Harlequin MLWorks separate
compilation system.
*)

require "__code";
require "__dynamics";
require "__scheduler";
require "_arithmetic";

structure Arithmetic = 
    Arithmetic(structure Code = Code structure Dynamics = Dynamics
			structure Scheduler = Scheduler);




