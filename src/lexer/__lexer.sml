(*
$Log: __lexer.sml,v $
Revision 1.17  1998/01/30 09:40:42  johnh
[Bug #30326]
Merge in change from branch MLWorks_workspace_97

 * Revision 1.16.11.2  1997/11/20  17:08:55  daveb
 * [Bug #30326]
 *
 * Revision 1.16.11.1  1997/09/11  20:56:11  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.16  1995/03/14  10:49:56  matthew
 * Removing redundant structures
 *
Revision 1.15  1994/08/04  13:46:00  matthew
Adding Timer structure

Revision 1.14  1993/05/18  16:15:42  jont
Removed integer parameter

Revision 1.13  1993/03/30  14:45:47  daveb
Removed the Crash parameter again.  There is mthoed in this madness!
Crash was only needed for the pushback facility of tokenstreams, which
I've now removed.

Revision 1.12  1993/03/29  12:14:10  daveb
Added Crash parameter.

Revision 1.11  1992/11/05  15:35:09  matthew
Changed Error structure to Info

Revision 1.10  1992/08/31  15:43:04  richard
Added error handler structure.

Revision 1.9  1992/08/18  13:28:15  davidt
Now builds the Lexer structure directly, without using
the Lexer functor.

Revision 1.8  1992/08/14  21:13:45  davidt
Added the Crash structure.

Revision 1.7  1992/08/07  15:42:09  davidt
String structure is now pervasive.

Revision 1.6  1992/08/04  15:43:04  davidt
Took out redundant Array argument and require.

Revision 1.5  1992/05/06  10:36:35  richard
Changed BalancedTree to BTree

Revision 1.4  1992/01/29  11:03:41  jont
Added string parameter

Revision 1.3  1991/10/11  13:35:30  davidt
This used to build a functor, which isn't normally done here, so I
move the functor into the file _lexer.sml

Revision 1.2  91/09/06  16:47:25  nickh
Lexer structure. This uses the lexer generator, and is quite messy for
reasons of type sharing.

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
require "../utils/__btree";
require "../utils/__mlworks_timer";
require "../basics/__token";
require "__ndfa";
require "__lexrules";

require "_lexgen";

structure Lexer_ =
  LexGen(structure Lists = Lists_
	 structure Map = BTree_
         structure Timer = Timer_
	 structure Token = Token_
	 structure Ndfa = Ndfa_
	 structure LexRules = LexRules_
           );
