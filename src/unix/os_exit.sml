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
 * OS-specific version of the EXIT interface (q.v.)
 *
 * This provides the exit_status datatype and fromStatus function to
 * the Unix structure, sharing the types with OS.Process.
 * 
 * Revision Log
 * ------------
 *
 * $Log: os_exit.sml,v $
 * Revision 1.2  1999/05/28 10:44:23  johnh
 * [Bug #190553]
 * Fix require statement for bootstrap compiler.
 *
 *  Revision 1.1  1999/05/13  15:27:18  daveb
 *  new unit
 *  New unit.
 *
 *
 *)

require "^.basis.__word8";

signature OS_EXIT =
  sig
    type status

    datatype exit_status =
      W_EXITED
    | W_EXITSTATUS of Word8.word
    | W_SIGNALED of Word8.word
    | W_STOPPED of Word8.word

    val success : status

    val failure : status

    val isSuccess : status -> bool

    val atExit : (unit -> unit) -> unit

    val exit : status -> 'a

    val terminate : status -> 'a

    val os_exit : exit_status -> 'a

    val fromStatus : status -> exit_status

  end
