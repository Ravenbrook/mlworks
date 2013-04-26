(* LinkSupport the structure *)
(*
 * Functions to support linking of .o files to make .sos or .dlls
 *
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: __link_support.sml,v $
 * Revision 1.3  1998/10/23 15:39:02  jont
 * [Bug #70198]
 * Add some functor parameters
 *
 * Revision 1.2  1998/10/21  13:47:23  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

require "../utils/__crash";
require "../main/__encapsulate";
require "_win_nt_link_support";

structure LinkSupport_ =
  WinNtLinkSupport(
    structure Encapsulate = Encapsulate_
    structure Crash = Crash_);
