(* Copyright (C) 1996 Harlequin Ltd.
 *
 *
 * Revision Log
 * ------------
 *
 * $Log: stack_frame.sml,v $
 * Revision 1.1  1996/02/26 16:08:44  stephenb
 * new unit
 * A bunch of flags that indicate whether various stack frames should
 * be displayed by the tty&gui debuggers.
 *
 *)

signature STACK_FRAME =
  sig
    val hide_c_frames : bool ref
    val hide_setup_frames : bool ref
    val hide_anonymous_frames : bool ref
    val hide_handler_frames : bool ref
    val hide_delivered_frames : bool ref
    val hide_duplicate_frames : bool ref
  end
