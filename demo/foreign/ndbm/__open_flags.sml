(* Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * The following are the values that most Unix variants use.
 *
 * Revision Log
 * ------------
 * $Log: __open_flags.sml,v $
 * Revision 1.2  1997/06/30 10:43:12  stephenb
 * [Bug #30029]
 * Correct copyright.
 *
 *  Revision 1.1  1997/04/29  14:51:22  stephenb
 *  new unit
 *  [Bug #30030]
 *
 *)

structure OpenFlags = 
  struct
    val O_RDONLY = 0
    val O_WRONLY = 1
    val O_RDWR   = 2
    val O_CREAT  = 0x100
  end
