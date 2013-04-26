(* __ident.sml the structure *)
(*
$Log: __ident.sml,v $
Revision 1.6  1995/07/19 15:57:15  jont
Remove bignum references

Revision 1.5  1995/07/17  16:21:24  jont
Add bignum functor parameter

Revision 1.4  1992/12/17  16:36:09  matthew
> Changed int and real scons to carry a location around

Revision 1.3  1992/08/11  17:43:27  davidt
Removed redundant Lists structure argument.

Revision 1.2  1991/11/21  15:53:18  jont
Added copyright message

Revision 1.1  91/06/07  10:52:04  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "__symbol";
require "__location";
require "_ident";

structure Ident_ = Ident (structure Symbol = Symbol_
                          structure Location = Location_);
