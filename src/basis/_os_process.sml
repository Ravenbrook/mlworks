(* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 * $Log: _os_process.sml,v $
 * Revision 1.4  1999/03/20 22:24:56  daveb
 * Removed the equality attribute from type status; added isSuccess.
 *
 * Revision 1.3  1996/10/03  15:09:05  io
 * [Bug #1614]
 * remove redundant requires
 *
 * Revision 1.2  1996/05/08  14:20:59  stephenb
 * Update wrt move of file "main" to basis.
 *
 * Revision 1.1  1996/04/18  15:11:45  jont
 * new unit
 *
 *  Revision 1.1  1996/04/17  15:30:12  stephenb
 *  new unit
 *
 *
 *)

require "os_process";
require "exit";

functor OSProcess (structure Exit : EXIT) : OS_PROCESS =
  struct
    val env = MLWorks.Internal.Runtime.environment

    type status = Exit.status

    val success = Exit.success

    val failure = Exit.failure

    val isSuccess = Exit.isSuccess

    val system : string -> status = env "system os system"

    val terminate = Exit.terminate

    val atExit = Exit.atExit

    val exit = Exit.exit

    val getEnv : string -> string option = env "system os getenv"

  end
