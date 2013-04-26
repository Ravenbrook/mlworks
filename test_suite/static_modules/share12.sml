(*
Sharing error: between functor parameter and rigid type

Result: OK

$Log: share12.sml,v $
Revision 1.1  1993/05/21 14:03:00  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

functor Foo(structure T : sig end structure U : sig end) : sig structure S : sig end sharing S = T end = struct structure S = T end;
