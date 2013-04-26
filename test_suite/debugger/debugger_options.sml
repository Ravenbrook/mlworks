(* This tests that the new Shell options to the debugger work correctly.
 *

Result: OK

 * $Log: debugger_options.sml,v $
 * Revision 1.4  1998/04/27 10:33:58  johnh
 * [Bug #30229]
 * Reflect recent changes to mode and compiler options.
 *
 *  Revision 1.3  1997/10/02  09:49:20  jkbrook
 *  [Bug #20088]
 *  Merging from MLWorks_11:
 *  Set maximumStrDepth to 0.
 *
 *  Revision 1.2  1996/09/26  10:17:43  stephenb
 *  [Bug #1562]
 *  Removed the C frame and setup frame tests since these aren't portable.
 *
 *  Revision 1.1  1996/08/08  12:20:52  andreww
 *  new unit
 *  Testing that the debugger options in Shell actually do what their
 *  name suggests (e.g., hide C frames, etc.)
 *
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
 *)

Shell.Options.set (Shell.Options.ValuePrinter.maximumStrDepth, 0);
structure S = Shell.Options;
structure D = Shell.Options.Debugger;
S.Mode.debugging ();    	       (* set debug mode ON *)
fun fact x = if x =0 then 1 else fact (x-1)*x;
Shell.Trace.breakpoint "fact";
fact 4;                                  (*Trace hiding everything *)
s
s
b
q
S.set(D.hideDeliveredFrames,false);     (* don't hide Delivered Frames *)
fact 4;
s
s
b
q
S.set(D.hideDuplicateFrames,false);     (* don't hide Duplicate Frames *)
fact 4;
s
s
b
q


(*

The layout and number of C frames is different of different platforms
so this cannot be tested in a generic test.

S.set(D.hideCFrames,false);             (* don't hide C Frames *)
fact 4;
s
s
b
q



The Irix version doesn't appear to have any setup frames (might be a bug) 
so this cannot be tested at the moment either.

S.set(D.hideSetupFrames,false);         (* don't hide Setup Frames *)
fact 4;
s
s
b
q

*)
