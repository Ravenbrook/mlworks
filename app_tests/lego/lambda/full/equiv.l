(*
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Log: equiv.l,v $
 * Revision 1.1  1998/08/06 10:36:10  jont
 * new unit
 * Lego test application
 *
 *
 *)
(* equivalences *)

Forget equiv;

(* Axiomatic characterization *)

(* The value equivalence *)

[equiv : val -> val -> Prop];

(* val_env equivalence *)

Goal val_env -> val_env -> Prop;
Refine vallist_elim([v:val]BB)[ve:val_env]val_env-> Prop;
Intros;Refine tt;
Intros;Refine tt;
Intros;Refine tt;
Intros;Refine tt;
Refine vallist_elim([v:val]BB)[ve:val_env]Prop;
Intros;Refine tt;
Intros;Refine tt;
Intros;Refine tt;
Intros;Refine tt;
Refine TT;
intros;Refine FF;
Intros _ _ _ _;
Refine vallist_elim([v:val]BB)[ve:val_env]Prop;
Intros;Refine tt;
Intros;Refine tt;
Intros;Refine tt;
Intros;Refine tt;
Refine FF;
intros;
Refine and (equiv x1 x11) (x2_ih x21);
Save ve_equiv;

(* the state equivalence *)
(* This needs to be defined so that the two states have the same domain *)
[state_equiv [s,s':state] = ve_equiv (state_vallist s) (state_vallist s')];

(* AXIOMS *)
(* equiv axioms *)
[equiv_eq : {x,y|val}(Q x y) -> equiv x y];
[equiv_trans : {x,y,z|val}(equiv x y) -> (equiv y z) -> (equiv x z)];
[equiv_sym : {x,y|val}(equiv x y) -> equiv y x];
[equiv_refl : {x|val}equiv x x];
(* Location equivalence is equality *)
[loc_equiv :{l1,l2:loc}(equiv (vloc l1) (vloc l2))->Q l1 l2];

(* equivalence on closures *)
(* Next two are inverses of each other *)
[equiv_app : 
{c1,c2,x1,x2,r1,r2|val}{s1,s1',s2,s2'|state}
(apply s1 c1 x1 r1 s1')->(apply s2 c2 x2 r2 s2')->
(equiv c1 c2)->
(equiv x1 x2)->
(state_equiv s1 s2)->
and (equiv r1 r2)(state_equiv s1' s2')];

[equiv_intro:
{c1,c2:val}
({x1,x2,r1,r2:val}{s1,s1',s2,s2'|state}
 (apply s1 c1 x1 r1 s1')->(apply s2 c2 x2 r2 s2')->
 (equiv x1 x2)->
 (state_equiv s1 s2)->
 and (equiv r1 r2) (state_equiv s1' s2'))->
equiv c1 c2];

Goal {ve1,ve2|val_env}{v1,v2|val}(ve_equiv ve1 ve2) -> (equiv v1 v2) -> ve_equiv (extend_ve v1 ve1) (extend_ve v2 ve2);
Intros;
Refine H2;Refine H1;Refine H;
Save extend_equiv;

Goal ve_equiv empty_ve empty_ve;
Intros;Immed;
Save empty_ve_equiv;

Goal {ve1,ve2|val_env}(ve_equiv ve1 ve2)->{n:NN}equiv(lookup n ve1)(lookup n ve2);
Refine vallist_elim1 [ve1:val_env]{ve2:val_env}(ve_equiv ve1 ve2)->{n:NN}equiv (lookup n ve1) (lookup n ve2);
Refine vallist_elim1 [ve2:val_env](ve_equiv empty_ve ve2)->{n:NN}equiv (lookup n empty_ve) (lookup n ve2);
intros;Refine equiv_eq;Refine Q_refl;
intros;Refine H;
Intros ___;
Refine vallist_elim1 [ve2:val_env](ve_equiv (extend_ve car cdr) ve2)->{n:NN}equiv (lookup n (extend_ve car cdr)) (lookup n ve2);
intros;Refine H;
Intros;
Refine Nrec [n:NN]equiv (lookup n (extend_ve car cdr)) (lookup n (extend_ve car1 cdr1));
Refine and1 H;
intros;Refine cdr_ih;Refine and2 H;
Save ve_equiv_thm;

