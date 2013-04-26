(*
Free imperative tyvars in function body

Result: FAIL
 
$Log: functor_imptyvars.sml,v $
Revision 1.1  1993/12/02 11:16:24  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

functor F () =
  struct
    val x = ref []
  end;
