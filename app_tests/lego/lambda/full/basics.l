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
 * $Log: basics.l,v $
 * Revision 1.1  1998/08/06 10:36:10  jont
 * new unit
 * Lego test application
 *
 *
 *)
Init XCC; 

(******* ignore this for the time being
Module basics;
********)
Logic;
Forget Q;
[TYPE=Type(0)];
[SET=Prop];
(*** Inductive equality ***)

Configure Qrepl Q Q_subst Q_sym;

[A|TYPE];
$[Q:A->A->Prop];
$[Q_refl:{a:A}Q a a];
$[QRec:{a|A}
        {P:{x:A}(Q a x)->Prop}
        {QR:P a (Q_refl a)}
        {b|A}{p:Q a b}P b p];
[[a:A]
 [P:{b:A}(Q a b)->Prop]
 [d:P a (Q_refl a)]
  QRec P d (Q_refl a) ==> d];

Goal {a,b|A}(Q a b)->(Q b a);
intros;
Refine QRec ([b:A][p:Q a b]Q b a);
Refine Q_refl; Immed;
Save Q_sym;

Goal {a,b,c|A}(Q a b)->(Q b c)->(Q a c);
intros;
Refine QRec ([y:A][p:Q a y](Q y c)->Q a c) ? H H1;
intros; Immed;
Save Q_trans;

Goal {a,b|A}(Q a b)->{P:A->Prop}(P a)->P b;
intros;
Refine QRec ([y:A][p:Q a y]P y);
Immed;
Save Q_subst;

Discharge A;

Goal {T,S|TYPE}{f:T->S}{t,u|T}(Q t u)->Q (f t) (f u);
intros;
Refine Q_subst H ([x:T]Q (f t) (f x));
Refine Q_refl;
Save Q_resp;


(* some more preliminaries *)
[TT = {A:Prop}A->A];
[FF = {A:Prop}A];
[true = [A:Prop][a:A]a : TT];

Goal {A,B|Prop}(A->B)->{X|Prop}(B->X)->A->X;
intros; Refine H1 (H H2);
Save Contrapos;

[ExIn = [T|TYPE][wit:T][P:T->Prop]ExIntro P|wit];

[T,S,U,V,W,X|TYPE]
[Ex2 [P:T->S->Prop] : Prop =
    {B:Prop}({t|T}{s|S}(P t s)->B)->B];
[Ex2In [t:T][s:S][P:T->S->Prop][p:P t s] : Ex2 P =
    [B:Prop][gen:{t|T}{s|S}(P t s)->B]gen p];
[Ex3 [P:T->S->U->Prop] : Prop =
    {B:Prop}({t|T}{s|S}{u|U}(P t s u)->B)->B];
[Ex3In [t:T][s:S][u:U][P:T->S->U->Prop][p:P t s u] : Ex3 P =
    [B:Prop][gen:{t|T}{s|S}{u|U}(P t s u)->B]gen p];
[Ex4 [P:T->S->U->V->Prop] : Prop =
    {B:Prop}({t|T}{s|S}{u|U}{v|V}(P t s u v)->B)->B];
[Ex4In [t:T][s:S][u:U][v:V][P:T->S->U->V->Prop][p:P t s u v] : Ex4 P =
    [B:Prop][gen:{t|T}{s|S}{u|U}{v|V}(P t s u v)->B]gen p];
[Ex5 [P:T->S->U->V->W->Prop] : Prop =
    {B:Prop}({t|T}{s|S}{u|U}{v|V}{w|W}(P t s u v w)->B)->B];
[Ex5In [t:T][s:S][u:U][v:V][w:W][P:T->S->U->V->W->Prop][p:P t s u v w] : Ex5 P =
    [B:Prop][gen:{t|T}{s|S}{u|U}{v|V}{w|W}(P t s u v w)->B]gen p];
[Ex6 [P:T->S->U->V->W->X->Prop] : Prop =
    {B:Prop}({t|T}{s|S}{u|U}{v|V}{w|W}{x|X}(P t s u v w x)->B)->B];
[Ex6In [t:T][s:S][u:U][v:V][w:W][x:X][P:T->S->U->V->W->X->Prop][p:P t s u v w x]
      : Ex6 P
      = [B:Prop][gen:{t|T}{s|S}{u|U}{v|V}{w|W}{x|X}(P t s u v w x)->B]gen p];
[Q_resp2 [f:T->U->S][t,t'|T][u,u':U][Qtt':Q t t'][Quu':Q u u']
   : Q (f t u) (f t' u')
   = Q_subst Qtt' ([x:T]Q (f t u) (f x u'))
                  (Q_subst Quu' ([y:U]Q (f t u) (f t y))
                                (Q_refl (f t u)))];
Discharge T;

[A,B,C,D,E,F,G|Prop][a:A][b:B][c:C][d:D][e:E][f:F][g:G];

[and4 [A,B,C,D:Prop] = {chi|Prop}{premise:A->B->C->D->chi}chi];
[pair4 = [chi|Prop][premise:A->B->C->D->chi](premise a b c d):and4 A B C D];
[and4_out1 [conj:and4 A B C D] = conj|A [a:A][_:B][_:C][_:D]a:A];
[and4_out2 [conj:and4 A B C D] = conj|B [_:A][b:B][_:C][_:D]b:B];
[and4_out3 [conj:and4 A B C D] = conj|C [_:A][_:B][c:C][_:D]c:C];
[and4_out4 [conj:and4 A B C D] = conj|D [_:A][_:B][_:C][d:D]d:D];

[and5 [A,B,C,D,E:Prop] = {chi|Prop}{premise:A->B->C->D->E->chi}chi];
[pair5 = [chi|Prop][premise:A->B->C->D->E->chi](premise a b c d e):and5 A B C D E];
[and5_out1 [conj:and5 A B C D E] = conj|A [a:A][_:B][_:C][_:D][_:E]a:A];
[and5_out2 [conj:and5 A B C D E] = conj|B [_:A][b:B][_:C][_:D][_:E]b:B];
[and5_out3 [conj:and5 A B C D E] = conj|C [_:A][_:B][c:C][_:D][_:E]c:C];
[and5_out4 [conj:and5 A B C D E] = conj|D [_:A][_:B][_:C][d:D][_:E]d:D];
[and5_out5 [conj:and5 A B C D E] = conj|E [_:A][_:B][_:C][_:D][e:E]e:E];

[and6 [A,B,C,D,E,F:Prop] = {chi|Prop}{premise:A->B->C->D->E->F->chi}chi];
[pair6 = [chi|Prop][premise:A->B->C->D->E->F->chi](premise a b c d e f)
       : and6 A B C D E F];
[and6_out1 [conj:and6 A B C D E F] = conj|A [a:A][_:B][_:C][_:D][_:E][_:F]a:A];
[and6_out2 [conj:and6 A B C D E F] = conj|B [_:A][b:B][_:C][_:D][_:E][_:F]b:B];
[and6_out3 [conj:and6 A B C D E F] = conj|C [_:A][_:B][c:C][_:D][_:E][_:F]c:C];
[and6_out4 [conj:and6 A B C D E F] = conj|D [_:A][_:B][_:C][d:D][_:E][_:F]d:D];
[and6_out5 [conj:and6 A B C D E F] = conj|E [_:A][_:B][_:C][_:D][e:E][_:F]e:E];
[and6_out6 [conj:and6 A B C D E F] = conj|F [_:A][_:B][_:C][_:D][_:E][f:F]f:F];

[and7 [A,B,C,D,E,F,G:Prop] = {chi|Prop}{premise:A->B->C->D->E->F->G->chi}chi];
[pair7 = [chi|Prop][premise:A->B->C->D->E->F->G->chi](premise a b c d e f g)
       : and7 A B C D E F G];
