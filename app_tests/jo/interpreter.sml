(*
 *
 * $Log: interpreter.sml,v $
 * Revision 1.2  1998/06/08 13:13:52  jont
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
                           the signature
*)

signature INTERPRETER =
sig
   exception ProgramFailed of int
   exception RunError of string

   val interpret: unit -> unit
end;
