(*
Not a real test, part of a larger one
Result: FAIL
 
$Log: separate2_c.sml,v $
Revision 1.2  1999/03/18 10:58:18  mitchell
[Bug #190535]
Add in dummy module dependencies to match require statements

 * Revision 1.1  1993/08/20  13:10:08  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)
require "separate2_b";
require "separate2_a";
local open S2A; open S2B in end;
datatype prCnstr = PrType  of node
fun ffpef (Type(i))        = PrType(i)
