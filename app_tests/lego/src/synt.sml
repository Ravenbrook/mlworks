(*
 *
 * $Log: synt.sml,v $
 * Revision 1.2  1998/08/05 17:28:41  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "utils.sml";
require "universe.sml";
require "term.sml";
require "pretty.sml";
require "type.sml";
require "toc.sml";
require "unif.sml";
require "namespace.sml";
require "parser.sml";
(* synt.sml *)


(* "quest" is the type of the current goals.
 * Empty is the null list of subgoals.
 * Push indicates introductions, hence a change of context.
 *    When Push is the head of a "quest", a discharge is
 *    needed, after Push is removed so previous goals are
 *    restored in their correct context.
 * Unknown is the list of subgoals in the current context.
 *)
datatype question =
  Push of int * int * cnstr
| Unknown of assignment list;
type quest = question list;


val QUEST = ref([] : quest);

(* utilities for "quest"ions *)

fun map_quest fU fc = map (fn Unknown(l)  => Unknown(fU l)
                            | Push(n,m,c) => Push(n,m,fc c));

local
  fun ff s (m,c) l = if mem_assoc m s then l else (m,sub s c)::l
in
  fun erase_replace s n new =
    let fun fff (m,c) l = if n=m then new@l else ff s (m,c) l
    in  foldr fff []
    end
  fun erase s = foldr (ff s) []
end;

fun eraseq s = map_quest (erase s) (sub s);

fun Addq l = if l = [] then I else fn        (* add new subgoals *)
                  Unknown(l1)::q => Unknown(l@l1)::q
                | q              => Unknown(l)::q;

fun type_of_Var n = 
    let fun tov_rec (Unknown(l)::q) = ((assoc n l) handle _ =>  (tov_rec q))
          | tov_rec (_::q)          = tov_rec q
          | tov_rec []            
              = failwith("Undefined metavar: ?"^(string_of_num n))
     in tov_rec (!QUEST) end;

fun type_of_Var_restricted m n =
    if m = n then failwith("use of ?"^(string_of_num m)^" out of scope")
             else type_of_Var n;


(* la preuve partielle *)
val COM = ref Bot;


(* for gensym *)
val NUN = ref(0);


(* reference to newest context before proof *)
val GOAL_CTXT = ref (!NSP);


(* history; for UNDO *)
datatype hist =
  Initial | NoProof | State of state | Proven of (cnstr * cnstr) * hist
withtype state =
  cnstr * quest * int * context * univ_graph * hist;

val HIST = ref NoProof;

fun pushHist() =
  HIST:= State(!COM,!QUEST,!NUN,!NSP,!UVARS,!HIST)
fun pushHistProven vt = HIST:= Proven(vt,!HIST)


fun proofState() = !HIST <> NoProof
fun activeProofState() =
  case !HIST of Initial => true | State s => true | _ => false
fun provenState() = case !HIST of Proven s => true | _ => false;


exception UndoExn
fun undo() =
  let fun restore (c,q,n,v,u,h) =
    (COM:=c;QUEST:=q;NUN:=n;NSP:=v;UVARS:=u;HIST:=h;())
  in  case !HIST
	of State st => restore st
	 | Proven(_,State st) => restore st
	 | Initial => (NSP:= (!GOAL_CTXT); raise UndoExn)
	 | _ => bug"undo"
  end;


fun goals() = if activeProofState()
		then case !QUEST
		       of Unknown(l)::q => (l,q)
			| _             => bug"goals"
	      else failwith"no current goals"
fun subgoals() = case goals()
		   of ((nc as (n,c))::l,q) => (nc,l,q)
		    | ([],_)               => bug"subgoals"
fun goaln n = if n=(~9999) then #1 (subgoals())
              else (n,assoc n (fst (goals()))
                    handle _ =>  
                      failwith("goal "^(string_of_num n)^" not found"))
fun goal_plusn n =
    let val (h,t,_) = subgoals()
        val l = h::t
        fun check _ [] = failwith("goal +"^(string_of_num n)^" not found")
          | check 0 (h::_) = h
          | check n (_::t) = check (n-1) t
     in check n l end;



(* some tools for managing metavars *)
fun manageVars() =
  let 
    val nun = ref(!NUN)
    val newVars = ref([] : assignment list)
    fun mkVar cc = 
      let val nc = ((nun:= !nun+1; !nun),cc) 
      in (newVars:= !newVars@[nc]; Var(nc))
      end
    fun eraseNewVars t = 
      (newVars:= map (fn (n,c) => (n,dnf c)) (erase t (!newVars));
       !newVars)
    fun closeNewVars() = (NUN:= !nun; !NUN)
  in  (mkVar,eraseNewVars,closeNewVars)
  end;


exception Explicit of cnstr * cnstr;
(* unroll a construction to make a refinement rule of it.
 * maintain invariant a achieves c with subgoals newVars
 * (see resolve).   *)
fun explicit mkVar (a,c) = case hnf c of
  Bind((Pi,v),_,d,e) => let val V = mkVar d
                        in  (MkApp((a,[V]),[prVis v]),subst1 V e)
			end
| _                  => raise Explicit(a,c);


(* The principal function: try to solve the current goal against the
 * (type of) v_c.  The match is first tried against the entire TYP.
 * If that fails, TYP is progressively unwound (by explicit). *)
val resolve_debug = ref false;
local
  fun resolve_abstract explicit VT p c =
    let
      fun resolve_rec (a1,c1) =
	let
	  val _ = if (!resolve_debug) then (prs"*res1* "; prnt_vt a1 c1)
		  else ()
	  val (b,s) = type_match_unif [] c1 c
	in  if b then compose sub [(p,sub s a1)] s
	    else resolve_rec (explicit (a1,c1))
	end
    in
      resolve_rec VT handle Explicit(_) => failwith"doesn't solve goal"
    end
  fun subPrfCxt s (nsp as (b::l)) =
        if sameRef b (hd (!GOAL_CTXT)) then nsp
       else ref_updat_vt b (pair_apply (sub s) (ref_vt b))::(subPrfCxt s l)
    | subPrfCxt s [] = bug"subPrfCxt"
in
  fun resolve_c n m v_c =      (* when v_c is a concrete term *)
    let val (mkVar,eraseNew,close) = manageVars()
      val (l,q) = goals()
      val (n,goal) = goaln n
      val ((VT as (V,T)),sbst) =
	EvalRefine (type_of_Var_restricted n) mkVar v_c
      val _ = if (!resolve_debug) then (prs"*resc1* "; prnt_vt V T)
	      else()
      val (VT as (V,T)) = 
	(ignore(eraseNew sbst);
	 (Repeat m (explicit mkVar) VT
	  handle Explicit(_) => failwith"too much cut"))
      val _ = if (!resolve_debug) then (prs"*resc2* "; prnt_vt V T)
	      else()
      val s = resolve_abstract (explicit mkVar) VT n goal
      val new = eraseNew s
    in  (subPrfCxt s (!NSP),
	 new,
	 sub s (!COM),
	 Unknown(erase_replace s n new l)::(eraseq s q),
	 close,
	 V)
    end
  fun resolve_a n m V =      (* when V is an abstract term *)
    let val (mkVar,eraseNew,close) = manageVars()
      val (l,q) = goals()
      val (n,goal) = goaln n
      val T = type_of_constr V
      val _ = if (!resolve_debug) then (prs"*resa1* "; prnt_vt V T)
	      else()
      val (VT as (V,T)) = (Repeat m (explicit mkVar) (V,T)
			   handle Explicit(_) => failwith"too much cut")
      val _ = if (!resolve_debug) then (prs"*resa2* "; prnt_vt V T)
	      else()
      val s = resolve_abstract (explicit mkVar) VT n goal
      val new = eraseNew s
    in  (subPrfCxt s (!NSP),
	 new,
	 sub s (!COM),
	 Unknown(erase_replace s n new l)::(eraseq s q),
	 close,
	 V)
    end
end;
