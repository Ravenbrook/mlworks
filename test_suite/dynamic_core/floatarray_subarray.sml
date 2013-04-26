(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_subarray.sml,v $
 * Revision 1.2  1997/05/28 12:03:24  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  15:01:57  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.
*)

val a = MLWorks.Internal.FloatArray.arrayoflist(map real [0,1,2,3,4,5,6,7,8,9])

val b = MLWorks.Internal.FloatArray.subarray(a, 3, 5)

val _ = case (map floor (MLWorks.Internal.FloatArray.to_list b))
          of [3,4] => print"Pass1\n"
           | _ => print"Fail1\n"

val c = MLWorks.Internal.FloatArray.subarray(a, 3, 2) 
  handle MLWorks.Internal.FloatArray.Subscript =>
  MLWorks.Internal.FloatArray.from_list(map real [3,2])

val _ = case (map floor (MLWorks.Internal.FloatArray.to_list c))
          of [3,2] => print"Pass2\n"
           | _ => print"Fail2\n"

val d = MLWorks.Internal.FloatArray.subarray(a, 3, 11) 
  handle MLWorks.Internal.FloatArray.Subscript =>
  MLWorks.Internal.FloatArray.from_list(map real [3,11])

val _ = case (map floor (MLWorks.Internal.FloatArray.to_list d))
          of [3,11] => print"Pass3\n"
           | _ => print"Fail3\n"

val e = MLWorks.Internal.FloatArray.subarray(a, ~3, 2) 
  handle MLWorks.Internal.FloatArray.Subscript =>
  MLWorks.Internal.FloatArray.from_list(map real [253,2])

val _ = case (map floor (MLWorks.Internal.FloatArray.to_list e))
          of [253,2] => print"Pass4\n"
           | _ => print"Fail4\n"
