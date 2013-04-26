(*

Result: OK
 
* Revision Log:
* -------------
* $Log: floatarray_append.sml,v $
* Revision 1.1  1997/01/07 15:10:05  andreww
* new unit
* [Bug #1818]
* floatarray tests
*
*
*
* Copyright (c) 1997 Harlequin Ltd.
*)


(* have to be careful here, since real isn't an equality type in sml'96*)


val a = MLWorks.Internal.FloatArray.arrayoflist
                          (map real [0,1,2,3,4,5,6,7,8,9])

val b = MLWorks.Internal.FloatArray.arrayoflist
                          (map real [0,1,2,3,5])

val c = MLWorks.Internal.FloatArray.append(a, b)

val _ = case (map floor (MLWorks.Internal.FloatArray.to_list c))
          of [0,1,2,3,4,5,6,7,8,9,0,1,2,3,5] 
            => print "Pass\n"
          | _ => print "Fail\n"
