(* __stamp.sml the structure *)
(*
$Log: __stamp.sml,v $
Revision 1.1  1995/04/06 12:51:27  matthew
new unit
Replacement for tyfun_id's etc

*)

require "../utils/_counter";
require "../utils/__intbtree";

require "_stamp";

structure Stamp_ = Stamp (structure Counter = Counter ()
                          structure Map = IntBTree_);
