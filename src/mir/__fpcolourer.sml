(*  ==== FP REGISTER COLOURER ====
 *            STRUCTURE
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
 *  Revision Log
 *  -------------
 *  $Log: __fpcolourer.sml,v $
 *  Revision 1.12  1998/08/27 12:17:18  jont
 *  [Bug #70040]
 *  Modify register colourer to use stack colourer only if requested from machspec
 *
 * Revision 1.11  1997/04/24  15:40:33  jont
 * [Bug #20007]
 * [Bug #20007]
 * Adding reserved_but_preferencable registers
 *
 * Revision 1.10  1997/01/22  16:02:00  jont
 * Adding corrupted_by_callee to functor parameter
 *
 * Revision 1.9  1995/12/27  15:50:46  jont
 * Remove __option
 *
 *  Revision 1.8  1995/05/30  11:08:40  matthew
 *  Adding debugging_available value
 *
 *  Revision 1.7  1993/10/11  13:21:33  jont
 *  Added option parameter
 *
 *  Revision 1.6  1993/05/18  14:44:50  jont
 *  Removed Integer parameter
 *
 *  Revision 1.5  1992/11/03  14:10:41  jont
 *  Efficiency changes to use mononewmap for registers and tags
 *
 *  Revision 1.4  1992/10/05  13:15:49  clive
 *  Change to NewMap.empty which now takes < and = functions instead of the single-function
 *
 *  Revision 1.3  1992/06/19  10:53:35  richard
 *  Added instance_name and available temporaries parameters.
 *
 *  Revision 1.2  1992/06/08  14:28:20  richard
 *  Added allocation order for registers.
 *
 *  Revision 1.1  1992/06/04  15:03:05  richard
 *  Initial revision
 *
 *)


require "../utils/__lists";
require "../utils/__crash";
require "../utils/__smallintset";
require "../utils/__text";
require "../utils/_diagnostic";
require "__mirtypes";
require "__mirregisters";
require "../machine/__machspec";
require "_registercolourer";


structure FPColourer_ =
  RegisterColourer
  (structure Lists = Lists_
   structure Crash = Crash_
   structure IntSet = SmallIntSet_
   structure Register = MirTypes_.FP
   structure Diagnostic = Diagnostic (structure Text = Text_)
   structure MachSpec = MachSpec_

   val instance_name = Text_.from_string "FP"

   val allocation_order = #fp MirRegisters_.allocation_order
   val allocation_equal = #fp MirRegisters_.allocation_equal

   val preassigned      = #fp MirRegisters_.preassigned
   val corrupted_by_callee = #fp MirRegisters_.corrupted_by_callee
   val available        = #fp MirRegisters_.general_purpose
   val debugging_available        = #fp MirRegisters_.debugging_general_purpose
   val temporaries	= #fp MirRegisters_.temporary
   val reserved_but_preferencable = #fp MirRegisters_.gp_for_preferencing
   val debugger_reserved_but_preferencable = #fp MirRegisters_.debugging_gp_for_preferencing)
