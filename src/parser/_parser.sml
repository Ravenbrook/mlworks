(* _newparser.sml the functor *)
(*
$Log: _parser.sml,v $
Revision 1.32  1998/02/19 16:35:48  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.31  1996/09/25  11:12:48  matthew
 * Problem with end location in parse_incrementally
 *
 * Revision 1.30  1996/08/09  11:38:41  daveb
 * [Bug #1534]
 * Added infix declaration for "before".
 *
 * Revision 1.29  1996/04/19  14:29:40  matthew
 * Removing exceptions
 *
 * Revision 1.28  1996/03/25  11:05:22  matthew
 * Extra field in VALdec
 *
 * Revision 1.27  1996/03/18  16:18:04  matthew
 * Removed topdec_semicolons option
 *
 * Revision 1.26  1996/03/15  14:38:02  daveb
 * Fixed use of Info.default_options.
 *
 * Revision 1.25  1995/07/19  12:17:50  matthew
 * Changing parser error reporting.
 *
Revision 1.24  1995/05/15  14:50:20  matthew
Renaming nj_semicolons

Revision 1.23  1995/02/28  11:00:13  matthew
Changes to Lexer signatture

Revision 1.22  1993/08/12  14:58:55  jont
modified to use new multiple unget facility

Revision 1.21  1993/07/28  16:07:44  matthew
Added error check for Foo.Bar. longids

Revision 1.20  1993/06/16  10:37:00  matthew
Changed to allow no semicolons between topdecs

Revision 1.19  1993/06/09  16:33:46  matthew
Semi clean up of parser state

Revision 1.18  1993/05/20  10:47:59  jont
Changed default status of @ to infixr 5

Revision 1.17  1993/05/14  17:05:08  jont
Added New Jersey interpretation of weak type variables under option control

Revision 1.16  1993/04/26  16:08:45  jont
Added remove_str for getting rid of FullPervasiveLibrary_ from initial env

Revision 1.15  1993/04/01  12:33:14  daveb
Exposed LexerState so that _shell can set prompts appropriately.
Changed parse_incremental so that it distinguishes between the end of lines
and the end of files.

Revision 1.14  1993/03/30  11:54:46  daveb
Changes to EOF handling to support LexerState.

Revision 1.13  1993/03/24  13:29:26  daveb
Lexer.getToken now takes an options parameter.

Revision 1.12  1993/03/19  12:15:43  matthew
Added is_initial_state function
/

Revision 1.11  1993/03/16  16:04:56  matthew
Changed type of parse_incrementally to fit with error wrapping

Revision 1.10  1993/03/10  14:56:57  matthew
Options changes

Revision 1.9  1993/03/09  11:30:46  matthew
Options & Info changes

Revision 1.8  1993/02/03  18:02:51  matthew
Rationalised sharing.

Revision 1.7  1992/12/21  10:37:40  matthew
Changed SyntaxError exception to include a location and print the token differently.

Revision 1.6  1992/11/25  20:12:59  daveb
 Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.5  1992/11/05  17:48:15  matthew
Changed Error structure to Info

Revision 1.4  1992/10/14  11:42:35  richard
Added line number to token stream input functions.

Revision 1.3  1992/10/07  16:11:48  matthew
Added functions for incremental parsing.

Revision 1.2  1992/09/04  08:56:39  richard
Installed central error reporting mechanism.

Revision 1.1  1992/08/26  10:18:00  matthew
Initial revision

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "LRparser";
require "../lexer/lexer";
require "../utils/crash";
require "parser";

functor NewParser (
  structure LRparser : LRPARSER
  structure Lexer : LEXER
  structure Crash : CRASH

  sharing Lexer.Token = LRparser.ActionFunctions.Token
  sharing LRparser.ActionFunctions.Info.Location = Lexer.Info.Location
  sharing Lexer.Token.Symbol = LRparser.ActionFunctions.Absyn.Ident.Symbol
  sharing LRparser.ActionFunctions.Info = Lexer.Info
    
  sharing type LRparser.ActionFunctions.Options.options = Lexer.Options
) : PARSER =
struct

structure Lexer = Lexer
structure Absyn = LRparser.ActionFunctions.Absyn
structure ActionFunctions = LRparser.ActionFunctions
structure Info = ActionFunctions.Info
structure Token = Lexer.Token
structure Options = ActionFunctions.Options
structure PE = ActionFunctions.PE
structure Symbol = Absyn.Ident.Symbol

type ParserBasis = PE.pB

val empty_pB = PE.empty_pB

exception WrongParseResultType

exception SeriousParseError

fun with_parser_basis pB f =
  let 
    val old_pB = ActionFunctions.getParserBasis()
    val _ = ActionFunctions.setParserBasis pB
    val result = 
      f ()
      handle exn =>
        (ActionFunctions.setParserBasis old_pB;raise exn)
  in
    ActionFunctions.setParserBasis old_pB;
    result
  end

fun token_to_string tok =
  ActionFunctions.print_token (ActionFunctions.token_to_parsed_object (false, tok))

(* The location should be the location before the token *)    
fun check_semicolon (error_info,options,ts,(tok,loc)) =
  case tok of
    Token.RESERVED Token.SEMICOLON => ()
  | Token.EOF _ => ()
  | Token.IGNORE => ()
  | _ => Lexer.ungetToken((tok,loc), ts)

(* this function filters out longids with null names since the lexer no
 longer checks for this *)

fun getToken error_info (args as (options, ls, ts)) =
  let
    val token = Lexer.getToken error_info args
    val _ =
      case token of
        Token.LONGID (_,sym) =>
          if Symbol.symbol_name sym = ""
            then Info.error error_info (Info.RECOVERABLE, 
                                        Lexer.locate ts,
                                        "Invalid long identifier: " ^ Token.makestring token)
          else ()
      | _ => ()
  in
    token
  end
  
(* EOFs in the middle of comments and strings are treated differently
   by each parser, so they're handled here instead of in the lexer. *)
(* There is a nasty hack whereby we have to record the location of the token stream *)
(* before reading the current token *)
fun parse_topdec error_info (options,ts,pB) =
  let
    val gettok = getToken error_info
    val parse_it = LRparser.parse_it (error_info,options)
    val lasttok = ref (Token.IGNORE, Info.Location.UNKNOWN)
    fun get_next () =
      let
        val loc1 = Lexer.locate ts
        val tok = gettok (options, Token.PLAIN_STATE, ts)
        val loc = Lexer.locate ts
      in
	(lasttok := (tok,loc1);
         case tok of
	   Token.EOF (Token.IN_COMMENT _) =>
	     Info.error error_info
			(Info.RECOVERABLE, loc,
			 "End of file reached while reading comment")
	 | Token.EOF (Token.IN_STRING _) =>
	     Info.error error_info
			(Info.RECOVERABLE, loc,
			 "End of file reached while reading string")
	 | _ => ();
	 (tok, loc))
      end
  in
    with_parser_basis
    pB
    (fn () =>
     (ignore(parse_it (get_next, Lexer.is_interactive ts));
      Crash.impossible "Topdec not found in parser??!!"))
    handle ActionFunctions.FoundTopDec x =>
      (check_semicolon (error_info,options,ts,!lasttok);
       x)
  end

exception NotExpression

fun parse_string (s,error_info,options,pB) =
  let
    open Absyn
    fun get_expression (STRDECtopdec (strdec,_)) =
      (case strdec of
         (DECstrdec (VALdec ([(pat,exp,_)],[],_,_))) =>
           (case pat of
              VALpat ((valid,_),_) =>
                (case valid of
                   Ident.LONGVALID (Ident.NOPATH,Ident.VAR sym) =>
                     if Symbol.symbol_name sym = "it"
                       then exp
                     else raise NotExpression
                 | _ => raise NotExpression)
            | _ => raise NotExpression)
       | _ => raise NotExpression)
      | get_expression _ = raise NotExpression
    val sref = ref s
    fun input_fn _ = let val result = !sref in sref := ""; result end
    val ts = Lexer.mkTokenStream(input_fn,"String Input")
    val (topdec,_) = parse_topdec error_info (options,ts,pB)
  in
    get_expression topdec
  end

val (initial_pB,initial_pB_for_builtin_library) = 
  let
      fun parse pB s =
	let
	  val done = ref false
	  val ts =
            Lexer.mkTokenStream
            (fn _ => if !done then "" else (done := true; s), "")
	in
	  parse_topdec
	    (Info.make_default_options ())
	    (Options.default_options,ts,pB)
	end
      
      val (_, initial) =
	parse empty_pB   
	
	"(* first value constructors *) \
          \  datatype constructors = true | false | nil | :: | ref \

          \  (* next exception constructors *) \
          \  exception Ord and Chr and Div and Sqrt and Exp and Ln and Io \
          \ and Match and Bind and Interrupt \

          \  (* next value variables *) \
          \  val map = () and rev = () and not = () and ~ = () and abs = () \
          \  and floor = () and real = () and sqrt = () and sin = () and cos = () \
          \  and arctan = () and exp = () and ln = () and size = () and chr = () \
          \  and ord = () and explode = () and implode = () and ! = () \
          \  and substring = ()   \
          
          \  and / = () and div = () and mod = () and + = () and * = () and - = () \
          \  and ^ = () and @ = () and <> = () and < = () and > = () \
          \  and <= = () and >= = () and := = () and o = () \

          \  (* finally we define the infix identifiers *) \
          \  infix 7 / * div mod \
          \  infix 6 + - ^ \
          \  (*infix 5 @*) \
          \  infixr 5 :: @ \
          \  infix 4 <> < > <= >= =\
          \  infix 3 := o   \
          \  infix 0 before \
          \\
          \\
          \ structure Array = \
           \    struct     \
           \       val update = () and length = () and array = () \
           \         and sub = () and tabulate = () and arrayoflist = () \
           \        exception Size and Subscript   \
           \    end ; ";

      val (_, initial') =
	parse empty_pB   
	
	"(* first value constructors *) \
          \  datatype constructors = true | false | nil | :: | ref \

          \  (* next value variables *) \
          \  fun call_c x = ()  \

          \  (* finally we define the infix identifiers *) \
          \  infixr 5 ::  \
          \        ;"


    in
      (initial,initial')
    end

  val augment_pB = PE.augment_pB

  val remove_str = PE.remove_str

  (* Incremental Parsing *)
  
  type ParserState = LRparser.ParserState

  val initial_parser_state = LRparser.initial_parser_state

  fun is_initial_state ps = LRparser.is_initial_state ps

  exception FoundTopDec of (Absyn.TopDec * ParserBasis * Info.Location.T)

  exception SyntaxError of string * Info.Location.T

  (* End of file is overloaded here - a "fake" EOF is found at the end of
     each line, which must be distinguished from a real EOF.  So the shell
     indicates a real EOF by creating a tokenstream for which eof returns
     true before any tokens have been read. *)
  (* There is a nasty hack whereby we have to record the location of the token stream *)
  (* before reading the current token *)
  (* This is to ensure that ungetting tokens resets the location appropriately *)
  fun parse_incrementally error_info (options,ts,pB,ps,ls) =
    let
      val gettok = getToken error_info
      val lasttok = ref (Token.IGNORE, Info.Location.UNKNOWN)
      fun loop (ps, ls) =
        let
          val loc1 = Lexer.locate ts
          val tok = gettok (options, ls, ts)
          val location = Lexer.locate ts
        in
          lasttok := (tok,loc1);
	  case tok of 
            Token.EOF ls' =>
	      (* End of line *)
              (ActionFunctions.getParserBasis(), ps, ls')
          | _ =>
            let val new_state =
                  LRparser.parse_one_token((error_info,options),tok,location,ps)
            in
	      if LRparser.error_state new_state then
	        raise SyntaxError ("Unexpected `" ^ token_to_string tok ^ "'",location)
	      else
                loop (new_state, Token.PLAIN_STATE)
            end
        end
    in
      with_parser_basis
      pB
      (fn () =>
       if Lexer.eof ts then
         (* this is a real EOF, not just an end of line *)
         let
           val location = Lexer.locate ts
         in
           case ls of
             (Token.IN_COMMENT _) =>
               (Info.error error_info
                (Info.RECOVERABLE, location,
                 "End of file reached while reading comment");
                (pB, ps, ls))
           | (Token.IN_STRING _) =>
               (Info.error error_info
                (Info.RECOVERABLE, location,
                 "End of file reached while reading string");
                (pB, ps, ls))
           | _ =>
               let
                 val new_state =
                   LRparser.parse_one_token ((error_info,options),
                                             Lexer.Token.EOF ls, location, ps)
               in
                 (ActionFunctions.getParserBasis(), new_state, ls)
               end
         end
       else
         loop (ps, ls))
      handle ActionFunctions.FoundTopDec (dec, pB) =>
	(check_semicolon (error_info,options,ts,!lasttok);
         raise FoundTopDec (dec, pB, Lexer.locate ts))
    end
end