[and7_out1 [conj:and7 A B C D E F G] = conj|A [a:A][_:B][_:C][_:D][_:E][_:F][_:G]a:A];
[and7_out2 [conj:and7 A B C D E F G] = conj|B [_:A][b:B][_:C][_:D][_:E][_:F][_:G]b:B];
[and7_out3 [conj:and7 A B C D E F G] = conj|C [_:A][_:B][c:C][_:D][_:E][_:F][_:G]c:C];
[and7_out4 [conj:and7 A B C D E F G] = conj|D [_:A][_:B][_:C][d:D][_:E][_:F][_:G]d:D];
[and7_out5 [conj:and7 A B C D E F G] = conj|E [_:A][_:B][_:C][_:D][e:E][_:F][_:G]e:E];
[and7_out6 [conj:and7 A B C D E F G] = conj|F [_:A][_:B][_:C][_:D][_:E][f:F][_:G]f:F];
[and7_out7 [conj:and7 A B C D E F G] = conj|G [_:A][_:B][_:C][_:D][_:E][_:F][g:G]g:G];

Discharge A;

(* contrapositive *)
Goal {A,B|Prop}(A->B)->(not B)->(not A);
Intros _____; Refine H1; Refine H; Refine H2;
Save contrapos;

(* Bool *)
$[BB:TYPE];
$[tt:BB];
$[ff:BB];
$[Brec:{C:BB->TYPE}{d:C tt}{e:C ff}{b:BB}C b];
[[C:BB->Prop][d:C tt][e:C ff]
    Brec C d e tt ==> d
 || Brec C d e ff ==> e];

[is_tt [b:BB] = Q b tt];
[is_ff [b:BB] = Q b ff];


[if [a:BB][D|TYPE][d,e:D] = Brec ([_:BB]D) d e a];
[andd [a,b:BB] = if a b ff];
[orr [a,b:BB] = if a a b];
[nott [a:BB] = if a ff tt];
[impp [a,b:BB] = if b tt (if a ff tt)];


Goal {C:BB->BB->TYPE}
     (C tt tt)->(C tt ff)->(C ff tt)->(C ff ff)->
     {x,y:BB}C x y;
intros _____; Refine Brec [x:BB]{y:BB}C x y;
Refine Brec [y:BB]C tt y; Immed;
Refine Brec [y:BB]C ff y; Immed;
Save BB_double_induct;

[BBeq : BB->BB->BB = BB_double_induct ([_,_:BB]BB) tt ff ff tt];

Goal {b:BB}is_tt (BBeq b b);
Refine Brec [b:BB]is_tt (BBeq b b);
Refine Q_refl; Refine Q_refl;
Save BBeq_refl;

Goal {b,c|BB}(is_tt (BBeq b c))->Q b c;
Refine BB_double_induct [b,c:BB](is_tt (BBeq b c))->Q b c;
intros; Refine Q_refl;
intros; Refine Q_sym; Immed;
intros; Immed;
intros; Refine Q_refl;
Save BBeq_subst;

[tt_not_ff: not (Q tt ff)];

Goal {b:BB}or (is_tt b) (is_ff b);
Refine Brec [b:BB]or (is_tt b) (is_ff b);
Refine inl; Refine Q_refl;
Refine inr; Refine Q_refl;
Save tt_or_ff;

Goal {b:BB}iff (is_tt b) (not (is_ff b));
intros; Refine pair;
intros h; Qrepl h; Refine tt_not_ff;
intros h; Refine tt_or_ff b; intros; Immed; intros; Refine h; Immed;
Save is_tt_isnot_ff;

Goal {x:BB}{A|TYPE}{a:A}Q (if x a a) a;
intros; Refine Brec [x:BB]Q (if x a a) a;
Refine Q_refl;
intros; Refine Q_refl;
Save triv_if;

Goal {A|TYPE}{a,b,c|A}{x|BB}(Q (if x a b) c)->or (Q a c) (Q b c);
intros ____;
Refine Brec [x|BB](Q (if x a b) c)->or (Q a c) (Q b c);
intros; Refine inl; Immed;
intros; Refine inr; Immed;
Save if_character;

Goal {A|TYPE}{a,b,a',b'|A}(Q a a')->(Q b b')->
                   {x:BB}Q (if x a b) (if x a' b');
intros; Refine tt_or_ff x;
intros ttx; Qrepl ttx; Expand if; Refine H;
intros ffx; Qrepl ffx; Expand if; Refine H1;
Save Q_if_triv;

(* moving inside if *)
Goal {A,B|TYPE}{f:A->B}{a,b:A}{x:BB}Q (f (if x a b)) (if x (f a) (f b));
intros; Refine tt_or_ff x;
intros ttx; Qrepl ttx; Refine Q_refl;
intros ffx; Qrepl ffx; Refine Q_refl;
Save if_inside;

Goal {A|TYPE}{a,b,c,d:A}{x,y:BB}Q (if x (if y a b) (if y c d))
                                  (if y (if x a c) (if x b d));
intros; Refine tt_or_ff x;
intros ttx; Qrepl ttx; Refine Q_refl;
intros ffx; Qrepl ffx; Refine Q_refl;
Save middle_four_if;

Goal {A|TYPE}{a,b,c:A}{x:BB}Q (if x (if x a b) c) (if x a c);
intros; Refine tt_or_ff x;
intros ttx; Qrepl ttx; Refine Q_refl;
intros ffx; Qrepl ffx; Refine Q_refl;
Save reduce_if_left;

Goal {A|TYPE}{a,b,c:A}{x:BB}Q (if x a (if x b c)) (if x a c);
intros; Refine tt_or_ff x;
intros ttx; Qrepl ttx; Refine Q_refl;
intros ffx; Qrepl ffx; Refine Q_refl;
Save reduce_if_right;

Goal {a,b:BB}iff (is_tt (andd a b)) (and (is_tt a) (is_tt b));
intros; Refine pair;
intros h; Refine tt_or_ff a; intros att; Refine tt_or_ff b;
intros btt; Refine pair att btt;
intros bff; Refine tt_not_ff; Qrepl Q_sym h;
    Qrepl att; Qrepl bff; Refine Q_refl;
intros aff; Refine tt_not_ff; Qrepl Q_sym h; Qrepl aff; Refine Q_refl;
intros attbtt; Qrepl fst attbtt; Qrepl snd attbtt; Refine Q_refl;
Save andd_character;

Goal {a:BB}Q (andd a a) a;
intros; Refine tt_or_ff a;
intros tta; Qrepl tta; Refine Q_refl;
intros ffa; Qrepl ffa; Refine Q_refl;
Save triv_and;

Goal {b:BB}iff (is_tt (nott b)) (not (is_tt b));
intros; Refine pair;
Intros h g; Refine tt_not_ff; Qrepl Q_sym h; Qrepl g; Refine Q_refl;
intros notbtt; Refine tt_or_ff b;
intros; Refine notbtt; Immed;
intros bff; Qrepl bff; Refine Q_refl;
Save nott_character;

Goal {b:BB}iff (is_tt (nott b)) (is_ff b);
Refine Brec [b:BB]iff (is_tt (nott b)) (is_ff b);
Refine pair; intros; Refine Q_sym H; intros; Refine Q_sym H;
Refine pair; intros; Refine Q_refl; intros; Refine Q_refl;
Save nott_negates_tt;

Goal {a,b|BB}((is_tt a)->(is_tt b))->(is_ff b)->(is_ff a);
Expand is_tt is_ff;
Refine BB_double_induct [a,b|BB]((Q a tt)->Q b tt)->(Q b ff)->Q a ff;
intros; Immed;
intros h j; Refine Q_sym (h (Q_refl tt));
intros; Refine Q_refl;
intros; Refine Q_refl;
Save B_contrapos;

