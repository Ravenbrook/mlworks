(* This tests that the StreamIO functor implements functional streams.
 *

Result: OK

 * $Log: stream_io.sml,v $
 * Revision 1.7  1997/11/24 11:02:01  daveb
 * [Bug #30323]
 *
 *  Revision 1.6  1997/08/05  09:48:36  brucem
 *  [Bug #30004]
 *  Suppress printing structure contents to prevent spurious failure.
 *
 *  Revision 1.5  1997/05/28  11:18:59  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.4  1997/02/26  11:35:31  andreww
 *  [Bug #1759]
 *  recompiling
 *  changes owing to new TEXT_STREAM_IO signature.
 *
 *  Revision 1.3  1996/11/16  02:07:47  io
 *  [Bug #1757]
 *  renamed __ieeereal to __ieee_real
 *          __char{array,vector} to __char_{array,vector}
 *
 *  Revision 1.2  1996/07/18  15:05:40  andreww
 *  [Bug #1453]
 *  updating to respect the modernisation of the IO library (May 96)
 *
 *  Revision 1.1  1996/06/11  11:18:26  andreww
 *  new unit
 *  Test file for stream input/output.
 *
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
  open TextIO.StreamIO;
in

(* functions that supply reader input *)

   val comm_medium = ref "";
   val pos = ref 0;


(*Arthur is going to read what Amy writes: our test function. *)

  val w = TextPrimIO.WR{ name = "Amy",
              chunkSize = 20,
              writeVec = SOME (fn {buf=b,i=p,sz=s} => (
                                 comm_medium:=(!comm_medium)^
                                                CharVector.extract(b,p,s);
                                 case s of
                                   NONE => CharVector.length b -p
                                 | SOME(si) => si)),
              writeArr = NONE,
              writeVecNB = NONE,
              writeArrNB=NONE,
              block=NONE,
              canOutput= SOME(fn ()=>true),
              getPos = SOME(fn ()=> 0),
              setPos = SOME(fn x => ()),
              endPos = SOME(fn ()=> ~1),
              verifyPos = NONE,
              close = fn () => (),
              ioDesc = NONE};

  val amy = mkOutstream(w,IO.LINE_BUF);
    
  val the_answer = "One Two Three\n1Four Five Six\nSeven Eight Nine."
    
  val _ = output(amy,"One Two Three\n");
  val _ = output1(amy,#"1");
  val _ = output(amy,"Four Five Six\n");
  val _ = output(amy,"Seven Eight Nine.");
    
  val test1 = the_answer <> (!comm_medium);
  val text2 = the_answer = (flushOut amy; !comm_medium);





  val r = TextPrimIO.RD{ 
              name = "Arthur",
              chunkSize = 5,
              readVec = 
                SOME (fn (x:int) =>
                 let val y = if x+(!pos)>CharVector.length(!comm_medium)
                               then CharVector.length(!comm_medium)-(!pos)
                             else x
                     val r = CharVector.extract(!comm_medium,!pos,SOME y)
                 in
                   (pos:=(!pos)+y; r)
                 end),
              readArr = NONE,
              readVecNB = NONE,
              readArrNB=NONE,
              block=SOME(fn ()=>()),
              canInput= SOME(fn ()=> 
                             not(CharVector.length (!comm_medium)=(!pos))),
              avail=fn()=>NONE,
              getPos = SOME(fn ()=> (!pos)),
              setPos = SOME(fn x => pos:=x),
              endPos = SOME(fn ()=> raise Fail "No end of file."),
              verifyPos = NONE,
              close = fn () => 
                comm_medium:=CharVector.extract(!comm_medium,0,SOME (!pos)),
              ioDesc = NONE};


    val arthur = mkInstream(r,"");

    val test1 = input arthur;
    val test2 as (s1,benjamin) = input arthur;
    val test3 as (s2,colin) = input benjamin;
    val test4 = input arthur;
    val test5 as s3= inputAll colin;
    val (_,dave) = input colin;
    val test6 = input benjamin;

    fun reportOK true = print"test succeeded.\n"
      | reportOK false = print"test failed.\n"

    val x = reportOK ((#1 test1)=(#1 test2));
    val x = reportOK ((#1 test1)=(#1 test4));
    val x = reportOK ((#1 test3)=(#1 test6));

    val x = reportOK (the_answer=s1^s2^s3);
    val x = reportOK (not (endOfStream benjamin));

    val x = reportOK (let val (a,_) = input arthur
                          val (b,_) = input arthur
                        in a=b end);

    val x = reportOK (closeIn arthur; closeIn arthur; true);

    val _ = comm_medium:="Oh the grand old Duke of York...";
    val _ = pos:=0;


    val x = reportOK (let val (a,_) = input arthur
                        in canInput (arthur, (CharVector.length a))
                           = SOME (CharVector.length a)
                      end);


    val x = reportOK (let val a = mkInstream (r,"")
                        in closeIn a;
                           CharVector.length (#1(input a))=0
                           end);

    val _ = comm_medium:="Yes, we have no bananas.";
    val _ = pos:=0;

    val x = reportOK (let val art = mkInstream (r,"")
                          val (a,bart) = input art
                          val _ = closeIn art
                          val (b,_) = input art
                       in a=b andalso (endOfStream bart)
                      end);

end



