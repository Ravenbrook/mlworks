(*
$Log: __ndfa.sml,v $
Revision 1.3  1992/10/29 16:17:21  jont
Used IntBTree instead of btree for efficiency

Revision 1.2  1992/05/06  10:42:59  richard
Changed BalancedTree to BTree

Revision 1.1  1991/10/10  12:22:28  davidt
Initial revision


Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__crash";
require "../utils/__intbtree";
require "_ndfa";

structure Ndfa_ = Ndfa(
  structure Crash = Crash_
  structure Map = IntBTree_
)
