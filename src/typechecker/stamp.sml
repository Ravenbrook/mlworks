(* simpletypes.sml the signature *)
(*
$Log: stamp.sml,v $
Revision 1.2  1996/02/26 12:47:57  jont
mononewmap becomes monomap

 * Revision 1.1  1995/04/06  12:52:30  matthew
 * new unit
 * Replacement for tyfun_id's etc
 *

Copyright (c) 1995 Harlequin Ltd.
*)

require "../utils/monomap";

signature STAMP  =
  sig 
    structure Map : MONOMAP
    eqtype Stamp
    sharing type Stamp = Map.object
    val make_stamp_n : int -> Stamp
    val make_stamp : unit -> Stamp
    val stamp : Stamp -> int
    val string_stamp : Stamp -> string
    val stamp_lt : (Stamp * Stamp) -> bool
    val stamp_eq : Stamp * Stamp -> bool
    val reset_counter : int -> unit
    val read_counter : unit -> int
    val push_counter : unit -> unit
    val pop_counter : unit -> unit
  end;
