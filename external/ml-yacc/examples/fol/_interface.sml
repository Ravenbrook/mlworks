require "$.basis.__text_io";
require "$.basis.__int";

(* Externally visible aspects of the lexer and parser *)

signature INTERFACE =
sig

type pos
val line : pos ref
val init_line : unit -> unit
val next_line : unit -> unit
val error : string * pos * pos -> unit

type arg
val nothing : arg

end  (* signature INTERFACE *)

functor Interface () : INTERFACE =
struct

type pos = int
val line = ref 0
fun init_line () = (line := 1)
fun next_line () = (line := !line + 1)
fun error (errmsg,line:pos,_) =
  TextIO.print("Line " ^ (Int.toString line) ^ ": " ^ errmsg ^ "\n")

type arg = unit

val nothing = ()

end  (* functor INTERFACE *)
