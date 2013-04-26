require "number";

structure Integer : NUMBER =
  struct

    type 'a T = int

    val zero = 0
    val one = 1
    val two = 2
    val three = 3

    fun successor n = n+1
    fun add n m = n+m : int
    fun multiply m n = n*m : int

    fun reduce f a 0 = a
      | reduce f a n = reduce f (f a) (n-1)

  end
