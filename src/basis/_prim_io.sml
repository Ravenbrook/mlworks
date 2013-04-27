(*  ==== INITIAL BASIS : primio functor ====
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
 *  $Log: _prim_io.sml,v $
 *  Revision 1.6  1999/03/20 21:44:16  daveb
 *  [Bug #20125]
 *  Replaced substructure with type.
 *
 *  Revision 1.5  1998/02/19  16:19:24  mitchell
 *  [Bug #30349]
 *  Fix to avoid non-unit sequence warnings
 *
 *  Revision 1.4  1996/11/08  14:19:33  matthew
 *  [Bug #1661]
 *  Changing io_desc to iodesc
 *
 *  Revision 1.3  1996/10/03  15:11:00  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.2  1996/08/14  09:46:00  andreww
 *  [Bug #1537]
 *  adjusting augment reader/writer routines to propagate io descriptors
 *
 *  Revision 1.1  1996/07/17  17:17:01  andreww
 *  new unit
 *  [Bug 1453] updated (and renamed) version of _primio.sml
 *
 * Revision 1.5  1996/05/22  09:31:19  matthew
 * Fixing merge problem in last revision
 *
 * Revision 1.4  1996/05/22  09:15:13  matthew
 * Vector changes
 *
 * Revision 1.3  1996/05/20  12:11:10  jont
 * signature changes
 *
 * Revision 1.2  1996/05/15  13:20:04  jont
 * pack_words moved to pack_word
 *
 * Revision 1.1  1996/04/18  11:38:38  jont
 * new unit
 *
 *  Revision 1.2  1995/05/10  14:00:21  daveb
 *  Characters are no longer integers.
 *  Removed definitions of BinPrimIO and TextPrimIO.
 *
 *  Revision 1.1  1995/04/13  13:39:08  jont
 *  new unit
 *  No reason given
 *
 *
 *)

require "../system/__os";
require "mono_vector";
require "mono_array";
require "prim_io";

functor PrimIO(include sig
                 structure A : MONO_ARRAY
                 structure V : MONO_VECTOR
               end sharing type A.vector = V.vector
                       and type A.elem = V.elem
	       val someElem : A.elem
	       type pos
	       val compare : pos * pos -> order) : PRIM_IO =
  struct
    type elem = A.elem
    type vector = V.vector
    type array = A.array
    type pos = pos

    val compare = compare

    type 'a portion = {buf: 'a, i: int, sz: int option}

    datatype reader = RD of 
              {readVecNB : (int -> vector option) option,
               readArrNB: (array portion -> int option) option,
               readVec :   (int -> vector) option,
               readArr:   (array portion -> int) option,
               block      : (unit -> unit) option,
               canInput  : (unit -> bool) option,
               avail     : unit -> int option,
               name       : string,
               chunkSize  : int,
               close      : unit -> unit,
               getPos     : (unit -> pos) option,
               setPos     : (pos -> unit) option,
               endPos     : (unit -> pos) option,
               verifyPos  : (unit -> pos) option,
	       ioDesc : OS.IO.iodesc option}

    datatype writer = WR of 
              {writeVecNB: (vector portion -> int option) option,
               writeArrNB: (array portion -> int option) option,
               writeVec: (vector portion -> int) option,
               writeArr: (array portion -> int) option,
               block: (unit->unit) option,
               canOutput: (unit->bool) option,
               name: string,
               chunkSize: int,
               close: unit -> unit,
               getPos : (unit->pos) option,
               setPos : (pos->unit) option,
               endPos : (unit->pos) option,
               verifyPos : (unit -> pos) option,
	       ioDesc : OS.IO.iodesc option}

    fun noOption convert f x = 
      case convert f x
        of SOME result => result
         | NONE => raise Fail "bug in PrimIO"

    fun blockingOperation(readaNoBlock,block) = 
	     SOME(fn x => 
		  (ignore(block()); 
		   case readaNoBlock x 
		     of SOME r => r
		      | NONE => raise Fail "unexpected blocking operation"))


    fun augmentReader (r as RD r') =
      let
	fun readaToReadv reada i =
	  let
	    val a = A.array(i,someElem)
	  in case reada{buf=a,i=0,sz=SOME i}
	    of SOME i' => SOME(A.extract(a,0,SOME i'))
	  | NONE => NONE  
	  end

	fun readvToReada readv{buf: array, i: int, sz: int option} =
	  let
	    val nelems = case sz of
	      SOME i => i
	    | NONE => A.length buf - i
	    val first = i
	    val data = buf
	  in
	    case readv nelems of
	      SOME v => SOME(let val len = V.length v
				 fun loop i = 
				   if i >= len then len
				   else (A.update(data,i+first,V.sub(v,i));
					 loop(i+1))
			     in loop 0
			     end)
	    | NONE => NONE
	  end

	val readBlock' = 
          case r
	    of RD{readVec=SOME f,...} => SOME f
	  | RD{readArr=SOME f,...} => SOME(noOption readaToReadv (SOME o f))
	  | RD{readVecNB=SOME f,block=SOME b,...} =>
	      SOME(fn i => (b(); noOption (fn x=>x) f i))
	  | RD{readArrNB=SOME f, block=SOME b,...} =>
	      SOME(fn x => (b(); noOption readaToReadv f x))
	  | _ => NONE

	val readaBlock' = 
          case r
	    of RD{readArr=SOME f,...} => SOME f
	  | RD{readVec=SOME f,...} => SOME(noOption readvToReada (SOME o f))
	  | RD{readArrNB=SOME f, block=SOME b,...} =>
	      blockingOperation(f,b)
	  | RD{readVecNB=SOME f,block=SOME b,...} =>
	      blockingOperation(readvToReada f, b)
	  | _ => NONE

	val readNoBlock' =
	  case r
	    of RD{readVecNB=SOME f,...} => SOME f
	  | RD{readArrNB=SOME f,...} => SOME(readaToReadv f)
	  | RD{readVec=SOME f, canInput=SOME can,...} =>
	      SOME(fn i => if can()
			     then SOME(f i) else NONE)

	  | RD{readArr=SOME f, canInput=SOME can,...} =>
	      SOME(fn i => if can()
			     then readaToReadv (SOME o f) i else NONE)
	  | _ => NONE

        val readaNoBlock' =
	  case r
	    of RD{readArrNB=SOME f,...} => SOME f
	  | RD{readVecNB=SOME f,...} => SOME(readvToReada f)
	  | RD{readArr=SOME f, canInput=SOME can,...} =>
	      SOME(fn x => if can()
			     then SOME(f x) else NONE)
	  | RD{readVec=SOME f, canInput=SOME can,...} =>
	      SOME(fn x => if can()
			     then readvToReada (SOME o f) x else NONE)
	  | _ => NONE

      in RD{readVec=readBlock', readArr=readaBlock',
	    readVecNB=readNoBlock', readArrNB=readaNoBlock',
	    block= #block r', canInput = #canInput r',
            avail = #avail r',
	    name= #name r', chunkSize= #chunkSize r',
	    close= #close r', getPos = #getPos r', 
	    setPos = #setPos r', endPos = #endPos r',
            verifyPos = #verifyPos r',
	    ioDesc= #ioDesc r'}
      end

    fun augmentWriter (r as WR r') =
      let
	fun writevToWritea writev {buf,i,sz} =
	  let
	    val data = buf
	    val first = i
	    val nelems = case sz of
	      SOME i => i
	    | NONE => A.length buf - i
	    val v = A.extract(data,first,SOME nelems)
	  in
	    writev{buf=v,i=0,sz=SOME nelems}
	  end
	fun writeaToWritev writea {buf,i,sz=SOME 0} = SOME 0
	  | writeaToWritev writea {buf,i,sz} =
	    let
	      val nelems = case sz of
		SOME i => i
	      | NONE => V.length buf - i
	      val first = i
	      val data = buf
	      val a = A.array(nelems,V.sub(data,first))
	      fun loop i = if i >= nelems then  ()
			   else (A.update(a,i,V.sub(data,first+i));
				 loop(i+1))
	    in loop 1; writea{buf=a,i=0,sz=SOME nelems}
	    end

	val writeBlock' =
          case r
	    of WR{writeVec=SOME f,...} => SOME f
	  | WR{writeArr=SOME f,...} => 
	      SOME(noOption writeaToWritev (SOME o f))
	  | WR{writeVecNB=SOME f,block=SOME b,...} =>
	      SOME(fn i => (b(); noOption (fn x=>x) f i))
	  | WR{writeArrNB=SOME f, block=SOME b,...} =>
	      SOME(fn x => (b(); noOption writeaToWritev f x))
	  | _ => NONE

	val writeaBlock' = 
          case r
	    of WR{writeArr=SOME f,...} => SOME f
	  | WR{writeVec=SOME f,...} => 
	      SOME(noOption writevToWritea (SOME o f))
	  | WR{writeArrNB=SOME f, block=SOME b,...} =>
	      blockingOperation(f,b)
	  | WR{writeVecNB=SOME f,block=SOME b,...} =>
	      blockingOperation(writevToWritea f, b)
	  | _ => NONE

	val writeNoBlock' =
	  case r
	    of WR{writeVecNB=SOME f,...} => SOME f
	  | WR{writeArrNB=SOME f,...} => SOME(writeaToWritev f)
	  | WR{writeVec=SOME f, canOutput=SOME can,...} =>
	      SOME(fn i => if can()
			     then SOME(f i) else NONE)
	     
	  | WR{writeArr=SOME f, canOutput=SOME can,...} =>
	      SOME(fn i => if can()
			     then writeaToWritev (SOME o f) i else NONE)
	  | _ => NONE

	val writeaNoBlock' =
	  case r
	    of WR{writeArrNB=SOME f,...} => SOME f
	  | WR{writeVecNB=SOME f,...} => SOME(writevToWritea f)
	  | WR{writeArr=SOME f, canOutput=SOME can,...} =>
	      SOME(fn x => if can() then SOME(f x) else NONE)
	  | WR{writeVec=SOME f, canOutput=SOME can,...} =>
	      SOME(fn x => if can() 
			     then SOME(writevToWritea f x) else NONE)
	  | _ => NONE

      in WR{writeVec=writeBlock', writeArr=writeaBlock',
	    writeVecNB=writeNoBlock', writeArrNB=writeaNoBlock',
	    block= #block r', canOutput = #canOutput r',
	    name= #name r', chunkSize= #chunkSize r',
	    close= #close r', getPos = #getPos r', 
	    setPos = #setPos r', endPos = #endPos r',
            verifyPos = #verifyPos r',
	    ioDesc= #ioDesc r'}
      end

  end
