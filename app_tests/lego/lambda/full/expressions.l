(*
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: expressions.l,v $
 * Revision 1.1  1998/08/06 10:36:10  jont
 * new unit
 * Lego test application
 *
 *
 *)
Forget bop;
(* basic operators *)
Inductive [bop:SET]
Constructors
[plusbop:bop]
[subbop:bop]
[assign:bop]
[ref:bop]
[deref:bop];

[dummyBop = plusbop];

(* raw expressions *)
Inductive [exp : SET] [explist : SET]
Constructors
[num:{n:NN}exp]
[var:{v:NN}exp]
[app:{f:exp}{arg:exp}exp]
[fn:{body:exp}exp]
[letrec:{fl:explist}{body:exp}exp]
[bopapp:{b:bop}{arg:exp}exp]
[mktuple:{vl:explist}exp]
[expnil:explist]
[expcons: {car:exp}{cdr:explist}explist];

Goal 
{C_explist:explist->TYPE}
(C_explist expnil)->
({car:exp}{cdr:explist}{cdr_ih:C_explist cdr}C_explist (expcons car cdr))->
{z:explist}C_explist z;
intros;
Refine explist_elim ([_:exp]BB)C_explist;
intros;Refine tt;
intros;Refine tt;
intros;Refine tt;
intros;Refine tt;
intros;Refine tt;
intros;Refine tt;
intros;Refine tt;
Refine H;
intros;Refine H1 car cdr cdr_ih;
Save explist_elim1;

Goal 
{C_exp:exp->TYPE}
({n:NN}C_exp (num n))->
({v:NN}C_exp (var v))->
({f,arg:exp}{f_ih:C_exp f}{arg_ih:C_exp arg}C_exp (app f arg))->
({body:exp}{body_ih:C_exp body}C_exp (fn body))->
({fl:explist}{body:exp}{body_ih:C_exp body}C_exp (letrec fl body))->
({b:bop}{arg:exp}C_exp (bopapp b arg))->
({vl:explist}C_exp (mktuple vl))->
{z:exp}C_exp z;
intros;
Refine exp_elim C_exp [_:explist]BB;
Refine H;
Refine H1;
Refine H2;
Refine H3;
intros;
Refine H4 fl body body_ih;
intros;
Refine H5 b arg;
intros;
Refine H6 vl;
Refine tt;
intros;Refine tt;
Save exp_elim1;

[expLL = LL|exp];

Goal explist->expLL;
Refine explist_elim1([_:explist]expLL);
Refine NIL;
Intros;
Refine CONS car cdr_ih;
Save explist_to_expLL;

Goal expLL -> explist;
Refine LLrec [_:expLL]explist;
Refine expnil;
Intros;
Refine expcons b LLih;
Save expLL_to_explist;

[explist_map [f:exp->exp][el:explist] = (expLL_to_explist (map f (explist_to_expLL el)))];

(* Projection functions *)

Goal exp->NN;
Refine exp_elim1([_:exp]NN);
Intros n;Refine n;
Intros n;Refine n;
Intros;Refine Z;
Intros;Refine Z;
Intros;Refine Z;
Intros;Refine Z;
Intros;Refine Z;
Save exp_num;

Goal exp->exp;
Refine exp_elim1([_:exp]exp);
Intros;Refine num Z;
Intros;Refine num Z;
Intros;Refine f;
Intros;Refine body;
Intros;Refine body;
Intros;Refine arg;
Intros;Refine num Z;
Save exp_exp1;

Goal exp->exp;
Refine exp_elim1([_:exp]exp);
Intros;Refine num Z;
Intros;Refine num Z;
Intros;Refine arg;
Intros;Refine num Z;
Intros;Refine num Z;
Intros;Refine num Z;
Intros;Refine num Z;
Save exp_exp2;

Goal exp->explist;
Refine exp_elim1([_:exp]explist);
Intros;Refine expnil;
Intros;Refine expnil;
Intros;Refine expnil;
Intros;Refine expnil;
Intros;Refine fl;
Intros;Refine expnil;
Intros;Refine vl;
Save exp_explist;

Goal exp->bop;
Refine exp_elim1([_:exp]bop);
Intros;Refine dummyBop;
Intros;Refine dummyBop;
Intros;Refine dummyBop;
Intros;Refine dummyBop;
Intros;Refine dummyBop;
Intros;Refine b;
Intros;Refine dummyBop;
Save exp_bop;

(* Determine if two expressions are of the same syntax class *)

Goal exp->exp->BB;
Refine exp_elim1([_:exp]exp->BB);
Intros _;
Refine exp_elim1([_:exp]BB);
Intros;Refine tt;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros _;
Refine exp_elim1([_:exp]BB);
Intros;Refine ff;
Intros;Refine tt;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros ____;
Refine exp_elim1([_:exp]BB);
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine tt;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros __;
Refine exp_elim1([_:exp]BB);
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine tt;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros ___;
Refine exp_elim1([_:exp]BB);
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine tt;
Intros;Refine ff;
Intros;Refine ff;
Intros __;
Refine exp_elim1([_:exp]BB);
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine tt;
Intros;Refine ff;
Intros _;
Refine exp_elim1([_:exp]BB);
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine ff;
Intros;Refine tt;
Save same_sort;

(* same_sort respects equality *)
Goal {e,e1|exp}(Q e e1)->(is_tt (same_sort e e1));
Refine exp_elim1([e:exp]{e1:exp}(Q e e1)->(is_tt (same_sort e e1)));
Intros;Qrepl (Q_sym H);Refine Q_refl;
Intros;Qrepl (Q_sym H);Refine Q_refl;
Intros;Qrepl (Q_sym H);Refine Q_refl;
Intros;Qrepl (Q_sym H);Refine Q_refl;
Intros;Qrepl (Q_sym H);Refine Q_refl;
Intros;Qrepl (Q_sym H);Refine Q_refl;
Intros;Qrepl (Q_sym H);Refine Q_refl;
Save eq_implies_same_sort;

