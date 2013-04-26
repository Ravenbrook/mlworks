(*
Not a real test, part of a larger one
Result: OK
 
$Log: separate2_a.sml,v $
Revision 1.2  1999/03/18 10:58:00  mitchell
[Bug #190535]
Add in dummy module dependencies to match require statements

 * Revision 1.1  1993/08/20  13:09:11  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)
structure S2A = struct end;
datatype node = Uconst of int
