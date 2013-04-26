(* Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 * 
 * The following are taken from /usr/include/sys/fcntlcom.h under SunOS 4.1.X.
 * 
 * Revision Log
 * -----------
 *
 * $Log: __open_flags.sml,v $
 * Revision 1.3  1997/06/30 10:44:24  stephenb
 * [Bug #30029]
 * Correct copyright.
 *
 *  Revision 1.2  1997/05/14  09:50:33  stephenb
 *  [Bug #30121]
 *  Spell "Revision Log" correctly so that the remove_log.sh script
 *  can remove the revision log when a distribution is created.
 *
 *  Revision 1.1  1997/04/29  14:51:39  stephenb
 *  new unit
 *  [Bug #30030]
 *
 *
 *)

structure OpenFlags = 
  struct
    val O_RDONLY = 0
    val O_WRONLY = 1
    val O_RDWR   = 2
    val O_CREAT  = 0x200
  end
