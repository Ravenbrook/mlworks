(*
$Log: __derived.sml,v $
Revision 1.12  1995/02/14 12:15:23  matthew
Removing structure Options

Revision 1.11  1993/12/08  10:43:21  nickh
Added IdentPrint so that we can report a tycon in the withtype expansion.

Revision 1.10  1993/08/13  15:56:18  nosa
structure Options.

Revision 1.9  1993/05/18  18:06:05  jont
Removed integer parameter

Revision 1.8  1993/02/23  13:43:58  matthew
Added parserenv structure

Revision 1.7  1993/02/03  13:31:07  matthew
Rationalised functor parameter

Revision 1.6  1992/11/10  15:56:52  matthew
Changed Error structure to Info

Revision 1.5  1992/09/09  14:00:11  matthew
Improved error messages.

Revision 1.4  1992/04/13  13:30:28  clive
First version of the profiler

Revision 1.3  1992/02/14  13:09:26  jont
Added integer and lists parameters

Revision 1.2  1991/11/19  17:20:39  jont
Added Crash parameter

Revision 1.1  91/06/07  16:16:27  colin
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
require "../utils/_counter";
require "../utils/__crash";
require "../basics/__absyn";
require "../basics/__identprint";
require "../main/__info";
require "__parserenv";
require "_derived";

structure Derived_ = Derived(
  structure Lists     = Lists_
  structure Counter   = Counter()
  structure Crash     = Crash_
  structure Absyn     = Absyn_
  structure IdentPrint= IdentPrint_
  structure PE        = ParserEnv_
  structure Info = Info_
)

