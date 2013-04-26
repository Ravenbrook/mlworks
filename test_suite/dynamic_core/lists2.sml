(*
Check matching of lists in function declarations.

Result: OK

$Log: lists2.sml,v $
Revision 1.1  1993/01/21 13:56:50  daveb
Initial revision


Copyright (c) 1992 Harlequin Ltd.
*)

let
  fun loop (n :: ns, res:int) = loop (ns, n + res)
    | loop ([], res) = res
in
  loop ([2,3,4,5,6],0)
end

