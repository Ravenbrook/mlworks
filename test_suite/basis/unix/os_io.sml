(* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
Result: OK

 *
 * Does some Unix specific testing of OS.IO.
 *
 * Currently just checks what OS.IO.kind when applied to various things.
 * and also that it is possible to use OS.IO.poll to detect the availablility 
 * of input/output on such a descriptor.
 *
 * All tests should return true.
 * 
 * Note the result for "available.input.input" may look wrong.  However, since 
 * this is the result under SunOS and Irix I tend to believe that is what it is
 * supposed to be.
 * Further note: Linux disagrees with the result for "available.input.input"
 * and so the test has now been removed.
 *
 * Revision Log
 * ------------
 *
 * $Log: os_io.sml,v $
 * Revision 1.7  1998/02/05 11:08:37  jont
 * [Bug #70057]
 * Remove system dependent test
 *
 *  Revision 1.6  1998/01/22  17:00:34  jont
 *  [Bug #30323]
 *  Remove unnecessary uses of Shell.Build.loadSource
 *
 *  Revision 1.5  1997/11/11  22:59:15  jont
 *  [Bug #70013]
 *  Fix OS incompatibility problems under Linux
 *
 *  Revision 1.4  1997/08/11  09:44:13  brucem
 *  [Bug #30086]
 *  Stop printing structure contents to prevent spurious failure.
 *
 *  Revision 1.3  1996/08/22  12:22:30  stephenb
 *  [Bug #1554]
 *  Win32 doesn't like select being passed file descriptors that
 *  aren't sockets.  So moved this part of the test from the generic
 *  test file to the unix specific one.
 *
 *  Revision 1.2  1996/08/20  08:17:45  stephenb
 *  Remove the /dev/tty test since /dev/ttty does exist for
 *  a cron job.
 *
 *)

local
    val _ = Shell.Options.set(Shell.Options.ValuePrinter.maximumStrDepth, 0);
in
end;


(* As per ../os_io.sml#applyToInDesc. *)

fun applyToOutDesc fileName action =
  let
    val file = TextIO.openOut fileName
    val _ = TextIO.outputSubstr (file, Substring.all "abc");
    val stream = TextIO.getOutstream file;
    val desc = case TextIO.StreamIO.getWriter stream of
                 (TextPrimIO.WR {ioDesc=NONE, ...}, _)=> raise Match
               | (TextPrimIO.WR {ioDesc=SOME desc, ...}, _) => desc
    val action_result = action desc
  in
    TextIO.StreamIO.closeOut stream;
    OS.FileSys.remove fileName;
    action_result
  end

(* As per ../os_io.sml#applyToInDesc. *)



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


fun available_test (addPoll, modifyIn, modifyOut, modifyPri, fd) =
  case OS.IO.pollDesc fd of
    NONE =>  NONE
  | SOME pd => 
      let
        val pd' = addPoll pd 
        val info = OS.IO.poll ([pd, pd'], SOME Time.zeroTime)
      in
        case info of
          [] => NONE
        | [info] => 
            let
              val pd'' = OS.IO.infoToPollDesc info
            in
              SOME
                ( modifyIn (OS.IO.isIn info)
                , modifyOut (OS.IO.isOut info)
                , modifyPri (OS.IO.isPri info)
                , pd'' = pd'
                , pd'' <> pd
                )
            end
        | _ => NONE
      end

fun id x = x;



val zero_ans = applyToInDesc "/dev/zero" (fn desc => OS.IO.kind desc = OS.IO.Kind.device)
val dir_ans = applyToInDesc "basis" (fn desc => OS.IO.kind desc = OS.IO.Kind.dir)

val ans = 
  applyToOutDesc "os_io_test_a" (fn descA =>
  applyToInDesc "os_io_test_a" (fn descB =>
  (("available.input.output", 
      available_test (OS.IO.pollOut, not, id, not, descB))
  , ("available.output.input", 
      available_test (OS.IO.pollIn, id, not, not, descA))
  )));

(*
 * Note can't do the following :-
 *
 *   , ("available.input.pri",
 *       available_test (OS.IO.pollPri, not, not, id, descB))
 *   , ("available.output.pri",
 *       available_test (OS.IO.pollPri, not, not, id, descA))
 *
 * since under SunOS they return :-
 *
 *   ("available.input.pri", SOME (true, true, true, true, true)),
 *   ("available.output.pri", SOME (true, true, true, true, true))
 *
 * whilst under Irix they return :-
 *
 *   ("available.input.pri", NONE),
 *   ("available.output.pri", NONE)
 *
 * Not sure which is correct, but my guess is Irix.
 *
 * Nor can we do
 *   , ("available.input.input", 
 *       available_test (OS.IO.pollIn, id, not, not, descB))
 *
 * Since under Solaris this returns
 *
 *   ("available.input.input", SOME (true, true, true, true, true))
 *
 * whilst under Linux it returns
 *
 *   ("available.input.input", NONE)
 *
 * or
 * ("available.output.output",
 *     available_test (OS.IO.pollOut, not, id, not, descA))
 *
 * Since under Solaris this returns
 *
 *   ("available.output.output", NONE)
 *
 * whilst under Linux it returns
 *
 *   ("available.output.output", SOME (true, true, true, true, true))
 *
 * Again, not sure which is correct, if either
 *)
