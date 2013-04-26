(*  ==== BASIS EXAMPLES : Batch structure ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module demonstrates the OS.Process structure in the basis library.
 *  It defines a function that will execute multiple commands, and report upon
 *  their success.  Note that this module should be delivered to an image file
 *  or executable rather than run from a Listener.
 *
 *  Revision Log
 *  ------------
 *  $Log: __batch.sml,v $
 *  Revision 1.2  1996/09/04 11:51:59  jont
 *  Make require statements absolute
 *
 *  Revision 1.1  1996/08/09  16:08:17  davids
 *  new unit
 *
 *
 *)

require "batch";
require "$.system.__os";

structure Batch : BATCH =
  struct

    (* Attempt to execute all commands in the list.  If all commands
     are executed successfully, the function will exit the process
     with 'success' status.  Otherwise, it will exit with 'failure' status
     without executing any further commands. *)

    fun runFiles [] = OS.Process.exit OS.Process.success

      | runFiles (file::rest) =

        if OS.Process.system (file) = OS.Process.success then
	  (* Register a message noting success to report later. *)
          (OS.Process.atExit 
	   (fn () => print (file ^ " executed sucessfully.\n"));
           runFiles rest)

        else
	  (* Report failure and exit process. *)
          (print ("Failure reported executing file " ^ file ^ "\n");
           OS.Process.exit OS.Process.failure)

        handle OS.SysErr (message, error) => 
	  (* Report error and exit process. *)
          (print ("Unable to execute file " ^ file ^
		  "due to system error:\n" ^ message ^ "\n");
           OS.Process.exit OS.Process.failure)


    (* Attempt to execute all of the command line arguments given. *)

    fun batch () = runFiles (MLWorks.arguments ())

  end
