(* i386_schedule.sml the signature *)
(*
$Log: i386_schedule.sml,v $
Revision 1.3  1997/05/01 12:38:32  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.2  1995/12/20  14:18:47  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.1  1994/09/08  12:20:20  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

require "i386_assembly";

signature I386_SCHEDULE = sig
  structure I386_Assembly : I386_ASSEMBLY

  val reschedule_block :
    (I386_Assembly.opcode * I386_Assembly.tag option * string) list ->
    (I386_Assembly.opcode * I386_Assembly.tag option * string) list
    (* Internal block rescheduling to move instructions forward into *)
    (* delay slots where possible *)

  val reschedule_proc :
    (I386_Assembly.tag *
     (I386_Assembly.tag *
      (I386_Assembly.opcode * I386_Assembly.tag option * string) list) list)
    ->
    (I386_Assembly.tag *
     (I386_Assembly.tag *
      (I386_Assembly.opcode * I386_Assembly.tag option * string) list) list)
    (* Inter block rescheduling to move instructions back from destination *)
    (* blocks into delay slots for conditional branches where possible *)

end
