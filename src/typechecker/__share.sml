(*
$Log: __share.sml,v $
Revision 1.7  1995/02/07 15:28:01  matthew
Removing debug stuff

Revision 1.6  1993/03/17  19:01:28  matthew
Added basistypes structure

Revision 1.5  1992/08/04  12:40:36  davidt
Removed redundant structure argument.

Revision 1.4  1992/03/16  11:15:22  jont
Added require"__debug"

Revision 1.3  1992/01/27  18:16:11  jont
Added ty_debug parameter

Revision 1.2  1991/11/19  19:01:55  jont
Added crash parameter

Revision 1.1  91/06/07  11:22:19  colin
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
require "../typechecker/__datatypes";
require "../typechecker/__valenv";
require "../typechecker/__strnames";
require "../typechecker/__nameset";
require "../typechecker/__sharetypes";
require "__basistypes";
require "../typechecker/_share";

structure Share_ = Share(
  structure Lists = Lists_
  structure Crash = Crash_
  structure IdentPrint = IdentPrint_
  structure Datatypes = Datatypes_	
  structure Sharetypes = Sharetypes_	
  structure Valenv = Valenv_	
  structure Strnames = Strnames_	
  structure Nameset = Nameset_
  structure Print = Print_
  structure BasisTypes = BasisTypes_
    );
  
