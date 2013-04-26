(*
 $Log: lexer.sml,v $
 Revision 1.29  1997/05/28 11:29:01  daveb
 [Bug #30090]
 [Bug #30090]
 Converted lexer to Basis IO.

 * Revision 1.28  1996/09/25  10:13:59  matthew
 * Removing lastToken function
 *
 * Revision 1.27  1996/04/30  14:57:08  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.26  1995/02/14  12:28:36  matthew
 * Removing require options
 *
Revision 1.25  1993/12/23  13:24:39  daveb
Removed mkInteractiveTokenStream.

Revision 1.24  1993/08/12  12:08:44  jont
Modified to allow multiple ungets

Revision 1.23  1993/06/15  14:50:48  matthew
Added single character unGetToken function and lastToken function

Revision 1.22  1993/04/01  09:33:45  daveb
Added the eof argument to mkLineTokenStream for use with the incremental
parser.

Revision 1.21  1993/03/31  14:14:50  daveb
Removed misleading comment.

Revision 1.20  1993/03/30  14:45:33  daveb
Removed ungetToken; no longer used.

Revision 1.19  1993/03/29  11:03:23  daveb
getToken now takes a Lexerstate argument.

Revision 1.18  1993/03/24  11:24:09  daveb
getToken now takes an options parameter.

Revision 1.17  1992/12/21  11:03:11  matthew
Added mkLineTokenStream

Revision 1.16  1992/11/20  13:34:35  matthew
Added an "unget" facility.

 Revision 1.15  1992/11/19  14:33:09  matthew
 Added flush_to_nl
 
 Revision 1.14  1992/11/17  14:26:10  matthew
 Changed Error structure to Info
 
 Revision 1.13  1992/11/09  18:39:19  daveb
 Added clear_eof function.
 
 Revision 1.12  1992/10/14  11:30:54  richard
 Added line number to token stream input functions.
 Added mkFileTokenStream.
 
 Revision 1.11  1992/09/04  08:44:43  richard
 Installed central error reporting mechanism.
 
 Revision 1.10  1992/08/31  15:41:40  richard
 Removed LexError.  Errors are handled by the global Error structure.
 
 Revision 1.9  1992/08/26  13:02:32  matthew
 Added interactive token streams.
 
 Revision 1.8  1992/08/18  13:37:06  davidt
 Took out structure LexGen, flushTokenStream and getbuffer since
 they were never used.
 
 Revision 1.7  1992/08/05  13:31:07  jont
 Removed some structures and sharing
 
 Revision 1.6  1992/05/19  17:12:58  clive
 Fixed line position output from lexer
 
 Revision 1.5  1992/04/13  13:39:34  clive
 First version of the profiler
 
 Revision 1.4  1991/11/19  12:39:21  jont
 Merging in comments from Ten15 branch to main trunk
 
 Revision 1.3  91/10/14  08:42:34  davidt
 Put in the missing require for the LEXGEN signature.
 
 Revision 1.2  91/09/06  16:49:46  nickh
 Lexer signature. This is the same as for the old lexer (before the
 generator was a functor). This interface could do with reworking, but
 the parser would have to be changed to allow that.
 
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

require "../basis/__text_io";
require "../basics/token";
require "../main/info";

(* This module is automatically generated from the lexer descriptions
in generator/LexA, LexB and LexC. It provides the type TokenStream,
and functions for manipulating TokenStreams. See comments later in
this file on those functions. The generation method is essentially
that described by Aho, Sethi, Ullman in "Compilers : Principles,
Techniques and Tools", section 3. See lexgen/generator.sml for more
details. *)

signature LEXER =
    sig
        structure Token : TOKEN
        structure Info : INFO

        type TokenStream
	type Options

        (* The internal representation of a TokenStream is a (potentially
         large) buffer string together with some information about it,
	 including Lexer state info. *)

        val mkTokenStream : (int -> string) * string -> TokenStream
        val mkLineTokenStream :
	      (int -> string) * string * int * bool -> TokenStream
        val mkFileTokenStream : TextIO.instream * string -> TokenStream

        (* mkTokenStream f creates a token stream which gets input characters
         from the function f. Each application of f should return an
         arbitrary-length prefix of the remaining input. f should only return
         the empty string when there is no further input. f is passed the line
         number that will be assigned to the first line it returns. *)

        val getToken : Info.options ->
			 (Options * Token.LexerState * TokenStream) ->
			 Token.Token

        val ungetToken : (Token.Token * Info.Location.T) * TokenStream -> unit
        (* getToken ts removes the next token from ts and returns it. It is a
         table-driven lexer, with tables (arrays) created by the lexer
         generator. *)

        val associated_filename : TokenStream -> string
        val locate : TokenStream -> Info.Location.T
	val eof : TokenStream -> bool
	val clear_eof : TokenStream -> unit
        val is_interactive : TokenStream -> bool

        (* need to flush the input in the buffer for shell error handling *)
        val flush_to_nl : TokenStream -> unit

    end;
