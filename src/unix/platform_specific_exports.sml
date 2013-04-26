(*
 * A file to ensure all the platform-specific bit of the basis get compiled
 * and to ensure that those items that should be visible at top level are.
 *
 * Copyright (C) 1999 Harlequin Ltd.
 *
 * $Log: platform_specific_exports.sml,v $
 * Revision 1.1  1999/03/04 13:57:18  mitchell
 * new unit
 * Export Unix signature/structure
 *
 *)

require "unix";
require "__unix";

signature UNIX = UNIX;
structure Unix = Unix;
