(*
Not a real test, part of a larger one
Result: FAIL
 
$Log: separate1_c.sml,v $
Revision 1.1  1993/08/20 13:03:26  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)
require "separate1_b";
require "separate1_a";

functor F(structure B : sig structure A : sig end end structure A : sig end sharing B.A = A) =
  struct end;

structure C = F(structure B = B structure A = A);
