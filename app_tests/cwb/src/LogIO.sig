(*
 *
 * $Log: LogIO.sig,v $
 * Revision 1.2  1998/06/02 15:27:31  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: LogIO.sig,v 1.2 1998/06/02 15:27:31 jont Exp $";
(*********************************** LogIO ***********************************)
(*                                                                           *)
(* This file contains signatures and functors that implement the I/O logic   *)
(* used by the system.                                                       *)
(*                                                                           *)
(*****************************************************************************)

signature LOGIO =
sig
   structure L : LOGIC

   exception Parse of string

   val mkprop     : string -> L.prop
   val mkstrparam : L.param -> string
   val mkstr      : L.prop -> string
end

