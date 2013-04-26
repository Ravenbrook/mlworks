(* Copyright (C) 1999 Harlequin Group plc.   All rights reserved.
 *
 * OS-specific version of the EXIT interface (q.v.)
 *
 * This provides the exit_status datatype and fromStatus function to
 * the Windows structure, sharing the types with OS.Process.
 * 
 * Revision Log
 * ------------
 *
 * $Log: os_exit.sml,v $
 * Revision 1.2  1999/05/28 13:32:49  johnh
 * [Bug #190553]
 * Fix require statements for bootstrap compiler.
 *
 *  Revision 1.1  1999/05/13  15:27:51  daveb
 *  new unit
 *  New unit.
 *
 *
 *)

require "^.basis.__sys_word";

signature OS_EXIT =
  sig
    type status

    type exit_status = SysWord.word

    val success : status

    val failure : status

    val isSuccess : status -> bool

    val atExit : (unit -> unit) -> unit

    val exit : status -> 'a

    val os_exit : exit_status -> 'a

    val terminate : status -> 'a

    val fromStatus : status -> exit_status
  end
