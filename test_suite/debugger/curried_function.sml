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

Result: OK

 * Test that the debugger can generate correct stack back traces.
 * Specifically for MIPS/386 which used to have a problem with this -- 
 * see bug 1446.
 *
 * Revision Log
 * ------------
 * $Log: curried_function.sml,v $
 * Revision 1.2  1998/04/27 10:29:08  johnh
 * [Bug #30229]
 * Reflect recent changes to modes.
 *
 *  Revision 1.1  1996/10/03  11:35:12  stephenb
 *  new unit
 *
 *)

Shell.Options.Mode.debugging ();

fun foldl f z [] = z
  | foldl f z (x::xs) = foldl f (f (z, x)) xs;

fun sum xs = foldl op+ 0 xs;

Shell.Trace.breakpoint "sum";


(* The following is the correct number of "s"teps and "b"acktraces for
 * the above argument.
 *)
sum [1,2,3];
b
s
b
s
b
s
b
s
b
s
b
s
b
s
b
s
b
s
b
s
b
s
b
s
b
s
b
s
b
s
b
s
