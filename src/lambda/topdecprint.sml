(* topdecprint.sml the signature *)
(*
$Log: topdecprint.sml,v $
Revision 1.8  1996/08/05 18:03:43  andreww
[Bug #1521]
Propagating changes made to typechecker/_types.sml (essentially
just passing options rather than print_options).

 * Revision 1.7  1993/03/04  14:13:41  matthew
 * Options & Info changes
 * ,
 *
Revision 1.6  1993/02/01  16:14:36  matthew
Added sharing constraints

Revision 1.5  1992/11/25  15:05:46  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.4  1992/09/24  11:43:19  richard
Added print_sigexp.

Revision 1.3  1992/09/16  08:40:20  daveb
show_id_class controls printing of id classes (VAR, CON or EXCON)

Revision 1.2  1991/07/23  09:56:40  davida
Added print_depth for signature expressions.  Could have a better name.

Revision 1.1  91/07/10  09:18:59  jont
Initial revision


Copyright (c) 1991 Harlequin Ltd.
*)

require "../basics/absyn";
require "../main/options";

signature TOPDECPRINT =
  sig
    structure Absyn : ABSYN
    structure Options : OPTIONS

    val print_sigexp	: Options.options
              -> ('a * string -> 'a) -> ('a * int * Absyn.SigExp) -> 'a

(*
    val print_strexp	: ('a * string -> 'a) -> ('a * int * Absyn.StrExp) -> 'a
    val print_strdec	: ('a * string -> 'a) -> ('a * int * Absyn.StrDec) -> 'a
    val print_topdec	: ('a * string -> 'a) -> ('a * int * Absyn.TopDec) -> 'a
*)

    val sigexp_to_string : Options.options -> Absyn.SigExp -> string
    val strexp_to_string : Options.options -> Absyn.StrExp -> string
    val strdec_to_string : Options.options -> Absyn.StrDec -> string
    val topdec_to_string : Options.options -> Absyn.TopDec -> string
  end;
