(*  ==== BASIS EXAMPLES : Batch structure ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
