(* __lambdatypes.sml the structure *)
(*
$Log: __lambdatypes.sml,v $
Revision 1.18  1996/10/04 13:47:17  matthew
[Bug #1634]

Tidying up

 * Revision 1.17  1995/12/27  15:52:36  jont
 * Remove __option
 *
Revision 1.16  1995/12/04  13:36:59  matthew
Simplifying

Revision 1.15  1995/03/22  14:09:23  daveb
Removed unused parameters.

Revision 1.14  1995/01/04  12:27:42  matthew
Renaming debugger_env to runtime_env

Revision 1.13  1994/09/13  10:02:05  matthew
Added RuntimeEnv

Revision 1.12  1993/05/28  08:14:48  nosa
structure Option

Revision 1.11  1993/05/18  15:52:01  jont
Removed integer parameter

Revision 1.10  1992/10/29  18:04:26  jont
Added IntNewMap parameter for constructing more efficient maps

Revision 1.9  1992/09/21  10:38:00  clive
Changed hashtables to a single structure implementation

Revision 1.8  1992/08/19  16:35:27  davidt
Took out redundant structure arguments.

Revision 1.7  1992/07/29  09:56:20  clive
Changed the bindingtable to be a hashtable

Revision 1.6  1992/06/11  08:38:54  clive
Added datatype recording to the FNexp for the debugger and annotated LETs with
a string to be used as the annotation when they are converted into Fnexps

Revision 1.5  1992/04/16  11:20:33  clive
General speed improvements

Revision 1.4  1991/09/06  10:10:01  davida
Added LambdaInfo type for optimisations,
information for code-generator.

Revision 1.3  91/08/23  11:41:41  jont
Added pervasives

Revision 1.2  91/06/27  09:58:33  jont
Changed use multiple counter instances

Revision 1.1  91/06/11  11:09:00  jont
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

require "../utils/__set";
require "../utils/_counter";
require "../main/__pervasives";
require "../typechecker/__datatypes";
require "../debugger/__runtime_env";
require "_lambdatypes";

structure LambdaTypes_ =
  LambdaTypes(structure Set = Set_
	      structure Counter = Counter()
	      structure Pervasives = Pervasives_
	      structure Datatypes = Datatypes_
              structure RuntimeEnv = RuntimeEnv_
                );
