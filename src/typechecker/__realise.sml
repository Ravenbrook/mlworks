(*
$Log: __realise.sml,v $
Revision 1.12  1995/02/02 14:25:33  matthew
Rationalizations

Revision 1.11  1995/01/30  11:52:02  matthew
Removing redundant debugger structures.

Revision 1.10  1993/08/11  15:37:21  nosa
structure Lists.

Revision 1.9  1993/03/04  11:50:47  matthew
Added Info structure

Revision 1.8  1993/02/19  12:26:38  matthew
Added Scheme and Tystr structures

Revision 1.7  1993/02/08  19:09:31  matthew
Changes for BASISTYPES signature

Revision 1.6  1992/08/12  11:14:26  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.5  1992/08/04  13:24:44  jont
Anel's changes to use NewMap instead of Map

Revision 1.4  1992/01/27  18:07:15  jont
Added ty_debug parameter

Revision 1.3  1991/11/19  19:10:19  jont
Added crash parameter

Revision 1.2  91/07/16  17:22:03  colin
added structure Valenv as an argument

Revision 1.1  91/06/07  11:19:34  colin
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

require "../utils/__print";
require "../utils/__crash";
require "../utils/__lists";
require "../main/__info";
require "../basics/__identprint";
require "../typechecker/__strnames";
require "../typechecker/__types";
require "../typechecker/__valenv";
require "../typechecker/__tyenv";
require "../typechecker/__strenv";
require "../typechecker/__environment";
require "../typechecker/__sigma";
require "../typechecker/__nameset";
require "__scheme";
require "../typechecker/_realise";

structure Realise_ = Realise(
  structure Print     = Print_
  structure Crash     = Crash_
  structure Lists     = Lists_
  structure IdentPrint = IdentPrint_
  structure Strnames  = Strnames_
  structure Types     = Types_
  structure Valenv    = Valenv_
  structure Tyenv     = Tyenv_
  structure Strenv    = Strenv_
  structure Env       = Environment_
  structure Sigma     = Sigma_
  structure Scheme    = Scheme_
  structure Nameset   = Nameset_
  structure Info      = Info_
)

