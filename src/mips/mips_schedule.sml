(* 
 Copyright (c) 1993 Harlequin Ltd.
 
 based on ???
 
 Revision Log
 ------------
 $Log: mips_schedule.sml,v $
 Revision 1.5  1997/05/06 09:45:37  jont
 [Bug #30088]
 Get rid of MLWorks.Option

 * Revision 1.4  1997/01/24  14:46:17  matthew
 * Adding CompilerOptions parameter
 *
 * Revision 1.3  1995/12/22  13:20:51  jont
 * Add extra field to procedure_parameters to contain old (pre register allocation)
 * spill sizes. This is for the i386, where spill assignment is done in the backend
 *
Revision 1.2  1993/11/17  14:13:46  io
Deleted old SPARC comments and fixed type errors

 *)
 
require "mips_assembly";

signature MIPS_SCHEDULE = sig
  structure Mips_Assembly : MIPS_ASSEMBLY

  val reschedule_proc :
    bool ->
    (Mips_Assembly.MirTypes.tag *
     (Mips_Assembly.MirTypes.tag *
      (Mips_Assembly.opcode * Mips_Assembly.MirTypes.tag option * string) list) list)
    ->
    (Mips_Assembly.MirTypes.tag *
     (Mips_Assembly.MirTypes.tag *
      (Mips_Assembly.opcode * Mips_Assembly.MirTypes.tag option * string) list) list)
    (* Inter block rescheduling to move instructions back from destination *)
    (* blocks into delay slots for conditional branches where possible *)

end
