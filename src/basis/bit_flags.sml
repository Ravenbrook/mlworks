(* The flags signature *)
(*
 * Copyright (c) 1998 Harlequin Group plc
 * All rights reserved
 *
 * $Log: bit_flags.sml,v $
 * Revision 1.3  1999/03/19 12:06:05  daveb
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 * Revision 1.1  1998/04/07  14:11:14  jont
 * new unit
 * ** No reason given. **
 *
 *
 *)

(* Move the POSIX_FLAGS signature to BIT_FLAGS, because we need it here too. *)

require "__sys_word";

signature BIT_FLAGS =
  sig

    eqtype  flags

    val toWord : flags -> SysWord.word
    val fromWord : SysWord.word -> flags

    val flags : flags list -> flags

    val allSet : (flags * flags) -> bool
    (* True if all flags in parameter 2 occur in parameter 1 *)

    val anySet : (flags * flags) -> bool
    (* True if any flags in parameter 2 occur in parameter 1 *)
  end
