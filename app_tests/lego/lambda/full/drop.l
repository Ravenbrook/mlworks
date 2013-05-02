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
 * $Log: drop.l,v $
 * Revision 1.1  1998/08/06 10:36:11  jont
 * new unit
 * Lego test application
 *
 *
 *)
Forget deb_occurs;

(* new stuff *)
(* A function to say if a debruijn occurs *)

Goal {e:exp}{n:NN}BB;
Refine exp_elim([e:exp]{n:NN}BB)([el:explist]{n:NN}BB);
intros;Refine ff;
intros n m;
Refine neq n m;
intros;Refine orr (f_ih n) (arg_ih n);
intros;Refine body_ih(S n);
intros;[newlen = add (el_length fl) n];
Refine orr (fl_ih (S newlen)) (body_ih newlen);
intros;Refine arg_ih n;
intros;Refine vl_ih n;
intros;Refine ff;
intros;Refine orr (car_ih n) (cdr_ih n);
Save deb_occurs;

Goal {e:exp}{n:NN}exp;
Refine exp_elim ([_:exp]{n:NN}exp) ([_:explist]{n:NN}explist);
intros;Refine num n;
intros;Refine tt_or_ff (lt v n);
intros;Refine var v;
intros;Refine var (pred v);
intros;Refine app (f_ih n) (arg_ih n);
intros;Refine fn (body_ih (S n));
intros;[newlen = add (el_length fl) n];
Refine letrec (fl_ih (S newlen)) (body_ih newlen);
intros;Refine bopapp b (arg_ih n);
intros;Refine mktuple (vl_ih n);
intros;Refine expnil;
intros;Refine expcons (car_ih n) (cdr_ih n);
Save drop;

Goal {l,m|NN}(is_tt (lt m l)) -> Q (drop (var m) l) (var m);
Intros ___;Normal;Intros;Qrepl H;Refine Q_refl;
Save drop_thm_lt;

Goal {l,m|NN}(is_ff (lt m l))  -> Q (drop (var m) l) (var (pred m));
Intros ___;Normal;Intros;Qrepl H;Refine Q_refl;
Save drop_thm_ge;

[liftaux_drop_thm : {e:exp}{n:NN} (is_ff (deb_occurs e n)) -> Q (liftaux one (drop e n) n) e];
[drop_liftaux_thm : {e:exp}{n:NN} Q (drop (liftaux one e n) n) e];


Goal {e|exp} (is_ff (deb_occurs e Z)) ->
     {x:val}
     {ve1,ve2|val_env}(ve_equiv ve1 ve2)->
     {s1,s2|state}(state_equiv s1 s2)->
     {a,a':val}{s1',s2':state}
     (sem ve1 s1 (drop e Z) a s1') ->
     (sem (extend_ve x ve2) s2 e a' s2')->
     and (equiv a a')(state_equiv s1' s2');
intros _____________;
Qrepl (Q_sym (liftaux_drop_thm e Z H));
Qrepl drop_liftaux_thm (drop e Z) Z;
intros;
Refine lift_lemma H1 H2 (extend_ve x empty_ve) a a' s1' s2' H3 H4;
Save drop_thm;

Goal {ve:val_env}{s:state}{e1,e2:exp}{esafe:safe_no_update e2 ve}
     {nocc:is_ff (deb_occurs e1 Z)}
     {v1,v2:val}{s1,s2:state}
     {eval1: sem ve s (drop e1 Z) v1 s1}
     {eval2: sem ve s (app (fn e1) e2) v2 s2}
     and (equiv v1 v2)(state_equiv s1 s2);
intros;
Refine extract_app eval2;intros ____;Refine and3_elim;intros _;
Refine extract_fn H;intros __;
Qrepl H1;Qrepl H2;intros;
Refine cut (apply_thm H4);intros;
Refine drop_thm;
Refine e1;Refine nocc;Refine s3;Refine ve;Refine ve;Refine ve_equiv_eq;
Refine s;Refine s;Refine state_equiv_eq;Refine Q_refl;
Refine eval1;
Qrepl esafe H3;
Refine H5;
Save unused_elim_thm;
