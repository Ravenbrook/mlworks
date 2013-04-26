(*
Cover

Result: FAIL

$Log: cover12.sml,v $
Revision 1.1  1993/06/25 15:44:10  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

functor A(structure B : sig type t end structure E : sig type t end) =
  struct
    structure C : sig structure D : sig type t end sharing D = B = E end =
      struct
	structure D = E
      end
  end
