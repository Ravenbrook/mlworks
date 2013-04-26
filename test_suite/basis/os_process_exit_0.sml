(* Copyright (c) 1996 Harlequin Ltd.

Result: OK

 *
 * Test OS.Process.exit.  Specifically, ensure that a sequence of
 * actions are executed in the correct (i.e. reverse) order.
 * 
 * Revision Log
 * ------------
 *
 * $Log: os_process_exit_0.sml,v $
 * Revision 1.6  1997/11/21 10:45:49  daveb
 * [Bug #30323]
 *
 *  Revision 1.5  1997/05/28  11:07:07  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.4  1997/04/01  16:44:13  jont
 *  Modify to stop displaying syserror type
 *
 *  Revision 1.3  1996/05/22  10:19:17  daveb
 *  Shell.Module renamed to Shell.Build.
 *
 *  Revision 1.2  1996/05/01  16:11:28  jont
 *  Fixing up after changes to toplevel visible string and io stuff
 *
 *  Revision 1.1  1996/04/18  10:36:35  stephenb
 *  new unit
 *  Test for OS.Process.exit
 *
 *)

fun out s = print(s ^ "\n");

fun finish () = out "finished.";
fun k () = out "k.";
fun j () = out "j.";
fun i () = out "i.";
fun h () = out "h.";
fun g () = out "g.";
fun f () = out "f.";
fun e () = out "e.";
fun d () = out "d.";
fun c () = out "c.";
fun b () = out "b.";
fun a () = out "a.";
fun start () = out "starting ...";


OS.Process.atExit finish;
OS.Process.atExit k;
OS.Process.atExit j;
OS.Process.atExit i;
OS.Process.atExit h;
OS.Process.atExit g;
OS.Process.atExit f;
OS.Process.atExit e;
OS.Process.atExit d;
OS.Process.atExit c;
OS.Process.atExit b;
OS.Process.atExit a;
OS.Process.atExit start;


val _ = OS.Process.exit OS.Process.success;
