(* LRparser.sml the signature *)
(*
$Log: LRparser.sml,v $
Revision 1.9  1994/08/31 12:03:20  matthew
Remove debug flag

Revision 1.8  1993/03/19  12:13:01  matthew
Added is_initial_state function

Revision 1.7  1993/03/10  14:48:22  matthew
Signature revisions

Revision 1.6  1993/03/04  09:51:11  matthew
Options & Info changes

Revision 1.5  1993/02/03  17:59:49  matthew
Added sharing.

Revision 1.4  1992/11/05  15:08:03  matthew
Changed Error structure to Info

Revision 1.3  1992/10/07  14:15:41  matthew
Added functions for incremental parsing.

Revision 1.2  1992/09/04  13:58:49  richard
Installed central error reporting mechanism.

Revision 1.1  1992/08/26  10:15:24  matthew
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

require "actionfunctions";

signature LRPARSER =
  sig
    structure ActionFunctions : ACTIONFUNCTIONS

    type TokenType
    sharing type TokenType = ActionFunctions.Token.Token

    type Parsed_Object
    sharing type Parsed_Object = ActionFunctions.Parsed_Object

    type ParserState
      
    val initial_parser_state : ParserState
    val is_initial_state : ParserState -> bool
    val error_state : ParserState -> bool
    val parse_one_token :
      ((ActionFunctions.Info.options * ActionFunctions.Options.options) *
       TokenType * ActionFunctions.Info.Location.T * ParserState) ->
       ParserState
    val parse_it :
       (ActionFunctions.Info.options * ActionFunctions.Options.options) ->
       (unit -> TokenType * ActionFunctions.Info.Location.T) * bool ->
       Parsed_Object
  end
