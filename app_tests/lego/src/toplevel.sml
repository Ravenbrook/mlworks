(*
 *
 * $Log: toplevel.sml,v $
 * Revision 1.2  1998/08/05 17:29:44  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "ut1";
require "utils.sml";
require "universe.sml";
require "pretty.sml";
require "term.sml";
require "type.sml";
require "toc.sml";
require "unif.sml";
require "namespace.sml";
require "machine.sml";
require "parser.sml";
require "synt.sml";
(* top level *)

(* toplevel goal: save for use at end of proof *)
val TLGOAL = ref Bot;

(* initialize toplevel *)
fun init_toplevel() = HIST:= NoProof;

(* Putting PR and DECH together is ugly; but it's the only way I
 * can get "auto discharge".  Notice DECH is now hidden from users *)
fun Pr() = 
    let 
      fun disCom m VT =
	let
	  fun dc VT =
	    if m<>latestTsGbl()
	      then let val (VT,br) = dischCxtGbl VT
		   in  (prs(" "^ref_nam br); dc VT) 
		   end
	    else (fst VT)
	in 
	  if m<>latestTsGbl()
	    then (prs "Discharge.. "; let val V = dc VT in line(); V end)
	  else fst VT
	end
      fun DECH () =
	case (!QUEST)    (* discharge function *)
	  of Unknown([])::q  => (QUEST:=q; DECH())
	   | Push(n,m,c)::q  =>
                let val sbst = [(n,disCom m (!COM,Bot))]
		in  (COM:= sub sbst c;
		     QUEST:= eraseq sbst q;
		     DECH()) 
		end
	   | Unknown(_)::_  => PR()
	   | []  => (COM:= disCom(ref_ts(hd (!GOAL_CTXT)))(!COM,Bot); Pr())
    in  case !QUEST
	  of [] => let val com = snd (fEval (unEval (!COM)))
		   in if (pure (!COM) andalso   (***********************)
			  (!MacroMode orelse 
			   (convert com (!TLGOAL)
			    orelse type_match com (!TLGOAL))))
			then (pushHistProven  (!COM,!TLGOAL);
			      message"*** QED ***")
		      else bug"Pr"
		   end
	   | Push(_)::_     => DECH()
	   | Unknown([])::q => DECH()
	   | Unknown(l)::q  => prl l
    end
and PR() = if activeProofState()
	     then (prt_context_ref (hd (!GOAL_CTXT)) ElideDfns; Pr())
	   else if provenState() 
		  then message"all goals proven!"
		else failwith"No refinement state";


(* to apply tactics *)
fun appTac f x =
    if not (activeProofState()) then failwith"no active goals"
    else (pushHist(); (f x) handle Failure s => (undo(); failwith s));
fun AppTac f x = (ignore(appTac f x); PR())
fun smallAppTac f x = (ignore(appTac f x); Pr());



fun Goal u =
  if activeProofState() then failwith"Cannot use 'Goal' during a proof"
  else let val (V,T) = fEval u
       in  if kind T then (message"Goal";
			   GOAL_CTXT:= (!NSP);
			   NUN:=0;
			   QUEST:= [Unknown[(0,V)]];
			   COM:= Var(0,V);
			   TLGOAL:= V;
			   HIST:= Initial;
			   Pr())
	   else failwith"Only a Prop or a Type can be a goal"
       end;


fun Undo n = repeat n undo () handle UndoExn => ()
fun UNDO n = if proofState()
	       then (ignore(Undo n); message "Undo"; PR())
	     else failwith"Cannot undo: not in proof state";


fun nullTac (x:substitution) = ();

val AutoTac = ref nullTac;


fun solve tacflg g (nsp,new,c,q,close,V) tac =
   (if not tacflg
      then (prs("Refine"^(if g>0 then " "^string_of_num g else "")^" by  ");
	    ignore(legoprint V); ignore(pushHist()))
    else ();
    NSP:=nsp; COM:=c; QUEST:=q; ignore(close()); tac new;
    if not tacflg then Pr() else ())
and RefineTac_c n m v_c = solve true n (resolve_c n m v_c)
and RefineTac_a n m v = solve true n (resolve_a n m v)
and Refine n m v_c = solve false n (resolve_c n m v_c) (!AutoTac)
and SolveTacn n m v_c =
    let val (res as (_,new,_,_,_,_)) =
      ((resolve_c n m v_c) handle _ => ([],[(0,Bot)],Bot,[],(fn()=>0),Bot))
    in  
      if new=[] then (solve true n res nullTac; true) else false 
    end;


fun killRef() =
  let fun undoAll() = (Undo 99999; HIST:= NoProof)
  in
    if activeProofState()
      then (message"Warning: forgetting an unfinished proof"; undoAll())
    else if provenState()
      then (message"Warning: forgetting a finished proof"; undoAll())
    else()
  end
fun KillRef() = (killRef(); message "KillRef: ok, not in proof state");


fun claim v_c =
  let val (mkVar,eraseNew,close) = manageVars()
  and (l,q) = goals()
      val ((V,T),sbst) = EvalRefine type_of_Var mkVar v_c
  in  if kind T 
      then (ignore(mkVar V); ignore(close()); ((Unknown(l@(eraseNew sbst))::q),V))
      else failwith"Only a Prop or a Type can be claimed" end;

fun Claim v_c =
    let val (q,V) = claim v_c
    in  (prs"Claim  "; legoprint V; pushHist(); QUEST:=q; Pr()) end;



(* on veut d'abord chercher une preuve du sous-but n *)
fun NextTac n =
    let fun reorder n ((u as (p,_))::l) = 
              if p=n then (u,l) 
                     else let val (v,l') = reorder n l in (v,u::l') end
          | reorder n [] = failwith("reorder: subgoal "^string_of_num n
                                                   ^" not found")
     in
    if n=(~9999) then ()
    else (QUEST:= (let val (l,q) = goals() 
                       val (u,l') = reorder n l in  Unknown(u::l')::q end);
          () )
    end;

val Next = appTac (fn n => (NextTac n; message("Next "^string_of_num n)));

local
  fun mk_goal c = ((NUN:= 1+(!NUN);!NUN),c)  (** dnf c ?? **)
  fun push_so_far ((n,c),l,q) h c' =
    if eq (c,c') then ()
    else let val gl = mk_goal c'
         in  (QUEST:= Unknown([gl])::((Push(n,h,!COM))::(Addq l q));
              COM:= Var(gl); () )
	 end
  fun mk_name nam s = mkNameGbl(if nam<>"" then nam
				else if s<>"" then s else "H")
in
  fun do_intros count lst (flgs as (hnfFlg,autoFlg)) =
    let
      fun intros_rec count lst c push =
	let
	  fun pi_intro nam nams ((_,vis),s,c1,c2) push =
	    let
	      val nam = mk_name nam s
	      val newCxt =
		extendCxtGbl Lda vis Local [] nam (c1,type_of_constr c1)
	    in
	      intros_rec (count+1) nams (subst1 (Ref(hd newCxt)) c2) push
	    end
	  fun sig_intro (sigBod as (_,s,tl,tr)) =
	    let
	      val ((n,c),l,q) = subgoals()
	      val goal_l = mk_goal tl
	      val tr = subst1 (Var goal_l) tr
	      val goal_r = mk_goal tr
	      (***********  Tuple is unsafe ********)
	      val sbst = [(n,Tuple(Bind sigBod,[Var goal_l,Var goal_r]))]
	    in
	      (QUEST:= eraseq sbst (Unknown(goal_l::goal_r::l)::q);
	       COM:= sub sbst (!COM); () )
	    end
	  fun let_intro nam nams ((_,vis),s,c1,c2) push =
	    let
	      val nam = mk_name nam s
	      val newCxt =
		extendCxtGbl Let vis Local [] nam (c1,type_of_constr c1)
	    in  
	      intros_rec (count+1) nams (subst1 (Ref(hd newCxt)) c2) push
	    end
	in
	  case if autoFlg then [""] else lst
	    of nam::nams
	        => (case if hnfFlg then hnf c else c
		      of Bind(b as ((Pi,_),_,_,_))
			 => pi_intro nam nams b push
		       | Bind(b as ((Sig,_),_,_,_))
			 => if nam="#" orelse autoFlg
			      then (ignore(push c); sig_intro b;
				    do_intros count nams flgs)
			    else failwith
			      ("SIG Intro with improper token: "^nam)
		       | Bind (b as ((Let,_),_,_,_))
			 => let_intro nam nams b push
		       | _  => if autoFlg then (ignore(push c); count)
			       else failwith"goal has wrong form for intros")
	      | [] => (ignore(push c); count)
	end
      val (sgs as ((_,c),_,_)) = subgoals() 
      val h = latestTsGbl()
    in
      intros_rec count lst c (push_so_far sgs h)
    end
end;

val intros_debug = ref false;
fun IntrosTac n l hnfFlg = (NextTac n; do_intros 0 l (hnfFlg,l=[]))
fun Intros n hnfFlg =
      smallAppTac
        (fn l => let
		   val show_l = concat_sep " " (map (fn "" => "_" | x => x) l)
		   val _ = if (!intros_debug)
			     then (prs"**intros_debug** "; pri n; prs" ";
				   prs show_l; prs" "; print_bool hnfFlg; line())
			   else ()
		   val count = IntrosTac n l hnfFlg
		 in
		   prs(if hnfFlg then "Intros " else "intros ");
		   prs"("; pri count; prs") "; message show_l;
		   prt_context_dpth count ElideDfns
		 end);


fun Save name locGlob =
  case !HIST
    of Proven(vt,_) => (ignore(extendCxtGbl Let Def locGlob [] name vt);
			HIST:= NoProof;
			message ("\""^name^"\"  saved as "^
			  (if locGlob=Local then "local" else "global")))
     | NoProof => failwith"no proof to save"
     | _ => failwith("cannot Save \""^name^"\": proof unfinished");

