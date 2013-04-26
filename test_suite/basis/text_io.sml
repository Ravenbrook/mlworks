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
 * Copyright (c) 1996 Harlequin Ltd.
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
