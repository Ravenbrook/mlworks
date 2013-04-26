(*
 *
 * $Log: newtop.sml,v $
 * Revision 1.2  1998/08/05 17:31:57  jont
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
require "type.sml";
require "unif.sml";
require "namespace.sml";
require "parser.sml";
require "ind_relations.sml";
require "synt.sml";
require "toplevel.sml";
require "^.polyml-compat";
(* newtop.ml *)

(* scratch registers *)
val VAL = ref Prop
val TYP = ref (Type((uconst 0)));

fun init_newtop() = (VAL:= Prop; TYP:= Type((uconst 0)));


(** Reductions on subgoal, !VAL, !TYP **)

fun Dnf () =
    let val ((n,c),l,q) = subgoals()
        val q' = (Unknown((n,dnf c)::l))::q
        in (pushHist();
            QUEST:= q';
            message "DNF";
            Pr()) end;

fun V_Dnf () = (VAL:=(dnf (!VAL)); legoprint (!VAL));
fun T_Dnf () = (TYP:=(dnf (!TYP)); legoprint (!TYP));

fun Normal () =
    let val ((n,c),l,q) = subgoals()
        val q' = (Unknown((n,normal c)::l))::q
        in (pushHist();
            QUEST:= q';
            message "Normalize";
            Pr()) end;

fun V_Normal () = (VAL:=(normal (!VAL)); legoprint (!VAL)); 
fun T_Normal () = (TYP:=(normal (!TYP)); legoprint (!TYP));

fun Hnf () =
    let val ((n,c),l,q) = subgoals()
        val q' = (Unknown((n,hnf c)::l))::q
        in (pushHist();
            QUEST:= q';
            message "HNF";
            Pr()) end;

fun V_Hnf () = (VAL:= hnf (!VAL); legoprint (!VAL));
fun T_Hnf () = (TYP:= hnf (!TYP); legoprint (!TYP));

fun Equiv trm_c =
    let
      val (mkVar,eraseNew,close) = manageVars()
      val ((nc as (n,c)),l,q) = subgoals()
      val ((V,_),sbst) = EvalRefine type_of_Var mkVar trm_c
      val (b,s) = convert_unif sbst c V
    in
      if b then
	let val new = (n,sub s V)::(eraseNew s)
	in (pushHist();
	    QUEST:= Unknown(erase_replace s n new (nc::l))::(eraseq s q);
	    ignore(close()); message"Equiv"; Pr())
	end
      else failwith"not convertible"
    end;

fun V_Equiv new = let val (V,_) = fEval new
		  in  if (convert (!VAL) V) then (VAL:= V; message"true")
                      else message"false" end;
fun T_Equiv new = let val (V,_) = fEval new
		  in  if (convert (!TYP) V) then (TYP:= V; message"true")
                      else message"false" end;

fun Expand nams =
    let val ((n,c),l,q) = subgoals()
    in  (pushHist();
         QUEST:= (Unknown((n,dnf (foldl (C expand) c nams))::l))::q;
	 prs"Expand "; message (concat_sep " " nams);
         Pr()) end;
fun V_Expand nams = 
    (VAL:= dnf (foldl (C expand) (!VAL) nams); legoprint (!VAL));
fun T_Expand nams = 
    (TYP:= dnf (foldl (C expand) (!TYP) nams); legoprint (!TYP));

fun ExpAll m =
    let val ((n,c),l,q) = subgoals()
    in  (pushHist();
         QUEST:= (Unknown((n,dnf (expAll m c))::l))::q;
	 message ("ExpAll "^string_of_num m);
         Pr()) end;
fun V_ExpAll n = (VAL:= dnf (expAll n (!VAL)); legoprint (!VAL));
fun T_ExpAll n = (TYP:= dnf (expAll n (!TYP)); legoprint (!TYP));


(* Evaluate contexts *)
local
  fun evalDeps deps = map (fn n => search n (!NSP)) deps
in
  fun evalCxt (b,Def,par_flg,deps,ns,c) = 
    (do_list (fn n => extendCxtGbl b Def par_flg
                                         (evalDeps deps) n (fEval c))
             ns;
     prs "defn  "; prs (concat_sep " " ns);
       prs" = "; legoprint (ref_val (hd (!NSP)));
       prs "      "; prs (concat_sep " " ns);
       prs" : "; legoprint (ref_typ (hd (!NSP))) )
    | evalCxt (b,v,par_flg,deps,ns,c)   = 
      if activeProofState()
	then failwith"Cannot add assumptions during a proof"
      else (do_list (fn n => extendCxtGbl b v par_flg
                                              (evalDeps deps) n (fEval c))
                    ns;
	    prs "decl  "; prs (concat_sep " " ns);
	    prs (if v=Vis then " : " else " | ");
	    legoprint (ref_typ (hd (!NSP))) )
end
val EvalCxt = do_list evalCxt;

fun EvalRed c =
  if activeProofState()
    then failwith"Cannot add reductions during a proof"
     else (SaveReductGbl (fEval c);
	   message"added reductions";
	   makeAllPats());


(*
local
  val t = ref (System.Timer.start_timer())
in
  fun StartTimer() = (t:= start_timer(); message"- Start Timer -")
  fun PrintTimer() = message("- Print Timer -  "^(makestring_timer (!t)))
end
*)


(***  For dynamic changes to LEGOPATH ***)

local
  fun splitup([],l) = [implode (rev ("/"::l))]
    | splitup(":"::t, l) = (implode (rev ("/"::l))) :: (splitup(t,[]))
    | splitup(c::t, l) = splitup(t, c::l)
  val addPath = ref ([]:string list)
  val delPath = ref ([]:string list)
in
  fun legopath() =
    let
      fun check [] = ["./"]
	| check (h::t) =
	  if size h < 10 then check t
	  else case substring(h,0,9)
		 of "LEGOPATH=" =>
		   splitup (explode (substring(h,9,size h - 9)), [])
		  | _ => check t
    in
      check (get_unix_environment())
    end
end;


fun Eval c =
  let
    val (v,t) = fst (fEval_ (!NSP) type_of_Var (parser_var_pack()) c)
    val nam = (case v
		 of (Ref br) => if ref_isDefnNow br
				  then ("of "^ref_nam br^" ")
				else ""
		  | _ => "")
    val _ = VAL:= (case v of (Ref br) => ref_val br | _ => v)
    val _ = TYP:= t
  in
    prs ("value "^nam^"= "); legoprint(!VAL);
    prs ("type "^nam^" = "); legoprint(!TYP)
  end;


fun inductive_datatype ct1 ct2 ct3 no_reds = 
    let 
      val oldcontext = !NSP
      val (ctxt1,reduc) = do_inductive_type ct1 ct2 ct3 no_reds
	                     handle sch_err s => failwith ("Inductive: "^s);
    in
      (EvalCxt ctxt1;
       if not no_reds
	  then (legoprint (fst (fEval reduc)); EvalRed reduc)
       else ())
      handle ex => (NSP := oldcontext; raise ex)
    end;
