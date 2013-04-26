(*
  Tests to see that imperative type vars are only written with an underscore
  in SML'90 mode.

Result: OK
 
$Log: print_tyvars.sml,v $
Revision 1.1  1996/08/07 15:34:01  andreww
new unit
Test file to show that imperative type vars are only printed with
underscores in SML'90 mode.  This is related to the changes made
in regard to bug 1521.
(See the change message rather than the bug fix message.)

 *

Copyright (c) 1996 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition,true);
fn x=> ! (ref x);
Shell.Options.set(Shell.Options.Language.oldDefinition,false);
fn x=> ! (ref x);

