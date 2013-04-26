(*
 * Foreign Interface parser: final structure
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: __fi_parser.sml,v $
 * Revision 1.2  1997/08/22 10:25:46  brucem
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)

require "fi_abs_syntax";
require "__fi_abs_syntax";
require "fi_int_abs_syn";
require "_fi_int_abs_syn";
require "lex_parse_interface";
require "__lex_parse_interface";
require "_fi_parser";
require "fi_grm";
require "_fi_grm";
require "fi_lex";

require "$.lib.base";
require "$.lib.join";
require "$.lib.parser2";


local

  structure FIIntAbsSyn = FIIntAbsSyn (structure FIAbsSyntax=FIAbsSyntax)

  structure FILrVals = FILrValsFun(structure FIIntAbsSyn = FIIntAbsSyn
                                   structure Token = LrParser.Token
                                   structure LexParseInterface = LexParseInterface)

  structure FILex = FILexFun(structure Tokens = FILrVals.Tokens
                             structure LexParseInterface = LexParseInterface)

  structure Joined = Join(structure LrParser = LrParser
                          structure ParserData = FILrVals.ParserData
                          structure Lex = FILex)
in

  (* This is the top level structure for the FI Parser, it contains
     functions for parsing and the abstract syntax data types *)

  structure FIParser = FIParser(structure FIIntAbsSyn = FIIntAbsSyn
                                structure LexParseInterface = LexParseInterface
                                structure Joined = Joined
                                structure Tokens = FILrVals.Tokens)
end
