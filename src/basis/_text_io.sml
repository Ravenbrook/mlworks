(*  ==== INITIAL BASIS : TextIO functor ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: _text_io.sml,v $
 *  Revision 1.15  1999/02/02 15:58:40  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.14  1998/02/19  14:37:44  jont
 *  [Bug #30341]
 *  Fix where type ... and syntax
 *
 *  Revision 1.13  1997/11/25  17:49:12  daveb
 *  [Bug #30329]
 *  Removed bogus Process argument from ImperativeIO functor.
 *
 *  Revision 1.12  1997/10/07  16:05:37  johnh
 *  [Bug #30226]
 *  Closing streams on exit.
 *
 *  Revision 1.11  1997/02/26  15:26:53  andreww
 *  [Bug #1759]
 *  new TEXT_STREAM_IO sig.
 *
 *  Revision 1.10  1996/11/16  01:57:51  io
 *  [Bug #1757]
 *  renamed __ieeereal to __ieee_real
 *
 *  Revision 1.9  1996/11/08  14:19:23  matthew
 *  [Bug #1661]
 *  Changing io_desc to iodesc
 *
 *  Revision 1.8  1996/10/07  10:37:30  andreww
 *  [Bug #1631]
 *  Altering inputLine to insert a newline after the last line of a file if it
 *  does not already contain one.
 *
 *  Revision 1.7  1996/10/03  15:25:27  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.6  1996/08/21  11:43:46  stephenb
 *  [Bug #1554]
 *  As part of the iodesc change MLWorks.Internal.SysErr has changed
 *  to MLWorks.Internal.Error.SysErr
 *
 *  Revision 1.5  1996/07/31  16:22:46  andreww
 *  [Bug #1523]
 *  Wrapping openIn, openOut and openApp with handlers to translate
 *  SysErr exceptions to Io exceptions.
 *
 *  Revision 1.3  1996/07/15  13:41:10  andreww
 *  modifying the standard io redirection stuff.
 *  Removing guiIO and terminalIO.
 *
 *  Revision 1.2  1996/07/02  15:48:08  andreww
 *  Altering treatment of standard IO streams, to allow redirection
 *  when converting from a GUI running program to a terminal standalone image.
 *
 *  Revision 1.1  1996/06/03  14:08:42  andreww
 *  new unit
 *  Revised basis functor.
 *
 *
 *)

require "__char_array";
require "__char_vector";
require "__char";
require "__position";
require "__io";
require "_imperative_io";
require "os_prim_io";
require "text_io";
require "__text_stream_io";
require "prim_io";
require "__substring";
require "^.system.__os";

functor TextIO(include sig
                structure TextPrimIO: PRIM_IO
                structure OSPrimIO: OS_PRIM_IO
                sharing type OSPrimIO.text_reader = TextPrimIO.reader
                sharing type OSPrimIO.text_writer = TextPrimIO.writer
              end where type OSPrimIO.text_reader = TextStreamIO.reader
	       where type OSPrimIO.text_writer = TextStreamIO.writer
	       where type TextPrimIO.elem = Char.char
	       where type TextPrimIO.array = CharArray.array
	       where type TextPrimIO.vector = CharVector.vector): TEXT_IO =

  struct
     structure TextIO' =
       ImperativeIO(structure StreamIO = TextStreamIO
                    structure Vector = CharVector
                    structure Array = CharArray)
       
     val translateIn = OSPrimIO.translateIn
     val translateOut = OSPrimIO.translateOut

     val openIn =
       fn x => TextIO'.mkInstream
       (TextIO'.StreamIO.mkInstream
        (translateIn(OSPrimIO.openRd x), ""))
       handle MLWorks.Internal.Error.SysErr e =>
         raise IO.Io{name=x,function="openIn",cause=OS.SysErr e}

     val openOut =
       fn x => TextIO'.mkOutstream
       (TextIO'.StreamIO.mkOutstream
        (translateOut(OSPrimIO.openWr x), IO.NO_BUF))
       handle MLWorks.Internal.Error.SysErr e =>
         raise IO.Io{name=x,function="openOut",cause=OS.SysErr e}

     val openAppend =
       fn x => TextIO'.mkOutstream
       (TextIO'.StreamIO.mkOutstream
        (translateOut(OSPrimIO.openApp x), IO.NO_BUF))
       handle MLWorks.Internal.Error.SysErr e =>
         raise IO.Io{name=x,function="openAppend",cause=OS.SysErr e}
       

     fun openString s = 
         TextIO'.mkInstream
           (TextIO'.StreamIO.mkInstream
             (OSPrimIO.openString s,""))

     
     fun inputLine (f: TextIO'.instream) =
       let
         val g0 = TextIO'.getInstream f
         val (s,gn) = TextStreamIO.inputLine g0
         val _ = TextIO'.setInstream(f,gn)
       in
         s
       end
         

     fun outputSubstr(f:TextIO'.outstream, ss:Substring.substring) =
       TextIO'.output(f,Substring.string ss)


     val stdIn = 
       TextIO'.mkInstream(TextIO'.StreamIO.mkInstream
                          (translateIn OSPrimIO.stdIn,""))
     val stdOut =
       TextIO'.mkOutstream(TextIO'.StreamIO.mkOutstream
                           (translateOut OSPrimIO.stdOut, IO.NO_BUF))

     val stdErr =
       TextIO'.mkOutstream(TextIO'.StreamIO.mkOutstream
                           (translateOut OSPrimIO.stdErr, IO.NO_BUF))
       

     fun print s = (TextIO'.output(stdOut, s); TextIO'.flushOut stdOut)

     fun scanStream scanFn stream =
       let
         val instream=TextIO'.getInstream stream
       in
         case (scanFn TextIO'.StreamIO.input1 instream)
           of NONE => NONE
            | (SOME (v,instream')) => 
                (TextIO'.setInstream (stream,instream');
                 SOME v)
       end
                                     

     open TextIO'
     structure StreamIO = TextStreamIO
     structure Position = Position


  end






