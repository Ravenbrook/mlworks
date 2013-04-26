(* preliminary Test suite for binprimio functions.
 *

Result: OK

 * $Log: prim_io_1.sml,v $
 * Revision 1.8  1997/11/21 10:46:24  daveb
 * [Bug #30323]
 *
 *  Revision 1.7  1997/08/05  09:30:59  brucem
 *  [Bug #30004]
 *  Suppress printing structure contents to prevent spurious failure.
 *
 *  Revision 1.6  1997/05/28  11:09:16  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.5  1997/01/15  15:52:17  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.4  1996/07/18  14:18:24  andreww
 *  [Bug #1453]
 *  updating to respect the modernisation of the IO library (May 96)
 *
 *  Revision 1.3  1996/06/04  12:15:20  andreww
 *  adding BinPrimIO.
 *  ,
 *
 *  Revision 1.2  1996/05/24  13:29:13  andreww
 *  sorted bugs relating to answer files.
 *
 *  Revision 1.1  1996/05/24  09:54:54  andreww
 *  new unit
 *
 * Copyright (c) 1996 Harlequin Ltd.
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



(* dear old reader Alfred *)

  val r = RD{ name = "Alfred",
              chunkSize = 5,
              readVec = SOME (fn x => Word8Vector.fromList
                                (makelist x)),
              readArr = NONE,
              readVecNB = NONE,
              readArrNB=NONE,
              block=NONE,
              canInput= SOME(fn ()=>true),
              avail = fn()=>NONE,
              getPos = SOME(fn ()=> Word8.toInt(!number)),
              setPos = SOME(fn x => (number:=Word8.fromInt x)),
              endPos = SOME(fn ()=> raise Fail "No end of file."),
              verifyPos = NONE,
              close = fn () => (),
              ioDesc = NONE};

  val r'= augmentReader r;
  val s = (fn (RD({setPos=SOME s,...})) => s | _ => raise Div) r';


(* test synthesized, non-blocking vector read *)

  val f = (fn RD({readVecNB=SOME(f),...}) =>f
            | RD({readVecNB=NONE,...}) => raise Div)  r';
                                 (* a hack to overcome warning messages
                                  * about unexhaustive matches.  Div
                                  * should never be raised *)

  val y = (fn SOME(y) => y | NONE => raise Div)(s 0;f 10);

  fun compare x = if x = 11 then print"VectorNB read succeeded.\n"
                  else if Word8.toInt(Word8Vector.sub(y,x-1))<>x
                       then print"VectorNB read failed.\n"
                         else compare (x+1);

  val test1=compare 1;  





(* test that synthesized array read is OK *)

  val buffer = Word8Array.array(10,Word8.fromInt(0));
  val f = (fn RD({readArr=SOME(f),...}) =>f
            | RD({readArr=NONE,...}) => raise Div)  r';


  val x = (s 0;f{buf = buffer, i=1, sz=SOME(9)});

  fun compare x = if x = 10 then print"Array read succeeded.\n"
                  else if Word8.toInt(Word8Array.sub(buffer,x))<>x
                       then print"Array read failed.\n"
                         else compare (x+1);

  val test2 = compare 1;

(* test that synthesized array NB read is OK *)

  val buffer = Word8Array.array(10,Word8.fromInt(0));
  val f = (fn RD({readArrNB=SOME(f),...}) =>f
            | RD({readArrNB=NONE,...}) => raise Div)  r';

  val x = (s 0;f{buf = buffer, i=1, sz=SOME(9)});

  fun compare x = if x = 10 then print"ArrayNB read succeeded.\n"
                  else if Word8.toInt(Word8Array.sub(buffer,x))<>x
                       then print"ArrayNB read failed.\n"
                         else compare (x+1);

  val test3 = compare 1;


end;





