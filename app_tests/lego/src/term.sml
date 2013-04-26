(*
 *
 * $Log: term.sml,v $
 * Revision 1.2  1998/08/05 17:16:03  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "utils";
require "universe";

(* term.sml *)

datatype visSort = Vis | Hid | Def | VBot
datatype bindSort = Lda | Pi | Sig | Let
type  bindVisSort = bindSort * visSort
datatype projSort = Fst | Snd | Psn of int
datatype prntVisSort = ShowNorm | ShowForce | NoShow
datatype LocGlob = Local | Global
datatype Kind = Red | Bnd | Mrk of string

fun prVis Vis = ShowNorm 
  | prVis Hid = NoShow 
  | prVis Def = bug"prVis: Def"
  | prVis VBot = bug"prVis: VBot"


(** Abstract syntax **)
datatype  cnstr =
    Prop
  | Type of node
  | Ref of binding
  | Rel of int                                         (* variable *)
  | App of (cnstr * (cnstr list)) * (prntVisSort list) (* application *)
  | Bind of binder_data
  | Var of int * cnstr                      (* existential variable *)
  | AbsKind                                 (* any abstractable kind *)
  | Tuple of cnstr * (cnstr list)           (* elem of Sig *)
  | Proj of projSort * cnstr
  | Bot
and binding =
    Bd of {kind:Kind, ts:int, 
	   frz:bool ref, param:LocGlob, deps:binding list,
	   bd:binder_data}
withtype binder_data = bindVisSort * string * cnstr * cnstr

fun ref_body (Bd b) = b
fun ref_ts br = #ts (ref_body br)
fun ref_frz br = #frz (ref_body br)
fun ref_param br = #param (ref_body br)
fun ref_deps br = #deps (ref_body br)
fun ref_kind br = #kind (ref_body br)
fun ref_isRed br = ref_kind br = Red
fun ref_isBnd br = ref_kind br = Bnd
fun ref_isMrk br = case ref_kind br of Mrk _ => true | _ => false
fun ref_bd br = #bd (ref_body br)
fun ref_bind br = fst (#1 (ref_bd br))
fun ref_vis br = snd (#1 (ref_bd br))
fun ref_nam br = #2 (ref_bd br)
fun ref_mrk br = case ref_kind br of Mrk s => s | _ => ""
fun ref_vt br = let val (_,_,v,t) = ref_bd br in (v,t) end
fun ref_isDefn br = ref_isBnd br andalso (ref_bind br) = Let
fun ref_isDefnNow br = ref_isDefn br andalso not (!(ref_frz br))
fun ref_isDecl br = ref_isBnd br andalso not (ref_isDefn br)
fun ref_val br = if ref_isDefnNow br then #3 (ref_bd br)
		 else Ref br
(******
fun ref_val br = if ref_isDefn br then #3 (ref_bd br) else bug"ref_val"
******)
fun ref_typ br = (if ref_isDefn br then #4 else #3) (ref_bd br)
fun sameRef br br' = ref_ts br = ref_ts br'
fun sameNam(br, nam) = ref_nam br = nam
fun sameMrk br mrk = ref_mrk br = mrk
fun ref_updat_vt (Bd{ts,frz,param,deps,kind,bd=(bv,nam,_,_)}) (v,t) =
      Bd{ts=ts,frz=frz,param=param,deps=deps,kind=kind,bd=(bv,nam,v,t)}


(* A Type construction function allows sharing storage *)
fun mkTyp nod = 
    let val (Type0,Type1,Type2) =
      (Type(uconst 0),Type(uconst 1),Type(uconst 2))
    in  case nod
	  of Uconst(0) => Type0
	   | Uconst(1) => Type1
	   | Uconst(2) => Type2
	   | _         => Type(nod)
    end



(* var_occur tests whether object variable Rel(1) occurs
 * free_occur tests for any free obj var occurrance *)
local
  fun occ f =  
    let fun occur_rec p =
      fn Rel(p')        => f(p,p')
       | App((c,cs),_)  => (occur_rec p c) orelse (exists (occur_rec p) cs)
       | Bind(_,_,c,d)  => (occur_rec (succ p) d) orelse (occur_rec p c)
       | Tuple(T,l)     => (occur_rec p T) orelse (exists (occur_rec p) l)
       | Proj(_,c)      => occur_rec p c
       | _              => false
    in occur_rec
    end
in
  val var_occur = occ (op =) 1
  val free_occur = occ (op <) 0
end


(* test (shallow) dependency of a term on a reference *)
fun depends bref = 
    let fun deprec (Ref(br))       = sameRef br bref
          | deprec (App((c,cs),_)) = (deprec c) orelse (exists deprec cs)
          | deprec (Bind(_,_,c,d)) = (deprec d) orelse (deprec c)
          | deprec (Tuple(T,l))    = (deprec T) orelse (exists deprec l) 
          | deprec (Proj(_,c))     = deprec c
          | deprec (Var(_,c))      = deprec c
          | deprec _               = false
     in deprec end
(* similar but DIFFERENT: does a term mention a name *)
fun mentions nam = 
    let fun mtnrec (Ref(br))       = ref_nam br = nam
          | mtnrec (App((c,cs),_)) = (mtnrec c) orelse (exists mtnrec cs)
          | mtnrec (Bind(_,_,c,d)) = (mtnrec d) orelse (mtnrec c)
          | mtnrec (Tuple(T,l))    = (mtnrec T) orelse (exists mtnrec l)
          | mtnrec (Proj(_,c))     = mtnrec c
          | mtnrec (Var(_,c))      = mtnrec c
          | mtnrec _               = false
     in mtnrec end


(* construction of compound bodies... *)
     (* non-binders have one form *)
(*
fun mkAppBod f (b,vs) = (share2 (f,map_share f) b,vs)
*)
fun mkAppBod f (b as (b1, b2),vs) =
  (((f b1, no_raise_map_share f b2) handle Share => (b1, map_share f b2)), vs)

(*
fun mkTupleBod f Tls = share2 (f,map_share f) Tls
*)
fun mkTupleBod f (Tls as (t1, t2)) =
  (f t1, no_raise_map_share f t2) handle Share => (t1, map_share f t2)

fun mkProjBod f (s,b) = (s,f b)
     (* binders have two forms *)
fun mkBindBod f k (t,s,b1,b2) =
      let val (b1',b2') = share2 (f k,f (succ k)) (b1,b2) in (t,s,b1',b2') end
fun mkBindBod2 f (t,s,b1,b2) = 
      let val (b1',b2') = share2 (f,f) (b1,b2) in (t,s,b1',b2') end


(* lifting to avoid capture *)
exception Lift
(** WARNING: This function doesn't use the canonical constructors below **)
fun lift_unshared n =
  if n=0 then (fn _ => raise Share)
  else
    let fun lft_rec k (Rel(m))  = if m<k then raise Share
				  else if (m+n)>0 then  Rel(m+n)
				       else raise Lift
	  | lft_rec k (App(b))  = App(mkAppBod (lft_rec k) b)
	  | lft_rec k (Bind(b)) = Bind(mkBindBod lft_rec k b) 
	  | lft_rec k (Tuple(b))= Tuple(mkTupleBod (lft_rec k) b)
	  | lft_rec k (Proj(b)) = Proj(mkProjBod (lft_rec k) b)
	  | lft_rec k _         = raise Share
    in lft_rec 1
    end
fun lift n = share (lift_unshared n)


(* now can define canonical term constructors *)
fun MkApp ((c,[]),_)                  = c
  | MkApp ((App((c',cs'),vs'),cs),vs) = MkApp ((c',cs'@cs),(vs'@vs))
  | MkApp x                           = App(x)
fun mkApp f b = MkApp(mkAppBod f b)
fun MkBind (d as ((Let,_),_,_,b)) = if var_occur b then Bind(d)
				    else lift (~1) b
  | MkBind b                      = Bind(b)
fun mkBind f k b = MkBind(mkBindBod f k b)
fun mkBind2 f b = MkBind(mkBindBod2 f b)
fun MkTuple(T,l) =
  let 
    fun standard cs =  (* unfold all rightmost Tuples *)
      case rev cs
	of (tpl as Tuple(_,ks))::cs => (rev cs)@(standard ks)
	 | cs                       => rev cs
  in 
    case standard l
      of []  => bug"MkTuple"
       | [l] => l
       | ls  => Tuple(T,ls)
  end
fun mkTuple f b = MkTuple(mkTupleBod f b)
fun MkProj b = Proj(b)
fun mkProj f b = MkProj(mkProjBod f b)



(** Substitution of object language (nameless variable) terms **)
(* Remark : We use sharing for the substitution functions *)

(* substitute (f a) for Rel(1) in c.  Is lazy about applying f to a *)
fun subst1_lazy f a = 
  let
    fun substrec n = 
      let
	val lift_fa = ref (fn (_:int) => Bot)
	fun init_lift_fa j =
	  let
	    val fa = f a     (* compute (f a) on first call to lift_fa *)
	    fun mem_lift_fa mem =
	      fn 0 => fa
	       | j => assoc j mem
		   handle _ => (* call to lift_unshared tests fa closed *)
		     (let val ljfa = lift_unshared j fa
		      in  lift_fa:= mem_lift_fa ((j,ljfa)::mem); ljfa
		      end handle Share => (lift_fa:= (fn _ => fa); fa))
	  in lift_fa:= mem_lift_fa []; (!lift_fa j)
	  end
	val _ = lift_fa:= init_lift_fa
      in
	fn (arg as Rel(n'))   => if n'=n then (!lift_fa) (n-1)
			else if n'<n then arg(*raise Share*) else Rel(n'-1)
	 | App(b)    => mkApp (substrec n) b
	 | Bind(b)   => mkBind substrec n b
	 | Tuple(b)  => mkTuple (substrec n) b
	 | Proj(c)   => mkProj (substrec n) c
	 | x         => (*raise Share*)x
      end
  in share (substrec 1) end
val subst1 = subst1_lazy I

(* substitute Rel(1) for Ref(br) *)
fun subst2 bref = 
    let fun substrec n (Ref(br))   = 
              if sameRef br bref then Rel(n) else raise Share
          | substrec n (App bod)  = mkApp (substrec n) bod
          | substrec n (Bind b)   = mkBind substrec n b
          | substrec n (Tuple b)  = mkTuple (substrec n) b
          | substrec n (Proj c)   = mkProj (substrec n) c
          | substrec n _          = raise Share
     in share (substrec 1) end

