(*
Bad argument signature in functor application

Result: FAIL
 
$Log: badargs.sml,v $
Revision 1.1  1993/12/01 17:39:01  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

functor F (val x : int) =
  struct
  end;

structure S = F ();
