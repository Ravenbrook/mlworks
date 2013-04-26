(*  ==== INITIAL BASIS : Option structure ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: __option.sml,v $
 *  Revision 1.2  1997/07/21 09:33:46  brucem
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 *)

require "option";

structure Option : OPTION =
  struct

    datatype option = datatype option (* Top level type *)

    exception Option = Option (* Top level exception *)

    (*
      (* The simple functions should be equivalent to: *)
      fun isSome (SOME _) = true | isSome _ = false

      fun valOf (SOME x) = x | valOf NONE = raise Option

      fun getOpt (NONE, d) = d
        | getOpt ((SOME x), _) = x
      (* They are not defined here as they are available from the top level. *)
     *)

    val isSome = isSome
    and valOf = valOf
    and getOpt = getOpt


    fun filter pred x = if (pred x) then (SOME x) else NONE

    fun map f NONE     = NONE
      | map f (SOME x) = SOME (f x)

    fun join NONE     = NONE
      | join (SOME x) = x

    fun mapPartial f = join o map f

    fun compose (f, g) x =
          (case (g x)
           of NONE => NONE
           | (SOME x) => SOME(f x) )
    fun composePartial (f, g) x =
          (case (g x) of
             NONE => NONE
          | (SOME x) => f x )

    (* Alternative definitions:
      fun compose  (f, g) = map f o g
      fun composePartial (f, g) = mapPartial f o g
    *)

  end

