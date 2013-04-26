(*
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
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
