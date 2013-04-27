(*
 * Foreign Interface parser: final structure
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
