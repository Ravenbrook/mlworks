(* License server implementation.
 *
 * Copyright (c) Harlequin Ltd. 1996.
 *
 * $Log: license.sml,v $
 * Revision 1.3  1998/07/14 09:37:52  jkbrook
 * [Bug #30435]
 * Remove user-prompting code
 *
 *  Revision 1.2  1997/07/18  13:28:49  johnh
 *  [Bug #20074]
 *  Improve licensing.
 *
 *  Revision 1.1  1996/11/11  19:59:18  daveb
 *  new unit
 *  Interface to the licensing code in the runtime.
 *
 *
 *)

signature LICENSE =
sig
  val license: (string -> bool option) -> bool option
  (* license checks whether the user has a current license.  If using
     the license server, it sets up an hourly expiry check.  If the 
     license fails, it uses the complain parameter to report this fact. *)

  val ttyComplain: string -> bool option
  (* ttyComplain prints the rejection message to standard output and exits. *)

end
