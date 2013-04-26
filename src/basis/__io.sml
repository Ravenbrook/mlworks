(*  ==== INITIAL BASIS : IO structure ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __io.sml,v $
 *  Revision 1.3  1997/03/17 14:19:15  andreww
 *  [Bug #1431]
 *  moving Io exception into the pervasive library
 *  (so it can be handled properly by exnMessage).
 *
 *  Revision 1.2  1996/07/17  15:18:50  andreww
 *  [Bug #1453]
 *  Bringing up to date wrt May 30 basis definition.
 *
 *  Revision 1.1  1996/05/20  16:56:50  jont
 *  new unit
 *
 *
 *)

require "io";

structure IO : IO =
  struct

    exception Io = MLWorks.Internal.IO.Io

    exception BlockingNotSupported

    exception NonblockingNotSupported

    exception RandomAccessNotSupported

    exception TerminatedStream

    exception ClosedStream

    datatype buffer_mode = NO_BUF | LINE_BUF | BLOCK_BUF

  end
