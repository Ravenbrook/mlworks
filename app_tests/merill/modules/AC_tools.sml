(*
 *
 * $Log: AC_tools.sml,v $
 * Revision 1.2  1998/06/08 17:46:31  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

AC_tools.sml

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     22/01/92
Glasgow University and Rutherford Appleton Laboratory.

Provides some basic tools for equational reasoning modulo the Commutative 
and Associative-Commutative theories.

*)

functor AC_ToolsFUN (structure T : TERM
	 	     sharing type T.OpId = T.Sig.O.OpId
		     and     type T.Sig.V.Variable = T.Variable
		    ) : AC_TOOLS =
struct

type Term = T.Term
type Signature = T.Sig.Signature
type OpId = T.Sig.O.OpId
type Variable = T.Sig.V.Variable

open T T.Sig T.Sig.O

val get_operators = T.Sig.get_operators
val VarEq = T.Sig.V.VarEq

local
fun insert t [] = [t]
  | insert t (t1::ts) = 
	if ord_t t1 t then t1::insert t ts
		      else t::t1::ts
  			
fun norm f (n1::ns) = 
    if variable n1 then insert n1 (norm f ns)
    else if same_root f n1
         then norm f (subterms n1 @ ns)
         else insert n1 (norm f ns)
  | norm f [] = []
in

(*
AC_flatten : Signature -> Term -> Term

AC_flatten does a flatten on AC terms and returns a (strictly) bogus
term with all AC subterms at the same level.  Care must be taken as
this term is meaningless in other circumstances, but is useful in this
file for giving AC equiavalence.

The AC-subterms are in the syntactic order defined by ord_t
*)

fun AC_flatten Sigma T = 
    if variable T 
    then T
    else let val f = root_operator T
         in if AC_Operator (get_operators Sigma) f
            then mk_OpTerm f 
            	(map (AC_flatten Sigma) (norm T (subterms T)))
            else mk_OpTerm f 
            	(map (AC_flatten Sigma) (subterms T))
         end

(* 
AC_subterms : Term -> Term list

Gives the immediate subterms of a term which have the same operator -
that is the terms of the level one AC flatten.

Assumes root operator is AC.
*)

fun AC_subterms T = norm T (subterms T) 

end (* of local *)

(*
AC_unflatten : OpId -> Term list -> Term

The pure unification algorithm returns a list of list of "terms and lists of terms", 
the innermost list representing the flattened AC-subterms of a unifiying
substitutions to the variable term on the lhs.  We must rebuild the terms at this stage.

We rebuild right associative - the is arbitrary - the operator is associative 
so it makes no difference semantically.
*)

fun AC_unflatten f [v] = v 
  | AC_unflatten f (v::rvs) = mk_OpTerm f [v, AC_unflatten f rvs]
  | AC_unflatten f [] = raise (Ill_Formed_Term "No AC Terms to Unflatten") 
		(* a reasonable exception to raise *)


(* 
AC_equivalent : Signature -> Term -> Term -> bool

Checks to see whether the two terms are C and AC equivalent.

Uses AC_equiv which assumes that the terms are already in AC_flattened
form.  This is likely to be a highly inefficient version to start with - 
eg  a). we calculate all permutations then check
    b). we recalculate the permuations on each descent into the subterms

Ultimately we should replace this with some sort of ordering on the 
subterms which should make the whole thing linear.  But this gets things
going.

*)
local
fun inserts a (b::l) = (a :: b :: l) :: map (cons b) (inserts a l)
  | inserts a [] = [[a]]
in
fun permutations [] = []
  | permutations [a] = [[a]]
  | permutations (a::l) = mapapp (inserts a) (permutations l)
end (* of local *)

