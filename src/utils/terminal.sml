(* terminal.sml the signature *)
(*
 * $Log: terminal.sml,v $
 * Revision 1.2  1998/02/19 16:03:23  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 * Copyright (c) 1998 Harlequin Group plc
 *)

signature TERMINAL =
  sig
    val output : string -> unit
  end;
