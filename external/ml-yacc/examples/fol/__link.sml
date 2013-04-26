require "fol_grm";
require "_fol_grm";
require "_interface";
require "fol_lex";
require "_parse";
require "__absyn";
require "$.lib.base";
require "$.lib.join";
require "$.lib.parser2";

structure FolLrVals : Fol_LRVALS =
   FolLrValsFun(structure Token = LrParser.Token
                structure Absyn = Absyn);

structure Interface : INTERFACE = Interface();
structure FolLex : LEXER =
   FolLexFun(structure Tokens = FolLrVals.Tokens
             structure Interface = Interface);

structure FolParser : PARSER =
   Join(structure ParserData = FolLrVals.ParserData
        structure Lex = FolLex
	structure LrParser = LrParser);

structure Parse : PARSE =
   Parse (structure Absyn = Absyn
	  structure Interface = Interface
	  structure Parser = FolParser
	  structure Tokens = FolLrVals.Tokens );
