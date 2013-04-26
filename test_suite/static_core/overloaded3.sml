(*
Overloaded operators and overloaded literals must co-exist.

Result: OK
 
$Log: overloaded3.sml,v $
Revision 1.1  1994/05/12 15:29:07  daveb
new file


Copyright (c) 1994 Harlequin Ltd.
*)

fun nearest_power_of_two (size,x) =
  if x >= size then
    x
  else
    nearest_power_of_two (size,2*x);
