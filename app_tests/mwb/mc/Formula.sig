(*
 *
 * $Log: Formula.sig,v $
 * Revision 1.2  1998/06/11 13:16:14  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature FORMULA =
sig

    structure CST : CONSTANT
    structure ACT : ACTION
    structure P : PROPVAR


  (* Slightly altered from Dam-Concur'93:                              *)
  (*                                                                   *)
  (*      - Basic prop's on actions, not names                         *)
  (*      - (because) <> and [] are binders                            *)
  (*      - Two version of sigma-propositions, one for output, one for *)
  (*        bound output                                               *)
  (*      - No use of lambda/app on names -                            *)
  (*        these should appear in syntax, but                         *)
  (*        eliminated at this point                                   *)
  (*      - Fixed point formulas (minus root) are assumed to be closed *)
  (*        at this point. This can easily be relaxed at syntax level  *)
  (*      - Use de Bruijn indexes                                      *)

  type variable

  type formula

  type fixed_point_formula

  exception not_closed_formula of string

  exception not_syntactically_monotone of string

  exception bug

  exception dual_not_yet_implemented

  val mkstr : formula -> string

  (* SUBSTITUTIONS *)

  val subst: ACT.N.name -> ACT.N.name -> formula -> formula

  (* CONSTRUCTORS *)

  val mk_true: formula

  val mk_false: formula

  val mk_eq: ACT.N.name -> ACT.N.name -> formula

  val mk_ineq: ACT.N.name -> ACT.N.name -> formula

  val mk_and: formula -> formula -> formula

  val mk_big_and: formula list -> formula

  val mk_or: formula -> formula -> formula

  val mk_big_or: formula list -> formula

  val mk_diamond: ACT.action -> formula -> formula

  val mk_box: ACT.action -> formula -> formula

  val mk_rooted_var: P.propvar -> (ACT.N.name list) -> formula

  val mk_rooted_gfp: P.propvar -> (ACT.N.name list) ->
                                     formula -> (ACT.N.name list) -> formula

  val mk_rooted_lfp: P.propvar -> (ACT.N.name list) ->
                                     formula -> (ACT.N.name list) -> formula

  val mk_rooted_con: CST.constant -> (ACT.N.name list) -> formula

  val mk_sigma: ACT.N.name -> formula -> formula

  val mk_bsigma: ACT.N.name -> formula -> formula

  val mk_pi: ACT.N.name -> formula -> formula

  val mk_exists: ACT.N.name -> formula -> formula

  val mk_not: formula -> formula

(* TESTERS *)

  val is_true: formula -> bool

  val is_false: formula -> bool

  val is_eq: formula -> bool

  val is_neq: formula -> bool

  val is_and: formula -> bool

  val is_or: formula -> bool

  val is_diamond_unbarred: formula -> bool

  val is_diamond_barred: formula -> bool

  val is_diamond_tau: formula -> bool

  val is_box_unbarred: formula -> bool

  val is_box_barred: formula -> bool

  val is_box_tau: formula -> bool

  val is_rooted_var: formula -> bool

  val is_rooted_gfp: formula -> bool

  val is_rooted_lfp: formula -> bool

  val is_rooted_con: formula -> bool

  val is_sigma: formula -> bool

  val is_bsigma: formula -> bool

  val is_pi: formula -> bool

  val is_exists: formula -> bool

  val is_GFP: fixed_point_formula -> bool

(* DESTRUCTORS *)

  val eq_left: formula -> ACT.N.name

  val eq_right: formula -> ACT.N.name

  val select_left: formula -> formula

  val select_right: formula -> formula

  val successor: ACT.N.name -> formula -> formula

  val get_propvar: fixed_point_formula -> P.propvar

  val get_arity: fixed_point_formula -> int

  val get_body: fixed_point_formula -> (ACT.N.name list) -> formula

  (* root (sigma X.F) nl roots sigma X.F at nl *)
  val root: fixed_point_formula -> (ACT.N.name list) -> formula

  val unroot: formula -> fixed_point_formula

  val params: formula -> ACT.N.name list

  (* Given U and rooted fixed point formula sigma X.F, assumed to be the *)
  (* formula associated to U,                                            *)
  (* unfold U (sigma X.F) computes F with U substituted for X            *)
  val unfold: CST.constant -> formula -> formula

  val constants: fixed_point_formula -> CST.constant list

  (* hack to unpack a RootedCon /BV *)
  val constant: formula -> CST.constant

  val free_names: formula -> ACT.N.name list

end
