(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_reducer_index.sml,v $
 * Revision 1.2  1997/05/28 12:01:46  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  15:20:20  andreww
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

fun f(i, x:real, acc) = (acc+i)*(floor x)

val b = MLWorks.Internal.FloatArray.reducer_index f (a, 0)

val _ = print(if b = 3219686 then "Pass\n" else "Fail\n")
