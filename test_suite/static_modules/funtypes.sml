(*
Test that types which instantiate to function types after signature matching
can be used in code thereafter.

Result: OK
 
$Log: funtypes.sml,v $
Revision 1.1  1995/03/30 14:05:13  jont
new unit
No reason given


Copyright (c) 1995 Harlequin Ltd.
*)

signature PARSE =
  sig
    type parser
    val $ : parser
  end;

functor ParseFUN () : PARSE =
  struct
    type parser = int -> int
    fun $ _ = raise Bind
  end;

structure HelpParse = ParseFUN()

fun begL _ = HelpParse.$ 0
