(* This tests that the TextIO.openString function correctly reads the
 * specified string.
 *

Result: OK

 * $Log: text_io_2.sml,v $
 * Revision 1.5  1997/11/21 10:49:46  daveb
 * [Bug #30323]
 *
 *  Revision 1.4  1997/05/28  11:22:29  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.3  1997/04/01  16:47:38  jont
 *  Modify to stop displaying syserror type
 *
 *  Revision 1.2  1996/11/16  02:06:23  io
 *  [Bug #1757]
 *  renamed __ieeereal to __ieee_real
 *          __char{array,vector} to __char_{array,vector}
 *
 *  Revision 1.1  1996/08/05  16:23:21  andreww
 *  new unit
 *  Test for TextIO.openString.
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


  val x = openString "Blah"

  val _ = reportOK (SOME #"B" = (input1 x))
  val _ = reportOK (SOME #"l" = (input1 x))
  val _ = reportOK (SOME #"a" = (input1 x))
  val _ = reportOK (SOME #"h" = (input1 x))
  val _ = reportOK (NONE = (input1 x))




end



