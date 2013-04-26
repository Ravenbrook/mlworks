(* symbol.sml the signature *)
(*
$Log: symbol.sml,v $
Revision 1.4  1992/09/15 17:06:52  jont
Added strict less than functions for all the symbol types

Revision 1.3  1991/11/21  16:00:03  jont
Added copyright message

Revision 1.2  91/11/19  12:16:26  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:06:30  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  10:57:59  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(* 

This module defines a type Symbol and functions for manipulating them.
This conceals the string nature of symbols and would allow one to add
more information to the symbol type. The functions are all
self-explanatory.

Symbols are used throughout the compiler for identifiers, via the
basics/ident.sml module. N.B. qualified identifiers (foo.bar.baz) are
represented using lists of symbols.

*)


signature SYMBOL =
    sig
        eqtype Symbol
        val symbol_name : Symbol -> string
        val find_symbol : string -> Symbol
        val eq_symbol   : Symbol * Symbol -> bool
	val symbol_lt   : Symbol * Symbol -> bool
	val symbol_order: Symbol * Symbol -> bool
    end

