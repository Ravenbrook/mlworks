(* The flags signature *)
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
