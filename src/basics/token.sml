(* token.sml the signature *)
(*
$Log: token.sml,v $
Revision 1.14  1996/03/18 16:20:34  matthew
New language definition

 * Revision 1.13  1995/07/28  14:30:08  matthew
 * Removing MAGICCLOSE
 *
Revision 1.12  1995/07/24  15:21:45  jont
Add WORD token

Revision 1.11  1995/07/19  09:55:32  jont
Add char token

Revision 1.10  1995/03/17  14:31:50  matthew
Use ints as basic character representation

Revision 1.9  1993/05/20  11:31:41  matthew
Added code for abstractions.

Revision 1.8  1993/03/30  10:03:48  daveb
Added LexerState type.

Revision 1.7  1993/02/12  15:32:22  matthew
Added magic brackets tokens

Revision 1.6  1992/05/14  12:00:08  richard
Added IGNORE token in order to remove recursion from lexer.

Revision 1.5  1992/03/25  16:29:08  matthew
Added a token print function, makestring

Revision 1.4  1991/11/21  16:00:24  jont
Added copyright message

Revision 1.3  91/11/19  12:16:28  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.2.1.1  91/11/19  11:05:23  jont
Added comments for DRA on functions

Revision 1.2  91/06/20  17:48:39  nickh
Added REQUIRE to the reserved words, for separate compilation.

Revision 1.1  91/06/07  10:58:02  colin
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

(* 

This module defines a type Token which is the unit of information
handed from the lexer (lexer/lexer.sml) to the parser
(parser/parser.sml). Tokens are divided by the Definition into
reserved words, special constants, and identifiers. Here special
constants are further subdivided into integers (which can also appear
as labels in records), reals and strings, and identifiers are
separated into type variables (prefixed with a ', and accompanied by
equality and imperative attributes) and others (which may have
structure qualifiers).

The reserved words are treated as an enumerated type, since this
(which amounts to an inteeger) is more efficient than handling
strings. 

When called from the shell, the end of line is treated as an end of
file.  The lexer may reach the end of a line in the middle of a comment
or string, with this being legal input.  The status of the lexer in
such a case is indicated by the LexerState type.

The function makestring makes a string from a token

*)

require "symbol";

signature TOKEN =
    sig
        structure Symbol : SYMBOL

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
	    IN_COMMENT of int |		(* depth of nesting *)
	    IN_STRING of int list	(* in \f .... f\ formatting sequence *)

        datatype Token = 
            RESERVED of Reserved |
            INTEGER of string |
            REAL of string | 
            STRING of string|
            CHAR of string|
            WORD of string|
            LONGID of Symbol.Symbol list * Symbol.Symbol |
            TYVAR of Symbol.Symbol * bool * bool |
            IGNORE |
	    EOF of LexerState

        val makestring: Token -> string

    end