(*

local

(*                           handle Zip => 
	(write_terminal ("Heres the Zip Error "^stringlist (show_term Sigma) (""," ","") t1s ^ " and " ^stringlist (show_term Sigma) (""," ","") t2s ^ "\n") ; raise Zip)
*)
(*
and AC_equiv t1 t2  =
    (case (variable t1 , variable t2) of
       (true,true) => VarEq (get_Variable t1) (get_Variable t2) 
    | (false,true) => false
    | (true,false) => false
    | (false,false) => 
    	if same_root t1 t2
    	   andalso 
    	   num_ops_in_term t1 = num_ops_in_term t2 (*could save a lot of work*)
    	then if constant t1
    	     then true
    	     else
    	     let val t1s = subterms t1
    	         val t2s = subterms t2
    	         val f = root_operator t1
    	     in if C_Op f
    	        then check_subterms t1s t2s
    	             orelse
    	             check_subterms t1s (rev t2s)
    	        else 
    	        if AC_Op f 
    	        then length t1s = length t2s  (* AC-flattening can result in unequal lists *)
    	             andalso let val ps = permutations t2s
    	                     in exists (check_subterms t1s) ps
    	                     end
    	        else 
    	        check_subterms t1s t2s
    	     end 
    	else false
    )

*) (* a new way of doing this without permutations - I hope that it works! *)


(*
(*
A version which assume the syntactic term ordering - trouble is this is not guarenteed!
*)
(*
and remove (t1 :: ts) t = 
    if AC_equiv t t1 
    then ts
    else if ord_t t1 t 
         then raise NotEq
         else t1::remove ts t 
  | remove [] t = raise NotEq
*)
and AC_equiv t1 t2  =
    (case (variable t1 , variable t2) of
       (true,true) => VarEq (get_Variable t1) (get_Variable t2) 
    | (false,true) => false
    | (true,false) => false
    |(false,false) => 
    	if same_root t1 t2
    	   andalso 
    	   num_ops_in_term t1 = num_ops_in_term t2 
    	   	(*could save a lot of work*)
    	then if constant t1
    	     then true
    	     else
    	     let val t1s = subterms t1
    	         val t2s = subterms t2
    	         val f = root_operator t1
    	    in if C_Op f
    	        then forall_pairs AC_equiv t1s t2s
    	             orelse
    	             forall_pairs AC_equiv  t1s (rev t2s)
    	        else 
    	        if AC_Op f 
    	        then (*length t1s = length t2s  (* AC-flattening can result in unequal lists *)
    	             andalso (null (foldl remove t2s t1s) handle NotEq => false)*)
    	             check_subterms t1s t2s handle Zip => false
    	        else 
    	        check_subterms t1s t2s
    	     end 
    	else false
    	end
    )

fun AC_equiv t1 t2 = TermEq t1 t2 handle Zip => false *)
in AC_equiv
end (* of let for fun AC_eq *)
*)
local
exception NotEq

fun AC_eq Sigma = 
let
val C_Op = C_Operator (get_operators Sigma)
val AC_Op = AC_Operator (get_operators Sigma)
fun check_subterms t1s t2s = forall_pairs AC_equiv t1s t2s
and remove (t1 :: ts) t = 
    if AC_equiv t t1 
    then ts
    else t1::remove ts t 
  | remove [] t = raise NotEq
and AC_equiv t1 t2  =
    (case (variable t1 , variable t2) of
       (true,true) => VarEq (get_Variable t1) (get_Variable t2) 
    | (false,true) => false
    | (true,false) => false
    |(false,false) => 
    	if same_root t1 t2
    	   andalso 
    	   num_ops_in_term t1 = num_ops_in_term t2 
    	   	(*could save a lot of work*)
    	then if constant t1
    	     then true
    	     else
    	     let val t1s = subterms t1
    	         val t2s = subterms t2
    	         val f = root_operator t1
    	    in if C_Op f
    	        then forall_pairs AC_equiv t1s t2s
    	             orelse
    	             forall_pairs AC_equiv  t1s (rev t2s)
    	        else 
    	        if AC_Op f 
    	        then length t1s = length t2s  (* AC-flattening can result in unequal lists *)
    	             andalso (null (foldl remove t2s t1s) handle NotEq => false)
    	        else 
    	        check_subterms t1s t2s
    	     end 
    	else false
    )
in AC_equiv
end (* of let for fun AC_eq *)
in

fun AC_equivalent Sigma T1 T2 = 
    let val t1 = AC_flatten Sigma T1
        val t2 = AC_flatten Sigma T2
    in AC_eq Sigma t1 t2
    end
end  (* of local *)

