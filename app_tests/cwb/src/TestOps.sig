(*
 *
 * $Log: TestOps.sig,v $
 * Revision 1.2  1998/06/02 15:34:19  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: TestOps.sig,v 1.2 1998/06/02 15:34:19 jont Exp $";
(********************************** TestOps **********************************)
(*                                                                           *)
(* This file contains a signature and functor that encapsulate the testing   *)
(* equivalences and preorders.                       Rance Cleaveland Aug-88 *)
(* The signature for the testing operations:                                 *)
(*      'a state - the type of polymorphic states.                           *)
(*      may_eq   - determines if two polygraphs are "may equivalent".        *)
(*      must_eq  - determines if two polygraphs are "must equivalent".       *)
(*      test_eq  - determines if two polygraphs are "testing equivalent".    *)
(*      may_pr   - determines if first polygraph is less than the second     *)
(*                 polygraph in the may preorder.                            *)
(*      must_pr  - determines if first polygraph is less than the second     *)
(*                 polygraph in the must preorder.                           *)
(*      test_pr  - determines if first polygraph is less than the second     *)
(*                 polygraph in the must preorder.                           *)
(*                                                                           *)
(* Changes:                                                                  *)
(* 26/04/89 (RC)   Fixed bug in "testpr". Openness information was not       *)
(*                 being correctly tested for.                               *)
(*                                                                           *)
(*****************************************************************************)

signature TESTOPS =
sig
   type 'a state
   val may_eq  : ('_a state ref * '_a state ref list) *
                 ('_a state ref * '_a state ref list) -> bool

   val must_eq : ('_a state ref * '_a state ref list) *
                 ('_a state ref * '_a state ref list) -> bool

   val test_eq : ('_a state ref * '_a state ref list) *
                 ('_a state ref * '_a state ref list) -> bool

   val may_pr  : ('_a state ref * '_a state ref list) *
                 ('_a state ref * '_a state ref list) -> bool

   val must_pr : ('_a state ref * '_a state ref list) *
                 ('_a state ref * '_a state ref list) -> bool

   val test_pr : ('_a state ref * '_a state ref list) *
                 ('_a state ref * '_a state ref list) -> bool
end

