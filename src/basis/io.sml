(*  ==== INITIAL BASIS : IO ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: io.sml,v $
 *  Revision 1.3  1996/07/17 15:18:19  andreww
 *  [Bug #1453]
 *  Bringing up to date wrt May 30 basis definition.
 *
 * Revision 1.2  1996/05/20  13:08:15  jont
 * signature changes
 *
 *
 *)

signature IO =
  sig

    exception Io of {name : string, function : string, cause : exn}

    exception BlockingNotSupported

    exception NonblockingNotSupported

    exception RandomAccessNotSupported

    exception TerminatedStream

    exception ClosedStream

    datatype buffer_mode = NO_BUF | LINE_BUF | BLOCK_BUF

  end
