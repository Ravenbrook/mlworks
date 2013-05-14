(*  ==== PACK REGISTERS IN A PROCEDURE ====
 *                SIGNATURE
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
 *  This module analyses a procedure in order to pack the virtual registers
 *  such that they may be used in `packed sets' which have nice properties.
 *  (See virtual register signature.) 
 *
 *  Revision Log
 *  ------------
 *  $Log: registerpack.sml,v $
 *  Revision 1.4  1992/06/18 14:25:06  jont
 *  Added require diagnostic
 *
 *  Revision 1.3  1992/06/16  13:00:35  richard
 *  Added Diagnostic structure to signature.
 *
 *  Revision 1.2  1992/06/09  10:08:51  richard
 *  Exported substitute function for use elsewhere.
 *
 *  Revision 1.1  1992/05/27  10:52:17  richard
 *  Initial revision
 *
 *)


require "../utils/diagnostic";
require "mirtypes";


signature REGISTERPACK =
  sig

    structure MirTypes : MIRTYPES
    structure Diagnostic : DIAGNOSTIC


    (*  == Substitute registers in a procedure ==
     *
     *  Given functions which substitute GC, non GC and FP registers this
     *  function substitutes registers in MIR opcodes.  Lift this function
     *  where possible.
     *)

    val substitute :
      {gc     : MirTypes.GC.T    -> MirTypes.GC.T,
       non_gc : MirTypes.NonGC.T -> MirTypes.NonGC.T,
       fp     : MirTypes.FP.T    -> MirTypes.FP.T} ->
      MirTypes.opcode -> MirTypes.opcode

 

    (*  === ANALYSE A PROCEDURE ===
     *
     *  This function analyses a procedure and produces a record containing:
     *    nr_registers  the number of each type of register present
     *    substitute    a function to substitute packed registers in any
     *                  opcode of the procedure.
     *
     *  The packed registers are such that calling the relevant `unpack'
     *  function from the virtual register structure produces an integer in
     *  the range 0 to nr_registers-1.
     *
     *  N.B. The identity of the special registers from MirRegisters is
     *  preserved.
     *)

    val f : MirTypes.procedure ->
            {nr_registers : {gc : int, non_gc : int, fp : int},
             substitute   : MirTypes.opcode -> MirTypes.opcode}

  end
