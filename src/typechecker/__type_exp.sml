(* __type_exp.sml the structure *)
(*
$Log: __type_exp.sml,v $
Revision 1.13  1996/10/28 17:45:47  io
removing Lists

 * Revision 1.12  1995/02/07  16:02:29  matthew
 * Removing Print parameter
 *
Revision 1.11  1993/05/18  18:15:55  jont
Removed integer parameter

Revision 1.10  1993/03/04  11:00:28  matthew
Added Info structure

Revision 1.9  1993/02/22  12:48:37  matthew
Removed debug structures/

Revision 1.8  1993/02/08  18:31:57  matthew
Changes for BASISTYPES signature

Revision 1.7  1992/12/03  10:18:06  daveb
Added Integer parameter to functor.

Revision 1.6  1992/11/04  17:57:19  matthew
Changed Error structure to Info

Revision 1.5  1992/09/04  09:05:49  richard
Installed central error reporting mechanism.

Revision 1.4  1992/08/11  18:53:56  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.3  1992/01/27  18:37:02  jont
Added ty_debug parameter

Revision 1.2  1991/11/21  16:42:13  jont
Added copyright message

Revision 1.1  91/06/07  11:28:26  colin
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

require "^.basics.__absyn";
require "^.main.__info";
require "^.basics.__identprint";
require "^.typechecker.__types";
require "__basis";

require "^.typechecker._type_exp";

structure Type_exp_ =
  Type_exp(structure Absyn     = Absyn_
           structure IdentPrint = IdentPrint_
           structure Types     = Types_
           structure Basis = Basis_
           structure Info = Info_)
