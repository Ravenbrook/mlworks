(* __miroptimiser.sml the structure *)
(*
$Log: __miroptimiser.sml,v $
Revision 1.24  1995/05/30 11:00:11  matthew
Removing Timer structure

 *  Revision 1.23  1994/04/12  11:01:45  jont
 *  Adding expression analysis
 *
 *  Revision 1.22  1992/06/17  10:15:21  richard
 *  Removed preallocator and expression analyser from parameters.
 *
 *  Revision 1.21  1992/06/04  07:56:18  richard
 *  Removed obsolete MirOptTypes and MirFlow structures.
 *
 *  Revision 1.20  1992/04/28  14:13:52  richard
 *  Added register preallocator.
 *
 *  Revision 1.19  1992/04/23  11:13:10  jont
 *  Added require __timer
 *
 *  Revision 1.18  1992/02/20  16:25:11  richard
 *  Added MirProcedure to parameters.
 *
 *  Revision 1.17  1992/02/14  16:05:56  richard
 *  Removed unnecessary parameters to the functor and added Timer.
 *
Revision 1.16  1992/02/11  13:17:10  richard
Changed the application of the Diagnostic functor to take the Text
structure as a parameter.  See utils/diagnostic.sml for details.

Revision 1.15  1991/11/18  16:41:55  richard
Changed debugging output to use the Diagnostic module.

Revision 1.14  91/10/29  09:44:21  richard
Added stack allocator to optimizations.

Revision 1.13  91/10/24  14:38:33  richard
Added several modules to dependencies.

Revision 1.12  91/10/21  14:00:48  richard
Added Print module to dependencies to allow listings at a later stage.

Revision 1.11  91/10/17  11:26:22  richard
Added Switches structure and removed redundant MirDataFlow module.

Revision 1.10  91/10/15  16:01:47  richard
Added MirRegisters to dependencies.

Revision 1.9  91/10/04  13:57:21  richard
Removed some redundant dependencies.

Revision 1.8  91/09/30  10:16:49  richard
Added register allocator to optimisation module.

Revision 1.7  91/09/18  17:53:05  richard
Added MirFlow module to functor call.

Revision 1.6  91/09/17  15:40:41  richard
Minor changes associated with break-up of MirDataflow module. See
log for that file.

Revision 1.5  91/09/16  12:07:27  richard
Added dependency on Lists module so that separate function can cope
with nested procedures. See functor.

Revision 1.4  91/09/09  09:43:32  richard
Changed filename of mirpeep to mirpeepholer.

Revision 1.3  91/09/05  12:32:16  richard
Removed dependency on Set module. This is now imported via the
MirDataFlow module.

Revision 1.2  91/09/04  11:33:09  richard
Early version of code to split up MIR code ready for
dataflow analysis.

Revision 1.1  91/09/02  12:15:27  richard
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

require "../utils/__text";
require "../utils/_diagnostic";
require "__mirvariable";
require "__mirregisters";
require "__mirexpr";
require "__stackallocator";
require "_miroptimiser";


structure MirOptimiser_ = MirOptimiser(
  structure MirVariable = MirVariable_
  structure StackAllocator = StackAllocator_
  structure MirRegisters = MirRegisters_
  structure MirExpr = MirExpr_
  structure Diagnostic = Diagnostic (structure Text = Text_)
)
