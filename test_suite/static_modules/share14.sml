(*
Sharing error: basis doesn't cover structure

Result: FAIL

$Log: share14.sml,v $
Revision 1.1  1993/05/25 11:50:52  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

structure A = struct type t = int end;

structure A : sig end = A;

signature S = sig structure D : sig type t end sharing D = A sharing type D.t = bool end;
