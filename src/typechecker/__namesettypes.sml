(* datatype declaration for nameset *)
(* removed from basistypes *)
(*
$Log: __namesettypes.sml,v $
Revision 1.1  1993/03/18 14:57:05  matthew
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

require "../utils/_hashset";
require "../utils/__crash";
require "../utils/__lists";
require "__datatypes";
require "__namehash";
require "__types";
require "__strnames";
require "_namesettypes";

structure NamesetTypes_ =
  NamesetTypes(structure TynameSet = HashSet(structure Crash = Crash_
                                             structure Lists = Lists_
                                             type element = Datatypes_.Tyname
                                             val eq = Types_.tyname_eq
                                             val hash = NameHash_.tyname_hash
                                               )
               structure StrnameSet = HashSet(structure Crash = Crash_
                                              structure Lists = Lists_
                                              type element = Datatypes_.Strname
                                              val eq = Strnames_.strname_eq
                                              val hash = NameHash_.strname_hash
                                                ))
