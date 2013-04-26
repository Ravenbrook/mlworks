(*
Sharing error: arity.

Result: FAIL

$Log: share7.sml,v $
Revision 1.2  1993/01/20 16:55:21  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature SIG = 
  sig
    structure A : sig type t end
    structure B : sig type t end
    structure C : sig type 'a t end
    sharing A = B = C
  end
