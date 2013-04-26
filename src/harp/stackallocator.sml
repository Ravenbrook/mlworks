(*  ==== STATIC STACK ALLOCATOR ====
 *             SIGNATURE
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
 *  Description
 *  -----------
 *  The stack allocator analyses an annotated MIR procedure to determine how
 *  much space is required by the stack allocating instruction within it.  This
 *  amount is entered into the procedure parameters so that the procedure
 *  can allocate the space in one go on procedure entry, and use the offsets
 *  attached to the instructions as positions within this space.
 *
 *  Diagnostic output levels (see ../utils/diagnostic.sml)
 *  ------------------------
 *    0  none
 *    1  procedure tags
 *    2  stack instructions processed
 *    3  flow of control decisions, states at exit points
 *
 *  Revision Log
 *  ------------
 *  $Log: stackallocator.sml,v $
 *  Revision 1.5  1992/03/05 10:58:28  richard
 *  Updated to use annotated procedures.
 *
 *  Revision 1.4  1991/12/05  13:18:34  richard
 *  Redocumented.
 *
 *  Revision 1.3  91/11/19  16:01:01  richard
 *  Changed debugging output to use the Diagnostic module, which
 *  prevents the debugging output strings being constructed even
 *  if they aren't printed.
 *  
 *  Revision 1.2  91/10/31  15:11:41  richard
 *  Gave the module a more standard interface.
 *  
 *  Revision 1.1  91/10/29  09:43:17  richard
 *  Initial revision
 *)


require "../utils/diagnostic";
require "mirprocedure";


signature STACKALLOCATOR =

  sig

    structure MirProcedure	: MIRPROCEDURE
    structure Diagnostic	: DIAGNOSTIC

    val allocate : MirProcedure.procedure -> MirProcedure.procedure

  end
