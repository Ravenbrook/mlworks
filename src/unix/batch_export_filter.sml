(* Platform specific exports from the batch compiler to the rest of the system
 *
 * $Log: batch_export_filter.sml,v $
 * Revision 1.2  1999/02/09 15:24:55  mitchell
 * [Bug #190505]
 * Add missing require statements
 *
 *  Revision 1.1  1999/02/09  11:55:30  mitchell
 *  new unit
 *  [Bug #190505]
 *  "Support for precompilation of subprojects"
 *
 * 
 * Copyright (c) 1999 Harlequin Ltd.
 *)

require "unixos.sml";
require "__unixos.sml";

signature UNIXOS = UNIXOS;
structure UnixOS_ = UnixOS_;