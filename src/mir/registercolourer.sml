(*  ==== REGISTER GRAPH COLOURER ====
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
 *  This signature describes a structure which builds a graph of clashes
 *  between registers and a function for colouring it with some other
 *  registers.
 *
 *  Diagnostics
 *  -----------
 *  0  Register preferences are printed when functor is applied
 *  1  Graph creation
 *  2  Register mergers on graph creation, register assignments
 *  3  Register merger map
 *  4  Clashes added to graph
 *
 *  Revision Log
 *  ------------
 *  $Log: registercolourer.sml,v $
 *  Revision 1.10  1997/01/27 16:44:21  jont
 *  [Bug #0]
 *  Pass name of function to colourer so we don't try too hard on setups and functors
 *
 * Revision 1.9  1995/05/30  11:34:02  matthew
 * Adding debug flag to colour
 *
 *  Revision 1.8  1994/08/24  16:06:42  matthew
 *  Added preferences argument
 *
 *  Revision 1.7  1993/07/30  09:50:26  richard
 *  Added graph printing function.
 *
 *  Revision 1.6  1992/08/05  11:30:10  jont
 *  Removed require array
 *
 *  Revision 1.5  1992/06/19  09:55:05  jont
 *  Added missing require diagnostic
 *
 *  Revision 1.4  1992/06/17  10:08:46  richard
 *  Hints are no longer passed to the graphs.
 *
 *  Revision 1.3  1992/06/11  10:28:37  richard
 *  Added `referenced' parameter to clasher.
 *
 *  Revision 1.2  1992/06/09  14:33:31  richard
 *  Removed `used' return from colouring function.
 *
 *  Revision 1.1  1992/06/04  15:03:15  richard
 *  Initial revision
 *)


require "../utils/diagnostic";
require "virtualregister";


signature REGISTERCOLOURER =
  sig

    structure Register   : VIRTUALREGISTER
    structure Diagnostic : DIAGNOSTIC


    (*  === REGISTER CLASH GRAPH ===
     *
     *  An empty graph is created from several bits of information about the
     *  registers which are to occupy it.  The registers must have been
     *  packed, i.e., must map onto the integers 0 to N-1, and the integer N
     *  supplied to the `empty' function.
     *
     *  The clash function augments the graph with live register
     *  information.  The set of registers defined, referenced, and live at
     *  each instruction is passed.  The defined set should be sparser than
     *  the referenced set, in general.  This is critical to timing.
     *)

    type Graph

    val empty : int * bool -> Graph
    val clash : Graph * Register.Pack.T * Register.Pack.T * Register.Pack.T -> unit


    (*  === COLOUR A CLASH GRAPH ===
     *
     *  This function colours the registers in a clash graph with a set of
     *  registers taken from MirRegisters (see functor for details).  If
     *  there are not enough registers to go round registers are coloured
     *  with spill numbers.  The colouring function yields a function
     *  mapping registers to their colouring and the number of spills (one
     *  greater than the largest spill).
     *
     *  A Graph may only be coloured once, as it is destructively modified
     *  by the colouring process.
     *)

    datatype assignment = REGISTER of Register.T | SPILL of int

    val colour :
      Graph * (Register.T * Register.T) list * bool * string ->
      {assign : Register.T -> assignment,
       nr_spills : int}


  end
