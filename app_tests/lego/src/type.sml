(*
 *
 * $Log: type.sml,v $
 * Revision 1.2  1998/08/05 17:19:39  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "utils.sml";
require "universe.sml";
require "term.sml";
require "pretty.sml";
require "pattern.sml";
(* type.ml *)

(** Reduction, Conversion and Normalization **)

(* Redices *)
fun delta_1 br = if ref_isDefnNow br then ref_val br else raise Share
fun special_1 nf tm d = let
			  val (b,e) = specialReduce nf tm d
			in
			  if b then e else raise Share
			end
fun beta_1 f bod cs vs = MkApp((subst1_lazy f (hd cs) (f bod),tl cs),(tl vs))
fun let_1 f (v,b) = subst1_lazy f v b


exception Step1
val tm_debug = ref false

(* weak-head-beta-eta-normal form: all beta-eta steps are done here *)
(* NOTE: this is NOT a top-level function; it will raise Share, but
 *       isn't protected by share *)
fun proj_1 (p:projSort) (T,ls) : cnstr =
  case (p,hnf T,ls)
    of (Fst,Bind((Sig,_),_,_,_),l::_)  => l
     | (Snd,Bind((Sig,_),_,_,S),l::r)  => 
	  (case hnf(subst1 l S)
	     of (S as Bind((Sig,_),_,_,_)) => MkTuple(S,r)
	      | _ => case r
		       of [s] => s
			| _   => bug"proj_1a")
     (* careful: the list may not be fully evaluated *)
     | (Psn p,_,_) =>
	  failwith"general projection not implemented yet"
     | _ => bug"proj_1"
(*****************************************************)
and whbenf nf nf2 =
  fn App((c,cs),vs) => 
    (case nf c
       of lda as Bind((Lda,_),_,_,bod) => nf (beta_1 nf2 bod cs vs)
	| c  => let
		  val d = MkApp((c,cs),vs)
                  val (b,e) = specialReduce nf type_match d
		in
		  if b then (nf e) else d
		end)
   | d as (Ref _) => special_1 nf type_match d
   | Bind((Let,_),_,bod1,bod2) => nf (let_1 nf2 (bod1,bod2))
   | Bind((Lda,_),_,_,r) => if neg eta () then raise Share
			    else (case nf r of
             App((c,cs),vs) => if var_occur c then raise Share
                               else let val (la,fas) = sep_last cs
                                    in if ((hnf la)=(Rel 1)) andalso
                                          (neg (exists var_occur) fas)
                                       then lift (~1)
                                          (MkApp((nf c,fas),(except_last vs)))
                                       else raise Share end
           | _              => raise Share )
   | Proj(p,c) =>
       (case nf c
	  of Tuple(bod) => nf (proj_1 p bod)
	   | c          => MkProj(p,c))
   | _         => raise Share

and type_match c d = 
     let
       val an = !UVARS
       fun tm LMflg (M,N) =
	 let
	   val _ = if !tm_debug
		     then (message"** tm_debug **";legoprint M;legoprint N)
		   else ()
           val TM =
	     fn (Type i,Type j) => if LMflg then univ_leq i j else univ_equal i j
	      | (Prop,Type j) => LMflg
	      | (Prop,Prop) => true
	      | (Rel n,Rel m) => n=m
	      | (Ref(b1),Ref(b2)) => sameRef b1 b2
	      | (App((f1,cs1),_),App((f2,cs2),_)) =>
		  (tm LMflg (f1,f2)) andalso (for_all (tm LMflg) (zip (cs1,cs2))
					      handle Zip => false)
	      | (Bind((Pi,vs1),_,M1,M2),Bind((Pi,vs2),_,N1,N2)) =>
		  (*********** (vs1=vs2) andalso **************)
		  (tm false (M1,N1)) andalso (tm LMflg (M2,N2))
	      | (Bind((Sig,_),_,M1,M2),Bind((Sig,_),_,N1,N2)) =>
		  (tm LMflg (M1,N1)) andalso (tm LMflg (M2,N2))
	      | (Proj(p1,c1),Proj(p2,c2)) =>
		  (p1=p2) andalso (tm false (c1,c2)) (**?????????????**)
	      | (Bind((Lda,vs1),_,M1,M2),Bind((Lda,vs2),_,N1,N2)) => (**????????**)
		  (*************(vs1=vs2) andalso ***************)
		  (tm false (M1,N1)) andalso (tm false (M2,N2))
	      | (Tuple(T1,ls1),Tuple(T2,ls2)) => 
		  (for_all (tm false) (zip(ls1,ls2)) (**????????**)
		   handle Zip => false)
	      | (Var(n,c),Var(m,d)) => n=m andalso tm LMflg (c,d)
	      | (_,_) => false
	 in
	   case (M,N)
	     of (App((Ref b1,cs1),_),App((Ref b2,cs2),_)) =>
	          (if sameRef b1 b2 andalso (for_all (tm LMflg) (zip (cs1,cs2))
					     handle Zip => false)
		  then true
	        else TM (hnf M,hnf N))
	      | _ => TM (hnf M,hnf N)
	 end
     in
       if tm (!LuosMode) (c,d) then true
       else (UVARS:= an; false)
     end


(* do 1 step of normal order reduction or raise exception  *)
(* NOTE that eta reduction cannot be lazy in this way: while the
 * leftmost-outermost beta redex can a easily be found without
 * reduction, finding an eta redex may require some beta steps. *)
and step1 (cxt:cnstr list) sub =
  fn rb as (Ref br) => (delta_1 br
			handle Share => (special_1 hnf type_match rb
					 handle Share => raise Step1))
   | Rel(n)              => let val v = lift n (sub (nth cxt n))
			    in  if v = Bot then raise Step1 else v end
   | Bind((Let,_),_,bod1,bod2) => let_1 I (bod1,bod2)
   | Bind((Lda,_),_,_,r)
     => if neg eta() then raise Step1
	else (case hnf r of
		App((c,cs),vs)
		=> if var_occur c then raise Step1
		   else let val (la,fas) = sep_last cs
			in if ((hnf la)=(Rel 1) andalso
			       (neg (exists var_occur) fas))
			     then lift (~1) (MkApp((c,fas),(except_last vs)))
			   else raise Step1 end
	      | _              => raise Step1 )
   | (app as (App((c,cs),vs))) =>
       (case c
	  of lda as Bind((Lda,_),_,_,bod) => beta_1 I bod cs vs
	   | c  => (special_1 hnf type_match app
		    handle Share => MkApp((step1 cxt sub c,cs),vs)))
   | Proj(p,c) =>
       (case c
	  of Tuple(bod) =>  proj_1 p bod
	   | c => MkProj(p,step1 cxt sub c))
| _  => raise Step1
(* a heuristic decides which reduction to do next *)
and try_reduce cxt sub c d =
  (step1 cxt sub c,d) handle Step1 => (c,step1 cxt sub d)

(* a toplevel version of whbenf *)
and hbenf c = share (whbenf hbenf I) c
(* weak-head-normal form *)
and hnf c =
  let
    fun hnfrec (rx as (Ref x)) =
            hnf (delta_1 x handle Share => (special_1 hnf type_match rx))
      | hnfrec x         = whbenf hnf I x
  in share hnfrec c
  end;

(******************************************************
local  (* a somewhat applicative normal form *)
  fun fnf c =
    let fun fnfrec (Ref x)    = normal (delta_1 x)
	  | fnfrec x          = whbenf normal normal x
    in share fnfrec c
    end
in
  fun normal c = 
    let fun nfrec c = (share nf1 (fnf c) handle Share => nf1 c)
	and nf1 (App(b))    = mkApp nfrec b
	  | nf1 (Bind(b))   = mkBind2 nfrec b
	  | nf1 (Tuple(b))  = mkTuple nfrec b
	  | nf1 (Proj(b))   = mkProj nfrec b
	  | nf1 _           = raise Share
    in share nfrec c
    end
end
*******************************************************)
(* FAST-head-normal form (not really head-normal) *)
fun fhnf c = 
    let
      fun fhnfrec (rx as (Ref x)) =
	      fhnf (delta_1 x handle Share => (special_1 hnf type_match rx))
	| fhnfrec x          = whbenf fhnf normal x
     in share fhnfrec c end
(* normal form; all actual reductions are handled by the call to fhnf *)
and normal c = 
    let fun nfrec c = ((let val x = fhnf c in share nf1 x end)
                       handle Share => nf1 c)
        and nf1 (App(b))    = mkApp nfrec b
          | nf1 (Bind(b))   = mkBind2 nfrec b
          | nf1 (Tuple(b))  = mkTuple nfrec b
          | nf1 (Proj(b))   = mkProj nfrec b
          | nf1 _           = raise Share
     in share nfrec c end


(* display-normal form: do no delta steps, but all
 * beta-eta-projection steps *)
fun dnf c =
(*************************************************
  let var rec dnfrec =
    fn App(b as ((c,cs),vs))
       => (case c
	     of Bind((Lda,_),_,_,bod) => dnf (beta_1 I (dnf bod) cs vs)
	      | _ => mkApp dnfrec b)
     | Bind(b) => mkBind2 dnfrec b
     | Tuple(b) => mkTuple dnfrec b
     | Proj(b) => mkProj dnfrec b
     | _ => raise Share
  in share dnfrec c
  end
*******************************************)
    let fun dnfrec c = ((let val x = whbenf dnf dnf c in share dnf1 x end)
                        handle Share => dnf1 c)
	and dnf1 (App(b))    = mkApp dnfrec b
	  | dnf1 (Bind(b))   = mkBind2 dnfrec b
	  | dnf1 (Tuple(b))  = mkTuple dnfrec b
	  | dnf1 (Proj(b))   = mkProj dnfrec b
	  | dnf1 _           = raise Share
    in share dnfrec c
    end


(* constant expansion *)
fun expand nam = 
    let fun exp_rec (Ref(br)) = 
              if nam = (ref_nam br) then delta_1 br else raise Share
          | exp_rec (App(b))  = mkApp exp_rec b
          | exp_rec (Bind(b)) = mkBind2 exp_rec b
          | exp_rec (Tuple(b)) = mkTuple exp_rec b
          | exp_rec (Proj(b)) = mkProj exp_rec b
          | exp_rec _         = raise Share
     in share exp_rec end


fun expAll n = 
    let fun eArec n = if n <= 0 then I else
      fn Ref(br)   => eArec (n-1) (delta_1 br)
       | App(b)    => mkApp (eArec n) b
       | Bind(b)   => mkBind2 (eArec n) b
       | Tuple(b)  => mkTuple (eArec n) b
       | Proj(b)   => mkProj (eArec n) b
       | _         => raise Share
    in share (eArec n) end;
