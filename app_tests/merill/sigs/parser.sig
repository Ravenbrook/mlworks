(*
 *
 * $Log: parser.sig,v $
 * Revision 1.2  1998/06/08 17:33:34  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 
parser.sml

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     19/02/91
Glasgow University and Rutherford Appleton Laboratory.

Functional parsing routines.

Based on a mixture of Larry Paulson's library of parsing functions
in SML and Guy Argos library of parsing functions with error propagation
in LML together with modifications of my own.

*)

infix 5 -- #-- --#;
infix 3 >>;
infix 0 ||;

signature PARSE =
  sig
  exception SynError of string
  type token
  type 'a parser

  val fail  : 'a parser 
  val empty : 'a list parser
  val eof   : 'a list parser 
  val nl    : 'a list parser
  val id    : string parser
  val num   : int parser

  val $  : string -> string parser
  val symbol : string -> string parser
  val notkey : string list -> string parser

  val -- : 'a parser * 'b parser -> ('a * 'b) parser
  val --# : 'a parser * 'b parser -> 'a parser
  val #-- : 'a parser * 'b parser -> 'b parser
  val || : 'a parser * 'a parser -> 'a parser
  val >> : 'b parser * ('b -> 'd) -> 'd parser

  val infixes : 'a parser * (string -> int) *
      		(string -> 'a -> 'a -> 'a) -> 'a parser
  val repeat : 'a parser -> 'a list parser

  val change_errors : string -> 'a parser -> 'a parser
  val drop_errors : 'a parser -> 'a parser

  val reader: 'a parser -> string -> 'a
  
  end;
