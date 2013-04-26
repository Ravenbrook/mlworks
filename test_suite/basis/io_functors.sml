(* Test that the IO functors are loaded.
 *
 * Result:  OK
 *
 * Copyright (C) 1997 The Harlequin Group plc.  All rights reserved.
 *
 * Revision Log
 * ____________
 * $Log: io_functors.sml,v $
 * Revision 1.2  1997/11/25 18:56:04  daveb
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)

structure P =
  PrimIO (
    structure V = CharVector
    structure A = CharArray
    val someElem = #"p"
    type pos = Position.int
    val compare = Position.compare
  );

structure S =
  StreamIO (
    structure PrimIO = P
    structure Vector = CharVector
    structure Array = CharArray
    val someElem = #"p"
  );

structure I = 
  ImperativeIO (
    structure StreamIO = S
    structure Vector = CharVector
    structure Array = CharArray
  );

