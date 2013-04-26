(*
 *
 * $Log: __scheduler.sml,v $
 * Revision 1.2  1998/06/08 13:00:43  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*		Jo: A Concurrent Constraint Programming Language
			(Programming for the 1990s)

			     Andrew Wilson


			   Scheduler for Baby-Jo

			    19th November 1990

				the structure

Version of July 1996, modified to use Harlequin MLWorks separate
compilation system.
*)

require "_scheduler";
require "__code";
require "__dynamics";
require "__tracer";


structure Scheduler = 
  Scheduler(structure Code = Code structure Dynamics = Dynamics
			structure Tracer = Tracer);

