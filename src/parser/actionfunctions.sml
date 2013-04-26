(* actionfunctions.sml the signature *)
(*
$Log: actionfunctions.sml,v $
Revision 1.10  1995/03/08 16:27:36  matthew
Adding error_id

Revision 1.9  1994/09/15  10:02:08  matthew
Added make_id_value and print_token

Revision 1.8  1993/06/10  10:40:21  matthew
ActionOpts contains Options.options

Revision 1.7  1993/05/17  11:58:16  jont
Added options parameter to get_resolution

Revision 1.6  1993/05/14  17:03:33  jont
Added New Jersey interpretation of weak type variables under option control

Revision 1.5  1993/03/09  11:19:11  matthew
Options & Info changes

Revision 1.4  1993/02/03  17:59:23  matthew
Rationalised substructures.

Revision 1.3  1992/11/05  16:52:29  matthew
Changed Error structure to Info

Revision 1.2  1992/09/04  08:58:02  richard
Installed central error reporting mechanism.

Revision 1.1  1992/08/25  16:58:06  matthew
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)
require "../basics/token";
require "../basics/absyn";
require "../parser/parserenv";
require "../main/info";
require "../main/options";

require "LRbasics";

signature ACTIONFUNCTIONS =
  sig
    structure Token: TOKEN
    structure Absyn : ABSYN
    structure LRbasics : LRBASICS
    structure PE : PARSERENV
    structure Info : INFO
    structure Options : OPTIONS

    sharing Info.Location = Absyn.Ident.Location
    sharing PE.Ident = Absyn.Ident
    sharing PE.Ident.Symbol = Token.Symbol

    type Parsed_Object
    type ParserBasis

    datatype ActionOpts = OPTS of (Absyn.Ident.Location.T * Info.options * Options.options)

    sharing type ParserBasis = PE.pB

    val do_debug : bool ref

    val dummy_location : Absyn.Ident.Location.T
    val setParserBasis : ParserBasis -> unit
    val getParserBasis : unit -> ParserBasis

    exception ActionError of int
    exception ResolveError of string

    val dummy : Parsed_Object
    val make_id_value : string -> Parsed_Object
    val error_id_value : Parsed_Object

    val print_token : LRbasics.GSymbol * Parsed_Object -> string

    val get_function : int -> (Parsed_Object list * ActionOpts -> Parsed_Object)
    val get_resolution : int * Options.options ->
      (LRbasics.Action * LRbasics.Action * Parsed_Object list * Parsed_Object -> LRbasics.Action)

    type FinalValue
    sharing type FinalValue = Absyn.TopDec

    exception FoundTopDec of (FinalValue * ParserBasis)
    val get_final_value : Parsed_Object -> FinalValue * ParserBasis

    val token_to_parsed_object : bool * Token.Token -> (LRbasics.GSymbol * Parsed_Object)
  end
