(* __value_printer_utilities.sml the structure *)

(*
$Log: __value_printer_utilities.sml,v $
Revision 1.2  1993/12/09 19:27:04  jont
Added copyright message

Revision 1.1  1992/08/13  16:41:20  clive
Initial revision

 * Copyright (c) 1993 Harlequin Ltd.
*)

require "../typechecker/__basis";
require "../typechecker/__types";
require "_value_printer_utilities";

structure ValuePrinterUtilities_ = 
  ValuePrinterUtilities(
     structure Types = Types_
     structure Basis = Basis_)
