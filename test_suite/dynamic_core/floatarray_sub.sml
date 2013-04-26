(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_sub.sml,v $
 * Revision 1.2  1997/05/28 12:02:22  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  14:49:56  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.
*)

val a = MLWorks.Internal.FloatArray.array(10, 5.0)

val b = MLWorks.Internal.FloatArray.sub(a, 3)

val _ = print(if floor b = 5 then "Pass\n" else "Fail\n")
