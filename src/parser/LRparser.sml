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

Copyright (c) 1992 Harlequin Ltd.
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
