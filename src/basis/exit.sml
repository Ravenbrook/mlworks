(* Copyright (C) 1996 Harlequin Ltd.
 *
 * Interface to process termination.
 * It provides a status type which is the type of value that is returned
 * by the process when it terminates and some functions for terminating
 * the process and registering functions to be executed upon termination.
 *
 * This is effectively the subset of OS.Process concerned with termination
 * augmented with additional error codes that MLWorks returns in certain
 * circumstances.
 *
 * Any type/value that shares a name with one in OS.Process behaves 
 * according to the description of that type/value in OS.Process.
 *
 * For more information on the additional error codes see where they are
 * used (mainly main/_batch.sml) since their names and values were initially 
 * based on the context in which they were used and the integer values
 * used in that context.
 * 
 * Revision Log
 * ------------
 *
 * $Log: exit.sml,v $
 * Revision 1.3  1999/05/12 17:44:12  daveb
 * Removed the equality attribute from the status type; added isSuccess.
 *
 *  Revision 1.2  1999/03/11  17:17:40  daveb
 *  [Bug #190523]
 *  Added fromStatus.
 *
 *  Revision 1.1  1996/05/08  13:20:42  stephenb
 *  new unit
 *  Moved from main so that the files can be distributed as part
 *  of the basis.
 *
 *  Revision 1.1  1996/04/17  15:27:08  stephenb
 *  new unit
 *  Provide an OS independent way of terminating MLWorks.
 *
 *
 *)

signature EXIT =
  sig
    type status

    val success : status

    val failure : status

    val isSuccess : status -> bool

    val atExit : (unit -> unit) -> unit

    val exit : status -> 'a

    val terminate : status -> 'a
  end
