(* __primitives.sml the structure *)
(*
$Log: __primitives.sml,v $
Revision 1.3  1991/10/22 15:11:30  davidt
Now builds using the Crash_ structure.

Revision 1.2  91/08/23  11:43:26  jont
Added __pervasives

Revision 1.1  91/07/10  11:28:48  jont
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

require "../utils/__crash";
require "../utils/__lists";
require "../utils/__set";
require "../basics/__ident";
require "../basics/__symbol";
require "../lambda/__environtypes";
require "../lambda/__lambdatypes";
require "../lambda/__environ";
require "__pervasives";
require "_primitives";

structure Primitives_ =
  Primitives(structure Crash = Crash_
	     structure Lists = Lists_
	     structure Set = Set_
	     structure Symbol = Symbol_
	     structure Ident = Ident_
	     structure EnvironTypes = EnvironTypes_
	     structure LambdaTypes = LambdaTypes_
	     structure Environ = Environ_
	     structure Pervasives = Pervasives_);
