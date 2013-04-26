(*
Checks that "it" can be bound as an exception constructor
in SML'90 mode.

Result: OK
 
$Log: bad_valids4.sml,v $
Revision 1.1  1996/09/20 16:10:45  andreww
new unit
[1588] Test to show new fixed constructor status of "it".


Copyright (c) 1996 Harlequin Ltd.
*)

Shell.Options.Mode.sml'90();
exception it;


