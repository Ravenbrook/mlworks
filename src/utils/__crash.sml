(* __crash.sml the structure *)
(*
$Log: __crash.sml,v $
Revision 1.4  1992/11/17 16:21:50  matthew
Changed Error structure to Info

Revision 1.3  1992/08/28  15:44:30  richard
Installed central error reporting mechanism.

Revision 1.2  1991/11/21  16:57:59  jont
Added copyright message

Revision 1.1  91/06/07  15:52:08  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../main/__info";
require "_crash";

structure Crash_ = Crash (structure Info = Info_);
