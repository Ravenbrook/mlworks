(* Copyright (C) 1996 Harlequin Ltd.
 *
 *
 * Revision Log
 * ------------
 *
 * $Log: __stack_frame.sml,v $
 * Revision 1.1  1996/02/26 16:10:30  stephenb
 * new unit
 * A bunch of flags that indicate whether various stack frames should
 * be displayed by the tty&gui debuggers.
 *
 *)

require "_stack_frame";

structure StackFrame_ = StackFrame ()
