(* print.sml the signature *)
(*
$Log: print.sml,v $
Revision 1.3  1991/11/21 17:05:05  jont
Added copyright message

Revision 1.2  91/11/19  12:20:52  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:43  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  15:59:08  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(* Outputs the string to stdout *)

signature PRINT = 
  sig
    val print : string -> unit
  end

  
