(*
Not a real test, part of a larger one
Result: FAIL
 
$Log: separate2_b.sml,v $
Revision 1.2  1999/03/18 10:58:09  mitchell
[Bug #190535]
Add in dummy module dependencies to match require statements

 * Revision 1.1  1993/08/20  13:09:37  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)
require "separate2_a";
local open S2A in structure S2B = struct end end;
datatype cnstr = Type of node


