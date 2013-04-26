(* Copyright (C) 1996 Harlequin Ltd.
 *
 *
 * Revision Log
 * ------------
 *
 * $Log: _stack_frame.sml,v $
 * Revision 1.2  1998/04/20 12:55:56  jont
 * [Bug #70103]
 * Add signature constraint to functor result
 *
 *  Revision 1.1  1996/02/26  16:09:36  stephenb
 *  new unit
 *  A bunch of flags that indicate whether various stack frames should
 *  be displayed by the tty&gui debuggers.
 *
 *)

require "stack_frame";

functor StackFrame () : STACK_FRAME =
  struct

    val hide_c_frames = ref true

    val hide_setup_frames = ref true

    val hide_anonymous_frames = ref true

    val hide_handler_frames = ref true

    val hide_delivered_frames = ref true

    val hide_duplicate_frames = ref true

  end
