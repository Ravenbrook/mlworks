(*
Result: OK
 
 * $Log: close_out.sml,v $
 * Revision 1.6  1997/11/21 10:53:08  daveb
 * [Bug #30323]
 *
 * Revision 1.5  1997/07/11  16:13:17  daveb
 * [Bug #30192]
 * Updated for TextIO.closeOut.
 *
 * Revision 1.4  1996/05/31  12:54:42  jont
 * Io has moved into MLWorks.IO
 *
 * Revision 1.3  1996/05/01  17:24:11  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.2  1995/07/28  12:51:50  matthew
 * Changing test slightly
 *
 * Revision 1.1  1994/04/27  13:25:54  jont
 * new file
 *
 * Copyright (c) 1993 Harlequin Ltd.
 *)

(TextIO.closeOut TextIO.stdErr; "Fail")
handle IO.Io _ =>
  (TextIO.closeOut TextIO.stdOut; "Fail")
  handle IO.Io _ => "Pass"