Goal {ve,ve'|val_env} (ve_equiv ve ve')->Q(ve_len ve)(ve_len ve');
Refine vallist_elim1 [ve:val_env]{ve':val_env}(ve_equiv ve ve')->Q (ve_len ve) (ve_len ve');
Refine vallist_elim1 [ve':val_env](ve_equiv empty_ve ve')->Q (ve_len empty_ve) (ve_len ve');
Intros;Refine Q_refl;
intros;Refine H;
Intros ___;
Refine vallist_elim1 [ve':val_env](ve_equiv (extend_ve car cdr) ve')->Q (ve_len (extend_ve car cdr)) (ve_len ve');
intros;Refine H;
intros;Refine Q_resp S;
Refine cdr_ih;Refine and2 H;
Save equiv_len_thm;

(* State equivalence theorems *)
(* These should be provable *)
(* Given a proper definition of state_equiv *)
[state_equiv_eq : {x,y|state}(Q x y) -> state_equiv x y];
[state_equiv_trans : {x,y,z|state}(state_equiv x y) -> (state_equiv y z) -> (state_equiv x z)];
[state_equiv_sym : {x,y|state}(state_equiv x y) -> state_equiv y x];
[state_equiv_refl : {x|state}state_equiv x x];

[nextloc_ax:{s1,s2:state}(state_equiv s1 s2)->Q(nextloc s1)(nextloc s2)];

(* value state pairs *)
(* Useful operations of equivalence of value-state pairs *)
Goal {v1,v2|val}{s1,s2|state}
     (and (Q v1 v2)(Q s1 s2))->(and (equiv v1 v2) (state_equiv s1 s2));
Intros;
Refine H1;
Refine H;Intros;Refine equiv_eq;Immed;
Refine H;Intros;Refine state_equiv_eq;Immed;
Save pair_equiv_eq;

Goal {v1,v2,v3|val}{s1,s2,s3|state}
     (and (equiv v1 v2) (state_equiv s1 s2))->
     (and (equiv v2 v3) (state_equiv s2 s3))->
     (and (equiv v1 v3) (state_equiv s1 s3));
Intros;
Refine H2;
Refine equiv_trans;
Next +1;
Refine H;Intros;Immed;
Refine H1;Intros;Immed;
Refine state_equiv_trans;
Next +1;
Refine H;Intros;Immed;
Refine H1;Intros;Immed;
Save pair_equiv_trans;

Goal {v1,v2|val}{s1,s2|state}
     (and (equiv v1 v2) (state_equiv s1 s2))->
     (and (equiv v2 v1) (state_equiv s2 s1));
intros ____;
Refine and_elim;
intros;
andI;
Refine equiv_sym H;
Refine state_equiv_sym H1;
Save pair_equiv_sym;

(* Recursion *)
Goal val_env -> (LL|exp) -> val_env -> val_env;
Intros ve el values;
Refine LLrec [_:LL|exp]val_env;
Refine empty_ve;
Intros;
Refine extend_ve (clos b (NIL|exp) (ve_append values ve)) LLih;
Refine el;
Save nonrecextend;

(* recursion *)
[rec_thm:
{ve,ve':val_env}
{el,el':LL|exp}
(Q (length el) (length el')) ->
({ve1,ve1':val_env}
 (Q (ve_len ve1) (ve_len ve1')) ->
 (Q (ve_len ve1) (length el)) ->
 (ve_equiv ve1 ve1') ->
 (ve_equiv (nonrecextend ve el ve1)(nonrecextend ve' el' ve1'))) ->
ve_equiv (recextend ve el) (recextend ve' el')];

[recextend_len: {ve:val_env}{el:LL|exp} Q(ve_len (recextend ve el)) (length el)];

(* bopapp equivalence *)
[bopapp_equiv:{b|bop}{v1,v2|val}{s1,s1',s2,s2'|state}{v1',v2'|val}
(bopapply b v1 s1 v1' s1') ->
(bopapply b v2 s2 v2' s2') ->
(equiv v1 v2) ->
(state_equiv s1 s2) ->
and (equiv v1' v2') (state_equiv s1' s2')];

[append_equiv_thm:
 {ve1,ve1',ve2,ve2':val_env}
 (ve_equiv ve1 ve2) ->
 (ve_equiv ve1' ve2') ->
 (ve_equiv (ve_append ve1 ve1') (ve_append ve2 ve2'))];

[tuple_equiv: {vl,vl':val_env} (ve_equiv vl vl') -> equiv (vtuple vl) (vtuple vl')];

Goal {ve:val_env} ve_equiv ve ve;
Refine vallist_elim1[ve:val_env]ve_equiv ve ve;
Intros;
Immed;
intros;
andI;
Refine equiv_eq;
Refine Q_refl;
Refine cdr_ih;
Save ve_equiv_eq;
