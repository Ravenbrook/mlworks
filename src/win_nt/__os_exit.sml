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
 * Platform-specific implementation of the EXIT signature (q.v.).
 * Also see the OS_EXIT signature.
 * Note that we use opaque signature matching here, but can't use it
 * when matching against the EXIT signature, as we need to share types
 * between Windows and OS.Process.
 *
 * This implementation is copied from the original Exit structure.
 *
 * Revision Log
 * ------------
 *
 * $Log: __os_exit.sml,v $
 * Revision 1.2  1999/05/28 13:32:36  johnh
 * [Bug #190553]
 * Fix require statements for bootstrap compiler.
 *
 *  Revision 1.1  1999/05/13  15:28:10  daveb
 *  new unit
 *
 *  New unit.
 *
 *
 *
 *)

require "^.basis.__sys_word";
require "os_exit";

structure OSExit :> OS_EXIT = 
  struct
    open MLWorks.Internal.Exit;

    type exit_status = SysWord.word

    val os_exit = exit

    fun fromStatus s = s

    fun isSuccess s = (s = SysWord.fromInt 0)
    (* Word literals don't seem to be overloaded on SysWord.word. *)

    fun atExit action = (ignore(MLWorks.Internal.Exit.atExit action); ())
  end;
