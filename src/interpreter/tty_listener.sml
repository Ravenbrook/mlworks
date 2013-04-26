(*  TTY Listener
 *
 *  Copyright (C) 1992,1993 Harlequin Ltd
 *
 *  Description 
 *  -----------
 *  A tty-based user interface to the incremental compiler.
 *
 *  $Log: tty_listener.sml,v $
 *  Revision 1.2  1993/03/30 10:26:02  matthew
 *  Changed Args type to ListenerArgs
 *
Revision 1.1  1993/03/01  15:18:00  daveb
Initial revision

 *
 *)

signature TTY_LISTENER =
sig
  type ListenerArgs

  val listener: ListenerArgs -> int
  val initial_listener: ListenerArgs -> int
end;
