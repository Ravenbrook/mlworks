(* the flags structure *)
(*
 * Copyright (c) 1998 Harlequin Group plc
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
