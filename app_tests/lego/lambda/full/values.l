(*
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: values.l,v $
 * Revision 1.1  1998/08/06 10:36:10  jont
 * new unit
 * Lego test application
 *
 *
 *)
Forget loc;

(* A type of locations *)
Inductive [loc:SET]
Constructors
[mkloc: {n:NN}loc];

(* Needed as a default value for projection functions *)
[dummyloc = mkloc Z];

Goal loc -> NN;
Refine loc_elim[_:loc]NN;
Intros n;Refine n;
Save loc_num;

(* values - a simultaneous inductive definition *)
(* vallists are just lists of values *)
Inductive [val:SET][vallist:SET]
Constructors 
[vnum:NN->val]
[vloc:loc->val]
[clos:exp->expLL->vallist->val]
[vtuple:vallist->val]
[valnil:vallist]
[valcons:val->vallist->vallist];

(* A simpler induction scheme for values *)

Goal {T:TYPE}(NN->T)->(loc->T)->(exp->expLL->vallist->T)->(vallist->T)->val->T;
Intros T nf lf cf pf;
Refine val_elim([_:val]T)([_:vallist]BB);
Refine nf;
Refine lf;
Intros;Refine cf;Immed;
Intros;Refine pf x3;
Refine tt;
Intros;Refine tt;
Save valrec;

(* Simpler induction schemes for vallists *)

Goal
{C_vallist:vallist->TYPE} 
(C_vallist valnil)->
({car:val}{cdr:vallist}{cdr_ih:C_vallist cdr}C_vallist (valcons car cdr))->
{z:vallist}C_vallist z;
intros _ _ _ _;
Refine vallist_elim ([_:val]BB)C_vallist;
Intros;Refine tt;
Intros;Refine tt;
Intros;Refine tt;
Intros;Refine tt;
Refine H;
Intros; Refine H1 x1 x2 x2_ih;
Save vallist_elim1;

[valLL = LL|val];

Goal vallist->valLL;
Refine vallist_elim1([_:vallist]valLL);
Refine NIL;
Intros;
Refine CONS car cdr_ih;
Save vallist_to_valLL;

Goal valLL -> vallist;
Refine LLrec [_:valLL]vallist;
Refine valnil;
Intros;
Refine valcons b LLih;
Save valLL_to_vallist;

Goal {T:TYPE} T -> (val -> vallist -> T -> T) -> {ve:vallist}T;
intros;
Refine vallist_elim1 [_:vallist]T;
Refine H;
intros; Refine H1 car cdr cdr_ih;
Refine ve;
Save vallist_rec;

(* Projections and predicates *)

[valnum_proj = valrec NN ([H:NN]H) ([_:loc]Z)([_:exp][_:expLL][_:vallist]Z) ([_:vallist]Z)];
[valexp_proj = valrec exp ([_:NN]num Z) ([_:loc]num Z) ([e:exp][_:expLL][_:vallist]e) ([_:vallist]num Z)];
[valexpLL_proj = valrec expLL ([_:NN]NIL|exp) ([_:loc]NIL|exp) ([e:exp][el:expLL][_:vallist]el) ([_:vallist]NIL|exp)];
[valenv_proj = valrec vallist ([_:NN]valnil) ([_:loc]valnil) ([e:exp][_:expLL][ve:vallist]ve) ([_:vallist]valnil)];
[valloc_proj = valrec loc ([n:NN]dummyloc) ([l:loc]l)([_:exp][_:expLL][ve:vallist]dummyloc)([_:vallist]dummyloc)];
[valvallist_proj = valrec vallist ([_:NN]valnil) ([_:loc]valnil) ([e:exp][_:expLL][_:vallist]valnil) ([vl:vallist]vl)];

(* Length of a vallist *)
Goal vallist -> NN;
Refine vallist_elim1[ve:vallist]NN;
Refine Z;
Intros; Refine S cdr_ih;
Save ve_len;

(* Append vallists *)

Goal vallist->vallist->vallist;
Refine vallist_elim1[ve:vallist]vallist->vallist;
Intros;Refine H;
Intros;Refine valcons car (cdr_ih H);
Save ve_append;

(* Alternate definition *)
(*
[ve_append [vl1,vl2:vallist] = 
 valLL_to_vallist (append (vallist_to_valLL vl1) (vallist_to_valLL vl2))];
*)

(* Properties needed for vallists *)

(* lookup function in environments *)
(* Returns vnum Z if not defined *)
Goal vallist->NN->val;
Refine vallist_rec;
intros;Refine vnum Z;
intros;Refine tt_or_ff (neq H3 Z);
Intros;Refine H;
intros;Refine H2 (pred H3);
Save lookup_aux;

[lookup [n:NN][ve:vallist] = lookup_aux ve n];

Goal {ve:vallist}{v:val}{n:NN} Q (lookup (S n) (valcons v ve)) (lookup n ve);
intros;Refine Q_refl;
Save lookup_successor;

Inductive [state : SET]
Constructors [mk_state:vallist -> state];

Goal state->vallist;
Refine state_elim[_:state]vallist;
Intros H;Refine H;
Save state_vallist;

(* Should be usual definition *)
[state_lookup [l:loc][s:state] = lookup (loc_num l) (state_vallist s)];

(* Returns the next location in a state *)
[nextloc [s:state] = mkloc (ve_len (state_vallist s))];

(* Put a value onto the end of the list *)
[state_extend [s:state][v:val] = mk_state (ve_append (state_vallist s) (valcons v valnil))];

(* Update a location in a state *)
[state_update : state -> loc -> val -> state];

[ve_append_len_thm : {ve,ve':vallist} Q (ve_len (ve_append ve ve')) (add (ve_len ve)(ve_len ve'))];

[append_lookup_thm_less : 
{ve'|vallist}{n|NN}(is_tt (lt n (ve_len ve'))) -> 
{ve:vallist} Q (lookup n (ve_append ve' ve)) (lookup n ve')];

[append_lookup_thm_ge : 
{ve'|vallist}{n|NN}(is_tt (ge n (ve_len ve'))) -> 
{ve:vallist} Q (lookup n (ve_append ve' ve)) (lookup (sbt n (ve_len ve')) ve)];

[append_lookup_thm_gt :
{ve,ve':vallist}{a:val}{n:NN}
(is_tt (gt n (ve_len ve'))) -> 
Q (lookup n (ve_append ve' (valcons a ve)))
  (lookup (pred n) (ve_append ve' ve))];

[append_lookup_thm_equal : 
{ve'|vallist}{n|NN}(is_tt (neq n (ve_len ve'))) -> 
{v:val}{ve:vallist} Q (lookup n (ve_append ve' (valcons v ve))) v];

[append_thm: {x:val}{ve,ve':vallist}Q (ve_append (valcons x ve) ve') (valcons x (ve_append ve ve'))];

[append_assoc : {ve1,ve2,ve3:vallist}Q (ve_append ve1 (ve_append ve2 ve3)) (ve_append (ve_append ve1 ve2) ve3)];
