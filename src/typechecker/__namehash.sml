(* __namehash.sml the structure *)
(*
$Log: __namehash.sml,v $
Revision 1.2  1993/03/02 16:10:46  matthew
Used Types structure not Datatypes now

Revision 1.1  1992/04/21  14:34:21  jont
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)

require "../utils/__lists";
require "../typechecker/__types";
require "../typechecker/_namehash";

structure NameHash_ = NameHash(
  structure Lists = Lists_
  structure Types = Types_
)
