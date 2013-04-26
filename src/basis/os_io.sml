(* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Note that this does not match the March 1996 basis spec. for OS.IO.
 * This is because the spec. wasn't workable and so Reppy suggested
 * the following changes :-
 *
 *   pollErr is removed (it is a nop for poll/socket based implementations).
 *   isErr is removed, any error in poll now raises OS.SysErr.
 *   pollPri and isPri are introduced.
 *
 * Also in a separate post March 1996 basis change, kind now returns 
 * a result of iodesc_kind rather than a string. 
 *
 * Revision Log
 * ------------
 *
 * $Log: os_io.sml,v $
 * Revision 1.4  1996/11/08 14:20:15  matthew
 * [Bug #1661]
 * Changing io_desc to iodesc
 *
 *  Revision 1.3  1996/10/03  15:23:17  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.2  1996/05/23  14:14:33  stephenb
 *  Update to post March 1996 basis spec., i.e. remove pollErr and
 *  add {poll,is}Pri.
 *
 *  Revision 1.1  1996/05/07  14:06:51  stephenb
 *  new unit
 *
 *)

require "../system/__time";

signature OS_IO =
  sig

    eqtype iodesc

    val hash : iodesc -> word

    val compare : (iodesc * iodesc) -> order

    eqtype iodesc_kind

    structure Kind : sig
      val file : iodesc_kind
      val dir : iodesc_kind
      val symlink : iodesc_kind
      val tty : iodesc_kind
      val pipe : iodesc_kind
      val socket : iodesc_kind
      val device : iodesc_kind
    end

    val kind : iodesc -> iodesc_kind

    type poll_desc

    type poll_info

    val pollDesc : iodesc -> poll_desc option

    val pollToIODesc : poll_desc -> iodesc

    exception Poll

    val pollIn : poll_desc -> poll_desc
    val pollOut : poll_desc -> poll_desc
    val pollPri : poll_desc -> poll_desc

    val poll : (poll_desc list * Time.time option) -> poll_info list

    val isIn : poll_info -> bool
    val isOut : poll_info -> bool
    val isPri : poll_info -> bool

    val infoToPollDesc : poll_info -> poll_desc

  end
