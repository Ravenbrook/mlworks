(*  ==== PACK REGISTERS IN A PROCEDURE ====
 *                STRUCTURE
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
 *  $Log: __registerpack.sml,v $
 *  Revision 1.5  1994/09/26 12:33:25  matthew
 *  Adding IntHashTable
 *
 *  Revision 1.4  1994/05/26  11:34:31  richard
 *  Adding parameter to functor.
 *
 *  Revision 1.3  1993/05/18  14:49:36  jont
 *  Removed Integer parameter
 *
 *  Revision 1.2  1992/06/17  13:22:57  richard
 *  Added Integer structure and parameter to decide when to apply
 *  full analysis.
 *
 *  Revision 1.1  1992/05/27  11:17:49  richard
 *  Initial revision
 *
 *)


require "../utils/__inthashtable";
require "../utils/__text";
require "../utils/_diagnostic";
require "../utils/__crash";
require "../utils/__lists";
require "__mirtables";
require "__mirregisters";
require "__mirprint";

require "_registerpack";


structure RegisterPack_ =
  RegisterPack (structure Diagnostic = Diagnostic (structure Text = Text_)
                structure Crash = Crash_
                structure Lists = Lists_
                structure IntHashTable = IntHashTable_
                structure MirTables = MirTables_
                structure MirRegisters = MirRegisters_
                structure MirPrint = MirPrint_

                val full_analysis_threshold = 500)
