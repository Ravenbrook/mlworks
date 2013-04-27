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
 * $Log: bops.l,v $
 * Revision 1.1  1998/08/06 10:36:10  jont
 * new unit
 * Lego test application
 *
 *
 *)
Forget bopapply;

Inductive [bopapply : bop -> val -> state -> val -> state -> Prop]
Constructors
[plus_rule : 
 {n1,n2:NN}{s:state}
 bopapply plusbop (vtuple (valcons (vnum n1) (valcons (vnum n2) valnil))) s (vnum (add n1 n2)) s]
[sub_rule : 
 {n:NN}{s:state}
 bopapply subbop (vnum n) s (vnum (pred n)) s]
[assign_rule :
 {l:loc}{x:val}{s:state}
 bopapply assign 
          (vtuple (valcons (vloc l) (valcons x valnil)))
          s 
          (vtuple valnil)
          (state_update s l x)]
[ref_rule :
 {x:val}{s:state}
 bopapply ref x s (vloc (nextloc s)) (state_extend s x)]
[deref_rule :
 {l:loc}{s:state}
 bopapply deref (vloc l) s (state_lookup l s) s];
