(******************************************)
(* __pretty.sml - A Simple Pretty-Printer *)
(******************************************)

(* $Log: __pretty.sml,v $
 * Revision 1.3  1991/11/21 16:24:22  jont
 * Added copyright message
 *
Revision 1.2  91/10/22  12:48:47  davidt
Now builds using the Crash_ structure.

Revision 1.1  91/07/19  10:16:44  davida
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__crash";
require "_pretty";

structure Pretty_ =
  PrettyFun(structure Crash = Crash_);
