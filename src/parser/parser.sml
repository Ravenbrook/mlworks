(* parser.sml the signature *)
(*
$Log: parser.sml,v $
Revision 1.23  1995/02/14 12:30:27  matthew
Changes to Lexer signature

Revision 1.22  1993/05/27  13:08:09  matthew
Added sharing

Revision 1.21  1993/04/26  16:07:52  jont
Added remove_str for getting rid of FullPervasiveLibrary_ from initial env

Revision 1.20  1993/03/31  14:25:43  daveb
Exposed LexerState so that _shell can set prompts appropriately.
Added Location field to FoundTopDec so that history mechanism knows where
the topdec ends.

Revision 1.19  1993/03/29  13:44:36  daveb
Removed skip_topdec.

Revision 1.18  1993/03/24  12:38:14  daveb
Added options parameter to skip_topdec.

Revision 1.17  1993/03/19  12:14:43  matthew
Added is_initial_state function

Revision 1.16  1993/03/16  16:03:58  matthew
Changed type of parse_incrementally to fit with error wrapping

Revision 1.15  1993/03/10  14:47:01  matthew
Options changes

Revision 1.14  1993/03/09  11:30:07  matthew
Options & Info changes
Absyn changes

Revision 1.13  1993/02/01  14:21:39  matthew
Added sharing.

Revision 1.12  1992/12/21  10:27:20  matthew
Changed SyntaxError exception to include a location and print the token differently.

Revision 1.11  1992/11/19  19:17:20  jont
Removed Info structure from parser, tidied upderived

Revision 1.10  1992/11/05  16:22:15  matthew
Changed Error structure to Info

Revision 1.9  1992/10/14  12:35:28  richard
Added a missing sharing constraint.

Revision 1.8  1992/10/08  15:44:07  matthew
Added functions for incremental parsing.

Revision 1.7  1992/10/07  13:38:56  richard
Added a missing sharing constraint.

Revision 1.6  1992/09/02  15:35:35  richard
Installed central error reporting mechanism.

Revision 1.5  1992/02/11  10:16:03  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.4  1992/02/04  17:25:18  jont
Removed ident from signature (not needed)

Revision 1.3  1991/11/21  16:37:13  jont
Added copyright message

Revision 1.2  91/11/19  12:21:17  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:12:34  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  16:18:17  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(* This signature is the externally-visible interface to the modules
in the parser directory.  parse_topdec is self-explanatory.
The type parser_basis is pB from parserenv.
Functions are provided to manipulate this type, providing the
functionality required for separate compilation: an encoded parser
basis is placed in the `spec' component of an object file, and files
which require this file can build a parser basis by augmenting
together the initial parser basis with this.

The parser functions in a top-down manner, with functions for each
syntactic class. The sources are reasonably clear: exceptions are used
for backtracking. *)

require "../lexer/lexer";
require "../basics/absyn";

signature PARSER =
    sig
        structure Lexer  : LEXER
        structure Absyn  : ABSYN
        sharing Lexer.Info.Location = Absyn.Ident.Location
        sharing Absyn.Ident.Symbol = Lexer.Token.Symbol

        type ParserBasis

	val empty_pB : ParserBasis
	val initial_pB : ParserBasis
	val initial_pB_for_builtin_library : ParserBasis
	val augment_pB : ParserBasis * ParserBasis -> ParserBasis
        
	val remove_str : ParserBasis * Absyn.Ident.StrId -> ParserBasis

        val parse_topdec :
          Lexer.Info.options ->
          Lexer.Options * Lexer.TokenStream * ParserBasis -> 
          Absyn.TopDec * ParserBasis

        (* New stuff for incremental parsing *)

        type ParserState
        val initial_parser_state : ParserState

        val is_initial_state : ParserState -> bool

        exception SyntaxError of string * Lexer.Info.Location.T
        exception FoundTopDec of
	  (Absyn.TopDec * ParserBasis * Lexer.Info.Location.T)

        val parse_incrementally :
          Lexer.Info.options ->
          (Lexer.Options * Lexer.TokenStream *
	   ParserBasis * ParserState * Lexer.Token.LexerState) ->
          (ParserBasis * ParserState * Lexer.Token.LexerState)
    end


