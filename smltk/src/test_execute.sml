require "basic_util";
require "__text_io";

val (ins, outs) = BasicUtil.FileUtil.execute ("/u/johnh/temp/pipe", []);

(*
val test = TextIO.output (outs, "hello\n");
val test2 = TextIO.input ins;
*)