(*
 * Copyright (c) 1995 Harlequin Ltd.
 *
 * $Log: __entry.sml,v $
 * Revision 1.2  1999/02/02 15:59:56  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.1  1995/07/17  11:47:10  matthew
 * new unit
 * Moved from motif
 *
 *
 *  Revision 1.1  1995/07/14  16:47:09  io
 *  new unit
 *  move context_browser bits over.
 *
 *
 *)

require "../main/__user_options";
require "../utils/__crash";
require "../basics/__identprint";
require "../typechecker/__basistypes";
require "../typechecker/__types";
require "../typechecker/__valenv";
require "../typechecker/__scheme";
require "../interpreter/__incremental";
require "_entry";

structure Entry_ =
  Entry (
    (*structure Lists : LISTS*)
    structure IdentPrint = IdentPrint_
    structure BasisTypes = BasisTypes_
    structure Types = Types_
    structure Valenv = Valenv_
    structure Scheme = Scheme_
    structure Crash = Crash_
    structure UserOptions = UserOptions_
    structure Incremental = Incremental_
)
