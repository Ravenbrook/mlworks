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
 *  Revision Log
 *  ------------
 *  $Log: os_process.sml,v $
 *  Revision 1.4  1999/03/20 22:24:06  daveb
 *  Removed the equality attribute from type status; added isSuccess.
 *
 * Revision 1.3  1996/10/03  15:23:34  io
 * [Bug #1614]
 * remove redundant requires
 *
 * Revision 1.2  1996/05/08  14:19:33  stephenb
 * Pull in toplevel so that MLWorks.Option.option -> option
 *
 * Revision 1.1  1996/04/18  13:41:16  jont
 * new unit
 *
 *  Revision 1.1  1996/04/17  15:29:03  stephenb
 *  new unit
 *
 *  Revision 1.2  1996/03/26  15:08:29  stephenb
 *  Name change required by latest basis revision: PROCESS -> OS_PROCESS
 *
 *  Revision 1.1  1995/04/13  14:07:30  jont
 *  new unit
 *  No reason given
 *
 *)

signature OS_PROCESS =
  sig
    type status

    val success : status

    val failure : status

    val isSuccess : status -> bool

    val system : string -> status

    val atExit : (unit -> unit) -> unit

    val exit : status -> 'a

    val terminate : status -> 'a

    val getEnv : string -> string option
  end
