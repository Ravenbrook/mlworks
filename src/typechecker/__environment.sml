(* __environment.sml the structure *)
(*
$Log: __environment.sml,v $
Revision 1.14  1996/02/26 11:30:30  jont
Change newhashtable to hashtable

 * Revision 1.13  1995/03/24  15:07:42  matthew
 * Adding structure Stamp
 *
Revision 1.12  1995/02/07  12:05:30  matthew
Stuff

Revision 1.11  1994/09/22  16:01:00  matthew
Added Tystr

Revision 1.10  1993/02/04  15:18:51  matthew
Added hashtable parameter
Used for caching structure operations.

Revision 1.9  1992/08/11  12:53:15  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.8  1992/08/06  13:36:19  jont
Anel's changes to use NewMap instead of Map

Revision 1.6  1992/07/16  16:25:51  jont
Added btree parameter

Revision 1.5  1992/04/15  13:21:30  jont
Changed to require __lists instead of __set

Revision 1.4  1992/01/27  17:44:31  jont
Added ty_debug parameter

Revision 1.3  1991/11/21  16:39:07  jont
Added copyright message

Revision 1.2  91/11/13  13:47:12  richard
Added dependency on the new Strenv module.

Revision 1.1  91/06/07  11:15:09  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__print";
require "../utils/__hashtable";
require "../basics/__identprint";
require "__strnames";
require "__types";
require "__scheme";
require "__valenv";
require "__tyenv";
require "__strenv";
require "__stamp";
require "_environment";

structure Environment_ = Environment(
  structure HashTable = HashTable_
  structure Print      = Print_
  structure Strnames   = Strnames_
  structure IdentPrint = IdentPrint_
  structure Types      = Types_
  structure Scheme     = Scheme_
  structure Valenv     = Valenv_
  structure Tyenv      = Tyenv_
  structure Strenv     = Strenv_
  structure Stamp      = Stamp_
);
