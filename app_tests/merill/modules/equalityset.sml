(*
 *
 * $Log: equalityset.sml,v $
 * Revision 1.2  1998/06/08 17:51:32  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     10/03/90
Glasgow University and Rutherford Appleton Laboratory.

equalityset.sml

functions for manipulating equality sets.

*)


functor EqualitySetFUN  (structure E : EQUALITY
			 structure T : TERM 
			 structure S : SUBSTITUTION
			 sharing type T.Term = E.Term = S.Term 
			 and     type T.Sig.Signature = E.Signature 
			 	  	= S.Signature 
			 and     type S.Substitution = E.Substitution
			 sharing T.Pretty = T.Sig.O.Pretty = E.Pretty 
			) : EQUALITYSET =

struct

type Signature = T.Sig.Signature
type Term = T.Term
type Equality = E.Equality

open E T S

structure OrdList = OrdListFUN ()
structure Pretty = E.Pretty

(*

An Equality Set has four elements:

Equality list : (int * Equality) OrdList   --  Ordered list of equalities labelled by a number
Count : int 		  --  A counter on the number of equations entered in to the set.
Label : string		  --  A String which gives a short label as a name on the equality set.
Name  : string 		  --  A String which gives a longer name as a description of the  equality set.

*)

(* 
The form of equality sets may ultimately change into some kind of discrimination net
character for the sake of the efficiency of the engine.
*)

abstype EqualitySet = ES of (int * Equality) OrdList.OrdList * int * string * string
with 

val EmptyEqSet = ES ([],0,"","")
fun get_label (ES(es,k,l,n)) = l 
fun get_name  (ES(es,k,l,n)) = n 
fun get_equalities (ES(es,k,l,n)) = map snd es 
	
local 
fun lift_order order = let fun f (_,a) (_,b) = order a b in f end 
in
fun eqinsert order (ES (es1,n,s,s')) E = 
    ES (OrdList.insert (lift_order order) es1 (n+1,E),n+1,s,s')

fun merge_eqsets order (ES (es1,n1,s,s')) (ES (es2,n2,r,r')) = 
   ES (OrdList.merge (lift_order order) es1 (map (apply_fst (add n1)) es2),n1+n2,s,s')

fun select_by_number (ES ((m,e)::es,k,s,s')) n = 
    if n = m then OK e else select_by_number (ES (es,k,s,s')) n 
  | select_by_number (ES ([],_,_,_)) n = Error("No Equation "^makestring n^" in Set")

fun reorder_eqset order (ES (es,k,s,s')) = 
    ES(OrdList.reorder (lift_order order) es,k,s,s')
	
fun map_over_equations order f (ES (es,k,s,s')) = 
    ES(OrdList.map (lift_order order) f es,k,s,s')

fun foldl_over_equations f a (ES (es,k,s,s')) = foldl f a es 

end (* of local *)

fun delete_by_number (ES ((m,e)::es,k,s,s')) n = 
    if n = m then ES (es,k,s,s') 
    else let val ES (es',k,s,s') = delete_by_number (ES (es,k,s,s')) n
	 in ES ((m,e)::es',k,s,s')
    end
  | delete_by_number (ES ([],k,s,s')) n = ES ([],k,s,s')
	  
fun total_entered_in_eqset (ES (es1,n,s,s')) = n
	
fun select_eq (ES ((_,e)::es,m,s,s')) = e
  | select_eq (ES ([],k,s,s')) = failwith "select_eq: Empty Equality Set"
	
fun rest_eq (ES (e::es,m,s,s')) = ES (es,m,s,s')
  | rest_eq (ES ([],k,s,s')) = failwith "rest_eq: Empty Equality Set"
	
fun empty_equality_set (ES (e::es,_,_,_)) = false
  | empty_equality_set (ES ([],_,_,_)) = true
	
fun length_eq_set (ES (es,_,_,_)) = length es

fun rename_eq_set (ES (es,n,s,s')) = ES (map (apply_snd rename_equality) es,n,s,s')

fun equality_map order = map_over_equations order o apply_snd 
fun equality_foldl f   = foldl_over_equations (fn a => (f a o snd))

fun equality_filter p (ES (es,n,s,s')) =
    let fun filt ((n,e)::res) (out,ins) =
            let val (b,e') = p e
            in if b then filt res ((n,e')::out,ins)
               else filt res (out,(n,e')::ins)
            end
          | filt [] (out,ins) = (out,rev ins) (* to preserve the order *)
        val (pes,es') = filt es ([],[])
    in (pes, ES (es',n,s,s'))
    end 

fun unparse_equality_set a (ES (es,n,s',s'')) = map (apply_pair (makestring,unparse_equality a)) es
fun pretty_equality_set a (ES (es,n,s',s'')) = map (apply_pair (makestring,pretty_equality a)) es

(* in addition, we have functions which handle the naming and labelling of equality sets *)

fun change_label (ES(es,k,_,n)) l = ES(es,k,l,n)
fun change_name (ES(es,k,l,_)) n = ES(es,k,l,n)

fun new_equality_set label name = ES([],0,label,name)
fun clear_equality_set (ES(_,n,label,name)) = ES([],n,label,name)

local
fun orderES (ES(es,k,l,n)) (ES(es',j,l',n')) = 
	if l < l' then LT else if l = l' then EQ else GT
in
fun insert_ES [] e = [e]
  | insert_ES (a::l) e = 
   (case orderES e a of 
    LT => e::a::l | EQ => a::l | GT => a::insert_ES l e) 

fun get_by_label (ES(es,k,l,n)::rles) lab = 
    if l = lab 
    then OK (ES(es,k,l,n)) 
    else get_by_label rles lab 
  | get_by_label [] lab = Error ("No Equality Set With Label "^lab) 

fun get_by_name (ES(es,k,l,n)::rles) name = 
    if n = name then OK (ES(es,k,l,n)) else get_by_name rles name
  | get_by_name [] name = Error ("No Equality Set With Name "^name) 

fun remove_by_label (ES(es,k,l,n)::rles) lab = 
    if l = lab then rles else ES(es,k,l,n)::remove_by_label rles lab 
  | remove_by_label [] lab = [] 

fun remove_by_name (ES(es,k,l,n)::rles) name = 
    if n = name then rles else ES(es,k,l,n)::remove_by_name rles name
  | remove_by_name [] name = []

fun change_by_label (ES(es,k,l,n)::rles) lab (ES(es',k',l',n')) = 
    if l = lab then ES(es',k',l',n')::rles 
    else if l < lab then ES(es,k,l,n)::change_by_label rles lab (ES(es',k',l',n'))
         else ES(es',k',l',n')::ES(es,k,l,n)::rles
  | change_by_label [] lab nes = [nes] 

fun change_on_label es e = change_by_label es (get_label e) e

fun new_labES (ES(es,k,l,n)::rles) (ES(es1,k1,l1,n1)) =
    if l1 = l then Error ("Equality Set with Label "^l^" already declared")
    else new_labES rles (ES(es1,k1,l1,n1)) eachM (C insert_ES (ES(es,k,l,n)))
  | new_labES [] (ES(es1,k1,l1,n1)) = OK [ES(es1,k1,l1,n1)] 

end (* of local *)

end  (* of the abstype EqualitySet *)
   
end (* of functor EqualitySetFUN *)
;

