(* This is a demonstration of a structure.  It defines the church numbers. *)

require "number";

structure Church : NUMBER =
  struct

    type 'a T = ('a -> 'a) -> 'a -> 'a

    fun zero f a = a
    fun one f a = f a
    fun two f a = f (f a)
    fun three f a = f (f (f a))

    fun successor n =
      fn f => fn a => f (n f a)

    fun add m n =
      fn f => fn a => m f (n f a)

    fun multiply m n =
      fn f => fn a => m (n f) a

    fun reduce f a n =  n f a

  end
