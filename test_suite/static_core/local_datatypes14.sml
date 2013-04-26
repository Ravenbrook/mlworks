(*
Checks that sharing types aren't screwed up in signatures.

Result: OK

$Log: local_datatypes14.sml,v $
Revision 1.1  1996/10/04 18:37:58  andreww
new unit
new test


Copyright (c) 1996 Harlequin Ltd.
*)

signature S =
sig
  type banana
  structure X: sig type banana end
  sharing type X.banana = banana
end;



