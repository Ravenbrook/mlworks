(*
 *
 * $Log: stream.sml,v $
 * Revision 1.2  1998/06/08 13:17:25  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*    	    Jo: A concurrent constraint programming language
		     (programming for the 1990s)

    Implementation of a character stream as input to lexical analyser

		Andrew Wilson:  6th November 1990

			the signature

Version of July 1996, modified to use Harlequin MLWorks separate
compilation system.
*)



signature STREAM =
sig
  exception Eof
  exception StreamUnopen

  val flushStdIn: unit -> unit
  val openStream: string * int -> unit
  val putSymbol: string -> unit
  val nextSymbol: bool -> string     (* where string has length one *)
end;
