(*
 *
 * $Log: signature.sml,v $
 * Revision 1.2  1998/06/08 17:41:17  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*
signature.sml

A data structure for defining (algebra) signatures.

depends on:
	sort.sml
	variable.sml
	opsymb.sml

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     17/10/91
Glasgow University and Rutherford Appleton Laboratory.
*)


functor SignatureFUN (structure S : SORT 
                      structure O : OPSYMB
                      structure V : VARIABLE
                      sharing type S.Sort = O.Sort = V.Sort
                     ) : SIGNATURE =
struct

structure S = S
structure O = O
structure V = V

(*
An Signature consists of a triple:
	Sort_Store - data structure of Sort names and ordering (cf: sort.sml)
	Op_Store - data structure of Operator names and signatures (cf: opsymb.sml)  
	Variable_Store - data structure of Variable name *templates* and sorts for generating 
			variable names of the appropriate sort. (cf: variable.sml)

*)

abstype Signature  = SIG of S.Sort_Store * O.Op_Store * V.Variable_Store
with

val Empty_Signature = SIG (S.Empty_Sort_Store,
			   O.Empty_Op_Store,
			   V.Empty_Variable_Store)

(* constructor for Signatures *)

fun mk_signature ss fs vs = SIG (ss,fs,vs)

(* projection functions for components of Signatures *)

fun get_sorts (SIG (ss,fs,vs)) = ss
fun get_sort_ordering (SIG (ss,fs,vs)) = S.get_sort_order ss
fun get_operators (SIG (ss,fs,vs)) = fs
fun get_variables (SIG (ss,fs,vs)) = vs

(* functions for changing the components with new components.
   Typically used to alter existing component thus:
   	...
	val ss = get_sorts A
	val New_A = change_sorts A (f ss)
	...
*)

fun change_sorts (SIG (ss,fs,vs)) ss' = (SIG (ss',fs,vs))
fun change_operators (SIG (ss,fs,vs)) fs' = (SIG (ss,fs',vs)) 
fun change_variables (SIG (ss,fs,vs)) vs' = (SIG (ss,fs,vs'))

(* MONOTONICITY

The function monotonic will given an algebra structure check each signatures of a given
operator in a pairwise fashion to see if any pair break the monotonicity requirement, roughly:
|x| < |y| => |f(x)| < |f(y)|
more details and algorithm description in ~/LOTOS/src/doc/order_sorts. 

Returns those pairs of operator signatures which break the requirement, or Null value if mono holds.

monotonic : Algebra -> (OpId * (OpSig * OpSig) list) list

 *)

local  (* outer local *)

(* this strips out the NoMatch and the Match constructors in a list of lifted results *)
        fun clean f (a::l) = 
		(case f a of			(* apply function *)
	 	 NoMatch => clean f l		(* not wanted in list *)
		| Match b => b :: clean f l	(* wanted in list *)
		)
 	 | clean f [] = []

(* a non-reflexive, non-symmetric make pairs function *)

fun makepairs (a::l) = map (pair a) l @ makepairs l
  | makepairs [] = [] ;

in (* in of outer local *)

local (* local for monotonic *)

fun pairwise_mono so (OpSig1,OpSig2) = 
    let val (ss1,s1) = O.get_type OpSig1
        val (ss2,s2) = O.get_type OpSig2
    in  if      forall_pairs so ss1 ss2 andalso not (so s1 s2) 
        then    Match (O.mk_OpSig (ss1,s1),O.mk_OpSig (ss2,s2))
        else if forall_pairs so ss2 ss1 andalso not (so s2 s1) 
        then    Match (O.mk_OpSig (ss2,s2),O.mk_OpSig (ss1,s1))
        else    NoMatch
    end

fun mono_sig so (symb,sigs) = 
    (case clean (pairwise_mono so) (makepairs (O.get_OpSigs sigs)) of
        [] => NoMatch |
        ss  => Match (symb,ss) )
    
in
fun monotonic (SIG (ss,fs,vs)) = 
    let val so = curry (S.sort_ordered_reflexive (S.get_sort_order ss))
        val symbsigs = map (apply_pair 
        ((fn OK s=> s |
           Error_=> failwith "Catastrophic Error in the Symbol database") 
                    o O.find_operator fs,I)) (O.all_forms fs)
    in clean (mono_sig so) symbsigs
    end 
