(*
 *
 * $Log: lowlevel.sml,v $
 * Revision 1.2  1998/06/08 13:14:55  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*           Jo: A concurrent constraint programming language
 	                (Programming for the 1990s)

			   Andrew Wilson


Version of July 1996, modified to use Harlequin MLWorks separate
compilation system.

Lowlevel definitions used by the Jo Interpreter, using system calls in 
place of the basis library. (For reasons of size.)

                            the signature
*)


signature LOWLEVEL =
sig
  type 'a array
  val array: int * 'a -> 'a array
  val sub: 'a array * int -> 'a
  val update: 'a array * int * 'a -> unit
  val fromList: 'a list -> 'a array

  val makeString: int -> string
  val makeRealString: real -> string
  val stringSub: (string * int) -> int

  type inStream
  val stdIn : inStream

  val inputN: inStream * int -> string
  val openIn: string -> inStream
  val noStdInput: unit -> bool
  val flushStdIn: unit -> unit

end



