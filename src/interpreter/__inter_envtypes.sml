(* __inter_envtypes.sml the structure *)
(*
$Log: __inter_envtypes.sml,v $
Revision 1.5  1992/10/27 18:27:11  jont
Removed dependence on _environ

Revision 1.4  1992/10/13  12:51:57  richard
Removed redundant parameters.

Revision 1.3  1992/07/29  09:53:23  jont
Removed references to callc_codes and __callc_codes

Revision 1.2  1992/06/19  17:27:08  jont
Fixed the source errors

Revision 1.1  1992/06/18  12:11:49  jont
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

require "../utils/__lists";
require "../basics/__identprint";
require "../lambda/__environtypes";
require "_inter_envtypes";

structure Inter_EnvTypes_ =
  Inter_EnvTypes(structure Lists = Lists_
                 structure IdentPrint = IdentPrint_
                 structure EnvironTypes = EnvironTypes_);
