(*  ==== INITIAL BASIS : Option structure ====
 *
 *  Copyright (C) 1997 Harlequin Group Limited.  All rights reserved.
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

