(*

Result: OK
 
$Log: vector_vector1.sml,v $
Revision 1.7  1997/11/21 10:52:57  daveb
[Bug #30323]

 * Revision 1.6  1997/05/28  12:17:15  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.5  1996/11/06  12:01:09  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.4  1996/05/22  10:55:01  daveb
 * Renamed Shell.Module to Shell.Build.
 *
 * Revision 1.3  1996/05/08  12:20:33  jont
 * Vectors have moved
 *
 * Revision 1.2  1996/05/01  17:39:35  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1995/09/19  18:10:26  jont
 * new unit
 *

Copyright (c) 1994 Harlequin Ltd.
*)

let
  fun foo(x, 0) = (x, 0)
    | foo(x, n) = foo(MLWorks.Internal.Vector.vector [1,2,3,4,5,6] :: x, n-1)

  val y = foo([], 1000000)
in
  print("Pass " ^ Int.toString(#2 y) ^ "\n")
end
