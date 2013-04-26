(*
 * A file to ensure all the platform-specific bit of the basis get compiled
 * and to ensure that those items that should be visible at top level are.
 *
 * Copyright (C) 1999 Harlequin Ltd.
 *
 * $Log: platform_specific_exports.sml,v $
 * Revision 1.1  1999/03/03 10:45:22  mitchell
 * new unit
 * Export Windows signature and structure
 *
 *)

require "windows";
require "__windows";

signature WINDOWS = WINDOWS;
structure Windows = Windows;
