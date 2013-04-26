(*
Result: OK
 
$Log: enricherr1.sml,v $
Revision 1.2  1993/01/20 16:31:18  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

structure A : sig type 'a t end = 
  struct
    type 'b t = 'b list
  end

 
