signature NUMBER =
  sig

    type 'a T

    val zero		: 'a T
    val one		: 'a T
    val two		: 'a T
    val three		: 'a T

    val successor	: 'a T -> 'a T
    val add		: 'a T -> 'a T -> 'a T
    val multiply	: 'a T -> 'a T -> 'a T

    val reduce		: ('a -> 'a) -> 'a -> 'a T -> 'a

  end
