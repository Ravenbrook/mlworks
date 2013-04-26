(* crash.sml the signature *)
(*
$Log: crash.sml,v $
Revision 1.4  1992/09/30 14:50:38  clive
Type of impossible did not need to be imperative

Revision 1.3  1991/11/21  17:03:40  jont
Added copyright message

Revision 1.2  91/11/19  12:20:39  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:38  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  15:58:11  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(* This module provides two functions for the compiler to call when it
gets into trouble. `impossible' is used when the compiler gets into an
inconsistent state (for instance a function is called with a value of
the `correct type' but the incorrect value constructor (e.g.
cg_fun_type called with a Type which is not FUNTYPE _)).
`unimplemented' is used when an incomplete part of the compiler is
entered. Both functions print their arguments to stdout and exit the
compiler.

*)

signature CRASH =
  sig
    val impossible    : string -> 'a
    and unimplemented : string -> 'a
  end;



             
