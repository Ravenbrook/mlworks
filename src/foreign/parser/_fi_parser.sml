(*
 * Foreign Interface Parser: Functor for final structure
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
 * $Log: _fi_parser.sml,v $
 * Revision 1.2  1997/08/22 10:22:49  brucem
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)

require "fi_grm";
require "fi_abs_syntax";
require "fi_int_abs_syn";
require "lex_parse_interface";
require "fi_parser";
require "$.lib.base";
require "$.basis.__io";
require "$.basis.__text_io";
require "$.basis.__string";

functor FIParser (structure FIIntAbsSyn : FI_INT_ABS_SYN
                  structure LexParseInterface : LEX_PARSE_INTERFACE
                  structure Joined : PARSER
                    sharing type Joined.pos = LexParseInterface.pos
                    sharing type Joined.result =
                                 FIIntAbsSyn.FIAbsSyntax.declaration_list
                    sharing type Joined.arg = LexParseInterface.arg
                  structure Tokens : FI_TOKENS
                    sharing type Tokens.token = Joined.Token.token
                    sharing type Tokens.svalue = Joined.svalue ) : FI_PARSER =
struct

  structure FIAbsSyntax = FIIntAbsSyn.FIAbsSyntax

  (* This is an example for testing only, the final function(s) will
    depend on how we interface with the rest of the system. *)

  val parseFile =
    fn fName =>
    let
      val file = (TextIO.openIn fName)
                 handle _ => raise Fail "Can't open file"
      val lexer = Joined.makeLexer (fn i => TextIO.inputN (file, i))
      val (result, lexer') =
        Joined.parse(0 (* lookahead *), lexer, LexParseInterface.error,
                     LexParseInterface.arg)
      val _ = TextIO.closeIn file
    in
      result
    end
    handle Joined.ParseError =>
              (print "Parse error occurred.\n"; FIAbsSyntax.DECL_LIST [])
         | (Fail s) => (print s; FIAbsSyntax.DECL_LIST [])
         | e => (print ("Unknown Error: "^(General.exnMessage e)^"\n");
                 FIAbsSyntax.DECL_LIST [])
end