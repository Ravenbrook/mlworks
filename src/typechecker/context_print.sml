(* context_print.sml the signature *)
(*
$Log: context_print.sml,v $
Revision 1.1  1993/08/09 16:08:32  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

require "../main/options";
require "../basics/absyn";

(* This module prints small sections of abstract syntax to a depth of *)
(* one to give some context to type errors *)

signature CONTEXT_PRINT = 
  sig
    structure Options : OPTIONS
    structure Absyn : ABSYN

    val pat_to_string : Options.print_options -> Absyn.Pat -> string
    val exp_to_string : Options.print_options -> Absyn.Exp -> string
    val dec_to_string : Options.print_options -> (Absyn.Pat * Absyn.Exp) -> string
  end
