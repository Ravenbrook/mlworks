(* Copyright (C) 1996 Harlequin Ltd.
 *
 * Implements OS.Process.
 *
 * Revision Log
 * ------------
 *
 * $Log: __os_process.sml,v $
 * Revision 1.2  1996/05/08 13:18:15  stephenb
 * Change main/__exit -> exit now that exit is in the basis directory.
 *
 * Revision 1.1  1996/04/18  15:11:36  jont
 * new unit
 *
 *  Revision 1.1  1996/04/17  15:30:21  stephenb
 *  new unit
 *
 *
 *)

require "__exit";
require "_os_process";

structure OSProcess_ = OSProcess (structure Exit = Exit_);
