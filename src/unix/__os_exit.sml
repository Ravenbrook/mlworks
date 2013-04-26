(* Copyright (c) 1999 Harlequin Group plc.  All rights reserved.
 *
 * Platform-specific implementation of the EXIT signature (q.v.).
 * Also see the OS_EXIT signature.
 * Note that we use opaque signature matching here, but can't use it
 * when matching against the EXIT signature, as we need to share types
 * between Unix and OS.Process.

 * This implementation is copied from the original Exit structure.
 *
 * Revision Log
 * ------------
 *
 * $Log: __os_exit.sml,v $
 * Revision 1.3  1999/05/28 10:13:13  johnh
 * [Bug #190553]
 * Fix require statements for bootstrap compiler.
 *
 *  Revision 1.2  1999/05/14  14:39:35  daveb
 *  [Bug #190553]
 *  Fixed typo.
 *
 *  Revision 1.1  1999/05/13  15:29:56  daveb
 *  new unit
 *  New unit.
 *
 *
 *
 *)

require "^.basis.__word32";
require "^.basis.__word8";
require "os_exit";

structure OSExit :> OS_EXIT = 
  struct
    open MLWorks.Internal.Exit;

    datatype exit_status =
      W_EXITED
    | W_EXITSTATUS of Word8.word
    | W_SIGNALED of Word8.word
    | W_STOPPED of Word8.word

    fun word32toWord8 s =
      Word8.fromLargeWord (Word32.toLargeWord s)

    fun word8toWord32 s =
      Word32.fromLargeWord (Word8.toLargeWord s)

    fun hi8 s = word32toWord8 (Word32.>> (s, 0w24))

    fun lo8 s = word32toWord8 (Word32.andb (s, 0w127))

    fun fromStatus s =
      let
        val hi = hi8 s
        val lo = lo8 s
      in
        case (hi, lo) of
          (0w0, 0w0) => W_EXITED
        | (st, 0w0) => W_EXITSTATUS st
        | (0w0, sg) => W_SIGNALED sg
        | (sg, _) => W_STOPPED sg
      end

    fun isSuccess s =
      fromStatus s = W_EXITED

    fun os_exit W_EXITED = exit success
      | os_exit (W_EXITSTATUS st) = exit (word8toWord32 st)
      | os_exit _ = exit failure

    (* Now redefine exit, because an exit status returned from wait
       is not encoded the same way as an argument to exit.
       This stupidity is part of the Unix API. *)
    fun exit s = 
      os_exit (fromStatus s)

    fun atExit action = (ignore(MLWorks.Internal.Exit.atExit action); ())
  end;
