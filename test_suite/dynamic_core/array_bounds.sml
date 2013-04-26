(*

Result: OK
 
 * $Log: array_bounds.sml,v $
 * Revision 1.3  1996/05/08 12:05:57  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1995/09/11  16:42:02  jont
 * poo
 *
 * Revision 1.1  1995/08/30  16:17:20  jont
 * new unit
 *
 *Copyright (c) 1995 Harlequin Ltd.
 *)


local
  val a = MLWorks.Internal.ExtendedArray.array(10, 0)
in
  val x = (MLWorks.Internal.Array.update(a, 9, 0);
	   0) handle MLWorks.Internal.Array.Subscript => 1
  val y = (MLWorks.Internal.Array.update(a, 0, 0);
	   0) handle MLWorks.Internal.Array.Subscript => 1
  val z = (MLWorks.Internal.Array.update(a, ~1, 0);
	   0) handle MLWorks.Internal.Array.Subscript => 1
  val b = (MLWorks.Internal.Array.update(a, 10, 0);
	   0) handle MLWorks.Internal.Array.Subscript => 1
  val c = (MLWorks.Internal.Array.sub(a, 9)) handle MLWorks.Internal.Array.Subscript => 1
  val d = (MLWorks.Internal.Array.sub(a, 0)) handle MLWorks.Internal.Array.Subscript => 1
  val e = (MLWorks.Internal.Array.sub(a, ~1)) handle MLWorks.Internal.Array.Subscript => 1
  val f = (MLWorks.Internal.Array.sub(a, 10)) handle MLWorks.Internal.Array.Subscript => 1
end

