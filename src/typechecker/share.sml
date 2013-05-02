(* share.sml the signature *)
(*
$Log: share.sml,v $
Revision 1.7  1995/02/07 15:29:25  matthew
Adding share_tyfun function

Revision 1.6  1993/05/25  15:23:14  jont
Changes because Assemblies now has Basistypes instead of Datatypes

Revision 1.5  1993/02/08  16:09:29  matthew
Changes for BASISTYPES signature

Revision 1.4  1992/08/11  14:23:05  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.3  1991/11/21  16:53:44  jont
Added copyright message

Revision 1.2  91/11/19  12:19:12  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:03  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:45:21  colin
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

(* Structure sharing. In rules 88,89,90 of the Definition cover the
behaviour of sharing equations. This module performs the necessary
consistency checking and updating of metastrnames. The module
sharetypes does similar work *)

require "assemblies";

signature SHARE = 
  sig
    structure Assemblies : ASSEMBLIES

    exception ShareError of string

    val share_str : Assemblies.Basistypes.Datatypes.Strname *
      Assemblies.Basistypes.Datatypes.Strname * 
      Assemblies.StrAssembly * Assemblies.TypeAssembly * Assemblies.Basistypes.Nameset -> 
      bool * Assemblies.StrAssembly * Assemblies.TypeAssembly

  end
