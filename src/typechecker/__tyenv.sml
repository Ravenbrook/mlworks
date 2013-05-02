(*
$Log: __tyenv.sml,v $
Revision 1.9  1995/02/07 11:55:08  matthew
Removing debug structure

Revision 1.8  1993/02/19  11:32:11  matthew
Changed Conenv to Valenv.
,

Revision 1.7  1992/08/11  17:58:11  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.6  1992/08/03  10:23:04  jont
Anel's changes to use NewMap instead of Map

Revision 1.5  1992/07/16  19:06:32  jont
added btree parameter

Revision 1.4  1992/04/15  13:40:05  jont
Changed to require __lists instead of __set

Revision 1.3  1992/01/27  18:32:46  jont
Added ty_debug parameter

Revision 1.2  1991/11/19  17:30:32  jont
Added crash parameter

Revision 1.1  91/06/07  11:27:38  colin
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
require "../utils/__crash";
require "../basics/__identprint";
require "__types";
require "__scheme";
require "__valenv";
require "_tyenv";

structure Tyenv_ = Tyenv(
  structure Lists     = Lists_
  structure IdentPrint = IdentPrint_
  structure Print     = Print_
  structure Crash     = Crash_
  structure Types     = Types_
  structure Scheme    = Scheme_
  structure Valenv    = Valenv_
)
