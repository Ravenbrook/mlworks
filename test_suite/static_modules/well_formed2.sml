(*
SIG is well-formed.
Tests for bug in sharing between functor parameter and result signature.

Result: OK

Copyright (c) 1993 Harlequin Ltd.
*)

signature TYPE = sig type t end;

functor SET (structure Type : TYPE):
  sig
    structure T : TYPE
    sharing T = Type
  end =
  struct
    structure T = Type
  end
