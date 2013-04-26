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

 * Ensure that the debugger doesn't stumble over fake frames 
 * that are created when an exception is raised.  In particular
 * see <URI:hope://MLWsrc/rts/src/arch/I386/interface.S#ml_raise>
 * and <URI:hope://MLWsrc/rts/src/arch/MIPS/interface.S#ml_raise>.
 * 
 * Revision Log
 * ------------
 * $Log: exception.sml,v $
 * Revision 1.2  1998/04/27 10:34:52  johnh
 * [Bug #30229]
 * Reflect recent changes to mode options.
 *
 *  Revision 1.1  1996/11/14  10:16:49  stephenb
 *  new unit
 *  [Bug #1760]
 *
 *
 *)

Shell.Options.Mode.debugging ();

exception Foo;

fun foldl f z [] = raise Foo
  | foldl f z (x::xs) = foldl f (f (z, x)) xs;


fun sum xs = foldl op+ 0 xs;

let
  val x = sum [1,2,3];
in
  ()
end;
