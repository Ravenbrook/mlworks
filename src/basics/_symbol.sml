(* _symbol.sml the functor *)
(*
$Log: _symbol.sml,v $
Revision 1.8  1996/10/09 12:36:34  io
moving String from toplevel

 * Revision 1.7  1992/09/15  17:07:18  jont
 * Added strict less than functions for all the symbol types
 *
Revision 1.6  1992/08/10  12:44:23  davidt
Structure String is now pervasive.

Revision 1.5  1992/02/27  12:26:35  jont
Changed symbol_eq so it knows that it's working on strings. This
should improve efficiency

Revision 1.4  1992/02/20  13:12:09  jont
Fixed symbol order to use String.<= rather than String.<, as required
by maps in order to get shadowing correct. Otherwise, you end up with
old objects shadowing newer ones, instead of the reverse

Revision 1.3  1992/02/18  14:00:24  richard
Changed symbol_order to use String.< rather than exploding and
comparing.

Revision 1.2  1991/11/21  15:57:05  jont
Added copyright message

Revision 1.1  91/06/07  10:55:42  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "symbol";

functor Symbol () : SYMBOL =
  struct
    type Symbol = string

    fun symbol_name s = s

    fun find_symbol s = s

    val eq_symbol = (op=) : string * string -> bool

    val symbol_lt :string * string -> bool = (op<)

    val symbol_order : string * string -> bool = (op<=)
  end;
