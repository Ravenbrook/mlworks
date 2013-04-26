(*  ==== INITIAL BASIS :  GENERAL ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: general.sml,v $
 *  Revision 1.4  1997/08/04 12:39:36  brucem
 *  [Bug #30084]
 *  Remove items which have been moved to Option.
 *
 * Revision 1.3  1996/05/08  14:53:41  jont
 * Update to latest revision
 *
 * Revision 1.2  1996/04/23  13:05:43  matthew
 * Updating
 *
 * Revision 1.1  1996/04/18  11:42:57  jont
 * new unit
 *
 *  Revision 1.4  1996/03/28  12:29:02  matthew
 *  Fixing rigid type sharing problem
 *
 *  Revision 1.3  1995/03/31  13:44:07  brianm
 *  Adding options operators to General ...
 *
 * Revision 1.2  1995/03/12  18:49:24  brianm
 * Commented out troublesome datatypes and equality definitions.
 *
 * Revision 1.1  1995/03/08  16:23:04  brianm
 * new unit
 *
 *)

signature GENERAL =
  sig
    eqtype  unit
    type  exn

    exception Bind
    exception Match
    exception Subscript
    exception Size
    exception Overflow
    exception Domain
    exception Div
    exception Chr
    exception Fail of string

    val exnName : exn -> string
    val exnMessage : exn -> string

    datatype order = LESS | EQUAL | GREATER

    val <> : (''a * ''a) -> bool

    val ! : 'a ref -> 'a

    val := : ('a ref * 'a) -> unit

    val o : (('b -> 'c) * ('a -> 'b)) -> 'a -> 'c

    val before : ('a * unit) -> 'a

    val ignore : 'a -> unit

  end
