(* __stack_interface the structure*)
(*
$Log: __stack_interface.sml,v $
Revision 1.1  1995/03/20 11:05:01  matthew
new unit
Machine dependent debugger stuff.

*)

require "../rts/gen/__tags";
require "../utils/__crash";

require "_stack_interface";

structure StackInterface_ =
  StackInterface (structure Tags = Tags_
                  structure Crash = Crash_
                    );

