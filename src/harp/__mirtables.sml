(* mirtables.sml the structure *)

(* $Log: __mirtables.sml,v $
 * Revision 1.4  1993/11/01 16:31:50  nickh
 * Merging in structure simplification.
 *
Revision 1.3.1.2  1993/11/01  16:24:54  nickh
Removed unused substructures of MirTables

Revision 1.3.1.1  1992/01/31  09:26:00  jont
Fork for bug fixing

Revision 1.3  1992/01/31  09:26:00  richard
Added Option module.

Revision 1.2  1991/10/15  09:53:08  richard
Added Table to dependencies.

Revision 1.1  91/10/09  13:07:28  richard
Initial revision

Copyright (C) 1991 Harlequin Ltd
*)

require "../utils/__lists";
require "../utils/__crash";
require "__mirregisters";
require "_mirtables";


structure MirTables_ = MirTables(
  structure Lists = Lists_
  structure Crash = Crash_
  structure MirRegisters = MirRegisters_
)
