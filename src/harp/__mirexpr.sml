(* __mirexpr.sml the structure *)
(*
 * $Log: __mirexpr.sml,v $
 * Revision 1.3  1995/04/27 15:44:04  jont
 * Fix require statements and comments
 *
 * Revision 1.2  1994/11/16  17:29:16  jont
 * Add __machspec parameter
 *
 * Revision 1.1  1994/04/12  14:44:04  jont
 * new file
 *
 * Copyright (c) 1994 Harlequin Ltd.
*)

require "../utils/__lists";
require "../utils/__crash";
require "__mirtables";
require "__mirregisters";
require "__mirprint";
require "../machine/__machspec";
require "_mirexpr";

structure MirExpr_ = MirExpr(
  structure Lists = Lists_
  structure Crash = Crash_
  structure MirTables = MirTables_
  structure MirRegisters = MirRegisters_
  structure MirPrint = MirPrint_
  structure MachSpec = MachSpec_
)
