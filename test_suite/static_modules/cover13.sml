(*
Cover

Result: FAIL

$Log: cover13.sml,v $
Revision 1.1  1993/06/25 17:10:31  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

functor A(structure B : sig type t end structure E : sig type t end) :
  sig structure F : sig type t end sharing F = E end =
  struct
    structure F = B
  end

