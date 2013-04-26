(* Test for exception IO.RandomAccessNotSupported
 * 
 * Result: OK
 * 
 * $Log: random_access.sml,v $
 * Revision 1.4  1998/07/29 14:54:36  jont
 * [Bug #70144]
 * Modify to put the object files in /tmp
 *
 *  Revision 1.3  1998/07/14  16:26:01  jont
 *  [Bug #20130]
 *  Modify to avoid recompiling into the release area
 *
 *  Revision 1.2  1998/06/04  15:55:10  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *  Revision 1.7  1998/05/19  11:50:12  mitchell
 *  [Bug #50071]
 *  Modify test to use forceCompileAll
 *
 *  Revision 1.6  1998/05/07  11:07:17  mitchell
 *  [Bug #50071]
 *  Modify test to perform a Shell.Project.touchAllSources before compiling to force a recompile
 *
 *  Revision 1.5  1998/05/06  11:09:39  mitchell
 *  [Bug #30409]
 *  Fix test so that it explicitly disables random access to TextIO.stdIn and uncomment handler
 *
 *  Revision 1.4  1998/05/04  17:19:54  mitchell
 *  [Bug #50071]
 *  Replace uses of Shell.Build.loadSource by Shell.Project
 *
 *  Revision 1.3  1998/01/22  16:17:56  jont
 *  [Bug #30323]
 *  Remove unnecessary uses of Shell.Build.loadSource
 *
 *  Revision 1.2  1997/07/17  15:51:20  brucem
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 * 
 *
 * Copyright (C) 1997 The Harlequin Group Limited. All rights reserved.
 *)

Shell.Options.set (Shell.Options.ValuePrinter.maximumStrDepth, 0);

let
  val dir = OS.FileSys.getDir() 
  fun setTargets l = (app Shell.Project.setTargetDetails l; Shell.Project.setTargets l)
  val _ = Shell.Project.openProject (OS.Path.concat [dir, "..", "src", "basis.mlp"]);
  val _ = Shell.Project.setConfiguration "I386/NT";
  val {binariesLoc, libraryPath, objectsLoc} = Shell.Project.showLocations();
  val _ = Shell.Project.setLocations
    {binariesLoc=binariesLoc, libraryPath=libraryPath, objectsLoc="\\tmp\\objects"};
in
  setTargets ["__io.sml", "__bin_prim_io.sml", "__os_prim_io.sml", "__text_io.sml", 
              "__text_stream_io.sml", "__bin_stream_io.sml", "__text_prim_io.sml"];
  Shell.Project.forceCompileAll();
  Shell.Project.loadAll()
end;

local
  open OSPrimIO
  open BinPrimIO
in

(* This is to demonstrate that OSPrimIO uses exception
   IO.RandomAccessNotSupported where appropriate *)

datatype Result = CORRECT_EX | WRONG_EX of exn | NO_EX

(* 'test' will return a record containing CORRECT_EX values if and only if
  exception IO.RandomAccessNotSupported has been raised by a test case *)

val test = fn () =>
  let

    (* Need to set up stdIn/Out so that they do not permit random access,
       just modify the currentIO so that it does not permit random access *)

    val currIO = MLWorks.Internal.StandardIO.currentIO ()

    val newIO = 
      { access = #access currIO,
        error = {
          can_output = NONE, (* The `NONE's prevent random access *)
          close = #close (#error currIO),
          descriptor = #descriptor (#error currIO),
          get_pos = NONE : (unit -> int) option,
          put = #put (#error currIO),
          set_pos = NONE : (int -> unit) option},
        input = {
          can_input =  NONE,
          close = #close (#input currIO),
          descriptor = #descriptor (#input currIO),
          get_pos = NONE : (unit -> int) option,
          get = #get (#input currIO),
          set_pos = NONE : (int -> unit) option},
        output = {          
          can_output = NONE,
          close = #close (#output currIO),
          descriptor = #descriptor (#output currIO),
          get_pos = NONE : (unit -> int) option,
          put = #put (#output currIO),
          set_pos = NONE : (int -> unit) option}
        }
    
    val redirect = MLWorks.Internal.StandardIO.redirectIO newIO

    (* Get the function getPos from standard input,
       call the function,
       record CORRECT_EX if correct exception is raised *)
    val RD OSPrimIOStdIn = stdIn
    val getPosStdIn =
      case (#getPos(OSPrimIOStdIn)) of SOME a => a | _ => raise Fail "?"
    val testGetPosStdIn =
      (ignore(getPosStdIn ()); NO_EX)
      handle IO.RandomAccessNotSupported => CORRECT_EX
           | e => WRONG_EX e

    (* Same for the other operations and streams *)
    val testSetPosStdIn = 
      let
        val RD OSPrimIOStdIn = stdIn
        val setPosStdIn =
          case (#setPos(OSPrimIOStdIn)) of SOME a => a | _ => raise Fail "?"
      in
        (setPosStdIn 1; NO_EX)
      end handle IO.RandomAccessNotSupported => CORRECT_EX

    val testGetPosStdOut = 
      let
        val WR OSPrimIOStdOut = stdOut
        val getPosStdOut =
          case (#getPos(OSPrimIOStdOut)) of SOME a => a | _ => raise Fail "?"
      in
        (ignore(getPosStdOut ()); NO_EX)
      end handle IO.RandomAccessNotSupported => CORRECT_EX

    val testSetPosStdOut = 
      let
        val WR OSPrimIOStdOut = stdOut
        val setPosStdOut =
          case (#setPos(OSPrimIOStdOut)) of SOME a => a | _ => raise Fail "?"
      in
        (setPosStdOut 1; NO_EX)
      end handle IO.RandomAccessNotSupported => CORRECT_EX

    val testGetPosStdErr = 
      let
        val WR OSPrimIOStdErr = stdErr
        val getPosStdErr =
          case (#getPos(OSPrimIOStdErr)) of SOME a => a | _ => raise Fail "?"
      in
        (ignore(getPosStdErr ()); NO_EX)
      end handle IO.RandomAccessNotSupported => CORRECT_EX

    val testSetPosStdErr = 
      let
        val WR OSPrimIOStdErr = stdErr
        val setPosStdErr =
          case (#setPos(OSPrimIOStdErr)) of SOME a => a | _ => raise Fail "?"
      in
        (setPosStdErr 1; NO_EX)
      end handle IO.RandomAccessNotSupported => CORRECT_EX

    local
      open TextIO
      fun setSetPosIn (stream, newval) =
        let val instream = getInstream stream
            val (r as TextPrimIO.RD 
                  {avail, block, canInput, chunkSize, close, endPos, getPos, 
                   ioDesc, name, readArr, readArrNB, readVec, readVecNB, 
                   setPos, verifyPos},
                 v) = StreamIO.getReader(instream);
            val r' = TextPrimIO.RD 
                  {avail=avail, block=block, canInput=canInput,
                   chunkSize=chunkSize, close=close, endPos=endPos, 
                   getPos=getPos, ioDesc=ioDesc, name=name, readArr=readArr, 
                   readArrNB=readArrNB, readVec=readVec, readVecNB=readVecNB, 
                   setPos=newval, verifyPos=verifyPos}
            val newinstream = StreamIO.mkInstream(r', v)
         in setInstream(stream, newinstream);
            setPos
        end
        

    in
      val oldsetpos = setSetPosIn (stdIn, NONE);

      val testStreamIO =
        {getPosStdIn = 
          (ignore(getPosIn stdIn); NO_EX)
           handle IO.Io { cause = IO.RandomAccessNotSupported, ...} => CORRECT_EX
               | e => WRONG_EX e ,
         getPosStdOut =
          (ignore(getPosOut stdOut); NO_EX)
           handle IO.Io { cause = IO.RandomAccessNotSupported, ...} => CORRECT_EX
                | e => WRONG_EX e
          }


    (* The code for StreamIO.getPosIn is a bit odd, try calling it
       several times and with use of the stream ... *)

    val repeatTest =
      let
        fun doIt () = (ignore(getPosIn stdIn); NO_EX)
                    handle IO.Io {cause = IO.RandomAccessNotSupported, ...} =>
                      CORRECT_EX
                         | e => WRONG_EX e
        fun repeat 0 = []
          | repeat n = (doIt ())::(repeat (n-1))
      in
        repeat 10
      end

      val _ = setSetPosIn(stdIn, oldsetpos);
    end

    (* Finally, put StdIn/Out back to normal *)
    (* val reset = MLWorks.Internal.StandardIO.resetIO () *)
    val redirect = MLWorks.Internal.StandardIO.redirectIO currIO

  in
    {testGetPosStdIn = testGetPosStdIn,
     testSetPosStdIn = testSetPosStdIn,
     testGetPosStdOut = testGetPosStdOut,
     testSetPosStdOut = testSetPosStdOut,
     testGetPosStdErr = testGetPosStdErr,
     testSetPosStdErr = testSetPosStdErr,
     testStreamIO = testStreamIO,
     repeatTest = repeatTest}
  end

end

test();




