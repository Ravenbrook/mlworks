(*  ==== INITIAL BASIS :  LIST-PAIRS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: list_pair.sml,v $
 *  Revision 1.1  1996/04/18 11:43:18  jont
 *  new unit
 *
 * Revision 1.1  1996/04/18  11:43:18  jont
 * new unit
 *
 *  Revision 1.2  1996/03/20  13:02:28  stephenb
 *  Bring up to date with version 1.0 dated 1/1996 in March 12th 1996 draft.
 *  Added foldl and foldr
 *
 *  Revision 1.1  1995/03/16  21:19:54  brianm
 *  new unit
 *  reanmed from list-pairs.sml
 *
 *
 *)


signature LIST_PAIR =
  sig

    val zip    : ('a list * 'b list) -> ('a * 'b) list
    val unzip  : ('a * 'b) list -> ('a list * 'b list)
    val map    : ('a * 'b -> 'c) -> ('a list * 'b list) -> 'c list
    val app    : ('a * 'b -> unit) -> ('a list * 'b list) -> unit
    val foldl  : (('a * 'b * 'c) -> 'c) -> 'c -> ('a list * 'b list) -> 'c
    val foldr  : (('a * 'b * 'c) -> 'c) -> 'c -> ('a list * 'b list) -> 'c
    val all    : ('a * 'b -> bool) -> ('a list * 'b list) -> bool
    val exists : ('a * 'b -> bool) -> ('a list * 'b list) -> bool

  end (* signature LIST_PAIR *)
