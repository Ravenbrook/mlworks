(*
Result realisation forcing argument sharing

Result: FAIL

$Log: share18.sml,v $
Revision 1.1  1994/01/05 12:38:26  jont
Initial revision

Copyright (c) 1994 Harlequin Ltd.
*)

functor Foo(S : sig type t end) : sig type s sharing type s = S.t end = struct type s = int end;
