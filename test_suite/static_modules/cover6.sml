(*
Cover

Result: FAIL

$Log: cover6.sml,v $
Revision 1.1  1993/06/01 14:10:57  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)
structure A = struct type t = int end;
functor Foo(structure C : sig structure B : sig type t sharing type t = real end sharing B = A end) = struct end;
