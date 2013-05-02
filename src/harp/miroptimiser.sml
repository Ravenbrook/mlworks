(*  ==== MIR OPTIMISER ====
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
 *  The MIR optimiser takes an MIR code unit (see MirTypes) and transforms
 *  it in an attempt to impove is execution speed.  It also asssigns real
 *  registers to the virtual registers used in the procedure so that the
 *  code for the target machine can be generated.
 *
 *  Diagnostic Levels
 *  -----------------
 *   0  no output
 *   1  procedure tags printed
 *   2  listings generated between all stages
 *
 *  Revision Log
 *  ------------
 *  $Log: miroptimiser.sml,v $
 *  Revision 1.12  1995/05/30 11:37:21  matthew
 *  Adding make_debug_code flag
 *
Revision 1.11  1994/03/04  12:37:45  jont
Changes for automatic_callee mechanism removal
and moving machspec from machine to main

Revision 1.10  1992/11/02  18:03:55  jont
Reworked in terms of mononewmap

Revision 1.9  1992/02/27  16:03:41  richard
Changed the way virtual registers are handled.  See MirTypes.

Revision 1.8  1992/02/17  17:24:59  richard
Moved machine register assignments to the top level of this structure.
Added show_timings.

Revision 1.8  1992/02/14  16:05:59  richard
Moved machine register assignments to the top level of this structure.
Added show_timings.

 *  Revision 1.7  1991/11/18  16:24:14  richard
 *  Changed debugging output to use the Diagnostic module.
 *  
 *  Revision 1.6  91/10/17  11:26:24  richard
 *  Added Switches structure.
 *  
 *  Revision 1.5  91/10/15  13:32:54  richard
 *  Removed register assignments. These are now in the MirRegisters
 *  structure.
 *  
 *  Revision 1.4  91/10/07  11:55:02  richard
 *  Changed dependency on MachRegisters to MachSpec.
 *  
 *  Revision 1.3  91/10/04  13:26:48  richard
 *  Mappings from virtual to real registers are now exported.
 *  
 *  Revision 1.2  91/09/03  10:47:15  richard
 *  Early version of code to split up MIR code ready for
 *  dataflow analysis.
 *  
 *  Revision 1.1  91/09/02  12:22:35  richard
 *  Initial revision
 *)


require "../utils/diagnostic";
require "../main/machspec";
require "mirtypes";


signature MIROPTIMISER = 

  sig
    
    structure MirTypes		: MIRTYPES
    structure Diagnostic	: DIAGNOSTIC
    structure MachSpec		: MACHSPEC

    (*  === OPTIMISE MIR CODE ===
     *
     *  Attempts to optimise the execution speed of the code. It
     *  returns the optimised code, which has had its virtual
     *  registers mapped onto a set of aliases for the real machine
     *  registers. Tables which map these onto the real machine
     *  registers can be found in the MirRegisters structure above.
     *)
      
    val optimise : MirTypes.mir_code * bool -> MirTypes.mir_code
      
      
    (*  === MACHINE REGISTER ALIASES ===
     *
     *  The result procedure of optimisation (above) contains virtual
     *  registers which can be mapped onto real machine registers using the
     *  following maps.
     *)

    val machine_register_assignments :
      {gc	: (MachSpec.register) MirTypes.GC.Map.T,
       non_gc	: (MachSpec.register) MirTypes.NonGC.Map.T,
       fp	: (MachSpec.register) MirTypes.FP.Map.T}


  end
