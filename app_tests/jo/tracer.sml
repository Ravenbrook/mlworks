(*
 *
 * $Log: tracer.sml,v $
 * Revision 1.2  1998/06/08 13:18:01  jont
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

			the signature

Version of July 1996 modified to use Harlequin MLWorks separate compilation
system.

=========================================================================*)



signature TRACER =
sig
   exception TraceAbort
   type word
   val prettyPrint: word list * int -> unit
   val plainPrint: word list * int -> unit
   val panel: bool ref -> unit
end;
