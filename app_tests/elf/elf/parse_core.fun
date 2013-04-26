(*
 *
 * $Log: parse_core.fun,v $
 * Revision 1.2  1998/06/03 12:25:33  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Joining of various pieces of the generated parser *)
(* This should take care to make system SML of NJ dependencies clear *)

functor ParseCore
   (include sig
      structure Interface : INTERFACE
      structure Parser : PARSER
      sharing type Parser.pos = Interface.pos
      val EOF_token_name : Parser.pos * Parser.pos
			  -> (Parser.svalue,Parser.pos) Parser.Token.token
      val QUERY_token_name : Parser.pos * Parser.pos 
			  -> (Parser.svalue,Parser.pos) Parser.Token.token
      val SIGENTRY_token_name : Parser.pos * Parser.pos
			  -> (Parser.svalue,Parser.pos) Parser.Token.token
    end where type Parser.pos=int
               where type Parser.arg = unit
	)
  : PARSE =
struct

structure Parser = Parser

val EOF_token = EOF_token_name(Interface.dummy_pos,Interface.dummy_pos)
val QUERY_token = QUERY_token_name(Interface.dummy_pos,Interface.dummy_pos)
val SIGENTRY_token = SIGENTRY_token_name(Interface.dummy_pos,Interface.dummy_pos)

type token_stream =
  (Parser.svalue,Parser.pos) Parser.Token.token Parser.Stream.stream

fun file_open filename =
   let val in_stream = open_in filename
       val _ = print("[reading file " ^ filename ^ "]\n")
       val token_stream = Parser.makeLexer(fn i => input_line in_stream)
       val _ = Interface.init_line (1)
       val close_func = fn () => ( close_in in_stream ;
			           print("[closed file " ^ filename ^ "]\n") )
    in (close_func,token_stream) end

exception ParseError of (Parser.pos * Parser.pos) * string

fun parsing_error (msg,lpos,rpos) =
       raise ParseError ((lpos,rpos),msg)

fun skip_DOT_token (parsed_item, token_stream) =
      let val (DOT_token,rest_stream) = Parser.Stream.get(token_stream)
       in SOME(parsed_item,rest_stream) end

fun file_parse token_stream =
    let val (next_token,_) = Parser.Stream.get(token_stream)
     in if Parser.sameToken(next_token,EOF_token)
	   then NONE
	   else skip_DOT_token (Parser.parse(0,
		    Parser.Stream.cons(SIGENTRY_token, token_stream),
			        parsing_error, ()))
    end

fun interactive_parse (prompt:string) (secondaryPrompt:string) =
    let val _ = Interface.init_line (1)
        val firstTime = ref true
	fun inputFun _ = ( if !firstTime
			      then ( print prompt ; flush_out std_out ;
				     firstTime := false )
			      else ( print secondaryPrompt ;
				     flush_out std_out ) ;
			   input_line std_in )
	val stream = Parser.makeLexer inputFun
	val (next_token,_) = Parser.Stream.get(stream)
	fun first_item(result,_) = result
     in if Parser.sameToken(next_token,EOF_token)
	   then NONE
	   else SOME(first_item(Parser.parse(0,
	     Parser.Stream.cons(QUERY_token, stream), parsing_error, ())))
    end

fun stream_init instream echo_func =
    let fun inputFun _  = echo_func (input_line (instream))
	val token_stream = Parser.makeLexer inputFun
	val _ = Interface.init_line (1)
     in token_stream end

fun stream_parse token_stream =
    let val (next_token,_) = Parser.Stream.get(token_stream)
     in if Parser.sameToken(next_token,EOF_token)
	   then NONE
	   else skip_DOT_token
	           (Parser.parse(0,Parser.Stream.cons(QUERY_token,token_stream),
				 parsing_error, ()))
    end

end  (* functor Parse *)
