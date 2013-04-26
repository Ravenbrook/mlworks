(*
Check that callee save fp registers are preserved by exceptions
Result: OK
 
$Log: real_exception.sml,v $
Revision 1.1  1996/11/01 13:37:22  jont
new unit
Test for callee save fp register corruption on exception handling


Copyright (c) 1996 Harlequin Ltd.
*)

local
  fun a g = let val x = g(1.0) val y = x+1.0 val w = g(y) in x+y+w end
  fun c g = let val x = g(1.0) val y = x+1.0 val w = g(y) in (x+y+w, raise Overflow) end
  fun b x = #1 (c(fn _ => x)) handle _ => 0.0
in
  val x = a b
end
