(*
 *
 * $Log: i_term.sml,v $
 * Revision 1.2  1998/06/08 18:09:20  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/04/90
Glasgow University and Rutherford Appleton Laboratory.

i_term.sml 

This module provides the top level interface for the formal entering and display 
of terms

*)

functor I_TermFUN (structure T : TERM 
		   sharing T.Pretty = T.Sig.O.Pretty) : I_TERM = 
struct

structure Pretty = T.Pretty

type Signature = T.Sig.Signature
type Term = T.Term

open T

   fun enter_term Al TS env = 
         let val ss = Lex.lex_input ()
         in if null ss orelse ss = ["\n"] then NoMatch else
	(case parse_term Al TS env ss of
	  OK ((t,s),e) => let val ss = strip s in
	  		  if null ss orelse ss = ["\n"] then Match (t,e)
	  		  else (error_message "Ill-formed Term.  Try again" ;
	  		  	enter_term Al TS env) 
	  		  end
	| Error s      => (error_message (s ^ " Try again") ; 
	                   enter_term Al TS env) )
	end 

   fun display_term Al = C (curry Pretty.pr) (snd(get_window_size ())) o show_pretty_term Al 

end (* of functor I_TermFUN *)
;
