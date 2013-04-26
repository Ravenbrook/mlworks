(*
 * Tests that structure sharing respects type dependencies: i.e., if
 * type s depends on t, it makes sense to share s before t.

Result: OK
 
$Log: share23.sml,v $
Revision 1.1  1997/04/08 15:07:55  andreww
new unit
[Bug #2033]
test.

 *

Copyright (c) 1997 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition,true);

datatype 'a S = RHUBARB of 'a;

signature S1 =
sig
  type t
  type s = t S
end;

signature S2 =
sig
  structure X : S1
end;

signature S3 =
sig
  structure A : S1
  structure B : S2
  sharing A = B.X
end;