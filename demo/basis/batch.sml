(*  ==== BASIS EXAMPLES : BATCH signature ====
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
 *  $Log: batch.sml,v $
 *  Revision 1.1  1996/08/09 16:08:42  davids
 *  new unit
 *
 *
 *)

signature BATCH =
  sig

    (* Attempt to execute all of the command line arguments.  If they are 
     all executed successfully, the function will exit the process
     with 'success' status.  Otherwise, it will exit with 'failure' status
     without executing any further commands. *)

    val batch : unit -> unit

  end


