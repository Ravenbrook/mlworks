(*
 *
 * $Log: Top.sig,v $
 * Revision 1.2  1998/06/02 15:35:06  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Top.sig,v 1.2 1998/06/02 15:35:06 jont Exp $";
(************************************ Top ************************************)
(*                                                                           *)
(* Top-Level Concurrency Workbench.                                          *)
(*                                                                           *)
(*****************************************************************************)

signature TOP =
sig
   val toploop : unit -> unit
end

