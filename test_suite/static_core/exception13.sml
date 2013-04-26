(*
 Pattern matching on exceptions is quite hard;
 textual identity is not the same as constructor equivalence.  

Result:  WARNING

$Log: exception13.sml,v $
Revision 1.1  1994/01/20 15:09:28  nosa
Initial revision



Copyright (c) 1993 Harlequin Ltd.
*)

exception A;
exception B = A;
signature E = sig exception C end;
functor F(structure S:E) =
 struct
   local
     fun f _ = 0 handle S.C => 1 | B => 2
   in
     val f = f
   end
 end;
structure f = F(structure S = struct exception C = A end);
(* on structure application, warn that the pattern in functor is redundant *)
