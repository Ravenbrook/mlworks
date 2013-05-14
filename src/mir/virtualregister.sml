(*  ==== VIRTUAL REGISTER ABSTRACT TYPE ====
 *                 SIGNATURE
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
 *  The virtual register type supplies unique pure names for virtual
 *  registers together with an efficient implementation of monomorphic sets
 *  of virtual registers.
 *
 *  Revision Log
 *  ------------
 *  $Log: virtualregister.sml,v $
 *  Revision 1.8  1996/11/28 13:41:34  matthew
 *  [Bug #1812]
 *  Adding reset function
 *
 * Revision 1.7  1996/02/26  12:48:20  jont
 * mononewmap becomes monomap
 *
 * Revision 1.6  1994/08/15  15:41:52  matthew
 * Removed hash function
 *
 *  Revision 1.5  1992/10/29  17:27:41  jont
 *  Added Map structure for mononewmaps to allow efficient implementation
 *  of lookup tables for integer based values
 *
 *  Revision 1.4  1992/08/26  13:26:39  jont
 *  Removed some redundant structures and sharing
 *
 *  Revision 1.3  1992/06/01  09:42:10  richard
 *  Added register Packs.
 *
 *  Revision 1.2  1992/05/18  13:30:37  richard
 *  Added `range' function.
 *
 *  Revision 1.1  1992/03/02  14:25:28  richard
 *  Initial revision
 *
 *)


require "../utils/monoset";
require "../utils/mutablemonoset";
require "../utils/monomap";

signature VIRTUALREGISTER =
  sig

    structure Set	: MONOSET
    structure Pack      : MUTABLEMONOSET
    structure Map       : MONOMAP

    sharing Set.Text = Pack.Text

    eqtype T

    sharing type T = Set.element = Pack.element = Map.object

    val new		: unit -> T
    val reset           : unit -> unit
    val order		: T * T -> bool
    val pack		: int -> T
    val unpack		: T -> int

    val pack_set	: Set.T -> Pack.T
    val unpack_set	: Pack.T -> Set.T

    val to_string	: T -> string
    val to_text		: T -> Set.Text.T

  end


