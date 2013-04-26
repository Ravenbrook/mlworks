(*
Sharing error: between functor parameter and rigid type

Result: FAIL

$Log: share10.sml,v $
Revision 1.1  1993/05/21 13:10:56  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

signature S = sig type t end;
functor Foo(structure T : S) : sig sharing type T.t = int end = struct end;
