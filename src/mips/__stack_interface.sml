(* __stack_interface the structure*)
(*
$Log: __stack_interface.sml,v $
Revision 1.1  1995/03/20 11:02:31  matthew
new unit
add _stack_interface.sml
Machine dependent debugger stuff.

*)

require "../rts/gen/__tags";
require "../utils/__crash";

require "_stack_interface";

structure StackInterface_ =
  StackInterface (structure Tags = Tags_
                  structure Crash = Crash_
                    );

