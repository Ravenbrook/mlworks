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
Result: OK

 *
 * Test OS.Process.exit.  Specifically, ensure that :-
 *
 * 1. calling atExit from within a function registered by atExit is a nop.
 * 2. calling exit from within a function registered by atExit is a nop.
 *
 * Does not test :-
 *
 * 3. any exception raised by a function registered with atExit is 
 *    trapped and ignored.
 *
 * because currently if a file with an exception is loaded, 
 * OS.SysErr is raised by the loader and not caught due to exceptions
 * being rebound -- see bug #1273.
 * 
 * Revision Log
 * ------------
 *
 * $Log: os_process_exit_1.sml,v $
 * Revision 1.7  1998/02/18 11:56:01  mitchell
 * [Bug #30349]
 * Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.6  1997/11/21  10:46:01  daveb
 *  [Bug #30323]
 *
 *  Revision 1.5  1997/05/28  11:07:25  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.4  1997/04/01  16:44:36  jont
 *  Modify to sto displaying syserror type
 *
 *  Revision 1.3  1996/05/22  10:19:20  daveb
 *  Shell.Module renamed to Shell.Build.
 *
 *  Revision 1.2  1996/05/01  16:11:46  jont
 *  Fixing up after changes to toplevel visible string and io stuff
 *
 *  Revision 1.1  1996/04/18  11:06:01  stephenb
 *  new unit
 *  Test for OS.Process.exit
 *
 *)

fun out s = print(s ^ "\n");

fun finish () = out "finished.";

fun recursive_atExit () = OS.Process.atExit (fn () => out "Oops");

fun after_exit () = out "after recursive exit, trying atExit case ...";

fun recursive_exit () = 
  (out "Starting recursive exit ...";
   ignore(OS.Process.exit OS.Process.success);
   out "Should never get here");

fun start () = out "starting ...";


OS.Process.atExit finish;
OS.Process.atExit recursive_atExit;
OS.Process.atExit after_exit;
OS.Process.atExit recursive_exit;
OS.Process.atExit start;


val _ = OS.Process.exit OS.Process.failure;
