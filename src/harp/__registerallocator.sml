(*  ==== REGISTER ALLOCATOR ====
 *           STRUCTURE
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Notes
 *  -----
 *  This file determines the sizes of the hash tables used during register
 *  allocation.
 *
 *  Revision Log
 *  ------------
 *  $Log: __registerallocator.sml,v $
 *  Revision 1.23  1995/05/30 11:02:20  matthew
 *  Removing Timer structure
 *
 *  Revision 1.22  1995/03/17  20:10:11  daveb
 *  Removed unused parameters.
 *
 *  Revision 1.21  1992/06/10  14:31:53  richard
 *  Added Map parameter.
 *
 *  Revision 1.20  1992/06/04  13:22:57  richard
 *  Changed register allocator to use separate colourers for each register
 *  type.  See functor.
 *
 *  Revision 1.19  1992/04/16  13:08:00  richard
 *  Added timer to functor parameters.
 *
 *  Revision 1.18  1992/04/09  16:00:57  richard
 *  Removed obsolete Switches structure.
 *
 *  Revision 1.17  1992/02/27  16:01:01  richard
 *  Changed the way virtual registers are handled.  See MirTypes.
 *
 *  Revision 1.16  1992/02/11  13:17:12  richard
 *  Changed the application of the Diagnostic functor to take the Text
 *  structure as a parameter.  See utils/diagnostic.sml for details.
 *
 *  Revision 1.15  1992/02/05  17:17:08  richard
 *  Complete rewrite using imperative ML features to gain efficiency.
 *  See functor revision 1.15 for details.
 *
 *)


require "../utils/__lists";
require "../utils/__text";
require "../utils/_diagnostic";
require "../utils/__crash";
require "__mirprint";
require "__mirprocedure";
require "__mirtables";
require "__mirregisters";
require "__gccolourer";
require "__nongccolourer";
require "__fpcolourer";
require "_registerallocator";


structure RegisterAllocator_ =
  RegisterAllocator
  (structure MirProcedure = MirProcedure_
   structure MirRegisters = MirRegisters_
   structure Crash = Crash_
   structure Diagnostic =
     Diagnostic (structure Text = Text_)
   structure MirPrint = MirPrint_
   structure MirTables = MirTables_
   structure Lists = Lists_
   structure GCColourer = GCColourer_
   structure NonGCColourer = NonGCColourer_
   structure FPColourer = FPColourer_)



