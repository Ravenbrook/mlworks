signature SIMPLELIB =
sig
  val map : ('a -> 'b) -> 'a list -> 'b list

  type 'a array2
  val array2 : ((int * int) * (int * int)) * '_a -> '_a array2
  val sub2 : 'a array2 * (int * int) -> 'a
  val update2 : 'a array2 * (int * int) * 'a -> unit

  type 'a array1 
  val array1 : ((int * int) * '_a) -> '_a array1
  val sub1 : ('a array1 * int) -> 'a
  val update1 : ('a array1 * int * 'a) -> unit
  val bounds1 : ('a array1) -> (int * int)
	      
  val abs : real -> real
  val max_list : real list -> real
  val min_list : real list -> real
  val sum_list : real list -> real
  val for : {from : int, step : int, to : int} -> (int -> unit) -> unit
  val from : int * int -> int list
  val flatten : 'a list list -> 'a list
  val pow : real * int -> real
  val min : real * real -> real
  val max : real * real -> real
  exception Overflow

  val grid_max : int
  val iterations : int
end
