(*
 *
 * $Log: init.sml,v $
 * Revision 1.2  1998/08/05 17:40:58  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "utils.sml";
require "universe.sml";
require "pattern.sml";
require "namespace.sml";
require "toplevel.sml";
require "newtop.sml";
require "tactics.sml";
(* init.sml *)

(* initialization function is defined last *)
fun Init(i,e) =
   ( set_inference(i,e);
     Init_universes();
     init_reductions();
     init_namespace();
     init_toplevel();
     init_newtop();
     Config_Qrepl("","","");        (* init Qrepl to leibniz equality *)
     message ((case theory() of lf     => "LF"
                              | xtndCC => "Extended CC"
                              | pureCC => "Pure CC")
              ^": Initial State!") );
