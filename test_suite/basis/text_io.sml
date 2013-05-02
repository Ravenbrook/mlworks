(* This tests that the TextIO functor catches system errors as IO errors
 *

Result: OK

 * $Log: text_io.sml,v $
 * Revision 1.7  1998/02/18 11:56:01  mitchell
 * [Bug #30349]
 * Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.6  1997/11/21  10:49:38  daveb
 *  [Bug #30323]
 *
 *  Revision 1.5  1997/05/28  11:21:33  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.4  1997/04/01  16:47:11  jont
 *  Modify to stop displaying syserror type
 *
 *  Revision 1.3  1997/03/13  13:52:19  jont
 *  Modify to cope with NT style of error for no such file
 *
 *  Revision 1.2  1996/11/16  02:06:59  io
 *  [Bug #1757]
 *  renamed __ieeereal to __ieee_real
 *          __char{array,vector} to __char_{array,vector}
 *
 *  Revision 1.1  1996/07/31  16:47:10  andreww
 *  new unit
 *  [Bug 1523]
 *  test file to prove that TextIO.openIn raises IO.Io rather than SysErr
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
  open General
  open TextIO
in


  fun reportOK true = print"test succeeded.\n"
    | reportOK false = print"test failed.\n"


  val _ = closeOut (openOut "123");       (* ensure that file 123 exists *)
  val _ = OS.FileSys.remove "123" handle _ => () (*remove it*)

           (*At this point, the file is guaranteed not to exist *)

  val _ = reportOK ((ignore(TextIO.openIn  "123");false)
                    handle IO.Io{cause = 
                                 OS.SysErr(_ , SOME 2) (* Unix ENOENT *)
                                 ,...} => true
                         | IO.Io{cause =
                                 OS.SysErr(_ , SOME 4) (* Win32 version *)
                                 ,...} => true)

  (*tests to see if openOut and openAppend errors are correctly parcelled
    will have to wait until I can find a way to set permissions on files
    that can set them to be read only *)


end
