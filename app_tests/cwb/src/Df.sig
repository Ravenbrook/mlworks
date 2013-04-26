(*
 *
 * $Log: Df.sig,v $
 * Revision 1.2  1998/06/02 15:17:41  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Df.sig,v 1.2 1998/06/02 15:17:41 jont Exp $";
(*********************************** Df **************************************)
(*                                                                           *)
(* This contains some operations on graphs. The graphs are as in PolyGraph.  *)
(*                                                                           *)
(*****************************************************************************)

signature DF =
sig
   structure PG : POLYGRAPH

   type prop

   val str_eq : ('_a PG.state ref * '_a PG.state ref list) *
                ('_a PG.state ref * '_a PG.state ref list)
                -> (bool * prop)

   val obs_eq : ('_a PG.state ref * '_a PG.state ref list) *
                ('_a PG.state ref * '_a PG.state ref list)
                -> (bool * prop)

   val may_eq : ('_a PG.state ref * '_a PG.state ref list) *
                ('_a PG.state ref * '_a PG.state ref list)
                -> (bool * (bool * (PG.act list)))
end

