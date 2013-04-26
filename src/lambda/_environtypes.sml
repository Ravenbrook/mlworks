(* _environtypes.sml the functor *)
(*
$Log: _environtypes.sml,v $
Revision 1.17  1996/11/22 12:03:33  matthew
Removing reference to MLWorks.Option

 * Revision 1.16  1996/02/23  16:58:41  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.15  1995/12/22  17:02:56  jont
 * Remove references to option structure
 * in favour of MLWorks.Option
 *
Revision 1.14  1995/01/19  12:34:34  matthew
Tidying up

Revision 1.13  1994/02/21  18:44:01  nosa
Debugger environments for Modules Debugger.

Revision 1.12  1994/01/20  10:21:04  nosa
Paths in LAMBs for dynamic pattern-redundancy reporting

Revision 1.11  1993/07/05  12:41:41  daveb
Removed exception environments and interfaces.

Revision 1.10  1993/03/24  12:22:54  nosa
Matthew's Signature revisions

Revision 1.9  1993/01/26  09:44:31  matthew
Rationalised substructures.

Revision 1.8  1992/08/26  11:56:25  jont
Removed some redundant structures and sharing

Revision 1.7  1992/06/15  16:44:45  jont
Added EXTERNAL constructor to COMP

Revision 1.6  1992/06/10  13:19:46  jont
Changed to use newmap

Revision 1.5  1991/10/08  18:01:41  davidt
Changed the type comp so that record selection now retains the total
size of the record as well as just the index

Revision 1.4  91/07/12  16:12:13  jont
Added exception environemtn to env

Revision 1.3  91/07/11  09:08:23  jont
Changed Fun_Env to use comp

Revision 1.2  91/07/08  17:52:21  jont
Added functor environment

Revision 1.1  91/06/11  11:01:00  jont
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

require "../utils/map";
require "lambdatypes";
require "environtypes";

functor EnvironTypes
  (structure LambdaTypes: LAMBDATYPES
   structure NewMap: MAP
  ) : ENVIRONTYPES =
struct
  structure Ident = LambdaTypes.Ident
  structure LambdaTypes = LambdaTypes
  structure NewMap = NewMap

  datatype ValSpec =
    STRIDSPEC of LambdaTypes.Ident.LongStrId |
    VARSPEC of LambdaTypes.LVar |
    NOSPEC

  datatype comp =
    EXTERNAL | (* Place holder to say translate otherwise *)
    LAMB of LambdaTypes.LVar * ValSpec |
    FIELD of {index : int, size : int} | (* Field selectors in structures *)
    PRIM of LambdaTypes.Primitive (* Primitive functions, numbers on the wall *)

  datatype Env =
    ENV of (Ident.ValId, comp) NewMap.map *
           (Ident.StrId, Env * comp * bool) NewMap.map
    
  datatype Fun_Env =
    FUN_ENV of (Ident.FunId, comp * Env * bool) NewMap.map

  datatype Top_Env = TOP_ENV of Env * Fun_Env
  
  datatype Foo = LVARFOO of LambdaTypes.LVar | INTFOO of int

  datatype DebuggerExp =
    NULLEXP |
    LAMBDAEXP of {index : int, size : int} list * (LambdaTypes.LVar * LambdaTypes.LVar)
    * LambdaTypes.Tyfun ref option |
    LAMBDAEXP' of {index : int, size : int} list * Foo ref * LambdaTypes.Tyfun ref option |
    INT of int

  datatype DebuggerEnv = 
    DENV of (LambdaTypes.Ident.ValId, DebuggerExp) NewMap.map *
    (LambdaTypes.Ident.StrId, DebuggerStrExp) NewMap.map

  and DebuggerStrExp =
    LAMBDASTREXP of {index : int, size : int} list 
                     * (LambdaTypes.LVar * LambdaTypes.LVar) * LambdaTypes.Structure |
    LAMBDASTREXP' of {index : int, size : int} list * Foo ref * LambdaTypes.Structure |
    DENVEXP of DebuggerEnv


end
