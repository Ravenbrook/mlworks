(* _token.sml the functor *)
(*
$Log: _token.sml,v $
Revision 1.20  1996/11/06 10:51:06  matthew
[Bug #1728]
__integer becomes __int

 * Revision 1.19  1996/10/09  11:52:09  io
 * moving String from toplevel
 *
 * Revision 1.18  1996/04/30  17:33:06  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.17  1996/04/29  13:17:41  matthew
 * Changes to Integer
 *
 * Revision 1.16  1996/03/18  16:20:59  matthew
 * New language definition
 *
 * Revision 1.15  1995/07/28  14:30:21  matthew
 * Removing MAGICCLOSE
 *
Revision 1.14  1995/07/24  15:22:26  jont
Add WORD token

Revision 1.13  1995/07/19  09:56:45  jont
Add char token

Revision 1.12  1995/03/17  14:32:17  matthew
Use ints as basic character representation

Revision 1.11  1993/05/20  11:32:11  matthew
Added code for abstractions.

Revision 1.10  1993/05/18  13:38:05  jont
Removed Integer parameter

Revision 1.9  1993/03/29  11:09:03  daveb
Added LexerState type.

Revision 1.8  1993/02/12  15:35:22  matthew
Added magic brackets tokens

Revision 1.7  1992/08/15  15:39:45  davidt
Fixed bug in printing of longids.

Revision 1.6  1992/05/14  12:00:05  richard
Added IGNORE token in order to remove recursion from lexer.

Revision 1.5  1992/03/25  16:31:45  matthew
Added a token print function, makestring

Revision 1.4  1991/11/21  15:57:20  jont
Added copyright message

Revision 1.3  91/06/20  19:56:48  nickh
Corrected cockup in datatype for 1.2

Revision 1.2  91/06/20  17:49:13  nickh
Added REQUIRE to the reserved words, for separate compilation.

Revision 1.1  91/06/07  10:55:49  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)
require "symbol";
require "token";
require "../basis/__int";

functor Token (
  structure Symbol : SYMBOL
) : TOKEN =
  struct
    structure Symbol = Symbol

    datatype Reserved =
      
      ABSTYPE | AND | ANDALSO | AS | CASE | DO | DATATYPE | ELSE |
      END | EXCEPTION | FN | FUN | HANDLE | IF | IN | INFIX |
      INFIXR | LET | LOCAL | NONFIX | OF | OP | OPEN | ORELSE |
      RAISE | REC | REQUIRE | THEN | TYPE | VAL | WHERE | WITH | WITHTYPE | WHILE |
      
      EQTYPE | FUNCTOR | INCLUDE | SHARING |
      SIG | SIGNATURE | STRUCT | STRUCTURE |
      
      LPAR | RPAR | BRA | KET | LBRACE | RBRACE | COMMA | COLON | ABSCOLON |
      SEMICOLON | ELLIPSIS | UNDERBAR | VBAR | EQUAL | DARROW | ARROW |
      HASH | 

      ABSTRACTION | 

      MAGICOPEN


    datatype LexerState =
      PLAIN_STATE |
      IN_COMMENT of int | 	(* depth of nesting *)
      IN_STRING of int list	(* in \f .... f\ formatting sequence *)

    datatype Token = 
      RESERVED of Reserved |
      INTEGER of string |
      REAL of string | 
      STRING of string |
      CHAR of string |
      WORD of string |
      LONGID of Symbol.Symbol list * Symbol.Symbol |
      TYVAR of Symbol.Symbol * bool * bool |
      IGNORE |
      EOF of LexerState

  
    fun mkstring PLAIN_STATE = ""
    |   mkstring (IN_STRING _) = " (in string)"
    |   mkstring (IN_COMMENT n) =
	  " (in " ^ Int.toString n ^ " levels of comment)"

    fun makestring token =
      case token of
	RESERVED (reserved) =>
	  (case reserved of 
	     ABSTYPE => "abstype"
	   | AND => "and"
	   | ANDALSO => "andalso"
	   | AS => "as"
	   | CASE => "case"
	   | DO => "do"
	   | DATATYPE => "datatype"
	   | ELSE => "else"
	   | END => "end"
	   | EXCEPTION => "exception"
	   | FN => "fn"
	   | FUN => "fun"
	   | HANDLE => "handle"
	   | IF => "if"
	   | IN => "in"
	   | INFIX => "infix"
	   | INFIXR => "infixr"
	   | LET => "let" 
	   | LOCAL => "local" 
	   | NONFIX => "nonfix" 
	   | OF => "of" 
	   | OP => "op" 
	   | OPEN => "open" 
	   | ORELSE => "orelse"
	   | RAISE => "raise" 
	   | REC => "rec" 
	   | REQUIRE => "require" 
	   | THEN => "then" 
	   | TYPE => "type" 
	   | VAL => "val" 
	   | WHERE => "where" 
	   | WITH => "with" 
	   | WITHTYPE => "withtype" 
	   | WHILE => "while"
	   | EQTYPE => "eqtype"
	   | FUNCTOR => "functor" 
	   | INCLUDE => "include" 
	   | SHARING => "sharing" 
	   | SIG => "sig" 
	   | SIGNATURE => "signature" 
	   | STRUCT => "struct" 
	   | STRUCTURE => "structure"
	   | LPAR => "(" 
	   | RPAR => ")" 
	   | BRA => "[" 
	   | KET => "]"
	   | LBRACE => "{" 
	   | RBRACE => "}" 
	   | COMMA => "," 
	   | COLON => ":" 
	   | ABSCOLON => ":>" 
	   | SEMICOLON => ";" 
	   | ELLIPSIS => "..." 
	   | UNDERBAR => "_" 
	   | VBAR => "|"
	   | EQUAL => "=" 
	   | DARROW => "=>"
	   | ARROW => "->"
	   | HASH => "#" 
           | ABSTRACTION => "abstraction"
           | MAGICOPEN => "<<")
      | INTEGER (s) => s
      | REAL (s) => s
      | STRING (s) => s
      | CHAR (s) => s
      | WORD (s) => s
      | LONGID (slist, sym) => concat (map (fn sym => Symbol.symbol_name sym ^ ".") slist) ^ Symbol.symbol_name sym
      | TYVAR (sym, bool1, bool2) => Symbol.symbol_name sym
      | IGNORE => "ignore"
      | EOF ls => "eof" ^ mkstring ls
  end
