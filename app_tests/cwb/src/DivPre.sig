(*
 *
 * $Log: DivPre.sig,v $
 * Revision 1.2  1998/06/02 15:19:15  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: DivPre.sig,v 1.2 1998/06/02 15:19:15 jont Exp $";
(********************************** DivPre ***********************************)
(*                                                                           *)
(*             Signature for Preorder Checking                               *)
(*                                                                           *)
(*  Modified to run under Bell ML compiler - April 1989 - Jo Blishen         *)
(*                                                                           *)
(*****************************************************************************)

signature DIVPRE =
sig
   structure Elem : ELEM

   val strongpreorder :
       (Elem.Preinf Elem.PG.state ref * Elem.Preinf Elem.PG.state ref list) *
       (Elem.Preinf Elem.PG.state ref * Elem.Preinf Elem.PG.state ref list)
       ->  bool
   val weakpreorder :
       (Elem.Preinf Elem.PG.state ref * Elem.Preinf Elem.PG.state ref list) *
       (Elem.Preinf Elem.PG.state ref * Elem.Preinf Elem.PG.state ref list)
       ->  bool
   val precongruence :
       (Elem.Preinf Elem.PG.state ref * Elem.Preinf Elem.PG.state ref list) *
       (Elem.Preinf Elem.PG.state ref * Elem.Preinf Elem.PG.state ref list)
       ->  bool
   val strongequivalence :
       (Elem.Preinf Elem.PG.state ref * Elem.Preinf Elem.PG.state ref list) *
       (Elem.Preinf Elem.PG.state ref * Elem.Preinf Elem.PG.state ref list)
       ->  bool
   val weakequivalence :
       (Elem.Preinf Elem.PG.state ref * Elem.Preinf Elem.PG.state ref list) *
       (Elem.Preinf Elem.PG.state ref * Elem.Preinf Elem.PG.state ref list)
       ->  bool
   val weakcongruence :
       (Elem.Preinf Elem.PG.state ref * Elem.Preinf Elem.PG.state ref list) *
       (Elem.Preinf Elem.PG.state ref * Elem.Preinf Elem.PG.state ref list)
       ->  bool
   val twothirds :
       (Elem.Preinf Elem.PG.state ref * Elem.Preinf Elem.PG.state ref list) *
       (Elem.Preinf Elem.PG.state ref * Elem.Preinf Elem.PG.state ref list)
       ->  bool
end

