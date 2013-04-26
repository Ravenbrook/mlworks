(* Copyright (C) 1999 Harlequin Ltd.  All rights reserved.
 *
 * Windows interface to process termination.
 * This provides a set of MLWorks-specific exit codes, and
 * OS-specific exit/terminate functions.
 * 
 * We don't use OS.Process directly because it can't provide
 * the application-specific status values.
 *
 * Any type/value that shares a name with one in OS.Process behaves 
 * according to the description of that type/value in OS.Process.
 *
 * For more information on the additional error codes see where they are
 * used (mainly main/_batch.sml) since their names and values were initially 
 * based on the context in which they were used and the integer values
 * used in that context.
 * 
 * Revision Log
 * ------------
 *
 * $Log: __mlworks_exit.sml,v $
 * Revision 1.2  1999/05/27 10:48:35  johnh
 * [Bug #190553]
 * Fix require statements to fix bootstrap compiler.
 *
 *  Revision 1.1  1999/05/13  15:26:00  daveb
 *  new unit
 *  New unit.
 *
 *
 *)

require "../utils/mlworks_exit";
require "__windows"
require "__sys_word";

structure MLWorksExit :> MLWORKS_EXIT =
  struct
    type status = Windows.Status.status

    val success = SysWord.fromInt 0
    val failure = SysWord.fromInt 1
    val uncaughtIOException = SysWord.fromInt 2
    val badUsage = SysWord.fromInt 3
    val stop = SysWord.fromInt 4
    val save = SysWord.fromInt 5
    val badInput = SysWord.fromInt 6

    val exit = Windows.exit
  end
