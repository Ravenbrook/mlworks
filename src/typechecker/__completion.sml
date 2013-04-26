(* __completion.sml the structure *)
(*
$Log: __completion.sml,v $
Revision 1.8  1996/02/26 11:32:28  jont
Change newhashtable to hashtable

 * Revision 1.7  1995/03/24  14:59:36  matthew
 * Adding structure Stamp
 *
Revision 1.6  1993/03/31  13:39:54  jont
Added NameHash and NewHashTable parameters to functor application

Revision 1.5  1993/02/22  10:56:50  matthew
Removed Env structure

Revision 1.4  1993/01/27  14:25:00  matthew
Rationalised structures

Revision 1.3  1992/11/24  17:03:40  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.2  1991/11/21  16:38:07  jont
Added copyright message

Revision 1.1  91/06/07  11:11:04  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../basics/__identprint";
require "../utils/__lists";
require "../utils/__hashtable";
require "__namehash";
require "__types";
require "__stamp";
require "_completion";

structure Completion_ = Completion(
  structure Types      = Types_
  structure IdentPrint = IdentPrint_
  structure HashTable = HashTable_
  structure NameHash = NameHash_
  structure Stamp = Stamp_
  structure Lists      = Lists_);
