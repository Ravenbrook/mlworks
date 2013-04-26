(* __token.sml the structure *)
(*
$Log: __token.sml,v $
Revision 1.4  1993/05/18 13:38:47  jont
Removed Integer parameter

Revision 1.3  1993/03/26  17:25:42  daveb
Added Integer_ parameter.

Revision 1.2  1991/11/21  15:55:02  jont
Added copyright message

Revision 1.1  91/06/07  10:54:18  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)
require "__symbol";
require "_token";

structure Token_ = Token (
  structure Symbol = Symbol_)
