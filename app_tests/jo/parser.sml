(*
 *
 * $Log: parser.sml,v $
 * Revision 1.2  1998/06/08 13:15:33  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*           Jo: A concurrent constraint programming language
 	                (Programming for the 1990s)

			   Andrew Wilson


		     Recursive Descent Parser
			6th November 1990

                          the signature

Version of July 1996, modified to use Harlequin MLWorks separate
compilation system.
*)


signature PARSER =
sig
    type token
    type object
    type constraint
    type agent
    type clause

    exception ParseError of token

    val parse: string * int * string * string * bool * bool -> bool
    val parseCLI: unit -> int * agent * string list
    val openFile: string * int * string * string * bool-> unit
end;


