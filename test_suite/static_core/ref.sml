(*
datatype declarations are generative.

Result: FAIL
 
$Log: ref.sml,v $
Revision 1.2  1993/01/20 13:00:03  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)


datatype 'a ref = FOO of 'a

val x = ref 1 = FOO 1

