(* messages.sml the signature *)
(*
 * $Log: messages.sml,v $
 * Revision 1.2  1998/02/19 13:56:49  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 * Copyright (c) 1998 Harlequin Group plc
 *)

signature MESSAGES =
  sig
    val output : string -> unit
    val flush : unit -> unit
  end;
