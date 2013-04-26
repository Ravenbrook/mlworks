(*
Checks that "it" can be bound as a datatype constructor
in SML'90 mode.

Result: OK
 
$Log: bad_valids3.sml,v $
Revision 1.1  1996/09/20 16:10:26  andreww
new unit
[1588] Test to show new fixed constructor status of "it".


Copyright (c) 1996 Harlequin Ltd.
*)

Shell.Options.Mode.sml'90();
datatype bagpuss = it;


