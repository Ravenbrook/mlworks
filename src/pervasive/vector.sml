(*
 * The vector module.
 *
 * Copyright (c) 1992 Harlequin Ltd.
 *
 * $Log: vector.sml,v $
 * Revision 1.2  1996/05/21 11:48:58  matthew
 * Adding maxLen
 * Adding maxLen
 *
 * Revision 1.1  1992/12/21  11:18:59  daveb
 * Initial revision
 *
 *
 *)

signature VECTOR =
  sig
    eqtype 'a vector
    exception Size
    exception Subscript
    val vector: 'a list -> 'a vector
    val tabulate: int * (int -> 'a) -> 'a vector
    val sub: 'a vector * int -> 'a
    val length: 'a vector -> int
    val maxLen : int
  end
