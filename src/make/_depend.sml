(* _depend.sml the functor *)
(*
 * $Log: _depend.sml,v $
 * Revision 1.5  1997/05/28 11:25:31  daveb
 * [Bug #30090]
 * Converted lexer to Basis IO.
 *
 * Revision 1.4  1996/05/30  12:46:28  daveb
 * The Io exception is no longer at top level.
 *
 * Revision 1.3  1996/04/30  17:17:35  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.2  1995/12/14  10:57:08  daveb
 * Removed unnecessary dependencies.
 *
 *  Revision 1.1  1995/12/05  10:57:48  daveb
 *  new unit
 *  Read dependency information from .sml files (taken from make/_recompile).
 *

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

require "../basis/__io";
require "../basis/__text_io";

require "../basics/module_id";
require "../lexer/lexer";
require "../main/options";

require "depend";

functor Depend
  (structure Lexer      : LEXER
   structure ModuleId	: MODULE_ID
   structure Options	: OPTIONS

   sharing type ModuleId.Symbol = Lexer.Token.Symbol.Symbol
   sharing type ModuleId.Location = Lexer.Info.Location.T
   sharing type Options.options = Lexer.Options
) : DEPEND =
  struct
    structure Lexer = Lexer
    structure Info = Lexer.Info
    structure Token = Lexer.Token

    type ModuleId = ModuleId.ModuleId;

    (* Returns reversed list of imports *)
    fun get_imports_from_stream (is_pervasive, error_info, ts, imports) =
      let
	val options = Options.default_options
      in
	case Lexer.getToken error_info (options, Token.PLAIN_STATE, ts) of
	  Token.RESERVED Token.REQUIRE =>
	    (case Lexer.getToken error_info (options, Token.PLAIN_STATE, ts) of
	       Token.STRING filename =>
		 let
		   val _ =
	             case Lexer.getToken
		    	    error_info
			    (options, Token.PLAIN_STATE, ts)
	             of Token.RESERVED Token.SEMICOLON =>
		       ()
	             |  _ =>
		       Info.error' error_info
				    (Info.RECOVERABLE,
				     Lexer.locate ts,
				     "missing `;' after `require'")
		
		   val module_id =
		     if is_pervasive then
		       ModuleId.perv_from_require_string
			 (filename, Lexer.locate ts)
		     else
		       ModuleId.from_require_string
			 (filename, Lexer.locate ts)
		 in
		   get_imports_from_stream
		     (is_pervasive, error_info, ts, module_id :: imports)
		 end
	     | _ =>
		 Info.error' error_info
			     (Info.FATAL,
			      Lexer.locate ts,
		              "missing string after `require'"))
	| _ => imports
      end

    (* Returns list of imports *)
    fun get_imports (is_pervasive, error_info, filename) =
      let
	val stream = TextIO.openIn filename
        val ts = Lexer.mkFileTokenStream (stream, filename)
	val imports =
	  get_imports_from_stream (is_pervasive, error_info, ts, [])
      in
	TextIO.closeIn stream;
	rev imports
      end handle IO.Io _ => []

  end
