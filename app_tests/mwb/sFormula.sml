(*
 *
 * $Log: sFormula.sml,v $
 * Revision 1.2  1998/06/11 13:07:33  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
functor StringFormula(structure PropVar: SPROPVAR
(*                 structure Constant: CONSTANT *)
                structure Act: SACTION): SFORMULA =
struct

(*   structure CST = Constant *)
  structure ACT = Act
  structure P = PropVar


(*     datatype variable = ACT.N.name *)
    datatype formula = True (* of unit *)
                   | False (* of unit *)
                   | IsEq of ACT.N.name * ACT.N.name
                   | IsNeq of ACT.N.name * ACT.N.name
                   | And of formula * formula
                   | Or of formula * formula
                   | Diamond of ACT.action * formula
                   | Box of ACT.action * formula
                   | RootedVar of P.propvar * ACT.N.name list
                   | RootedGFP of
                         P.propvar * ACT.N.name list * formula * ACT.N.name list
                   | RootedLFP of
                         P.propvar * ACT.N.name list * formula * ACT.N.name list
(*                    | RootedCon of CST.constant * ACT.N.name list *)
                   | Sigma of ACT.N.name * formula
                   | BSigma of ACT.N.name * formula
                   | Pi of ACT.N.name * formula
                   | Exists of ACT.N.name * formula
		   | Not of formula

end;    (* Formula *)
