(*
'a is scoped at the outside value declaration, and is therefore non-generic
in the inner value declaration.

Result: FAIL
 
$Log: tyvarscope1.sml,v $
Revision 1.2  1993/01/20 13:07:48  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)


val x = (let val Id1 : 'a -> 'a = fn z => z in Id1 Id1 end,
         fn z => z:'a )
