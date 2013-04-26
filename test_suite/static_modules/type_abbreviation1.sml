(*

Result: OK
 
$Log: type_abbreviation1.sml,v $
Revision 1.1  1996/10/22 14:57:03  andreww
new unit
[Bug #1320]
tests that type abbreviations are printed nicely.
/


Copyright (c) 1996 Harlequin Ltd.
*)

signature S =
sig
  type t = int * int
end;

