(*
 *
 * $Log: Contract.sig,v $
 * Revision 1.2  1998/06/02 15:16:30  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Contract.sig,v 1.2 1998/06/02 15:16:30 jont Exp $";
(********************************** Contract *********************************)
(*                                                                           *)
(*  This file contains the code for computing a contraction relating two     *)
(*  agent graphs if one exists, or else reporting that one does not exist.   *)
(*  (A contraction exists between P and Q if P and Q are equivalent, but     *)
(*  P never need do more tau moves than Q).          Faron Moller  April-90  *)
(*                                                                           *)
(*****************************************************************************)

signature CONTRACT =
sig
   structure PG : POLYGRAPH

   val contraction : ('_a PG.state ref * '_a PG.state ref list) *
                     ('_a PG.state ref * '_a PG.state ref list) -> bool
end