end  (* of local for monotonic *)

(*

This gives the basic functions for proving that an operators signature
is regular.

BMM  19-10-90

The definition of regularity follows Goguen & Meseguer "Order-Sorted Algebra I:
Equational Deduction for Multiple Inheritence Overloading, Exceptions and Partial 
Operations"  Oxford University, Tech Monograph no. PRG-80 Dec 1989.

This is given as:

An Order-Sorted signature SIGMA is Regular iff given an operator f with rank w1 -> s1
and given some w0 =< w1 (in the ordering on sorts extended to lists) then the set
{ w | f: w -> s and w0 =< w } has a unique least element. 

This is not quite strong enough as SIGMA is assumed to be monotonic.  We extend to non-monotonic
by changing the set to { s | f: w -> s and w0 =< w }. that if there is another rank w' -> s' such that w0 =< w', then s =< s'.

Goguen and Meseguer then state that in the case of (in particular) finite signatures, 
it suffices to check the following: 

A finite Order-Sorted signature SIGMA is Regular iff f has ranks w1 -> s1 and w2 -> s2 and 
if there is some w0 such that w0 =< w1 and also w0 =< w2 then there is some w =< w1, w2 such 
that f has rank w -> s and w0 =< w. 

Again we extend to non-monotonic by adding that if there is another rank w' -> s' such that 
w0 =< w' =< w1, w2,  then s =< s'.


We implement an algorithm from this last definition.  
It is very naive and does far too much computation, 
but does the job.

It goes as follows.

Given a operator f with a set of signatures OpSigSet.
   for every pair of signatures (w1,s1), (w2,s2) in OpSigSet
   
   1). check whether w1 =< w2 orelse w2 =< w1 then we have trivially regular
       if s1 =< s2 or s2 =< s1 respectively. 
   
   2). find all subsorts of w1 and w2
   
   3). i).  find all the sequences that can be made of the subsorts of w1 
       ii).  find all the sequences that can be made of the subsorts of w2.
       iii).  find the intersection set W of 3i) and 3ii).
       
       All sequences w in W have the property that w =< w1, w2.

   4).  For each w in W find the set Minimal{ s | f : w' -> s in OpSigSet and w =< w' }
        (This checks for non-monotonic signatures as well.)
   
   5).  If for some w in W the set in step 4. proves to be either a singleton, 
        or empty (this latter should not happen as w =< w1, w2) then the 
	pair does not break regularity.  Otherwise they do.


Could be made more efficient by 'memoising' the constant build up of the subsorts, 
and sequences of sorts.

*)

local (* local for regular *)

(* 
we use a memoised version of subsorts as we are likely to be constantly looking up
the subsorts of the same sort in calculating the sequences of subsorts.
Thus the reference to a Association list.
*)

val SubSorts_Ref = ref Assoc.Empty_Assoc : (S.Sort , S.Sort list) Assoc.Assoc ref 

fun clear_subsorts () = (SubSorts_Ref := Assoc.Empty_Assoc)

fun all_subsorts so s = 
    (case Assoc.assoc_lookup S.SortEq s (!SubSorts_Ref) of
      Match sl => sl 
    | NoMatch  => let val sl = s::S.subsorts so s  (* subsorts returns the strict subsorts only *)
                  in (SubSorts_Ref := Assoc.assoc_nocheck s sl (!SubSorts_Ref) ; sl)
                  end)

(* find the minimal greater signatures *)

fun find_min_greater_sigs (so : S.Sort_Order)
		      (opsiglist:(S.Sort list * S.Sort) list)
		      (sort_list:S.Sort list) : S.Sort list = 
    let fun greater_sig result_sorts (ss,s) = 
    		if S.sort_ordered_list so sort_list ss 
    		then s::result_sorts 
    		else result_sorts
    in S.minimal_sorts so (foldl greater_sig [] opsiglist)
    end 
		     
fun eq_sort_lists l1 l2 = forall_pairs S.SortEq l1 l2

