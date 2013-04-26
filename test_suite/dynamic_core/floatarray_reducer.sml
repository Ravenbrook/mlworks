(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_reducer.sml,v $
 * Revision 1.2  1997/05/28 12:01:29  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  15:19:58  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.
*)

val a = MLWorks.Internal.FloatArray.arrayoflist(map real [1,2,3,4,5,6,7,8,9])

fun f(x:real, acc) = let val y = floor x in (acc+y)*y end

val b = MLWorks.Internal.FloatArray.reducer f (a, 0)

val _ = print(if b = 3628799 then "Pass\n" else "Fail\n")
