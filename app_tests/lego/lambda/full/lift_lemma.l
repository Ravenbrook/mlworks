(*
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: lift_lemma.l,v $
 * Revision 1.1  1998/08/06 10:36:10  jont
 * new unit
 * Lego test application
 *
 *
 *)
Goal {ve1,ve2|val_env}{veq:ve_equiv ve1 ve2}
     {ve|val_env}
     {e|exp}
     {ve1',ve2'|val_env}
     {veq': ve_equiv ve1' ve2'}
     {s1,s2|state}
     {a,a'|val}{s1',s2'|state}
     {eval1: sem (ve_append ve1' ve1) s1 e a s1'}
     {eval2: sem (ve_append ve2' (ve_append ve ve2)) s2 (liftaux (ve_len ve) e (ve_len ve2')) a' s2'}
     {seq: state_equiv s1 s2}
     and (equiv a a')(state_equiv s1' s2');

Intros ____;
[lift_prop [e:exp] =
     {ve1',ve2'|val_env}
     {veq':ve_equiv ve1' ve2'}
     {s1,s2|state}
     {a,a'|val}{s1',s2'|state}
     {eval1:sem (ve_append ve1' ve1) s1 e a s1'}
     {eval2:sem (ve_append ve2' (ve_append ve ve2)) s2 (liftaux (ve_len ve) e (ve_len ve2')) a' s2'}
     {seq:state_equiv s1 s2}
     and (equiv a a')(state_equiv s1' s2')];

Refine exp_elim lift_prop ([el|explist](forall_explist el ([e:exp]lift_prop e)));

(* Numeric case *)
Expand lift_prop;intros;
Refine extract_num eval1;intros;
Refine extract_num eval2;intros;
Qrepl H;Qrepl H1;Qrepl H2;Qrepl H3;
andI;
Refine equiv_eq;
Refine Q_refl;
Refine seq;

(* Variable case *)
intros;
Expand lift_prop;
Intros __________;
Refine extract_var eval1;
Intros __;
Qrepl H;Qrepl H1;
Refine cut (equiv_len_thm veq');
intros eq_len;
Refine tt_or_ff (lt v (ve_len ve2'));
(* lt case *)
intros _;
Qrepl liftaux_thm_lt (ve_len ve) H2;
intros;
Refine extract_var eval2;
intros;
Qrepl H3;Qrepl H4;
andI;
Refine equiv_trans;
Next +1;
Refine equiv_eq;
Refine append_lookup_thm_less;
Qrepl eq_len;
Refine H2;
Refine equiv_trans;
Next +2;Refine equiv_eq;Refine Q_sym;
Refine append_lookup_thm_less;
Refine H2;
Refine ve_equiv_thm veq';
Refine seq;
(* ge case *)
intros _;
Qrepl liftaux_thm_ge (ve_len ve) H2;intros;
Refine extract_var eval2;intros;
Qrepl H3;Qrepl H4;andI;
Refine equiv_trans;Next +1;Refine equiv_eq;
Refine append_lookup_thm_ge;
Qrepl eq_len;
Qrepl ge_thm v (ve_len ve2');
Qrepl H2; Refine Q_refl;
Refine equiv_trans;Next +2;Refine equiv_eq;
Refine Q_sym;Qrepl append_assoc ve2' ve ve2;
Refine append_lookup_thm_ge;
Qrepl ve_append_len_thm ve2' ve;
Refine Q_trans;Next +1;
Qrepl addCommute v (ve_len ve);
Refine ge_thm;
Qrepl Q_sym (add_lt_distrib v (ve_len ve2') (ve_len ve));
Qrepl H2;
Refine Q_refl;
Qrepl ve_append_len_thm ve2' ve;
Qrepl eq_len;
Qrepl addCommute v (ve_len ve);
Qrepl Q_sym (add_sbt_distrib v (ve_len ve2') (ve_len ve));
Refine ve_equiv_thm veq;
Refine seq;
(* Applications *)
intros;Expand lift_prop;intros __________;
Claim Q (liftaux (ve_len ve) (app f arg) (ve_len ve2')) (app (liftaux (ve_len ve) f (ve_len ve2')) (liftaux (ve_len ve) arg (ve_len ve2')));
Qrepl ?+1;Next +1;Refine Q_refl;
intros;
Refine extract_app eval1;
Intros ____;
Refine and3_elim;
intros;
Refine extract_app eval2;intros ____;Refine and3_elim;intros;
Refine equiv_app H2 H5;
Claim and ? ?;Next +1;Refine and1 ?+5;
Next +1;Refine and2 ?+3;
Next +1;
Refine arg_ih veq' H1 H4;
Claim and ? ?;Refine and2 ?+4;Refine and1 ?+2;
Refine f_ih veq' H H3;
Refine seq;

(* Closures *)
intros;
Expand lift_prop;
intros __________;
Claim Q (liftaux (ve_len ve) (fn body) (ve_len ve2'))(fn (liftaux (ve_len ve) body (S (ve_len ve2'))));
Qrepl ?+1;Next +1;Refine Q_refl;
intros;
Refine extract_fn eval1;intros;
Refine extract_fn eval2;intros;
Qrepl H;Qrepl H1;Qrepl H2;Qrepl H3;
andI;
Refine equiv_intro;intros;
Refine body_ih;
Refine extend_ve x1 ve1';
Refine extend_ve x2 ve2';
andI;
Refine H6;
Refine veq';
Refine s11;Refine s21;
Qrepl append_thm x1 ve1' ve1;
Refine apply_thm H4;
Qrepl append_thm x2 ve2' (ve_append ve ve2);
Refine apply_thm H5;
Refine H7;
Refine seq;

(* Letrec case *)
intros;Expand lift_prop;
Intros __________;
Qrepl letrec_liftaux (ve_len ve) (ve_len ve2') fl body;
intros;
Refine body_ih;
Refine ve_append ? ?;
Next +6;
Qrepl Q_sym (append_assoc ?+1 ?+2 ve1);
Refine extract_letrec eval1;
Refine ve_append ? ?;
Next +4;
Qrepl Q_sym (append_assoc ?+1 ?+2 (ve_append ve ve2));
Refine +2 ve2';
Refine +3 s2;
Claim Q (ve_len (ve_append ?+1 ve2')) (add (el_length fl) (ve_len ve2'));
Qrepl ?+4;
Refine extract_letrec eval2;
Refine append_equiv_thm;
Refine rec_thm;
Refine explist_liftaux_len_thm;
intros;
Refine explist_elim1 [el:explist](forall_explist el ([e:exp]lift_prop e))->
ve_equiv 
(nonrecextend (ve_append ve1' ve1) 
	      (explist_to_expLL el)
	      ve11)
(nonrecextend (ve_append ve2' (ve_append ve ve2)) 
	      (explist_to_expLL (explist_liftaux (ve_len ve) el (S (add (el_length fl) (ve_len ve2')))))
	      ve1'1);
intros;
Refine empty_ve_equiv;
intros;
andI;
Next +1;
Refine cdr_ih;
Refine and2 H3;
Refine equiv_intro;
intros;
Refine and1 H3;
Refine extend_ve x1 (ve_append ve11 ve1');
Refine extend_ve x2 (ve_append ve1'1 ve2');
Refine extend_equiv;
Refine append_equiv_thm;
Refine H2;Refine veq';Refine H6;
Refine s11;Refine s21;
Qrepl append_thm  x1 (ve_append ve11 ve1') ve1;
Qrepl Q_sym (append_assoc ve11 ve1' ve1);
Refine apply_thm H4;
Qrepl append_thm x2 (ve_append ve1'1 ve2')(ve_append ve ve2);
Qrepl Q_sym (append_assoc ve1'1 ve2'(ve_append ve ve2));
Claim Q (ve_len (extend_ve x2 (ve_append ve1'1 ve2'))) (S (add (el_length fl) (ve_len ve2')));
Qrepl ?+2;
Refine apply_thm H5;
Refine H7;
Refine Q_resp S;
Refine Q_trans;
Next +1;
Refine ve_append_len_thm;
Qrepl Q_sym H;
Qrepl H1;
Refine Q_refl;
Refine fl_ih;
Refine veq';
Refine seq;
Refine Q_trans;
Next +1;
Refine ve_append_len_thm;
Qrepl recextend_len (ve_append ve2' (ve_append ve ve2)) (explist_to_expLL (explist_liftaux (ve_len ve) fl (S (add (el_length fl) (ve_len ve2')))));
Qrepl Q_sym (explist_liftaux_len_thm fl (ve_len ve) (S (add (el_length fl) (ve_len ve2'))));
Refine Q_refl;

(* Bopapp case *)
intros;
Expand lift_prop;
Intros __________;
Qrepl bopapp_liftaux (ve_len ve) (ve_len ve2') b arg ;
intros;
Refine extract_bopapp eval1;intros __;Refine and_elim;intros;
Refine extract_bopapp eval2;intros __;Refine and_elim;intros;
Refine bopapp_equiv H1 H3;
Claim and ? ?;Refine and1 ?+4;Refine and2 ?+2;
Refine arg_ih veq' H H2;
Refine seq;

(* Tuple case *)
intros;
Expand lift_prop;
Intros __________;
Qrepl tuple_liftaux (ve_len ve) (ve_len ve2') vl;
intros;
Refine extract_tuple eval1;
intros _;
Refine and_elim;
intros;
Refine extract_tuple eval2;
intros _;
Refine and_elim;
intros;
Qrepl H;Qrepl H2;
andI;
Refine tuple_equiv;
Claim and (ve_equiv t t1)(state_equiv s1' s2');
Refine ?+2;Intros;Immed;
Refine ?+1;Intros;Immed;
Refine explist_elim1 [el:explist](forall_explist el ([e:exp]lift_prop e)) ->
{s1,s1',s2,s2':state}
{vl1,vl2:val_env}
(state_equiv s1 s2) ->
(sem_list (ve_append ve1' ve1) s1 el vl1 s1') ->
(sem_list (ve_append ve2' (ve_append ve ve2)) s2 (explist_liftaux (ve_len ve) el (ve_len ve2')) vl2 s2') ->
and (ve_equiv vl1 vl2) (state_equiv s1' s2');
intros;
Qrepl sem_list_nil_vl H6;
Qrepl sem_list_nil_vl H7;
Qrepl Q_sym (sem_list_nil_state H6);
Qrepl Q_sym (sem_list_nil_state H7);
andI;
Refine empty_ve_equiv;
Refine H5;
intros;
Refine extract_list H6;
intros ___;
Refine and3_elim;
intros;
Refine extract_list H7;
intros ___;
Refine and3_elim;
intros;
Qrepl H8;Qrepl H11;
andI;
Refine extend_equiv;
Claim and ? ?;Refine and1 ?+5;Refine +1 and2 ?+3;
Next +1;
Refine cdr_ih;
Refine and2 H4;
Refine +3 H10;
Refine +2 H13;
Claim and ? ?;Refine and2 ?+4;Refine and1 ?+2;
Refine and1 H4;
Refine +5 H9;
Refine +3 H12;
Refine veq';
Refine H5;
Refine vl;Refine vl_ih;Refine s1;Refine s2;Refine seq;
Refine H1;
Refine H3;

(* nil case *)
Refine true;

(* cons case *)
intros;
andI;
intros;
Refine car_ih;
Refine cdr_ih;
Save liftaux_lemma;

Goal {e|exp}
     {ve1,ve2|val_env}(ve_equiv ve1 ve2)->
     {s1,s2|state}(state_equiv s1 s2)->
     {ve:val_env}{a,a':val}{s1',s2':state}
     (sem ve1 s1 e a s1')->
     (sem (ve_append ve ve2) s2 (lift e (ve_len ve)) a' s2')->
     and (equiv a a')(state_equiv s1' s2');
intros;
Refine liftaux_lemma H empty_ve_equiv H2 H3 H1;
Save lift_lemma;
