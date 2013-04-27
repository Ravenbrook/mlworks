(* Test of I/O facilities in Old structure (emmulation of SML'90 basis)
 * 
 * Result: OK
 * 
 * $Log: old_io.sml,v $
 * Revision 1.5  1998/02/18 11:56:01  mitchell
 * [Bug #30349]
 * Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.4  1997/11/21  10:45:00  daveb
 *  [Bug #30323]
 *
 *  Revision 1.3  1997/09/24  09:24:11  brucem
 *  [Bug #30153]
 *  Old has changed to SML90.
 *
 *  Revision 1.2  1997/07/18  14:17:30  brucem
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
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
 *)

local
open SML90; (* So it looks like the SML'90 Basis *)
in

  val _ = TextIO.closeOut (TextIO.openOut "old_io.txt");
    (* ensure that file exists *)
  val _ = OS.FileSys.remove "old_io.txt" handle _ => () (*remove it*)
  (*At this point, the file is guaranteed not to exist *)



val test1 = output (std_out, "test1\n");

val os = open_out "old_io.txt";

val test2 = output(os, "test2\n");

val test3 = close_out os;

val is = open_in "old_io.txt";

val test4 = input (is, 10);

val test5 = close_in is;

val test6 = (output (os, "test4\n"); "wrong")
             handle Io "Output stream is closed" => "right"
                  | _ => "wrong";

val test7 = (ignore(open_in "/this does not exist"); "wrong")
            handle Io "Cannot open /this does not exist" => "right"
                 | _ => "wrong"

val test8 = (ignore(open_out "/"); "wrong")
            handle Io "Cannot open /" => "right"
                 | _ => "wrong"

  val _ = OS.FileSys.remove "old_io.txt" handle _ => () (*remove it*)
end
