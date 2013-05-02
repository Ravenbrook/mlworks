(* __enc_sub.sml the structure *)
(*
$Log: __enc_sub.sml,v $
Revision 1.6  1996/02/22 14:18:40  jont
Remove __map parameter

 * Revision 1.5  1992/03/19  12:44:20  clive
 * Changed hashtables to a single structure implementation
 *
Revision 1.4  1992/03/19  12:44:20  jont
Added some more hashtables

Revision 1.3  1992/03/16  13:13:09  jont
Added hash tables for encoding of common types (fun, rec, cons) and also
metatynames.

Revision 1.2  1992/02/11  13:17:16  richard
Changed the application of the Diagnostic functor to take the Text
structure as a parameter.  See utils/diagnostic.sml for details.

Revision 1.1  1992/01/22  16:31:14  jont
Initial revision

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

require "../utils/__text";
require "../utils/__lists";
require "../utils/__crash";
require "../utils/_diagnostic";
require "../typechecker/__datatypes";
require "_enc_sub";

structure Enc_Sub_ = Enc_Sub(
  structure Lists = Lists_
  structure Crash = Crash_
  structure Diagnostic = Diagnostic(structure Text = Text_)
  structure DataTypes = Datatypes_
)
