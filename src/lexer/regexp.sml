(*
$Log: regexp.sml,v $
Revision 1.3  1995/07/17 10:09:20  jont
Add hex digit class

Revision 1.2  1992/08/15  15:55:12  davidt
Removed a couple of redundant functions and added the
negClass function.

Revision 1.1  1991/09/06  16:43:25  nickh
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)
signature REGEXP = 
  sig
    datatype RegExp =
      DOT of RegExp * RegExp
    | STAR of RegExp
    | BAR  of RegExp * RegExp
    | NODE of string (* any string now *)
    | CLASS of string (* class of characters, alternated *)
    | EPSILON

    val plusRE : RegExp -> RegExp
    val sequenceRE : RegExp list -> RegExp

    val printable : RegExp
    val letter : RegExp
    val digit : RegExp
    val hexDigit : RegExp
    val any : RegExp

    (* negated class, written [^...] in lex *)
    val negClass : string -> RegExp
  end
