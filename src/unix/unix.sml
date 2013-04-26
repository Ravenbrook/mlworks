(*  The Unix signature
 * 
 * Copyright (C)  1999 Harlequin Group plc.  All rights reserved.
 * 
 * Revision Log
 * ------------
 * 
 *  $Log: unix.sml,v $
 *  Revision 1.2  1999/05/13 15:27:31  daveb
 *  [Bug #190553]
 *  Added exit_status and fromStatus.
 *
 *  Revision 1.1  1999/01/25  17:58:49  johnh
 *  new unit
 *  New Unix signature.
 *
 * 
 *)

require "^.basis.__text_io";
require "^.basis.__word8";
require "__os";

signature UNIX = 
  sig

    (* represents a handle to the operating system process *)
    type proc

    type signal

    datatype exit_status =
      W_EXITED
    | W_EXITSTATUS of Word8.word
    | W_SIGNALED of signal
    | W_STOPPED of signal

    (* fromStatus sts *)
    val fromStatus : OS.Process.status -> exit_status

    val exit : exit_status -> 'a

    (* executeInEnv (cmd, args, env) 
     *   raises SysErr 
     *)
    val executeInEnv : (string * string list * string list) -> proc

    (* execute (cmd, args)
     *   raise SysErr
     *)
    val execute : (string * string list) -> proc

    val streamsOf : proc -> (TextIO.instream * TextIO.outstream)

    (* reap process 
     *   raises SysErr
     *)
    val reap : proc -> OS.Process.status

    (* kill (process, signal)
     *   raises SysErr
     *)
    val kill : (proc * signal) -> unit

  end


