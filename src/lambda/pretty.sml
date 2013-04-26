(****************************************)
(* pretty.sml - A Simple Pretty-Printer *)
(****************************************)

(* $Log: pretty.sml,v $
 * Revision 1.4  1992/09/24 11:25:23  richard
 * Added reduce.
 *
Revision 1.3  1991/11/21  16:24:58  jont
Added copyright message

Revision 1.2  91/08/06  11:55:28  davida
Added print_T function to print a pretty-tree as it
is generated, without generating an intermediate
string.  This function should be used for very large
or deep print trees, where string concatenation and
the accumulation of garbage causes a dramatic time/space
growth...

Revision 1.1  91/07/19  10:17:33  davida
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)


signature PRETTY = 
    sig
	type T

	val blk : int * T list -> T
	val str : string -> T
	val brk : int -> T
	val nl  : T
	val lst : string * T list * string -> T list -> T list

	val margin: int ref

    	val string_of_T : T -> string

	val print_T : (string -> unit) -> T -> unit (* use this for big ones *)

        val reduce : ('a * string -> 'a) -> ('a * int * T) -> 'a
    end;

