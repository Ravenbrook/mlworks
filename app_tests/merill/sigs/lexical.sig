(*
 *
 * $Log: lexical.sig,v $
 * Revision 1.2  1998/06/08 17:32:42  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 
lexical.sig

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     19/02/91
Glasgow University and Rutherford Appleton Laboratory.

The basic lexical elements that we can return are:

	NL  -  	We must give parsers the opportunity to handle newlines in 
		their own ways.
	Id  -   Any sequence of A-Za-z0-9 together with underscore "_" and
		prime "'", which must commence with a alphabetic character.
	Digit - any sequence of 0-9.
	Symbol- Symbolics are now matched one at a time !! (bmm 03-12-90 )
	Quote - any sequence of characters delimited by quotes.  The quotes are
		then quietly dropped!
	Other - any other single character - eg parentheses.
*)

signature LEXICAL = 
sig

datatype Token = Id of string | Num of int | NL

val lex : string -> string list
val lex_line : string -> string list
val lex_input : unit -> string list

val scan : string -> Token list
val scan_line : string -> Token list

val end_marker : string
val end_check1 : string -> bool
val end_check2 : string list -> bool

end (* of Signature LEXICAL *)
;
