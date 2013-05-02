(*  ==== VIRTUAL REGISTER ABSTRACT TYPE ====
 *                 FUNCTOR
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
 *  Implementation
 *  --------------
 *  Virtual registers are implemented as integers and an IntSet structure is
 *  used to provide the efficient set implementation.
 *
 *  Revision Log
 *  ------------
 *  $Log: _virtualregister.sml,v $
 *  Revision 1.9  1996/11/28 13:45:26  matthew
 *  [Bug #1812]
 *  Adding reset function
 *
 * Revision 1.8  1994/08/15  09:40:00  matthew
 * Removed hash function
 *
 *  Revision 1.7  1993/05/18  14:41:57  jont
 *  Removed Integer parameter
 *
 *  Revision 1.6  1992/10/29  17:26:55  jont
 *  Added Map structure for mononewmaps to allow efficient implementation
 *  of lookup tables for integer based values
 *
 *  Revision 1.5  1992/06/10  17:05:01  richard
 *  Added missing require.
 *
 *  Revision 1.4  1992/06/01  09:42:08  richard
 *  Added register Packs, making `range' obsolete.
 *
 *  Revision 1.3  1992/05/18  14:13:57  richard
 *  Added `range' function.
 *  Added `int_to_text' and `int_to_string' parameters to functor.
 *
 *  Revision 1.2  1992/03/31  14:04:54  jont
 *  Added require text
 *
 *  Revision 1.1  1992/03/02  14:27:29  richard
 *  Initial revision
 *
 *)


require "../utils/text";
require "../utils/intset";
require "../utils/mutableintset";
require "../utils/intnewmap";
require "virtualregister";


functor VirtualRegister (
  structure IntSet	: INTSET
  structure SmallIntSet : MUTABLEINTSET
  structure Map         : INTNEWMAP
  structure Text	: TEXT

  val int_to_text	: int -> Text.T
  val int_to_string	: int -> string

  sharing Text = IntSet.Text = SmallIntSet.Text

) : VIRTUALREGISTER =

  struct

    structure Text = Text
    structure Set = IntSet
    structure Map = Map
    structure Pack = SmallIntSet

    type T = int

    val source = ref 0

    fun new () = (source := !source-1; !source)
    fun reset () = source := 0

    val order = op< : int * int -> bool
    fun pack r = r
    fun unpack r = r

    fun pack_set set    = Set.reduce Pack.add' (Pack.empty, set)
    fun unpack_set pack = Pack.reduce Set.add (Set.empty, pack)

    val to_string = int_to_string
    val to_text = int_to_text

  end
