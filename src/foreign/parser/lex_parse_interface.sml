(*
 * Foreign Interface parser: Signature for lexer/parser shared data
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: lex_parse_interface.sml,v $
 * Revision 1.2  1997/08/22 10:33:04  brucem
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)

signature LEX_PARSE_INTERFACE =
  sig

    eqtype pos
    val pos : pos ref
    val startPos : pos
    val nextPos : pos -> pos
    val printPos : pos -> string

    type arg val arg : arg

    val error : string * pos * pos -> unit

  end