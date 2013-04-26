(* preliminary Test suite for binprimio functions.
 *

Result: OK

 * $Log: prim_io_3.sml,v $
 * Revision 1.8  1997/11/21 10:46:45  daveb
 * [Bug #30323]
 *
 *  Revision 1.7  1997/08/05  09:36:02  brucem
 *  [Bug #30004]
 *  Suppress printing structure contents to prevent spurious failure.
 *
 *  Revision 1.6  1997/05/28  12:58:48  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.5  1997/01/15  15:52:43  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.4  1996/07/18  14:19:36  andreww
 *  [Bug #1453]
 *  updating to respect the modernisation of the IO library (May 96)
 *
 *  Revision 1.3  1996/06/04  12:15:52  andreww
 *  adding BinPrimIO.
 *  ,
 *
 *  Revision 1.2  1996/05/24  14:18:38  andreww
 *  fix bugs concerning answer file.
 *
 *  Revision 1.1  1996/05/24  09:46:37  andreww
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
in



(* functions that supply input *)

  val number = ref (Word8.fromInt 0);

  fun nextno () = (number:=(Word8.fromInt(1+Word8.toInt(!number)));
                   !number);

  fun makelist x = if x<=0 then [] 
                   else nextno()::(makelist(x-1));

  fun makearray(b,p,s) = if s = 0 then ()
                         else (Word8Array.update(b,p,nextno());
                               makearray(b,p+1,s-1));



(* Bertie, our reader for this test *)

  val r = RD{ name = "Bertrand",
              chunkSize = 5,
              readVec = NONE,
              readArr = SOME (fn {buf=b, i=p, sz=s} =>
                              case s of
                                NONE => 
                                  (makearray(b,p,Word8Array.length b-p);
                                   Word8Array.length b -p)
                              | SOME(si) =>   
                                  if p+si>Word8Array.length b then
                                    raise Fail "array too small"
                                  else (makearray(b,p,si); si)),
              readVecNB = NONE,
              readArrNB=NONE,
              block=NONE,
              avail=fn()=>NONE,
              canInput= SOME(fn ()=>true),
              getPos = SOME(fn ()=> Word8.toInt(!number)),
              setPos = SOME(fn x => (number:=Word8.fromInt x)),
              endPos = SOME(fn ()=> raise Fail "No end of file."),
              verifyPos = NONE,
              close = fn () => (),
              ioDesc = NONE};

  val r'=augmentReader r;
  val s = (fn (RD({setPos=SOME s,...})) => s | _ => raise Div) r';


(* test that synthesized vector read is OK *)

  val  f = (fn RD({readVec=SOME(f),...}) => f
             | RD({readVec=NONE,...}) => raise Div) r';
                                 (* a hack to overcome warning messages
                                  * about unexhaustive matches.  Div
                                  * should never be raised *)

  val y = (s 0; f 11);

  fun compare x = if x = 11 then print"Vector read succeeded.\n"
                  else if Word8.toInt(Word8Vector.sub(y,x))<>(x+1)
                       then print"Vector read failed.\n"
                         else compare (x+1);

  val test1=compare 1;


(* test that synthesized vectorNB read is OK *)


  val f = (fn RD({readVecNB=SOME(f),...}) => f
            | RD({readVecNB=NONE,...}) => raise Div) r';

  val y = (fn SOME(y) => y | NONE => raise Div) (s 0; f 11);

  fun compare x = if x = 11 then print"VectorNB read succeeded.\n"
                  else if Word8.toInt(Word8Vector.sub(y,x))<>(x+1)
                       then print"VectorNB read failed.\n"
                         else compare (x+1);

  val test2=compare 1;


(* test that synthesized arrayNB read is OK *)

  val f = (fn RD({readArrNB=SOME(f),...}) => f
            | RD({readArrNB=NONE,...}) => raise Div) r';

  val buffer = Word8Array.array(10,Word8.fromInt 0);
  val x = (s 0;f{buf = buffer, i=1, sz=SOME(9)});

  fun compare x = if x = 10 then print"ArrayNB read succeeded.\n"
                  else if Word8.toInt(Word8Array.sub(buffer,x))<>x
                       then print"ArrayNB read failed.\n"
                         else compare (x+1);
  val test3=compare 1;



end;
