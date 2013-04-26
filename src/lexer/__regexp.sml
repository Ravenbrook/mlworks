(*
$Log: __regexp.sml,v $
Revision 1.2  1992/08/15 16:19:18  davidt
Added the Lists structure.

Revision 1.1  1991/09/06  16:46:00  nickh
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__lists";
require "_regexp";

structure RegExp_ = RegExp(structure Lists = Lists_);