(*
fun AC_equivalent Sigma T1 T2 = 
    TermEq (AC_flatten Sigma T1) (AC_flatten Sigma T2)
    handle Zip => false
*)
(* 
AC_equivalent expects the terms to be exact AC/C variant of each other.  
we also need a function which gives equivalence up to variable renaming. 

AC_alpha_equivalent : Signature -> Term -> Term -> (Variable,Variable) Assoc.Assoc -> bool * (Variable,Variable) Assoc.Assoc

Gives equivalence of terms up to renaming of variables.  It takes a "renaming
of variables" environment as an argument, and also returns a modified 
environment as an argument.  
*)

local
  val lookup = Assoc.assoc_lookup VarEq
  val assoc = Assoc.assoc VarEq VarEq

(* ff replaces the exists function, propagating the environment *)

  fun ff e1 p (a::l) = 
      let val (b,e) = p a in if b then (b,e) else ff e1 p l end
    | ff e1 p [] = (false,e1)

(* gg replaces the forall_pairs function, propagating the environment *)

fun AC_aeq Sigma = 
let
  val C_Op = C_Operator (get_operators Sigma)
  val AC_Op = AC_Operator (get_operators Sigma)
  fun gg env (a::l1) (b::l2) =  
      let val (p,env') = AC_alphaequiv a b env
      in if p then gg env' l1 l2
    	 else (false,env)
      end 
    | gg E [] [] = (true,E)
    | gg E _ _ = (false,E)   
 and 
    AC_alphaequiv t1 t2 env = 
      ( case (variable t1,variable t2) of 
        (true,true) => 
                let val s = get_Variable t1
                    val t = get_Variable t2
                in    
      		(case lookup s env of
      		   NoMatch  =>  (true,assoc s t env)
      		 | Match gg =>  (VarEq gg t,env)
      		)
      		end 
      | (false, false) =>
    	if same_root t1 t2
    	   andalso 
    	   num_ops_in_term t1 = num_ops_in_term t2 
    	then if constant t1
    	     then (true,env)
    	     else
    	     let val t1s = subterms t1
    	         val t2s = subterms t2
    	         val f = root_operator t1
    	    in
             if C_Op f
    	     then let val (b,e) = gg env t1s t2s
    	          in if b then (b,e) else gg env t1s (rev t2s)
    	          end
    	     else 
    	     if AC_Op f
    	     then let val ps = permutations t2s
    	          in ff env (gg env t1s) ps
    	          end
    	     else gg env t1s t2s
    	     end
     	else (false,env)

      | _   => (false,env) 
      )
  in  AC_alphaequiv
  end (* of let for fun AC_aeq *)

 in (* of local *)

fun AC_alpha_equivalent Sigma T1 T2 env = 
    let val t1 = AC_flatten Sigma T1
        val t2 = AC_flatten Sigma T2
    in AC_aeq Sigma t1 t2 env
    end
  end (* of assoc local *)

(*

Provides the mutation procedure for Commuative unification, and an
algorithm for C-unification.

i.e. if + is a commutative operator, then it obeys the equation:

	x + y = y + x 

C-Unification is dependent on the non-deterministic rules for mutation:

  {  s1 + s2  == t1 + t2 } U E
 -------------------------------	Decompose 
  {  s1 == t1 , s2  == t2 } U E

  {  s1 + s2  == t1 + t2 } U E
 -------------------------------	C-Mutate
  {  s1 == t2 , s2  == t1 } U E

*)

fun Cmutate Sigma Cterm1 Cterm2 =
    let val (sis, tis) = (subterms Cterm1, subterms Cterm2)
        val (s1,s2) = (hd sis, hd(tl sis)) (* Guarenteed to have two subterms if well formed *)
        val (t1,t2) = (hd tis, hd(tl tis))
    in if AC_equivalent Sigma s1 s2 orelse AC_equivalent Sigma t1 t2 (* if two terms are the same, we will get identical unifiers *)
       then [[(s1,t1),(s2,t2)]]
       else [[(s1,t1),(s2,t2)],[(s1,t2),(s2,t1)]]
    end 

local 
fun equiv A (l,r) (g,d) = 
    let val (b,e) = AC_alpha_equivalent A l g Assoc.Empty_Assoc
    in b andalso fst (AC_alpha_equivalent A r d e) 
    end 
in
fun equivalentPairs A (l,r) (g,d) = 
    equiv A (g,d) (l,r) orelse equiv A (d,g) (l,r)
end

end (* of functor AC_ToolsFUN *)
;
