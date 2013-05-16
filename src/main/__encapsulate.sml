(* __encapsulate.sml the structure *)
(*
$Log: __encapsulate.sml,v $
Revision 1.43  1998/01/30 09:44:06  johnh
[Bug #30326]
Merge in change from branch MLWorks_workspace_97

 * Revision 1.42.2.2  1997/11/20  17:09:02  daveb
 * [Bug #30326]
 *
 * Revision 1.42.2.1  1997/09/11  20:56:30  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.42  1997/05/09  10:35:39  jont
 * [Bug #30091]
 * Convert from MLWorks.Internal.FileIO to BinIO from the basis
 *
 * Revision 1.41  1996/02/26  11:28:35  jont
 * Change newhashtable to hashtable
 *
 * Revision 1.40  1995/04/27  12:57:55  matthew
 * Removing Integer structure.
 *
Revision 1.39  1995/03/24  15:55:09  matthew
Adding Stamp

Revision 1.38  1995/03/01  16:29:42  matthew
Removing Diagnostic and Text
,

Revision 1.37  1995/02/07  13:02:53  matthew
Moving pervasive name counts to Basis

Revision 1.36  1994/10/06  10:07:26  matthew
Added IntHashTable

Revision 1.35  1994/06/09  16:05:27  nickh
New runtime directory structure.

Revision 1.34  1994/03/08  17:37:54  jont
Moved module type into separate file

Revision 1.33  1994/02/28  07:14:11  nosa
Deleted structure Encapsulate.Debugger_Env_type.

Revision 1.32  1994/02/21  16:16:20  daveb
Added Info parameter.

Revision 1.31  1993/07/19  12:30:06  nosa
Debugger Environments for local and closure variable inspection
in the debugger.

Revision 1.30  1993/05/28  11:43:55  jont
Cleaned up after assembly changes

Revision 1.29  1993/02/19  11:26:57  jont
Modified to spot common strs. Big size improvement for large .mo files

Revision 1.28  1993/02/09  09:24:34  matthew
Typechecker structure changes

Revision 1.27  1993/01/25  19:25:45  matthew
Changed functor parameter

Revision 1.26  1992/11/02  15:19:25  richard
Added a missing require.

Revision 1.25  1992/10/28  12:02:35  jont
Removed dependence on environ in favour of environtypes

Revision 1.24  1992/10/15  16:24:16  clive
Anel's changes for encapsulating assemblies

Revision 1.23  1992/09/21  10:46:04  clive
Changed hashtables to a single structure implementation

Revision 1.22  1992/08/10  10:39:51  davidt
Deleted various redundant structure arguments.

Revision 1.21  1992/07/24  16:21:42  clive
Use of new hash tables, removed some concatenation and compression of integers in encapsulator

Revision 1.20  1992/07/07  09:42:45  clive
Added call point information recording

Revision 1.19  1992/06/10  17:02:38  jont
changed to use newmap

Revision 1.18  1992/04/23  17:52:02  jont
Added timer parameter

Revision 1.17  1992/04/23  16:43:58  jont
Added timer parameter to functor

Revision 1.16  1992/04/03  09:55:29  jont
Add integer parameter to functor.

Revision 1.15  1992/02/11  14:33:19  richard
Changed the application of the Diagnostic functor to take the Text
structure as a parameter.  See utils/diagnostic.sml for details.

Revision 1.14  1992/02/11  10:27:27  clive
Work on the new pervasive library mechanism

Revision 1.13  1992/01/22  16:34:36  jont
Added Enc_Sub paramter

Revision 1.12  1992/01/10  14:53:55  jont
Added diagnostic parameter

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
require "../utils/__mlworks_timer";
require "../utils/__lists";
require "../utils/__intbtree";
require "../utils/__hashtable";
require "../utils/__inthashtable";
require "../basis/__bin_io";
require "../basis/__bin_prim_io";
require "../parser/__parserenv";
require "../typechecker/__basis";
require "../typechecker/__types";
require "../typechecker/__stamp";
require "../typechecker/__strnames";
require "../typechecker/__nameset";
require "../typechecker/__environment";
require "../lambda/__environtypes";
require "../main/__pervasives";
require "../main/__info";
require "../main/__code_module";
require "../debugger/__debugger_types";
require "__objectfile";
require "__enc_sub";
require "_encapsulate";

structure Encapsulate_ = Encapsulate(
  structure Timer = Timer_
  structure Crash = Crash_
  structure Lists = Lists_
  structure BinIO = BinIO
  structure PrimIO = BinPrimIO
  structure IntMap = IntBTree_
  structure ParserEnv = ParserEnv_
  structure Basis = Basis_
  structure Nameset = Nameset_
  structure Types = Types_
  structure Stamp = Stamp_
  structure Strnames = Strnames_
  structure Env = Environment_
  structure EnvironTypes = EnvironTypes_
  structure Pervasives = Pervasives_
  structure Info = Info_
  structure Code_Module = Code_Module_
  structure ObjectFile = ObjectFile_
  structure Debugger_Types = Debugger_Types_
  structure Enc_Sub = Enc_Sub_
  structure HashTable = HashTable_
  structure IntHashTable = IntHashTable_
)
