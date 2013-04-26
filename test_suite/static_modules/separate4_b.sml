(*
Disallow mid-file requires

Result: FAIL
 
$Log: separate4_b.sml,v $
Revision 1.1  1993/08/20 13:44:43  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)
require "separate4_a";
val x = 1;
require "separate4_a";
