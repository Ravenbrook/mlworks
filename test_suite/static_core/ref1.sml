(*
datatype declarations are generative.

Result: FAIL
 
$Log: ref1.sml,v $
Revision 1.2  1993/01/20 13:01:54  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)


datatype 'a FOO = ref of 'a

val x :int ref = ref 1