fun pairwise_regular so Sigs (OpSig1,OpSig2) = 
    let val (ss1,s1) = O.get_type OpSig1	(* the two ranks we are playing with *)
        val (ss2,s2) = O.get_type OpSig2
    in  if S.sort_ordered_list so ss1 ss2
           orelse 	(* if one arg_sort is less than the other then we are have a simpler check. *)
           S.sort_ordered_list so ss2 ss1
        then  		(* if not assuming monotonic, the only cause of problems is non-comparability *)
             if S.sort_ordered_reflexive so (s1,s2) orelse 
                S.sort_ordered_reflexive so (s2,s1)
             then NoMatch   		(* NoMatch signals that the pair is pairwise Regular *)
             else Match (O.mk_OpSig (ss1,s1),O.mk_OpSig (ss2,s2))  (* this is a non-regular pair *)
        else let val Ws1 = map (all_subsorts so) ss1	(* find all the subsorts declared for the arities *)
 		 val Ws2 = map (all_subsorts so) ss2
 		 val sort_seqs1 = all_seqs Ws1		(* make all possible sequences of the arities *)
 		 val sort_seqs2 = all_seqs Ws2
 		 val Ws = intersection eq_sort_lists sort_seqs1 sort_seqs2 (* find all the common sequences *)
 	         val results = map (find_min_greater_sigs so Sigs) Ws
 	     in if forall (ou is_singleton null) results  (* check for unique *)
 	        then NoMatch 				(* NoMatch signals that the pair is pairwise Regular *)
 	        else Match (O.mk_OpSig (ss1,s1),O.mk_OpSig (ss2,s2))  (* this is a non-regular pair *)
 	     end 
    end
	    
fun regular_sig so (symb,sigs) = 
    let val Sigs = (map O.get_type sigs)
    in 
    if (null o fst o hd) Sigs  (* ie a constant *)
    then if is_singleton (S.minimal_sorts so (map snd Sigs))
         then NoMatch
         else Match (symb,makepairs sigs)
    else
    (case clean (pairwise_regular so Sigs) (makepairs sigs) of
        [] => NoMatch |
        ss  => Match (symb,ss) )
    end 
    
in
fun regular (SIG (ss,fs,vs)) = 
    let val so = (clear_subsorts ();  (* clear the old subsort table *)
                  S.get_sort_order ss)
        val symbsigs = map (apply_pair 
        ((fn OK s => s |
           Error_ => failwith "Catastrophic Error in the Symbol database") 
           o O.find_operator fs,I)) (O.all_forms fs)
    in clean (regular_sig so) (map (fn (symb,sigs) => (symb,O.get_OpSigs sigs)) symbsigs)
    end 
end  (* of local for regular *)

end  (* of outer local *)

(*

INHABITEDNESS

The inhabited test whether sorts have ground terms within them.  

Given S = {sorts, sigs, < } where < is sort ordering, we test for 
inhabitedness thus: (+ is set union, 'in' set membership )

let U, I := sorts, {}
U = unihabited sorts, I = inhabited sorts.  

1.  forall f : -> si in sigs then U := U - {si}, I := I + {si}
2.  if f : s1 ,..., sn -> s in sigs and 
       forall i. si in I 
    then U := U - {s}, I := I + {s}
3.  if s1 < s2 and s1 in I then U := U - {s2}, I := I + {s2}
4.  repeat steps 1 - 3 until no change in U,I.  Then finish

*)
local
val is_sort = element S.SortEq
val ins_sort = insert S.SortEq
val rem_sort = remove S.SortEq
in
fun inhabited (SIG (ss,fs,vs)) =
    let val sigs = flatten (map (O.get_OpSigs o snd) (O.all_forms fs))
        val supers = S.supersorts (S.get_sort_order ss)
        
        fun check_sigs (U,I) (opsig::ls) new ss =
            let val (args,s) = O.get_type opsig
            in  if is_sort I s 
                then check_sigs (U,I) ls new ss
        	else if forall (is_sort I) args 
        	     then let val ss' = s::filter (non (is_sort I)) (supers s)
        	          in check_sigs (foldl rem_sort U ss',
        		     		 foldl ins_sort I ss') ls (ss'@new) ss
        	          end
        	     else check_sigs (U,I) ls new (opsig::ss)
            end 
          | check_sigs (U,I) [] new ss = 
         		if null new then (U,I) else check_sigs (U,I) ss [] []

    in check_sigs (S.fold_over_sorts (C cons) [] ss,[]) sigs [] []
    end
end (* of local *)

end (* of abstype Signature *) 

end (* of functor SignatureFUN *)
;
