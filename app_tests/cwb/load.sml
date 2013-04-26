(*
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: load.sml,v $
 * Revision 1.2  1998/06/02 15:13:15  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
use "../nj-compat/nj-compat";
Shell.Options.set (Shell.Options.Language.requireReservedWord,true);

val _ = use "build.ml";

