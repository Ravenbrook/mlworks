(*
Sharing error: equality types.

Result: FAIL

$Log: respect_eq2.sml,v $
Revision 1.1  1993/01/20 16:54:41  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

signature SIG = 
  sig
    structure A : sig type t end
    structure B : sig datatype t = T of int -> int end
    structure C : sig eqtype t end
    sharing A = B = C
  end
