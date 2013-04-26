(* the flags structure *)
(*
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 * See signature for details
 *
 * $Log: __bit_flags.sml,v $
 * Revision 1.4  1999/03/19 12:07:49  daveb
 * [Bug #190523]
 * Change require of flags to bit_flags.
 *
 *  Revision 1.3  1999/03/19  11:59:54  daveb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *  Revision 1.2  1999/03/19  10:48:12  daveb
 *  Automatic checkin:
 *  changed attribute _comment to ''
 *
 *  Revision 1.1  1999/03/11  14:29:12  daveb
 *  new unit
 *  Moved from __flags.sml.
 *
 * Revision 1.1  1998/04/07  14:09:36  jont
 * new unit
 * ** No reason given. **
 *
 *
 *)

require "__sys_word";
require "bit_flags";

structure BitFlags : BIT_FLAGS =
  struct
    type flags = SysWord.word;
    val toWord = fn x => x
    val fromWord = fn x => x
    fun flags(acc, []) = acc
      | flags(acc, x :: xs) = flags(SysWord.orb(acc, x), xs)
    val flags = fn x => flags(0w0, x)
    fun allSet(total_flags, test_flags) =
      let
	val combined = SysWord.orb(total_flags, test_flags)
      in
	combined = total_flags
      end

    fun anySet(total_flags, test_flags) =
      let
	val intersected = SysWord.andb(total_flags, test_flags)
      in
	intersected <> 0w0
      end
  end
