(*

Result: OK
 
* Revision Log:
* -------------
* $Log: floatarray_array.sml,v $
* Revision 1.1  1997/01/07 14:11:11  andreww
* new unit
* [Bug #1818]
* floatarray tests
*
*
* Copyright (c) 1997 Harlequin Ltd.
*)

val a = MLWorks.Internal.FloatArray.array(10, 0.0)
val b = MLWorks.Internal.FloatArray.array(10, 0.0)

val _ = print (if a = b then "Fail\n" else "Pass\n")
