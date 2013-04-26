(*
 *
 * $Log: discharge.sml,v $
 * Revision 1.2  1998/08/05 17:36:50  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "utils.sml";
require "term.sml";
require "pretty.sml";
require "unif.sml";
require "namespace.sml";
require "machine.sml";
require "synt.sml";
(* discharge.sml *)


(** Commands to DISCHARGE an assumption; to FORGET assumptions;
 ** and to SPECIALIZE an assumption to a particular witness 
 **)

(* split context at name *)
fun splitCtxt nam = 
  let
    fun sr pre (br::brs) = if nam = (ref_nam br) then (br::pre,brs)
			   else sr (br::pre) brs
      | sr pre []        = failwith(nam^" undefined or out of scope")
  in
    sr [] (!NSP)
  end;

fun subRef s = 
  let
    fun sub_rec (arg as Ref(br))  = (assoc (ref_ts br) s handle Assoc => arg(*raise Share*))
      | sub_rec (Var(u,c)) = Var(u,sub_rec c)
      | sub_rec (App(b))   = mkApp sub_rec b
      | sub_rec (Bind(b))  = mkBind2 sub_rec b
      | sub_rec (Tuple(b)) = mkTuple sub_rec b
      | sub_rec (Proj(b))  = mkProj sub_rec b
      | sub_rec x          = (*raise Share*)x
  in share sub_rec
  end
fun subRef_pr s = pair_apply (subRef s);

val disch_debug = ref false
fun dk (left,deltas,moved) br =
  let
    fun discharge oper deps (vt as (v,t)) =
      let
	val _ = if !disch_debug
		  then (prs("\n** disch debug **  ");
			prnt_vt v t)
		else ()
	fun operate (vcv as (vt as (v,t),cs,vs)) br =
	  (if !disch_debug
	     then (prs("\n** operate ** "^ref_nam br^", "); prnt_vt v t)
	   else ();
	   if (depends br v orelse depends br t)
	             orelse (exists (sameRef br) deps)
	     then case ref_bind br
		    of Lda => (oper vt br,
			       (Ref br)::cs,
				(prVis (ref_vis br))::vs)
		     | Let => (letize vt br,cs,vs)
		     | _ => bug"funny Discharge"
	   else vcv)
      in 
	foldl operate (vt,[],[]) moved
      end
    fun globalDefn ts deps vt =
      let
	val (vt,cs,vs) = discharge abstract deps (subRef_pr deltas vt)
	val br' = ref_updat_vt br vt
      in  
	(br'::left,
	 compose subRef [(ts,MkApp((Ref br',cs),vs))] deltas,
	 moved)
      end
    fun globalDecl ts deps vt =
      let	           (* a global decl depends on everything! *)
	val (vt,cs,vs) = discharge generalize deps (subRef_pr deltas vt)
	val br' = ref_updat_vt br vt
      in  
	(br'::left,
	 compose subRef [(ts,MkApp((Ref br',cs),vs))] deltas,
	 moved)
      end
    fun reductions ts deps vt =
      let
	val (vt,cs,vs) = discharge abstract deps (subRef_pr deltas vt)
	val br' = ref_updat_vt br vt
      in  
	(br'::left,deltas,moved)
      end
    fun localDecl ts n vt =
      let
	val vt = subRef_pr deltas vt
	val br'= ref_updat_vt br vt
      in
	prs(" "^n);
	(left,compose subRef [(ts,Ref br')] deltas,br'::moved)
      end
    fun localDefn ts n vt =
      let
	val vt = subRef_pr deltas vt
	val br'= ref_updat_vt br vt
      in
	prs(" "^n);
	(left,compose subRef [(ts,Ref br')] deltas,br'::moved)
      end
  in
    case (ref_body br,ref_isDefn br)
      of ({kind=Red,ts,deps=deps,bd=(_,_,v,t),...},_)
	  => reductions ts deps (v,t)
       | ({kind=Mrk(_),...},_) => (br::left, deltas, moved)
       | ({kind=Bnd,ts,param=Global,deps=deps,bd=(_,_,v,t),...},true)
	  => globalDefn ts deps (v,t)
       | ({kind=Bnd,ts,param=Global,deps=deps,bd=(_,_,v,t),...},false)
	  => globalDecl ts deps (v,t)
       | ({kind=Bnd,ts,param=Local,bd=(_,n,v,t),...},true)
	  => localDefn ts n (v,t)
       | ({kind=Bnd,ts,param=Local,bd=(_,n,v,t),...},false)
	  => localDecl ts n (v,t)
  end;


fun dischg nam msg =
    if activeProofState() then failwith"No Discharge in proof state"
    else let val (new,old) = splitCtxt nam
         in  (prs("Discharge and "^msg^".. ");
	      HIST:= NoProof;
              foldl dk (old,[],[]) new)
	 end;

local
  fun dischState nsp = (NSP:= nsp; line(); autoInitUniv(); makeAllPats())
in
  fun DischargeKeep nam = let val (left,_,moved) = dischg nam "keep"
			  in  dischState (moved@left)
			  end
  and Discharge nam = let val (left,_,_) = dischg nam "forget"
		      in  dischState left
		      end
end;


fun Forget nam =
    if activeProofState()
      then failwith"No Forget in proof state"
    else if isNewName nam (!NSP)
      then message("Forget is no-op; \""^nam^"\" not defined")
    else let val (_,rmndr) = splitCtxt nam
         in  (NSP:= rmndr;
	      HIST:= NoProof;
	      makeAllPats();
	      message ("forgot back through "^nam))
	 end;
