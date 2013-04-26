(*
Compilation of topdecs must handle cases where two functors are 
not separated by a semicolon.

Result: OK
 
$Log: topdec.sml,v $
Revision 1.1  1993/07/12 11:39:25  daveb
Initial revision



Copyright (c) 1993 Harlequin Ltd.
*)


functor F (): sig end = struct end

functor G (): sig end = F ()
