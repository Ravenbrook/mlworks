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
 * $Log: beta_theorem.l,v $
 * Revision 1.1  1998/08/06 10:36:11  jont
 * new unit
 * Lego test application
 *
 *
 *)
Goal {ve:val_env}{s:state}{e1,e2:exp}{esafe:safe e2 ve}
     {v1,v2:val}{s1,s2:state}
     {eval1: sem ve s (app (fn e1) e2) v1 s1}
     {eval2: sem ve s (sub e1 e2 Z) v2 s2}
     and (equiv v1 v2)(state_equiv s1 s2);
intros;
Refine extract_app eval1;intros ____;Refine and3_elim;intros _;
Refine extract_fn H;intros __;
Qrepl H1;Qrepl H2;intros;
Refine cut (apply_thm H4);intros;
Refine subst_theorem esafe H3 (ve_equiv_eq ve);
Refine e1;
Refine empty_ve;
Refine empty_ve;
Refine +2 H5;
Refine +1 eval2;
Refine state_equiv_eq;
Refine Q_sym (safe_theorem2 esafe H3);
Refine ve_equiv_eq;


Save beta_thm;
