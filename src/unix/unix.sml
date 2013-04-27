(*  The Unix signature
 * 
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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


