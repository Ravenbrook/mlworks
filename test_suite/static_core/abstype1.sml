(*

Result: OK
 
$Log: abstype1.sml,v $
Revision 1.2  1993/01/20 11:33:43  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

abstype ('a,'b) table = TABLE of 'a -> 'b
with
  fun find key (TABLE f) = f key
end
