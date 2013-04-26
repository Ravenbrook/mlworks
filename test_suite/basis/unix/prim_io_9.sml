(* This tests the behaviour of the translateIn and translateOut functions.
 *

Result: OK

 * $Log: prim_io_9.sml,v $
 * Revision 1.5  1999/03/23 10:11:01  mitchell
 * [Bug #190507]
 * When we set the targets in the basis to not include require_all we must remove this file from the list of project files to avoid duplicate definition warnings in the dependency analysis
 *
 *  Revision 1.4  1998/07/29  15:09:32  jont
 *  [Bug #70144]
 *  Modify to place object files in /tmp
 *
 *  Revision 1.3  1998/07/14  16:11:28  jont
 *  [Bug #20130]
 *  Make sure object directory is not normal build directory
 *
 *  Revision 1.2  1998/06/04  15:48:18  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *  Revision 1.10  1998/05/19  11:49:54  mitchell
 *  [Bug #50071]
 *  Modify test to use forceCompileAll
 *
 *  Revision 1.9  1998/05/07  11:09:43  mitchell
 *  [Bug #50071]
 *  Modify test to perform a Shell.Project.touchAllSources before compiling to force a recompile
 *
 *  Revision 1.8  1998/05/04  17:15:37  mitchell
 *  [Bug #50071]
 *  Replace uses of Shell.Build.loadSource by Shell.Project
 *
 *  Revision 1.7  1997/12/22  14:39:18  jont
 *  [Bug #30323]
 *  Remove uses of Shell.Build.loadSource and tidy up
 *
 *  Revision 1.6  1997/04/01  11:04:34  jont
 *  Remove ref ptr from result as it's system dependent
 *
 *  Revision 1.5  1997/01/15  15:53:28  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.4  1996/08/14  12:12:48  io
 *  switch off Compiling messages...
 *
 *  Revision 1.3  1996/07/18  14:38:40  andreww
 *  [Bug #1453]
 *  updating to respect the modernisation of the IO library (May 96)
 *
 *  Revision 1.2  1996/07/04  18:31:01  andreww
 *  Updating with respect to changes in __primio.sml:
 *  alterning name PrimIO to OSPrimIO.
 *
 *  Revision 1.1  1996/06/04  09:45:45  andreww
 *  new unit
 *  Test that conversions from text to bin and back work.
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


let
  val _ = Shell.Options.set(Shell.Options.ValuePrinter.maximumStrDepth, 0);
  val dir = OS.FileSys.getDir()
  fun setTargets l = (app Shell.Project.setTargetDetails l; Shell.Project.setTargets l)
  val _ = Shell.Project.openProject (OS.Path.concat [dir, "..", "src", "basis.mlp"]);
  val _ = Shell.Project.setConfiguration "SPARC/Solaris";
  val {binariesLoc, libraryPath, objectsLoc} = Shell.Project.showLocations();
  val _ = Shell.Project.setLocations
    {binariesLoc=binariesLoc, libraryPath=libraryPath, objectsLoc="/tmp/objects"};
  val _ = Shell.Project.setFiles
            (List.filter (fn s => s <> "basis/require_all.sml")
                         (Shell.Project.showFiles()))
in
  setTargets ["__io.sml", "__bin_prim_io.sml", "__os_prim_io.sml", "__text_io.sml", "__bin_io.sml",
              "__text_stream_io.sml", "__bin_stream_io.sml", "__text_prim_io.sml", "__word8_vector.sml"];
  Shell.Project.forceCompileAll();
  Shell.Project.loadAll()
end;

local
  val pos = ref 0;
  val comm_medium = ref (Word8Vector.fromList [])
in

(* functions that supply reader input *)

(*Arthur is going to read what Amy writes: our test function. *)

  val w = BinPrimIO.WR{ name = "Amy",
              chunkSize = 5,
              writeVec = SOME (fn {buf=b,i=p,sz=s} => (
                                 comm_medium:=Word8Vector.extract(b,p,s);
                                 case s of
                                   NONE => Word8Vector.length b -p
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


  val r = BinPrimIO.RD{ 
              name = "Arthur",
              chunkSize = 5,
              readVec = 
                SOME (fn (x:int) =>
                 let val y = if x+(!pos)>Word8Vector.length(!comm_medium)
                               then Word8Vector.length(!comm_medium)-(!pos)
                             else x
                     val r = Word8Vector.extract(!comm_medium,!pos,SOME y)
                 in
                   (pos:=(!pos)+y; r)
                 end),
              readArr = NONE,
              readVecNB = NONE,
              readArrNB=NONE,
              block=SOME(fn ()=>()),
              canInput= SOME(fn ()=>true),
              avail=fn()=>NONE,
              getPos = SOME(fn ()=> 1),
              setPos = SOME(fn x => ()),
              endPos = SOME(fn ()=> raise Fail "No end of file."),
              verifyPos = NONE,
              close = fn () => (),
              ioDesc = NONE};


(* build text functions from the binary ones *)

   val tr = OSPrimIO.translateIn(r);
   val tw = OSPrimIO.translateOut(w);
   val outfn  = (fn TextPrimIO.WR({writeVec = NONE,...}) => raise Div
                  | TextPrimIO.WR({writeVec = SOME f,...}) => f) tw;
   val infn  = (fn TextPrimIO.RD({readVec = NONE,...}) => raise Div
                  | TextPrimIO.RD({readVec = SOME f,...}) => f) tr;

   val teststring =
       "Mary had a little lamb,\n a lobster and some prunes.\nYo!";

   
   val test_in = (ignore(outfn {buf=teststring, i=0, sz=NONE});
               infn 100);

   val result = (teststring= test_in);
end




















