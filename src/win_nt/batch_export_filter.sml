(* Platform specific exports from the batch compiler to the rest of the system
 *
 * $Log: batch_export_filter.sml,v $
 * Revision 1.1  1999/02/09 11:55:16  mitchell
 * new unit
 * [Bug #190505]
 * "Support for precompilation of subprojects"
 *
 * 
 * Copyright (c) 1999 Harlequin Ltd.
 *)

require "win32.sml";
require "__win32.sml";

signature WIN32 = WIN32;
structure Win32_ = Win32_;
