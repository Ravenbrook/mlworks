(* Copyright (c) 1996 Harlequin Ltd.

Result: OK

 *
 * Test OS.Process.terminate.  Specifically, ensure that none of the
 * functions registered by atExit are run.
 * 
 * Revision Log
 * ------------
 *
 * $Log: os_process_terminate.sml,v $
 * Revision 1.6  1997/11/21 10:46:16  daveb
 * [Bug #30323]
 *
 *  Revision 1.5  1997/05/28  11:07:49  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.4  1997/04/01  16:45:41  jont
 *  Modify to stop displaying syserror type
 *
 *  Revision 1.3  1996/05/22  10:19:26  daveb
 *  Shell.Module renamed to Shell.Build.
 *
 *  Revision 1.2  1996/05/01  16:12:09  jont
 *  Fixing up after changes to toplevel visible string and io stuff
 *
 *  Revision 1.1  1996/04/18  10:10:11  stephenb
 *  new unit
 *  Test for OS.Process.terminate
 *
 *)

fun oops () = print"Oops\n";

OS.Process.atExit oops;

val _ = OS.Process.terminate OS.Process.success;
