(*
 *
 * $Log: __cli.sml,v $
 * Revision 1.2  1998/06/08 12:56:58  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*	  Jo: A Concurrent Constraint Programming Language 
		   (Programming for the 1990s)

			  Andrew Wilson

			19th November 1990

  	  	     Command Line Interpreter
                         the structure


version of July 1996, updating to use the Harlequin MLWorks separate
compilation system.
*)

require "__parser";
require "__stream";
require "__lexer";
require "__code";
require "__scheduler";
require "__dynamics";
require "__tracer";
require "__interpreter";
require "_cli";

structure Jo = Cli(structure Code = Code structure Lexer = Lexer
		   structure Stream = Stream
		   structure Parser = Parser 
                   structure Scheduler = Scheduler
		   structure Interpreter = Interpreter
		   structure Dynamics = Dynamics
		   structure Tracer = Tracer);
