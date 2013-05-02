(*
$Log: __absynprint.sml,v $
Revision 1.5  1993/05/18 13:35:15  jont
Removed Integer parameter

Revision 1.4  1992/12/08  18:30:55  jont
Removed a number of duplicated signatures and structures

Revision 1.3  1992/02/14  14:02:28  jont
Added integer parameter

Revision 1.2  1991/11/19  19:25:37  jont
Added crash parameter

Revision 1.1  91/06/07  10:51:30  colin
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
require "../utils/__sexpr";
require "../utils/__lists";
require "../utils/__set";
require "__identprint";
require "__absyn";
require "../typechecker/__types";
require "_absynprint";

structure AbsynPrint_ = AbsynPrint(
  structure Sexpr      = Sexpr_
  structure Set        = Set_
  structure Lists      = Lists_
  structure IdentPrint = IdentPrint_
  structure Absyn      = Absyn_
  structure Types      = Types_
)
