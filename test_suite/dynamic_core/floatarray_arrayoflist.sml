(*

Result: OK
 
* Revision Log:
* -------------
* $Log: floatarray_arrayoflist.sml,v $
* Revision 1.1  1997/01/07 15:12:02  andreww
* new unit
* [Bug #1818]
* floatarray tests
*
*
*
* Copyright (c) 1997 Harlequin Ltd.
*)

val a = MLWorks.Internal.FloatArray.arrayoflist
  [1.1,2.2,3.3,4.4,5.5,1.1,2.2,3.3,4.4,5.5]

val b = MLWorks.Internal.FloatArray.length a

val c = MLWorks.Internal.FloatArray.sub(a, 7)

val _ = print(if b = 10 then "Pass1\n" else "Fail1\n")

val _ = print(if floor c = 3 then "Pass2\n" else "Fail2\n")
