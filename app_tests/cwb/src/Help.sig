(*
 *
 * $Log: Help.sig,v $
 * Revision 1.2  1998/06/02 15:27:07  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Help.sig,v 1.2 1998/06/02 15:27:07 jont Exp $";
(*********************************** Help ************************************)
(*                                                                           *)
(*  This prints out help messages.                                           *)
(*                                                                           *)
(*****************************************************************************)

signature HELP =
sig
   val help : string -> unit
end

