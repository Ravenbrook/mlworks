(*  ==== LIVE VARIABLE ANALYSIS ====
 *	       STRUCTURE
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
 *  ------------
 *  $Log: __mirvariable.sml,v $
 *  Revision 1.10  1994/09/13 16:09:16  matthew
 *  Added IntHashTable
 *
 *  Revision 1.9  1994/08/16  14:50:56  matthew
 *  Update requires
 *
 *  Revision 1.8  1992/06/22  11:50:35  richard
 *  Added MirRegisters to parameters.
 *
 *  Revision 1.7  1992/06/04  07:57:49  richard
 *  Added RegisterAllocator parameter.
 *
 *  Revision 1.6  1992/02/27  11:06:46  richard
 *  Added register structures as instances of VirtualRegister.
 *
 *)
require "../utils/__lists";
require "../utils/__crash";
require "../utils/_diagnostic";
require "../utils/__text";
require "../utils/__inthashtable";
require "__mirprint";
require "__mirtables";
require "__mirregisters";
require "__registerallocator";
require "_mirvariable";


structure MirVariable_ = MirVariable(
  structure Lists = Lists_
  structure Crash = Crash_
  structure Diagnostic = Diagnostic( structure Text = Text_ )
  structure IntHashTable = IntHashTable_
  structure MirPrint = MirPrint_
  structure MirTables = MirTables_
  structure MirRegisters = MirRegisters_
  structure RegisterAllocator = RegisterAllocator_
)
