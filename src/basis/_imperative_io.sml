(*  ==== INITIAL BASIS : streamio functor ====
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
 *  This is part of the extended Initial Basis.
 *
 *  $Log: _imperative_io.sml,v $
 *  Revision 1.9  1999/03/20 21:49:25  daveb
 *  [Bug #20125]
 *  Replaced substructure with type.
 *
 *  Revision 1.8  1998/05/26  13:56:24  mitchell
 *  [Bug #30413]
 *  Remove tracking of open output streams as this is now done in stream_io
 *
 *  Revision 1.7  1997/11/25  17:37:00  daveb
 *  [Bug #30329]
 *  Removed bogus Process argument.
 *
 *  Revision 1.6  1997/10/07  16:03:41  johnh
 *  [Bug #30226]
 *  Closing streams on exit.
 *
 *  Revision 1.5  1996/10/03  15:08:41  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.4  1996/07/17  15:42:23  andreww
 *  [Bug #1453]
 *  Updating to bring inline with the new basis document of May 30 '96
 *
 *  Revision 1.3  1996/06/11  12:36:31  andreww
 *  Debugging input1 to return NONE input correctly.
 *
 *  Revision 1.2  1996/06/06  12:24:01  andreww
 *  canInput must check that exactly the required number of elements
 *  can be input without blocking.
 *
 *  Revision 1.1  1996/06/03  14:09:32  andreww
 *  new unit
 *  support file for revised basis.
 *
 *)

require "mono_array";
require "mono_vector";
require "stream_io";
require "imperative_io";

functor ImperativeIO(structure StreamIO : STREAM_IO
                     structure Vector: MONO_VECTOR
                     structure Array: MONO_ARRAY
                       sharing type StreamIO.elem=Vector.elem=Array.elem
                       sharing type StreamIO.vector=Vector.vector
                                                   =Array.vector
 		     ) : IMPERATIVE_IO = 

  struct
    structure StreamIO = StreamIO
    type instream = StreamIO.instream ref
    type outstream = StreamIO.outstream ref
    type elem = StreamIO.elem
    type vector = StreamIO.vector

    (* list of outstreams which are currently open *)
    val mkInstream = ref
    val getInstream = !
    val setInstream = op :=
    val mkOutstream = ref
    val getOutstream = !
    val setOutstream = op :=
    fun endOf f = if StreamIO.endOfStream f then f 
                  else endOf(#2(StreamIO.input f))

    fun closeIn(r as ref f) = (StreamIO.closeIn f; r := endOf f)
    fun inputN (r as ref f, n) = let val (v,f') = StreamIO.inputN(f,n) 
                                 in  r:=f'; v end

    fun input (r as ref f) = let val (v,f') = StreamIO.input f in r:=f'; v end
    fun input1 (r as ref f) =
      case StreamIO.input1 f of
        SOME (v,f') => (r:=f'; SOME v)
      | NONE => NONE


    fun inputAll(r as ref f) =
      let val v = StreamIO.inputAll f
      in
	r := endOf f; v
      end


    val endOfStream = StreamIO.endOfStream o !


    fun lookahead(ref f) = case StreamIO.input1 f of
      NONE => NONE
    | SOME(e, _) => SOME e

    fun getPosIn(ref f) = StreamIO.getPosIn f

    fun setPosIn(f, pos) = f:=(StreamIO.setPosIn pos)

    val closeOut = StreamIO.closeOut o ! 
    fun output(ref f, v) = StreamIO.output(f,v)
    fun output1(ref f, x) = StreamIO.output1(f,x)
    val flushOut = StreamIO.flushOut o !

    fun canInput(ref instream, i) = case StreamIO.canInput(instream, i) of
      SOME j => i=j
    | NONE => false

    fun getPosOut (ref f) = StreamIO.getPosOut f

    fun setPosOut (f,pos) = f:=(StreamIO.setPosOut pos)

  end











