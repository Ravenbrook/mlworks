(* __reals.sml the structure *)
(*
$Log: __reals.sml,v $
Revision 1.4  1994/03/08 17:35:04  jont
Replace use of machtypes with machspec

Revision 1.3  1992/09/28  16:57:13  matthew
Removed some structure parameters.

Revision 1.2  1992/04/23  11:32:50  jont
Added lists parameter to functor

Revision 1.1  1991/11/11  14:34:48  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__crash";
require "../machine/__machspec";
require "_reals";

structure Reals_ = Reals(
  structure Crash = Crash_
  structure MachSpec = MachSpec_
)



