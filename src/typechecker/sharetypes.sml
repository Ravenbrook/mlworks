(* sharetypes.sml the signature *)
(*
$Log: sharetypes.sml,v $
Revision 1.7  1996/03/27 16:59:58  matthew
Updating for new language revisions

 * Revision 1.6  1993/05/25  15:33:39  jont
 * Changes because Assemblies now has Basistypes instead of Datatypes
 *
Revision 1.5  1993/05/20  16:29:02  jont
Avoid updating flexible names in the basis (when doing sharng in functor results)

Revision 1.4  1992/08/11  14:22:20  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.3  1991/11/21  16:53:57  jont
Added copyright message

Revision 1.2  91/11/19  12:19:14  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:04  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:45:33  colin
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

(* This module performs the updating of metatynames and metatyfuns to
obey the typename sharing rule (89 in the Definition). It is only
called when following this rule (from mod_rules.sml). *)

require "namesettypes";
require "assemblies";

signature SHARETYPES = 
  sig
    structure Assemblies : ASSEMBLIES
    structure NamesetTypes : NAMESETTYPES
    sharing type Assemblies.Basistypes.Nameset = NamesetTypes.Nameset
    exception ShareError of string

    val share_tyfun : bool * Assemblies.Basistypes.Datatypes.Tyfun * Assemblies.Basistypes.Datatypes.Tyfun *
      Assemblies.TypeAssembly * NamesetTypes.Nameset -> bool * Assemblies.TypeAssembly
  end
