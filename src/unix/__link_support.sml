(* LinkSupport the structure *)
(*
 * Functions to support linking of .o files to make .sos or .dlls
 *
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: __link_support.sml,v $
 * Revision 1.2  1998/10/21 13:47:22  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

require "../utils/__crash";
require "_unix_link_support";

structure LinkSupport_ =
  UnixLinkSupport(
    structure Crash = Crash_);
