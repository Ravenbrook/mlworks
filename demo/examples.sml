fun bar [] = raise Div | bar (a::b) = 1 + bar b;
fun boz (a : int list) = 1 + bar a

fun test () = boz [1,2,3,4,5];

fun fib 0 = 1 | fib 1 = 1 | fib n = fib(n-1) + fib(n-2);

(*
val _ =  Shell.trace_full (<<fib>>,<<fn x => true>>,<<fn x => x = 0>>);
*)
