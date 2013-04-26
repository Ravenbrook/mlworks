(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_reducel_index.sml,v $
 * Revision 1.2  1997/05/28 12:01:12  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  15:19:24  andreww
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

fun f(i, acc, x:real) = (acc+(floor x))*i

val b = MLWorks.Internal.FloatArray.reducel_index f (0, a)

val _ = print(if b = 328792 then "Pass\n" else "Fail\n")