(* Useful in derivation inductions *)
Goal {e,e1|exp} (Q e e1) -> (is_ff(same_sort e e1)) -> FF;
Intros;
Refine tt_not_ff;
Qrepl (Q_sym H1);
Refine Q_sym;
Refine eq_implies_same_sort;
Immed;
Save ss_lemma;

[el_length [el : explist] = length (explist_to_expLL el)];

(* Now I have to define substition *)

(* lift -- increment the global variable references of an expression *)
(* liftaux -- do this within the context of several (level) lamba expressions *)
Goal {n:NN}{e:exp}{level:NN}exp;
Intros _;
Refine exp_elim([_:exp]NN->exp)([_:explist]NN->explist);
Intros numn level;Refine num numn;
Intros varn level;
Refine tt_or_ff (lt varn level);
Intros;
Refine var varn;
Intros;Refine var (add n varn);
Intros;Refine app (f_ih H) (arg_ih H);
Intros;Refine (fn (body_ih (S H)));
Intros;[newlen = (add (el_length fl) H)];
Refine letrec (fl_ih (S newlen)) (body_ih newlen);
Intros;Refine bopapp b (arg_ih H);
Intros;Refine mktuple (vl_ih H);
Intros;Refine expnil;
Intros;Refine expcons (car_ih H) (cdr_ih H);
Save liftaux;

[explist_liftaux [n:NN][el:explist][m:NN] = explist_map ([e:exp] liftaux n e m) el];

[lift [e:exp][n:NN] = liftaux n e Z];

[explist_liftaux_len_thm: {el:explist}{n,m:NN} Q (el_length el)(el_length (explist_liftaux n el m))];

[letrec_liftaux:
{n,m:NN}{el:explist}{e:exp}
Q(liftaux n (letrec el e) m)
 (letrec (explist_liftaux n el (S (add (el_length el) m)))
         (liftaux n e (add (el_length el) m)))];

[bopapp_liftaux:
{n,m:NN}{b:bop}{e:exp}
Q (liftaux n (bopapp b e) m)
  (bopapp b (liftaux n e m))];

[tuple_liftaux:
{n,m:NN}{el:explist}
Q (liftaux n (mktuple el) m)
  (mktuple (explist_liftaux n el m))];

Goal {n:NN}{l,m|NN}(is_tt (lt m l)) -> Q (liftaux n (var m) l) (var m);
intros;Expand liftaux;Qrepl H;Refine Q_refl;
Save liftaux_thm_lt;

Goal {n:NN}{l,m|NN}(is_ff (lt m l))  -> Q (liftaux n (var m) l) (var (add n m));
intros;Expand liftaux;Qrepl H;Refine Q_refl;
Save liftaux_thm_ge;

(* Substitutions for debruijns *)
Goal {e1:exp}{e2:exp}{n:NN}exp;
Refine exp_elim([e1:exp]{e2:exp}{n:NN}exp)([el:explist]{e2:exp}{n:NN}explist);
Intros m __;Refine num m;
Intros m __;
Refine trich m n;
Intros;Refine var m;
Intros;Refine lift e2 n;
Intros;Refine var (pred m);
Intros;Refine app (f_ih e2 n)(arg_ih e2 n);
Intros;Refine fn (body_ih e2 (S n));
Intros;[newlen=add (el_length fl) n]; Refine letrec (fl_ih e2 (S newlen))(body_ih e2 newlen);
Intros;Refine bopapp b (arg_ih e2 n);
Intros;Refine mktuple (vl_ih e2 n);
Intros;Refine expnil;
Intros;Refine expcons (car_ih e2 n) (cdr_ih e2 n);
Save sub;

[explist_sub [el:explist][e2:exp][n:NN] = explist_map ([e1:exp] sub e1 e2 n) el];

[explist_sub_len_thm :
{el:explist}{e:exp}{n:NN}
Q (el_length (explist_sub el e n))
  (el_length el)];

[letrec_sub:
{el:explist}{e:exp}{e2:exp}{n:NN}
Q(sub (letrec el e) e2 n)
 (letrec (explist_sub el e2 (S (add (el_length el) n)))
         (sub e e2 (add (el_length el) n)))];

[bopapp_sub:
{b:bop}{e:exp}{e2:exp}{n:NN}
Q(sub (bopapp b e) e2 n)
 (bopapp b (sub e e2 n))];


[tuple_sub:
{el:explist}{e2:exp}{n:NN}
Q(sub (mktuple el) e2 n)
 (mktuple (explist_sub el e2 n))];

Goal {n,m|NN}(is_tt (lt n m))->{e:exp}Q (sub (var n) e m) (var n);
intros; Refine lt_trich_ax H;
Save sub_thm_less;

Goal {n,m|NN}(is_tt (neq n m))->{e:exp}Q (sub (var n) e m) (lift e m);
intros; Refine neq_trich_ax H;
Save sub_thm_equal;

Goal {n,m|NN}(is_tt (gt n m))-> {e:exp}Q (sub (var n) e m) (var (pred n));
intros;  Refine gt_trich_ax H;
Save sub_thm_greater;

(* This could be defined as a list utility *)
Goal explist -> (exp->Prop)->Prop;
Refine explist_elim1([_:explist](exp->Prop)->Prop);
intros;Refine TT;
intros;Refine and (H car) (cdr_ih H);
Save forall_explist;
