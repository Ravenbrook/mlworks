(*
Sharing error: between functor parameter and rigid type

Result: OK

$Log: share13.sml,v $
Revision 1.1  1993/05/21 14:06:43  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

signature R = sig end;
functor Foo(structure T : R structure U : R) : sig structure S : R sharing S = T end = struct structure S = T end;
