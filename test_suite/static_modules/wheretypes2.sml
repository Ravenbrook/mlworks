(*
Check that the derived form of where type, where the types can be combined
using "and", works, whilst still allowing sigbinds to be combined using and
as well.  The grammar is a bit nasty in this area, so it's tricky to
allow both.  Better check we can, hence the test ...

Result: OK
 
$Log: wheretypes2.sml,v $
Revision 1.2  1998/02/18 10:39:13  mitchell
Automatic checkin:
changed attribute _comment to ' *  '


Copyright (c) 1998 Harlequin Group plc
*)

signature S1 = sig type s; type t; val x: s; val y: t end;

signature S2 = S1 where type s = int and type t = bool and S3 = S1;