Goal {a,b|BB}((is_ff a)->(is_ff b))->(is_tt b)->(is_tt a);
Expand is_tt is_ff;
Refine BB_double_induct [a,b|BB]((Q a ff)->Q b ff)->(Q b tt)->Q a tt;
intros; Immed;
intros; Refine Q_refl;
intros h j; Refine Q_sym (h (Q_refl ff));
intros; Immed;
Save contrapos_B;

Goal {a,b:BB}iff (is_tt (orr a b)) (or (is_tt a) (is_tt b));
intros; Refine pair;
intros orrab; Refine tt_or_ff a; intros att; Refine inl att;
intros aff; Refine inr;  Expand is_tt;
Qrepl Q_sym orrab; Qrepl aff; Refine Q_refl;
intros orab; Refine orab;
intros att; Expand is_tt; Qrepl att; Refine Q_refl;
intros btt; Expand is_tt; Qrepl btt; Refine tt_or_ff a;
intros att; Expand is_tt; Qrepl att; Refine Q_refl;
intros aff; Expand is_tt; Qrepl aff; Refine Q_refl;
Save orr_character;

Goal {a:BB}Q (orr a a) a;
intros; Refine tt_or_ff a;
intros tta; Qrepl tta; Refine Q_refl;
intros ffa; Qrepl ffa; Refine Q_refl;
Save triv_orr;

Goal {a:BB}Q (orr a ff) a;
Refine Brec [a:BB]Q (orr a ff) a; Refine Q_refl; Refine Q_refl;
Save ff_orr_unit;

Goal {a,b,c:BB}Q (orr (orr a b) c) (orr a (orr b c));
intros;
Refine tt_or_ff a;
intros tta; Qrepl tta; Refine Q_refl;
intros ffa; Qrepl ffa; Refine Q_refl;
Save orr_associates;

Goal {a,b:BB}Q (orr a b) (orr b a);
intros;
Refine tt_or_ff a;
intros ah; Qrepl ah;
Refine tt_or_ff b;
intros bh; Qrepl bh; Refine Q_refl;
intros bh; Qrepl bh; Refine Q_refl;
intros ah; Qrepl ah;
Refine tt_or_ff b;
intros bh; Qrepl bh; Refine Q_refl;
intros bh; Qrepl bh; Refine Q_refl;
Save orr_commutes;

(* deMorgan laws *)
Goal {a,b:BB}iff (is_ff (orr a b)) (and (is_ff a) (is_ff b));
intros; Refine pair;
intros hyp; Refine pair;
Refine tt_or_ff a; intros tta; Refine tt_not_ff;
Qrepl Q_sym hyp; Qrepl tta; Refine Q_refl;
intros; Immed;
Refine tt_or_ff b; intros ttb; Refine tt_not_ff;
Qrepl Q_sym hyp; Qrepl orr_commutes a b; Qrepl ttb; Refine Q_refl;
intros; Immed;
intros g; Qrepl fst g; Qrepl snd g; Refine Q_refl;
Save deMorgan;

(* proof by contradiction *)
Goal {a|BB}(is_tt a)->(is_ff a)->{A:Prop}A;
intros; Refine tt_not_ff; Qrepl Q_sym H; Qrepl Q_sym H1; Refine Q_refl;
Save B_contradiction;

(**)
(* Naturals *)
$[NN:TYPE]
$[Z:NN]
$[S:NN->NN]
$[Nrec:{C:NN->TYPE}{Nbase:C Z}{Nstep:{x:NN}{Nih:C x}C (S x)}{a:NN}C a];
[[C:NN->TYPE]
 [d:C Z]
 [e:{x:NN}(C x)->C (S x)]
 [a:NN]
   Nrec C d e Z ==> d
|| Nrec C d e (S a) ==> e a (Nrec C d e a)];
[Nrec_on [a:NN][C:NN->TYPE][Nbase:C Z][Nstep:{x:NN}{Nih:C x}C (S x)]
         = Nrec C Nbase Nstep a];
Freeze Nrec_on;
[one = S Z];
[two = S one];
[neq : NN->NN->BB
     = Nrec ([_:NN]NN->BB)
            (Nrec ([_:NN]BB) tt ([_:NN][_:BB]ff))
            ([_:NN][rest:NN->BB]Nrec ([_:NN]BB)
                                     ff
                                     ([y:NN][_:BB]rest y))];
[add [n,m:NN] : NN = Nrec ([_:NN]NN) m ([_,x:NN]S x) n];
[pred : NN->NN = Nrec ([_:NN]NN) Z [x,_:NN]x];
[sbt [n:NN] : NN->NN = Nrec ([_:NN]NN) n ([_,x:NN]pred x)];
[ifz [A|TYPE][x:NN][a,b:A] : A = Nrec ([_:NN]A) a ([_:NN][_:A]b) x];
(* we use Z for true and S for false *)
[Nlt [i,j:NN] = sbt (S i) j];
[Nle [i,j:NN] = sbt i j];
[Neq [i,j:NN] = add (sbt i j) (sbt j i)];

Goal {C:NN->NN->TYPE}
     (C Z Z)->
     ({y:NN}(C Z y)->(C Z (S y)))->
     ({x:NN}({y:NN}C x y)->C (S x) Z)->
     ({x:NN}({y:NN}C x y)->{y:NN}(C (S x) y)->C (S x) (S y))->
     {x,y:NN}C x y;
intros C bb_step bs_step sb_step ss_step;
Refine Nrec [x:NN]{y:NN}C x y; Refine Nrec (C Z); Immed;
intros x h; Refine Nrec (C (S x));
Refine sb_step x h; Refine ss_step x h;
Save double_induct;

[Q_resp_S [x,y|NN][h:Q x y] : Q (S x) (S y) = Q_resp S h];
[Q_resp_pred [x,y|NN][h:Q x y] : Q (pred x) (pred y) = Q_resp pred h];
[S_injective [x,y|NN][h:Q (S x) (S y)] : Q x y = Q_resp_pred h];

[Z_not_S: {n:NN}not (Q Z (S n))];

Goal {n:NN}not (Q n (S n));
Refine Nrec [n:NN]not (Q n (S n));
Refine Z_not_S;
Intros x ih hyp; Refine ih; Refine S_injective; Immed;
Save n_not_Sn;

[is_S [n:NN] = Q n (S (pred n))];

Goal {n:NN}or (Q n Z) (is_S n);
Refine Nrec ([n:NN]or (Q n Z) (is_S n));
Refine inl; Refine Q_refl;
intros; Refine inr; Refine Q_refl;
Save ZorS;

(**)
(* add *)
Goal {n:NN}Q (add n Z) n;
Refine Nrec [n:NN]Q (add n Z) n;
Refine Q_refl;
intros n ih; Refine Q_resp_S ih;
Save addZ;

Goal {m,n:NN}Q (add n (S m)) (S (add n m));
intros m;
Refine Nrec ([n:NN]Q (add n (S m)) (S (add n m)));
Refine Q_refl;
intros x ih; Refine Q_resp_S ih;
Save addS;

[addSubstL [a,b,y|NN][h:Q a b] : Q (add a y) (add b y) =
      Q_resp ([x:NN](add x y)) h];
[addSubstR [a,b,y|NN][h:Q a b] : Q (add y a) (add y b) =
      Q_resp ([x:NN](add y x)) h];

Goal {m,k,n:NN}Q (add (add n m) k) (add n (add m k));
intros m k;
Refine Nrec [n:NN]Q (add (add n m) k) (add n ?);
Refine Q_refl;
intros x ih; Refine Q_resp_S ih;
Save addAssocR;

