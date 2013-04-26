(*
 *
 * $Log: i_equality.sml,v $
 * Revision 1.2  1998/06/08 18:10:16  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/04/90
Glasgow University and Rutherford Appleton Laboratory.

i_equality.sml

This module provides the interface for the formal entering and display 
of equality sets.

*)

functor I_EqualityFUN (structure Eq : EQUALITY
		       structure Es : EQUALITYSET
		       structure T  : TERM
		       structure O  : ORDER
		       sharing type Eq.Equality = Es.Equality
		       and     type Eq.Term = Es.Term = T.Term
		       and     type Eq.Signature = Es.Signature = T.Sig.Signature
		       and     type O.ORIENTATION = Eq.ORIENTATION
		       sharing Eq.Pretty = Es.Pretty = T.Pretty = T.Sig.O.Pretty
		      ) : I_EQUALITY =

struct

structure Pretty = Eq.Pretty

type Signature = T.Sig.Signature
type Term = T.Term
type Equality = Eq.Equality
type EqualitySet = Es.EqualitySet
type ORIENTATION = O.ORIENTATION

open Eq Es T O

fun printequality a s e = write_terminal (s^"  "^(unparse_equality a e)^"\n");
val eq_set_size = makestring o length_eq_set ;

local
fun numbered_delete (s::ss) ES = if nl s then ES else
		  (case stringtoint s of
		    OK n     => numbered_delete ss (delete_by_number ES n)
		  | Error _  => if s = "all" then clear_equality_set ES
		   else (error_message (s^" not an integer"); numbered_delete ss ES))
  | numbered_delete   []    ES = ES 

fun orient_one A Ordr e Ev = 
    (printequality A "Equation:" e ;
     case Ordr Ev e of
	 (LR,Ev') => (let val e' = order e 
		      in printequality A "Oriented as:" e' ; e'
		      end, Ev')
	| (RL,Ev') => (let val e' = reorder e 
		      in printequality A "Oriented as:" e' ; e'
		      end, Ev')
	| (UNORIENTABLE,Ev') => (printequality A "Unorderable:" e ;(e,Ev'))
    )

fun orient_all A strat ev Ordr Es = 
    if empty_equality_set Es then (Es,ev) else
    let val (e,res) = (select_eq Es , rest_eq Es )
        val (r,ev') = orient_one A Ordr e ev
        val (Es',ev'') = orient_all A strat ev' Ordr res
    in (eqinsert strat Es' r, ev'')
    end
    
fun numbered_orient A strat Ev Ordr (s::ss) ES = if nl s then (ES,Ev) else
    (case stringtoint s of
	 OK n     => 
		(case select_by_number ES n of 
		  OK e => 
		  (let val ES' = delete_by_number ES n 
		       val (e',Ev') = orient_one A Ordr e Ev
		   in numbered_orient A strat Ev' Ordr ss (eqinsert strat ES' e')
		   end )  
		| Error m => (error_message (s^" out of range"); 
		   			numbered_orient A strat Ev Ordr ss ES))
	| Error _  => if s = "all" then 
		orient_all A strat Ev Ordr ES
		else (error_message (s^" not an integer"); 
		   	numbered_orient A strat Ev Ordr ss ES))
  | numbered_orient A strat Ev _  []    ES = (ES,Ev)
  
fun get s () = (prompt1 s; Lex.lex_input ())

val test = ou null (eq ["\n"])

fun read_equality_set infn endfn A TS strat ES =
    let val s = infn ()
    in if endfn s then ES
       else case parse_equality A TS s of
            OK e => ((*write_terminal (unparse_equality A e ^ "\n") ;*)
		     read_equality_set infn endfn A TS strat 
            				  (eqinsert strat ES e) )
       | Error s => (error_message s ; 
       		     read_equality_set infn endfn A TS strat ES)
    end 

in

fun save_equality_set outfn a es = 
	(app (outfn o (fn (n,s) => s^"\n")) 
	(unparse_equality_set a es) ; 
	 outfn Lex.end_marker)

val enter_equality_set = read_equality_set (get "Enter ") test
fun load_equality_set infn = read_equality_set (Lex.lex o infn) Lex.end_check2

fun display_equality_set a es = 
	(app 
	(fn (n,s) => 
	     Pretty.pr (Pretty.blo(3,[Pretty.str(pad Left 6 n),s,Pretty.str"\n"]),
	                snd (get_window_size ()))) 
	(pretty_equality_set a es) ; ())

fun delete_from_equality_set ES =
    let val s = get "Number or \"all\": " ()
    in if test s then ES
       else if hd s = "all" then numbered_delete s ES
            else delete_from_equality_set (numbered_delete s ES)
    end 

fun orient_select A strat env Ordr ES =
    let val s = get "Number or \"all\": " ()
    in if test s then (ES,env)
       else let val (ES',env') = (numbered_orient A strat env Ordr s ES)
            in orient_select A strat env' Ordr ES'
            end
    end 

end (* of local *) 

end (* of functor I_EqualityFUN *)
;

