(*
 *
 * $Log: arithmetic.sml,v $
 * Revision 1.2  1998/06/08 13:11:42  jont
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
                             the signature



version of July 1996 modified to use the Harlequin MLWorks separate
compilation system.
*)

signature ARITHMETIC =
sig

  type condition
  type answer
  type constraint
  type context

  exception ArithError

  val evalPrimitive: constraint * context -> answer
  val publish: constraint * context * bool ref -> answer
end;




