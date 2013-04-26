(* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
