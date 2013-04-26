(*
 *
 * $Log: print.sig,v $
 * Revision 1.2  1998/06/03 11:55:07  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Printing *)

signature PRINT_VAR =
sig

   structure Term : TERM
   val makestring_var : (string -> bool) -> Term.term -> string

end  (* signature PRINT_VAR *)


signature PRINT_TERM =
sig

   structure Term : TERM
   structure F : FORMATTER
   structure S : SYMBOLS   sharing S.F = F

   val makeformat_term : Term.term -> F.format
   val makeformat_const : Term.term -> F.format

   val printDepth : int option ref
   val printLength : int option ref 

end  (* signature PRINT_TERM *)


signature PRINT =
sig

   structure Term : TERM
   structure F : FORMATTER
   structure S : SYMBOLS    sharing S.F = F

   val makeformat_term : Term.term -> F.format
   val makeformat_const : Term.term -> F.format
   val makeformat_varbind : Term.varbind -> F.format
   val makeformat_conbind : Term.varbind -> F.format

   val makestring_term : Term.term -> string
   val makestring_const : Term.term -> string
   val makestring_varbind : Term.varbind -> string
   val makestring_conbind : Term.varbind -> string

   val makestring_vartermlist : (Term.term * Term.term) list -> string
   val makestring_substitution : Term.term list -> string

   (* raise this to signal subtype violations *)
   val subtype : string * Term.term * string -> exn

   val printDepth : int option ref
   val printLength : int option ref 

end  (* signature PRINT *)
