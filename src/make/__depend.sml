(* __depend.sml the structure *)
(*
 * $Log: __depend.sml,v $
 * Revision 1.3  1995/12/14 10:50:31  daveb
 * Removed unnecessary dependencies.
 *
 *  Revision 1.2  1995/12/07  17:05:44  daveb
 *  Corrected copyright date.
 *
 *  Revision 1.1  1995/12/05  10:57:05  daveb
 *  new unit
 *  Read dependency information from .sml files (taken from make/_recompile).
 *
 * 
 * Copyright (c) 1995 Harlequin Ltd.
 *)

require "../basics/__module_id";
require "../lexer/__lexer";
require "../main/__options";
require "_depend";

structure Depend_ =
  Depend (
    structure Lexer = Lexer_
    structure ModuleId = ModuleId_
    structure Options = Options_
)
