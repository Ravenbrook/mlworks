(*
 * Foreign Interface parser: Final structure's signature
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: fi_parser.sml,v $
 * Revision 1.2  1997/08/22 10:20:19  brucem
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)

require "fi_abs_syntax";

signature FI_PARSER =
  sig
   structure FIAbsSyntax : FI_ABS_SYNTAX

   val parseFile : string (* filename *) -> FIAbsSyntax.declaration_list

  end
