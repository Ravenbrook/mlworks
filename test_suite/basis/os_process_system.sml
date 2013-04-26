(* Copyright (c) 1996 Harlequin Ltd.

Result: OK

 *
 * Test OS.Process.system.
 * Currently only tests that system is supported since this is the only
 * test I can think of that is portable across all OSes.
 * 
 * Revision Log
 * ------------
 *
 * $Log: os_process_system.sml,v $
 * Revision 1.5  1999/04/23 09:24:24  daveb
 * [Bug #190553]
 * OS.Process.status is no longer an equality type.
 *
 *  Revision 1.4  1997/11/21  10:46:09  daveb
 *  [Bug #30323]
 *
 *  Revision 1.3  1997/04/01  16:45:01  jont
 *  Modify to stop displaying syserror type
 *
 *  Revision 1.2  1996/05/22  10:19:23  daveb
 *  Shell.Module renamed to Shell.Build.
 *
 *  Revision 1.1  1996/04/11  14:28:05  stephenb
 *  new unit
 *  Test for OS.Process.system
 *
 *)

OS.Process.isSuccess (OS.Process.system "");
