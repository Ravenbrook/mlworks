(*
 *
 * $Log: unif.sml,v $
 * Revision 1.2  1998/08/05 17:22:37  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "ut1";
require "utils.sml";
require "universe.sml";
require "term.sml";
require "pretty.sml";
require "pattern.sml";
require "type.sml";
require "toc.sml";
(* unif.ml *)

(* WARNING: In the future, if bindings can ever mention ex-vars then
 * many things in this file need to be re-thought.
 *)


type assignment = int * cnstr
type substitution = assignment list;

structure Unif : sig
		    val pure : cnstr -> bool
		    val semi_pure : cnstr -> bool
		    val sub : (int * cnstr) list -> cnstr -> cnstr
		    val sub_pr : (int * cnstr) list -> cnstr * cnstr -> cnstr * cnstr
		    val compose : (('a * 'b) list -> 'c -> 'b) -> ('a * 'b) list -> ('a * 'c) list -> ('a * 'b) list
		    exception Unif
		    val unif_debug : bool ref
		    val extnd_unif : bool -> (int * cnstr) list -> cnstr -> cnstr -> (int * cnstr) list
		    val convert_unif : (int * cnstr) list -> cnstr -> cnstr -> bool * (int * cnstr) list
		    val type_match_unif : (int * cnstr) list -> cnstr -> cnstr -> bool * (int * cnstr) list
		    val convert : cnstr -> cnstr -> bool
		  end =
struct

(** existential variables: utilities, substitutions **)

(* pure c is true if c has no ex-variables *)
(* semi_pure c is true if c has no ex-vars unresolved from 
 * argument synthesis *)
(* mv_occur n c is true if Var(n,_) occurs in c *)
local 
  fun occ f = 
    let val rec occ_rec =
      fn (Var(m,_)) => f m
       | (App((c,cs),vs)) => (occ_rec c) andalso (for_all occ_rec cs)
       | (Bind(_,_,c,d))  => (occ_rec c) andalso (occ_rec d)
       | (Tuple(T,ls))    => (occ_rec T) andalso (for_all occ_rec ls)  
       | (Proj(_,c))      => occ_rec c
       | _                => true
    in occ_rec end
in 
  val pure = occ (fn m => false)
  val semi_pure = occ (fn m => m >= 0)
  fun mv_occur n c = neg (occ (fn m => n<>m)) c
end;


(** ex-variable substitution **)

(* Apply a substitution to a construction *)
(* NOTE: A cnstr bound to a ex-var can have NO free
 * object-language variables.  This is enforced by reunion *)
fun sub [] = I
  | sub s  =  
    let fun sub_rec (Var(u,c))  =  ((assoc u s) handle _ =>  Var(u,sub_rec c))
          | sub_rec (App(b))    =  mkApp sub_rec b
          | sub_rec (Bind(b))   =  mkBind2 sub_rec b
          | sub_rec (Tuple(b))  =  mkTuple sub_rec b
          | sub_rec (Proj(b))   =  mkProj sub_rec b
(*
          | sub_rec _           =  raise Share
*)
	  | sub_rec x = x
    in share sub_rec end
fun sub_pr sbst (V,T) =
  let val sub_fun = sub sbst in (sub_fun V,sub_fun T) end;


(* compose two substitutions *)
(*** Warning: depends on 'sub' searching from head to tail
 *** because composite may have multiple bindings for a variable *)
fun compose sub t s = (map (fn (n,c) => (n,sub t c)) s) @ t;


(** unification **)

exception Unif;
val unif_debug = ref false

(* reunion can't allow free object variables in a substitution, but some
 * free ovars may be defined in the local delta context.  This function
 * attempts to expand any such free ovars *)
fun exp_free_ovar cxt s = 
  let fun efor p =
    fn (arg as Rel(n)) => if p < n
		   then let
			  val v = nth cxt (n-p)
			in
			  if v = Bot
			    then (if !unif_debug
				    then message
				      "** unif_debug- Unif:free o-var **"
				  else ();
				  raise Unif)
			  else efor p (sub s (lift n v))
			end
		 else (*raise Share*) arg
     | App(bod)  => mkApp (efor p) bod
     | Bind(b)   => mkBind efor p b
     | Tuple(b)  => mkTuple (efor p) b
     | Proj(b)   => mkProj (efor p) b
(*
     | _         => raise Share
*)
     | x => x
  in share (efor 0) end;


    fun reunion p P M cxt s =
    let val M = exp_free_ovar cxt s M
    in  if mv_occur p M
	  then (if !unif_debug
		  then message"** unif_debug- Unif:occurs check **"
		else ();
		raise Unif)                 (* occurs check *)
        else let val tM = type_of_constr M
                 val s = unirec (!LuosMode) cxt s tM P
	     in compose sub [(p,sub s M)] s
	     end
    end
and unirec LMflg cxt s M N =
 let
   val (MN as (M,N)) = (sub s M,sub s N)
   val _ = if !unif_debug
	     then (message"** unif_debug **";print_expand M;print_expand N)
	   else ()
 in  case MN of
    (Var(m,tm),Var(n,tn))
                     => if m=n then s
                        else if m>n then reunion m tm N cxt s
			     else reunion n tn M cxt s
  | (Var(m,tm),_)    => reunion m tm N cxt s
  | (_,Var(n,tn))    => reunion n tn M cxt s
  | (_,AbsKind)      => abs_kind M s
  | (AbsKind,_)      => abs_kind N s
  | (Type(i),Type(j))=> if (if LMflg then univ_leq i j else univ_equal i j)
			  then s
			else (if !unif_debug
				then message"** unif_debug- Unif:Types **"
			      else ();
				raise Unif)
  | (Prop,Type(j))   => if LMflg then s
			else (if !unif_debug
				then message"** unif_debug- Unif:Prop/Type **"
			      else ();
				raise Unif)
  | (Prop,Prop)      => s
  | (Rel(n),Rel(m))  => if n=m then s else try_approx LMflg cxt s MN
  | (Ref b1,Ref b2) =>
       if ref_isDecl b1 andalso ref_isDecl b2
	 then if sameRef b1 b2 then s
	      else (if !unif_debug
		      then message
			("** unif_debug- Unif:Refs ** ("^
			 (int_to_string(ref_ts b1))^","^(ref_nam b1)^") ("^
			  (int_to_string(ref_ts b2))^","^(ref_nam b1)^")")
		    else ();
		    raise Unif)
       else if (not(!MacroMode) andalso sameRef b1 b2)
	      then s 
	    else try_approx LMflg cxt s MN
  | (Bind((Let,_),_,v1,b1),Bind((Let,_),_,v2,b2))
                     => let val s = unirec false cxt s v1 v2
                        in  unirec false ((sub s v1)::cxt) s b1 b2 end
  | (App(A as ((f1,cs1),vs1)),App(B as ((f2,cs2),vs2)))
              => (* uniApp cxt s f1 cs1 vs2 f2 cs2 vs2 *)
                (let val l1 =length cs1 and l2 = length cs2
                     val an = !UVARS
                 in  (let val (f1,f2,cs1,cs2) =
                           if l1 = l2
                           then (f1,f2,cs1,cs2)
                           else if l1 < l2 
                                then let val (pre,post) = chop_list (l2-l1) cs2
                                     and (prev,postv) = chop_list (l2-l1) vs2
                                     in  (f1,App((f2,pre),prev),cs1,post) end
                                else let val (pre,post) = chop_list (l1-l2) cs1
                                     and (prev,postv) = chop_list (l1-l2) vs1
                                     in  (App((f1,pre),prev),f2,post,cs2) end
                         in uniargs cxt (unirec false cxt s f1 f2) cs1 cs2 end)
                                         (* in case of beta *)
                     handle Unif => (UVARS:= an; try_approx LMflg cxt s MN)
                 end ) 
  | (Bind((Pi,vs1),_,M1,M2),Bind((Pi,vs2),_,N1,N2))
            => if true   (******* vs1=vs2 *******)
		 then unirec LMflg (Bot::cxt) (unirec false cxt s M1 N1) M2 N2
	       else try_approx LMflg cxt s MN
  | (Bind((Lda,vs1),_,M1,M2),Bind((Lda,vs2),_,N1,N2))
            => (if true   (******* vs1=vs2 *******)
		  then let val an = !UVARS
		       in (unirec false (Bot::cxt)
                                        (unirec false cxt s M1 N1) M2 N2)
			        (* in case of eta *)
			 handle Unif =>
			   (UVARS:= an; try_approx LMflg cxt s MN) 
		       end
		else try_approx LMflg cxt s MN)
  | (Bind((Sig,_),_,M1,M2),Bind((Sig,_),_,N1,N2))
     => unirec LMflg (Bot::cxt) (unirec LMflg cxt s M1 N1) M2 N2
  | (Tuple(T1,ls1),Tuple(T2,ls2))
     => uniargs cxt (unirec false cxt s T1 T2) ls1 ls2
  | (Proj(p1,c1),Proj(p2,c2))
                     => (if p1<>p2 then try_approx LMflg cxt s MN
                         else let val an = !UVARS
                         in  (unirec false cxt s c1 c2)
                                         (* in case projection *)
                             handle Unif => 
                               (UVARS:= an; try_approx LMflg cxt s MN) end)
  | _                => try_approx LMflg cxt s MN
  end
and uniargs cxt s args1 args2 = 
    let fun uabod s (m,n) = unirec false cxt s m n 
     in foldl uabod s ((zip (args1,args2)) handle _ =>  raise Unif) end
and abs_kind c s = case (theory(),hnf c) of
    (lf,Prop)    => s
  | (lf,_)       => raise Unif
  | (_,Prop)     => s
  | (_,Type(_))  => s
  | _            => raise Unif
and try_approx LMflg cxt s (M,N) =
    let
      val _ = if !unif_debug
		then message"** unif_debug: try_approx **"
	      else ()
      val (c,d) = (try_reduce cxt (sub s) M N)
	handle Step1 => (if !unif_debug
			   then message
			     "** unif_debug- Unif:try_approx backtrack **"
			 else ();
			   raise Unif)
      val _ = if !unif_debug
		then message"** unif_debug: try_approx **"
	      else ()
    in
      unirec LMflg cxt s (hbenf c) (hbenf d)
    end;


fun extnd_unif LMflg old_s M N = 
  let val an = !UVARS   (*** !! side efects !! ***)
  in
    unirec LMflg [] old_s M N handle Unif => (UVARS:= an; failwith"unif")
  end;

local
  fun shell x y = (true,x y) handle Failure "unif" => (false,[])
in
  fun convert_unif s c d = shell (extnd_unif false s c) d
  fun type_match_unif s c d = shell (extnd_unif (!LuosMode) s c) d
end

fun convert c d = case convert_unif [] c d of
      (true,[]) => true
    | (false,_) => false
    | _         => bug"convert returns sbst"
(*
fun type_match c d = case type_match_unif [] c d of
      (true,[]) => true
    | (false,_) => false
    | _         => bug"type_match returns sbst";
*)

end;

open Unif;
