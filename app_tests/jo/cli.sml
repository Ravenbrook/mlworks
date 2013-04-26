(*
 *
 * $Log: cli.sml,v $
 * Revision 1.2  1998/06/08 13:12:13  jont
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
                         the signature


version of July 1996, updating to use the Harlequin MLWorks separate
compilation system.
*)



signature CLI =
sig
  val run: unit -> unit
end;

