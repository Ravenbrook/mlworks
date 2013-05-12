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
 * Windows interface to process termination.
 * This provides a set of MLWorks-specific exit codes, and
 * OS-specific exit/terminate functions.
 * 
 * We don't use OS.Process directly because it can't provide
 * the application-specific status values.
 *
 * Any type/value that shares a name with one in OS.Process behaves 
 * according to the description of that type/value in OS.Process.
 *
 * For more information on the additional error codes see where they are
 * used (mainly main/_batch.sml) since their names and values were initially 
 * based on the context in which they were used and the integer values
 * used in that context.
 * 
 * Revision Log
 * ------------
 *
 * $Log: __mlworks_exit.sml,v $
 * Revision 1.2  1999/05/27 10:48:35  johnh
 * [Bug #190553]
 * Fix require statements to fix bootstrap compiler.
 *
 *  Revision 1.1  1999/05/13  15:26:00  daveb
 *  new unit
 *  New unit.
 *
 *
 *)

require "../utils/mlworks_exit";
require "__windows";
require "__sys_word";

structure MLWorksExit :> MLWORKS_EXIT =
  struct
    type status = Windows.Status.status

    val success = SysWord.fromInt 0
    val failure = SysWord.fromInt 1
    val uncaughtIOException = SysWord.fromInt 2
    val badUsage = SysWord.fromInt 3
    val stop = SysWord.fromInt 4
    val save = SysWord.fromInt 5
    val badInput = SysWord.fromInt 6

    val exit = Windows.exit
  end