Goal {n,m:NN}Q (add m n) (add n m);
intros n;
Refine Nrec [m:NN]Q (add m n) (add n m);
Refine Q_sym (addZ n);
intros x ih;
Refine Q_trans; Refine S (add n x); Refine Q_resp_S ih;
Qrepl addS x n; Refine Q_refl;
Save addCommute;

Goal {n,m|NN}(Q (add n m) Z)->and (Q n Z) (Q m Z);
intros n;
Refine Nrec [m|NN](Q (add n m) Z)->and (Q n Z) (Q m Z);
intros; Refine pair; Refine Q_trans (Q_sym (addZ n)) H; Refine Q_refl;
intros; Refine Z_not_S (add n x); Qrepl (Q_sym (addS x n)); Refine Q_sym H;
Save add_strict;

Goal {i,j,k:NN}(Q (add i j) (add i k))->Q j k;
Refine Nrec [i:NN]{j,k:NN}(Q (add i j) (add i k))->Q j k;
intros;Immed;
intros;Refine Nih;Refine S_injective;Immed;
Save cancel_add;

(**)
(* subtract *)

Goal {x,y:NN}Q (sbt x (S y)) (sbt (pred x) y);
intros x;
Refine Nrec [y:NN]Q (sbt x (S y)) (sbt (pred x) y);
intros; Refine Q_refl;
intros x ih;
Refine Q_resp_pred; Immed;
Save sbt_S_pred;

Goal {x,y:NN}Q (sbt (S x) (S y)) (sbt x y);
intros; Qrepl sbt_S_pred (S x) y; Refine Q_refl;
Save sbt_respect_S;

Goal {x:NN}Q (sbt x x) Z;
Refine Nrec [x:NN]Q (sbt x x) Z;
Refine Q_refl;
intros x ih; Qrepl sbt_S_pred (S x) x; Immed;
Save sbt_x_x_eq_z;

Goal {x:NN}Q (sbt Z x) Z;
Refine Nrec [x:NN]Q (sbt Z x) Z;
Refine Q_refl;
intros x ih; Qrepl sbt_S_pred Z x; Immed;
Save sbt_Z_x_eq_Z;

Goal {m,n,t|NN}(Q (sbt n m) (S t))->Q (sbt (S n) m) (S (sbt n m));
Refine double_induct [m,n:NN]{t:NN}(Q (sbt n m) (S t))->
                                   Q (sbt (S n) m) (S (sbt n m));
intros; Refine Q_refl;
intros; Refine Q_refl;
intros; Refine Z_not_S t; Qrepl Q_sym H1;
   Qrepl sbt_Z_x_eq_Z (S x); Refine Q_refl;
intros; Qrepl sbt_respect_S (S y) x; Qrepl sbt_respect_S y x;
   Refine H ? t; Qrepl Q_sym (sbt_respect_S y x); Immed;
Save sbt_commutes_S_left;

Goal {m,n,t|NN}(Q (sbt n m) (S t))->Q (sbt n (S m)) t;
intros;
Equiv Q (pred (sbt n m)) t;
Qrepl H; Refine Q_refl;
Save sbt_commutes_S_right;

Goal {a:NN}{m,n,t|NN}(Q (sbt n m) (S t))->Q (sbt (add n a) m) (S (add t a));
Refine Nrec [a:NN]{m,n,t|NN}(Q (sbt n m) (S t))->
         Q (sbt (add n a) m) (S (add t a));
intros; Qrepl addZ n; Qrepl addZ t; Immed;
intros; Qrepl addS x n; Qrepl addS x t; Refine Nih|m|(S n)|(S t);
Qrepl Q_sym H; Refine sbt_commutes_S_left H;
Save sbt_monotone_left;


(**)
(* Nlt, computational less-than *)

Goal {n:NN}Q (Nlt Z (S n)) Z;
intros; Expand Nlt; Qrepl sbt_respect_S Z n;
Refine sbt_Z_x_eq_Z;
Save Z_Nlt_S;

Goal {n:NN}Q (Nle Z (S n)) Z;
intros; Expand Nle; Refine sbt_Z_x_eq_Z;
Save Z_Nle_S;

Goal {n:NN}not (Q (Nlt n Z) Z);
Intros n h; Refine Z_not_S n; Refine Q_sym h;
Save not_Nlt_n_Z;

Goal {n,m:NN}Q (Nlt n m) (Nlt (S n) (S m));
intros; Qrepl sbt_S_pred (S (S n)) m; Refine Q_refl;
Save NltS;

Goal {n,m:NN}Q (Nle n m) (Nle (S n) (S m));
intros; Qrepl sbt_S_pred (S n) m; Refine Q_refl;
Save NleS;

Goal {x:NN}Q (Nlt x x) one;
Refine Nrec [x:NN]Q (Nlt x x) one;
Refine Q_refl;
intros; Qrepl Q_sym Nih; Refine Q_sym (NltS x x);
Save notNltxx;

Goal {x:NN}Q (Nlt x (S x)) Z;
intros; Refine sbt_x_x_eq_z (S x);
Save xNltSx;

Goal {x,n|NN}(is_S (Nlt x (S n)))->(is_S x);
Refine Nrec [x:NN]{n|NN}(is_S (Nlt x (S n)))->(is_S x);
intros; Refine Z_not_S (pred (Nlt Z (S n))); Qrepl Q_sym H;
   Refine Q_sym; Refine Z_Nlt_S;
intros; Refine Q_refl;
Save notNltSisS;

Goal {x,n|NN}(Q (Nlt x n) Z)->(is_S n);
intros x;
Refine Nrec [n:NN](Q (Nlt x n) Z)->is_S n;
intros; Refine not_Nlt_n_Z x; Immed;
intros; Refine Q_refl;
Save Nlt_right_isS;

Goal {a,b|NN}or (is_S (Nlt a b)) (is_S (Nlt b a));
Refine double_induct [a,b|NN]or (is_S (Nlt a b)) (is_S (Nlt b a));
Refine inl; Refine Q_refl;
intros; Refine inr; Refine Q_refl;
intros; Refine inl; Refine Q_refl;
intros; Qrepl Q_sym (NltS y x); Qrepl Q_sym (NltS x y); Immed;
Save not_Nltab_and_Nltba;

Goal {a,b|NN}(Q (Nlt a b) Z)->(Q (Nlt a (S b)) Z);
Expand Nlt; intros; Equiv Q (pred (sbt (S a) b)) Z; Qrepl H; Refine Q_refl;
Save NltWeakTrans;

(*********  another form of last lemma  **************
Goal {a,b|NN}(Q (Nlt a b) Z)->is_S (Nlt b a)
Refine double_induct [a,b|NN](Q (Nlt a b) Z)->is_S (Nlt b a);
intros; Refine not_Nlt_n_Z Z H;
intros; Refine Q_refl;
intros; Refine not_Nlt_n_Z (S x) H1;
intros; Qrepl Q_sym (NltS y x); Refine H; Qrepl NltS x y; Immed;
Save not_Nltab_and_Nltba;
**************************)

Goal {a,b,n|NN}(Q (Nlt a b) (S n))->Q (Nlt (S a) b) (S (S n));
intros; Qrepl sbt_commutes_S_left H; Refine Q_resp_S; Immed;
Save Nlt_S_left;

Goal {n,m:NN}(Q (Nlt (S n) m) Z)->(Q (Nlt n m) Z);
Refine double_induct [n,m:NN](Q (Nlt (S n) m) Z)->Q (Nlt n m) Z;
intros QmZ; Refine not_Nlt_n_Z one; Immed;
intros; Refine Z_Nlt_S;
intros; Refine not_Nlt_n_Z (S (S x)); Immed;
intros; Qrepl Q_sym (NltS x y); Refine H; Qrepl NltS (S x) y; Immed;
Save Nlt_left_S;

