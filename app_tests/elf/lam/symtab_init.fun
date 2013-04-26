(*
 *
 * $Log: symtab_init.fun,v $
 * Revision 1.2  1998/06/03 12:06:32  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Initialize the empty symbol table with the special constants *)
(* Appling this functor will read the file init_file *)

functor SymtabInit
  (structure Term : TERM
   structure Sign : SIGN  sharing Sign.Term = Term
   structure EmptySymtab : SYMTAB
      sharing type EmptySymtab.entry = Term.sign_entry
   val sig_file_read : string -> Sign.sign
   val init_file : string) : SYMTAB =
struct

(* reproduce the definitions from EmptySymtab, then override clean *)
open EmptySymtab

local open Term
      fun restore (SOME(cref as E(ref{Bind = Varbind(c,A),...}),sign')) = 
	     ( EmptySymtab.add_entry c cref ; reinstall sign' )
        | restore _ = ()
      and reinstall sign = restore (Sign.sig_item sign)

      val init_sign = sig_file_read init_file
in

  fun clean () = ( EmptySymtab.clean () ; EmptySymtab.checkpoint () ;
		   reinstall init_sign
		      handle exn => ( print "%WARNING: pervasives could not be reinstalled." ;
				      EmptySymtab.rollback () ;
				      raise exn ) ;
		   EmptySymtab.commit () )

end  (* local ... *)

end  (* functor SymtabInit *)
