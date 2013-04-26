(* Copyright (c) 1999 Harlequin Group plc.  All rights reserved.
 *
 * Platform-specific implementation of the EXIT signature (q.v.).
 * Also see the OS_EXIT signature.
 * Note that we use opaque signature matching here, but can't use it
 * when matching against the EXIT signature, as we need to share types
 * between Windows and OS.Process.
 *
 * This implementation is copied from the original Exit structure.
 *
 * Revision Log
 * ------------
 *
 * $Log: __os_exit.sml,v $
 * Revision 1.2  1999/05/28 13:32:36  johnh
 * [Bug #190553]
 * Fix require statements for bootstrap compiler.
 *
 *  Revision 1.1  1999/05/13  15:28:10  daveb
 *  new unit
 *
 *  New unit.
 *
 *
 *
 *)

require "^.basis.__sys_word";
require "os_exit";

structure OSExit :> OS_EXIT = 
  struct
    open MLWorks.Internal.Exit;

    type exit_status = SysWord.word

    val os_exit = exit

    fun fromStatus s = s

    fun isSuccess s = (s = SysWord.fromInt 0)
    (* Word literals don't seem to be overloaded on SysWord.word. *)

    fun atExit action = (ignore(MLWorks.Internal.Exit.atExit action); ())
  end;
