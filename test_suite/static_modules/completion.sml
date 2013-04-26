(*
Types resulting from functor application should not be hidden,
whether or not the functor is signature constrained.

Result: OK
 
$Log: completion.sml,v $
Revision 1.1  1995/01/11 14:26:44  jont
new unit
No reason given


Copyright (c) 1995 Harlequin Ltd.
*)
functor F () : sig datatype a = A val x : a end =
  struct
    datatype a = A
    val x = A
  end;

structure S = F ();

functor F () =
  struct
    datatype a = A
    val x = A
  end;

structure S = F ();

structure T =
  struct
    datatype a = A
    val x = A
end
