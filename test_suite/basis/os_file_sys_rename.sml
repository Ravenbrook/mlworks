(* Copyright (c) 1996 Harlequin Ltd.

Result: OK

 *
 * Test OS.FileSys.rename.  All tests should return true.
 * 
 * Revision Log
 * ------------
 *
 * $Log: os_file_sys_rename.sml,v $
 * Revision 1.4  1997/11/21 10:45:33  daveb
 * [Bug #30323]
 *
 *  Revision 1.3  1997/04/01  16:43:15  jont
 *  Modify to stop displaying syserror type
 *
 *  Revision 1.2  1996/05/22  10:19:14  daveb
 *  Shell.Module renamed to Shell.Build.
 *
 *  Revision 1.1  1996/05/17  07:50:40  stephenb
 *  new unit
 *
 *
 *)


(* Test if an exception is raised when attempting to rename a non-existent
 * file
 *)

val a = (OS.FileSys.rename {old = "no such file", new = "also does not exist"}; false) handle OS.SysErr _ => true;


(* Should test that rename actually works, but to to that need to create a
 * file first which cannot be done portably until the IO library is sorted out.
 *)
