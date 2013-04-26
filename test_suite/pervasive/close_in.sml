(*
Result: OK
 
 * $Log: close_in.sml,v $
 * Revision 1.6  1997/11/21 10:53:03  daveb
 * [Bug #30323]
 *
 * Revision 1.5  1997/07/11  16:10:47  daveb
 * [Bug #30192]
 * Updated for TextIO.closeIn.
 *
 * Revision 1.4  1996/05/31  12:54:29  jont
 * Io has moved into MLWorks.IO
 *
 * Revision 1.3  1996/05/01  17:40:14  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.2  1995/07/28  12:51:00  matthew
 * Changing test slightly
 *
 * Revision 1.1  1994/04/27  13:25:18  jont
 *  new file
 *
 * Copyright (c) 1993 Harlequin Ltd.
 *)

(TextIO.closeIn TextIO.stdIn; "Fail")
 handle IO.Io _ => "Pass"

