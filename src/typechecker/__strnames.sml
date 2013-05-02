(* __strnames.sml the structure *)
(*
$Log: __strnames.sml,v $
Revision 1.8  1995/03/24 15:04:18  matthew
Adding structure Stamp

Revision 1.7  1995/02/02  14:01:17  matthew
Removing debug stuff

Revision 1.6  1993/05/18  19:08:22  jont
Removed integer parameter

Revision 1.5  1992/08/27  18:54:29  davidt
Removed some redundant structure arguments.

Revision 1.4  1992/07/17  10:11:41  jont
added btree parameter

Revision 1.3  1992/01/27  18:29:53  jont
Added ty_debug parameter

Revision 1.2  1991/11/21  16:41:50  jont
Added copyright message

Revision 1.1  91/06/07  11:26:09  colin
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
require "../utils/__print";
require "__datatypes";
require "__stamp";
require "_strnames";

structure Strnames_ = Strnames(
  structure Crash      = Crash_
  structure Print      = Print_
  structure Datatypes  = Datatypes_
  structure Stamp = Stamp_
);
