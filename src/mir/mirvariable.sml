(*  ==== LIVE VARIBALE ANALYSIS ====
 *            SIGNATURE
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
 *  Variable analysis determines the relationships between registers in
 *  order that they can be assigned to real machine registers.  It is also
 *  able to detect some instructions which have no useful effect, and
 *  discard them.
 *
 *  Diagnostics
 *  -----------
 *   0  no output
 *   1  procedure tags as they are processed
 *   2  flow and live variable maps
 *   3  blocks tags as they are analysed, instructions eliminated
 *   4  all live variable information as it is calculated
 *
 *  Revision Log
 *  ------------
 *  $Log: mirvariable.sml,v $
 *  Revision 1.8  1992/12/08 19:52:44  jont
 *  Removed a number of duplicated signatures and structures
 *
 *  Revision 1.7  1992/12/02  13:34:22  jont
 *  Removed superfluous MirTypes
 *
 *  Revision 1.6  1992/06/04  15:11:30  richard
 *  The variable analyser now updates a register graph rather than
 *  producing a list of clashes.
 *
 *  Revision 1.5  1992/05/27  13:27:38  richard
 *  Changes register Sets to Packs.
 *
 *  Revision 1.4  1992/02/27  17:13:03  richard
 *  This new signature goes with revision 1.4 of the functor.  The analysis
 *  now uses MirProcedure annotated procedures and returns a list of live
 *  register clashes for use by the register allocator as well as the
 *  optimised procedure.  Much faster.
 *
 *)


require "../utils/diagnostic";
require "registerallocator";


signature MIRVARIABLE =
  sig
    structure RegisterAllocator : REGISTERALLOCATOR
    structure Diagnostic	: DIAGNOSTIC


    (*  == Switches ==
     *
     *  eliminate	Instructions which define unused variables and have
     *                  no side effects are removed from the procedure iff
     *                  this flag is true.
     *)

    val eliminate : bool ref


    (*  === PERFORM LIVE VARIABLE ANALYSIS ON A PROCEDURE ===
     *
     *  Returns an optimised procedure and updates the graph with the
     *  register clash information.  After this stage the graph is ready for
     *  colouring by the register allocator.
     *)

    val analyse :
      RegisterAllocator.MirProcedure.procedure * RegisterAllocator.Graph ->
      RegisterAllocator.MirProcedure.procedure

  end
