(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_update.sml,v $
 * Revision 1.2  1997/05/28 12:06:30  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  15:05:46  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.
*)

val a = MLWorks.Internal.FloatArray.array(10, 0.0)

val _ = MLWorks.Internal.FloatArray.update(a, 3, 2.0)

val b = MLWorks.Internal.FloatArray.sub(a, 3)

val _ = print(if floor b = 2 then "Pass1\n" else "Fail1\n")

val b = MLWorks.Internal.FloatArray.sub(a, 2)

val _ = print(if floor b = 0 then "Pass2\n" else "Fail2\n")

val b = MLWorks.Internal.FloatArray.sub(a, 4)

val _ = print(if floor b = 0 then "Pass3\n" else "Fail3\n")
