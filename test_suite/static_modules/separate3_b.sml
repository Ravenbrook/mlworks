(*
Not a real test, part of a larger one
Result: FAIL
 
$Log: separate3_b.sml,v $
Revision 1.2  1999/03/18 10:57:46  mitchell
[Bug #190535]
Add in dummy module dependencies to match require statements

 * Revision 1.1  1993/08/20  13:13:26  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)
require "separate3_a";
local open LrParser in end;
signature Foo = sig end;
