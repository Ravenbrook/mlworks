(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_from_list.sml,v $
 * Revision 1.2  1997/05/28 11:58:44  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  15:15:21  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.
*)

val a = MLWorks.Internal.FloatArray.from_list(map real [1,2,3,4,5,1,2,3,4,5])

val b = MLWorks.Internal.FloatArray.length a

val c = MLWorks.Internal.FloatArray.sub(a, 7)

val _ = print(if b = 10 then "Pass1\n" else "Fail1\n")

val _ = print(if floor c = 3 then "Pass2\n" else "Fail2\n")
