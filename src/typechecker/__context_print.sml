(* __context_print.sml the structure *)
(*
$Log: __context_print.sml,v $
Revision 1.2  1996/10/29 12:09:56  io
[Bug #1614]
removing Lists

 * Revision 1.1  1993/08/09  15:41:22  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)

require "^.utils.__crash";
require "^.main.__options";
require "^.basics.__absyn";
require "^.basics.__identprint";
require "^.typechecker.__types";
require "_context_print";

structure Context_Print_ = Context_Print(
  structure Crash   = Crash_
  structure Options = Options_
  structure Absyn = Absyn_
  structure IdentPrint = IdentPrint_
  structure Types = Types_
)
