(* Copyright (C) 1999 Harlequin Group plc.   All rights reserved.
 *
 * OS-specific version of the EXIT interface (q.v.)
 *
 * This provides the exit_status datatype and fromStatus function to
 * the Unix structure, sharing the types with OS.Process.
 * 
 * Revision Log
 * ------------
 *
 * $Log: os_exit.sml,v $
 * Revision 1.2  1999/05/28 10:44:23  johnh
 * [Bug #190553]
 * Fix require statement for bootstrap compiler.
 *
 *  Revision 1.1  1999/05/13  15:27:18  daveb
 *  new unit
 *  New unit.
 *
 *
 *)

require "^.basis.__word8";

signature OS_EXIT =
  sig
    type status

    datatype exit_status =
      W_EXITED
    | W_EXITSTATUS of Word8.word
    | W_SIGNALED of Word8.word
    | W_STOPPED of Word8.word

    val success : status

    val failure : status

    val isSuccess : status -> bool

    val atExit : (unit -> unit) -> unit

    val exit : status -> 'a

    val terminate : status -> 'a

    val os_exit : exit_status -> 'a

    val fromStatus : status -> exit_status

  end
