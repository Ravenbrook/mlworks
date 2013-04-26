(*
 *
 * $Log: Elem.sig,v $
 * Revision 1.2  1998/06/02 15:20:01  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Elem.sig,v 1.2 1998/06/02 15:20:01 jont Exp $";
(*********************************** Elem ************************************)
(*                                                                           *)
(*         Signature to provide elementary functions on states               *)
(*                                                                           *)
(*****************************************************************************)

signature ELEM =
sig
   structure PG : POLYGRAPH

   type Div               (* Lists the local divergence potential           *)
   type accset            (* Additional information for testing equivalence *)
   type Preinf            (* Includes the entire additional information     *)
                          (* which is needed for preorder checking.         *)
                          (* Components are Div, App and accset             *)
   type App               (* List the states wich are upper approximates of *)
                          (* the considered state                           *)

   val compgldivref       : '_a PG.state ref -> bool ref
   val compprdiv          : '_a PG.state ref -> bool
   val compsuc            : '_a PG.state ref
                               -> (PG.act * '_a PG.state ref list ref) list ref
   val compinfo           : '_a PG.state ref -> '_a
   val divinf             : Preinf PG.state ref -> PG.act list
   val approxinf          : Preinf PG.state ref -> Preinf PG.state ref list
   val accsetinf          : Preinf PG.state ref -> accset
   val infocompdivref     : Preinf PG.state ref -> PG.act list ref
   val infocompappref     : Preinf PG.state ref -> Preinf PG.state ref list ref
   val infocompaccsetref  : Preinf PG.state ref -> accset ref
   val actsuclist         : PG.act * '_a PG.state ref -> '_a PG.state ref list
   val getaccsetref       : Preinf -> (accset ref)

   val setpreinf          : Preinf
   val preinfcongrcl      : Preinf PG.state ref -> Preinf

   val actmem             : PG.act * PG.act list -> bool
   val actlistinclusion   : PG.act list * PG.act list -> bool
   val stateeq            : '_a PG.state ref * '_a PG.state ref -> bool
   val statemem           : '_a PG.state ref * '_a PG.state ref list -> bool
   val statelistinclusion : '_a PG.state ref list * '_a PG.state ref list -> bool
   val statelistinters    : '_a PG.state ref list * '_a PG.state ref list -> bool
end