Goal {m,n:NN}(Q (Nlt n (S m)) Z)->(or (Q n m) (Q (Nlt n m) Z));
Refine double_induct [m,n:NN](Q (Nlt n (S m)) Z)->
                             or (Q n m) (Q (Nlt n m) Z);
intros; Refine inl; Refine Q_refl;
intros; Refine not_Nlt_n_Z y; Qrepl NltS y Z; Immed;
intros; Refine inr; Refine Z_Nlt_S;
intros; Refine H y; Qrepl NltS y (S x); Immed;
intros; Refine inl; Refine Q_resp_S; Immed;
intros; Refine inr; Qrepl Q_sym (NltS y x); Immed;
Save Nlt_S_character;

Goal {n,m:NN}or3 (and (Q (Nlt n m) Z) (is_S (Nlt m n)))
                (and (Q (Nlt m n) Z) (is_S (Nlt n m)))
                (Q n m);
Refine double_induct [n,m:NN]or3 (and (Q (Nlt n m) Z) (is_S (Nlt m n)))
                                (and (Q (Nlt m n) Z) (is_S (Nlt n m)))
                                (Q n m);
Refine or3_in3; Refine Q_refl;
intros; Refine or3_in1; Refine pair; Refine Z_Nlt_S; Refine Q_refl;
intros; Refine or3_in2; Refine pair; Refine Z_Nlt_S; Refine Q_refl;
intros; Qrepl Q_sym (NltS x y); Qrepl Q_sym (NltS y x); Refine H y;
intros; Refine or3_in1; Immed;
intros; Refine or3_in2; Immed;
intros; Refine or3_in3; Refine Q_resp_S H2;
Save Nlt_character;

Goal {n,m:NN}or3 (and (Q (Nle n m) Z) (is_S (Nle m n)))
                (and (Q (Nle m n) Z) (is_S (Nle n m)))
                (Q n m);
Refine double_induct [n,m:NN]or3 (and (Q (Nle n m) Z) (is_S (Nle m n)))
                                (and (Q (Nle m n) Z) (is_S (Nle n m)))
                                (Q n m);
Refine or3_in3; Refine Q_refl;
intros; Refine or3_in1; Refine pair; Refine Z_Nle_S; Refine Q_refl;
intros; Refine or3_in2; Refine pair; Refine Z_Nle_S; Refine Q_refl;
intros; Qrepl Q_sym (NleS x y); Qrepl Q_sym (NleS y x); Refine H y;
intros; Refine or3_in1; Immed;
intros; Refine or3_in2; Immed;
intros; Refine or3_in3; Refine Q_resp_S H2;
Save Nle_character;

Goal {a,b:NN}iff (Q (Neq a b) Z) (Q a b);
intros a b; Refine pair;
Refine Nle_character a b;
Expand Nle; intros; Refine Z_not_S (pred (sbt b a));
   Qrepl Q_sym (snd H); Qrepl snd (add_strict H1); Refine Q_refl;
Expand Nle; intros; Refine Z_not_S (pred (sbt a b));
   Qrepl Q_sym (snd H); Qrepl fst (add_strict H1); Refine Q_refl;
intros; Immed;
intros; Qrepl H; Expand Neq; Qrepl sbt_x_x_eq_z b; Refine Q_refl;
Save Neq_character;

Goal {a,b:NN}Q (Neq a b) (Neq b a);
intros; Expand Neq; Qrepl addCommute (sbt a b) (sbt b a); Refine Q_refl;
Save Neq_sym;

Goal {n:NN}Q (Neq n n) Z;
intros n; Refine snd (Neq_character n n); Refine Q_refl;
Save Neq_triv;

(**)
(* Le: an excursus from the library, modified  *)

[Le = [n,m:NN] Ex [k:NN] Q m (add k n) : NN->NN->Prop];

Goal {m,n|NN}(Le m n)->Le (S m) (S n);
intros;Refine H;
intros k eq;Refine ExIn k;Qrepl addS m k;
Refine Q_resp_S;Immed;
Save Le_resp_S;

Goal {m,n|NN}Le n (add m n);
intros;Refine ExIn;Refine +1 Q_refl;
Save Le_add_lemma1;

Goal {m,n|NN}Le m (add m n);
intros;Qrepl addCommute n m;
Refine Le_add_lemma1;
Save Le_add_lemma2;

Goal {m,n|NN}(Le m (S n)) -> or (Le m n) (Q m (S n));
intros;Refine H;
Refine Nrec [t:NN](Q (S n) (add t m))->or (Le m n) (Q m (S n));
intros;Refine inr;Refine Q_sym H1;
intros;Refine inl;Refine ExIn;Refine +1 S_injective;Immed;
Save Le_S_lemma;

Goal trans Le;
Intros x y z Lexy Leyz;Refine Lexy; 
intros t Qxty;Refine Leyz;
intros u Qyuz;Refine ExIn (add t u);
Qrepl Qyuz;
Qrepl addCommute u t;
Qrepl addAssocR t x u;
Refine Q_resp (add u);
Immed;
Save Le_trans;

Goal {C|TYPE}(NN -> C) -> (NN -> C) -> (C -> C)
  -> (NN -> NN -> C);
intros C fst_zero snd_zero inc;
Refine Nrec ([_:NN]NN -> C);
Refine fst_zero;
intros n f;Refine Nrec([_:NN]C);Refine snd_zero (S n);
intros;Refine inc (f x);
Save NN_double_iter;

[max = NN_double_iter ([n:NN]n) ([n:NN]n) S];

Goal {x,y:NN}Le x (max x y);
Refine double_induct  [x,y:NN]Le x (max x y);
Refine ExIn Z;Refine Q_refl;
intros;Refine ExIn (S y);Qrepl addZ (S y);Refine Q_refl;
intros;Refine ExIn Z;Refine Q_refl;
intros;Equiv Le (S x) (S (max x y));Refine Le_resp_S;Immed;
Save max_Le_left;

Goal {x,y:NN}Le y (max x y);
Refine double_induct  [x,y:NN]Le y (max x y);
Refine ExIn Z;Refine Q_refl;
intros;Refine ExIn Z;Refine Q_refl;
intros;Refine ExIn (S x);Qrepl addZ (S x);Refine Q_refl;
intros;Equiv Le (S y) (S (max x y));Refine Le_resp_S;Immed;
Save max_Le_right;

(* less: an arithmetic definition  *)
[Lt [n,m:NN] = Ex[x:NN] Q (add n (S x)) m];

Goal {n:NN}Lt Z (S n);
intros; Refine ExIn n; Refine Q_refl;
Save Lt_Z_Sn;

Goal {n:NN}Lt n (S n);
Intros n; Refine ExIn Z;
Refine Q_subst (addCommute ? ?) [t:NN]Q t ?; Refine Q_refl;
Save Lt_incl_S;

Goal {x,y,z|NN}(Lt x y)->(Lt y z)->(Lt x z);
Intros x y z Ltxy Ltyz;
Refine Ltxy; Intros t QxSty; Refine Ltyz; Intros u QySuz;
Refine ExIn (S (add t u));
Equiv Q (add x (add (S (S t)) u)) z;
Refine Q_subst (addAssocR ? ? ?) [t:NN]Q t z;
Refine Q_subst (Q_sym (addS ? ?)) [t:NN]Q (add t u) z;
Refine Q_subst (Q_sym QxSty) [t:NN]Q (add (S t) u) z;
Equiv Q (S (add y u)) z;
Refine Q_subst (addS u y) [t:NN]Q t z;
Immed;
Save Lt_trans;

