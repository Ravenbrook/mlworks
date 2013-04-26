(* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Revision Log
 * ------------
 *
 * $Log: _os_io.sml,v $
 * Revision 1.7  1996/11/08 14:25:12  matthew
 * [Bug #1661]
 * Changing io_desc to iodesc
 *
 *  Revision 1.6  1996/10/21  15:25:02  jont
 *  Remove references to toplevel
 *
 *  Revision 1.5  1996/08/19  15:39:45  stephenb
 *  [Bug #1554]
 *  Don't define iodesc in terms of Win32.file_desc since whilst
 *  they are both ints, some conversion is necessary to go from
 *  one to the other -- Win32.fdToIOD
 *
 *  Revision 1.4  1996/06/14  08:54:12  stephenb
 *  Define iodesc in terms of Win32.file_desc.  This allows Win32.file_desc's
 *  (which don't hide their representation) to be used for testing purposes.
 *
 *  Revision 1.3  1996/05/24  09:10:48  stephenb
 *  Update to post March 1996 basis spec., i.e. remove pollErr and
 *  add {poll,is}Pri.
 *
 *  Revision 1.2  1996/05/13  15:19:51  matthew
 *  basis changes
 *
 *  Revision 1.1  1996/05/01  15:40:12  stephenb
 *  new unit
 *
 *)

require "__time";
require "win32";
require "^.basis.__word";
require "^.basis.os_io";


(* If you modify any of the (data)type declarations in the following,
 * make sure that you also update rts/src/OS/Win32/win32.c.
 *)

functor OSIO (structure Win32: WIN32) : OS_IO =
  struct
    val env = MLWorks.Internal.Runtime.environment

    type iodesc = Win32.iodesc

    fun hash (Win32.IODESC fd) = Word.fromInt fd

    fun compare (Win32.IODESC a, Win32.IODESC b) = 
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

    datatype event_set = EVENT_SET of int
    datatype poll_desc = POLL_DESC of iodesc * event_set
    datatype poll_info = POLL_INFO of poll_desc * event_set


    val pollDesc : iodesc -> poll_desc option = env "OS.IO.pollDesc"

    fun pollToIODesc (POLL_DESC (fd, _)) = fd

    exception Poll

    val pollIn : poll_desc -> poll_desc = env "OS.IO.pollIn"

    val pollOut : poll_desc -> poll_desc = env "OS.IO.pollOut"

    val pollPri : poll_desc -> poll_desc = env "OS.IO.pollPri"

    val poll : (poll_desc list * Time.time option) -> poll_info list = env "OS.IO.poll"

    val isIn : poll_info -> bool = env "OS.IO.isIn"

    val isOut : poll_info -> bool = env "OS.IO.isOut"

    val isPri : poll_info -> bool = env "OS.IO.isPri"

    fun infoToPollDesc (POLL_INFO (pollDesc, _)) = pollDesc
  end
