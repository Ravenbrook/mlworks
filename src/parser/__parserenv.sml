(* __parserenv.sml the structure *)
(*
$Log: __parserenv.sml,v $
Revision 1.3  1992/08/18 18:15:37  davidt
Removed the Map_ and Symbol_, added BTree_ and Lists_.

Revision 1.2  1991/11/21  16:36:02  jont
Added copyright message

Revision 1.1  91/06/07  16:17:08  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "_parserenv";
require "../utils/__lists";
require "../utils/__btree";
require "../basics/__ident";

structure ParserEnv_ =
  ParserEnv (structure Map   = BTree_
	     structure Lists = Lists_
	     structure Ident = Ident_);
