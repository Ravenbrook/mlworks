(* __basis.sml the structure *)
(*
$Log: __basis.sml,v $
Revision 1.9  1996/09/25 14:11:32  andreww
[Bug #1593]
Adding Stamp structure to the basis functor.

 * Revision 1.8  1995/02/07  16:05:18  matthew
 * Adding Strenv structure
 *
Revision 1.7  1995/01/30  11:46:13  matthew
Rationalizing debugger

Revision 1.6  1993/02/08  18:19:36  matthew
Changes for BASISTYPES signature

Revision 1.5  1992/10/01  12:08:05  richard
Added Types structure parameter.

Revision 1.4  1992/08/11  18:37:44  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.3  1992/01/27  17:33:38  jont
Added ty_debug parameter

Revision 1.2  1991/11/21  16:37:55  jont
Added copyright message

Revision 1.1  91/06/07  11:10:10  colin
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
require "../utils/__print";
require "../basics/__identprint";
require "__valenv";
require "__strenv";
require "__tyenv";
require "__scheme";
require "__nameset";
require "__environment";
require "__sigma";
require "__types";
require "__stamp";
require "_basis";
  
structure Basis_ = Basis(
  structure Stamp = Stamp_
  structure IdentPrint = IdentPrint_
  structure Valenv = Valenv_
  structure Strenv = Strenv_
  structure Tyenv = Tyenv_
  structure Nameset = Nameset_
  structure Scheme = Scheme_
  structure Env = Environment_
  structure Sigma = Sigma_
  structure Types = Types_
  structure Lists = Lists_
  structure Print = Print_
);
