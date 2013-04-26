(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_length.sml,v $
 * Revision 1.2  1997/05/28 11:59:54  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  14:41:02  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.
*)

val a = MLWorks.Internal.FloatArray.array(10, 0.0)
val b = MLWorks.Internal.FloatArray.length a
val _ = print(if b = 10 then "Pass\n" else "Fail\n")
