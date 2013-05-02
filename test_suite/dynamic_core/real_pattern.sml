(*

Result: OK
 
$Log: real_pattern.sml,v $
Revision 1.6  1997/11/21 10:52:52  daveb
[Bug #30323]

 * Revision 1.5  1997/05/28  12:14:33  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.4  1996/11/05  13:07:46  andreww
 * [Bug #1711]
 * real not eqtype in sml'96.
 *
 * Revision 1.3  1996/05/22  10:54:53  daveb
 * Renamed Shell.Module to Shell.Build.
 *
 * Revision 1.2  1996/05/01  17:38:43  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/11/17  18:50:10  jont
 * Initial revision
 *
Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition,true);

fun f 0.0 = 0.0
|   f x = (print(Real.toString x); print"\n"; f (x / 2.0))

val it = (f 0.0, f 1.0)
