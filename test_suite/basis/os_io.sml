(* Copyright (c) 1996 Harlequin Ltd.

Result: OK

 *
 * Does some portable (and hence minimal) testing of OS.IO.
 *
 * Consists of checking what OS.IO.kind returns when applied to 
 * a file descriptor attached to a file.
 * 
 * Doesn't do anything with sockets since there isn't a standard mechanism yet.
 *
 * All the tests pass if all the boolean values in ans are true.
 * 
 * Revision Log
 * ------------
 *
 * $Log: os_io.sml,v $
 * Revision 1.5  1997/11/21 10:45:41  daveb
 * [Bug #30323]
 *
 *  Revision 1.4  1997/04/01  16:43:48  jont
 *  Modify to stop displaying syserror type
 *
 *  Revision 1.3  1996/08/29  09:06:39  stephenb
 *  Change the test so that it opens README instead of Makefile
 *  since the test is being run in the test_suite directory,
 *  not the src directory.
 *
 *  Revision 1.2  1996/08/22  12:23:58  stephenb
 *  [Bug #1554]
 *  Win32 doesn't like select being passed file descriptors that
 *  aren't sockets.  So moved this part of the test from the generic
 *  test file to the unix specific one.
 *
 *  Revision 1.1  1996/08/16  15:27:52  stephenb
 *  new unit
 *
 *)



(* Open the fileName as an output file, writes some characters to it
 * and then and applies action to the OS.IO.desc associated with the file 
 * Finally deletes the file and returns the result of the action.
 *
 * Doesn't attempt to catch exceptions and clean up properly.
 *
 * Note:
 *
 *  1. the tedious case stuff is there in preference to
 *
 *       val (TextPrimIO.WR {ioDesc= SOME desc, close, ...}, _) = 
 *         TextStreamIO.getWriter stream;
 *
 *    to avoid a warning from the compiler about inexhausitve bindings 
 *    which then causes the result to fail the tests done by CHECK_RESULT.
 * 
 *  2. Once bug 1564 is fixed, the explicit close could be replaced
 *     by a call to TextIO.StreamIO.closeOut.
 *)

fun applyToOutDesc fileName action =
  let
    val file = TextIO.openOut fileName
    val _ = TextIO.outputSubstr (file, Substring.all "abc");
    val stream = TextIO.getOutstream file;
    val (desc, close)
      = case TextIO.StreamIO.getWriter stream of
          (TextPrimIO.WR {ioDesc=NONE, ...}, _)=> raise Match
        | (TextPrimIO.WR {ioDesc=SOME desc, close, ...}, _) => (desc, close)
    val action_result = action desc
  in
    close();
    OS.FileSys.remove fileName;
    action_result
  end




(* As per applyToOutDesc above except that the file is opened as
 * an input file and it is not deleted afterwards.
 *
 * The original from which unix/os_io.sml#applyToInDesc was copied.
 *)

fun applyToInDesc fileName action =
  let
    val file = TextIO.openIn fileName
    val stream = TextIO.getInstream file;
    val desc = case TextIO.StreamIO.getReader stream of
                 (TextPrimIO.RD {ioDesc=NONE, ...}, _)=> raise Match
               | (TextPrimIO.RD {ioDesc=SOME desc, ...}, _) => desc
    val action_result = action desc
  in
    TextIO.StreamIO.closeIn stream;
    action_result
  end



fun compare_test (a, b) = 
  ( OS.IO.compare (a, a) = EQUAL
  , OS.IO.compare (b, b) = EQUAL
  , OS.IO.compare (a, b) <> EQUAL
  )



fun kind_test (a, b) = 
  ( OS.IO.kind a = OS.IO.Kind.file
  , OS.IO.kind b = OS.IO.Kind.file
  )



fun pollDesc_test a =
  case OS.IO.pollDesc a of
    NONE => false
  | SOME pd => a = OS.IO.pollToIODesc pd



val ans = 
  applyToOutDesc "os_io_test" (fn descA =>
  applyToInDesc "README" (fn descB =>
  ( ("compare", compare_test (descA, descB))
  , ("kind", kind_test (descA, descB))
  , ("pollDescA", pollDesc_test descA)
  , ("pollDescB", pollDesc_test descB)
  )));
