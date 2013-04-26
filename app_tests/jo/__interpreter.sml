(*
 *
 * $Log: __interpreter.sml,v $
 * Revision 1.2  1998/06/08 12:58:36  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*	    Jo: A Concurrent Constraint Programming Language
		    (Programming for the 1990s)

			   Andrew Wilson
			19th November 1990

		   Serial Interpreter for Jo Toddler
                           the structure
*)

require "_interpreter";
require "__code";
require "__scheduler";
require "__dynamics";
require "__arithmetic";


structure Interpreter = Interpreter(structure Code = Code 
                                    structure Scheduler = Scheduler
                                    structure Dynamics = Dynamics
                                    structure Arithmetic = Arithmetic);