Goal {n:NN}not (Lt n Z);
Intros n LtnZ; Refine LtnZ; Intros t h;
Refine Z_not_S (add n t);
Refine Q_subst (addS ? ?) [u:NN]Q Z u;
Refine Q_sym h;
Save not_Lt_n_Z;

Goal {x,y:NN}iff (Lt x y) (Lt (S x) (S y));
Intros x y; Refine pair;
Intros Ltxy; Refine Ltxy; Intros t h; Refine ExIn t;
Refine Q_resp_S h;
Intros LtSxSy; Refine LtSxSy; Intros t h; Refine ExIn t;
Refine Q_resp_pred h;
Save Lt_resp_S;

Goal {n,m|NN}(Lt n (S m))->or (Lt n m) (Q n m);
intros; Refine H; 
Refine Nrec [t:NN](Q (add n (S t)) (S m))->or (Lt n m) (Q n m);
intros; Refine inr; Refine S_injective;
   Qrepl Q_sym H1; Qrepl addS Z n; Qrepl addZ n; Refine Q_refl;
intros; Refine inl; Refine ExIn x; Refine S_injective;
   Qrepl Q_sym H1; Refine Q_sym; Refine addS;
Save LtnSm_character;

(* Lt and add *)
Goal {i,j|NN}(Lt i j)->{n:NN}Lt (add i n) (add j n);
intros i j Ltij;
Refine Nrec [n:NN]Lt (add i n) (add j n);
Qrepl addZ i; Qrepl addZ j; Immed;
intros x Ltixjx;
Qrepl addS x i; Qrepl addS x j;
Refine fst (Lt_resp_S (add i x) (add j x)); Immed;
Save add_resp_Lt_left;

Goal {i,j:NN}Lt j (S (add i j));
intros;Equiv Lt (add Z j) (add (S i) j);
Refine add_resp_Lt_left;Refine Lt_Z_Sn;
Save Lt_add_S_left;

Goal {i,j:NN}Lt i  (S (add i j));
intros;Qrepl addCommute j i;Refine Lt_add_S_left;
Save Lt_add_S_right;

Goal {n,m,l|NN}(Lt (S (add n m)) l)->and (Lt n l) (Lt m l);
Refine double_induct [n,m:NN]{l|NN}(Lt (S (add n m)) l)->and (Lt n l) (Lt m l);
intros;Refine pair;Refine ?+1;
Refine Lt_trans;Refine +1 Lt_Z_Sn;Immed;
intros;Refine pair (fst (H ?));Refine ?+1;
Refine Lt_trans;Refine +1 Lt_incl_S;Immed;
intros;Refine pair;Refine +1 Lt_trans;Refine ?+3;
Refine Lt_Z_Sn;Refine Lt_trans;Refine +1 Lt_incl_S;
Qrepl Q_sym (addZ (S x));Immed;
intros;Refine pair (fst (H1 ?)) (snd (H (S y) ?));
Qrepl Q_sym (addS y x);Refine ?+1;
Refine Lt_trans;Refine +1 Lt_incl_S;Immed;
Save Lt_S_add;

(* complete induction *)
Goal {P:NN->Prop}{ih:{n:NN}({x:NN}(Lt x n)->(P x))->P n}{m:NN}P m;
intros;Refine ih;Refine Nrec [m:NN]{x:NN}(Lt x m)->P x;
intros; Refine not_Lt_n_Z; Immed;
intros; Refine LtnSm_character; Immed;
intros; Refine ih; Qrepl H1; Immed;
Save complete_induction;

Goal {T|Prop}{f|T->NN}{P:T->Prop}
     {wf_ih:{t:T}({x:T}(Lt (f x) (f t))->(P x))->P t}
     {k:T}P k;
intros;
Refine complete_induction [n:NN]{y:T}(Q n (f y))->P y;
intros; Refine wf_ih;
intros; Refine H; Refine f x; Qrepl H1; Refine H2; Refine Q_refl;
Refine f k; Refine Q_refl;
Save WF_induction;

