(*
 * $Log: __proj_file.sml,v $
 * Revision 1.6  1998/06/08 12:20:08  mitchell
 * [Bug #30418]
 * Convert to use sectioned files
 *
 *  Revision 1.5  1998/04/20  15:27:26  johnh
 *  [Bug #50073]
 *  Add Getenv and other structures.
 *
 *  Revision 1.4  1998/03/02  12:21:00  johnh
 *  [Bug #30365]
 *  Implement support for subprojects.
 *
 *  Revision 1.3  1998/02/23  14:40:03  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *  Revision 1.1.1.5  1997/12/23  12:27:43  daveb
 *  [Bug #30071]
 *  Added Diagnostic parameter.
 *
 *  Revision 1.1.1.4  1997/11/28  16:55:39  daveb
 *  [Bug #30071]
 *  Removed List argument.
 *
 *  Revision 1.1.1.3  1997/10/31  15:58:32  daveb
 *  [Bug #30071]
 *  Added Info parameter.
 *
 *  Revision 1.1.1.2  1997/09/12  14:39:07  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
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


require "^.basis.__text_io";
require "^.system.__getenv";
require "^.utils.__terminal";

require "^.system.__os";
require "../main/__info";
require "../utils/_diagnostic";
require "../utils/__text";
require "../utils/__lists";

require "__sectioned_file";
require "_proj_file";

structure ProjFile_ =
  ProjFile (
    structure OS = OS
    structure TextIO = TextIO
    structure SectionedFile = SectionedFile
    structure Getenv = Getenv_
    structure Terminal = Terminal

    structure Info = Info_
    structure Lists = Lists_
    structure Diagnostic =
      Diagnostic (structure Text = Text_)
  )
