(* datatype declaration for nameset *)
(* removed from basistypes *)
(*
$Log: _namesettypes.sml,v $
Revision 1.1  1993/03/18 14:56:49  matthew
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

require "../utils/hashset";
require "namesettypes";


functor NamesetTypes (structure TynameSet : HASHSET
                      structure StrnameSet : HASHSET) : NAMESETTYPES =
  struct
    structure TynameSet = TynameSet
    structure StrnameSet = StrnameSet

    (****
     Nameset is one of the semantic objects for the Modules.  In this
     structure the type and the operations on it are defined.
     ****)

    (****
     Nameset is one of the semantic objects for the Modules.  In this
     structure the type and the operations on it are defined.
     ****)

    datatype Nameset =  NAMESET of (TynameSet.HashSet * StrnameSet.HashSet)
  end

                        