(**)
(* lists *)
[A|TYPE]
$[LL:TYPE//A]
$[NIL:LL]
$[CONS:A->LL->LL]
$[LLrec:{C:LL->TYPE}
      {Lbase:C NIL}
      {Lstep:{b:A}{prem:LL}{LLih:C prem}C (CONS b prem)}
      {l:LL}C l];
[hd [a:A][l:LL] = LLrec ([_:LL]A) a ([x:A][_:LL][_:A]x) l];
[tl [l:LL] = LLrec ([_:LL]LL) NIL ([_:A][k,_:LL]k) l];
[append [k,l:LL] = LLrec ([_:LL]LL) l ([a:A][_,j:LL]CONS a j) k];
[unit [a:A] = CONS a NIL];
[length [l:LL] = LLrec ([_:LL]NN) Z ([_:A][_:LL]S) l];
[exist [P:A->BB] : LL->BB =
    LLrec ([_:LL]BB) ff ([b:A][_:LL][rest:BB]orr (P b) rest)];
[member [eq:A->A->BB][a:A] : LL->BB = exist (eq a)];
[sublist [eq:A->A->BB][k,l:LL]
        = {a|A}(is_tt (member eq a k)) -> is_tt (member eq a l)];
[nth [n:NN][l:LL][a:A] : A =
     [zro [k:LL] = hd a k]
     [suc [_:NN][f:LL->A][k:LL] = f (tl k)]
       Nrec ([_:NN]LL->A) zro suc n l];
[listRemove [eq:A->BB] : LL->LL =
     LLrec ([_:LL]LL) NIL ([b:A][_:LL][k:LL]if (eq b) k (CONS b k))];
[noDups [eq:A->A->BB] : LL->BB =
   LLrec ([_:LL]BB)
         tt
         ([a:A][as:LL][rest:BB]andd (nott (member eq a as)) rest)];

[B|TYPE][g:A->B->B];

[foldright [l:LL][b:B] = LLrec ([_:LL]B) b ([a:A][_:LL][b:B]g a b) l];
[foldleft = LLrec ([_:LL]B->B) ([b:B]b) ([a:A][_:LL][f:B->B][b:B]f (g a b))];



[[C:LL->TYPE]
 [d:C NIL]
 [e:{b:A}{k:LL}(C k)->C (CONS b k)]
 [a:A]
 [l:LL]
    LLrec C d e NIL ==> d
 || LLrec C d e (CONS a l) ==> e a l (LLrec C d e l)];

[LLrec_on [l:LL]
          [C:LL->TYPE]
          [Lbase:C NIL]
          [Lstep:{b:A}{prem:LL}{LLih:C prem}C (CONS b prem)]
      = LLrec C Lbase Lstep l];
Freeze LLrec_on;

[Q_resp_tl [k,l|LL][h:Q k l]
        : Q (tl k) (tl l) = Q_resp|LL|LL tl h];
[Q_resp_hd [k,l|LL][a,b|A][h:Q (CONS a k) (CONS b l)]
        : Q a b = Q_resp|LL|A (hd a) h];
[CONS_injective [k,l|LL][a,b|A][h:Q (CONS a k) (CONS b l)]
        : Q k l = Q_resp_tl h];

Goal {a,b|A}(Q a b)->{k,l|LL}(Q k l)->Q (CONS a k) (CONS b l);
intros; Qrepl H; Qrepl H1; Refine Q_refl;
Save Q_resp_CONS;

Goal {C:LL->LL->TYPE}
     (C NIL NIL)->
     ({b:A}{l:LL}(C NIL l)->C NIL (CONS b l))->
     ({b:A}{x:LL}({y:LL}C x y)->C (CONS b x) NIL)->
     ({b:A}{x:LL}({y:LL}C x y)->{c:A}{y:LL}(C (CONS b x) y)->
                    C (CONS b x) (CONS c y))->
     {x,y:LL}C x y;
intros C bb bs sb ss; Refine LLrec [x:LL]{y:LL}C x y;
Refine LLrec (C NIL); Immed;
intros b x h; Refine LLrec (C (CONS b x));
Refine sb b x h; Refine ss b x h;
Save list_double_induct;

$[NIL_not_CONS:{l|LL}{a|A}not (Q NIL (CONS a l))];

Goal {l:LL}{a:A}not (Q l (CONS a l));
Refine LLrec [l:LL]{a:A}not (Q l (CONS a l));
intros; Refine NIL_not_CONS;
Intros _____; Refine LLih b;
Refine CONS_injective; Refine +2 H;
Save l_not_CONSl;

Goal {l:LL}{a:A}Ex2 [b:A][m:LL]Q (CONS a l) (append m (unit b));
Refine LLrec [l:LL]{a:A}Ex2 [b:A][m:LL]Q (CONS a l) (append m (unit b));
intros;Refine Ex2In a NIL;Refine Q_refl;
intros;Refine LLih b;
intros c m eq;Qrepl eq;Refine Ex2In c (CONS a m);Refine Q_refl;
Save non_nil_list_lem;

Goal {k,l:LL}{a:A}
        Ex2 [b:A][j:LL]Q (append k (CONS a l)) (CONS b j); 
intros;
Refine LLrec_on k [k:LL]Ex2 ([b:A][j:LL]Q (append k (CONS a l)) (CONS b j));
Refine Ex2In a l; Refine Q_refl;
intros; Refine Ex2In b (append prem (CONS a l));
Refine Q_refl;
Save append_CONS;

Goal {a:A}{k,l:LL}not (Q NIL (append k (CONS a l)));
intros; Refine append_CONS k l a; intros;
Qrepl H; Refine NIL_not_CONS;
Save NIL_not_append_CONS;

Goal {l:LL}(Q (append l (NIL)) l);
Refine LLrec [l:LL](Q (append l (NIL)) l);
Refine Q_refl;
intros;Equiv Q (CONS b (append prem (NIL))) (CONS b prem);
Refine Q_resp;Immed;
Save append_nil;

Goal {j,k,l:LL}Q (append j (append k l))
                             (append (append j k) l);
intros _;
Refine LLrec [j:LL]{k,l:LL}Q (append j (append k l))
                              (append (append j k) l);
(* case NIL *)
intros; Refine Q_refl;
(* case CONS *)
intros;
Equiv Q (CONS b (append prem (append k l)))
        (CONS b (append (append prem k) l));
Qrepl LLih k l; Refine Q_refl;
Save append_associative;

Goal {G,H:LL}{b:B}Q (foldright (append G H) b) (foldright G (foldright H b));
Refine LLrec [G:LL]{H:LL}{b:B}
              Q (foldright (append G H) b) (foldright G (foldright H b));
intros; Refine Q_refl;
intros;
Equiv Q (g b (foldright (append prem H) b1))
        (g b (foldright prem (foldright H b1)));
Qrepl LLih H b1;Refine Q_refl;
Save foldright_append_lem;

Goal {G,H:LL}{b:B}Q (foldleft (append G H) b) (foldleft H (foldleft G b));
Refine LLrec [G:LL]{H:LL}{b:B}
              Q (foldleft (append G H) b) (foldleft H (foldleft G b));
intros; Refine Q_refl;
intros;
Equiv Q (foldleft (append prem H) (g b b1))
        (foldleft H (foldleft prem (g b b1)));
Qrepl LLih H (g b b1);Refine Q_refl;
Save foldleft_append_lem;

Discharge g;

Goal {P:A->BB}{j,k:LL}
        Q (exist P (append j k))
          (orr (exist P  j) (exist P k));
intros;
Refine LLrec [j:LL]Q (exist P (append j k))
                     (orr (exist P j) (exist P k));
Refine Q_refl;
intros;
Equiv Q (orr (P b) (exist P (append prem k)))
        (orr (orr (P b) (exist P prem)) ?);
Qrepl orr_associates (P b) (exist P prem) (exist P k);
Qrepl LLih; Refine Q_refl;
Save exist_append_lem;

Goal {eq:A->A->BB}{a:A}{j,k:LL}
        Q (member eq a (append j k))
          (orr (member eq a j) (member eq a k));
intros; Refine exist_append_lem (eq a) j k;
Save member_append_lem;

Goal {P:A->BB}{j,k|LL}
        (is_ff (exist P (append j k)))->
          is_ff (orr (exist P  j) (exist P k));
intros; Qrepl Q_sym (exist_append_lem P j k); Immed;
Save exist_append_lem';

Goal {eq:A->A->BB}{a:A}{j,k|LL}
        (is_ff (member eq a (append j k)))->
          is_ff (orr (member eq a j) (member eq a k));
intros; Refine exist_append_lem' (eq a) H;
Save member_append_lem';

Goal {eq:A->A->BB}{a|A}{l|LL}(is_tt (member eq a (tl l)))->is_tt (member eq a l);
intros __;
Refine LLrec [l:LL](is_tt (member eq a (tl l)))->is_tt (member eq a l);
intros; Immed;
intros;Refine snd (orr_character ? (member eq a prem));
Refine inr H;
Save member_tl_lem;

Goal {P:A->BB}{l:LL}is_ff (exist P (listRemove P l));
intros P;
Refine LLrec [l:LL]is_ff (exist P (listRemove P l));
Refine Q_refl;
intros;
Equiv is_ff (exist P (if (P b)
                      (listRemove P prem)
                      (CONS b (listRemove P prem))));
Refine tt_or_ff (P b);
intros Pb; Qrepl Pb; Expand if; Immed;
intros nPb; Qrepl nPb; Expand if;
Refine snd (deMorgan ? ?); Refine pair; Immed;
Save member_listRemove_lem;

Goal {eq|A->A->BB}{eq_refl:{a:A}is_tt (eq a a)}
     {l|LL}(sublist eq l (NIL))->Q l (NIL);
intros __;Refine LLrec [l|LL]{sub:sublist eq l (NIL)}Q l (NIL);
intros;Refine Q_refl;
intros;Refine tt_not_ff;Refine Q_sym;Refine sub;
Refine +1 snd (orr_character ? (member ? ? ?));
Refine +1 inl;Refine +1 eq_refl;
Save sublist_nil;

(* lists equality *)
[list_eq [eq:A->A->BB] : LL->LL->BB =
   LLrec ([_:LL]LL->BB)
         (LLrec ([_:LL]BB) tt ([_:A][_:LL][_:BB]ff))
         ([a:A][_:LL][rest:LL->BB]
            LLrec ([_:LL]BB)
                  ff
                  ([b:A][k:LL][_:BB]andd (eq a b) (rest k)))];

Goal {eq|A->A->BB}({a:A}is_tt (eq a a))->{l:LL}is_tt (list_eq eq l l);
intros;
Refine LLrec [l:LL]is_tt (list_eq eq l l);
Refine Q_refl;
intros; Refine snd (andd_character ? (list_eq ? ? ?));
Refine pair (H b) LLih;
Save list_eq_refl;

Goal {eq|A->A->BB}({a,b|A}(is_tt (eq a b))->Q a b)->
          {l,k|LL}(is_tt (list_eq eq l k))->Q l k;
intros eq eqHyp;
Refine list_double_induct [l,k:LL](is_tt (list_eq eq l k))->Q l k;
intros; Refine Q_refl;
intros; Refine tt_not_ff (Q_sym H1);
intros; Refine tt_not_ff (Q_sym H1);
intros;
[lem : and (is_tt (eq b c)) (is_tt (list_eq eq x y))
     = fst (andd_character ? ?) H2];
Refine Q_resp_CONS; Refine eqHyp (fst lem); Refine H ? (snd lem);
Save list_eq_subst;

(* A well-founded induction on lists *)
Goal {P:LL->Prop}
     {ih:{l:LL}({x:LL}(Lt (length x) (length l))->(P x))->P l}
     {k:LL}P k;
intros; Claim {y:LL}(Lt (length y) (length k))->P y; Refine ih k ?+1;
Refine LLrec_on k [k:LL]{y:LL}(Lt (length y) (length k))->P y;
intros; Refine not_Lt_n_Z; Immed;
intros; Refine LtnSm_character H;
intros; Refine LLih y H1;
intros; Refine ih; Qrepl H1; Refine LLih;
Save WF_list_induction;

DischargeKeep A;

(* the true map function *)
[C|TYPE][g:B->C][f:A->B];

[map : (LL|A)->(LL|B) =
     LLrec ([_:LL|A]LL|B) (NIL|B) ([a:A][_:LL|A][k:LL|B]CONS (f a) k)];

Goal {l|LL|A}(Q (map l) (NIL|B))->Q l (NIL|A);
Refine LLrec [l|LL|A]{eq:Q (map l) (NIL|B)}Q l (NIL|A);
intros;Refine Q_refl;
intros;Refine NIL_not_CONS (Q_sym eq);
Save map_nil;

Goal {G,H:LL|A}Q (map (append G H)) (append (map G) (map H));
Refine LLrec [G:LL|A]{H:LL|A}
              Q (map (append G H)) (append (map G) (map H));
intros; Refine Q_refl;
intros;
Equiv Q (CONS (f b) (map (append prem H)))
        (CONS (f b) (append (map prem) (map H)));
Qrepl LLih H; Refine Q_refl;
Save map_append_lem;

DischargeKeep A;

Goal {G:LL|A}Q (map (compose g f) G) ((compose (map g) (map f)) G);
Refine LLrec [G:LL|A]Q (map (compose g f) G)
                       ((compose (map g) (map f)) G);
Refine Q_refl;
intros;Equiv Q (CONS (g (f ?)) (map ? ?))
               (CONS (g (f ?)) (compose (map ?) (map ?) ?));
Refine Q_resp;Immed;
Save map_compose_lem;

Discharge A;

(**)
(* pairs *)
[A,B|TYPE];
$[PROD:TYPE//A B];
$[Pr:A->B->PROD];
$[PRODrec:{C:PROD->TYPE}({a:A}{b:B}C (Pr a b))->{g:PROD}C g];
[[C:PROD->TYPE][d:{a:A}{b:B}C (Pr a b)][a:A][b:B]
  PRODrec C d (Pr a b) ==> d a b];

[Fst = PRODrec ([_:PROD]A) ([a:A][b:B]a)];
[Snd = PRODrec ([_:PROD]B) ([a:A][b:B]b)];

(* equality and global bindings *)
Goal {u,v|PROD}(Q u v)->(and (Q (Fst u) (Fst v)) (Q (Snd u) (Snd v)));
intros; Refine pair;
Refine Q_resp|PROD|A Fst H; Refine Q_resp|PROD|B Snd H;  (* ??? *)
Save Q_resp_proj;

(* Fst and Snd are proper destructors *)
Goal {b:PROD}Q b (Pr (Fst b) (Snd b));
Refine PRODrec [b:PROD]Q b (Pr (Fst b) (Snd b));
intros; Refine Q_refl;
Save PROD_surj_pair;

Goal {p,q|A}(Q p q)->{A,B|B}(Q A B)->Q (Pr p A) (Pr q B);
intros; Qrepl H; Qrepl H1; Refine Q_refl;
Save Q_resp_Pr;

(**)
(* lists of pairs *)

[lefts : (LL|(PROD))->(LL|A) = map (Fst)];
[rights : (LL|(PROD))->(LL|B) = map (Snd)];

[eq:A->BB][dummy:B];

[assoc [abs:LL|PROD] : B
      = foldright ([x:PROD][rest:B]if (eq (Fst x)) (Snd x) rest) abs dummy];

Goal {abs|LL|(PROD)}(is_ff (exist eq (lefts abs))) ->
      Q (assoc abs) dummy;
Refine LLrec [abs|LL|(PROD)]
             {nocc:is_ff (exist eq (lefts abs))}
              Q (assoc abs) dummy;
intros;Refine Q_refl;
intros;Refine fst (deMorgan (eq (Fst b)) (exist eq (lefts prem))) nocc;
intros neqA nocc_prem;Equiv Q (if ? ? (assoc ?)) ?;
Qrepl neqA;Qrepl LLih nocc_prem;Refine Q_refl;
Save assoc_dummy_lem;

DischargeKeep dummy;

[dummy':B];

Goal {abs|LL|(PROD)}(is_tt (exist eq (lefts abs))) ->
      Q (assoc dummy abs) (assoc dummy' abs);
Refine LLrec [abs|LL|(PROD)]
             {occ:is_tt (exist eq (lefts abs))}
              Q (assoc dummy abs) (assoc dummy' abs);
intros;Refine tt_not_ff;Refine Q_sym;Immed;
intros;Equiv Q (if ? ? (assoc ? ?)) (if ? ? (assoc ? ?));
Refine fst (orr_character (eq (Fst b)) (exist eq (lefts prem))) occ;
intros eqA;Qrepl eqA;Refine Q_refl;
intros occ_prem;Qrepl LLih occ_prem;Refine Q_refl;
Save assoc_occurs_lem;

Discharge dummy';

Goal {abs1|LL|(PROD)}(is_tt (exist eq (lefts abs1))) ->
     {abs2:LL|(PROD)} Q (assoc dummy (append abs1 abs2)) (assoc dummy abs1);
intros;
Qrepl foldright_append_lem
      ([x:PROD][rest:B]if (eq (Fst x)) (Snd x) rest)
      abs1 abs2 dummy;
Qrepl assoc_occurs_lem (assoc dummy abs2) H;
Refine Q_refl;
Save assoc_append_lem_left;

Goal {abs1|LL|(PROD)}(is_ff (exist eq (lefts abs1))) ->
     {abs2:LL|(PROD)} Q (assoc dummy (append abs1 abs2)) (assoc dummy abs2);
intros;
Qrepl foldright_append_lem
      ([x:PROD][rest:B]if (eq (Fst x)) (Snd x) rest)
      abs1 abs2 dummy;
Qrepl assoc_dummy_lem (assoc dummy abs2) H;
Refine Q_refl;
Save assoc_append_lem_right;

[zip [as:LL|A][bs:LL|B] : LL|(PROD)
    = foldright ([a:A][_:(LL|B)->LL|(PROD)]map (Pr a))
                  as ([_:LL|B]NIL|(PROD)) bs];
                
[listSub [a:A] : (LL|A)->(LL|A) = map ([b:A]if (eq b) a b)];

DischargeKeep A;

[C|TYPE][f:B->C];

Goal {abs:LL|(PROD|A|B)}
      Q (f (assoc eq dummy abs))
        (assoc eq (f dummy) (map ([ab:PROD|A|B]Pr (Fst ab) (f (Snd ab))) abs));
Refine LLrec [abs:LL|(PROD|A|B)]Q (f (assoc eq dummy abs))
        (assoc eq (f dummy) (map ([ab:PROD|A|B]Pr (Fst ab) (f (Snd ab))) abs));
Refine Q_refl;
intros;Qrepl if_inside f (Snd b) (assoc eq dummy prem) (eq (Fst b));
Qrepl LLih;Refine Q_refl;
Save assoc_map_lem;

Discharge A;




