(*
Not a real test, part of a larger one
Result: FAIL
 
$Log: separate1_b.sml,v $
Revision 1.1  1993/08/20 13:02:55  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)
require "separate1_a";

structure B = struct structure A = A end
