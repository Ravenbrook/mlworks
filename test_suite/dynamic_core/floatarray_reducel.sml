(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_reducel.sml,v $
 * Revision 1.2  1997/05/28 12:00:54  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  15:18:49  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 *
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.
*)

val a = MLWorks.Internal.FloatArray.arrayoflist(map real [1,2,3,4,5,6,7,8,9])

fun f(acc, x:real) = let val y = floor x in (acc+y)*y end

val b = MLWorks.Internal.FloatArray.reducel f (0, a)

val _ = print(if b = 1972809 then "Pass\n" else "Fail\n")
