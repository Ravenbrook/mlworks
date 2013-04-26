(*
 *
 * $Log: DivComp.sig,v $
 * Revision 1.2  1998/06/02 15:18:31  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: DivComp.sig,v 1.2 1998/06/02 15:18:31 jont Exp $";
(********************************** DivComp **********************************)
(*                                                                           *)
(* This Module handles divergence. It provides functions which:              *)
(*   A) check whether a state has divergence properties                      *)
(*   B) compute the divergence information for a specific transition system  *)
(*                                                                           *)
(* strgldivinf puts the primitive divergence information prdiv in the field  *)
(* referenced by gldiv.                                                      *)
(* strlocdivinf is the extension of the divergence information above to      *)
(* local divergence information (divergence reachable by a visible move).    *)
(* weakgldivinf considers a potential of an infinite invisible behaviour     *)
(* as divergence                                                             *)
(* weaklocdivinf is the extension of the divergence information above to     *)
(* local divergence information (divergence reachable by a visible move).    *)
(* This computation is based on compweakgldivinf. This information is        *)
(* in testdivinf, successors of divergent states are considered as divergent *)
(*****************************************************************************)

signature DIVCOMP =
sig
   structure Elem : ELEM

   val globdivpred   : Elem.Preinf Elem.PG.state ref  ->  bool
   val locdivpred    : Elem.Preinf Elem.PG.state ref * Elem.PG.act ->  bool
   val strgldivinf   : Elem.Preinf Elem.PG.state ref list  ->  bool
   val strlocdivinf  : Elem.Preinf Elem.PG.state ref list  ->  bool
   val weakgldivinf  : Elem.Preinf Elem.PG.state ref list  ->  bool
   val weaklocdivinf : Elem.Preinf Elem.PG.state ref list  ->  bool
   val testdivinf    : Elem.Preinf Elem.PG.state ref list  ->  bool
end

