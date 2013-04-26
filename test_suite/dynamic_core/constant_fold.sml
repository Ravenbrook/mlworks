(*

Result: OK
 
$Log: constant_fold.sml,v $
Revision 1.3  1997/05/28 11:53:33  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.2  1996/05/01  17:10:49  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/11/25  13:41:32  matthew
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

(* Test that side-effecting expressions aren't removed by the optimizer in this context *)

exception Test;

val result =
(((raise Test) - (raise Test)) handle Test => 10) = 10
andalso
(((raise Test) * 0) handle Test => 10) = 10
andalso
((0 * (raise Test)) handle Test => 10) = 10
andalso
(((raise Test) div (raise Test)) handle Test => 10) = 10
andalso
(((raise Test) mod 1) handle Test => 10) = 10
andalso
((0 mod (raise Test)) handle Test => 10) = 10
andalso
(((raise Test) mod 0) handle Test => 10 | Mod => 0) = 10
andalso
not (((raise Test) =  (raise Test)) handle Test => false)
andalso
(((raise Test) <>  (raise Test)) handle Test => true)

val _ = if result then print"Pass\n" else print"Fail\n"
