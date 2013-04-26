(*
 *
 * $Log: specials.fun,v $
 * Revision 1.2  1998/06/03 12:23:25  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Specially interpreted constants *)

functor Specials
   (structure Term   : TERM
    structure Symtab : SYMTAB  sharing type Symtab.entry = Term.sign_entry)
   : SPECIALS =
struct

  structure Term = Term
  local fun get_entry c =
          let fun the_entry (SOME(e)) = Term.Const(e)
	        | the_entry (NONE) = raise Symtab.Symtab("Special constant " ^ c ^ " unknown.")
           in the_entry (Symtab.find_entry c) end
        fun mark_bogus_dynamic (Term.Const(Term.E(ref {Prog = index_r, ...}))) =
	      index_r := SOME(~1)
          | mark_bogus_dynamic _ = raise Symtab.Symtab ("Bogus dynamic declaration impossible.")
  in

    val backquote = get_entry "`"
    val _ = mark_bogus_dynamic backquote
    val bq = get_entry "#`#"

    val sigma = get_entry "sigma"
    val pr = get_entry "#pr#"

  end  (* local ... *)

end  (* functor Specials *)
