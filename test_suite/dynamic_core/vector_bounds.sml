(*

Result: OK
 
$Log: vector_bounds.sml,v $
Revision 1.2  1996/05/08 11:31:13  jont
Vectors have moved

 * Revision 1.1  1995/09/01  14:51:43  jont
 * new unit
 *

Copyright (c) 1995 Harlequin Ltd.
*)

local
  val a = MLWorks.Internal.Vector.tabulate(10, fn _ => 0)
in
  val c = (MLWorks.Internal.Vector.sub(a, 9)) handle MLWorks.Internal.Vector.Subscript => 1
  val d = (MLWorks.Internal.Vector.sub(a, 0)) handle MLWorks.Internal.Vector.Subscript => 1
  val e = (MLWorks.Internal.Vector.sub(a, ~1)) handle MLWorks.Internal.Vector.Subscript => 1
  val f = (MLWorks.Internal.Vector.sub(a, 10)) handle MLWorks.Internal.Vector.Subscript => 1
end

