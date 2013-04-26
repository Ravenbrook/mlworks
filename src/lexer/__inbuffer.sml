(*
$Log: __inbuffer.sml,v $
Revision 1.4  1994/03/08 14:45:29  daveb
Added Location parameter.

Revision 1.3  1992/08/07  15:45:10  davidt
String structure is now pervasive.

Revision 1.2  1992/01/31  16:53:06  jont
Added require"__string"; and reference to String_

Revision 1.1  1991/09/06  16:47:44  nickh
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "_inbuffer";
require "../basics/__location";

structure InBuffer_ =
  InBuffer (structure Location = Location_);
