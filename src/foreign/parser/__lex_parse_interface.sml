(*
 * Foreign Interface parser: Structure shared between lexer and parser
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: __lex_parse_interface.sml,v $
 * Revision 1.3  1997/08/22 15:06:46  brucem
 * [Bug #30034]
 * Change `require "basis.__int";' to `require "$.basis.__int";'.
 *
 *  Revision 1.2  1997/08/22  10:35:09  brucem
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 *)

require "lex_parse_interface";
require "$.basis.__int";

structure LexParseInterface : LEX_PARSE_INTERFACE =
  struct

    type pos = int
    val startPos = 1
    val pos = ref startPos
    val nextPos = fn i => i+1
    val printPos = Int.toString

    type arg = unit val arg = ()

    val error = fn (s, p1, p2) =>
                (pos := startPos;
                 raise Fail (s^" at "^(printPos p1)^", "^(printPos p2)^"\n"))
           (* Alternative is to print and continue *)

  end
