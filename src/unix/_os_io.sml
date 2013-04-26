(* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Revision Log
 * ------------
 *
 * $Log: _os_io.sml,v $
 * Revision 1.7  1996/11/08 14:30:27  matthew
 * [Bug #1661]
 * Changing io_desc to iodesc
 *
 *  Revision 1.6  1996/10/21  15:23:20  jont
 *  Remove references to basis.toplevel
 *
 *  Revision 1.5  1996/08/21  09:40:29  stephenb
 *  [Bug #1554]
 *  Change from defining iodesc as a file_desc to using the
 *  newly introduced UnixOS.iodesc.
 *
 *  Revision 1.4  1996/07/10  08:36:44  stephenb
 *  Add a comment about the relationship between various datatypes
 *  declared here and the corresponding runtime representation.
 *
 *  Revision 1.3  1996/05/24  09:10:39  stephenb
 *  Update to post March 1996 basis spec., i.e. remove pollErr and
 *  add {poll,is}Pri.
 *
 *  Revision 1.2  1996/05/08  13:56:02  matthew
 *  Changes to Int structure
 *
 *  Revision 1.1  1996/05/03  15:16:59  stephenb
 *  new unit
 *
 *)

require "unixos";
require "__time";
require "^.basis.os_io";
require "^.basis.__word";

(* If you modify any of the (data)type declarations in the following,
 * make sure that you also update either rts/src/OS/Unix/unix.c,
 * rts/src/OS/Unix/os_io_poll.c and/or rts/src/OS/Linux/os_io_poll.c
 *)

functor OSIO (structure UnixOS: UNIXOS) : OS_IO =
  struct
    val env = MLWorks.Internal.Runtime.environment

    type iodesc = UnixOS.iodesc

    fun hash (UnixOS.IODESC fd) = Word.fromInt fd

    fun compare (UnixOS.IODESC a, UnixOS.IODESC b) = 
      if a < b then
        LESS
      else if a > b then
        GREATER
      else
        EQUAL


    datatype iodesc_kind = IODESC_KIND of int

    structure Kind = struct
      val file = IODESC_KIND 1
      val dir = IODESC_KIND 2
      val symlink = IODESC_KIND 3
      val tty = IODESC_KIND 4
      val pipe = IODESC_KIND 5
      val socket = IODESC_KIND 6
      val device = IODESC_KIND 7
    end

    val kind : iodesc -> iodesc_kind = env "OS.IO.kind"
    (* raises: OS.SysErr *)


    datatype event_set = EVENT_SET of int
    datatype poll_desc = POLL_DESC of iodesc * event_set
    datatype poll_info = POLL_INFO of poll_desc * event_set

    val pollDesc : iodesc -> poll_desc option = env "OS.IO.pollDesc"

    fun pollToIODesc (POLL_DESC (fd, _)) = fd

    exception Poll

    val pollIn : poll_desc -> poll_desc = env "OS.IO.pollIn"
    val pollOut : poll_desc -> poll_desc = env "OS.IO.pollOut"
    val pollPri : poll_desc -> poll_desc = env "OS.IO.pollPri"
    (* all raise: Poll *)


    val poll : (poll_desc list * Time.time option) -> poll_info list = env "OS.IO.poll"
    (* raises: OS.SysErr *)


    val isIn : poll_info -> bool = env "OS.IO.isIn"
    val isOut : poll_info -> bool = env "OS.IO.isOut"
    val isPri : poll_info -> bool = env "OS.IO.isPri"

    fun infoToPollDesc (POLL_INFO (pollDesc, _)) = pollDesc
  end
