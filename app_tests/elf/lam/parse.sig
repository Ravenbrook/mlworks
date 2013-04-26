(*
 *
 * $Log: parse.sig,v $
 * Revision 1.2  1998/06/03 12:15:27  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Parser primitives *)

signature PARSE =
sig

  structure Parser : PARSER

  exception ParseError of (Parser.pos * Parser.pos) * string
  type token_stream
  val file_open : string -> (unit -> unit) * token_stream
  val file_parse : token_stream -> (Parser.result * token_stream) option
  val interactive_parse : string -> string -> Parser.result option
  val stream_init : instream -> (string -> string) -> token_stream
  val stream_parse : token_stream -> (Parser.result * token_stream) option

end  (* signature PARSE *)
where type Parser.pos = int

