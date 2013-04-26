(* _stamp.sml the functor *)
(*
$Log: _stamp.sml,v $
Revision 1.3  1996/11/06 11:33:30  matthew
[Bug #1728]
__integer becomes __int

 * Revision 1.2  1996/04/29  13:25:21  matthew
 * Integer changes
 *
 * Revision 1.1  1995/04/06  12:51:55  matthew
 * new unit
 * Replacement for tyfun_id's etc
 *
*)

require "../basis/__int";
require "../utils/counter";
require "../utils/intnewmap";

require "stamp";

functor Stamp (structure Counter : COUNTER
		   structure Map : INTNEWMAP
		     ) : STAMP =
  struct
    structure Map = Map
    type Stamp = int
    fun make_stamp () = Counter.counter ()
    fun make_stamp_n n = n
    fun stamp n = n
    fun string_stamp n = Int.toString n
    val stamp_eq = op= : int * int -> bool
    val stamp_lt = op< : int * int -> bool
    val read_counter = Counter.read_counter
    val reset_counter = Counter.reset_counter
    exception stack_empty of string
    val counter_stack = ref [] : int list ref
    fun push_counter() = counter_stack := read_counter() :: !counter_stack
    fun pop_counter() =
      case !counter_stack of
	[] => raise stack_empty "stamp stack"
      | x :: xs =>
	  (counter_stack := xs;
	   reset_counter x)
  end;
