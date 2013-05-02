(* preliminary Test suite for binprimio functions.
 *

Result: OK

 * $Log: prim_io_2.sml,v $
 * Revision 1.8  1997/11/21 10:46:33  daveb
 * [Bug #30323]
 *
 *  Revision 1.7  1997/08/05  09:33:34  brucem
 *  [Bug #30004]
 *  Suppress printing structure contents to prevent spurious failure.
 *
 *  Revision 1.6  1997/05/28  11:10:21  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.5  1997/01/15  15:52:33  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.4  1996/07/18  14:19:21  andreww
 *  [Bug #1453]
 *  updating to respect the modernisation of the IO library (May 96)
 *
 *  Revision 1.3  1996/06/04  12:15:37  andreww
 *  adding BinPrimIO.
 *  ,
 *
 *  Revision 1.2  1996/05/24  14:06:24  andreww
 *  fix some bugs relating to the answer file.
 *
 *  Revision 1.1  1996/05/24  10:17:30  andreww
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

(* functions that supply reader input *)

  val number = ref (Word8.fromInt 0);

  fun nextno () = (number:=(Word8.fromInt(1+Word8.toInt(!number)));
                   !number);

  fun makelist x = if x<=0 then [] 
                   else nextno()::(makelist(x-1));



(* dear old reader Charlie *)

  val r = RD{ name = "Charlie",
              chunkSize = 5,
              readVec = NONE,
              readArr = NONE,
              readVecNB = SOME (fn x => SOME(Word8Vector.fromList
                                (makelist x))),
              readArrNB=NONE,
              block=SOME(fn ()=>()),
              canInput= SOME(fn ()=>true),
              avail=fn()=>NONE,
              getPos = SOME(fn ()=> Word8.toInt(!number)),
              setPos = SOME(fn x => (number:=Word8.fromInt x)),
              endPos = SOME(fn ()=> raise Fail "No end of file."),
              verifyPos = NONE,
              close = fn () => (),
              ioDesc = NONE};

  val r'= augmentReader r;
  val s = (fn (RD({setPos=SOME s,...})) => s | _ => raise Div) r';


(* test synthesized vector read *)

  val f = (fn RD({readVec=SOME(f),...}) => f
            | RD({readVec=NONE,...}) => raise Div) r';
                                 (* a hack to overcome warning messages
                                  * about unexhaustive matches.  Div
                                  * should never be raised *)



  val y = (s 0;f 10);

  fun compare x = if x = 11 then print"Vector read succeeded.\n"
                  else if Word8.toInt(Word8Vector.sub(y,x-1))<>x
                       then print"Vector read failed.\n"
                         else compare (x+1);

  val test1=compare 1;  





(* test that synthesized array read is OK *)

  val buffer = Word8Array.array(10,Word8.fromInt(0));
  val f = (fn RD({readArr=SOME(f),...}) => f
            | RD({readArr=NONE,...}) => raise Div) r';

  val x = (s 0;f{buf = buffer, i=1, sz=SOME(9)});

  fun compare x = if x = 10 then print"Array read succeeded.\n"
                  else if Word8.toInt(Word8Array.sub(buffer,x))<>x
                       then print"Array read failed.\n"
                         else compare (x+1);

  val test2 = compare 1;

(* test that synthesized array NB read is OK *)

  val buffer = Word8Array.array(10,Word8.fromInt(0));
  val f = (fn RD({readArrNB=SOME(f),...}) =>f 
            | RD({readArrNB=NONE,...}) => raise Div) r';

  val x = (s 0;f{buf = buffer, i=1, sz=SOME(9)});

  fun compare x = if x = 10 then print"ArrayNB read succeeded.\n"
                  else if Word8.toInt(Word8Array.sub(buffer,x))<>x
                       then print"ArrayNB read failed.\n"
                         else compare (x+1);

  val test3 = compare 1;


end;





