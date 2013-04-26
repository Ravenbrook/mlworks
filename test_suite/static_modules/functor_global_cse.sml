(*
  Global CSE shouldn't eliminate common expressions across functor bodies 
  (such as the selections from List here).

  Result: OK

  $Log: functor_global_cse.sml,v $
  Revision 1.3  1997/11/21 10:53:25  daveb
  [Bug #30323]

 *  Revision 1.2  1997/08/01  18:30:48  jkbrook
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *

  Copyright (c) 1997 Harlequin Ltd. 
*)


functor Triv1 () =
struct
   fun nth' (l,n) = List.nth (l,n)
end;

functor Triv2 () =
struct
  fun nth' (l2,n2) = List.nth (l2,n2)
end;


