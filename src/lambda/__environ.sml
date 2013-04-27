(* __environ.sml the structure *)
(*
$Log: __environ.sml,v $
Revision 1.13  1993/05/18 18:48:27  jont
Removed integer parameter

Revision 1.12  1993/03/10  15:28:12  matthew
Signature revisions

Revision 1.11  1993/01/26  09:36:18  matthew
Simplified parameter signature

Revision 1.10  1992/09/25  11:50:21  jont
Removed numerous unused structure parameters

Revision 1.9  1992/06/10  14:02:39  jont
Changed to use newmap

Revision 1.8  1992/03/23  11:00:57  jont
Added requires for __absyn and __interface (was interface)

Revision 1.7  1991/11/21  16:23:16  jont
Added copyright message

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
require "../basics/__identprint";
require "../typechecker/__datatypes";
require "_environ";
require "__environtypes";

structure Environ_ = Environ(structure Crash = Crash_
                             structure Lists = Lists_
                             structure Datatypes = Datatypes_
                             structure IdentPrint = IdentPrint_
                             structure EnvironTypes = EnvironTypes_
                               );
