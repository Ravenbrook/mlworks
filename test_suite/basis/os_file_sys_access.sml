(* Copyright (c) 1996 Harlequin Ltd.

Result: OK

 *
 * Test OS.FileSys.access.  All tests should return true.
 * 
 * Revision Log
 * ------------
 *
 * $Log: os_file_sys_access.sml,v $
 * Revision 1.4  1997/11/21 10:45:14  daveb
 * [Bug #30323]
 *
 *  Revision 1.3  1997/04/01  16:58:20  jont
 *  Modify to avoid displaying syserror type
 *
 *  Revision 1.2  1996/05/22  10:19:05  daveb
 *  Shell.Module renamed to Shell.Build.
 *
 *  Revision 1.1  1996/05/17  07:52:32  stephenb
 *  new unit
 *
 *
 *)

(* This will only work if run in the test_suite directory or src directory
 * since it tries to locate a file called basis.
 *)

val a = OS.FileSys.access ("basis", [OS.FileSys.A_READ, OS.FileSys.A_WRITE, OS.FileSys.A_EXEC]);

val b = OS.FileSys.access ("basis", []);

val c = OS.FileSys.access ("no such file", [OS.FileSys.A_READ, OS.FileSys.A_WRITE, OS.FileSys.A_EXEC]) = false;

val d = OS.FileSys.access ("no such file", []) = false;

(* What about this case?
val e = OS.FileSys.access ("", []) = false;
*)
