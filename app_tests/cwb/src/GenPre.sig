(*
 *
 * $Log: GenPre.sig,v $
 * Revision 1.2  1998/06/02 15:22:17  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: GenPre.sig,v 1.2 1998/06/02 15:22:17 jont Exp $";
(********************************** GenPre ***********************************)
(*                                                                           *)
(*             Signature for Preorder Checking                               *)
(*                                                                           *)
(*  Modified to run under Bell ML compiler - April 1989 - Jo Blishen         *)
(*                                                                           *)
(*****************************************************************************)

signature GENPRE =
sig
   structure DivC : DIVCOMP

(****************************************************************************)
(*                                                                          *)
(* genpreord: (relaxpred,initpred) -> (lefttranssyst,righttranssyst)        *)
(*                                                                -> bool   *)
(* relaxpred: it relaxes the check of the second condition for bisimulation *)
(*     If this predicate is set to true then we only check for simulation   *)
(*     rather than for bisimulation.                                        *)
(*       -In the case of the testing preorder, we can use relaxpred to      *)
(*        switch to the simulation modus, because all we need about the     *)
(*        second condition is a consequence of the first condition and a    *)
(*        frame condition, which is checked already in the initialization   *)
(*        process via the predicate initpred. Thus for an application to    *)
(*        testing equivalence you have to use the trivial predicate:        *)
(*        trivpred: 'a state ->  bool     (state  ->  true)                 *)
(*       -In the case of the divergence preorder this predicate is to avoid *)
(*        the check of the second condition whenever the left hand state is *)
(*        known to be globally divergence. Therefore we need to use         *)
(*        globdivpred (see DivergenceComputations) in this case.            *)
(* initpre: it serves for a first approximation of the "greater set"        *)
(*     (represented in the component state.inf.appref).                     *)
(*       -In case of the testing preorder initpred should guarantee for     *)
(*        well behaving acceptance sets (represented in accsetref). The     *)
(*        ongoing main analysis always assumes that the acceptance sets     *)
(*        behave well. It is not checked there.                             *)
(*       -In case of the divergence preorder initpred guarantees that only  *)
(*        "more convergent" state are regarded as possible upper approxima- *)
(*        tions. So we never have to check (left state converges implies    *)
(*        right state converges) during the main analysis.                  *)
(* lefttranssyst: it gives just the left hand state with its environment    *)
(*     a list of states.                                                    *)
(* righttranssyst: it gives just the left hand state with its environment   *)
(*     a list of states.                                                    *)
(*                                                                          *)
(* genpreord results in true iff leftrtranssyst < righttranssyst            *)
(*                                                                          *)
(****************************************************************************)

val genpreord : (DivC.Elem.Preinf DivC.Elem.PG.state ref -> bool) *
                  ((DivC.Elem.Preinf DivC.Elem.PG.state ref *
                    DivC.Elem.Preinf DivC.Elem.PG.state ref) -> bool)
                -> (DivC.Elem.Preinf DivC.Elem.PG.state ref *
                    DivC.Elem.Preinf DivC.Elem.PG.state ref list) *
                   (DivC.Elem.Preinf DivC.Elem.PG.state ref *
                    DivC.Elem.Preinf DivC.Elem.PG.state ref list) -> bool
end

