(* preliminary Test suite for binprimio functions.
 *

 Result: OK

 * $Log: prim_io_8.sml,v $
 * Revision 1.10  1997/11/21 10:47:36  daveb
 * [Bug #30323]
 *
 *  Revision 1.9  1997/08/05  09:46:38  brucem
 *  [Bug #30004]
 *  Suppress printing structure contents to prevent spurious failure.
 *
 *  Revision 1.8  1997/05/28  11:17:09  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.7  1997/01/30  16:32:18  andreww
 *  [Bug #1904]
 *  monovectors no longer equality types.
 *
 *  Revision 1.6  1997/01/15  15:53:20  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.5  1996/08/14  12:12:15  io
 *  switch off Compiling messages...
 *
 *  Revision 1.4  1996/07/18  14:09:35  andreww
 *  [Bug #1453]
 *  updating to respect the modernisation of the IO library (May 96)
 *
 *  Revision 1.3  1996/06/04  12:17:22  andreww
 *  adding BinPrimIO.
 *  ,
 *
 *  Revision 1.2  1996/05/24  15:25:32  andreww
 *  fix bugs pertaining to answer file creation.
 *
 *  Revision 1.1  1996/05/24  10:18:39  andreww
 *  new unit
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *)


local
  open General;
  open BinPrimIO;
  infix ==;
  fun a == b =
    let
      val len = Word8Vector.length a
      fun scan i = if i=len then true
                   else (Word8Vector.sub(a,i) = Word8Vector.sub(b,i)
                         andalso scan (i+1))
    in
      len = Word8Vector.length b
      andalso scan 0
    end


in

(*functions to supply output *)

  val number = ref (Word8.fromInt 0);
  val result = ref (Word8Vector.fromList [])

  fun nextno () = (number:=(Word8.fromInt(1+Word8.toInt(!number)));
                   !number);

  fun reset () = number:=Word8.fromInt 0;

  fun makelist x = if x<=0 then [] 
                   else nextno()::(makelist(x-1));



(* Finally, meet Doris, who is quite intelligent *)

  val w=WR{ name = "Doris",
              chunkSize = 5,
              writeVec = NONE,
              writeArr = NONE,

              writeVecNB = NONE,
              writeArrNB= SOME (fn {buf=b,i=p,sz=s} => SOME (
                                 result:=Word8Array.extract(b,p,s);
                                 case s of
                                   NONE => Word8Array.length b -p
                                 | SOME(si) => si)),
              block=SOME(fn ()=>()),
              canOutput= SOME(fn ()=>true),
              getPos = SOME(fn ()=> 0),
              setPos = SOME(fn x => ()),
              endPos = SOME(fn ()=> ~1),
              verifyPos = NONE,
              close = fn () => (),
              ioDesc = NONE};


  val w'= augmentWriter w;


(* test synthesized vector write *)

  val f = (fn WR({writeVec=SOME(f),...}) => f
            | WR({writeVec=NONE,...}) => raise Div) w';
                                 (* a hack to overcome warning messages
                                  * about unexhaustive matches.  Div
                                  * should never be raised *)

  val v = (reset(); Word8Vector.fromList (makelist 10));

  val x = f{buf = v, i=0, sz=NONE};
  

  fun compare x = if v == !result then print"Vector write succeeded.\n"
                  else print"Vector write failed.\n"

  val test1 = compare 1;


(* test synthesized vector NB write *)

  val f = (fn WR({writeVecNB=SOME(f),...}) => f
            | WR({writeVecNB=NONE,...}) => raise Div) w';

  val v = (reset(); Word8Vector.fromList (makelist 10));

  val x = f{buf = v, i=0, sz=NONE};
  

  fun compare x = if v == !result then print"VectorNB write succeeded.\n"
                  else print"VectorNB write failed.\n"

  val test2 = compare 1;


(* test synthesized array write *)

  val f = (fn WR({writeArr=SOME(f),...}) => f
            | WR({writeArr=NONE,...}) => raise Div) w';

  val a = (reset(); Word8Array.fromList (makelist 10));

  val x = f{buf = a, i=0, sz=NONE};
  
    fun compare x = if x = 10 then print"Array write succeeded.\n"
                  else if Word8.toInt(Word8Vector.sub(!result,x-1))<>x
                       then print"Array write failed.\n"
                         else compare (x+1);

  val test3 = compare 1;


end;






